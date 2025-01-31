Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F780C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFc-0006WT-6y; Fri, 31 Jan 2025 16:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFU-0005gm-3t
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFS-00082f-A9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:23 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so29304165e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357700; x=1738962500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7A36aAFQQQuLpfdth227W6S0BPoJE/W3cgZ7jyQu4k=;
 b=tyvg2HxaNo4DzRYMzDMp2UcmJq8Cx57PY0001jkdU8f4bVkW+rUyMJkw82SkJ7RSkJ
 BgYr3xr3lO4f98Hpype78DHoKlReBD/+A2ZZdJz3kAaA1PFSrsvhmxOIPTeA/RU9LlOC
 J8sn6+FybvT0sYKeQvdAzGwSnM4orBlH+H/iClMJvOpBGnXCFfJaBSWyh7spK1JtCpAL
 VYJYYMsEUFam97wV79YfLmCxTwioDKl+GOJO6Se3GU2Z8CmAI/gqnZlXXSVzgVTiAl/d
 hPtr250p8BwT+EnLf73kmnrT4MhDF378sdLU10hypnCrKhOHSv7VmQIt2Vqa0RKJV3Ty
 ARBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357700; x=1738962500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7A36aAFQQQuLpfdth227W6S0BPoJE/W3cgZ7jyQu4k=;
 b=CU5meFbCQoj6WAlpwmiDestAYjvE0atu6P3pnDyP7fQXPDFrFIugv5wxRtmVyuBbQ3
 rfOKEpYImy0iZUxdEnV4HPI/I++7LRn8Gqv6/tND3xCJOjEc55phERkR4IjlB54PWTXt
 PkCqrHExYb47xvBDPUPgQ9n7qBBhyADK8KuYIHeEuu19Ys6d5WDYmC288sllmsUKEJ+g
 Uwunhd+WAJvJU0UfDf+DBde7Z3x7SpDX0MKhsoFM6/Bg5H3vKd8Z44En3duXrFziD4WX
 DUYHSW15Ge1y/1vjnNLlTsJqY+x/F4cqphgmdGDNCnoP+wEZlKmjfX7oDpqKDcMK0ZY1
 SlEQ==
X-Gm-Message-State: AOJu0YxhhRbVmcbhdyToP0sAG86w96Z5TrpZE2VqJxMmA72gs42r73bf
 SRYFmQjkOdJuhObGU7FC1Mt3QMZtDNA7lio7if7tPUQfKgkZDqnpq4Di0bMbsu+JDTLi8bwe50T
 oU44=
X-Gm-Gg: ASbGncuqSf1aJ1uhi51wgcq1nPo5qZboc6mx5EWj7C2osL7q3rGn0nomMtSfEm4V+2W
 JoxYySOWY9MCGclScj4Cj/IvN1/eE+Q0d2giedankQSzqd4SN/NKs8MA2uD/K04MGt5lGwWhT8A
 8DCz/gOl03ZYGCff5AbnkikMEaAH/hT+li//ltDifqlUuuQty24E9bbBLi+ix4GszxJer6hgeJ/
 R0uG3mOpTYwmamxXdasyKDo6AOT7uTYGbKrYqjibX3OneVwoS9hz852CsSOP6sd/0yABNjPugIH
 hBFQt8saF3QbTqL5rjoU0SfgyiuyeW8Vd+zFwG7mD8/AEEkvHX3+f2PSTBisySwQQQ==
X-Google-Smtp-Source: AGHT+IG6lvMBRbSD51w+TbTHf0AbEv1o1/Xl3hj8/zMwsGPeyI4lzbWjMjr7xJaM8TH9s9PPgmYACg==
X-Received: by 2002:a05:600c:3b0a:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438dc3cae6cmr141546445e9.17.1738357700244; 
 Fri, 31 Jan 2025 13:08:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm67206995e9.27.2025.01.31.13.08.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:08:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/36] hw/sd: Remove unused SDState::enable
Date: Fri, 31 Jan 2025 22:05:19 +0100
Message-ID: <20250131210520.85874-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Now that sd_enable() has been removed, SD::enable is set to true in
sd_instance_init() and then never changed. So we can remove it.

Note that the VMSTATE_UNUSED() size argument should be '1', not
'sizeof(bool)', as noted in the CAUTION comment in vmstate.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-12-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 74bb7f39bbf..e541c57f8c3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -173,7 +173,6 @@ struct SDState {
     size_t data_size;
     uint8_t data[512];
     QEMUTimer *ocr_power_timer;
-    bool enable;
     uint8_t dat_lines;
     bool cmd_line;
 };
@@ -292,12 +291,12 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 
 static uint8_t sd_get_dat_lines(SDState *sd)
 {
-    return sd->enable ? sd->dat_lines : 0;
+    return sd->dat_lines;
 }
 
 static bool sd_get_cmd_line(SDState *sd)
 {
-    return sd->enable ? sd->cmd_line : false;
+    return sd->cmd_line;
 }
 
 static void sd_set_voltage(SDState *sd, uint16_t millivolts)
@@ -976,7 +975,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
         VMSTATE_UNUSED_V(1, 512),
-        VMSTATE_BOOL(enable, SDState),
+        VMSTATE_UNUSED(1),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -2146,7 +2145,7 @@ static int sd_do_command(SDState *sd, SDRequest *req,
     sd_rsp_type_t rtype;
     int rsplen;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable) {
+    if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return 0;
     }
 
@@ -2297,8 +2296,9 @@ static void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
+    if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return;
+    }
 
     if (sd->state != sd_receivingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -2429,8 +2429,9 @@ static uint8_t sd_read_byte(SDState *sd)
     uint8_t ret;
     uint32_t io_len;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
+    if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return dummy_byte;
+    }
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -2664,7 +2665,6 @@ static void sd_instance_init(Object *obj)
 
     sd->proto = sc->proto;
     sd->last_cmd_name = "UNSET";
-    sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
 
-- 
2.47.1


