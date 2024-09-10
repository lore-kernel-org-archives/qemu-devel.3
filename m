Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2475ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X4-0007z4-BB; Tue, 10 Sep 2024 10:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X2-0007sL-NH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:48 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wz-0006We-DB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:48 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53661a131b4so3723060e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977263; x=1726582063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b313DFQEs8B271qGHlfKxgFhU13Os4oo/NuzYy1RUc0=;
 b=bMN4RQwDrjOseBIGL0ppdfKoGAOQtpgLxsGZS/0Nv2mxme+/Qs8v0h1Qb4KecHwGxM
 oXMNW0gtDxk+Y386BX/r/cFfmkrv7wz9ilObAOTvZTuYt7KE/4SGt+fYWYdc5clPGKVi
 /h2gSoppokl5yqs8Tjb8PNuuGo6EG/RtftjU5hmSSrFp86x2PeEo0wTzyVNFc2a6mh7L
 bcJ6I9ZY4Zav8J/X8kokmRbCWD9XByNiHi8cXYTlvl5hJDwkQD2QwxYV+sCnrz4O/lqD
 QMUWQP3MYJDHy8fe4AtniC9p65f04jglA6s2wxiV9a1BPqvKCp9UrPOKrqqd1+aZjBBY
 l1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977263; x=1726582063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b313DFQEs8B271qGHlfKxgFhU13Os4oo/NuzYy1RUc0=;
 b=GIGNdFCGd5KNX7deNnkiDdXeYZlOUUAEtjFZs1wM1szJbqEzaOC1QXFA2gjebLP9SX
 JaRG8HCMlGys7cvB1yENiBUDECjbEx471h/9JuwxkldZvLKr+UTWPvCExoWtHt8X2mDz
 83lPDb+AMFceG7wqmZRgflJeNgTpMPMFzmVbbLAuEmepSYtUSoqxA8D0o0zBF12pNkle
 Z97cesWWkJx+gxflstvLZylHMGEN1xni2MprywBg2FQ2dGY4bLjblJVjWE6f6whiIbyi
 mNeyGXN7Unw7SliUQpBL4jFBFa6xynWZ1moNsO3cbgpbpYfQ2/UWezrNsoF1NmmHKZzp
 1eBw==
X-Gm-Message-State: AOJu0YycnKPhvNLtyAUFd5EGhpTWjpIo0wND1sMka0nYkT+s885XQxcz
 lvn1QZS+ebNfQRiAT7WY35DIvmWedBjpAPfUQFQnI7OJlAEFpvn4NdMUjJ7EozM=
X-Google-Smtp-Source: AGHT+IFwO8H6MQwQurzjS0eTgVG0M9Cu5OMs+G0LwZFRbZEmCxIeo0Cs7eE9m636G9ihGMN/RsqLdw==
X-Received: by 2002:a05:6512:398d:b0:533:4652:983a with SMTP id
 2adb3069b0e04-536587cda61mr8522331e87.35.1725977262997; 
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72748sm485424066b.117.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B972C5FA1C;
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
Subject: [PATCH 11/26] deprecation: don't enable TCG plugins by default on 32
 bit hosts
Date: Tue, 10 Sep 2024 15:07:18 +0100
Message-Id: <20240910140733.4007719-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

The existing plugins already liberally use host pointer stuffing for
passing user data which will fail when doing 64 bit guests on 32 bit
hosts. We should discourage this by officially deprecating support and
adding another nail to the 32 bit host coffin.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't manually set based on CPU type, use __SIZEOF_POINTER__
---
 docs/about/deprecated.rst | 11 +++++++++++
 configure                 | 21 ++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f03786..f7c7c33d39 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -184,6 +184,17 @@ be an effective use of its limited resources, and thus intends to discontinue
 it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
+TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While it is still possible to enable TCG plugin support for 32-bit
+hosts there are a number of potential pitfalls when instrumenting
+64-bit guests. The plugin APIs typically pass most addresses as
+uint64_t but practices like encoding that address in a host pointer
+for passing as user-data will lose data. As most software analysis
+benefits from having plenty of host memory it seems reasonable to
+encourage users to use 64 bit builds of QEMU for analysis work
+whatever targets they are instrumenting.
 
 System emulator CPUs
 --------------------
diff --git a/configure b/configure
index 40186d865e..14581c1b9a 100755
--- a/configure
+++ b/configure
@@ -516,6 +516,25 @@ case "$cpu" in
     ;;
 esac
 
+# Now we have our CPU_CFLAGS we can check if we are targeting a 32 or
+# 64 bit host.
+
+check_64bit_host() {
+cat > $TMPC <<EOF
+#if __SIZEOF_POINTER__ != 8
+#error not 64 bit system
+#endif
+int main(void) { return 0; }
+EOF
+  compile_object "$1"
+}
+
+if check_64bit_host "$CPU_CFLAGS"; then
+    host_bits=64
+else
+    host_bits=32
+fi
+
 if test -n "$host_arch" && {
     ! test -d "$source_path/linux-user/include/host/$host_arch" ||
     ! test -d "$source_path/common-user/host/$host_arch"; }; then
@@ -1028,7 +1047,7 @@ if test "$static" = "yes" ; then
   fi
   plugins="no"
 fi
-if test "$plugins" != "no"; then
+if test "$plugins" != "no" && test $host_bits -eq 64; then
   plugins=yes
   subdirs="$subdirs contrib/plugins"
 fi
-- 
2.39.2


