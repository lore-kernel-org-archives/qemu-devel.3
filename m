Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BDDFC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4f-00063C-Mo; Fri, 13 Sep 2024 13:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4Z-0005ia-4R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4V-0005tJ-4z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cae102702so10876105e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248421; x=1726853221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUatFApg2Cs5Vc3/hwC8i7ZiRClvTT8CyVvcfUZaS0U=;
 b=SfV/SHA/A0qZKSWMRg0XKzti8Rm2VxvFPzywVgOTHzQPaDL+Or95UrfFUP+2888rrK
 vGOR8Indmq9N7+tC9rmmas0/pB2uHBXdwdhrsPgH7A9sEGGAtNmwC8SL6xhd3+gm5LBv
 WZQHnoyS6fVnAHilV6d+jhbSkU9Epb8tOPjsIb/ArnDF4IgGldoZde1AMh6LUN1nasX3
 zznNG7Lchfmt6iz8j77PREuV1TidVNGULdiGwBVN+G5sS0XDaXAU+caMEjIeeAZYogk0
 MKC8yQPMNRow26lSpd7qmVHv9WecdgrOrFmiR9ZK8vxU4dPSqw/A6kCkEr2uxtjoMHip
 8+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248421; x=1726853221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUatFApg2Cs5Vc3/hwC8i7ZiRClvTT8CyVvcfUZaS0U=;
 b=qsHK3dgbIc5IWLulWvpys6LgvK2rDTHCsYEZhaqxwOccAaptNT5Lxkwagb3D7YbAc3
 XKJKM3yt7UjHZ031buzxHjwwY+IcKLW10whSX7+0I3lTiyEj3mjtWZKJgzPCBJ+8MljL
 BC1KoCmoeSwX3vCixWOceW/YfR4yBh0Xkdhoav6B/L4bBWDrnQulkUoym/HES8BkpO8/
 87AdSOWkzN3vCFPS3Vsv+W3CF5Z8QJ7Rf79IuYM224q5HxtIhrk2UdqgAKUmWH4AUQ+d
 L134gjpumYqCgFFvW1nW8oxnMmFudm2MoXmqQJgwMp2qi+prWErIWb/+1FbhPgluQpjs
 H26g==
X-Gm-Message-State: AOJu0YwVv9kmq+nIDICyjTtIc6NG2tdUV+6xOzMcuV81ID0ecOgnz/2W
 8siZ/j3sJkrFGpxg7nDjrmNsWb7c41tTVEsDpzhan8ek2m0zr68VUl0IXd7YHvw=
X-Google-Smtp-Source: AGHT+IHKKyf5ejwCJKMPXA8BYeuUmTDQT/fT0817zZDcui5LC+sxij4NZUISFyk/FH2B8D1GwWhLig==
X-Received: by 2002:adf:cd8b:0:b0:374:b5fc:68df with SMTP id
 ffacd0b85a97d-378d61d4f96mr2116520f8f.4.1726248420508; 
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm7864030a12.57.2024.09.13.10.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 317965F8C3;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 01/17] deprecation: don't enable TCG plugins by default on 32
 bit hosts
Date: Fri, 13 Sep 2024 18:26:39 +0100
Message-Id: <20240913172655.173873-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
2.39.2


