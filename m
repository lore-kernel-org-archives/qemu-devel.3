Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A1AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIea-0000Ax-I4; Mon, 13 Jul 2026 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Sm-Rc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeG-00018Q-3J
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493f140ca8eso20758975e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956764; x=1784561564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLAxkDoYmmtjAx4obGT3sDZ/SgJ7OVZp4P5X+krvfFw=;
 b=gBaVa3sQ7Nhf8AaKUaQd2wf5TLzA4NmG9u/exKjLR3gIKiz8vC//BmK2zzrW2JzRgv
 5sSAuX31KW0ABtiJ/oFOZXQisw0K+vgKVI07dDMm1aLi1MvrmGr8PhYsJgQyUTrGMTs5
 9T2kv4WoMfI471MlZ7T77Z7DcqP8RSS6ypRhlwvcVK3hUbJdDAXNSbwKnYdozqMlTual
 DSB7hehvcekDoDpAqS4TEQNXunouLc6XWfEMTWbk0TGp5iPkhkeoIqZYgGTWpHAqWLLV
 zrEb6BwEuDdGxcbkxlAXDwizLX2gV+QGjxdNYutm4S/jsYq1W6lnMVy7M8x4XLc4Z6XW
 ezYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956764; x=1784561564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sLAxkDoYmmtjAx4obGT3sDZ/SgJ7OVZp4P5X+krvfFw=;
 b=JUtSXw2PNJIiSSJFJfFheXHe0YaW+R3BLTm5cc8NQnC8O5Ml6EZggFCVIhBFCy43+l
 VH+kKCQ+eiZW1HW76kcUO+OxxWphBqyoEIdtJMP6edzFBObpvqAPhBg0mbQZgoeoQs2o
 /HvPJwQeHXKeJbg4qEYQcbfsr3Jur+TkbT8gACu0eNFyMND1OwjcEUd3VGZq6/DB1NOk
 hseeZlznpbYwffhUZ//v1f2ThTrW4oMKzNxjdmIjnvJGti1o+gR8pT6fIxP+f00SX4Qt
 IWl46pXqMaaKt1I7tuIuUsEESSXygKRAuqC6BVBsU5sGKKwF4Jh1Pz+q23aRsCxbVRIN
 8ecg==
X-Gm-Message-State: AOJu0Yxhp5BpFBWjOIgyXFazXqiEJ4Gd8Y/Wkw6Z7MMrBsJ6sDpaKiPG
 B4xLujavNQZQyIaEBOlkz9vzhYy2C2IP5MeyvVHbM25GIdlAMd4G0zV2iM9LpIOPaOYWPPhSpje
 8q7JDsuODMA==
X-Gm-Gg: AfdE7ckUbzh5EAi4iY0OyN/DePLL7uqJi555sfcfCfFxGF2RS0mKhDG/RKpcqqwnTT9
 DwMp8PyzEtaxi2pNrgexPtCekQRXlXlDVKYMoCVy0kz/j/BMJ8RWEu+kSkn0qnqqJXxIZHYhVo4
 WxaoowweUo72M447PGjR3oVinbmfdJCzjh1jOgfWCpRt8XjDTqrV/HBt0O7FP6UFg4aPen7t8oc
 2+28B83E8n8VZCfa+bretCo1XQdkYTkZJ8EXIUwy1cLfJ2VoPoeRwRXGbxvJzcF+3Jso6byv9De
 yXY5LM63bXBEdSGfQt91oy2ClrcFBbzTIdbSyzYKIxURmOfMSC9azBEblE0rTxzorpAl7nXPoLC
 2VPSx40xuw3ibe47lHRsVShKHYrh+tmIeyKakwIdI8AFytdEfFRKks1TpNwv6x5CW7YWG7lYSPa
 AMmhJ6jBVyjDrnjibai+Gfr0ZGN4TRfjhmYvV+SXeLr0XEB0Sz4z5kSPfBLlwHeB4znh9+xZxsW
 28pfDJ7EYK7lPBEu1C7faSyVQyci9x6
X-Received: by 2002:a05:600c:8718:b0:493:c1a1:68f0 with SMTP id
 5b1f17b1804b1-493f881f0f1mr92509095e9.20.1783956764439; 
 Mon, 13 Jul 2026 08:32:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] docs/system: add big and little endian features names
Date: Mon, 13 Jul 2026 16:32:17 +0100
Message-ID: <20260713153233.3391818-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We've always supported these features but they have official feature
names in the Arm ARM now so we should declare them for completeness.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index fb8d263db49..d19b6c04429 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -31,6 +31,8 @@ the following architecture extensions:
 - FEAT_BBML1 (Translation table break-before-make level 1)
 - FEAT_BBML2 (Translation table break-before-make level 2)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
+- FEAT_BigEnd (Support for big-endian at EL1 and above)
+- FEAT_BigEndEL0 (Support for big-endian at EL0)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
 - FEAT_CHK (Check Feature Status)
@@ -103,6 +105,8 @@ the following architecture extensions:
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_JSCVT (JavaScript conversion instructions)
+- FEAT_LittleEnd (Support for little-endian at EL1 and above)
+- FEAT_LittleEndEL0 (Support for little-endian at EL0)
 - FEAT_LOR (Limited ordering regions)
 - FEAT_LPA (Large Physical Address space)
 - FEAT_LPA2 (Large Physical and virtual Address space v2)
-- 
2.43.0


