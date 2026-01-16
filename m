Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986A1D47CDE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj91-0002y1-1P; Fri, 16 Jan 2026 07:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7h-00025X-PC
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7e-0004hm-7k
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-430f57cd471so1126216f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567212; x=1769172012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZT0TS9aI2AFJaPW+y/uDp38mdkz5ijoNDIMHw7RVXk=;
 b=ziP/WXWS5acBEyX8gTqAlL+iR+aoDUcob9qTyhSzun8YgBIG+XHeS4uPedltpAYPFo
 S+zIym+k7Gdo72HEYyhcQfE6aTAlr8UQrxs3qwd6CVJ9tDlacriBDZsBDBmiOtbdTN9A
 uwdOF4j2zy4bJrQjPV5jCok3r5Yz5R59tI7U9XtLx5e1rCQguB7vpGtwF84OQ8h3dSVA
 XeJmxJnKMIuIrL72vZUcSsbWkrAJr5kgX9JK9/iUFGNrGl8xXmeahYceWKhcL1+fgBuj
 HqQebaLpRzJIRtcz/wDqNj0tkLJ90YU2y+lNH0MJX6XEwWj9yTDUa5z8103zbm67L3Cr
 AK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567212; x=1769172012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZT0TS9aI2AFJaPW+y/uDp38mdkz5ijoNDIMHw7RVXk=;
 b=qyVNLq8Sv61orkphfu1Rd7rr5du0P1R8MhpnTQWj/i29LRvowt+4a5stYpJuo+ulun
 ybvu/jma8YFyMiA0a7yAPmpgOyw4u9AZsEwPmBIMoFvdZB4yvJL9l7lZoUEfK5SHkuT2
 /xZVSESMtNTBcEbHxd8+x+DpkpQhC1u+ZLtD4n0Ey1azdDdY5xVeFjgn/jXZfAe5ZaTk
 57P4U9RfxcVBG+SMT70NGAsKjeVks3NvtLTdSW/kxm32ddjp2cmBq5IBZ1KX5Go4oAjr
 R/lIfkaiuYPYAcSb9nmZWv4FiChJsiefd4jkVeRwff79d/C/bukxYtMgyaObKvDtbbwJ
 g2ow==
X-Gm-Message-State: AOJu0Yz9lwSM4MTse5b8nCOyMBBqerd66icj/4lmRxeU/vS2HZoBxKxa
 DNgNGNClcSLbU5/SlfpAfJNaJ2jSVSK+pXgptNtCl2mD5Y2ICQt/+3S9mkLDdbb8Be5g0Rrp0El
 OgGJ9
X-Gm-Gg: AY/fxX4PftVzqMZhFBna4j+H8eDwxhNuMIbeTUiJsztkiIWCOOzbW0J07MGOWdDjbXv
 hhtHo8owlatExMd4GYs4D7tWHZ1j3TuS8lstowjkkZ+7tbJaAbzjyGor75rgLXNiyx51QUNwIUU
 vVBkvBsMSfPNr9nrE1Kcxi/xEWkV2Zlzp7CA3XPElc+ruih8o8muZKr7E5/hZ5LwJoZuGzv+tTo
 C2LzvLggW6Vve6E1nYWliDzpb6uwtv0z5/SkPUVs7vkIZ8O7tvKzOfqjkBeOGm5E6WSlUJuwJY9
 5Gp36XnnagIAsbfqYF87IJvmPUL5FdM9A+xOtV3OSqmWuEvT4ponbCmsZTCJvVsjCBFKuMJaZvX
 nsqBgB4xkW5Az09a4UleIMf5v5msopF2082rpU5x3Rn+fGG6QYF01Xod0sd16E/Vp+DjQ/Q5UZv
 0i5esanFl6b9AhXS0gNX5v5+0WVp3eGjCU9vCOjvjFmqgVrxRr6ZpLuOuDUHb5zXgVtOLv1Ijjw
 uoZfh6zMsl+xeoTYqpBI2yVceTa7mMhoSwqx2+6sDbL63A9wZ7U3N9F
X-Received: by 2002:adf:f983:0:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-4356c8dd0d7mr2070379f8f.32.1768567212371; 
 Fri, 16 Jan 2026 04:40:12 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 5/6] scripts/clean-includes: Give the args in git commit
 messages
Date: Fri, 16 Jan 2026 12:40:04 +0000
Message-ID: <20260116124005.925382-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If clean-includes is creating a git commit for its changes,
currently it says only "created with scripts/clean-includes".
Add the command line arguments the user passed us, as useful
extra information.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index a45421d2ff..b16eec0a5c 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -42,6 +42,28 @@
 GIT=no
 DUPHEAD=no
 
+# Save the original arguments in case we want to put them in
+# a git commit message, quoted for the shell so that we handle
+# args with spaces/metacharacters correctly.
+# The quote_sh() function is the same one we use in configure.
+
+quote_sh() {
+    for arg in "$@"; do
+        printf "%s" "$arg" | sed "s,','\\\\'',g; s,.*,'&',"
+    done
+}
+
+quote_args() {
+    while [ $# -gt 0 ]; do
+        printf "%s" "$(quote_sh "$1")"
+        shift
+        if [ $# -gt 0 ]; then
+            printf " "
+        fi
+    done
+}
+
+QUOTEDARGS="$(quote_args "$@")"
 
 while true
 do
@@ -198,7 +220,8 @@ if [ "$GIT" = "yes" ]; then
     git commit --signoff -F - <<EOF
 $GITSUBJ: Clean up includes
 
-This commit was created with scripts/clean-includes.
+This commit was created with scripts/clean-includes:
+ ./scripts/clean-includes $QUOTEDARGS
 
 All .c should include qemu/osdep.h first.  The script performs three
 related cleanups:
-- 
2.47.3


