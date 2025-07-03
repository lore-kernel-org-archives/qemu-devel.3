Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B828DC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKSn-0000ul-AY; Thu, 03 Jul 2025 09:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSl-0000u3-AN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:55 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSf-0000iw-83
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so11826526a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751551127; x=1752155927; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O07bbkkqKS35tHr8MO8G+GvqnuZRF6z78OKIb4PLGf4=;
 b=o5oZxbDMbsSgAFkAJm4+cL4RZ3kB5s1BonCoPKDJmgmCR/qXO6kP3mG08UTTElW4gc
 7Bwt0jFWkQFxzJFQgIc/1L9z5T84wLrjSrgw82Z6vxE69dfNO5n5Ypxv4TVfkkzmBcXV
 Azv6bYrVF/D44G6zj/dHRaXGLGhaqYM8GLn2eh+RpNduXOSKEByUzanWiUxkjHNOuEYs
 zVIsdR9xb11ELFfJw08KWt5W/A+dYYAnzGd7zAJWvuEP/vA+jCY28YTctEgNRp/yoZoe
 +mz4tGLaFRG9G5UKqsyuLbEW9Nb6KZaGGppbqHr5CDT2r9WJ9CfDWMF0wHHKVfwMH1mj
 MFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551127; x=1752155927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O07bbkkqKS35tHr8MO8G+GvqnuZRF6z78OKIb4PLGf4=;
 b=Tx+niCFgcVlgBARAEch/fBRsh5OuI7bdEnChrCLZ/zPj797RdTo27Q0pICwKfTeXvr
 p+ivcIpgo1sXX2E2775qGR9zhOS/Jk5Zfvjyby03mm8pVIs3NaZ+MMOwOpSAUYL3aMfv
 8axnGOir9bt6G3qTJOlmPvM892TydZ/oduZ5fjr/2/3wEOLzcmtTw1fgYIAH5ZAQ6GM1
 ExTG/aWM5pdUf5HBPtSGfb/iIcsA574og+E1sr1zKkqKGbfvfQP5Qx1owOenf3LaRTYj
 BzWCrY6IfJs1Bv2FAdlHFsNA0KOKgrAghyCMyoiu1iVcqRYNNLu2SKr0kr6hk0zf4UMg
 oJMQ==
X-Gm-Message-State: AOJu0Yzn9j+c656CzZgQ8e9k6r/X0+nC5tw98tbMCGdixq9nMIM2hHwM
 Ehrlqb+PxkT3UtUP+MblHcWaeZgba7cE69OXFQ8DXRHJX0nqpxHTKVIKbtPMiizZsnY=
X-Gm-Gg: ASbGncuDgD/rgUfkhLZ02E0FH1g7on9wjrz1eOFJrIcoX1EaEw9DFxGM3gIIfw1X8oU
 ugkBCxCK9DlVEhXkrxudy0zn9sMW14M1/73Uj81jO571TZoVnI0adstdE6RXBE5p71sriMsXuTN
 lrCBycDzcD5Rh+NVULXH+XKfD2/TlP6e2Fze5zImWaZ5NMk8ZhcQ+smMFsdSiuHbNJULSM1+K4b
 SDmI6qCyE/RRDtUDVKOWBK/fgKphJYp3kBKefOnFup8aWQ9f2DlMiVlNRZDRLcF1qgh6/Vab+xQ
 SlnfvrjVW1B9BNju3e0JgAyzifHE5eDvNssVH9n9CjcERGFtclPpUEFWv1q4n2YKtrk6Awx6FyV
 nhHu0qauEbeZ/mh5GEZs3/RYoJx6p9cc=
X-Google-Smtp-Source: AGHT+IFINac6KJTtfWQZffSnEtlYgBwoR5EwnGdvVHCVgPij3iY5Pp2h6xJiUJoCtBqTFgwvZY44vg==
X-Received: by 2002:a17:907:7f24:b0:ae0:d66c:5968 with SMTP id
 a640c23a62f3a-ae3d886be2emr366015266b.46.1751551127118; 
 Thu, 03 Jul 2025 06:58:47 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353ca1ca6sm1279678966b.176.2025.07.03.06.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 06:58:46 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 16:58:12 +0300
