Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4AD74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIoN-0007wv-Rw; Fri, 23 Jan 2026 10:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInJ-000732-Ov
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInI-000347-7a
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:53 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so2028193f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180991; x=1769785791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gs7ODs1UnR7WI5J2KyYg/zU1R/LCdmQqHDFDVqt5Yp0=;
 b=EFAhuKBY0WYsd9OOts51jcqf4NPifzzC15I4vwPrRX9p6N+8dU/6HJQM5Pzpedsucf
 FdkYjo8Omyg11InSC0eZDMv7D+2OrjH0qz9y72LxB62ipEnkbOaAPGx6VBu+Okf962UI
 fMqik4YVcpOUrru3iVbSFINvHsyNPnvTRKoN1HYZLYijfv3gOzGxP9/WE0fksJCt5FSn
 vSyb9JYWhLFUZgtwZrM+dtxCsRCiq6WfRusg1N0BLfvW6QLWa53hb1tB+Dmmhfs6Se7k
 C04kMxqq+ASoJxbhqTGXKpjzj2Q65qEWGFuq9piITfJlX9aASgiTWdB44ezwR+w95YVA
 XL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180991; x=1769785791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gs7ODs1UnR7WI5J2KyYg/zU1R/LCdmQqHDFDVqt5Yp0=;
 b=JAs4e2NZxHnY7vZ9aHI/6Kz/G83olUMOz88Qm0xroWKi30IeN10RMa508Q3fnBcg7Q
 Z5hBaYZ4y14SpYAUjniyYQ6RmJJYkUvTN8FQkR25tQwQg7ISUXviJc495GU3Hlgb8mHC
 DxfjdUELpec9Nhzc7lHZbHg+kHXKWWjryGx0WgHBu6PCEAqbMAp/f0M1pb52TZvNQTF5
 XYvUPAaPksr1uC0lcLSG4UqlSiA/idmengR8QuN1RUEt6YlExkQFO5J+ufPljuMY6nUn
 NqDj8R9SCg/8oNqohcgGU16dbp7PKh663U9lm4Jp++zzDZV+PGKF6VEzuTxqQC5CUArJ
 08KA==
X-Gm-Message-State: AOJu0Yx8Dx690lnUujvhbsQJmqcNlw13JdNnHG+oLYL0s0Wd24UPf897
 0X95Sxg41iLUHmocsXsyhUcl35KW+JBAjzj8bJWPzrISRJfXJWJA096lIt+HC/S2tAvhJYBLGPj
 lfqfypOs=
X-Gm-Gg: AZuq6aItjVhvB9eCBdowPZjGomOdEgbh0MV4nD/oVXx1QUh5iju8eHft9KjPMwV9hj+
 UO67+ub5gJRwNjgqYzImD0xissH745tQMze6s6XJhpuujobJjxSl3bkHpv6GRMOWIkezi1PR5Fh
 +u8vrF0AJyNhdSoAHCVliMRWr9Hl0yFsJOVHu6uI9wWaKyOkI6s5fwVJok/PgV9XfGuLayF+vtw
 MQMsJ8if9ap74wT/6PCsVQT263cR9vlJIp7sGJQHKoUoAp1Wr4Wq4MTVeMRTv2ax0MdNxxvJ9u3
 fD2Hw3wx8OBKKFEjJG9zJ2zkXUUylUvuxxtg3M0+VHM//vh7nnl/YI9NwDWtbunXokJnFFhwK34
 ay3nnG6ojF83MJs0p5TPFtzeq36pOhCO3IDpiwRdPfkJHs+fp0ZMBB+kBOI5t7g0skvJWDGmHlA
 Se7tXdE8lSRzB5Z27GeMRe7nbvsjEmxk2X9m0caHu5GWqgJBPBDvjH
X-Received: by 2002:a05:6000:2404:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-435b161ffa3mr4872275f8f.59.1769180990654; 
 Fri, 23 Jan 2026 07:09:50 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/22] scripts/clean-includes: Give the args in git commit
 messages
Date: Fri, 23 Jan 2026 15:09:27 +0000
Message-ID: <20260123150941.1877768-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20260116124005.925382-6-peter.maydell@linaro.org
---
 scripts/clean-includes | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index a45421d2ff..064e532037 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -42,6 +42,26 @@
 GIT=no
 DUPHEAD=no
 
+# Save the original arguments in case we want to put them in
+# a git commit message, quoted for the shell so that we handle
+# args with spaces/metacharacters correctly.
+# The quote_sh() function is the same one we use in configure.
+
+quote_sh() {
+    printf "%s" "$1" | sed "s,','\\\\'',g; s,.*,'&',"
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
@@ -198,7 +218,8 @@ if [ "$GIT" = "yes" ]; then
     git commit --signoff -F - <<EOF
 $GITSUBJ: Clean up includes
 
-This commit was created with scripts/clean-includes.
+This commit was created with scripts/clean-includes:
+ ./scripts/clean-includes $QUOTEDARGS
 
 All .c should include qemu/osdep.h first.  The script performs three
 related cleanups:
-- 
2.47.3


