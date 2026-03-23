Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40253F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWQ-0001aI-Au; Mon, 23 Mar 2026 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWL-0001Tl-JR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWI-0000Tq-Al
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48704db565eso21353335e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284767; x=1774889567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phzEH3Tj7gZPX5ttRlmc25ZCIEEomskK5rjdvu33ST8=;
 b=tNlWcI+e0609AsaYwEObNgBdoAJJ781p9MD30DdT1CX/+ReBBEXHbL2El1E2Bozmox
 BocGQzsMW3OMihERFwGgYJa/A34sHBnXsR16SRkdIQrYRZgSZWkPRXdaSCq9RHJpYO5C
 pLWuIn1SptwGcAl+QgAmJ/XbSYZSOr1Y22UiSoLKJg0aIT5pUdNhZfdV5uazD4xKrcqy
 X+A3+PrhIddnPoBEU5xI2cDffR/oEE1myVfM0KOn5typ4xCVp755wgtLX6IGSLhvXc4G
 Hb0KxwzjdsILFlhbS53+PwcS7slT+y1QErOSfe3GVBjD4+qOJ/+9kMsei2OoH7kuZGcn
 XLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284767; x=1774889567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=phzEH3Tj7gZPX5ttRlmc25ZCIEEomskK5rjdvu33ST8=;
 b=RpaDRMw7taobqVaCJd7xqnmlOfD47FyL2fqWs4sEyHcHqnAeIt5Xq0RihSQ6ZyqJfZ
 PGhjBUnSNmUUuvaM82iJSQOJjDLYgxe72VRgwDHo/0ut8bx0OHPnf6Y5Q0IXqh4NHuL8
 /GkpewqKW7axxstfNU50RLgAMH7QbRtsaJ6lE/6QGTJvqOWWjgLbamEpxLj+4KipJaJ2
 T4lq2awisKxDClZ43oWsYZFqpvHgYfMZWyz0Z7/TC+ZuyHZxEEZZDqLprmaUu4Yp0qyf
 pa+9TLB1H8+c+RRZn0HdBL5Sdh9PUz/fOYYWYLZGkA5fLci7AiU7h3qUNySXuu7YGIBs
 Tb4w==
X-Gm-Message-State: AOJu0YwIsjc+Rd6Q6rkIhlmA0OFrg4roY88QVNkwyASaYbu7RBGI+PhL
 oKAJ4KfzYFwfWIqQw7K4S08nY0eoFPzCGX6WgNDLHjm/mxgpR8pwrwO93GzIgQrofFhsSgtmHCi
 hvFsBuZ4=
X-Gm-Gg: ATEYQzytqh03gqHeDqhYBExWnizfKQdkkagY7QsMdwEFO/alc3JE1kRcZvrEP8SL3Sw
 MwoUAs1kL6E5ffb0dZQN67X8oWV1jKx8RS4XM5Ygruu8nSPIdFcnwv3ewSaVyszZ9CqBSC73+V+
 2sr5/n0vrHZO5A8JGj4nVfqPrggV+JZs0ZDEtcseQ+e4bvOrnRK6zMtvPh7P8Ms0egJ8VPZyzZ3
 5nwtCQLz2gm1M2CnnesJC8UCVorG2XU78nQ3SQ8XYUkGyYH2yWCZdlHQQSZJlQ9SQoD5rqitVXi
 8Im63OkK741WHknMfflKBbc9DixM9jdjxyARadaFMcC7ld2bQ2qt6BuzVADNikPg6iXuc/3nJqr
 C551iLV+5Xx6GPueYC/B+gfr/Q50DOfuuoWMsEjhmcyH7jQHPlC4c9mKBwab/XrZ9SSEqJ4Ruzf
 ZWJUy+8SQeD6Eh0o/A8QXuuNt4NVlf9a8hzPSV0nsLb5byrstYhFVamsc+TXT5MDqQv0YB7Vy4
X-Received: by 2002:a05:600c:888b:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-486fee08886mr130605545e9.22.1774284766970; 
 Mon, 23 Mar 2026 09:52:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8aacc73sm333612935e9.0.2026.03.23.09.52.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/27] hw/i3c/dw-i3c: Fix uninitialized data use in short
 transfer
Date: Mon, 23 Mar 2026 17:51:55 +0100
Message-ID: <20260323165218.96607-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Coverity reports that dw_i3c_short_transfer() may pass an
uninitialized buffer to dw_i3c_send().

The immediate cause is the use of `data[len] += arg.byte0`, which
reads from an uninitialized element of the buffer. Replace this with
a simple assignment.

Additionally, avoid calling dw_i3c_send() when the constructed payload
length is zero. In that case the transfer has no data phase, so the
controller can transition to the idle state directly.

This resolves the Coverity UNINIT warning and clarifies the handling
of zero-length short transfers.

Resolves: Coverity CID 1645555
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i3c/dw-i3c.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index e9bdfd6af2a..d87d42be891 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1213,7 +1213,7 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
          * ignored.
          */
         if (cmd.dbp) {
-            data[len] += arg.byte0;
+            data[len] = arg.byte0;
             len++;
         }
     }
@@ -1228,10 +1228,16 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
         len++;
     }
 
-    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
-        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+    if (len > 0) {
+        if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
+            err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+        } else {
+            /* Only go to an idle state on a successful transfer. */
+            ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                             DW_I3C_TRANSFER_STATE_IDLE);
+        }
     } else {
-        /* Only go to an idle state on a successful transfer. */
+        /* No payload bytes for this short transfer. */
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
                          DW_I3C_TRANSFER_STATE_IDLE);
     }
-- 
2.53.0


