Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188DEC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSMg-0004ts-Og; Thu, 16 Jan 2025 11:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLG-0003dM-1o
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL4-0001Kb-Pg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361c705434so7215395e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043400; x=1737648200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=MYLs6OQ/nMafsVqnR90My+j/uMCVYChB069uhO0iF2QUZOmqGGJpAKMASfwCdPNlyE
 9pY5pJvjgJhW1Ay2r3xrmYs2oWW3637fyVfZLx0Nfv9WWtHd8fl2szK+xNHOQ1W73Fs6
 eRdSZsZG+Yf58P2U2Ki/vV56G1av93mefIzmmhaWQ3fCRe95OpVVrDsYpTuALzZ0YkPP
 fMGUi9y+RC/Bs3ueXABKdedlavjdJvWiY+uwQRNe97A7QzfXzAhaXF9QsQTEPwO+hFrL
 2HD5xZYHohRweSY5exFvL6fmQRYZc9MmiuLnLAWdXrid4lEyyPwKtivCYXeWxl3iimAr
 w2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043400; x=1737648200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=kVsvGS9g5pZI9CT3+zGSQlFYGslZyAIIPnPrwiXtv1WcwdLiq0J2ZVDIJsQ69zzant
 sYCaoGTstGmRu/T4rlyiMnS7jZCbNfsZVMrsbupyqB382JmllNsaiysNYg7JXmDthNaY
 C/D99vzNHSWPmneyG9YXshcs6q8AgQu1rq9NRk/op4pIkjxmOfrBjP6Mf9CGKVRG3QGG
 0fKM7q+gBqbJhZyz6oCHyWiiRv1z1B9kqwX+8HajXAjSHUUW7G2PW7XLD7WkKCYeaXJL
 zmuFz2wvhU4BEyIKP0dlnVMVqS68i4mQT9w4NlBHlcYUmkFcfHIGzSuAssoXyFetXrIk
 XFZg==
X-Gm-Message-State: AOJu0YydZCpNx/B5kJ7Y/JrWaaHdQOtwksV7rQ0Xy5fWZIe7d73kUWrR
 YexWVESpI0DZNLEEHQBFOXyPhO96skGBkqGR3YXFI0R9KQ+DCC3kzJlKIxc9plc=
X-Gm-Gg: ASbGnctU9eq2qoCro2lQphjk6sWj5R5BlAN/wfjve81vfkd4JhYMtuxdeGUC8x9RvSi
 T3VI6mUf7MZgbAn93tIoThGLSR8rpb1t/o135T5qCDd3M59mzOnXyWzyEuTNxwqJkIHtT+6GQbo
 aZ09GZkrvKsIm1Y+HzhZXX6dYRC7mRsOkjQOQYsHIRZ0JLvXmxH7hJRvtIz2psrxMbg+DcB8qlW
 E4G01BoJDHTVuYkdx5b1e0Nw1eGPK5LamuAhu347S3Bzy0aukmaAl4=
X-Google-Smtp-Source: AGHT+IFBBDrPcDjbZD4R827AWZ3Zbp0TjIRzrWTOeQIqw49I+IIm2k0fADa4eh7wKCPYpb+wMd22SQ==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-436e26b9d45mr342166125e9.18.1737043400130; 
 Thu, 16 Jan 2025 08:03:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fc4sm63651915e9.27.2025.01.16.08.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8066D60853;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 21/37] configure: reenable plugins by default for 32-bit
 hosts
Date: Thu, 16 Jan 2025 16:02:50 +0000
Message-Id: <20250116160306.1709518-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

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


