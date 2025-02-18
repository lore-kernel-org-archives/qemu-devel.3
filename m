Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43CAC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkV2G-00033q-V4; Tue, 18 Feb 2025 16:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2E-00032f-Ii
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2A-000335-RP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913696; bh=hEdGGrdRnyKcM0NWUuU9kjR/8KwYnsAxspFYskjaN3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZM6lnfK4B8qYV33BPavYbeZ4Ok/JALi4AFz4TL8hLKSQEq57zzncuvGxlJk6YkVN0
 Sraejzp1ZOcZgmG5GXkCPWHD1cPaCmA+YGs4IAujWknJBUL4d5kDHWiqlDYGZuSVNE
 gc4L8ZaAe8GtdpEKk6kYgfcXe0Icm62t6sKX8yuVEEEoXkJZc1TXSH3TzVYZDxDs0f
 Lu1zb+bugpS+TLy2uZUJ+PcuVyYW98d/hNFtIh44n2/2AODgrgnFwfwmAA0YFaDKPN
 0ZdHZxKZDZ0kMhmPolEimSLcWB7E4QnThjOxK5/xddgmHU4QIkxTGXnbqqVY3gi1+D
 FCLnJhm67KF3g==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 5178C3F22879
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:21:36 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id ThcbEjBnbYD7; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913694; bh=hEdGGrdRnyKcM0NWUuU9kjR/8KwYnsAxspFYskjaN3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MJSt5ORqY3ukYJWqkUsjCvT5dAnv3rLwlZFvw3YIZf1JT2etDza8VtZ+8PPVl3XmI
 hAQnMiO4z5UIpMmmRA7AMvfaxVnd5KRni25VIpGKuwU+pgK//ipeM1zL8HZwRn3dj0
 HMHK7Cm/8oaMn+nfD7h32tHzD8LOsQ1d0/6iq9I1UaurX0YMtYZYljVS33OsGGSA04
 q/YTlYIBzA8pLPlWzy9wWRXGOHvgo3NAApKFnOnV+YGFJErq9jGPdUbAPasgyi6awv
 Q9VLwwc/uFoknJTztTKd2Kb3nVXpw2OmMML2jeqJcTMWZz4GXNazS0RyuFa5YISu1X
 kWERFAAsL3RBQ==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id E155B3F20D3C;
 Tue, 18 Feb 2025 13:21:34 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id B79FE1E6007A; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 1/4] target/rx: Set exception vector base to 0xffffff80
Date: Tue, 18 Feb 2025 13:21:00 -0800
Message-ID: <20250218212103.2024039-2-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218212103.2024039-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The documentation says the vector is at 0xffffff80, instead of the
previous value of 0xffffffc0. That value must have been a bug because
the standard vector values (20, 21, 23, 25, 30) were all
past the end of the array.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/rx/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 80912e8dcb..55e2ae4a11 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -90,7 +90,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
         cpu_stl_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffffc0 + vec * 4);
+            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
         } else {
             env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
         }
-- 
2.47.2


