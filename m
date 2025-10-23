Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF99DCCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjj-0004vc-64; Thu, 23 Oct 2025 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjh-0004tt-C4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjf-0005ay-LE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-427084a641aso677559f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231374; x=1761836174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vJBIux6dYQ51Htvje7MqSD4Q3H/yZoxJqquoVf9AWbs=;
 b=fJ4G7qlhgfWmlxOyryIyTVkcpN32BK6bJfOwhhoftdP45o3d7+eR4j/cuXCZ/pENFb
 aMXiG1Eb1VppMZJCJhta/gmO0stWfBptLkwlRWLEHJBADLrvDrG7mDD4i46HbjP90o28
 D8mhuCEEdf8oRP2P4nAs7I71tu2hmQx1qnASmKq25gMX/SGahpqpc2O4f5n26TMOA8C+
 wA86ILwDAfjMHWE13ctz1qS2xJ/VnpseK/CFBFtewrH+zHFUWSZpbzBk8UrgTbY/2blb
 h8VD+h1hseItjcBfw5bX7Hjnb65RXlUInF3jz21EctSbSyKHr85KBQd0b5ACvSDxkngd
 KkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231374; x=1761836174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJBIux6dYQ51Htvje7MqSD4Q3H/yZoxJqquoVf9AWbs=;
 b=CW+sTQ9i/0mntImX7uTUVIr/GbmyPZHIs2MmphLG18M2Ej/IRLpYCG0b86whIKg61m
 9qBppcGyxyfDoy6AEnZLw1RipYpat3R8e4jIjmBgJoh5vjxh9Onr/PXwb2WFVMxqT5rJ
 iI7HvS/+FWe9DLH5poT1Q9WDoE1aC61oQwcfQu49J7K87UQ/VE/Qa/aIEU+JXLHG7SM2
 xI7vZahlP+HafpKj4ipFWu7Cj187Zfb9jLRqAl0J9wXq7U08fVJ81Buc87MMKKMIDJqw
 NdQB7aMbSIp5yGvlExaN/3EEYU5kdbQGn27z5lFSmRrK4Sv4NPPbFRlLeq7Oo5CIp7ep
 rrOw==
X-Gm-Message-State: AOJu0YzOGXtSCe7DxhoBvZlhZffyTKZVreNqTHgmtXLAEORhEZCx3Kvt
 /f87UtTnu7ve2v2o4e5O7dpR+KBusWYpDIXTvt0LilU7Wm3pG1Acv1mCEwqqQjDROCoSx8FBMYy
 XFr8G
X-Gm-Gg: ASbGncsR5yGeNcf99GtE0xmv9Y9KHJsT8E2Sq/+UAZN/FB5DcHWgp401soBPCvke5Z4
 d1/ub1WVANBYd3lmHNc1AZZ9naeswG2jvFYmnSbvh/55qdkrwE9CF/8AiDtw4o6Npxh9Rm+FORI
 ZstTsX22bLaG01QLrGB8akA3xosEglF8hOeHXUs75GZGuSZyGqku0mbbbdoQIMQr/EUR4Z1oBHJ
 vJuANvcaYDp5jrV2MNvx4SQKJIcXao/hzf/U8+OucTF7nTeGSkYPJ+x/Qyf+9fKAeRuc3hHKUtF
 SPhlf7gcePxMcHqvnPj2FqxOrOGp0pzkArBIMymEoFS9P8CtS9BTVvh2dGaxx1VmdCl8TTvUo9S
 JO4ANGxqH4lT/k4NxGzQTDGu9D++O3iMgki7NfOroyJvVcF3SwXzDVGfKJyH/NGSt2eU/0x6DHE
 KJKXNIOtUClRm3o0cv
X-Google-Smtp-Source: AGHT+IFQ9rNOXoYp/Zn6dDuqjTIVW/oKLixVd0oVvLVNmL8zjR3xffzav24oa0OiEsNArdY7ah3dtQ==
X-Received: by 2002:a5d:5d02:0:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42704d9b22amr15501163f8f.43.1761231374005; 
 Thu, 23 Oct 2025 07:56:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] hw/net/rocker: Don't overflow in of_dpa_mask2prefix()
Date: Thu, 23 Oct 2025 15:55:54 +0100
Message-ID: <20251023145554.2062752-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In of_dpa_mask2prefix() we do "(2 << i)" for a loop where i can go up
to 31.  At i == 31 we shift off the top end of an integer.  This
doesn't actually calculate the wrong value in practice, because we
calculate 0 - 1 which is the 0xffffffff mask we wanted (and for QEMU
shifting off the top of a signed integer is not UB); but it makes
Coverity complain.

We could fix this simply by using "2ULL" (where the "(2ULL << i) - 1"
expression also evaluates to 0xffffffff for i == 31), but in fact
this function is a slow looping implementation of counting the number
of trailing zeroes in the (network-order) input mask:

 0bxxxxxxxxx1 => 32
 0bxxxxxxxx10 => 31
 0bxxxxxxx100 => 30
 ...
 0bx100000000 => 2
 0b1000000000 => 1
 0b0000000000 => 0

Replace the implementation with 32 - ctz32().

Coverity: CID 1547602
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251016145407.781978-1-peter.maydell@linaro.org
---
 hw/net/rocker/rocker_of_dpa.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 4aed1787566..16b9bc7a4b8 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -198,16 +198,7 @@ typedef struct of_dpa_group {
 
 static int of_dpa_mask2prefix(uint32_t mask)
 {
-    int i;
-    int count = 32;
-
-    for (i = 0; i < 32; i++) {
-        if (!(ntohl(mask) & ((2 << i) - 1))) {
-            count--;
-        }
-    }
-
-    return count;
+    return 32 - ctz32(ntohl(mask));
 }
 
 #if defined(DEBUG_ROCKER)
-- 
2.43.0


