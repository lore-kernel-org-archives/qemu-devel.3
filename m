Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A393EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1XC-0000Cd-Qj; Tue, 10 Sep 2024 10:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X8-0008GK-1X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:54 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X4-0006Yz-Nb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so111545566b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977268; x=1726582068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4TlBd0JeT03UVw9sn8pYyZukJ9dto1YgZC+m8kda2c=;
 b=tcNsxONHHaJUkykjmJjolSw+9LCt8rt5KLYyP6+JoDLQZ9gPou3nN2oD87a2ot52ye
 BOwQuN2+tmrH4lPuZN0WdrDzypdOe3dNmm4M33rcP56w73hFATTAcwF7c/vOLzShBr5K
 /fl8UbiV7Nr+Bg6axe1gNFzDZjcXFXZ4J3GCjwzyE1fKPbuwyujscTJjNmSmNSl9uzs8
 cRf4ypA23fo+5XVtQjU/TztuHopzGhT0zP6gahR2Ta8JUfQ8YJRIOhkuJnhuSNN+IN3x
 5b4ErdgwGVQFug0DzhJNht0NM9GwENqBBT8SMon/JrZn+IcgAZWopNv5IPE7lMrnw8Zn
 wnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977268; x=1726582068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4TlBd0JeT03UVw9sn8pYyZukJ9dto1YgZC+m8kda2c=;
 b=JL+tMtsFxP/G4BtpTM0+IQ1bUc8ZxhnhbRXxcKCimsroEat3erCA5QJIzfLrR0QVO9
 rH9d2EzucZfjJEahbIzz+JQrwuhkNbC30vu8V/VfyOm+5ntCawFsFHY3cyJBJbuP5KZ4
 FFmqCsxhfNKtO/L8DdlrRskRJkfyvEMH14HGPMEG9uSQsW/sMjeqpnIC3yC2YF88qIZR
 sJQ1DBE0UMR/QqTB+1czlhJvBqwaoSop0nh1M1AixYGns7rcKwgOLa7oiME94NE+ewfz
 rE1r6ktC+gVh6DBOrKsy3jdk9MRusBoMXSsZ7rMS1jDKcgwaygyCaWsW+6XprCtQcO1B
 uFdA==
X-Gm-Message-State: AOJu0YzQVYShwpkzJZpw/aVgz5ApISphuGlAj3KLEYoR7HvCW72ZJyyQ
 qPGiUFBjX2KV3wFZ4lMrAVo1+0XAfUpZ7h+3GjWaAIb9NPT+j+LuVOUrQseFCK4=
X-Google-Smtp-Source: AGHT+IErJNJJoE7feFTNDc27hviErpxt+F5KAygxg+YXUgSVnGAwixrEWB2e79CWF6NltR/8bD4giQ==
X-Received: by 2002:a17:907:7208:b0:a8d:2c3e:7ed3 with SMTP id
 a640c23a62f3a-a8ffab9752amr88481766b.35.1725977268040; 
 Tue, 10 Sep 2024 07:07:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cf6a88sm483205466b.182.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D55C862330;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 12/26] deprecation: don't enable TCG plugins by default with
 TCI
Date: Tue, 10 Sep 2024 15:07:19 +0100
Message-Id: <20240910140733.4007719-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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
index 14581c1b9a..1bda6b3a3b 100755
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
2.39.2


