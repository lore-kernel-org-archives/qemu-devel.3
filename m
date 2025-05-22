Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6C1C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBEv-0000vl-0F; Thu, 22 May 2025 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEo-0000up-DG
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEm-0006Rz-KT
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so8932607b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940751; x=1748545551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNQNvYWp/z3kSBykHJK9nPCJGqDZwEVbVWsgm8QVtr4=;
 b=dTWJWjJnh2Blz8nOWuKHNph+Z8a8NomPeSV7TWpvODGLKs0lF3q8mekcSxX9BULLUE
 vi+VFuJgnHuqo5FkKbxfSbm97CKetq8MtnuIqSgyikFMldbY8jU2Ri47bvSeWqLV1Klm
 fRiLzeiqHhaDvwPX2lra2ou4ZAqsQlUb9PEV8C2Ppi3DI4DZ3Rwj8sS0+R0RbhAT/Oby
 NXHSjo7aPkVRmJqeTlwlhpULL9BiEITlkAc8HYiciCcHfteuoMeuHDyehxRh7QPao6LN
 Pi4hfVqTD9Ysvy+zqM3p8jygezwcqaVBO75sOP25S1uvieIv8ZU70GHfVRk0vk+y9Srh
 KjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940751; x=1748545551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNQNvYWp/z3kSBykHJK9nPCJGqDZwEVbVWsgm8QVtr4=;
 b=ekj3+oFktU6UguutG1GzNAaB+MUQmg9uUeR7th0kjQJG28t90Ai4uE7WN/4tm6JdvW
 gXJz5jwSdC3J3q3nDuy7DGl591k2Skln1TfuTS4GZpS057G/bHTNd0o6o8iX4GEVuh2+
 NURwVWSqoJFyBaOJxe0wjjdST0C64OrKvFp+Y1LWDvQwuAAIqEUFodcrBjlPf7MzBZyI
 /lFG8uo51s4Hb8zGoTOUmTGOizxz+2WUEZ9pZO0kbtJ+CynytroivLH55HTnwzV6SLaO
 KLnRXUncw8BzD+eoF2iFAc1/Vavm4KxT+YySrMeN3cOb4feRCtBEg7eUZzhvALf+p47j
 nC6w==
X-Gm-Message-State: AOJu0YzkAGQT5N1m00Q7vakfCIqalEnJrxwp5hASrGZZIXHeNZLAi2cI
 6ElnGXm5BdntpGjw+CxQEhqb+QaMIBV12Hp7ScFDBKTRTi8l3WKtCQrlVTwJO+Ph8pkUaNxxLM0
 MePvw
X-Gm-Gg: ASbGncumUF6Xngf5ttWzjuKgzJEc3Y66/6a/a8FIN3nyeL7xTcGaBHEK0yc85l+/bkP
 GFhjBUhRMirbYWdMcY0tcp57K8PKXeAVSlVuxtBh6dZDChYBTE2pGi2u3aNlVJEODYEAoSxOxU0
 DTLAUM92HsHebPhaWancv9lyJp1hfp/sfJD8QLUIY8lzXCl8HsGl7y0piq43m7eZvla7fajy5VQ
 1sKcEcq+xyQoHUz8dYoYOM+JSN7YT13PYMQ5RxO211pxM0MtjNOXth5xh64Ld55H9w1HDk73iT6
 w/Wcs20Ajrv9Fgv7amIcMOqoDrlTw5yjLiWvsQm4/iWFcNO+moY=
X-Google-Smtp-Source: AGHT+IGs+xkDgNLx9mL3THsDqv3frXUQGJfJrhtzq4wdJ0Oo+aZnAyeJ92tyk9yS0LfM+iZQgF90TQ==
X-Received: by 2002:a05:6a00:3a04:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-745ed84a0d9mr328091b3a.4.1747940750891; 
 Thu, 22 May 2025 12:05:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 02/15] qapi: expand docs for SEV commands
Date: Thu, 22 May 2025 12:05:29 -0700
Message-ID: <20250522190542.588267-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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


