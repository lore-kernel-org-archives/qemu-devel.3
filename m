Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB6CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoJr-0001zO-4X; Fri, 02 May 2025 07:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoJp-0001xR-Ik
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:12:37 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoJn-0004wX-8n
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:12:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so273445066b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746184353; x=1746789153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gu7R9oUBo6pDCr1SSnvgpdbNyfx5mVxe3g41U0A+MTw=;
 b=RvSbZUXMczbxxd7HRaTj2Zu5e2Fh8Q8CnPIQBL0FavAcOJreOuCq7T7+u/DtBb5SB8
 eTYdSHHU1DuSp2n4cF/GKqJtTYS7hKixEiVqAaQHiWc2OmmPKTbWYYyd1fSAkhfqffqk
 u0bUkqfWQNEoitLc18O4dE0c2fCCONkkrZMK0rCEqSBRK4wf2ho8+jUo6cHy3krJ07iy
 5n+7MlzdXY/TqIcul8ugM4+S8da9bLrO3q6GqkfRp8LyW8HSn4ylAifcUQGCVOe4GcYz
 PBk4LOjgTD6berRddIR/6YdPf6Pt+YdpdWnP6Eg3+z/D92/sWjyzJsX+Se4ieXetEMPp
 93Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746184353; x=1746789153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gu7R9oUBo6pDCr1SSnvgpdbNyfx5mVxe3g41U0A+MTw=;
 b=smTWYVI20Wgz3TKjbLNcgi9mmIRrdR+DNef062ZXGyNhVLMFCP2xcAlTyjA9cdQZAZ
 sBLIqN9/tVAQrzbPuSkbY5713YQRaOn+/S8HBBKSJ4vtByY55siJecQqkrKlfxxg2fnN
 5Hs1QmCu+C0Hfo7pDnNujiOutOJHy0RttaJh4QkZyIMmyRpth5acIN9lw/ehOzJ384IL
 m52vwsNmF5ekkENiqnLvOy6EKhGEnx8G9tgLXoQibtUu/8rckFlSNerXEcxJ06KdKrKK
 FN/WL7UuzJkPkUPMnBGb6dEMR5Fmo4B1dPeEd9bmgNsIt3xIHguuo4AwYURH9fGnEvmc
 LrzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeU+Wc3VAEskhhMUUb9uEFrDhLv2ugWARqv8TNGXxc/2A49H/o6iyEtHYpdU6Hexi4OjGYEqx+JyJB@nongnu.org
X-Gm-Message-State: AOJu0Yw7ghFKQupeMxEW9MfuBJoAAzL1IujYhfyX9VFn3xYK6zFR9wBm
 YpOIYuuw8phhNYQmziaTJUi+tLCldrhKVnVACHwyO+SKPWfkHE2xD4Vx7MfdfwZVlhMw4JU0Sfq
 c
X-Gm-Gg: ASbGncv2Lul5W49bsgi7Yo1yo9zvUXY3H+VtrOsitgJ5TV3BBASDL+RiJ0URcNI1Cv9
 p27Jb6qkIBrE14njqN8p/Dm9XE786arlj62rj3qIhyYcTuzLZCAO02RFntOKQFy+4Lu/cCGGyHG
 LxVtNoKH68kBjqkunYzjhDelNz6B1vbl/V7Fdpsv5aP3u4o5ojw0MhA74FdoSCIQ6Y68iubPwFZ
 z6+E+x+3EN6QyVXZqg4EaJzUXw1aDgTn+6lPT7QYooR8Hf24fLgt+SVNu2FiN7NvmxXhTSwHV7S
 5zCcXyZYptSbxevHlug6+WMn9u4FUmpu4s9aPcQs0LKCIFAC1/2xVCIal7IR20JUdmx/5IhkkJR
 HCD6k8ZM3
X-Google-Smtp-Source: AGHT+IFrcGh9fbCtSw1wUA9piT7ZHWRxFjnPMQs73AAIR1AxROHH1VoeGUquL8/8/1y96xB5ARGAPQ==
X-Received: by 2002:a17:907:3d90:b0:ace:3ede:9d26 with SMTP id
 a640c23a62f3a-ad17adabf17mr257746066b.27.1746184353017; 
 Fri, 02 May 2025 04:12:33 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891473a1sm34950466b.4.2025.05.02.04.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 04:12:32 -0700 (PDT)
