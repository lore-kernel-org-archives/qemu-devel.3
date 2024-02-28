Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511AEC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQKc-0008Kb-SD; Wed, 28 Feb 2024 15:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKT-0008JM-PI
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:15:01 -0500
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKG-00042b-89
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:15:01 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 553367618C9
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:45 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 96991761612
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:44 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709151284; a=rsa-sha256;
 cv=pass;
 b=DRDRtOzSGm51A9j9xLJCP3Dz0G202TKYRROP/YSZga6imP/mDl8Jx8MF/3xzzLJ/1qmIC9
 vTEEV6hfU7OPdCiGz9BA3Rftk8YjueS2r78AjLPQyLFN5XZJ6y85EYkoGbn6cO/RpVYtFb
 IpznkysQd/qekkVOz4wncaa7Fy/FAccfgAv5u9Ka+YLs9JQVpgYj9qIUm6qAZBaPXkvHQC
 UBZFzh4idQJfBM9Lc+KNQs0uIvMCG7BwWlWxs40IFycFdMFfl+Fz7+x5+FSIFxW9PF0kYR
 C+JYNJR047Bu+kY+lIoBvujd7XSre8zUeCJby1ZkwODD7KZCAVUvy7kpbkgqWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709151284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=M6peY1jFuDHnQiDlFtFqQy92UFHBGjRAatq+vL9PT70=;
 b=0hSdSAJIhVm+WcfDAiGskjFi1p9BFezdOf70qrCwq1pwWVZUfpwqRcLP2QlCzV3N/+VYwI
 Srg4HAjyjjq0kL0qrM/7OtmXUwEJtMYHnoJX4/cClEdifCH9i9fiC0EZSWsR/dcB/1gpwx
 wp9LMirscqQusbiT4vY9xfmgYorpcuOKZTj+pg166gsFOynKEonZ/6cm/KL7MXBqDJJ4NX
 tEWLFTiqHZBaypPjvGt/KdM2/uwXk+u2OUj9ChZJQ6Xq1xzJJ/eQQj215YuRJADwPXMbEv
 WB/V6848Y+JK5+kUA2KV3YLL/EspgvwE79/v1Ho/bewcd8TTSjTSmP4C/IIk9w==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-zt5xj;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Exultant-Spot: 23d525697bc9aef4_1709151285115_3841980850
X-MC-Loop-Signature: 1709151285115:3089150733
X-MC-Ingress-Time: 1709151285115
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.52.242 (trex/6.9.2); Wed, 28 Feb 2024 20:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709151259; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=pfT9lXHwnlK+oMMTZluAF8/dR51APZLlB8cA6Bp2zQ1LQ/K5uA9CguNn5z9cIf7Oy9SYn8OkblOA5
 RHOHe6Bi8PX+zIjblmPOow+jBQUrEcIekk2qoZqCkI0zxunWLHYB57XGxms4aB5QP8YcyLrScjW8Ex
 JQky4P88YylmmEu+HKDzJCwXLFAJRir866SDV1fLQyliqIdCItVWXy9WzyIVryNj5GeQqrS/WnHQaB
 12VOuyMaLBylYkvx0lSutmJESl47Z05vtSp4isk6pnsWD+pPo0u/RnCYF+HDIFrqhacwETdcDyuVb7
 H1MI0JXWtsem4udvnwLTdxFsQv6DaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=M6peY1jFuDHnQiDlFtFqQy92UFHBGjRAatq+vL9PT70=;
 b=VigtCmJhajFJz6oftuSv2uik6QttQ1M+4wR5sBA8S+04D4Cm748q80b2mChl65dx4rwsAwkHtizXr
 qnb0FM3QK6yId97ZfArD4PchRG6yah+rF5CcVONilAOoy2kVRxwUgwe6hsyID46xlnthTBoUhx10Wb
 j47GO5kHP/LmWqfMxIQjtv73uRNgIuCcrBgQSvV01gDJBKPfVKFmSYBFs8hdUxg259m/SYl+K+CrWn
 gfSCzdGwmg7Q9wco7txva/6JggIihgsOdR9hULN+UE4MkU38azPJomr+4ZKJYo08WChIzBmCIlXgaJ
 694h7RGFFWZMr/gJ25lFGdXsFay476w==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=NUAYNP4s; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=M6peY1jFuDHnQiDlFtFqQy92UFHBGjRAatq+vL9PT70=;
 b=aySMMOH38G8mXyRmkuj3n0p6LycpZmpvdwyaIm0Fen+Fs7Y4YxVjyOQlB9oM1AZOBzCUqvImH7KMu
 E87TXvr0+OdufNZ2p4OlZDmMJAhDXMfBD1vQgdQsr6m+bHdepwV60pCQvq10Oq1Ra00a5Veg37W9gZ
 Uao9aj9axcKxtwQQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=M6peY1jFuDHnQiDlFtFqQy92UFHBGjRAatq+vL9PT70=;
 b=g75t2ICe0WIPCqqlkC4HjszlvJ599aGghDrQGjbDNkilo6YsnDQeWZafV4phvQWH0XN8px6znOBaA
 s+4G9D54FvfHwvEq2/VUXoc52WnLtuvYz/DtyM14sHO/dIuj4p7wJTUFaQPFZt41SwqgjPFinvjaPC
 N53sVwcCpmeD7CehoRF9OJvKKY6uDYk0kFvDhgExCNEoeXMqbuKsBfFyLFI5+4X5AktgUPm99VoEiy
 eisq3dP38FJWFcveXSDx37fIf8rynWRjXZzC9kn/Z4Jb5WdxEYqgHcFc96l5l2E3opWwhWEIbXDDzq
 mNdJIZMJPBgBUzZdooG7N8296x4Q4Og==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f2dc8941-d675-11ee-af94-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f2dc8941-d675-11ee-af94-eda7e384987e;
 Wed, 28 Feb 2024 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M6peY1jFuDHnQiDlFtFqQy92UFHBGjRAatq+vL9PT70=; b=NUAYNP4sMImJTQ6PYtLD15ALdz
 GWurLnDZ47EC5OTysUD0nqVcePHMTvo0Pfd3PbtTPj/z+y+/BwIE0PyKf2LsA7n1zAS8B2ezkdd8i
 83KceYoHMQlHD+MWKeeSGP4NR1vzpwKB/Fz4rDaiEi+texxQGS/qZMQFemEXUZVe0XpK7YD9AWCMV
 Gl927O20x9440J5jzpOkHt6CPBY6aSdOjcvlXkyzutEx+ZERHYnl2OYf72A16Qyw51H6d30neJ4P/
 gno9RamuKv9bzOPzbdpcmzpgH3PEEng8qjBWsTsRuVBLfr7dNOnF+cG84Q3rGzc4NJuqrru/FAbkA
 75esJpJw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQK8-000Dka-1e;
 Wed, 28 Feb 2024 21:14:40 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/3] Revert "target/hppa: Drop attempted gdbstub support for
 hppa64"
