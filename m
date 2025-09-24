Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnD-0007n9-IA; Wed, 24 Sep 2025 15:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ulu-0006v0-4P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uju-0007oY-IN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f7da24397so185652b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740473; x=1759345273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRAc5xsl1m+VhgQiShnpQM6Hj9dAAWKFHFsWJQupR0Q=;
 b=v1/bSwxCL4P4iXSu9edc8YRmYKzVbR+EbkeC8hvjjW7Z9JjjEaP2Gpjz+RZzYIRCsd
 9CPGwD3OODSCEyvD16pMmGMlqj/M9ERNCBB3U+2SEpjDI9H+UbBT/U+tCIEGbb38h26V
 p13r9GDBlnvjm4Pho7LDVVpnI2I42UwFKP3otyjsgVRn1o0kLdGpfHRvNfOHaABkvarF
 z0TPwGyz/7/SrvgRzNaWVUhtyTZsj5GQXF9CLcKnVelNEmKclRFtvd3AtH25K7UtQ3C3
 7AmZDUX784SHEBeqDC9ihQjt6EOs+RRUV5/qzCcuCIhaqTTVS7OZLeFV6qv1g24JsdgS
 Qf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740473; x=1759345273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRAc5xsl1m+VhgQiShnpQM6Hj9dAAWKFHFsWJQupR0Q=;
 b=dP5mfTeZzJKI7L7/JQgCl0OJXYpKd4wR+ExtIggOFRLwQbIp0oSO4cdPcB3j1WydIi
 4Dj8zClcdGJGFgGi5hUt76x7GdgQts10K6s6jDllT+WVsn9Tt3UhOg8NhZemU0mxstz8
 BH90Y5wZIotVNNWFD0cAmuGy+RujHUrYqalEHdSpM4PZGgl+G0dcTx3RTA5BVEbWqaGM
 u7vYl1z20V7KeQwjQJN7S//xpNpQB2d4KocplExvRvshbZiCDIsTf77/fcsj5EW2ZpDm
 cTa2IPHZHvBnj5JGTxqix/eq9lma+eU2H88w3Jhu/CORzwXqGTPJkOizK+adR0+OX/wD
 ibeQ==
X-Gm-Message-State: AOJu0YxvB22TN9h+k17hu9gVvNelASQn3RL47MWtyfi4DDcrmRZRZ6/+
 sg1zoOOWbf2MP98JDBMjOHED0i426Q6zRjaEP1Yuq0eejydDlZHYajzc2k2hhjQXJ+CwG1gQP40
 1h5QN
X-Gm-Gg: ASbGncsNcUBzq7r1KK6/gi09V5vWHg3pF/sijUMF0UX+0AtbAPMNMABxN7PjyLTDOOx
 30FV1y6IKRoFF570cCxdxFX8cxt9DBfLlY+UmyxhEQJgjAWGQJiRN+zfUE39eBuoD3I9qOerUAa
 Y2j39aOp4VBuP2c2dhT3eXqZpRAcC7D6tWNX79FiiA3MR+fCTNHGoGUwHyVCjlwqpUAbezdrLCQ
 t/rfORGtr85rubFli6zzcMLtaR520RZVho+E+V7KzUbktXk9FRMW/3LkONNQSQsQMq5pfkaLC1U
 QgFOIJR/ON9gA+J8mCjH70BxEwnAa3zVYxgFnjU4NgyyWBRVVq+uPm2AzSOn0Gf2f3qruOG4IcO
 H/qC2xdBWbTDhUKcLYeSt3LI3jj5hnbI6wAgyHXo=
X-Google-Smtp-Source: AGHT+IESJOoC5kPn5/kpVKuA5LDdy4i5FEvEW9gZ723lmIA3QwKVU5kRGbe6+4kR5Z1n170PE47ZQA==
X-Received: by 2002:a17:90b:1b4b:b0:32e:dd8c:dd18 with SMTP id
 98e67ed59e1d1-3342a2f9055mr779194a91.17.1758740472354; 
 Wed, 24 Sep 2025 12:01:12 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 07/32] target/sparc: Loosen decode of RDY for v7
Date: Wed, 24 Sep 2025 12:00:40 -0700
Message-ID: <20250924190106.7089-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Bits [18:0] are not decoded with v7, and for v8 unused values
of rs1 simply produce undefined results.

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c  | 14 ++------------
 target/sparc/insns.decode | 12 ++++++++++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ece393fffc..cfdd9c1ce4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2863,18 +2863,8 @@ static TCGv do_rdy(DisasContext *dc, TCGv dst)
     return cpu_y;
 }
 
-static bool trans_RDY(DisasContext *dc, arg_RDY *a)
-{
-    /*
-     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
-     * 32-bit cpus like sparcv7, which ignores the rs1 field.
-     * This matches after all other ASR, so Leon3 Asr17 is handled first.
-     */
-    if (avail_64(dc) && a->rs1 != 0) {
-        return false;
-    }
-    return do_rd_special(dc, true, a->rd, do_rdy);
-}
+TRANS(RDY_v7, 32, do_rd_special, true, a->rd, do_rdy)
+TRANS(RDY_v9, 64, do_rd_special, true, a->rd, do_rdy)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b1b85e9c2..74848996ae 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -91,6 +91,7 @@ CALL    01 i:s30
     STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
+    RDY_v9          10 rd:5  101000 00000 0 0000000000000
     RDCCR           10 rd:5  101000 00010 0 0000000000000
     RDASI           10 rd:5  101000 00011 0 0000000000000
     RDTICK          10 rd:5  101000 00100 0 0000000000000
@@ -118,8 +119,15 @@ CALL    01 i:s30
   # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
   STBAR_v8          10 ----- 101000 01111 - -------------
 
-  # Before v8, all rs1 accepted; otherwise rs1==0.
-  RDY               10 rd:5  101000 rs1:5 0 0000000000000
+  # For v7, bits [18:0] are ignored.
+  # For v8, bits [18:14], aka rs1, are repurposed and rs1 = 0 is RDY,
+  # and other values are RDASR.  However, the v8 manual explicitly
+  # says that rs1 in 1..14 yield undefined results and do not cause
+  # an illegal instruction trap, and rs1 in 16..31 are available for
+  # implementation specific usage.
+  # Implement not causing an illegal instruction trap for v8 by
+  # continuing to interpret unused values per v7, i.e. as RDY.
+  RDY_v7            10 rd:5  101000 ----- - -------------
 }
 
 {
-- 
2.43.0


