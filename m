Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3C9C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj3-0001UR-PA; Wed, 14 May 2025 19:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiz-0001Ka-W7
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiw-00031v-W8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b074d908e56so150825a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266077; x=1747870877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BumM4a0ZkPuppUUYHu5+IcPL4OW4nu6E6qjLxZN9PWM=;
 b=exwCNdpG6KFBHV9ZxLzxDQw6+UMlmwflE1tssJTln9dQaurPpV1RnORlxTjuj5H1wl
 Ck9RmBoAT34f+tuZDRuTaaHdp11g3IhYPheLIKmGx34aEffnzc3bFNCrbq1+EAodDY+W
 oIlgaaQNUUD4UJnqTS7kYbPpoCR25LPExskPSpnUWYfO/nhk7Feb1Sqt1/XUo+/jOfOn
 01VhQY4lnlBM3nQA45hujP+pE20Nd2aEWSt5+U4hd2BcJE5i/jyGYDa9GZoxFpAZ9FQW
 K8DKWGDkgwSv4Bl7oHNRb1MHAqCCyHHXIvb8D+vMEoqMEdVw1J2BSzuY+XOXH0+VQcWH
 S/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266077; x=1747870877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BumM4a0ZkPuppUUYHu5+IcPL4OW4nu6E6qjLxZN9PWM=;
 b=Z2MQCV66V6Do5xWDMw3XLs1heVvZ5d+J3QsieULpA3m7pkKAw9GxYbvLa3SbCX0F8w
 ibHVy8zyTS74u9dRwHgzFiF0vjLccnlAnyotFOwnJbPpJVrVeQG7xhxOhGYehEg6dudk
 B+L2k03UiJqWfIvA2yp/4BAyPIjLVBQV35TbDQL4xAUDlskMQOowCZ0fr6VvvrvaMqLY
 bNy71vR95IMrI2KLB1bMODiob8sqhURmRQkdW5KIgQ5cKBtrsZ2jZL+HmrP4jHClce7D
 zRWvEdt2IZBHfolhY/qILwJjU1gQ2rQH49tkqKjGnpwANALc+UkIZsKzPINH5sj9PJ9A
 0AtA==
X-Gm-Message-State: AOJu0YyXHLxZqIiae0OQRKKey1rIfFTbsn93ASI+pNinYi9oWcDwm0ND
 ynhaCbgu4L+QGH1zcDp92x+V/qFhLm6GxOZJaASp35YPBoxyTwyniq57ah1lIbqvJ6WTzQpxJbf
 qyss=
X-Gm-Gg: ASbGnctltqw15+uzRk/Du4X6rtVGZsA1pim4TcHwRui/IWcP000gdaH1ecSQuFOD21m
 QxlscoXe0QbHBn1ldY/q01Z1hSlMiIFCLuEiasZYLcZCzlDgSU2oq+NPf3QQ+Mi40eUyMI6Z4xl
 BCVvjiIZ1hzGYJgk0pwhtJdUi4EbEKJ+7Mex9YdxBPPChT4drvJUBFjEQDmjh7SxZe89BlyDI+U
 Sut/GkjPvRb0TuCwwO1Eq6K2NNfDFhIkhQrEs0ud6W2f3TsmcVlSriB3UQ0Nij0bmMX0wfh1oZd
 ax5vPr3vpNvYsEC5TJeALFfchuIoVC4zwZJq/0dQgqsHcgCozDhY9TbhuQtHRw==
X-Google-Smtp-Source: AGHT+IEfik7bcKclLzi/RALvPp+NFPQjkDuqtDJtpZ8RMA74JxcS8rOjVmEQL9ZBmOFye/zmNTCo8w==
X-Received: by 2002:a17:902:ea09:b0:223:628c:199 with SMTP id
 d9443c01a7336-231b6035614mr4519855ad.52.1747266077676; 
 Wed, 14 May 2025 16:41:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/12] qapi: expand docs for SEV commands
Date: Wed, 14 May 2025 16:40:58 -0700
Message-ID: <20250514234108.3746675-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 5d0ffb0164f..ae55e437a5f 100644
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