Message-ID: <d1090a93-242b-43a6-91b2-0c4350ad785d@linaro.org>
Date: Fri, 2 May 2025 13:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] hw/intc/ioapic: Remove
 IOAPICCommonState::version field
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-14-philmd@linaro.org>
 <c72e80c2-264a-4b4c-a782-e02d9d96f608@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c72e80c2-264a-4b4c-a782-e02d9d96f608@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 2/5/25 11:31, Mark Cave-Ayland wrote:
> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
> 
>> The IOAPICCommonState::version integer was only set
>> in the hw_compat_2_7[] array, via the 'version=0x11'
>> property. We removed all machines using that array,
>> lets remove that property, simplify by only using the
>> default version (defined as IOAPIC_VER_DEF).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/intc/ioapic_internal.h |  3 +--
>>   hw/intc/ioapic.c          | 18 ++----------------
>>   hw/intc/ioapic_common.c   |  2 +-
>>   3 files changed, 4 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
>> index 51205767f44..330ce195222 100644
>> --- a/hw/intc/ioapic_internal.h
>> +++ b/hw/intc/ioapic_internal.h
>> @@ -82,7 +82,7 @@
>>   #define IOAPIC_ID_MASK                  0xf
>>   #define IOAPIC_VER_ENTRIES_SHIFT        16
>> -
>> +#define IOAPIC_VER_DEF                  0x20
>>   #define TYPE_IOAPIC_COMMON "ioapic-common"
>>   OBJECT_DECLARE_TYPE(IOAPICCommonState, IOAPICCommonClass, 
>> IOAPIC_COMMON)
>> @@ -104,7 +104,6 @@ struct IOAPICCommonState {
>>       uint32_t irr;
>>       uint64_t ioredtbl[IOAPIC_NUM_PINS];
>>       Notifier machine_done;
>> -    uint8_t version;
>>       uint64_t irq_count[IOAPIC_NUM_PINS];
>>       int irq_level[IOAPIC_NUM_PINS];
>>       int irq_eoi[IOAPIC_NUM_PINS];
>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
>> index 133bef852d1..5cc97767d9d 100644
>> --- a/hw/intc/ioapic.c
>> +++ b/hw/intc/ioapic.c
>> @@ -315,7 +315,7 @@ ioapic_mem_read(void *opaque, hwaddr addr, 
>> unsigned int size)
>>               val = s->id << IOAPIC_ID_SHIFT;
>>               break;
>>           case IOAPIC_REG_VER:
>> -            val = s->version |
>> +            val = IOAPIC_VER_DEF |
>>                   ((IOAPIC_NUM_PINS - 1) << IOAPIC_VER_ENTRIES_SHIFT);
>>               break;
>>           default:
>> @@ -411,8 +411,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, 
>> uint64_t val,
>>           }
>>           break;
>>       case IOAPIC_EOI:
>> -        /* Explicit EOI is only supported for IOAPIC version 0x20 */
>> -        if (size != 4 || s->version != 0x20) {
>> +        if (size != 4) {
>>               break;
>>           }
>>           ioapic_eoi_broadcast(val);
>> @@ -444,18 +443,10 @@ static void ioapic_machine_done_notify(Notifier 
>> *notifier, void *data)
>>   #endif
>>   }
>> -#define IOAPIC_VER_DEF 0x20
>> -
>>   static void ioapic_realize(DeviceState *dev, Error **errp)
>>   {
>>       IOAPICCommonState *s = IOAPIC_COMMON(dev);
>> -    if (s->version != 0x11 && s->version != 0x20) {
>> -        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
>> -                   "(default: 0x%x).", IOAPIC_VER_DEF);
>> -        return;
>> -    }
>> -
>>       memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>>                             "ioapic", 0x1000);
>> @@ -476,10 +467,6 @@ static void ioapic_unrealize(DeviceState *dev)
>>       timer_free(s->delayed_ioapic_service_timer);
>>   }
>> -static const Property ioapic_properties[] = {
>> -    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, 
>> IOAPIC_VER_DEF),
>> -};
>> -
>>   static void ioapic_class_init(ObjectClass *klass, const void *data)
>>   {
>>       IOAPICCommonClass *k = IOAPIC_COMMON_CLASS(klass);
>> @@ -493,7 +480,6 @@ static void ioapic_class_init(ObjectClass *klass, 
>> const void *data)
>>        */
>>       k->post_load = ioapic_update_kvm_routes;
>>       device_class_set_legacy_reset(dc, ioapic_reset_common);
>> -    device_class_set_props(dc, ioapic_properties);
>>   }
>>   static const TypeInfo ioapic_info = {
>> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
>> index fce3486e519..8b3e2ba9384 100644
>> --- a/hw/intc/ioapic_common.c
>> +++ b/hw/intc/ioapic_common.c
>> @@ -83,7 +83,7 @@ static void ioapic_print_redtbl(GString *buf, 
>> IOAPICCommonState *s)
>>       int i;
>>       g_string_append_printf(buf, "ioapic0: ver=0x%x id=0x%02x 
>> sel=0x%02x",
>> -                           s->version, s->id, s->ioregsel);
>> +                           IOAPIC_VER_DEF, s->id, s->ioregsel);
>>       if (s->ioregsel) {
>>           g_string_append_printf(buf, " (redir[%u])\n",
>>                                  (s->ioregsel - 
>> IOAPIC_REG_REDTBL_BASE) >> 1);
> 
> Mildly curious that other than the reported version the version field 
> doesn't appear to control anything else - was the original bug that QEMU 
> implemented a 0x20 IOAPIC but incorrectly reported it as a 0x11 IOAPIC?

I'll mention:

commit 20fd4b7b6d9282fe0cb83601f1821f31bd257458
Author: Peter Xu <peterx@redhat.com>
Date:   Mon Aug 1 21:59:19 2016 +0800

     x86: ioapic: add support for explicit EOI

     Some old Linux kernels (upstream before v4.0), or any released RHEL
     kernels has problem in sending APIC EOI when IR is enabled.
     Meanwhile, many of them only support explicit EOI for IOAPIC, which
     is only introduced in IOAPIC version 0x20. This patch provide a way
     to boost QEMU IOAPIC to version 0x20, in order for QEMU to correctly
     receive EOI messages.

     Without boosting IOAPIC version to 0x20, kernels before commit
     d32932d ("x86/irq: Convert IOAPIC to use hierarchical irqdomain
     interfaces") will have trouble enabling both IR and level-triggered
     interrupt devices (like e1000).

     To upgrade IOAPIC to version 0x20, we need to specify:

       -global ioapic.version=0x20

     To be compatible with old systems, 0x11 will still be the default
     IOAPIC version. Here 0x11 and 0x20 are the only versions to be
     supported.

     One thing to mention: this patch only applies to emulated IOAPIC. It
     does not affect kernel IOAPIC behavior.

(see also:)

commit 048a2e8869cb7e26013e40d860c9ebdf8e28c2ac
Author: Peter Xu <peterx@redhat.com>
Date:   Fri Sep 23 13:33:15 2016 +0800

     x86: ioapic: boost default version to 0x20

     It's 2.8 now, and maybe it's time to switch IOAPIC default version to
     0x20.

     Signed-off-by: Peter Xu <peterx@redhat.com>
     Message-Id: <1474608795-23058-1-git-send-email-peterx@redhat.com>
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/include/hw/compat.h b/include/hw/compat.h
index a1d66944924..46412b229a7 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -8,0 +9,4 @@
+    },{\
+        .driver   = "ioapic",\
+        .property = "version",\
+        .value    = "0x11",\
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 31791b09860..fd9208fde08 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -419 +419 @@ static Property ioapic_properties[] = {
-    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, 0x11),
+    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, 0x20),

> 
> Anyhow the diff itself looks good so:
> 
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thanks!

