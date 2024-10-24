Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D66D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 06:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3rRf-0002H8-28; Thu, 24 Oct 2024 02:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRc-0002FL-JS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRZ-0003QA-Cy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729751736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jddloZJAOdj5LJFFamH+V0nhCVCsU4XwZ7MW6CT72+w=;
 b=C/YwiXzBEVSaGqh5k4e6TBcTzduxkoJruk6ZCI846dTNvFg2wLY0moeZDe2DsWOibmShVj
 LYOY+/jL6aVpwHR2VHkwl3SBztjaAEQKs2e0AfX4Z0J0dJ9nYZtrqYIU7oBqbasCBURYG7
 UgINZJ2S8lJQwYOH0HlmcBvwYPE4BJg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-zvR1FlElPVSjPWORYxEGhA-1; Thu,
 24 Oct 2024 02:35:31 -0400
X-MC-Unique: zvR1FlElPVSjPWORYxEGhA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF05C1955BF6; Thu, 24 Oct 2024 06:35:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EA5B1955F40; Thu, 24 Oct 2024 06:35:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 05/17] hw/gpio/aspeed: Add AST2700 support
Date: Thu, 24 Oct 2024 08:34:55 +0200
Message-ID: <20241024063507.1585765-6-clg@redhat.com>
In-Reply-To: <20241024063507.1585765-1-clg@redhat.com>
References: <20241024063507.1585765-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

AST2700 integrates two set of Parallel GPIO Controller with maximum 212
control pins, which are 27 groups. (H, exclude pin: H7 H6 H5 H4)

In the previous design of ASPEED SOCs, one register is used for setting
one function for one set which are 32 pins and 4 groups.
ex: GPIO000 is used for setting data value for GPIO A, B, C and D in AST2600.
ex: GPIO004 is used for setting direction for GPIO A, B, C and D in AST2600.

However, the register set have a significant change since AST2700.
Each GPIO pin has their own individual control register.
In other words, users are able to set one GPIO pin’s direction,
interrupt enable, input mask and so on in the same one register.

Currently, aspeed_gpio_read and aspeed_gpio_write callback functions
are not compatible AST2700.

Introduce new aspeed_gpio_2700_read and aspeed_gpio_2700_write callback
functions and aspeed_gpio_2700_ops memory region operation for AST2700.
Introduce a new ast2700 class to support AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/gpio/aspeed_gpio.c | 380 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 380 insertions(+)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 16c18ea2f743..a5b3f454e800 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -227,6 +227,38 @@ REG32(GPIO_INDEX_REG, 0x2AC)
     FIELD(GPIO_INDEX_REG, COMMAND_SRC_1, 21, 1)
     FIELD(GPIO_INDEX_REG, INPUT_MASK, 20, 1)
 
+/* AST2700 GPIO Register Address Offsets */
+REG32(GPIO_2700_DEBOUNCE_TIME_1, 0x000)
+REG32(GPIO_2700_DEBOUNCE_TIME_2, 0x004)
+REG32(GPIO_2700_DEBOUNCE_TIME_3, 0x008)
+REG32(GPIO_2700_INT_STATUS_1, 0x100)
+REG32(GPIO_2700_INT_STATUS_2, 0x104)
+REG32(GPIO_2700_INT_STATUS_3, 0x108)
+REG32(GPIO_2700_INT_STATUS_4, 0x10C)
+REG32(GPIO_2700_INT_STATUS_5, 0x110)
+REG32(GPIO_2700_INT_STATUS_6, 0x114)
+REG32(GPIO_2700_INT_STATUS_7, 0x118)
+/* GPIOA0 - GPIOAA7 Control Register */
+REG32(GPIO_A0_CONTROL, 0x180)
+    SHARED_FIELD(GPIO_CONTROL_OUT_DATA, 0, 1)
+    SHARED_FIELD(GPIO_CONTROL_DIRECTION, 1, 1)
+    SHARED_FIELD(GPIO_CONTROL_INT_ENABLE, 2, 1)
+    SHARED_FIELD(GPIO_CONTROL_INT_SENS_0, 3, 1)
+    SHARED_FIELD(GPIO_CONTROL_INT_SENS_1, 4, 1)
+    SHARED_FIELD(GPIO_CONTROL_INT_SENS_2, 5, 1)
+    SHARED_FIELD(GPIO_CONTROL_RESET_TOLERANCE, 6, 1)
+    SHARED_FIELD(GPIO_CONTROL_DEBOUNCE_1, 7, 1)
+    SHARED_FIELD(GPIO_CONTROL_DEBOUNCE_2, 8, 1)
+    SHARED_FIELD(GPIO_CONTROL_INPUT_MASK, 9, 1)
+    SHARED_FIELD(GPIO_CONTROL_BLINK_COUNTER_1, 10, 1)
+    SHARED_FIELD(GPIO_CONTROL_BLINK_COUNTER_2, 11, 1)
+    SHARED_FIELD(GPIO_CONTROL_INT_STATUS, 12, 1)
+    SHARED_FIELD(GPIO_CONTROL_IN_DATA, 13, 1)
+    SHARED_FIELD(GPIO_CONTROL_RESERVED, 14, 18)
+REG32(GPIO_AA7_CONTROL, 0x4DC)
+#define GPIO_2700_MEM_SIZE 0x4E0
+#define GPIO_2700_REG_ARRAY_SIZE (GPIO_2700_MEM_SIZE >> 2)
+
 static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int gpio)
 {
     uint32_t falling_edge = 0, rising_edge = 0;
@@ -970,6 +1002,316 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
     aspeed_gpio_set_pin_level(s, set_idx, pin, level);
 }
 
