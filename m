Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C469109C04A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RxO-0003qE-W8; Wed, 25 Mar 2026 13:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RxM-0003pS-Q7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RxL-0006oU-38
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774459426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8fWxewrs9KPN7x2kWxrHbVJR8SfoWMVf5gopTsTVQQ=;
 b=OAIdYS6N2N/B4yEZIzvqNixBDdj0dRGpVZQ3Onwexgk6F4Hn+B/VUINVDfKNR7wI5ReM9G
 mSM+CDFYS3v9hjbCuRB0QgTf8L9Un/ZD3D8xdy48erGrPc4B4CQVsPU3iNNJDuNtZGhKrm
 Bl1UD9C2pMoV5ATPjSelnvv1IuVZeqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-c4XM1QrSNf-F6m0uZwzqjw-1; Wed, 25 Mar 2026 13:23:44 -0400
X-MC-Unique: c4XM1QrSNf-F6m0uZwzqjw-1
X-Mimecast-MFC-AGG-ID: c4XM1QrSNf-F6m0uZwzqjw_1774459424
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso55953f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774459423; x=1775064223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8fWxewrs9KPN7x2kWxrHbVJR8SfoWMVf5gopTsTVQQ=;
 b=nu3FVXnqBvTNXgTjleqymRPQdUCG1pO5Vm7hLr9cjnr3gl9c15rbEF54Ik1Vl3HT6+
 ipV5t/suzjV2GfIGT9YpR8puRCcUPlmj63qjrfr0lAzYFWN61Gjt5WdYk2q6qnyyVYpw
 VdU4PSShK+DfTJ9fJ9hBsMuwTVLs4IXatrrUcmHvaGLvTTqoO7VmXjxRqt+14WOvyeYN
 GIQLYqeikmMWrAYeW7ra26V2ddT+AMGpPWPxWn2hX1GwKp2KlHALesMoZqUPSjbtEO/W
 83tMQesduG6CY3In/TC+lakIZ7Hvt0VLoScoQ9XYIIvMZdMkKOKE8MHhe7ckBNthseIH
 Q0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774459423; x=1775064223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8fWxewrs9KPN7x2kWxrHbVJR8SfoWMVf5gopTsTVQQ=;
 b=TIuLMJ8uQF2/UiBAwL0G4ykr6TOoRDb2gUPTdOtDWPm80jcKXw9Gm/jL8MiJQjrKQC
 IAQJ37vkc3RhJyUeDjfpFZdaVW2yvEp6SbQRInbWuyHmh+mlgPs6jcWerxujdq53rDO8
 oFsKJBzYRei+8CDnhoqy+l5xxwNWjhE/wkS/0hyslXFBladRJTMoCm3aQxkCZZZgIP+W
 pGLyEJMoL94JrljPLohtuGmOP87g6c/UBklcTTupmDTGDnoDDnkr+cASB7nBqyGGz6XQ
 8T3+Sw2/Tk3cPb5lr6gwG1Jq+6HioEQ7wgNwEiVhrzARJH2Nhx999/exjiK79pUXHcnq
 5G/w==
X-Gm-Message-State: AOJu0YztDgjXwI1y/QgszcT+32GNSK+tLJ13ZdkuCpVz2859qLUsGgn9
 gxUSfZQ3ggUk6ST7i28iK7HnelKFIeiZ3NdZ5cDOxHpodofRHsdmRmIKDOBRzdaLzRxkqRi1OCC
 tzxWmv2G+slzko/ZmtjvY2j1nwhJgsR+xxXgJIJN4ilZL7y1JS0gKKO5/9Y9SulLyzPltNDkYI8
 uNcDXisRTlZr0A+hk/gg64ODQbxsnD/tEWOE7VrwjR
X-Gm-Gg: ATEYQzxiBtgjhELhqEvJxhOe4LoVg3Y9TrxWLsJ/9CjJ1FlLu+MaejfhSyzOTgNEbc1
 09sQP4p9mSe/k7Xue3QQp3SeW5TyVKb1pfc+liO3U/DVyWdH/2NBm/285GfT+IMEWlCpKfSwM7f
 bRKg1LAxVy6heJBv7S+KffoJsT9E1Z4jVWe7gdnXKzao9Tt2PrTgUqW9la/BwAKl3ibJWjp3J5K
 CdF4ycAV+b2XNKRMokhkvGOmZMvfbDzO/v8aq6KYSk0SoAvkoyKXCdxzUP0l6WInuZx1PWHiVWi
 BCA9gufvlXHprPyvxUhHmlDx39D3PrUBMo7morolW1DTsvJqsu/OBEG97QOH6/cLqxyOaBTsmfV
 4u1p3bw0qOOPEIV196VJBCQW8ARsrE/Ce/mFE87N15mWgaHWC5ShaBM38KKFN2dTi62nkgHRzWt
 zX4sM0gtO2hcwMvLS/ZKKYHI7N
X-Received: by 2002:a05:6000:18a8:b0:43b:45da:f296 with SMTP id
 ffacd0b85a97d-43b8896cdfbmr6292561f8f.11.1774459422770; 
 Wed, 25 Mar 2026 10:23:42 -0700 (PDT)
X-Received: by 2002:a05:6000:18a8:b0:43b:45da:f296 with SMTP id
 ffacd0b85a97d-43b8896cdfbmr6292508f8f.11.1774459422106; 
 Wed, 25 Mar 2026 10:23:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e305sm1322998f8f.8.2026.03.25.10.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:23:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alyssa Ross <hi@alyssa.is>
Subject: [PULL 01/19] tests/functional: preserve PYTHONPATH entries
Date: Wed, 25 Mar 2026 18:23:37 +0100
Message-ID: <20260325172337.87212-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325172337.87212-1-pbonzini@redhat.com>
References: <20260325172337.87212-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alyssa Ross <hi@alyssa.is>

Otherwise, it's not possible to use a packaged qemu.qmp.

Fixes: 1497377857 ("tests/functional: Prepare the meson build system for the functional tests")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Link: https://lore.kernel.org/r/20260323084739.1013748-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/functional/meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3b42299e7ce..c158197c4b7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -76,8 +76,10 @@ foreach speed : ['quick', 'thorough']
     endif
     test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
     test_env.set('MESON_BUILD_ROOT', meson.project_build_root())
-    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                               meson.current_source_dir())
+    test_env.prepend('PYTHONPATH',
+                     meson.project_source_root() / 'python',
+                     meson.current_source_dir(),
+                     separator : ':')
 
     # Define the GDB environment variable if gdb is available.
     gdb = get_option('gdb')
@@ -97,8 +99,10 @@ foreach speed : ['quick', 'thorough']
       test_precache_env = environment()
       test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
       test_precache_env.set('MESON_BUILD_ROOT', meson.project_build_root())
-      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                                          meson.current_source_dir())
+      test_precache_env.prepend('PYTHONPATH',
+                                meson.project_source_root() / 'python',
+                                meson.current_source_dir(),
+                                separator : ':')
       precache = custom_target('func-precache-' + testname,
                                output: teststamp,
                                command: [python, testpath],
-- 
2.53.0