Date: Wed, 28 Feb 2024 21:14:31 +0100
Message-ID: <20240228201434.1515893-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228201434.1515893-1-svens@stackframe.org>
References: <20240228201434.1515893-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Despite commit e207b4aa718e ("target/hppa: Drop attempted gdbstub
support for hppa64") saying that hppa-linux-gdb doesn't support 64 bit
mode via remote protocol, it is actually working with a small add-on
patch which enables gdb to guess the size from the g protocol:

$ hppa64-linux-gnu-gdb ~/seabios-hppa/out-64/hppa-firmware64.img
[..]
Reading symbols from /home/svens/seabios-hppa/out-64/hppa-firmware64.img...
(gdb) target remote :1234
Remote debugging using :1234
warning: remote target does not support file transfer, attempting to access files from local filesystem.
warning: Unable to find dynamic linker breakpoint function.
GDB will be unable to debug shared library initializers
and track explicitly loaded dynamic code.
startup () at src/parisc/head.S:144
144		rsm	PSW_I, %r0	/* disable local irqs */
(gdb)

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/gdbstub.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 4a965b38d7..48a514384f 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,16 +21,11 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
-/*
- * GDB 15 only supports PA1.0 via the remote protocol, and ignores
- * any provided xml.  Which means that any attempt to provide more
- * data results in "Remote 'g' packet reply is too long".
- */
-
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val;
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ureg val;
 
     switch (n) {
     case 0:
@@ -144,13 +139,24 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         break;
     }
 
-    return gdb_get_reg32(mem_buf, val);
+    if (TARGET_REGISTER_BITS == 64) {
+        return gdb_get_reg64(mem_buf, val);
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
 }
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val = ldl_p(mem_buf);
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ureg val;
+
+    if (TARGET_REGISTER_BITS == 64) {
+        val = ldq_p(mem_buf);
+    } else {
+        val = ldl_p(mem_buf);
+    }
 
     switch (n) {
     case 0:
@@ -160,7 +166,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gr[n] = val;
         break;
     case 32:
-        env->cr[CR_SAR] = val & (hppa_is_pa20(env) ? 63 : 31);
+        env->cr[CR_SAR] = val;
         break;
     case 33:
         env->iaoq_f = val;
@@ -272,5 +278,5 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     }
-    return 4;
+    return sizeof(target_ureg);
 }
-- 
2.43.2


