Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C1EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VA-0000fK-U1; Mon, 16 Sep 2024 04:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uy-00009K-3I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uj-0005By-5Y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso41104685e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476842; x=1727081642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsHJWK1avixuzVqxRi8ie9rxVBQXKR8UstAkKvtNg2M=;
 b=OQx88je5W4pjInBUcMHZZk/2DmslbXfXcqup2uuqLAnJzrqmBhNKHyHnQbhjV8tRvc
 JmumjdhwGoCq9j57Yr7uctIV9SIkzk2zwORXdLSIYNZdTYJ9bEd8ILTR5L8keWbmBAY9
 sNwSLF7V43eEZ9hx8Pk7/cB1kTHgII47/6mZgkvmi0knhz5UPvHom1qqYduly++A2LST
 5nVaoBgE2ohgyKWSaEim8/6HitNR2z46gusHhcI+SAtdk9K569Jp/VliTacvoTpxTXKA
 Rg9wKwxFZ4pqgpg2tBP40E28GoOFzsFE4vAuE6im4eZnHfBx/8Xpc4C0H+r54iJ84uR/
 KFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476842; x=1727081642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsHJWK1avixuzVqxRi8ie9rxVBQXKR8UstAkKvtNg2M=;
 b=gHO/snrnfUrr+7W1VPU36EDm4Vq0VhdmauFRZAVYMFh42hboK4iauZ7yGSLoXNuCC/
 PpmEQ3fcBhZaE8unviDM6xtf1B2p8zlOgrCzRdNdaeho3gTdIS/zZIqV00lKc9DNRRPq
 Yr/pCBCMGpvKA7gm2h+YDx9jgWyhZaZOr8f4JhmD7hzLa+Ftf6AOSquT6gdYmLHFRA1d
 1HxXXxYE02aFx1ixdDul4gLF9nyugkJuRXNxBZoOOF4/u8/RnlPK4o+W0c/diOveahPQ
 6ShoBn2MP9YJs2UBUOv6Cw3TQoOpPTFhpA/neY+e+7w5bmI+qXj8YN+I4H2y/8c/5JRn
 wl/g==
X-Gm-Message-State: AOJu0Yx6D3GnZmp7uaqIU9FdXJnfkw4mhY6wjT4OBFRYdYVKA2vjene7
 Vp9im3DYInqd5h91Ackroxnax+xszRRAKW1jNOSr8bdEruLU8YfKVZgIUgwMhwQ=
X-Google-Smtp-Source: AGHT+IFNivt/OyI9olUKHVvAxnBI+LOquP/cWDiGl0t4mVcwedg1MQNm7mWOBMkETbSwIMUcuY3Leg==
X-Received: by 2002:a05:600c:1d1a:b0:42c:b45d:4a7b with SMTP id
 5b1f17b1804b1-42cdb56ade7mr120462295e9.25.1726476841926; 
 Mon, 16 Sep 2024 01:54:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22e733bsm70272705e9.22.2024.09.16.01.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C2B55F8F2;
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
Subject: [PATCH v2 01/18] deprecation: don't enable TCG plugins by default on
 32 bit hosts
Date: Mon, 16 Sep 2024 09:53:43 +0100
Message-Id: <20240916085400.1046925-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

The existing plugins already liberally use host pointer stuffing for
passing user data which will fail when doing 64 bit guests on 32 bit
hosts. We should discourage this by officially deprecating support and
adding another nail to the 32 bit host coffin.

Message-Id: <20240910140733.4007719-12-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 7f6eb6b331..f376fa24b3 100755
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
2.39.5


