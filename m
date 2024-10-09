Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F91CEFC5D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHw-0001aZ-78; Wed, 09 Oct 2024 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHn-0001LS-I4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHj-0008V1-E5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO920/vU3UVu5Z0ktPqv8vRtCWnYQqPNoMlASL2Ii24=;
 b=RJDxTyN05xQ4Vv1VykVL1vGH89f+hIEvOv0vfQ/gOj9GgwR0LHM9Z64PXr1VRsWX39tsLx
 A+s9G2JDH1s8MjjhRE9/gtcuM3/00xPVClqYOVhi6r0l83cQAQhesoSGsMGzKe78IdmyaE
 t1fOmF+z7IPInKRU+xIS/A8fh/q24/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ZW5osFTWPYOqAB5S3nUwrg-1; Wed, 09 Oct 2024 05:47:08 -0400
X-MC-Unique: ZW5osFTWPYOqAB5S3nUwrg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so58384f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467227; x=1729072027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UO920/vU3UVu5Z0ktPqv8vRtCWnYQqPNoMlASL2Ii24=;
 b=d4FTQctGJX/VR0ae1rT8adDOyVQakkgbOyVrC5eIImJaWAQirK6DZhQRdelIftRwQI
 BsZgdRMMaT1x2x+NmsCKGJ9gABJHNiFtf6QSMFk0tKoH1iZhGPOMvo2OZQUePF2+A1Oh
 Gy8AGCzBF37Ce2vzA9UrW9ybap9aD57aBWOt4M7yAL5/ITDZ+BcK8evHw3szLlGdKCk5
 B4RzXlgRuE0D5MUbR97nZRkFdBww5Ow0239jRbhRTWK0YCaouKkfgeUdQ4mKyphqADNq
 oLFcgoVpemNYfXCzvzrb8aW53pGzZPB8mnaoU1d/CsYO5DG1cmCgUtQhHb8ZkRnIMivD
 siZA==
X-Gm-Message-State: AOJu0YyIqDf6QH1WVIDtlR/zKUsj4wAwBBo8d/X3I0iuvEjUc1KIiDcQ
 xxyAnHXT0iLcMrSyxKauGpemdIH1MIvyfW0mHjedKSTUMKWyik+eA8AnofISUKhxai7DPYHkrNt
 wzM84qfzBahQdfx/RXXDGQ32yL8DPyQ+wToPhIdcvKmTlH98+LzkEWcaFjCVUGr0l0V1PxdCmjf
 OK89Cu4pwHGSPD5Z3CcnPyDw/BoLZjIT2Vrvqt1lE=
X-Received: by 2002:a5d:6742:0:b0:374:c4c2:5ad5 with SMTP id
 ffacd0b85a97d-37d3a5480cemr1344835f8f.27.1728467226873; 
 Wed, 09 Oct 2024 02:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmeo+yqvDnPSMPl4MheFhXZLbPNadkwnN5b9l8VJs0ssm7rL39IpSQAiEapXzPd196pjxRMg==
X-Received: by 2002:a5d:6742:0:b0:374:c4c2:5ad5 with SMTP id
 ffacd0b85a97d-37d3a5480cemr1344809f8f.27.1728467226334; 
 Wed, 09 Oct 2024 02:47:06 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d39cb1358sm1470753f8f.25.2024.10.09.02.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:47:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Subject: [PULL 12/14] meson: ensure -mcx16 is passed when detecting ATOMIC128
Date: Wed,  9 Oct 2024 11:46:13 +0200
Message-ID: <20241009094616.1648511-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Moving -mcx16 out of CPU_CFLAGS caused the detection of ATOMIC128 to
fail, because flags have to be specified by hand in cc.compiles and
cc.links invocations (why oh why??).

Ensure that these tests enable all the instruction set extensions that
will be used to build the emulators.

Fixes: c2bf2ccb266 ("configure: move -mcx16 flag out of CPU_CFLAGS", 2024-05-24)
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 65ea45cef03..e4b2af138da 100644
--- a/meson.build
+++ b/meson.build
@@ -2831,7 +2831,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
     __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
     return 0;
-  }'''))
+  }''', args: qemu_isa_flags))
 
 has_int128_type = cc.compiles('''
   __int128_t a;
@@ -2865,7 +2865,7 @@ if has_int128_type
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
       return 0;
     }'''
-  has_atomic128 = cc.links(atomic_test_128)
+  has_atomic128 = cc.links(atomic_test_128, args: qemu_isa_flags)
 
   config_host_data.set('CONFIG_ATOMIC128', has_atomic128)
 
@@ -2874,7 +2874,8 @@ if has_int128_type
     # without optimization enabled.  Try again with optimizations locally
     # enabled for the function.  See
     #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107389
-    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128)
+    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128,
+                                 args: qemu_isa_flags)
     config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
 
     if not has_atomic128_opt
@@ -2885,7 +2886,7 @@ if has_int128_type
           __sync_val_compare_and_swap_16(&x, y, x);
           return 0;
         }
-      '''))
+      ''', args: qemu_isa_flags))
     endif
   endif
 endif
-- 
2.46.2


