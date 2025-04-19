Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86562C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 12:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u67iI-0008Iv-VY; Sat, 19 Apr 2025 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u67iH-0008Ik-Le
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 08:54:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u67iF-00017k-Cw
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 08:54:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so2343876f8f.1
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745067265; x=1745672065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUw8ScwyaGOHRb10VFP5Ct3zsmPYxEPSdahF4+2SvAw=;
 b=XfutjI1nHWGDEkp7XKkNgNQz4i386dFq4jmjyVWdpt053YI/P5E4HPFd6Tf4K6Dz7m
 wAuhXcjexLCgVp4PXV6Kbd5LaMRG9wpqcdS0hhJWVfbxsQkQ3kBTxNggrlO+ajyxqRe9
 nGGWKY4j5/j54zcMHJf+/fCpvmDjp11wJLGnygGy2SFX0HQVFzbInK0f8dHAXIfPuC2q
 tmruDRlDYT2glTGBITjbc28WsZ6NvL7gEhXjYY4mKYXVQvwKcIJCViWoYStPw1AZcsFH
 MQBsin9lVKMJuGwYUdmidsVm5lVyx0BRMS/eB+z91EpUrE+JztJMDGtpmqA0du17/L0S
 jPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745067265; x=1745672065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUw8ScwyaGOHRb10VFP5Ct3zsmPYxEPSdahF4+2SvAw=;
 b=HMsYXAat+icb0kLxfR1eKMaifhmUP5drYJPhHytU3sC6v1NX6KqjkZEqccQy3+ztZS
 HzUW7+GQ6zfVCMtNnuqfKVWQjTZILFMbiBMFrqGOQqIhYZxfp2Q+UeHehbKNZBY9FQPi
 3BYKVUWm4B9kITCRV6sAV7Bspim3aIIQl6X27BSMJoAuDyvYYHZKBTrDcC38ChXEYA2t
 X6PqyfcygUlyZvdWw7OkK8HQv9RIzxh3jbLprnbCKjB8wld39hAaSg6lbRSzltDKja71
 EzEekqEmEDkZkw3+pe5aDN+gqp6xoWXQ7Tafk0i2XvyMkIpe3Tf6V7t7z14lcePvwVK2
 oLpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZSiG6fygqGw6JAckGEHbZQ84HE05QC+YGnjE5Yrc/COqhVQBjLMX9eUNh2Tuum+I6wIv5o0JsPdv@nongnu.org
X-Gm-Message-State: AOJu0Yzvgmq/0nD1ofayDdIS2eZZF9KvVK7P4kOyEql9j4ZbRPVQkWGU
 UIeWus0N7irJYRPDvsG4ibM4J+c+SfM6kGWPsw0wl6g4qSBfCsIj60B9hTHEI7c=
X-Gm-Gg: ASbGnctYNzyNy2v6PHp2SJRUyIZBosC5M1VBB43rebaMUHoKqomAjBehwoKuQpJ4CWP
 WZuTEWJx5aNBnWSvnzVkib6XkTKMCcUT9EUANuE5BC95wu03ud8Y7CrUqXp7a2sW0epHzkzWgaJ
 DRGU/ClzQnYmuP4YUXJve73soXG7zxjYMnHLt810O6h942lbUlqSRVIOHTLx3utENOq1jH40Fbr
 JwJ23+TNJNVb342VJzuXvcvH58m5Ssn7Lda5mVzvsbJqmEqR1pdpdmqlZmEoGur+y3fEGvaVb9d
 OdNidT7u3f8U0QQ/wB93ade+AACLIbxn13wO7vpQnp6l2KsWbQt6F0NQQliSzAC9VokkCO6X/Lz
 EN3ogTf/x
X-Google-Smtp-Source: AGHT+IG647P7TgbAJ4UnMEP8/iBFuHCuY/b3X0Cb61GboCjdTCXP7D5yPqnw3QyQ9q/1jwvR4ttmZw==
X-Received: by 2002:a05:6000:184c:b0:391:212:459a with SMTP id
 ffacd0b85a97d-39efba51004mr4830602f8f.22.1745067264881; 
 Sat, 19 Apr 2025 05:54:24 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43315esm5673286f8f.26.2025.04.19.05.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 05:54:24 -0700 (PDT)
Message-ID: <ff7cdc09-f11c-43ae-b1e4-668c39db3efe@linaro.org>
Date: Sat, 19 Apr 2025 14:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
 <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 19/4/25 03:09, Pierrick Bouvier wrote:
