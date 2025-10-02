Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA28ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 05:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Bgt-0000HO-9q; Thu, 02 Oct 2025 01:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Bgm-0000DW-T1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:17:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4BgX-0006mZ-Mv
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:17:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so4206235e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759382202; x=1759987002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nP44d4h1jekHn6mFqnHJmhmS/9Do5wl9GUaQdd3lrCA=;
 b=iMhgCPTQFqYwu0mpP15WIsbiNqAlN5zdk6XCF9cgoUBwdeOliMoFq6wzVjZz4aC0R8
 hKxnxKLHI7iN3o7xFSEISsMtLc+TTDOM8iTLgwDDFjhQR9OWOXgwollgigRpOu0fIFgJ
 JJg0AfE4fvVdnvU6vMrss2J7kU94oe5pB0d8t/lTdCfcKphVswc+O2tSd5TtElwIrrBT
 p61KcMYDxv0NJXAVT9ljK9Uv7LJRI5lwR0b0aBPovneYnwOWugdltNp35M154bekPxR5
 SbOknKKs9yZPEsWknmzw5M2/rmIJfMAqgUnQ8RvtkpEzgHQewiAdEwtViNWub+R1hoCC
 F4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759382202; x=1759987002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nP44d4h1jekHn6mFqnHJmhmS/9Do5wl9GUaQdd3lrCA=;
 b=Lwz5bhhWhp8phjQy2F25lnGKU8vozuzTf4u+pTjDSN+PiVCCYFzjwPcfxRK8kEDSHg
 1KPmS4B6kjXQxE/RDixiFcJm6JxhK3DbRG4cukmes2pxP0wu83nnsvzMzziFqPmNOETV
 rPSGYsJiyOlMQ6l8Wj5Eew5jaju8u4bU8bwnN/2mzcoVDoD+ygn2cMLadZ2WLtDq3+yw
 CMTHcK8VIxRKuWtGXC/HXjPe3TCMcsyidWcMsexEihZirl9QUS0/epHIuRuSF+aiQsvH
 s2XzAVdgCRQ+08bO2RlYKY1J8Ir5f8pp55lAVjGyED1MimxIhqpIlE9be0zMIgSVEYxF
 4s5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ7vONY/pWabcLL8E3x2vhTqdtOhidwxZh9pVfBfBwylZ19Hi5vrjaSYbhg4LoxUp306a4KM3foWag@nongnu.org
X-Gm-Message-State: AOJu0YzYUHVKmLrpgsaTfNVZocQiZZ48zqb4vEi/h26jt/8y59qBNgUa
 RplSOksiwtQOoJ3XV8a7zxOmJSa275OmqMQQ8ohj+R3qzpLFVZVDr92tNJ+vr/TfD+E=
X-Gm-Gg: ASbGncuuKyEZdOYOqsnBIfX8kO0N8Ld3Rwoymmr/Rcv3Ca0/azgGL16PIDk1ksMDnL+
 AjZVv6n6jmfl2Atr0iwiV8k/QqJgDI3K36hAWN3y+pBSeq/L4SfxgCAUsSqj23sQKPA7VD0WvpM
 enLjyAOmZa/MnyDn5oFHVWvv0Ef375zab5DsLwcZ0f6HeOYVVGnGtcRCO6ET3x1qr/UyC6xquoN
 cRJThm/2nVYmueeAF7gRSVKD/VP0ajFQBoDvETM8iKh62roRMsYeBMbKhW+PnT1iruEgZ3FM9WH
 0tRPRAdNBFp3SSS/0dwX/tqBpgw/a4iVCGiHa903MqvmNRTA77FKzBnZAW+//aMPfJkFrX6jxtZ
 0DoGn30QLe5S9+n5E1m7P1IQEJ2aZW+wR5JZvChK+Lw29TOqZBbvPbgEQUdVCNqMBmAE2KgnGOP
 cTrgWev62t5NP8I23cPN9g9kM=
