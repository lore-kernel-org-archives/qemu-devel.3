Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC6BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCS0h-00025B-Rb; Thu, 01 Oct 2026 21:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCS0b-00024H-Th
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCS0X-0003mu-1P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790904249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
 b=J11H8uAA0DgAHK06DBJdhdRWCEHsvLbaLxQSYTciVAE6yw4J0xITeXh1ncHIZ4BkQ31gIt
 WdieGhZ/0ZnxCPWFBDQXsXLZxK9q9GAXPU3wKzFWFCtTaNBol5Bw4xsPUlYNHQbFOj7CEm
 KB6YtCR714aBtInkAp/NUjLPlR7W9m4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-2oXfuxu8MgKhsruyY6jfRQ-1; Thu, 01 Oct 2026 21:24:08 -0400
X-MC-Unique: 2oXfuxu8MgKhsruyY6jfRQ-1
X-Mimecast-MFC-AGG-ID: 2oXfuxu8MgKhsruyY6jfRQ_1790904246
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso7998236a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790904245; x=1791509045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
 b=LOWtZnEN8+9sA7rWqN4ACjux3aa2Y14kBkxoFTSMuU1vFxEp1cX/0UfXsL8C0XzMoi
 ucuwxlbdQyETKwlbiwtP41+LXPI0Ajmbea+jRCN1CZxcoitcE7EQa/NDBEICtwe11I3I
 lNMVNnWe3g4POdHf7jGs+DbQVZdWMdHkOQJHCCHT+q4953QcQwrkZVIq/ZfYMAm+usc0
 p0d2+n6DMuZykHEh7dLVwGndWgNYOAPh78z5iWbaEzLUgBTavcwma9JEqSpjiakSng0P
 d1J6hVROiXwNfKMxhh13dz1yvrLPzq+epoCktkCKcNkqVGnctZkC6S6u0Zt0l6MtBekV
 OFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790904245; x=1791509045;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
 b=pbttRUPaU0/zoHcN3lsnTq16CoZ62gbcEgBWbtcLmbAejLlb3tJMuLZFHqiAS0gI91
 8lhfrAfF4f119FpVD779PumhicXhBd+VRv+b/8WfqVniujCVNKqe0Q6pcxg4b45+zEZX
 w+dzHWg2O+3M/TAj/Jw4tJr1UIi5+4eShltkQvNkxeYyy/wtz++o2KDQ9J4K5mtCtUNv
 mDW9l/cRT/zD49QFz0E3jUsVSysltZ5/JmzmWHLzYppjYbrnUIbXlfYYrwUqfif+XVHV
 SU8Wrc4Mqm2kaZ03SGG3zV37nsCjvgiqk9V3YwtMnuAJURNE0xWZwj3/dAE31LL1Oczu
 /Mlw==
X-Gm-Message-State: AFuF++l/M0XTtKasfxx40doqcNxcjM6ITfaBv4tivO4MZh7ZLX/krvWF
 86/tw0Fw/ZsMyyCGdKNOdr+otXDfHADeXLBP08kW/ewfliyw8agKJ1C7yS+0ZYKYNsGTQcgwWAC
 i0fy7rF5Ys77rLe1jXTmzGxNiRgscFXn0sWiXpNyxrdl94Ptc3EUuESTC
X-Gm-Gg: AYBFou0WKr1PFlFaCU3F44x+lnRsaJbYqlvoEd/RVX9QLgQQ5kowAHjrZg+WtE2bTpM
 i4yLoNJFBdeU4uSq2TSbbhM6qFLI6xgAKLDPCqNqFjzJHtsTp+Aw0ar7DJUEvpPneK/lhM2Zrjy
 IkPniWK9kfPNfe19EPyb2IoPABmMIBF1L2Tv4IrGjt0gdR5t/8jNILX24G1Kt8XXAYrakhGXhyI
 CRDYHHU8WhNxGfgNbp8o/rJPZofqg6VMvbnxGjb7MogE6AWK1Brgc4XjRznDKp4LiGFy31/L0rb
 YLDp1hcqTqE5h36+n6lZPjNwa5jd0qa8njubIQt+wgkbi1KYtbQ+cIDFfnxoYnGBFOUlTvSp3yw
 gzHsetQMEj+tzldYWH7LbhqvVXsIr1/xIIKDCb+iaFg==
X-Received: by 2002:a05:6a21:4ead:b0:3dd:a196:69df with SMTP id
 adf61e73a8af0-3e0bd12e409mr1203132637.58.1790904245521; 
 Thu, 01 Oct 2026 18:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ead:b0:3dd:a196:69df with SMTP id
 adf61e73a8af0-3e0bd12e409mr1203101637.58.1790904244966; 
 Thu, 01 Oct 2026 18:24:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f7384ca1sm297063a12.21.2026.10.01.18.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 18:24:04 -0700 (PDT)
Message-ID: <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>
Date: Fri, 2 Oct 2026 11:23:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-11-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> That way we can deterministically calculate the Realm Initial Measurement (RIM).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index f7c2cc786e2c..9985f5daba89 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -10,6 +10,7 @@
>   
>   #include "hw/core/boards.h"
>   #include "hw/core/cpu.h"
> +#include "hw/core/loader.h"
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> @@ -22,8 +23,18 @@
>   #define TYPE_RME_GUEST "rme-guest"
>   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +    uint8_t *data;
> +} RmeRamRegion;
> +

This is the equivalent to 'RomLoaderNotifyData' defined in PATCH[09/24]. We may
use 'RomLoaderNotifyData' if it can be renamed to reflect its purpose, no need
to define an identical structure.

>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
> +    Notifier rom_load_notifier;
> +    GSList *ram_regions;
>   };
>   
>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
>       kvm_mark_guest_state_protected();
>   }
>   
> +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> +{
> +    const RmeRamRegion *ra = a;
> +    const RmeRamRegion *rb = b;
> +
> +    g_assert(ra->base != rb->base);
> +    return ra->base < rb->base ? -1 : 1;
> +}
> +
> +static void rme_rom_load_notify(Notifier *notifier, void *data)
> +{
> +    RmeRamRegion *region;
> +    RomLoaderNotifyData *rom = data;
> +
> +    if (rom->addr == -1) {
> +        /*
> +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> +         * Instead the firmware will load them via fw_cfg and measure them
> +         * itself.
> +         */
> +        return;
> +    }
> +
> +    region = g_new0(RmeRamRegion, 1);
> +    region->base = rom->addr;
> +    region->size = rom->len;
> +    region->data = rom->data;
> +
> +    /*
> +     * The Realm Initial Measurement (RIM) depends on the order in which we
> +     * initialize and populate the RAM regions. To help a verifier
> +     * independently calculate the RIM, sort regions by GPA.
> +     */
> +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> +                                                   region,
> +                                                   rme_compare_ram_regions);
> +}
> +
>   static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>   {
>       KVMState *s = KVM_STATE(current_accel());
> @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>       error_setg(&rme_mig_blocker, "RME: migration is not implemented");
>       migrate_add_blocker(&rme_mig_blocker, &error_fatal);
>   
> +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> +
>       /*
>        * The realm activation is done last, when the VM starts, after all images
>        * have been loaded and all vcpus finalized.

Thanks,
Gavin


