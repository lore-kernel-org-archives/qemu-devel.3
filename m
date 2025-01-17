Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA8EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdI-0001CB-25; Fri, 17 Jan 2025 08:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-00011R-Fq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:13 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcx-0002G0-9N
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:13 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso372172966b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121390; x=1737726190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gjr3Ms2PP/dAfR8/IA8j7EUzgU3XB+6Gxoy5+eUAxmk=;
 b=K86Q94B8yXzrZsUNrYh0pJfwzEo+56/B1QLiR1c3CIgqtnuplJ8NXHtVp0JZfxczmh
 q+gYVDtVe6Xj4ak9fLu2gzB2ChR9aKP6pjY6p5cOx0xmnDkJWmUrE2s5mFqeTLWRp5Wb
 +jumwiUfzot87f9aemM9mcq4Bo8maQQedKRnh2+StBm9BEE38BvTEYuGp31mG6voHfwV
 ayOcs9EZyHqQlHS7FuOafeqONCNXlfswN+P///d80lCIahqOuCxkK5VY/lp9lph1f1w4
 ioYPcKCPtP3slJ0+q3lGQsqyfe8QxYXIEw+FmBD5os+UyGWYcNM0P33iZ77ssTxZrWdo
 +wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121390; x=1737726190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gjr3Ms2PP/dAfR8/IA8j7EUzgU3XB+6Gxoy5+eUAxmk=;
 b=sH9nrPyh00y43LxvImlT3nfV+CiJUh3Rr3C7AgAlMfgIXE8X7UL3teWUfrF3bqJpsl
 ayMoCSbUrhuEyEGrDeb9qiApEXiJu1fNaulq6VGpojyuqRyhrbubGBNgyDao8X2vqA2D
 h5rNzXtiG+FvQSpWve9iPv2lwACBbKnthal7+FU0LLml3aUXHny3+x6oJaty2hw1XSZB
 ruerj8m0cMhKvmvpFb3rd9eKblUlp8lldDwqlfWdL2JmA9Mj8H6Xb8f0o3t7Au/BWz9u
 2g9gs4q3haU8DLsLGUPcJRKACsJvS8vhsyE5G2RHJW0Wa41CtijVk71R0ZgSYbblG3YG
 +1gg==
X-Gm-Message-State: AOJu0YwAWWghd1sW2ZQUsIlYVqyJYl2Oa2FAnPHVM3V9Zy2hsGuDq8cA
 zv4o64+oj8QOVHJeqHpBApyNPDSGdCmwo0bBSlQxNQE4nNVOacIhLb+UE2PMMnY=
X-Gm-Gg: ASbGncvNRBz+dkBDHStH0D8r9P8b1819f9C0c+7GlrTstkLKUZtjEZoYmhFLXAZYxSh
 GyIXI4yvI3M0+HcB9CB0FGdz7WegrF+sl4/ZkNAjxaoxP5+Ptij1fjiPG8/ych04oUHXO7HDLdJ
 ByKv0MdDhIy4hHE+v+kxfbEaczBMXsCKhNPu7tvgkKxfHLBd9QagrGPcw+ED4oScn3HGu4On162
 q2xsrY+vn5FIFyw9+QkV2z+Y+fd8/ukGGwspvBkY22gRAYEHOxwmLQ=
X-Google-Smtp-Source: AGHT+IE0Z2gv854DsPXL9X88yDyprZKNV9pq2uTQ4ePLvMkhQJwzrLeRkG7LilvDSInqJCYp5/hOfQ==
X-Received: by 2002:a17:907:706:b0:aa6:5201:7ae3 with SMTP id
 a640c23a62f3a-ab38b3b23e1mr291248366b.40.1737121389795; 
 Fri, 17 Jan 2025 05:43:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce20fasm174368966b.66.2025.01.17.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC2FD608D2;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 21/37] configure: reenable plugins by default for 32-bit hosts
Date: Fri, 17 Jan 2025 13:42:40 +0000
Message-Id: <20250117134256.2079356-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-22-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 18336376bf..02f1dd2311 100755
--- a/configure
+++ b/configure
@@ -528,25 +528,6 @@ case "$cpu" in
     ;;
 esac
 
-# Now we have our CPU_CFLAGS we can check if we are targeting a 32 or
-# 64 bit host.
-
-check_64bit_host() {
-cat > $TMPC <<EOF
-#if __SIZEOF_POINTER__ != 8
-#error not 64 bit system
-#endif
-int main(void) { return 0; }
-EOF
-  compile_object "$1"
-}
-
-if check_64bit_host "$CPU_CFLAGS"; then
-    host_bits=64
-else
-    host_bits=32
-fi
-
 if test -n "$host_arch" && {
     ! test -d "$source_path/linux-user/include/host/$host_arch" ||
     ! test -d "$source_path/common-user/host/$host_arch"; }; then
@@ -1072,7 +1053,7 @@ if test "$static" = "yes" ; then
   fi
   plugins="no"
 fi
-if test "$plugins" != "no" && test $host_bits -eq 64; then
+if test "$plugins" != "no"; then
     if has_meson_option "-Dtcg_interpreter=true"; then
         plugins="no"
     else
-- 
2.39.5


