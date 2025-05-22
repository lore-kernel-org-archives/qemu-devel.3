Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C57C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFy-0001sm-5Y; Thu, 22 May 2025 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF3-0000xz-0B
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006US-Os
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so6930427b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940762; x=1748545562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFNyLq61X9oj5XcqX9ULx+NmBqVjk0YKZDfCa6aorIU=;
 b=RXqI4uIQ3yCkjnDoeg8Nsx+8nHFtDPChPqFuBulcwPG9ZeG8pYSbzwp/1wXHPaGnYm
 HajfknDF+kLKlFD42Us7StPntEHnRLfc9xe1v7GpG6+1YiwvAyKmZVf9Z9g9arzZilza
 nrum/dYKVCCOOoR1LHO2KPFht/wl32NX7IUcg5b6r9d7b9/eKYRjVsP3gLNdZ/TvQxzK
 2GSljnyFdbNPMjQYlaZ1oAi1JgiTlMTU3XrrKcbuhJkeZ2CRwFFc72koHyi1qNbeeTY3
 EKr9zCOmIhaGY9LUjFYFw3tRVx0eYgnFbPjYAKNpDoCZ8F6ntzRJHPEHq2LvQXSy73a8
 mAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940762; x=1748545562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFNyLq61X9oj5XcqX9ULx+NmBqVjk0YKZDfCa6aorIU=;
 b=ZOGse1gWUjxXxGRE1cgWKebe9puVR4JUDoBSWgdj1HzYb1zOmczsqpPg6dj4K7+iZI
 WFBm71gp/oO8V5c440jILvznQvlwaUVrIapCgV2g9fKzVJvQRbVTpdek4YaNW7yivXdV
 J7U7iHOE6mYpf6h3awDnhn4EF3QQ/AyA9cjqpvEROOj/q9RwxDCtm7aR/q95AvOSBhw5
 gDm+1L6/1kDmf0DUhUbjqcZ9VQKsBTeRpm6MTQWQop8RNbXMh3cCnndBQ5+IBnP0L/Ic
 CGW3bxUdD4s+/zcJNYw4lXdFOT4QANbVFOQeRZR2Cd2Pb2PxZb8Qb4nqUkyAwVY203Qw
 USjw==
X-Gm-Message-State: AOJu0Yyq+EV1VhBdZJZQFYZ+yt8x9w9mGRbGE3/ghbquX7k2d6Z0KWpE
 6/+P84ypM16YKOEY3yiqDdFtXNMK5UWm0z4Mx/BCbYO8NIfxI97shiA+POsp8jfgNFeNRUbgWHf
 qQcNK
X-Gm-Gg: ASbGnctaStAHXq40s894tQKcT/N8MC/r7kCRK3JoUz/MBgS4zStZFV/6xZT9uPXlW97
 +k4DOGxIkjftTjRYdJ4Qd6aIAZ4C7bq2bcZdk89eUEkohZ5IEwo5yBSTJVdzG1rkvkUsLkc/Q0G
 gowMuStKozyEW8OenPC0DruO8CW4ZrsRrO2RIKEaWLvzk1KGRSW9ZLyChoSfpWvQ4VzeKt3+nDp
 Z8auPM0IhMYXf6YQlTZB8R6zBi66e/bTil7R+bO/+caR7oxwys/xTzZIze8PhOhiJThHYv9ev1w
 4hHSMET8ULt7NyawUNhPIxqHbLpeLMDcHy6gREgaCdq+SeabMnw=
X-Google-Smtp-Source: AGHT+IF5IID0F81h0tLeg9xYW9mqtcfFGLLk9yDAeTgQvYSveO0u7K4Dy3YiuLcmWmVBpIKP1vkZrw==
X-Received: by 2002:a05:6a20:6a2b:b0:215:dfee:bb70 with SMTP id
 adf61e73a8af0-2170cde519dmr40055087637.29.1747940762585; 
 Thu, 22 May 2025 12:06:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:06:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 13/15] qapi: use imperative style in documentation
Date: Thu, 22 May 2025 12:05:40 -0700
Message-ID: <20250522190542.588267-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

