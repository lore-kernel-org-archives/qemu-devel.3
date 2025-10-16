Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F9CCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PN3-00077y-UY; Thu, 16 Oct 2025 10:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9PN1-00077g-Fi
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:54:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9PMw-00084z-8a
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:54:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so690657f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760626449; x=1761231249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M4mfBFUD3IWqk8HRwRC5PGFKB4N/RxRLXgmXR0FKMq0=;
 b=MGjdBg20VYMAeVcEiJbA/AFvpBsv4qYJuLyINKNEod/pqLMedq/qDqaPaEI2s9s71F
 0SDnvEhsNPwv2jyhSmgHZ+sGRhQ/X2ThSvcMxcRrl0e/h9er6ykACOXkM2HPbTvsMaNd
 qlHugZ5E52Z0qwf8JZmDvjMMcZNwQ96KITwpYqQCgU8ezHDoF9umY908Q+vvs8xfibKk
 FJ4nYiI3PpcRInJV1JSW2UUdK5/3QIh0IIjWiOVXX1oQpsa3S5jqSDFXhz64RTCIyNyG
 ZwapAukye5ogsoNGuzJRhmCEBhLBF8T5g6laZ7c2WfH7a8DPpMuC2r+cOPptMqFjiWpT
 pAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760626449; x=1761231249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4mfBFUD3IWqk8HRwRC5PGFKB4N/RxRLXgmXR0FKMq0=;
 b=wswbd68YpVGUGrmTkqwx8lE8nPvzG3gB54fgyMdbIuRzZVkciwSR0khHGIdDV+Dvvt
 qmNE2E7QFKdLxN9zx1wLDyvHMFZANjdIo164NqpD6ZQjv1YIQ96kZNO3dAjzrsoWQb0i
 JrZ3KNzO5Q0TQRbWYCHsI7HBr1DEchxCb0HyHu78V6xr5ZnHHnXhB8SdzEbX5SeBPQxR
 nJ/XcLd63QFSPE2DzR10eRuXD+2+Wpycdv6viP4+oIC7rL1euQxVhBjeb9hyYb+OEwke
 /WIvzs2PsKSx7h1AzTWAQllJRgv40OAZiwLmtUZtXXoLqe4leNWK8TDXzl6LK+0g3gqO
 1c+Q==
X-Gm-Message-State: AOJu0YwHMa6TaKta9JSJLw5Yz4LzuOODXcdMSzPE6wxKEx44PSXQ5/v5
 mrgL8ud8EKk1yEbhqyVWu+3Q6KPQ0bFBrV9iyII+UT34zRlj+rhXXfq8BMi8fv1ywNMf2IzyY0C
 oTRHz
X-Gm-Gg: ASbGncvxeenczMlyblyKZelw2F273e2Ja6ClBRAUtth42iilpvNaLcohlkWeOLHtq0U
 5aYQ0ioa0+hMJcLMvWVVlDclh5ClXWJGdpO066phAp9CgLjxyq0wZAcYxD0zdkvTTWYaegwyrLz
 ermnsa+RdqZOGxOsbod6b2KwnhdNoSUTVSeBVFUgwMM03UZE09xtoErZYGbkalvhn0UsyKk8Pim
 2394BKPEmTarz7+uRBphpui4jV6Pim/Q46VZJvgFnefI1WcOkYAwpPlmWLdh7fdooQU6MNFn4dH
 u1YaZUyVEoICJZ8RZ9cjfhqsLkC4dZeFp+SVvqa14qoF07dV3Mc57CsPiBZx6BO5ay87K0E3OHT
 GyoCf8grzjiPGIz8luqs6D3mgmjR8NZvX2E2j62b+YhLRGd6RPAEaUG/Z9BxkPfocw+MOkofhPg
 o2WKIbnw==
X-Google-Smtp-Source: AGHT+IHJMEnsUewdkR3/sso60FNvsGQmAgddrj+B1snLUpAg0ZphJgMYF4j9JHu5GnESG06+3PiTnA==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16a3 with SMTP id
 ffacd0b85a97d-4270526183emr157789f8f.29.1760626449023; 
 Thu, 16 Oct 2025 07:54:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf790sm33890328f8f.28.2025.10.16.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 07:54:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2] hw/net/rocker: Don't overflow in of_dpa_mask2prefix()
Date: Thu, 16 Oct 2025 15:54:07 +0100
Message-ID: <20251016145407.781978-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
---
I submitted the "2ULL" version of the patch back in July;
Philippe suggested this improvement but I never got round to
going back and checking it gave the same answers and resending.
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


