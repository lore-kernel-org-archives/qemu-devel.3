Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59F0CD98F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AN-0005Za-QQ; Thu, 18 Jun 2026 00:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A6-0005VA-BC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A4-0005bm-E8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c6b3f71648so6651825ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756127; x=1782360927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfHcgqSQ36vYhDqHmgC8PrWZm4ZineJsZ74HvJVrPIM=;
 b=A9BXRNGtETvbCqvpIrA3waz2PlmFvJKCol548Je1VNOur3+GfuiAtvuGMPPOzuQddZ
 9viRHUKfFWm5hT9++qHzPbtODznH6lzHE5YSYES+T+JP0FJIt3FHhCiLAu8n8lz5Cfqn
 sH/W5HKuEPGrKsc78yfEMYbyOdwn6Sr3p2bUfR4+rLZkmqrqcEYGsT/pd00YO0bAWqO5
 U6n7kfiVeNRbzjkOGOyu/+DPlvyKq+JJU8oiJuq9sRzVMFvytVRrkQfHxFVRqm6NIHFW
 Qo3RqMWqiBHSvpw2FPYnsNlFbWJzYku2gYPm9AAt2/dJLElU/l139OnT7WGwoY5PvtmK
 w7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756127; x=1782360927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfHcgqSQ36vYhDqHmgC8PrWZm4ZineJsZ74HvJVrPIM=;
 b=p7yfFJoNnBjqCDOy+ZQHWxzuyp7/uSofm09Cz5mpWEtAfIFiDaHSgkkIR4INOsXLeH
 jQP9p88zIJ3c5L+ElmQmq1WV4Ayq7WT/jUJfcbDKyb7vKyCWauWGxOGR5SotuRIkJIdT
 qup1zkQWmTtZMuNnw4iHAl6eunXzowWaqOn7t1YuU/qcBWMCE2hn6zA6fMW/QvCy7+7E
 8qgYlk90iT+O2Llp+2+gUiram+tjJ8FhRZeQ5KJHgT42YkBlWFNRrzkIEK8DShYlR6ia
 x1+6+H0vCv+Nb2iwxadh1OMXjoIRcg7WjE8qDccG7E3G4kQFhwPgeUnRiYN/ro4LWUzt
 18WQ==
X-Gm-Message-State: AOJu0YzPZtHGpONei5f9BTKeDm40M2Tf9nsOR/CI2TTBM/QGNy0jXR1c
 CncL8gA+l3mBOmHGVH2t1RxqXbLpSE0WVYl33NovqmS6XFpxsQGyW96TIMAxS9pCBk4FHkVo8Sx
 i3a4J
X-Gm-Gg: AfdE7ck2ctcMyNwflxjEZCtYYXxA4a2gtsoBiH6X34Rilf93pXoQHxh48PpjGS8S4ck
 OvLnTbW7nTb+JeOxtmlwe0DAP7ZaQvJEUdTZf69fgtkT2g/BigUW1DEVcz8E5v9KYf3T5XoaTFW
 h6S5IdvFFRdj818PhQPQmp/7nZwEJnENAmfVwNSX7IHNu1lSe2VSIcB9fbed6VkDsr3oQOHARLh
 GBsDzJeGFCx4BHT9n9/jA3WYZmWAplWl8PoXb08hWPc41zK1B2UFo9pYvy4ftkBgvE0uGfq1X1q
 ckdSlM3wb7bQCDqAVVUY7KMuTHqyh/miSpvYmVRfNw2xTYO38oCfNgzD+YAUfsCVenmbptE6gSL
 V0fzelacNd8W7dKKmENIjY4e4joIJ/apGfBtwUnjmBpYMzIiTSqnPRQdLvmJxNS+GBopRLWbQjc
 xCRnfLsd25rAvHh1i4kloCMCHLtoWPJ+jXsTAM+ZHXSFlnGVNRpA==
X-Received: by 2002:a17:903:32d1:b0:2bf:2015:5b93 with SMTP id
 d9443c01a7336-2c6bc0b4c2cmr72800895ad.11.1781756126969; 
 Wed, 17 Jun 2026 21:15:26 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/10] target/arm: Implement FDOT (multiple and single vector)
Date: Wed, 17 Jun 2026 21:15:13 -0700
Message-ID: <20260618041517.573469-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 8 ++++++++
 target/arm/tcg/sme.decode      | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index cc85c6d6e0..8fea451089 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1170,6 +1170,14 @@ static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 TRANS_FEAT(FDOT_n1, aa64_sme2, do_fdot, a, false)
 TRANS_FEAT(FDOT_nn, aa64_sme2, do_fdot, a, true)
 
+static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fdot_sb);
+}
+
+TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
+
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 80ad674cf2..3c7caf8bdb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -449,6 +449,9 @@ FMLALL_n1_b     11000001 001 1 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
 FMLALL_n1_b     11000001 001 0 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=2
 FMLALL_n1_b     11000001 001 1 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=4
 
+FDOT_n1_sb      11000001 001 0 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=2
+FDOT_n1_sb      11000001 001 1 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
-- 
2.43.0


