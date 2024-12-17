Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A539E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3v-0008LF-M5; Mon, 16 Dec 2024 20:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3h-0008IZ-Q5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:35 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3f-0004ze-Oh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:33 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1539770b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397649; x=1735002449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xW+LPUYaCaHyMzbWV59CTTMsUuCbv/1PDmcaQ3NGQk=;
 b=Vgqk60jOfLQ9tUw5G8eoC6AuFnp220QK3/an/P6h2A8H1KhcClobiNp7t6KOCpj2EN
 eAb+qDSwLX+KewxkdLiNmO9GFnwUeIJyN1mnjUxaAUX3tYnhSsIzr6qYyZih8DEP3FEa
 Hcx/4Zv1/WXSveT4ebd/kNHIXo/nnShK1bmV0+huQnIacttiLheUsl5uzv2qC1ixGVLT
 bpiMwFzaRp4GoTuSrX+eudyLt5nq0IdczJGv8cleD4aOE5cOi3seRBXFpca5EYo/+5+k
 ug4+SFb+3wVa9mJsYr188A4rvlrR/iOqdT0RipJbGr+0Qia+T8Mqas6HAjjkhetwgp/X
 gKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397649; x=1735002449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xW+LPUYaCaHyMzbWV59CTTMsUuCbv/1PDmcaQ3NGQk=;
 b=tKBzYAV7WZijz8Vee0rwszrPGx2kRs7dJsEGn+zy4joQc56k+81NlzM1dncAd6/q8L
 6+wQ3oqP2UqEaghf7sYt7AnvWlyFGu+kDcy4ckHyyt+1QACOXefGfWHqPXp/1FpSFoXL
 WylVQ+/VBLluNFmFPK9M72yaZtxisEWN0NWxZK4ywkMBwK5aAnLNAHH0VgrcSZumg3kV
 aod8Iovpi4IgJaEdE9hIf2yKE7MlqMCaWklCi0HLJCjdubfCP3Vjs457R8LRCtKT4lpv
 OY/o7/h4g3LWN2/1/y5Yl3aoYmlPTcWYHbDdgcKm6AF45a+dGbkHYwbfNcFtveRC4Fbu
 JZSg==
X-Gm-Message-State: AOJu0YyN4VAvI09bX5htUjK/nGgdn+i65rNRexq1kUHyke085xB+LFL2
 QkTZN5AYbdE0U4ft5AftubSM3zceKdbtKjn+G69eykiw5QJZy9ow5ft1ZzDrk6owRXbuGvoPs+w
 9pZU=
X-Gm-Gg: ASbGncuk1rgg0BowRCHIiwUH7ym7Fnl0OilTgUdS+HPtVNrazEQ08FG/w30VidLIsuX
 BOWZcl4O/zpN584iVHKUZRlW4SoP9j18ee4opYDjqK5kpwV4Z/hY6E0nZcxYXqHARGOGn2kX1Yb
 QtaUcqVZmblT/GMZl3oaioTx1VS0UQ+eiiupstMSH8IQHUsHcXf+I1ENVx2x3XprNj21E8uPJHc
 tonu3CUcPTx7KUoKWyRCdI5UOJ6KTzfZKIrVXKswvfuqgaI+o4GyNnGNa3abeLWtbWzhEqaqcMe
 xZPxwY228izdu+8=
X-Google-Smtp-Source: AGHT+IE3vppnMbpnhDV1YKBjofgA4Uz9lQ2xCyzGLQYVTD9SfYA2tWDwUmgDmwEuYoXcFOIDE1EK9g==
X-Received: by 2002:a17:902:e545:b0:216:7ee9:2212 with SMTP id
 d9443c01a7336-218929ca98cmr207827245ad.23.1734397649582; 
 Mon, 16 Dec 2024 17:07:29 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 13/13] configure: reenable plugins by default for 32-bit hosts
Date: Mon, 16 Dec 2024 17:07:07 -0800
Message-Id: <20241217010707.2557258-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/configure b/configure
index 18336376bff..02f1dd2311f 100755
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


