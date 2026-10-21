Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6344606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=haEuoVzP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR6p-0004Tv-LP; Wed, 21 Oct 2026 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6f-0004Qx-BL
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6d-0003xi-1O
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCEVMD1gyJAzZ9YtCPiB1iMbNGx4Ji4Gb/+PW9esD/Q=;
 b=haEuoVzPfH8C/XA/2pHb16yBUzTBh3e4V7cFbg174/IjVP1FaJgHCoDbxPdkXh2pJsjrsU
 0G6iU5vk8LwBMbb4vMAsBxRSno75j/sNsFp+Bm3btISMTPy4QCSpGlUGvVjldz0/wbQV6J
 DbKgyeySFwBj0AcztkY0zFKgW3eVvuc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-I0gtOtuKM9yQU1l017bpuA-1; Wed,
 21 Oct 2026 03:51:20 -0400
X-MC-Unique: I0gtOtuKM9yQU1l017bpuA-1
X-Mimecast-MFC-AGG-ID: I0gtOtuKM9yQU1l017bpuA_1792569078
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A561F1956070; Wed, 21 Oct 2026 07:51:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA8A41956089; Wed, 21 Oct 2026 07:51:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:04 +0400
Subject: [PATCH v2 1/9] tests/launchupdate-test: correct g_auto usage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-1-85471fca83db@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=B4SuUYDYOYHdj6YNYX9ybX09sSVtBdqWgwmLhNkBr3c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7szaLzZFlT+NGpkQeDe5xkJ/uFPnT/X/3mX
 w+qbORERkaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5ZULEACIUEzGHL2xRgPFJR5ukS8hpXqY8yUD9CDkaHGBz7voRSHecAwzrilUyAaNTVdWIWKmfI8
 pUnJBxi1005vXyKgoOZxqz0jPRf5TV91rEgBaKlx0dxFgrGIclUNMUSCoosu0D6QnHEzVHXfKs3
 BKI7+Hs2lmlnytkux29Hky4on4/0CpijDJDPK8D6CetzriQlMgyEpQyDysVPDRIa4aEMVrsLYf8
 UZSgLhIOfqyhZAB0cw3YjUxywOWzHydUNfqntnn+YPmpcYEhZ0LFwRgDny4KSgsMsh0JGSHK2ex
 9+ibZLDXEEs7+IaJaiJB3RjMQRFM+mwFuXx26dHw2XtRTRtGeO+pEvJ5hkm1EGJZuW8o45koPCV
 Uu9kftGQIHFcLokbB9vHjIjSLPcCUc4Vqqc7UmLxIYBgajI6mw980CS5hlhCqK16MhXiTWJ7Pe0
 6B4Wv56y/BeOGEoi8JUXKaX0VJpWFPXnB0cvYjt1HhCXtddzfZrvgfIR4fEqN7U8ruvUNsqumcH
 4154YA8cWNfyuQqJTTeVL4yX8RnEp7WytZgeKFrjUlD7FT4B5wLfk7eRbsFMLuv7cUWKhgkZeM8
 RhMJsKqf3fhuKQ/I10cvd9GDQe1lGlf+jFp7INrJfV9PsbPEVw+DbDJtlWErmkHvNCj04TdgyUK
 bk4x3hTjL7TtiNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

g_free() isn't the appropriate way to release those types.

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index 225c843df5b9..ed007cdce29f 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -192,8 +192,8 @@ static guint32 match_string(char *serial_f, const char *exp_out)
 {
     GError *error = NULL;
     g_autofree gchar *f_contents = NULL;
-    g_autofree GRegex *regex = NULL;
-    g_autofree GMatchInfo *match_info = NULL;
+    g_autoptr(GRegex) regex = NULL;
+    g_autoptr(GMatchInfo) match_info = NULL;
     gsize len;
     guint32 count = 0;
     gboolean ret;
@@ -214,7 +214,6 @@ static guint32 match_string(char *serial_f, const char *exp_out)
         g_match_info_next(match_info, &error);
         count++;
     }
-    g_regex_unref(regex);
     return count;
 }
 

-- 
2.56.0.116.g6de20f6092dc


