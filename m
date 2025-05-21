Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C6C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4R-00067p-TX; Wed, 21 May 2025 18:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Q-00067V-9B
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4K-0005YL-O7
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-231e331baceso57169295ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867067; x=1748471867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNQNvYWp/z3kSBykHJK9nPCJGqDZwEVbVWsgm8QVtr4=;
 b=J5kPIwwTbm6fPN2VQ5GO8OR+eoRFt6h/pvrLFuwCV5YXYlrJfDb7v6PeyjDcn86Ibw
 evajKwgXGGgi9L+crXvXCJYcaJ2byyt4J0OK6PsC43iD+qdtwL6FH9rK4G+Co8OllLYU
 2GGqWjOWn4uUarkxs2Lt1aR3/V6ksvMTkR4SC2hAV9cACBC9u0bWG9hrxuONi6PriRBi
 v2c4s63YzTpaSsNaGLpJ7/DRqIxgRrt00LxG+97Mxsgo62mjotZjiYbj3Gf4bAacw3Bo
 3s0Tbql+/NENZBqp2fYr3Z77Qb+4kinyKtGbi3fqEhwPZmpb0dqxmh5pY6CbYM4gplq/
 c5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867067; x=1748471867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNQNvYWp/z3kSBykHJK9nPCJGqDZwEVbVWsgm8QVtr4=;
 b=e7/BxX5cu5OTKd73DQ22tPnF4e6EfdQtwGPPqGYjTsaeM4RCsgqpMdi70AffnRXecO
 oGq3ZXNlpQneg4qYCmTpqeDMUc0k9Tftqc+WOl2FnLzCWcUc7wr9a9tk4osOVCh74fOM
 MM619snfMGlUdIBBmNCRe8CjpXJBDTtE7t9jQziuiiRqs/Jt5L6Tw4zKNgYdI7FCcGaj
 8N93fJ9mUgTLSlbLtIbYcS+b3qx1Bk3mlM06Ozl7jfW457YGub8lsvR9+d9m4BNS2K3N
 Od8+ytCwYIIJXHac9L5iO9Rf/x8Idyybbasnd3+auESC7I5xGGbyh3mN8fbK8Xqmrsay
 P5AQ==
X-Gm-Message-State: AOJu0YzJn0UbN024hgAhukkQjr/kPnZ5zhA53gIsGDgWx4c9nQmp0Vet
 N51lHtXqILgmn5JGLQHSEtT9BbMZe6/XZxLq+fzkettIleVSvF0P3gVa3P19rJut0rGV9Fis4JH
 YITZc
X-Gm-Gg: ASbGnctmpmJFH0wI6HviUK1GaL/Gprj4BP/9uTvo5hoqldeAS4F60U7tfQy/OFimKau
 5T+GV7NSF3HZ56I+5vOhloVfJNrmmcL1qTc5qNgCQ7wtfNAhrlKt600U4pChSJUYTpzvCLuSY7Z
 j3tYsyWlPXNxLYG85LqFvROpXglLrv7CITO/6+dCrD+IbSUHmcO93Y8JV4WBugvPXtzrGdEKrE+
 pXFGtwVDScia9HzgWB7mGMTX0TwlBX3j6NjOYBRgVsa0IyK5+JSheFw4wzAzDTYvYkvPgSNAHcj
 RvA/HOrqH/h6muI2s3Bf0slLoYnkbDtkThK4E9yAzipReDBWZeY=
X-Google-Smtp-Source: AGHT+IHvpgUKAHz6LBQJJ3PYAOalXAamtLSUiOapuSCPareRE7PyR9376yTOsUhA2ARWC4u/t9VseA==
X-Received: by 2002:a17:903:1b6d:b0:22e:4d50:4f58 with SMTP id
 d9443c01a7336-231d454d2f7mr333454485ad.31.1747867066889; 
 Wed, 21 May 2025 15:37:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 02/14] qapi: expand docs for SEV commands
Date: Wed, 21 May 2025 15:37:28 -0700
Message-ID: <20250521223740.249720-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This gives some more context about the behaviour of the commands in
unsupported guest configuration or platform scenarios.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index c5f9f6be7e1..6b857efc1cc 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -110,7 +110,11 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV
+# Returns information about SEV/SEV-ES/SEV-SNP.
+#
+# If unavailable due to an incompatible configuration the
+# returned @enabled field will be set to 'false' and the
+# state of all other fields is undefined.
 #
 # Returns: @SevInfo
 #
@@ -141,7 +145,16 @@
 ##
 # @query-sev-launch-measure:
 #
-# Query the SEV guest launch information.
+# Query the SEV/SEV-ES guest launch information.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The launch
+# measurement for SEV-SNP guests is only available within
+# the guest.
+#
+# This will return an error if the launch measurement is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
@@ -185,8 +198,9 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is supported
-# on AMD X86 platforms only.
+# This command is used to get the SEV capabilities, and is only
+# supported on AMD X86 platforms with KVM enabled. If SEV is not
+# available on the platform an error will be returned.
 #
 # Returns: SevCapability objects.
 #
@@ -205,7 +219,15 @@
 ##
 # @sev-inject-launch-secret:
 #
-# This command injects a secret blob into memory of SEV guest.
+# This command injects a secret blob into memory of a SEV/SEV-ES guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. SEV-SNP guests
+# do not support launch secret injection
+#
+# This will return an error if launch secret injection is not possible,
+# either due to an invalid guest configuration, or if the guest has not
+# reached the required SEV state.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -236,8 +258,15 @@
 ##
 # @query-sev-attestation-report:
 #
-# This command is used to get the SEV attestation report, and is
-# supported on AMD X86 platforms only.
+# This command is used to get the SEV attestation report.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
+# This will return an error if the attestation report is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
-- 
2.47.2


