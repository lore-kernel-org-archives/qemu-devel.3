Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52694FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKsv-00037M-Lf; Tue, 05 May 2026 14:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsI-0002hw-6Y
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsF-0007Aa-Ep
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso49794535e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778007121; x=1778611921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyvNlrhCDRRoXpiivbyJr1JUobLzjlCgnPIPMN8niGU=;
 b=e8TDMAC8hdMUCiKLjoTALciievk2cGh+1TGnB05PvLBeJrxTUHcLUa/9Z52XG1eu1n
 aB1nY+A6q3LTRWoVSoUguoLD4OjKOSq2xtNnh3MNDQaUA06GBex6l4N+5iPCf/oSX1/p
 cTpcX9KJBF3dW44RpRKofB+AZY/VTk09eSOFxrCtSegNK5MqugFxcYSoElwJ0xDdJQRJ
 0yGSc5lyEMo5KpvLERF3E9AjFgQGEDPDr0hlBYt6AUw5ovbeCaVozXIOhUjaR+m1t2lK
 WCB0d4uEpXUzz5To8bR+NfipzXpfIyKxJlO4SJb8QtOnCwrcUpGtlVKJOtR9b0vfCE8P
 OxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778007121; x=1778611921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wyvNlrhCDRRoXpiivbyJr1JUobLzjlCgnPIPMN8niGU=;
 b=o6rEoZSxCpTfNVH2D7/0eRaJcc46hr5T43fVUtlC0b9BnthVzsTIdAQnmnngcq6SO9
 IyEV/hBBjjOpCoh+LytKvAbhD+HB1RewMsXU34rGtVK5pW+zj31xW12MYmCyQFxdQ1J8
 0GmM1TeIDktOvwDxYh4QOUCjN7yqpBqTwB6micsJ8SdhLqjpUS4eV5BNH0HFDLr3YKPS
 8UuA6EZsbpAM7ewtJmTCyPrHXYXqhil9b6D/K5oKTfOY9FkXY6vRTyW4/xhzIQfBxdBW
 rbcw3YFlIBXvdquGGoGAQrBeZnEuQUEj0W5HtRcDx4kntwQttsnULhaAHdffMrTPHpq9
 bM8Q==
X-Gm-Message-State: AOJu0YxQV+XjBU9xMQ/A65tcb6kYJXUtEAvXDGjjwpNO8nBvO2eTxNNT
 ZKLzis6/H59XzxX9k5lLZ0DS8oL2l41TniRfVXaPgEKeT6PkE9hlUU23+M98xq0pTpVnw9miXd6
 bB0Ir
X-Gm-Gg: AeBDiesRbgbvHbJVqmeyq8XH73MMB1jhs4V2lUovfK2KzLQUUg8kz+6Z8L44hWvAoPW
 /qEV2wbDhHEQO69AQ8AkKj5qZuHRTTOiJ6AEwuJuSDXmz+bl8IVjRiA+vZFq99xar+XTn8gWwaG
 ahiN8C7ggZfLqEn7gS/L85YGk5ajmdkjjVBq+ixg+9O/bImnXHjdUlSPs3t3j/ryzOXfSdp7Coy
 fVMtwlQwhDW6jMHYr+02AITPwBU3UvLQiAkWXgemaANdFbNDyeXjr1om4GdSaGr2HykR+t4/6zi
 YR0GANaNB2o7EtmRci/ZBNpPhNx4C12N3OuYj+m0bN0QmT58Ky5DhceHRdbZtRe+saUdf6nX7vt
 GMZ8yZDzYtqmTpKpCKSH+PF8VpmBrBdY8KdaZNAfhThzpsolhsV+Z5Fc9In+ZS42krRwCOFoYzz
 /OocHieDPF6JkaOWhTCuXYY/8aOC/5fWsuLf9VS4KaCCfKbioJUaOMaM3by1GnKy3qWzcWwS1HD
 1glF45jb70VTIMPxABuk/xH9TFXfG2N+iGCpPjGpA==
X-Received: by 2002:a05:600c:1f0d:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-48e51dd9772mr8473475e9.0.1778007120740; 
 Tue, 05 May 2026 11:52:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm377086675e9.5.2026.05.05.11.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:52:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/2] hw/net/rocker_of_dpa: Avoid unaligned accesses in
 _of_dpa_flow_match()
Date: Tue,  5 May 2026 19:51:57 +0100
Message-ID: <20260505185157.608910-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505185157.608910-1-peter.maydell@linaro.org>
References: <20260505185157.608910-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

_of_dpa_flow_match() tries to do masked comparisons of OfDpaFlowkey
structs by casting pointers to them to uint64_t* and then doing the
memory accesses as 64-bit. This is undefined behaviour because the
pointers might not be 64-bit aligned, and the UB sanitizer spots this:

../../hw/net/rocker/rocker_of_dpa.c:321:20: runtime error: load of misaligned address 0x512000164044 for type 'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x512000164044: note: pointer points here
  02 00 00 00 00 00 ff ff  00 00 00 00 ff ff ff ff  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

We do know that OfDpaFlowKey structs must be at least aligned enough
for uint32_t accesses, because that's the type of the first field.
Switch to using uint32_t accesses in the loop.

Because the "width" field is always set via the FLOW_KEY_WIDTH macro
and not exposed to the guest, we can adjust the macro to store the
number of uint32_t to be checked rather than needing to change the
loop boundary in the match function.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 958f3006c1..3d6f55b512 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -99,13 +99,13 @@ typedef struct of_dpa_flow_key {
             } nd;
         } ipv6;
     };
-    int width;                       /* how many uint64_t's in key? */
+    int width;                       /* how many uint32_t's in key? */
 } OfDpaFlowKey;
 
-/* Width of key which includes field 'f' in u64s, rounded up */
+/* Width of key which includes field 'f' in u32s, rounded up */
 #define FLOW_KEY_WIDTH(f) \
     DIV_ROUND_UP(offsetof(OfDpaFlowKey, f) + sizeof_field(OfDpaFlowKey, f), \
-    sizeof(uint64_t))
+    sizeof(uint32_t))
 
 typedef struct of_dpa_flow_action {
     uint32_t goto_tbl;
@@ -304,9 +304,9 @@ static void _of_dpa_flow_match(void *key, void *value, void *user_data)
 {
     OfDpaFlow *flow = value;
     OfDpaFlowMatch *match = user_data;
-    uint64_t *k = (uint64_t *)&flow->key;
-    uint64_t *m = (uint64_t *)&flow->mask;
-    uint64_t *v = (uint64_t *)&match->value;
+    uint32_t *k = (uint32_t *)&flow->key;
+    uint32_t *m = (uint32_t *)&flow->mask;
+    uint32_t *v = (uint32_t *)&match->value;
     int i;
 
     if (flow->key.tbl_id == match->value.tbl_id) {
-- 
2.43.0


