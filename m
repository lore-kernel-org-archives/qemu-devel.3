Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F7C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 11:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtn0Y-0002ps-OE; Mon, 08 Apr 2024 07:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtn0V-0002pb-Cc
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:17:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtn0T-0004Pe-8b
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:17:47 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a519eae91d1so378295666b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712575063; x=1713179863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRfJYpfP7rS0TZ7yhUkWcxfGABZ0WpG9qgLSEdkcQGA=;
 b=oyWZ4TbDcAIHi9b4qTYf4WEzwYD4xfCL4J0vi1XpJqdjdpxQp1/QqlqC2cHJOpiw0A
 1O9Qs2YrDDsLHscm4R9Le5oMePf5NjRORoZV0GIWgyWbccvSOFeNbSsCfKFKylbL4Iea
 VVelctynSw2shJxbF+Z+ZSASukbunatN/9mwsbV67TgDeJ++QzFEtzoLsZ3OP1HeVtCX
 tybwFCyj6JVLdXxnIFdSklbOeExS4S7Q6zHk9OLGLZonNdHzw0ku7yXlwhNgM7LKtxIe
 hiutGRIpcfR7x+bB/WbUkEbR5cukJDx5TSwGTyLTyiDl8PYmROtDyXXIA+EPXmmisqrE
 cDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712575063; x=1713179863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRfJYpfP7rS0TZ7yhUkWcxfGABZ0WpG9qgLSEdkcQGA=;
 b=gsJAt/nhYaAa0AggV7bjK+0ZN6mQ0pqEiRViUsRSC28oPWMvRnWMitUTSn0CAFlm28
 P03qCkQV+66zJ/GdTCh3+E+LO53YBfyIW8OEGnkEPHnvp9mplIsSqYqvqt4oebt0lagq
 1uK6JaMPGYf3NfnKNqBrMy32lPKifIUuSFc1k7yZ2Jrv7LABf5PwEcK3+5TzIzbB/x7j
 csxjiKjYhyw49QsJ8na0XlfVzVbb9JUm9fS5/f8UT1H1nGPJVCHU3ZwGP/x26ZK1l4Og
 iMdTF9CrN4xhFKiVNIPFv/ty39sfLkpZESv97dwaAV+Qo1zskBRzMMIFAMDEXBCFtzwC
 IghA==
X-Gm-Message-State: AOJu0YzyH7EzcMIHBmPuLmhKjhP07UR5720FRL7MbKEBgiFRZylycInN
 Ddrot3+DaQmdSKsKFqSF9Pqgmy3XC7+C0d2GoNferi7eHCZWTNDPeS+jydNPzek=
X-Google-Smtp-Source: AGHT+IHNB3gzgnpUvwmkoYHdoBmBPIglgM2UO6EQnYAcPStKUDZ5vJeW1Mp5B3bT3+eMQ9tYJU/TzA==
X-Received: by 2002:a17:907:5c1:b0:a51:ce66:cf12 with SMTP id
 wg1-20020a17090705c100b00a51ce66cf12mr2718529ejb.35.1712575062719; 
 Mon, 08 Apr 2024 04:17:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a170906069000b00a51d45b289dsm1351322ejb.81.2024.04.08.04.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 04:17:42 -0700 (PDT)
Message-ID: <6fbcf565-f12c-4196-b6c8-559843c7a78c@linaro.org>
Date: Mon, 8 Apr 2024 13:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 2/2] hw/misc/applesmc: Fix memory leak in reset()
 handler
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Zheyu Ma <zheyuma97@gmail.com>
References: <20240408095217.57239-1-philmd@linaro.org>
 <20240408095217.57239-3-philmd@linaro.org>
 <CAFEAcA-GO0nVyjVy3WR8LrZ3qMJvpjOzncVGGDuU3hzziKm8uQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-GO0nVyjVy3WR8LrZ3qMJvpjOzncVGGDuU3hzziKm8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 8/4/24 12:34, Peter Maydell wrote:
