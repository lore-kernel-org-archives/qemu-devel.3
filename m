Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C86CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvD8-00019X-QR; Fri, 29 May 2026 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvD5-000197-F3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvD3-0008Bk-St
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM1V8XjBrCxs1yBLSZROpXvQPyHauxhZXHX7W4Xzbho=;
 b=RCD5t2OPYSSFkbZO4d4fMvci1hwtGxMolVLKTkIvNAPrMSkV/Onnfe0mJJXBNhGjOl5APK
 APWCFdS9HbjW0U7hNIoGIFrgEJ4MCUGYQOyJkpQnYfeMq82/qiSK1Avf73LP1EoWMMRjQq
 ahka+AtJtlwH5dywMZmxMoJrbNvIYmY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-qe3RjKEJOCiL3SHMXl1Bzg-1; Fri,
 29 May 2026 07:16:56 -0400
X-MC-Unique: qe3RjKEJOCiL3SHMXl1Bzg-1
X-Mimecast-MFC-AGG-ID: qe3RjKEJOCiL3SHMXl1Bzg_1780053415
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9C9319560AA; Fri, 29 May 2026 11:16:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7760A19560A3; Fri, 29 May 2026 11:16:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:23 +0400
Subject: [PATCH 02/32] build-sys: build with -fno-omit-frame-pointer with ASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-2-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eP9coWA13E2Og6kJdJyotHqJ3qp6iuOYSQNlNUaMVew=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWOveEOldIwc/Dflxc4f5XST2qLMCuYKHM+b
 DNkE5KuBESJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jgAKCRDa6OEJdZac
 5VRkD/0VsVax7bLNkDPzmbpq4YZcI0zpq1Oc84qOiQnwOHI0Bfc9AJWibwdxKun2u3w3yHFexBz
 L1do93SIcZEv1SobwhfDNLSdrGomOFReMDTxwLH26mvyJ1PN6udDAOiR/Xx/4ssgNWDA/ju4idZ
 FjfaQnkTv/Ch9Trx2N/ts9HZ2gIJDcIom5qQKUXlJc98eerLxYWgLNihUz0TRoSrbIzxHFAFLic
 MUaZOvtR20O4Vve144cCFkoZsoMvo5CzPx3mR/hyzm5EQCETEarw6WAlC96ZXu9/qWHx4X9AnCz
 RcPMpJhOguO/UGEfYd7ywo7WDZuYB/0YqObWnB5EUOhjLa2S2kLre+1aRXBQOjSMkxaJkLiyBK7
 Gz3TqNe8qGNxLslX2baN18qcUYOQuYniJq51ZmbIvZ/c4SWHY0r+UJCKTG/hQL6AIEr6A1IIvlQ
 YiAbLJ+hQkIljZguWQF5Fm/T107SfVNvnM70UADFwM1V1NbjhJEXRnMKetZHi6kI1Hs5GsgZKtP
 zBIMsMdOO1lbJYJZnG6HupRzhl23UiF3Fxd12N7a4YSs6ie+VemHdZrcCAxPDRYRwamcYygqeEl
 5BIegkCc6fizNOXPU2ywAELKzdSB+VpDsjWS4RTLvyrBv/z8Bf295q4LBfPO9F+Oy0yTGbeyYZ8
 gBVUts7u0w6+hgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On fc44, LSan fails to suppress leak:qemu_irq_intercept_in, because
the backtrace isn't deep enough.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index eb074918193..224534ac351 100644
--- a/meson.build
+++ b/meson.build
@@ -545,6 +545,8 @@ if get_option('asan')
   if cc.has_argument('-fsanitize=address')
     qemu_cflags = ['-fsanitize=address'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
+    # Ensure complete stack traces for LSan suppressions to match correctly.
+    qemu_cflags += ['-fno-omit-frame-pointer']
   else
     error('Your compiler does not support -fsanitize=address')
   endif

-- 
2.54.0


