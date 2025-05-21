Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388BAC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4j-0006Ec-ND; Wed, 21 May 2025 18:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4f-0006DD-Rp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4W-0005az-7u
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26ee6be1ecso4084306a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867076; x=1748471876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFNyLq61X9oj5XcqX9ULx+NmBqVjk0YKZDfCa6aorIU=;
 b=WizQGAlm872BRDcdElbnExnsWviWxghyZhyyLVI13n2qbu8zKKSbjuZm9AgMeVPNG4
 4Gu6Vx12TOsJhRciqAd6yJUE/HY8inzSaFaJFxABQaeot1HMz9iOew0stUo2ovnrNQcZ
 IMx6oi+MJdkUIlhhJcol9JG/cXfKJ/H3CQOoOWsQbe2+ja0o3bajewB/6+0O3wY8eAlW
 HTJdOR82PWvNdwPbWmFaCxcUhFeFsVMH+WnSziTjxKgAKgurgp1/rshNTMah5u/fG3Z8
 hNq6HFbVY5uKI3waRurIyqdfmRy2YkLGtDBSdbmKU2/BnZGYSvBVkErxFXc16oqVXU73
 Eozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867076; x=1748471876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFNyLq61X9oj5XcqX9ULx+NmBqVjk0YKZDfCa6aorIU=;
 b=iZN/NGQ47lUUsaJJ0xGoquWMHQNVoxB3qgUY1dS5mxDGqWs9HFP+PbczM14A3rS54M
 i3yrhcSo/aHl4vy0+A/2XdZhFin857amMiYi84OY6D9FPlk7kAVz8rhTKznC4ENN/fQn
 AMC1yNjZ+MHQ0gZQokhztbS+SUVFNuY0tD/DeBPN1bKVzNisUqMeS+Vfo5ipO297P4Nw
 Reun2+bCJaYYFheRzEpgicvFV6L4ppw8PJwmz2XiA4LnBTUelbT3anQCU6w5AhLS6lJM
 yY9yVmkmWpUtYrWJ4TwWK7QCvou4QxuV76CBrwSVKOr3z+xdtRn09Z9mQ66wTLmmjk4k
 TTug==
X-Gm-Message-State: AOJu0YwWWCyQBpuJ3aeSm9F/BFS/c4q0ZfGJHvd7jogSq7wrn9ssYSVC
 4pMdZhtmhpNWZCen8w/28D1VgGVFevVjuqAAup1yha6qPip0T/bkxpVdF5rAd2HGWQxU3B35jSs
 tH+NI
X-Gm-Gg: ASbGncvbX3qWy3gSa5bIvEbmlw4GoPliFxVvWt2D4RRkWA81nXW/a8pXvmgAt/paDow
 /IEAnL3I+cR6n3pViYFvQUga2j9HgLi6QcGWpatzFqI/S2V29Y/Sl/6mk+fvKl6VgXzG3hP+Et7
 ldESX0ETkpxR664I5wVGTUpsDySr2Z4zLigJLwzFXWwigNDF5Dcd09SCYtP4W8uPe2wjyX8oY/D
 8q3DmV6n7e1s7WCxEq99uRlguACYjPXEQYeIPe21z98fzJLUYmavVLjBcwW3UfFl/fJ00MpsOqA
 4AunQ/4B1avNvJS5PICV4CxnwKlp1UbFkBRjoJm8xkS6zdGs7wU=
X-Google-Smtp-Source: AGHT+IGKna2V+o0bir2P39PsvyeMw+2+W4JpVcCCOm1N4eu9SCEJDKzREMFeS/GQhS/8gBQt8QX7Lg==
X-Received: by 2002:a17:902:e786:b0:231:d143:746c with SMTP id
 d9443c01a7336-231de3ada00mr275968595ad.39.1747867076160; 
 Wed, 21 May 2025 15:37:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 12/14] qapi: use imperative style in documentation
Date: Wed, 21 May 2025 15:37:38 -0700
Message-ID: <20250521223740.249720-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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