> On Mon, 8 Apr 2024 at 10:53, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> AppleSMCData is allocated with g_new0() in applesmc_add_key():
>> release it with g_free().
>>
>> Leaked since commit 1ddda5cd36 ("AppleSMC device emulation").
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2272
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/misc/applesmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
>> index 8e65816da6..14e3ef667d 100644
>> --- a/hw/misc/applesmc.c
>> +++ b/hw/misc/applesmc.c
>> @@ -274,6 +274,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
>>       /* Remove existing entries */
>>       QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
>>           QLIST_REMOVE(d, node);
>> +        g_free(d);
>>       }
>>       s->status = 0x00;
>>       s->status_1e = 0x00;
>> --
> 
> Cc stable?
> 
> This is the right minimal fix for the leak, so
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> but overall this is a bit odd. We don't change either the
> keys or their values at runtime, they seem to be a fixed
> set defined by the device properties, so why are we tearing
> them down and readding them every reset? It would be
> simpler to create the data structure once at device realize.

This was my first approach, moving the applesmc_add_key()
calls to the realize() handler, and freeing them in a
unrealize() one:

-- >8 --
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 14e3ef667d..59a4899312 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -145,7 +145,7 @@ static void applesmc_io_cmd_write(void *opaque, 
hwaddr addr, uint64_t val,
      s->data_pos = 0;
  }

-static struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
+static const struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
  {
      struct AppleSMCData *d;

@@ -161,7 +161,7 @@ static void applesmc_io_data_write(void *opaque, 
hwaddr addr, uint64_t val,
                                     unsigned size)
  {
      AppleSMCState *s = opaque;
-    struct AppleSMCData *d;
+    const struct AppleSMCData *d;

      smc_debug("DATA received: 0x%02x\n", (uint8_t)val);
      switch (s->cmd) {
@@ -269,23 +269,10 @@ static void applesmc_add_key(AppleSMCState *s, 
const char *key,
  static void qdev_applesmc_isa_reset(DeviceState *dev)
  {
      AppleSMCState *s = APPLE_SMC(dev);
-    struct AppleSMCData *d, *next;

-    /* Remove existing entries */
-    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
-        QLIST_REMOVE(d, node);
-        g_free(d);
-    }
      s->status = 0x00;
      s->status_1e = 0x00;
      s->last_ret = 0x00;
-
-    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
-    applesmc_add_key(s, "OSK0", 32, s->osk);
-    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
  }

  static const MemoryRegionOps applesmc_data_io_ops = {
@@ -343,6 +330,24 @@ static void applesmc_isa_realize(DeviceState *dev, 
Error **errp)
      }

      QLIST_INIT(&s->data_def);
+    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
+    applesmc_add_key(s, "OSK0", 32, s->osk);
+    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
+    applesmc_add_key(s, "NATJ", 1, "\0");
+    applesmc_add_key(s, "MSSP", 1, "\0");
+    applesmc_add_key(s, "MSSD", 1, "\0x3");
+}
+
+static void applesmc_unrealize(DeviceState *dev)
+{
+    AppleSMCState *s = APPLE_SMC(dev);
+    struct AppleSMCData *d, *next;
+
+    /* Remove existing entries */
+    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
+        QLIST_REMOVE(d, node);
+        g_free(d);
+    }
  }

  static Property applesmc_isa_properties[] = {
@@ -377,6 +382,7 @@ static void qdev_applesmc_class_init(ObjectClass 
*klass, void *data)
      AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);

      dc->realize = applesmc_isa_realize;
+    dc->unrealize = applesmc_unrealize;
      dc->reset = qdev_applesmc_isa_reset;
      device_class_set_props(dc, applesmc_isa_properties);
      set_bit(DEVICE_CATEGORY_MISC, dc->categories);

---

But since a bit too much changes for the next release, I kept
it as a separate patch.

Thanks for the review,

Phil.

