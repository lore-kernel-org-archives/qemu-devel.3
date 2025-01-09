Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197BDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVw60-0007Od-Sg; Thu, 09 Jan 2025 12:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVw5x-0007Nf-Ob
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:13:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVw5w-0007uc-4G
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:13:21 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so1359212a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442798; x=1737047598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=CrujFPDnEWkNJpTTSV4jemIJhKKXB6wfNHSk9nqnBEWoJQUhdTLJVBgS2BuxqdF/Vq
 /4oHa1SyRfWSpvSnXOaIg/KbQ2gTH3EzdG64p5Od+Tm46mMQ5sje/XFIDZUO9cNN/GTq
 aGfeRLKPkVuQlyFtkTac6m2TytmQDvyMhSs6UK62xX5D/frPiLAR3cZKZ6uYX3MUgEPp
 LGtf74IB92sVxofvo+guDz4nVYG1s8AVHkrvhGcmkddomLcasP5FhS0uts2GMnJ0qEz7
 SS8r2Hlwlqit4UhFNlw+lcOiUjNuqK54FnJ1G3p6H6IBLWey2ZS1juuOYhdU75YvKciC
 Fm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442798; x=1737047598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=Q5yLIE0TkrQj38oLXW6uTnlSE3u6Otj/fWmaO871ac9fPYnSshahKvGZvEPGxriv75
 Kgb3P1xHDNlqg+UAIU/Odc3sXAkwrW2sugm9oEc1rxIWwKrTjHwADGz2M4NvJEGkZoo2
 szr72vI+h24R5cyKa0ckSNFfuRaKah6OtwJ1ZyIYoWXvqaACJtjDF8IW0jJ98WYzxExI
 NfmpRDr5SjlTx3BHX/P6vceVirLoaM9tY+6I9CwvFZNXBjkWEzLq9X/8JTEGd1EmhPdI
 yRUQXN660gesQpS/yQ7z7F8CwrXU2u8FjGSID/yaC1WkbHIOT5oLrWFLdwGz2rUohM0f
 ZKGQ==
X-Gm-Message-State: AOJu0YxOBvJJhGl8shTZiXIzYX5cmRihYELIcasiTd+6uzUxyaul5a2X
 6/EcZp8BzEU0I1uu8GP3Y37VO2qVDVQwBZf+t2e3kFbFo7KEfi21Uk9bFO8ZJUo=
X-Gm-Gg: ASbGncsL0K+gxCsjMFF1rsX9tZvjbwfJI+Hk68Y8MYPhuD1UoUyLCpoCjpNwhHf3hD8
 eS8+/rT/hBEBGFDJtDpynVEHRMo1o/Nn9jR4P7FwgCzDhBxP4LUiscnry9+ZmQyP1xBLTmGCFyG
 2/i9/REteECAPCPwPylcNYjV3EKtudF3H87mhY1Xm+2RUsQBPHz/u+pLMemwBdqPtoeoj8+ibxJ
 3M3ZcPxsia8U67CPjlnoKPEYrOSdvsyoj6pK/uexIZb1Ne7ZR3Ndvk=
X-Google-Smtp-Source: AGHT+IHpbiY0r3nkQ+skfaqAM5wW7/4WC5RAwxA+7WzJonWKOIuFIF414Vc1GA0Z7tT24kq89mEFRg==
X-Received: by 2002:a17:906:f5a8:b0:aa6:8676:3b3b with SMTP id
 a640c23a62f3a-ab2ab749f32mr612531066b.30.1736442798363; 
 Thu, 09 Jan 2025 09:13:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dacd7sm89705266b.70.2025.01.09.09.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:13:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C318A6144E;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 21/22] configure: reenable plugins by default for 32-bit hosts
Date: Thu,  9 Jan 2025 17:06:18 +0000
Message-Id: <20250109170619.2271193-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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