As requested by Markus:
> We prefer imperative mood "Return" over "Returns".

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/audio.json     | 2 +-
 qapi/char.json      | 4 ++--
 qapi/cryptodev.json | 2 +-
 qapi/machine.json   | 4 ++--
 qapi/migration.json | 8 ++++----
 qapi/misc-i386.json | 6 +++---
 qapi/ui.json        | 8 ++++----
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index dd5a58d13e6..826477c3072 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -533,7 +533,7 @@
 ##
 # @query-audiodevs:
 #
-# Returns information about audiodev configuration
+# Return information about audiodev configuration
 #
 # Returns: array of @Audiodev
 #
diff --git a/qapi/char.json b/qapi/char.json
index dde2f9538f8..447c10b91a5 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -34,7 +34,7 @@
 ##
 # @query-chardev:
 #
-# Returns information about current character devices.
+# Return information about current character devices.
 #
 # Returns: a list of @ChardevInfo
 #
@@ -80,7 +80,7 @@
 ##
 # @query-chardev-backends:
 #
-# Returns information about character device backends.
+# Return information about character device backends.
 #
 # Returns: a list of @ChardevBackendInfo
 #
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 04d0e21d209..28b97eb3da6 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -94,7 +94,7 @@
 ##
 # @query-cryptodev:
 #
-# Returns information about current crypto devices.
+# Return information about current crypto devices.
 #
 # Returns: a list of @QCryptodevInfo
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index e6b4b2dfef8..7f3af355b36 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -99,7 +99,7 @@
 ##
 # @query-cpus-fast:
 #
-# Returns information about all virtual CPUs.
+# Return information about all virtual CPUs.
 #
 # Returns: list of @CpuInfoFast
 #
@@ -467,7 +467,7 @@
 ##
 # @query-kvm:
 #
-# Returns information about KVM acceleration
+# Return information about KVM acceleration
 #
 # Returns: @KvmInfo
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c4..1278450e09d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -282,7 +282,7 @@
 ##
 # @query-migrate:
 #
-# Returns information about current migration process.  If migration
+# Return information about current migration process.  If migration
 # is active there will be another json-object with RAM migration
 # status.
 #
@@ -535,7 +535,7 @@
 ##
 # @query-migrate-capabilities:
 #
-# Returns information about the current migration capabilities status
+# Return information about the current migration capabilities status
 #
 # Returns: @MigrationCapabilityStatus
 #
@@ -1320,7 +1320,7 @@
 ##
 # @query-migrate-parameters:
 #
-# Returns information about the current migration parameters
+# Return information about the current migration parameters
 #
 # Returns: @MigrationParameters
 #
@@ -2294,7 +2294,7 @@
 ##
 # @query-vcpu-dirty-limit:
 #
-# Returns information about virtual CPU dirty page rate limits, if
+# Return information about virtual CPU dirty page rate limits, if
 # any.
 #
 # Since: 7.1
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index cbf85233eba..3fda7a20bdd 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -126,7 +126,7 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV/SEV-ES/SEV-SNP.
+# Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the
 # returned @enabled field will be set to 'false' and the
@@ -336,7 +336,7 @@
 ##
 # @query-sgx:
 #
-# Returns information about configured SGX capabilities of guest
+# Return information about configured SGX capabilities of guest
 #
 # Returns: @SgxInfo
 #
@@ -355,7 +355,7 @@
 ##
 # @query-sgx-capabilities:
 #
-# Returns information about SGX capabilities of host
+# Return information about SGX capabilities of host
 #
 # Returns: @SgxInfo
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index c536d4e5241..59897fcb9f0 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -323,7 +323,7 @@
 ##
 # @query-spice:
 #
-# Returns information about the current SPICE server
+# Return information about the current SPICE server
 #
 # Returns: @SpiceInfo
 #
@@ -654,7 +654,7 @@
 ##
 # @query-vnc:
 #
-# Returns information about the current VNC server
+# Return information about the current VNC server
 #
 # Returns: @VncInfo
 #
@@ -820,7 +820,7 @@
 ##
 # @query-mice:
 #
-# Returns information about each active mouse device
+# Return information about each active mouse device
 #
 # Returns: a list of @MouseInfo for each device
 #
@@ -1562,7 +1562,7 @@
 ##
 # @query-display-options:
 #
-# Returns information about display configuration
+# Return information about display configuration
 #
 # Returns: @DisplayOptions
 #
-- 
2.47.2


