Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F8C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4f-0006DG-0E; Wed, 21 May 2025 18:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4a-0006BM-12
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Y-0005bp-1t
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-231e98e46c0so46383575ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867078; x=1748471878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aCXupjQf+KpZBVxWkFiZBckC01w8HvIqJ4QFv6HBfc=;
 b=Okwq030Z6AGdtvUPTkYwW9HB/jrhEheqT5jvqp+acl+PaqYCkhwwd2zjVNMeTvKkQl
 oeU8cjpQ5voUahFFCZCyt/ZrJ2Gn7ho1nK4Z0uk4xoqlXzTDZwJZXaIWHAsXXU2aYC8g
 QC7Z0YwPvKgLzjQ7xrQESH9A3FhHW4TsolRsTlw6FmhPDsQVZFgOH1biOCw8bKddGCdN
 ilUX1yB6mmBoSCSZCLFTSIvuu4EzDj2T6CePJdK9aXz/BfGUc996DhMgbkBog/AzDmMB
 xRX0qjeggaVd5q0NMV64j+3wzh2DnWSYbu9k2avp/Pu90f9sMxEk6OQHdPt1EGzoyfwU
 3QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867078; x=1748471878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aCXupjQf+KpZBVxWkFiZBckC01w8HvIqJ4QFv6HBfc=;
 b=ilIICcb/hJrsPX+nmY+XDiiWzJUmL3BNzDAhNEY3tgGR7lAesMxYnCbZapu47Q3xIN
 Fk6jLmCCLpi9Ruq/bMREmaVGxVUCsNQhbeXHAX9zdh4SJ2E0B2dXHT0iUlgj3os/LoTQ
 IP0ckK7qIiDIRNkLo+ecJIofF7KDRyjHxx6C9P4i5stqEHbUn4IPNxOWlxhuipD6eZLB
 mI0VAM8ICqHFJkHv9bplg3yJgXmS4Ap1MiyemcAVq4EFhQgcN5r67i4ddaFFLyJwdGQA
 dW/Cjl6gtVSbzANluhYDZtFinJqXyvnryEMTdffqlTe+uDIvox8Oec4oma0vZUuUY3gI
 SUeA==
X-Gm-Message-State: AOJu0Yz+UqZg0t1ElBMLhPRaNQntdxLrBBgNupDcxLGiFO0gwVC8lS+F
 glySAUIc3GSoLdValYoyroK2dChc2TneAjYqPdygEpvV9KlDcG6NR1eD9AMudBqWjn0AVy0+dsP
 YokFH
X-Gm-Gg: ASbGncudEaO+yb41iL3rs5RPkbxdoqUHcvln/ClFnLVQS3pcSsVKhK+zk58rhaU2EEo
 +stu8IZdWU4EERBVMqiTmRNKiOVZXeoFgm+8voPW8Da9Mpa0US7sRdp+5shEyfchoj4PZ1dm44P
 SlOrFvK6ADmIU3LMnVRzyi0Aghwcm+d3//tkaIlcbz/sS6+CCIRGjNVd+R5cYr1nWWkCmpABCms
 qp0Rnh711U18jYsovTI4GD1W50c/u2MpKbYAhUpEx56uTMU3V1Mji2weFKruVbkwidr8u00YKFd
 E8Ho3mDtogCh6QlqdVS0rrrV/BxPQ+XX/cMU+IMJo4Wll66Lyfk=
X-Google-Smtp-Source: AGHT+IEYivub2LoaZPIXlmMUl3N6Hlmw5qhpkRSViRpv/opxSR1bknZdrE5OMgahPattMZzak1NrJg==
X-Received: by 2002:a17:903:324c:b0:231:e331:b7c9 with SMTP id
 d9443c01a7336-231e331bc2emr275792475ad.10.1747867077894; 
 Wed, 21 May 2025 15:37:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 14/14] qapi/misc-i386: move errors to their own
 documentation section
Date: Wed, 21 May 2025 15:37:40 -0700
Message-ID: <20250521223740.249720-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 6f79817e382..796eaa5f406 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -166,12 +166,13 @@
 # measurement for SEV-SNP guests is only available within
 # the guest.
 #
-# This will return an error if the launch measurement is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
+# Errors:
+#     - If the launch measurement is unavailable, either due to an
+#       invalid guest configuration or if the guest has not reached
+#       the required SEV state, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -210,12 +211,15 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is only
-# supported on AMD X86 platforms with KVM enabled. If SEV is not
-# available on the platform an error will be returned.
+# Get SEV capabilities.
+#
+# This is only supported on AMD X86 platforms with KVM enabled.
 #
 # Returns: SevCapability objects.
 #
+# Errors:
+#     - If # SEV is not available on the platform, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -234,11 +238,7 @@
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object. SEV-SNP guests
-# do not support launch secret injection
-#
-# This will return an error if launch secret injection is not possible,
-# either due to an invalid guest configuration, or if the guest has not
-# reached the required SEV state.
+# do not support launch secret injection.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -246,6 +246,11 @@
 #
 # @gpa: the guest physical address where secret will be injected.
 #
+# Errors:
+#     - If launch secret injection is not possible, either due to
+#       an invalid guest configuration, or if the guest has not
+#       reached the required SEV state, GenericError
+#
 # Since: 6.0
 ##
 { 'command': 'sev-inject-launch-secret',
@@ -273,15 +278,17 @@
 # 'sev-guest' confidential virtualization object. The attestation
 # report for SEV-SNP guests is only available within the guest.
 #
-# This will return an error if the attestation report is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
 # Returns: SevAttestationReport objects.
 #
+# Errors:
+#     - This will return an error if the attestation report is
+#       unavailable, either due to an invalid guest configuration
+#       or if the guest has not reached the required SEV state,
+#       GenericError
+#
 # Since: 6.1
 #
 # .. qmp-example::
-- 
2.47.2


