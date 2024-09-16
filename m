Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D0C3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VP-000130-9P; Mon, 16 Sep 2024 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uz-0000Ay-Au
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uj-0005CQ-Ah
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c180d123so1664782f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476844; x=1727081644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tM22JfJ8MqQx0zkIxo3mmiSupSHk/2QTpOs0HmJJEsE=;
 b=zlKB8U6MqlJeUw3FP9eOZukFa0OQztheuViUCYqdULCsc3ISl3DeiIxKhIlzy25/PO
 LtpBvQQzkFZShs2HWiMAhYibdktdQmj4fK0wqAOshnJQQ5x3yjRgy94hHT91HFDlIeTu
 sm/Gvvi85/vuuaDeOqFsAznCrAHDeKFSui5Awf5Zl1picPfeWEksorKNN5y2edcdzsfr
 pI8sjjpre/6WzPUXXnaKAnBRlmqFtogPwFv99kAcJZeUMiM1ihgxkg7qji6CnZz0nX8j
 MVOxmLMNCtOTtSjl3nmGobWkroe5assSAlryNR9j2WNH8tWqsnAczhWSLQ2sCu0XpAhS
 X90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476844; x=1727081644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tM22JfJ8MqQx0zkIxo3mmiSupSHk/2QTpOs0HmJJEsE=;
 b=NyHOipQdbLjwTbgl61tvthAH6EkgsVZK/E/9sZTr8bRTVLA/LLxeAuBh8IzIAxyxn4
 lNaXaIQyKxNwiCl5vASYVZWEo9Rc7mJsS6ULeFrzwddGUjP6jPFhCbea1JuKdA0GvLSA
 7c4BNN3ELfzbaw3g3WhmmK8eWuP8ckLCNCdG+SZQo852SKTw5HUMpRFuWTeLhJemF3Qu
 i0R4PUt2rPzEIDLQ2VY77G7nj5J/ZspspeOF5howLEuKBaZM5NdoCHp71DgF4nsfs16l
 SqE+CZVgrAcAOlA/dHIjbG8Zj9LR7LsU7EOabeJ0jq3cOGvbtYbVfIgNT9DVIhUXNYaQ
 aK3w==
X-Gm-Message-State: AOJu0Yxuc6bFLIKvu8ZMFxkWyW8g3qEC2kCrStyhyyhYItTxjflvLeAK
 6QC0Axh4OpbMVxMKSsZbTvssf7Dt5/vlx5CF60+QiSlB35LC4/KlUE+RVNHCOKo=
X-Google-Smtp-Source: AGHT+IFLXJ+7V/1aaQoFam8TjRU/0MUzurvEQwqqJnRBJNRuxRXtksWyXaMEyQsLXdONHgHk3eQ2wg==
X-Received: by 2002:a5d:6da6:0:b0:374:cd96:f73 with SMTP id
 ffacd0b85a97d-378d61d51bcmr7590148f8f.3.1726476843593; 
 Mon, 16 Sep 2024 01:54:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e7feesm6566584f8f.29.2024.09.16.01.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 747B85F8F6;
 Mon, 16 Sep 2024 09:54:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/18] deprecation: don't enable TCG plugins by default
 with TCI
Date: Mon, 16 Sep 2024 09:53:44 +0100
Message-Id: <20240916085400.1046925-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The softmmu memory instrumentation test sees so many more accesses
than a normal translated host and its really not worth fixing up. Lets
deprecate this odd configuration and save on the CI cycles.

Message-Id: <20240910140733.4007719-13-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst |  8 ++++++++
 configure                 | 11 +++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f7c7c33d39..5aa2e35314 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -196,6 +196,14 @@ benefits from having plenty of host memory it seems reasonable to
 encourage users to use 64 bit builds of QEMU for analysis work
 whatever targets they are instrumenting.
 
+TCG Plugin support not enabled by default with TCI (since 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While the TCG interpreter can interpret the TCG ops used by plugins it
+is going to be so much slower it wouldn't make sense for any serious
+instrumentation. Due to implementation differences there will also be
+anomalies in things like memory instrumentation.
+
 System emulator CPUs
 --------------------
 
diff --git a/configure b/configure
index f376fa24b3..3778b61c40 100755
--- a/configure
+++ b/configure
@@ -629,6 +629,9 @@ meson_option_parse() {
     exit 1
   fi
 }
+has_meson_option() {
+    test "${meson_options#*"$1"}" != "$meson_options"
+}
 
 meson_add_machine_file() {
   if test "$cross_compile" = "yes"; then
@@ -1048,8 +1051,12 @@ if test "$static" = "yes" ; then
   plugins="no"
 fi
 if test "$plugins" != "no" && test $host_bits -eq 64; then
-  plugins=yes
-  subdirs="$subdirs contrib/plugins"
+    if has_meson_option "-Dtcg_interpreter=true"; then
+        plugins="no"
+    else
+        plugins=yes
+        subdirs="$subdirs contrib/plugins"
+    fi
 fi
 
 cat > $TMPC << EOF
-- 
2.39.5


