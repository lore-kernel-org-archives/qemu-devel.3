Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25266C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPG2-00025i-EI; Fri, 21 Aug 2026 09:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPG1-00024h-1e
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFz-0006Q3-0E
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so817684f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787318761; x=1787923561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2alkrNBhAO1wnw1fFIL9osRmaaFocWT88WNJqpH93Ps=;
 b=dI5mT2WJaWc0pvL1aQ19pOtZD8PGBqill/UXeK9aCohosTec78z+HlozxMNxAFZy5J
 8OgxuDchZ/ZImPkBUXydwy5Uuy0eJmqGuj+C5KaPFvW2t4D3i/WZ1SyzMd09IU+kd6FZ
 SIkLWgCMiHaj4inRcnj8xkTtk14TXjJhTg8hp8JFgFbK7eDawWsU3K+TA96akMJXxGu+
 3Sy2B/+jkX4rChz5wz1YsLBfTPzivoCfOPAho0r3MECpSWBKjzwmrCa/MCb3S5lMIfPa
 qniryt92XMxErqd2eutvSGjymhhGPCcqE75S/K5MvZ+RUpgalchN8D8OpSio7ULZtCaj
 zGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787318761; x=1787923561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2alkrNBhAO1wnw1fFIL9osRmaaFocWT88WNJqpH93Ps=;
 b=nXJszNLNKd22vzLn56qt/7CZDcFE2RNKflUK9QP7v2NHnOP+IRbP9ot6mG2QQQFn2g
 3/G629zoHzh7bGgqpEvSg+7TxD30H2igJYGGzt4hwog/6ERDZ7pGQAlxXusPB9IP1FB1
 cDkLZEKBmlZXGdMdbLprOPn+U6MPewv6vxg22ctmueJpCOMUC4FBg38v+LSk9r0UE723
 WeWXzksf2FPiqckdb/7ez21+M111X0rRCArxohBwCEx7F0Kthld3gbIp1rmdPiZMjePh
 vRx9WrIxwVEYrMY3p42TKRV9SzfEAVIOSa2ryosdKjCeQunju5foFWuj8P7DT5AQ7mw3
 3H7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwV8tdM0SCcGU7fxw1ot5fPEMs4uGL5d1yStpNs4eTrwp2po6E+BOvgonwQe8nDFQyC+Uz4YgWOmng@nongnu.org
X-Gm-Message-State: AFuF++lREGLeAIrEpw5CkYTqlfZQUgFLxhBa1c3pSmM0pwGf4RaGv+kV
 swM27+VlJfaC6SyYaN8hkL+zIfB+Nc026fbHhE94qj3BD4pM9qmIlzU9z3qaT7DIe1Bm17ePbyn
 NwAZcyaI=
X-Gm-Gg: AR+sD13EenPkZlzsg4BdudkdI9JLsYTH9+/IJZb3kdgkDLCV//Zyfa22NmKnqPF0sC8
 ZYyaRMOOIvahWPeVVH/kijm8b54CUf5p+K0WyYMFMchyqG1lyetGWSEOginH2v+PCwTw+ZEzD2S
 CS/ndjl2Qhx3RqnfpcRCRgR6fbhRQMQMX+B5IrMvQVNUFFhDPpwvaBm/my4IKt6bDzlQUNB3VH5
 DeuUQPIGWvL0zq6KKFo43lJkeL52y83ipJorRT73HKxEwk9eQLzAxrjA1xJXh5H36/CDMqaGd8Z
 KotPLl24+ArtGbFKxQhZpb8Y0lad7pOH2/kDJtnO371EqD0xUM7KMJyQ1vzPpCPzY9/rvGXa2BB
 ilBsVmWQLl/nN1aDU/hApmLnqYrZBOmTfJb6SYj/NeV7ZGE6mnvMLG8o1Vn3gCgXbvydxorbX7Y
 P3/z3R0nEVG74s6gJwuKZI12wSnXkhm2T602dy2D/YS5nMHHPbCA2LqjdngRsTs2d1qqt9Kb9Cn
 YtwBIDmuF2kfY98kpjJkrlfT7o3zZAXh/+N4TVO8QFQkQZ9lP30PYmTzc1uQGfo3hpxMrN8XzGw
 G1oT
X-Received: by 2002:a5d:64cd:0:b0:47f:51bc:efe2 with SMTP id
 ffacd0b85a97d-482c0b95d85mr10259274f8f.11.1787318761395; 
 Fri, 21 Aug 2026 06:26:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm18770327f8f.11.2026.08.21.06.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 06:26:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Make Thumb T1 hint space UNDEF before v6T2
Date: Fri, 21 Aug 2026 14:25:50 +0100
Message-ID: <20260821132550.168896-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821132550.168896-1-peter.maydell@linaro.org>
References: <20260821132550.168896-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The "hint space" is a region of the encoding space which is defined
to NOP if not specified as an architected instruction, so that future
instructions can be added there which fall back to NOPs on older
CPUs.  In the A32 encoding, this hint space was carved out of the MSR
(imm) insn by using the fact that a field_mask (bits [19:15]) of
0b0000 meant that an MSR (imm) would set no parts of the CPSR from
the immediate, so it was always NOP on existing CPUs.

For the T1 encoding, the hint space is in a range that used to UNDEF
in Armv5, and so the hint insns and the NOP region must all UNDEF
before v6T2.  Rather than putting this check in the trans functions
for each hint insn and for the NOP space (which is a lot of places,
and awkward since those trans functions are often shared with the A64
and A32 encodings), put in a decode line that covers the whole space
which we check before any of the hints and which will explicitly
UNDEF if necessary.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4208
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/t16.decode  |  3 +++
 target/arm/tcg/translate.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 9a8f89538ac..43cd36e949c 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -224,6 +224,9 @@ REVSH           1011 1010 11 ... ...            @rdm
 
 {
   {
+    # Before v6T2 this was not NOP space and must UNDEF
+    MAYBE_UNDEF_T1_HINT 1011 1111 ---- 0000
+
     YIELD       1011 1111 0001 0000
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 103e2fe7c73..e889c6c6136 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3339,6 +3339,24 @@ static bool trans_NOP(DisasContext *s, arg_NOP *a)
     return true;
 }
 
+static bool trans_MAYBE_UNDEF_T1_HINT(DisasContext *s,
+                                      arg_MAYBE_UNDEF_T1_HINT *a)
+{
+    /*
+     * The Thumb T1 encoding hint space was only defined starting
+     * in v6T2 for A-profile. For M-profile it always exists, even
+     * in v6M.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        /* Allow decode to fall through to the hint insns and NOP space */
+        return false;
+    }
+    /* On the earlier cores, we must UNDEF */
+    unallocated_encoding(s);
+    return true;
+}
+
 static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
 {
     uint32_t val = ror32(a->imm, a->rot * 2);
-- 
2.43.0


