Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RwBQ/lJH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtw2-0007Lg-BA; Fri, 30 Oct 2026 17:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtw0-0007L0-41
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvy-0007pv-RM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKpGAVHTcd/TkCqkkiHIn8xFkhpFu72u/KatOzaZGWU=;
 b=RwBQ/lJHW7UiLf7MRszD9UQjX6aWbbmPxp23+iZZvudGPy0RTRl0tJ3jLLPHaMMYuXC8CA
 MFNH0WLHT2C5agJWO78z8NH92FiOSYpovddIZSTLjlQYNUqdP2ytP3/7FcNRs+XOU7YTtY
 EaV9ipUZmEElq5/SdlgLX8+0FAETaxA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-MEJ4fDSFPP6EYSjSDCfsGg-1; Fri,
 30 Oct 2026 17:14:42 -0400
X-MC-Unique: MEJ4fDSFPP6EYSjSDCfsGg-1
X-Mimecast-MFC-AGG-ID: MEJ4fDSFPP6EYSjSDCfsGg_1793394882
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC5C19560BE; Fri, 30 Oct 2026 21:14:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10E977C6; Fri, 30 Oct 2026 21:14:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:11 +0400
Subject: [GIT PULL 08/10] glib-compat: fix g_autofd fallback warnings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-8-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u0FqaHRQAfUFfUr27QolA60NOGjKFwqHGijvhvvRTpg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigtWJUEGGY9pB5HsaZQ39d6/ypO7IheGDHD
 1t9cs+UBJiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5TPREACBgj6Ba0cKDS0jck5TK2NlrIQOx8wetgcMQRaSHxUhQw38pkIcERcxB2ZN1NA0afDLsNa
 8DMNqK4FRVydnIWBHj7DPRbfCZfGTWMEP8aZgNM1m+E8CS9gJJy5ngKNv2YwudLzkk4MNbWY5IN
 9/W71nbp5Qq34olH1KTRxdfB04cJcMgS829Mo9y2vuQA9UiPQI0bLe2QBqO7Knwf8lvKk372eYR
 G8fJmuOxtyO/fTaIgZQeNcw1tGkKU3KnUClrRc6E2u91iuNH4vAiS+xjULyyGwAVkeGHxCeyl00
 ovP4Ov8tQeoW2YnVUdLqMp6hm6gCOZ1IZ5R8LpPU/y0hNJzBslI4IjI8SThprTMe4Zjfxhfeqse
 8KhaTHm+VoZdw8o9UlQZ6r+/DRhLKJVw5NQk8q0D/JITN1UCIkuvZSATP1ga0SVeJLPzrhu/cAF
 rK4fiOBK3+pQOEZme6fTSfO9ggv+QYz4PlFVJ/tK8Dj00ojbOkrU0N3W+49B+GPHThSpH4HRaIS
 L/IwOUZjXwg+Pou5GbPunjbNZZCo/CLqi3YxfUpUthEMwX1+7R4rPkRNohDDNr3/u+dX6q5gIwU
 5CuqgCuCZbKBJjYMWA8X89S2heDkpcDH9G6GZIiYDIdIPxngSO6d4ICdauAn+JSgNWAajheniP+
 31NjnaJcn/4+BFw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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