> On 4/18/25 10:29, Philippe Mathieu-Daudé wrote:
>> Add a helper to distinct the binary is targetting
>> Aarch64 or not.
>>
>> Start with a dump strcmp() implementation, leaving
>> room for future optimizations.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/target_info.h | 7 +++++++
>>   target_info.c              | 5 +++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
>> index c67b97d66f3..9b7575ce632 100644
>> --- a/include/qemu/target_info.h
>> +++ b/include/qemu/target_info.h
>> @@ -24,4 +24,11 @@ const char *target_name(void);
>>    */
>>   const char *target_machine_typename(void);
>> +/**
>> + * target_aarch64:
>> + *
>> + * Returns whether the target architecture is Aarch64.
>> + */
>> +bool target_aarch64(void);
>> +
>>   #endif
>> diff --git a/target_info.c b/target_info.c
>> index 1de4334ecc5..87dd1d51778 100644
>> --- a/target_info.c
>> +++ b/target_info.c
>> @@ -19,3 +19,8 @@ const char *target_machine_typename(void)
>>   {
>>       return target_info()->machine_typename;
>>   }
>> +
>> +bool target_aarch64(void)
>> +{
>> +    return !strcmp(target_name(), "aarch64");
> 
> I don't think doing strcmp is a good move here, even temporarily.
> 
> A short term solution is making target_info.c target specific, and use:
> return TARGET_AARCH64;

IIUC as 
https://lore.kernel.org/qemu-devel/20231122183048.17150-3-philmd@linaro.org/?

> The long term solution, is to have a create target_current() that 
> returns an enum, and target_aarch64() would become:
> return target_current() == {ENUM}_AARCH64. We just need to find a good 
> name for {enum} which is not Target, since it's a poisoned identifier.
> 
> This way, we can easily convert the simple
> #ifdef TARGET_AARCH64 by if target_aarch64(),
> and more complicated combinations by a switch on target_current().

This was 
https://lore.kernel.org/qemu-devel/20250403234914.9154-4-philmd@linaro.org/, 
which was useful for the virtio-mem patch:

-- >8 --
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c7968ee0c61..b5d62411b3e 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -17,2 +17,3 @@
  #include "qemu/units.h"
+#include "qemu/target_info.h"
  #include "system/numa.h"
@@ -35,9 +36,17 @@ static const VMStateDescription 
vmstate_virtio_mem_device_early;

-/*
- * We only had legacy x86 guests that did not support
- * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have legacy 
guests.
- */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
-#define VIRTIO_MEM_HAS_LEGACY_GUESTS
-#endif
+static bool virtio_mem_has_legacy_guests(void)
+{
+    /*
+     * We only had legacy x86 guests that did not support
+     * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have
+     * legacy guests.
+     */
+    switch (target_system_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}

@@ -145,3 +154,2 @@ static uint64_t 
virtio_mem_default_block_size(RAMBlock *rb)

-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
  static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
@@ -156,3 +164,2 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  }
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */

@@ -999,24 +1006,26 @@ static void virtio_mem_device_realize(DeviceState 
*dev, Error **errp)

-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
-    switch (vmem->unplugged_inaccessible) {
-    case ON_OFF_AUTO_AUTO:
-        if (virtio_mem_has_shared_zeropage(rb)) {
-            vmem->unplugged_inaccessible = ON_OFF_AUTO_OFF;
-        } else {
-            vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+    if (virtio_mem_has_legacy_guests()) {
+        switch (vmem->unplugged_inaccessible) {
+        case ON_OFF_AUTO_AUTO:
+            if (virtio_mem_has_shared_zeropage(rb)) {
+                vmem->unplugged_inaccessible = ON_OFF_AUTO_OFF;
+            } else {
+                vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+            }
+            break;
+        case ON_OFF_AUTO_OFF:
+            if (!virtio_mem_has_shared_zeropage(rb)) {
+                warn_report("'%s' property set to 'off' with a memdev 
that does"
+                            " not support the shared zeropage.",
+                            VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            }
+            break;
+        default:
+            break;
          }
-        break;
-    case ON_OFF_AUTO_OFF:
-        if (!virtio_mem_has_shared_zeropage(rb)) {
-            warn_report("'%s' property set to 'off' with a memdev that 
does"
-                        " not support the shared zeropage.",
-                        VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
-        }
-        break;
-    default:
-        break;
+    } else if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+        error_setg(errp, "guest requires property '%s' to be 'on'",
+                   VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+        return;
      }
-#else /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
-    vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */

@@ -1713,6 +1722,4 @@ static const Property virtio_mem_properties[] = {
                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
      DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, 
VirtIOMEM,
                              unplugged_inaccessible, ON_OFF_AUTO_ON),
-#endif
      DEFINE_PROP_BOOL(VIRTIO_MEM_EARLY_MIGRATION_PROP, VirtIOMEM,
---

but I thought either you didn't like the approach or it was too early
to propose for the API, so I went back to strcmp.

> 
> For a first version, I think that the first solution is enough.


