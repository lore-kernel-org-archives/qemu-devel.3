Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsD-0001di-9d; Tue, 04 Feb 2025 16:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQs1-0001Zt-25
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:14 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQry-0008V6-1E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:12 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so380240a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706049; x=1739310849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RF4IUZ2wStV4ova4JSHtHk43VzVhFdkA3cxlgv+PzwU=;
 b=mRGQARtolS0XFZadWlApBgisgaRtVwpidXSGGodhh5f3tY31TYDngBrkotkYrXEWYq
 U5RSilRxIHfmvb9Bwd9VAljfA1vDHshLTy6oLj4iYGTUNcyrkd5B2jm23/PVbaYE1phw
 asv4fg3nzlC/FXTWwGEm3KVABIJvXcGYDtMfJToPDYzu/Rd9mmRBIqfa/XDqHeXXY7hI
 S2SF4xpu2VegX3emb7fNxYss/vHInJwQh5BbxVrdAkQXVdmfMUjeUlMc6EdzMN2TBxO0
 2Hsqi4JhWSmaUWxiptnNvXy0wtvS0PZQjwvb/LVcVRVQUt0sz2w1t+JAbcKhpmpJoV3B
 i3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706049; x=1739310849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RF4IUZ2wStV4ova4JSHtHk43VzVhFdkA3cxlgv+PzwU=;
 b=Pf/+vQojYPVdOFFA980CbyrGaUVG8ZWKYkNU8ATWOhbyDEHPi9Ztk0A47D+yG5oIMu
 90ZSKRFqgNVXA35jv0j6OZyP5MG+3uXEexqcM3Z7P4n93qw2k5yrdphIphrcScterckr
 S1KtN1okRlqaH1Y5ith4p6XQ9vGJA4Tz+UaibbVCCHAJJSBYIQbA1HnmbxmyvXBCiy8q
 xNINUzkaeQG2BFtvwKFUH7dYrFd+3dArq7zf0A5wl9dS0Vp9ynoXhAvOVCCWutfag74A
 VSuhejG+z2//5uUVnANWoYtfw68LHF7Fq79frZp+eGBxLyamz7jULg07Wz/rAquKU3Pl
 9BFw==
X-Gm-Message-State: AOJu0YzdKAkMXhcLHTpaxmAJdpLcJ+1Z+2zmXSaHwfmvMPve+FdQmptN
 e5uxAsNK+nm9qlflxvKf6cpR4RYjrznXliWtRfZaMyyDJ3vA2mEL/yGd0IgVSSLyfCTIktukNya
 q
X-Gm-Gg: ASbGnctBETORNyu4/gfmuIZpNC6lXIeavRIHJxojoALGPcMMn6iD7U2174HeWHJpsFG
 /Hxr732E2biCI/FFMi1XCHPTZxNco/jAy4xUdUJ4+RMa5CFlHPb5eVm2bd9r6xBWNEP5Z3ZRKhi
 zJ2ahKQFMkzwQd4cQvV60s8tNJn92k2E4rAA7PK9zRfhp2HnX9JEmzIM7JIsthZnDt1K9C0DdNE
 IIMSiw1pGps6NVU+PsAe3oRwVHHgaSNuP5Q5eeSwLRCzPzk5rH6Gn+NS8O0JzwlC8kC2bnjgCpv
 LfEbT3mHnW6+eaWiY7L72IYb61figKK6MfUmJ4o3QvxV7CU=
X-Google-Smtp-Source: AGHT+IEwm99vJwqf4Sz++tlLWwgteNNfX0PTx5oVA/OyzjRAMeOuZiDPC3E4XGaWT5GOvZaNwugB1A==
X-Received: by 2002:a17:90a:d643:b0:2f4:4431:51d4 with SMTP id
 98e67ed59e1d1-2f9ba22584fmr7761981a91.6.1738706048682; 
 Tue, 04 Feb 2025 13:54:08 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 10/12] meson: Disallow 64-bit on 32-bit emulation
Date: Tue,  4 Feb 2025 13:53:57 -0800
Message-ID: <20250204215359.1238808-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For system mode, we can rarely support the amount of RAM that
the guest requires. TCG emulation is restricted to round-robin
mode, which solves many of the atomicity issues, but not those
associated with virtio.  In any case, round-robin does nothing
to help the speed of emulation.

For user mode, most emulation does not succeed at all.  Most
of the time we cannot even load 64-bit non-PIE binaries due
to lack of a 64-bit address space.  Threads are run in
parallel, not round-robin, which means that atomicity
is not handled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index c80382befd..aa1ca8355d 100644
--- a/meson.build
+++ b/meson.build
@@ -3190,6 +3190,9 @@ if host_os == 'windows'
   endif
 endif
 
+# Detect host pointer size for the target configuration loop.
+host_long_bits = cc.sizeof('void *') * 8
+
 ########################
 # Target configuration #
 ########################
@@ -3282,8 +3285,14 @@ foreach target : target_dirs
     }
   endif
 
+  config_target += keyval.load('configs/targets' / target + '.mak')
+
   target_kconfig = []
   foreach sym: accelerators
+    # Disallow 64-bit on 32-bit emulation and virtualization
+    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+      continue
+    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -3297,9 +3306,6 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  config_target += keyval.load('configs/targets' / target + '.mak')
-  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
-
   if 'TARGET_NEED_FDT' in config_target and not fdt.found()
     if default_targets
       warning('Disabling ' + target + ' due to missing libfdt')
@@ -3312,6 +3318,7 @@ foreach target : target_dirs
   actual_target_dirs += target
 
   # Add default keys
+  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
   endif
-- 
2.43.0


