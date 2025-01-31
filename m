Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2839C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyqW-0007f9-7P; Fri, 31 Jan 2025 16:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1tdyqP-0007eS-P3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:46:35 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1tdyqN-0007Ws-VD
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:46:33 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso431690766b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738359988; x=1738964788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=66Bo2gEeNzLllo0jczJ1SMGFCw0a04TJcr0F/2HYI5s=;
 b=mVxtucuf7NRR93DQ93KE6YYoBnlpgom6sjYXOpEOk+1VLW75yd9ae8pvZgMp/O1KZD
 KBqCHpJKro2lPYO+0eWybQnH8+7iBngq77f5k0aQkhksOwUmZxgHl+zyAcZxMkIcmsSg
 aqVwib7+k9qijhluwVJP0tLkJQPR8472Q42MWasV+Zjyh4L/3RGjm9MxejcDAM2//rD7
 w53HwDdA52E59ZEfas+er9KZIqK4brTeQ2zwyGBp1UlqQu/J2+t6pIq6f2mPvjYxOEcd
 BZsu4SxeuTyQNaIKczzDG80HaDaooyMqKht+dxG+P5guE8gMuu/GezmZgnwH22/75zY5
 LKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738359988; x=1738964788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=66Bo2gEeNzLllo0jczJ1SMGFCw0a04TJcr0F/2HYI5s=;
 b=G2SEtEf7nayMzC8YC0RZEXDGG6jJax7XF6FD49i+XMuGu0vAE1tcT2V+7324WP2UN3
 t133xsjGE1t6e0/pNGdxXMiKziQLYLLi4fRJChYmMsnI8D3+ocK287Y94wdAeXgqPM71
 e7BvbQgllyisvYz3r+bMzSII5+7PAiiAMAiIIMpCAQmXc9iavyPNocUABKu4ZMf/l+ln
 YDMrZh8kV+CQtlwuOsyrpyMiRuyiazhuQ43/0t9PaUymMTXBzpFZWsikKzRDPkpjw4A+
 eCooXwHj+ugmfKDFu6qern1dZ0kHr+sKvJNmlPnt767IY5kRCMLMn5gfneU2QBmiJSBg
 up8A==
X-Gm-Message-State: AOJu0YztHEbuLkrTUEenpSl6iIDm9TcTPnwqBiXnkKG9vLZtWtu4tubG
 VKQmihEYx2Zl1DIFfPYgqSlvi7E5ATeYTdjNw54I0nMOiZ7SIpNDc8jp4hPz
X-Gm-Gg: ASbGnctP6IQ8bMTY2b22DMA1V1F2NjouBVOVSyJbFWrR5zY3dA12V0z7m8HJIx9fpqx
 zoV2MG6X8wUQowBTWzF5KpAGQY6c9oFselMsVp5MWNkWw9B+WCPhCDs4sfJddfsBeOEY1zZ+lmY
 P2HIjkC5q/6Gpy2VSueT+TqRplo8Zq+QDX5xYZtqSj2DB7ArvFbRtX3uXjslQKxeU3XmRTOpYVu
 cqNkaKiVpHRssDbF6bfHpM8oasxTe/168GirIISLrMiA6OM8vsItL/37WR3pxPXnShcV4/jlBVO
 kUsFHZyg2Yy1V9GpAqdNoDdarNcRf87rqQYXexmkfsCy5i0Pix03cvBu7Y8HBqtDTiyYNtSJbNd
 1La6RGdticw==
X-Google-Smtp-Source: AGHT+IHHeAip7CzkWDE7Lz/Aj8Czsh2z1RQ0uelORzqWc+5RrV4p7TZlhJ/bAEk1AXYWorEHSqguJQ==
X-Received: by 2002:a17:907:2ce3:b0:aa6:6a52:970 with SMTP id
 a640c23a62f3a-ab6cfcb3b92mr1456491966b.1.1738359987612; 
 Fri, 31 Jan 2025 13:46:27 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-077-179-165-240.77.179.pool.telefonica.de. [77.179.165.240])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7010f4d2asm145444166b.75.2025.01.31.13.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 13:46:27 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] target/sparc: fake UltraSPARC T1 PCR and PIC registers
Date: Fri, 31 Jan 2025 22:44:15 +0100
Message-ID: <20250131214528.117846-1-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=atar4qemu@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

fake access to
PCR Performance Control Register
and
PIC Performance Instrumentation Counter.

Ignore writes in privileged mode, and return 0 on reads.

This allows booting Tribblix, MilaX and v9os under Niagara target.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/insns.decode |  7 ++++++-
 target/sparc/translate.c  | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..504147563c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -96,7 +96,10 @@ CALL    01 i:s30
     RDTICK          10 rd:5  101000 00100 0 0000000000000
     RDPC            10 rd:5  101000 00101 0 0000000000000
     RDFPRS          10 rd:5  101000 00110 0 0000000000000
-    RDASR17         10 rd:5  101000 10001 0 0000000000000
+    {
+      RDASR17       10 rd:5  101000 10001 0 0000000000000
+      RDPIC         10 rd:5  101000 10001 0 0000000000000
+    }
     RDGSR           10 rd:5  101000 10011 0 0000000000000
     RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
@@ -114,6 +117,8 @@ CALL    01 i:s30
     WRCCR           10 00010 110000 ..... . .............  @n_r_ri
     WRASI           10 00011 110000 ..... . .............  @n_r_ri
     WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
+    WRPCR           10 10000 110000 01000 0 0000000000000
+    WRPIC           10 10001 110000 01000 0 0000000000000
     {
       WRGSR         10 10011 110000 ..... . .............  @n_r_ri
       WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e5c7351cb..285c9b0a59 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,15 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
+static TCGv do_rdpic(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_movi_tl(dst, 0UL);
+    return dst;
+}
+
+TRANS(RDPIC, HYPV, do_rd_special, true, a->rd, do_rdpic)
+
+
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdccr(dst, tcg_env);
@@ -3315,6 +3324,17 @@ static void do_wrfprs(DisasContext *dc, TCGv src)
 
 TRANS(WRFPRS, 64, do_wr_special, a, true, do_wrfprs)
 
+static bool do_priv_nop(DisasContext *dc, bool priv)
+{
+    if (!priv) {
+        return raise_priv(dc);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(WRPCR, HYPV, do_priv_nop, supervisor(dc))
+TRANS(WRPIC, HYPV, do_priv_nop, supervisor(dc))
+
 static void do_wrgsr(DisasContext *dc, TCGv src)
 {
     gen_trap_ifnofpu(dc);
-- 
2.43.5


