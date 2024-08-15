Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnE-0003vQ-0w; Thu, 15 Aug 2024 10:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmw-00035D-AZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmu-0000Bv-Du
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:18 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso138617766b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733355; x=1724338155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1sXjiCdRpLULlo+gpPa91iiSnoCu2OdnjrYlFXOa+Q=;
 b=lOG23gpLo3XMNzOGnFpSxr7y3AtiipuXJA/VCXYAlNy1ognpMMvvowoeWdxLnzh/QU
 OIDv7rm2RtxNThlRWr/rxriz9I5SUB3T1SzriEVbf3opSiS3yEPHcdTzPQJD1DjkoaRG
 jH0v8+xeT7S0QoOirR0Jn9SkOffXTn6jOUcOCZ89G81dr912BOSmkYtfraFNGURuFpgF
 a1Q+lfdAGXEjHrsIueOqtZRt2Va85NnNk9CdD/XmePzZ8sBoEpk2/3EVm92eWFnL+C3s
 Qg4RnxA5vbZK7G/rMF2waKgD4BKhXpT/PO9YgkLbphqHVX71juvJHd3PKlwpGdFJwGk3
 +NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733355; x=1724338155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1sXjiCdRpLULlo+gpPa91iiSnoCu2OdnjrYlFXOa+Q=;
 b=skOgIYPHOC2B/s9UzrgbfZakg0AuA6JFh2jtXtoX0fUsomxHN8rY2gUFqCaxfa3luE
 hnxAekESEchj8CdDh2kQW2aeVgWM2mUtPXdfRz1N8906eQ0/3InDxMNUp8r16CtyZMUi
 +wBYOZ7Ywz6KuG2e666DvG9PS8cQ47vDgjPR3XDmSW1YOA8epkCkdAc3+osWKreFYoZJ
 y00M/YcYgcwr3JY+ALciZWYr7GHqPhsNeuWnvPG3RGCLTrmFUQe5znmqY0JngV6/UF/+
 eLZWPXlG48JWWKY92T1S3/TteZupxO9swIbT3i05rVz60xWwmZP4/M+lTOvYvBTwVkLp
 0jYA==
X-Gm-Message-State: AOJu0YxRpyzJOazoagy9unlBhO5AfiHHaGuqF3nZPMLs7HQC51v2gTmZ
 PBGp/uVyzOrArSX9ZgPLrJjwhbXyABO34RKwxFhsd7qCf+hJprG9xR3gGpCJE9/AXWi+YQEt6or
 d
X-Google-Smtp-Source: AGHT+IEsmQLMXx9oeD3lJpdbjKJvrhZBcNa9m49AgbitPTO/k69Jif7UXN+viErMAKelyBUJj0hByQ==
X-Received: by 2002:a17:907:9448:b0:a80:f893:51bb with SMTP id
 a640c23a62f3a-a83670bf179mr374746266b.68.1723733354494; 
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838394723asm114024166b.171.2024.08.15.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16B0A5F920;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/21] configure: Avoid use of param. expansion when using
 gdb_version
Date: Thu, 15 Aug 2024 15:48:54 +0100
Message-Id: <20240815144911.1931487-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

$gdb_version is now used in more than one conditional case and its usage
in such cases may increase in the future. Therefore, avoid using shell
parameter expansion when using it by setting gdb_version to its final
form.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-5-alex.bennee@linaro.org>

diff --git a/configure b/configure
index a3aa257fd3..97de85d710 100755
--- a/configure
+++ b/configure
@@ -1103,8 +1103,10 @@ fi
 # gdb test
 
 if test -n "$gdb_bin"; then
-    gdb_version=$($gdb_bin --version | head -n 1)
-    if version_ge ${gdb_version##* } 9.1; then
+    gdb_version_string=$($gdb_bin --version | head -n 1)
+    # Extract last field in the version string
+    gdb_version=${gdb_version_string##* }
+    if version_ge $gdb_version 9.1; then
         gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
@@ -1673,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