+static uint64_t aspeed_gpio_2700_read_control_reg(AspeedGPIOState *s,
+                                    uint32_t pin)
+{
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    GPIOSets *set;
+    uint64_t value = 0;
+    uint32_t set_idx;
+    uint32_t pin_idx;
+
+    set_idx = pin / ASPEED_GPIOS_PER_SET;
+    pin_idx = pin % ASPEED_GPIOS_PER_SET;
+
+    if (set_idx >= agc->nr_gpio_sets) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: set index: %d, out of bounds\n",
+                      __func__, set_idx);
+        return 0;
+    }
+
+    set = &s->sets[set_idx];
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_OUT_DATA,
+                              extract32(set->data_read, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_DIRECTION,
+                              extract32(set->direction, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_ENABLE,
+                              extract32(set->int_enable, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_0,
+                              extract32(set->int_sens_0, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_1,
+                              extract32(set->int_sens_1, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_2,
+                              extract32(set->int_sens_2, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_RESET_TOLERANCE,
+                              extract32(set->reset_tol, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_DEBOUNCE_1,
+                              extract32(set->debounce_1, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_DEBOUNCE_2,
+                              extract32(set->debounce_2, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INPUT_MASK,
+                              extract32(set->input_mask, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_STATUS,
+                              extract32(set->int_status, pin_idx, 1));
+    value = SHARED_FIELD_DP32(value, GPIO_CONTROL_IN_DATA,
+                              extract32(set->data_value, pin_idx, 1));
+    return value;
+}
+
+static void aspeed_gpio_2700_write_control_reg(AspeedGPIOState *s,
+                                uint32_t pin, uint64_t data)
+{
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    const GPIOSetProperties *props;
+    GPIOSets *set;
+    uint32_t set_idx;
+    uint32_t pin_idx;
+    uint32_t group_value = 0;
+    uint32_t pending = 0;
+
+    set_idx = pin / ASPEED_GPIOS_PER_SET;
+    pin_idx = pin % ASPEED_GPIOS_PER_SET;
+
+    if (set_idx >= agc->nr_gpio_sets) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: set index: %d, out of bounds\n",
+                      __func__, set_idx);
+        return;
+    }
+
+    set = &s->sets[set_idx];
+    props = &agc->props[set_idx];
+
+    /* direction */
+    group_value = set->direction;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DIRECTION));
+    /*
+     * where data is the value attempted to be written to the pin:
+     * pin type      | input mask | output mask | expected value
+     * ------------------------------------------------------------
+     * bidirectional  |   1       |   1        |  data
+     * input only     |   1       |   0        |   0
+     * output only    |   0       |   1        |   1
+     * no pin         |   0       |   0        |   0
+     *
+     * which is captured by:
+     * data = ( data | ~input) & output;
+     */
+    group_value = (group_value | ~props->input) & props->output;
+    set->direction = update_value_control_source(set, set->direction,
+                                                 group_value);
+
+    /* out data */
+    group_value = set->data_read;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_OUT_DATA));
+    group_value &= props->output;
+    group_value = update_value_control_source(set, set->data_read,
+                                              group_value);
+    set->data_read = group_value;
+
+    /* interrupt enable */
+    group_value = set->int_enable;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_ENABLE));
+    set->int_enable = update_value_control_source(set, set->int_enable,
+                                                  group_value);
+
+    /* interrupt sensitivity type 0 */
+    group_value = set->int_sens_0;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SENS_0));
+    set->int_sens_0 = update_value_control_source(set, set->int_sens_0,
+                                                  group_value);
+
+    /* interrupt sensitivity type 1 */
+    group_value = set->int_sens_1;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SENS_1));
+    set->int_sens_1 = update_value_control_source(set, set->int_sens_1,
+                                                  group_value);
+
+    /* interrupt sensitivity type 2 */
+    group_value = set->int_sens_2;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SENS_2));
+    set->int_sens_2 = update_value_control_source(set, set->int_sens_2,
+                                                  group_value);
+
+    /* reset tolerance enable */
+    group_value = set->reset_tol;
+    group_value = deposit32(group_value, pin_idx, 1,
+                        SHARED_FIELD_EX32(data, GPIO_CONTROL_RESET_TOLERANCE));
+    set->reset_tol = update_value_control_source(set, set->reset_tol,
+                                                 group_value);
+
+    /* debounce 1 */
+    group_value = set->debounce_1;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DEBOUNCE_1));
+    set->debounce_1 = update_value_control_source(set, set->debounce_1,
+                                                  group_value);
+
+    /* debounce 2 */
+    group_value = set->debounce_2;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DEBOUNCE_2));
+    set->debounce_2 = update_value_control_source(set, set->debounce_2,
+                                                  group_value);
+
+    /* input mask */
+    group_value = set->input_mask;
+    group_value = deposit32(group_value, pin_idx, 1,
+                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INPUT_MASK));
+    /*
+     * feeds into interrupt generation
+     * 0: read from data value reg will be updated
+     * 1: read from data value reg will not be updated
+     */
+    set->input_mask = group_value & props->input;
+
+    /* blink counter 1 */
+    /* blink counter 2 */
+    /* unimplement */
+
+    /* interrupt status */
+    if (SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_STATUS)) {
+        /* pending is either 1 or 0 for a 1-bit field */
+        pending = extract32(set->int_status, pin_idx, 1);
+
+        assert(s->pending >= pending);
+
+        /* No change to s->pending if pending is 0 */
+        s->pending -= pending;
+
+        /*
+         * The write acknowledged the interrupt regardless of whether it
+         * was pending or not. The post-condition is that it mustn't be
+         * pending. Unconditionally clear the status bit.
+         */
+        set->int_status = deposit32(set->int_status, pin_idx, 1, 0);
+    }
+
+    aspeed_gpio_update(s, set, set->data_value, UINT32_MAX);
+    return;
+}
+
+static uint64_t aspeed_gpio_2700_read(void *opaque, hwaddr offset,
+                                uint32_t size)
+{
+    AspeedGPIOState *s = ASPEED_GPIO(opaque);
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    GPIOSets *set;
+    uint64_t value;
+    uint64_t reg;
+    uint32_t pin;
+    uint32_t idx;
+
+    reg = offset >> 2;
+
+    if (reg >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%" PRIx64 " out of bounds\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    switch (reg) {
+    case R_GPIO_2700_DEBOUNCE_TIME_1 ... R_GPIO_2700_DEBOUNCE_TIME_3:
+        idx = reg - R_GPIO_2700_DEBOUNCE_TIME_1;
+
+        if (idx >= ASPEED_GPIO_NR_DEBOUNCE_REGS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: debounce index: %d, out of bounds\n",
+                          __func__, idx);
+            return 0;
+        }
+
+        value = (uint64_t) s->debounce_regs[idx];
+        break;
+    case R_GPIO_2700_INT_STATUS_1 ... R_GPIO_2700_INT_STATUS_7:
+        idx = reg - R_GPIO_2700_INT_STATUS_1;
+
+        if (idx >= agc->nr_gpio_sets) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: interrupt status index: %d, out of bounds\n",
+                          __func__, idx);
+            return 0;
+        }
+
+        set = &s->sets[idx];
+        value = (uint64_t) set->int_status;
+        break;
+    case R_GPIO_A0_CONTROL ... R_GPIO_AA7_CONTROL:
+        pin = reg - R_GPIO_A0_CONTROL;
+
+        if (pin >= agc->nr_gpio_pins) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid pin number: %d\n",
+                          __func__, pin);
+               return 0;
+        }
+
+        value = aspeed_gpio_2700_read_control_reg(s, pin);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                      PRIx64"\n", __func__, offset);
+        return 0;
+    }
+
+    trace_aspeed_gpio_read(offset, value);
+    return value;
+}
+
+static void aspeed_gpio_2700_write(void *opaque, hwaddr offset,
+                                uint64_t data, uint32_t size)
+{
+    AspeedGPIOState *s = ASPEED_GPIO(opaque);
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
+    uint64_t reg;
+    uint32_t pin;
+    uint32_t idx;
+
+    trace_aspeed_gpio_write(offset, data);
+
+    reg = offset >> 2;
+
+    if (reg >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%" PRIx64 " out of bounds\n",
+                      __func__, offset);
+        return;
+    }
+
+    switch (reg) {
+    case R_GPIO_2700_DEBOUNCE_TIME_1 ... R_GPIO_2700_DEBOUNCE_TIME_3:
+        idx = reg - R_GPIO_2700_DEBOUNCE_TIME_1;
+
+        if (idx >= ASPEED_GPIO_NR_DEBOUNCE_REGS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: debounce index: %d out of bounds\n",
+                          __func__, idx);
+            return;
+        }
+
+        s->debounce_regs[idx] = (uint32_t) data;
+        break;
+    case R_GPIO_A0_CONTROL ... R_GPIO_AA7_CONTROL:
+        pin = reg - R_GPIO_A0_CONTROL;
+
+        if (pin >= agc->nr_gpio_pins) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid pin number: %d\n",
+                          __func__, pin);
+            return;
+        }
+
+        if (SHARED_FIELD_EX32(data, GPIO_CONTROL_RESERVED)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reserved data: 0x%"
+                          PRIx64"\n", __func__, data);
+            return;
+        }
+
+        aspeed_gpio_2700_write_control_reg(s, pin, data);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      PRIx64"\n", __func__, offset);
+        break;
+    }
+
+    return;
+}
+
 /* Setup functions */
 static const GPIOSetProperties ast2400_set_props[ASPEED_GPIO_MAX_NR_SETS] = {
     [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
@@ -1016,6 +1358,16 @@ static GPIOSetProperties ast1030_set_props[ASPEED_GPIO_MAX_NR_SETS] = {
     [5] = {0x000000ff,  0x00000000,  {"U"} },
 };
 
+static GPIOSetProperties ast2700_set_props[ASPEED_GPIO_MAX_NR_SETS] = {
+    [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
+    [1] = {0x0fffffff,  0x0fffffff,  {"E", "F", "G", "H"} },
+    [2] = {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
+    [3] = {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
+    [4] = {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
+    [5] = {0xffffffff,  0xffffffff,  {"U", "V", "W", "X"} },
+    [6] = {0x00ffffff,  0x00ffffff,  {"Y", "Z", "AA"} },
+};
+
 static const MemoryRegionOps aspeed_gpio_ops = {
     .read       = aspeed_gpio_read,
     .write      = aspeed_gpio_write,
@@ -1024,6 +1376,14 @@ static const MemoryRegionOps aspeed_gpio_ops = {
     .valid.max_access_size = 4,
 };
 
+static const MemoryRegionOps aspeed_gpio_2700_ops = {
+    .read       = aspeed_gpio_2700_read,
+    .write      = aspeed_gpio_2700_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
 static void aspeed_gpio_reset(DeviceState *dev)
 {
     AspeedGPIOState *s = ASPEED_GPIO(dev);
@@ -1193,6 +1553,18 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->reg_ops = &aspeed_gpio_ops;
 }
 
+static void aspeed_gpio_2700_class_init(ObjectClass *klass, void *data)
+{
+    AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
+
+    agc->props = ast2700_set_props;
+    agc->nr_gpio_pins = 216;
+    agc->nr_gpio_sets = 7;
+    agc->reg_table_count = GPIO_2700_REG_ARRAY_SIZE;
+    agc->mem_size = 0x1000;
+    agc->reg_ops = &aspeed_gpio_2700_ops;
+}
+
 static const TypeInfo aspeed_gpio_info = {
     .name           = TYPE_ASPEED_GPIO,
     .parent         = TYPE_SYS_BUS_DEVICE,
@@ -1237,6 +1609,13 @@ static const TypeInfo aspeed_gpio_ast1030_info = {
     .instance_init  = aspeed_gpio_init,
 };
 
+static const TypeInfo aspeed_gpio_ast2700_info = {
+    .name           = TYPE_ASPEED_GPIO "-ast2700",
+    .parent         = TYPE_ASPEED_GPIO,
+    .class_init     = aspeed_gpio_2700_class_init,
+    .instance_init  = aspeed_gpio_init,
+};
+
 static void aspeed_gpio_register_types(void)
 {
     type_register_static(&aspeed_gpio_info);
@@ -1245,6 +1624,7 @@ static void aspeed_gpio_register_types(void)
     type_register_static(&aspeed_gpio_ast2600_3_3v_info);
     type_register_static(&aspeed_gpio_ast2600_1_8v_info);
     type_register_static(&aspeed_gpio_ast1030_info);
+    type_register_static(&aspeed_gpio_ast2700_info);
 }
 
 type_init(aspeed_gpio_register_types);
-- 
2.47.0


