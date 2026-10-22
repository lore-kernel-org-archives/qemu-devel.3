Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A10606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHQ5fyHi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrIW-0007Wv-MM; Thu, 22 Oct 2026 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHD-0006ly-5W
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHB-0007IA-Lb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7UAMGndHkBAfWYQV2L+hjiZYl2wV/DuHcskbi9k/eA=;
 b=bHQ5fyHiGhVCfzK1iDsKuuluv+ZoMDNA7jebJni9EZypA7thJY/dzDDKiU02sAj8oJxZqj
 GVwagAv9WFdPBTfWD838z1+ImmA4FkUl26juFsT9vzDpU7kE15wcC1oFnCID+3KK0oqj91
 Ki6mS/6MlK/qPOxJwm3d7ZTNbs5WCwU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-TGH_1WcaPdaeMdggEdoyIA-1; Thu,
 22 Oct 2026 07:48:01 -0400
X-MC-Unique: TGH_1WcaPdaeMdggEdoyIA-1
X-Mimecast-MFC-AGG-ID: TGH_1WcaPdaeMdggEdoyIA_1792669679
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1EC18011D7; Thu, 22 Oct 2026 11:47:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E2541956089; Thu, 22 Oct 2026 11:47:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:21 +0400
Subject: [PATCH v3 08/10] glib-compat: fix g_autofd fallback warnings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-8-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NK+pnxc7BwpVlq2y77Nbo1afqzbRfgLVGEkssM4T99c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffNtWSdxwlshpFRGcxwuyQ2vTCJNsmoyqhCn
 C0df2cbB2OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5d+gD/0WY9ksEOF8rWTVkj+o8om2zXTgjZiEmasZCNFWP7Ui5ZXh54yqSDt13w8iNsaN4qQIlHK
 CsKPXgOatmGQeuHFd9X207ktVpHFNIz38OeQlD9GEI/A/uk57SLLHM80jz2XRsyLyPioqqZHvZY
 GffxzsPoCVpMH+7Su+Rm7VmyWiOX6Y/Jrb6wc0zbp7DuXHh4zDuKsMDIIm9HFPqWZJFthxF+DwB
 VDJNMbunm4ssolGYKbYa+FFH2PnEZkFQ4NyDRDbGct8z0NJFWlo5IqMMToN0HgFFnTyOebUPpNu
 uV42sYGWkYURz3fNPQ6PwIWuR2eEA/W13m30/caCUgsfTq4Yo04VBA1IC6meE+DSBCPjcTUN8Nd
 z8Q61PPuIJpnmbe4QMGwL2CuUd6rDZkDwZ7YcVgbwA1drPEuV1GhkxfSkn0dqccKx72lmZMzhH8
 iBNklzri5WjVLs1V05RxVVHurONm/9qjexYBb3D8gk/08Xn4z7Tzg+2qXltEKHBUFroylQOSw58
 Kw7fLSvhGT+qbpPA/7AkG9QRcLH44TDqcfehvR5JpmcqHgxMnQadRScw933b9cIj7rdQwEOOei/
 nuAIhn2unv95LWHqYQ1NNETrxHnwJZFqhZ8BknoqCu3P/kwSFLPXDV6d8sVmuSpP77MpBGYOhhg
 bJLEsOqhZfDEzLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The g_autofd fallback is warning because it uses symbols from >=2.66

Fixes: 1599015a7a1a ("glib-compat: add fallback for g_clear_fd/g_autofd")
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/glib-compat.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 32ee2afdcdf5..dd6f062f5a43 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -148,15 +148,15 @@ static inline gboolean g_clear_fd_qemu(int *fd_ptr, GError **error)
 }
 #define g_clear_fd(fd, err) g_clear_fd_qemu(fd, err)
 
-#if !GLIB_CHECK_VERSION(2, 76, 0)
-static inline void _g_clear_fd_ignore_error(int *fd_ptr)
+static inline void _g_clear_fd_qemu_ignore_error(int *fd_ptr)
 {
     int errsv = errno;
     g_clear_fd(fd_ptr, NULL);
     errno = errsv;
 }
-#define g_autofd __attribute__((cleanup(_g_clear_fd_ignore_error)))
-#endif
+
+#undef g_autofd
+#define g_autofd __attribute__((cleanup(_g_clear_fd_qemu_ignore_error)))
 
 #pragma GCC diagnostic pop
 

-- 
2.56.0.116.g6de20f6092dc