X-Google-Smtp-Source: AGHT+IFTCkFMkkXlWMIq3Vgvzt5IFWI271cdWtVJqy/RZz/1PwzpzG3SNgfPDaXsmuZn+VswPUUmHA==
X-Received: by 2002:a05:600c:3544:b0:46e:5df4:6f16 with SMTP id
 5b1f17b1804b1-46e61294d1emr46097095e9.35.1759382201614; 
 Wed, 01 Oct 2025 22:16:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a022d8sm62129355e9.12.2025.10.01.22.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 22:16:41 -0700 (PDT)
Message-ID: <b85d3293-0fcc-40ef-a170-256a20eb91cb@linaro.org>
Date: Thu, 2 Oct 2025 07:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/23] whpx: copy over memory management logic from hvf
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
 <20250920140124.63046-13-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250920140124.63046-13-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 20/9/25 16:01, Mohamed Mediouni wrote:
> This allows edk2 to work, although u-boot is still not functional.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/whpx/whpx-common.c | 201 ++++++++++++++++++++++++++++-----------
>   1 file changed, 147 insertions(+), 54 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index c69792e638..f324f5c146 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -258,89 +258,174 @@ void whpx_vcpu_kick(CPUState *cpu)
>    * Memory support.
>    */
>   
> -static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
> -                                void *host_va, int add, int rom,
> -                                const char *name)
> + /* whpx_slot flags */
> +#define WHPX_SLOT_LOG (1 << 0)
> +typedef struct whpx_slot {
> +    uint64_t start;
> +    uint64_t size;
> +    uint8_t *mem;
> +    int slot_id;
> +    uint32_t flags;
> +    MemoryRegion *region;
> +} whpx_slot;
> +
> +typedef struct WHPXState {
> +    whpx_slot slots[32];
> +    int num_slots;
> +} WHPXState;
> +
> + WHPXState *whpx_state;
> +
> + struct mac_slot {
> +    int present;
> +    uint64_t size;
> +    uint64_t gpa_start;
> +    uint64_t gva;
> +};
> +
> +struct mac_slot mac_slots[32];
> +
> +static int do_whpx_set_memory(whpx_slot *slot, WHV_MAP_GPA_RANGE_FLAGS flags)
>   {
>       struct whpx_state *whpx = &whpx_global;
> +    struct mac_slot *macslot;
>       HRESULT hr;
>   
> -    /*
> -    if (add) {
> -        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
> -               (void*)start_pa, (void*)size, host_va,
> -               (rom ? "ROM" : "RAM"), name);
> -    } else {
> -        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
> -               (void*)start_pa, (void*)size, host_va, name);
> +    macslot = &mac_slots[slot->slot_id];
> +
> +    if (macslot->present) {
> +        if (macslot->size != slot->size) {
> +            macslot->present = 0;
> +            hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
> +                 macslot->gpa_start, macslot->size);
> +            if (FAILED(hr)) {
> +                abort();
> +            }
> +        }
>       }
> -    */
> -
> -    if (add) {
> -        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
> -                                         host_va,
> -                                         start_pa,
> -                                         size,
> -                                         (WHvMapGpaRangeFlagRead |
> -                                          WHvMapGpaRangeFlagExecute |
> -                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
> -    } else {
> -        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
> -                                           start_pa,
> -                                           size);
> +
> +    if (!slot->size) {
> +        return 0;
>       }
>   
> -    if (FAILED(hr)) {
> -        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
> -                     " Host:%p, hr=%08lx",
> -                     (add ? "MAP" : "UNMAP"), name,
> -                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
> +    macslot->present = 1;
> +    macslot->gpa_start = slot->start;
> +    macslot->size = slot->size;
> +    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
> +         slot->mem, slot->start, slot->size, flags);
> +    return 0;
> +}

[...]

This HVF code is bogus and Richard has been heavily reworking it. We
haven't posted the changes so far, but IMHO it is worth waiting them
to compare before proceeding with this series. I'll let Richard briefly
explain what we had to change ;)

Regards,

Phil.