Subject: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
In-Reply-To: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=NevvNxLKgIVDzO2wket28GXOp7d3QUgciZxG/+W4+YQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9ab3lUcDV2TW9sZEFoaFRoamRhS1ZLWDhMcStvCmdKMGR0eGluRWNzRHFIbldF
 VnVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhTWt3QUt
 DUkIzS2Nkd2YzNEowT1JCRC93Tk1YcnVHV2pPS3JZQmFHUEFkMDcyL0x6ek9VS3BBaDNlcjNWZg
 o2OVpvRkp0ZEJ5UG00RmUvekg4cTZUTEJKeVVLNjU5a0ViSEV1R2Y1UlVDMGRqRGFQbHNlOU84Y
 Vc5bGQ4bUN4Cmd2Z2p1OWJyQW9QZ2Zoa3gvZkdrVUtoQlJsZ1VSZjV3K2lhcU9teVcxRnV2NW15
 S0w5ckJEbGt5SFU1Wk1oMlkKVXJEQ1EzY0kwc2JzTUdTdjdSLy96am82TFNDMG4xYmg5TkdOejB
 BelVoMmxHL25LSU1zOU1ROHlzcTB4WTQyWAp0SVJnR2pBUm5wMnBFV3FzSEkyWE54RlkvS0MxT0
 9lT2hEalRTelhsTDJXRURoRXVxSXB4QjA5eUpLcy9pZ2hhCm0xenNOdHhGTjcxaENma21ESjdNQ
 U1LRlRmY2hjMWI4SEhkY2UzYmdrR29BR2VmRXdUNTBUaUg0SllDd0dlQkgKOGZnaUl2ekRSbCsz
 UnVVWllkRkNrdW5PclZjU0tTQ0xwVWlGNWt3elNHcFVEZ2dnc2JhMVVEcUpTR2ZOMWd3ZApQY0M
 2Zng4Q1ZkeEtKSGpSVVhOVG9GN0htajdLME9HUkVzVjV3WVk1L1FySmZFa3VwelFyanJyZE5EdU
 t5SFp6CldpKzJFOERWa1dubkdxc0ZFK2tOdFl2RVRtb0lZbTlEODZSWGxweFNORjBHNklZVTZ5e
 ko2RWJwRit3ODA5S24KMzB3d0htb2VlcW9LM2xkMlp0WXZNMmRzeG14VXVNNVRLNjN5V2FEcElO
 c3FoZ1BtVWN5KysvTEFPWTNaTUp5eApSa1QxSXMwTGVDU0hyVEt6TTF4Ymc1TEozSEw1Q2Z1U2x
 rQ0dNd1U5Q2hzdTg1eEpOUDBEZERiWG85NndhR0UxCjM3aGZaZz09Cj1xRkdoCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Convert MemTxResult defines into an enum. This will allow bindgen to
generate a bitflag using the enum variants as its domain of values.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/exec/memattrs.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 8db1d3046479c21a32928086ea8804a66a5d5ffa..dc99b456edb0d99eced6f6513c4e1c8013e84c3e 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -81,10 +81,11 @@ QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
  * of some kind. The memory subsystem will bitwise-OR together results
  * if it is synthesizing an operation from multiple smaller accesses.
  */
-#define MEMTX_OK 0
-#define MEMTX_ERROR             (1U << 0) /* device returned an error */
-#define MEMTX_DECODE_ERROR      (1U << 1) /* nothing at that address */
-#define MEMTX_ACCESS_ERROR      (1U << 2) /* access denied */
-typedef uint32_t MemTxResult;
+typedef enum MemTxResult {
+    MEMTX_OK           = 0,
+    MEMTX_ERROR        = (1U << 0), /* device returned an error */
+    MEMTX_DECODE_ERROR = (1U << 1), /* nothing at that address */
+    MEMTX_ACCESS_ERROR = (1U << 2), /* access denied */
+} MemTxResult;
 
 #endif

-- 
2.47.2


