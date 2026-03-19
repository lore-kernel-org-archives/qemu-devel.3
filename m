Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5661091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkf-0000lz-WE; Thu, 19 Mar 2026 19:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mke-0000la-HN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkc-0007db-TG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35a288a2c00so720038a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962760; x=1774567560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiG6bmN4hvSd4Ok8JNbYY1S2q/CsTpB05WZb49qcpBU=;
 b=Q0eFifhsq1uHp/3SBGDZh6CW+CCF65seXzTisfJyeyR+vu9OFzpCaCPY1/eY9NEk9u
 Fn8kU20Vtix4n4gq6a60NqMrni5FR5QLz90XpcMVJxwdzCiJfttM6E2YSBJ4ds9xLh0z
 8xsa3wVx2YxQxy0A0/V90QtE6Cq4TUSWkz+ACxWIeDc5JQeqBJwJjLfIfK56gkjP4rMf
 dzyXn41Olrw8CfHStL0xVMhIA+4S4IhDns/5GZx9hnsuMNKDg2hSvnG9Y/u3+MX934Jr
 SQHnChA3TMXYJ7ATwFLDQfEPrlouF6h7ywW3Ld0tvMaggBZxjdPcW8EsERcLaWX282kR
 9Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962760; x=1774567560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aiG6bmN4hvSd4Ok8JNbYY1S2q/CsTpB05WZb49qcpBU=;
 b=JPKi6q6kV2QRbXcaYISTNj+ufeF0d2aBFxkd/sR5mtM0hDzFl24LOL0JThWFSIdgME
 ESvSQ4QyZ1Vi7+qf5navH51nMngP74Nf7dM2NbcNAw3PeW/X11KAG0REPLrX5vjtoNGy
 jAk2l8Hhx/jaLI78zXV8BUYD1fVBlj5JMwLohkz849PJmY6RHCDpTmXeocx0vs1k1z8v
 Oa+laG+SSJbfo1ITgYSc02o5rYftYEqzKSTjvVAkYUhBbEl47Mi8c8orGGsgvmIdshXm
 HUN8h8MzOmQBWMvhf2BW5nY1JuzPdX0IY+z+uyCd73H3+p0gIhW5NP0/LxffcWjMP7DA
 aAiQ==
X-Gm-Message-State: AOJu0Yz7fcQIX0SuN+fLnYPdN+wki+ZixmJ0/RQQaudCBHhzK2HnGLnd
 vIXOxwXqbwarNYF2mtKOFA34KFFUnVlVgBMqZEok5lypc/ycYKuNboH5CoWHTg==
X-Gm-Gg: ATEYQzztW2QNN9KEX/OIMl6/k5q1kLJpd58V4o7wLunVuO0l2qAMNpijOKG6cDaiAEr
 JnGyGh4YYst6x0+RBrrPGmvmSHDsSirvHXdSs5js2or9yfV5Memrg68cxKkULSZzg8q1N3mFtex
 CrIAScXMBK7hmy0+ezHCbL0L911fttttIqOHs+AQjsPSKWCHZaDYhcpdMlBOIhJJ1eXvJNrpCt2
 EEBpuCRvQ8L6sM3evl4Q3vN8sZAqKWHe7ah0/eyDx75laIjbuxn5xUg+4oHXFm8/A+IQsOC8W5a
 yu1kyvZuPSOifkFqLf/GbyOQdOAChYaWGhraD5ASpd/BPFktoIA+fHxryKLuj0N6EMN7ATNQnVf
 lsGik5ltTUmde1sESPMrmJiFQHkZj6rCsiKNv4tO+uJQEOb0xwo23tJmLGIDa9x30K0SH6V37nE
 198Ojh8its8AL6AUC/Z3d7CsBo46IekQdzdwjNpWHp3w==
X-Received: by 2002:a17:903:4b47:b0:2b0:6e60:958e with SMTP id
 d9443c01a7336-2b0826c3fefmr7790975ad.7.1773962760363; 
 Thu, 19 Mar 2026 16:26:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/17] fpu: Fix repacking issues in the uncanonical step for
 E4M3 overflow
Date: Fri, 20 Mar 2026 09:25:12 +1000
Message-ID: <20260319232522.1867400-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

In the uncanonical step, the input FloatParts will be repacked to the
target FloatFmt. This commit fixes following issues after calling
uncanon_e4m3_overflow in the uncanon/uncanon_normal functions.

- Add the local exp update after calling uncanon_e4m3_overflow in the
  parts_uncanon_normal function.
- Add the fraction shift after calling uncanon_e4m3_overflow in the
  parts_uncanon function.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260226071817.1417875-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 fpu/softfloat-parts.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 61b07307bf..a738758aee 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -387,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             case float_expmax_e4m3:
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
+                    exp = p->exp;
                 }
                 break;
 
@@ -496,6 +497,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                 break;
             case float_expmax_e4m3:
                 partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
+                frac_shr(p, fmt->frac_shift);
                 break;
             case float_expmax_normal:
             default:
-- 
2.53.0


