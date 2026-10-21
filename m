Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112D606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfQ0HvwH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR71-0004bX-Bv; Wed, 21 Oct 2026 03:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6z-0004Z9-6T
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6x-00041x-Mi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1Vvc89dWzjddQWEvB+SAhvAwuborhpZwqfyKsRr2No=;
 b=XfQ0HvwHWyqDYzWIFScYzX5yKbF5eHaqojBvrIEUKidi8WEpy4xzwgG4k2XZjlzQf4dQ0G
 EsKm/tKici4TQQEy7yeD2XYlG9SSGT48rICCJYZ9M8YZqc+WqwO8bH7SzpwlBkb6GEzDEO
 zwhZDVREtImGoLdGivxR+njt33HbqMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-J_UKWlHOOxCSWqJz-EQisQ-1; Wed,
 21 Oct 2026 07:51:41 +0000
X-MC-Unique: J_UKWlHOOxCSWqJz-EQisQ-1
X-Mimecast-MFC-AGG-ID: J_UKWlHOOxCSWqJz-EQisQ_1792569099
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757651956095; Wed, 21 Oct 2026 07:51:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E05C1800347; Wed, 21 Oct 2026 07:51:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:10 +0400
Subject: [PATCH v2 7/9] glib-compat: fix g_autofd fallback warnings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-7-85471fca83db@redhat.com>
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
In-Reply-To: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S/T+qztE78a5HF46eJleJDNJF6GJp7oWwfHRiLJi8EU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7s2aRy3cKHprCAunT4Sav0yB4j5d6C8DHL/
 Itdy3TwSByJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5ekYD/9jCBW37kP3DlmYA7pO1N35QHDCm40u8WeRXJylWytzilN/mBqR5MQpxNysBaKma98Mfz+
 jRttfyBNW90Pv9LvU2shJNnqNU3M7j2g92jgMtFE4+WFbzVD8ugWFgIVLzz9elJiqyg8zOj4TM1
 sg9AXJ8Zg7bSm9XlTTYTDBP7J7inK0ih96e60GRfmInjlHl3S1bmQ8AIHMUmjSqfL6CGEQ/Z0Tm
 5lxV+1b0L8GY4eGYYifDsLcuE/w3Kq/hFbvnxhBkPHFOTFR/GRlS+TeVctfaZP26+LWYQeQlYrD
 cFpLMguYUqVK4m8J+C5bbG+S7j1A9PITyzmN76MlXxjmrUQwfl9xLrilsoNTWv1SeFU302678+7
 6cLPkZeER05aEA4KuK06PnrZiQN7a8uTT2YQNBgZc9ViJca2/NCXtXmni21HcZxPgn9ObB/tVaC
 KvAkzIavrg13lYLwQs58A+yv4pVX1jJsLqh8ZLvkpI5kArvJv04hHn3K1WIPAaZm5v71bxPoT6w
 2G0YCtQio4PfiD2LcYae7gxz0T+mLewhPDffau2nKiz7XzI9SCcUeMDnoMfyRlaWdq4lT/OVKmU
 UjuMmXs3h7frViU8pnpVIHyYtyqz9m3gFLDGm2zoNt8HeIulpmNfkL9yn+HXuS8QXWy/1uCP7DG
 zFSkXpXIuM2eRvw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The g_autofd fallback is warning because it uses symbols from >=2.66

Fixes: 1599015a7a1a ("glib-compat: add fallback for g_clear_fd/g_autofd")
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


