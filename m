Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E663E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ0-00050T-6u; Mon, 29 Dec 2025 13:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIHp-0003le-EW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:14 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIHi-0008I5-Si
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:07 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7f1243792f2so6202582b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767034075; x=1767638875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HjlNaSuWDJGQZltEQ1Gr0JR+hacBIOSScxQel3kNd0c=;
 b=rJ9tI3wFW/iSVfhuqIsRKZnq8NDRsXLrw92THsRCBWoBWzqqFL3GzVF3uoTkKi2r4D
 J0FpLb4GXyimW1UpqzlJxP6tMCLqHR4kuyqt1Cofr94mJ2nHetfgOVQgltqQwPg6nKIY
 1i7bXqGklG1SPFHGNnDQgKg6t9TZRKYxbAWNVApCtWDqP6RtiMRKtZTtiGxk0BfAh3yL
 MuFsbYfAJuC+gvdrE99ZJCAnoLjkG1vsNLU7wyQSPRfuiZZm+cjDjYarezCt7VZnsE40
 ELpGYjuA2Tv44mOkdGbQyjWfw0f+D92OMiy5An2OW12J3YtkbhMsO6CylI812gS7Rrcq
 kP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034075; x=1767638875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjlNaSuWDJGQZltEQ1Gr0JR+hacBIOSScxQel3kNd0c=;
 b=OQ6krWTydMQvONvaiTyeDINZOLUoXKIG5MzLbuiNEtvTSqFl8a6mw1dmuVv+C7Nwn3
 rquNqA1KLjni4qhqZ/89pg3JaTVaaJgon0B8FmyGk76nAd2PHiyEWKFvbxQ5Ms5tUkXJ
 TA6VM3uFi/E2pSm9M33/RbMlkhsWSBgOUDpGDo3SyYvdyTjCGVUoCkQyF/+IlGMrtKmw
 zxb8UML4uGllBtgMxvpJf9bnllDCnqY0F+hREb0vOPPudqnXGb2RL7xCKeYEbaF8ihRf
 rEt33cgNR4YnskBJlMco+3uMVQqUadB9EJutbUUjybk5o32suw4I2YW/FbaLQOUWoLnE
 c0rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd4Pc0hF9/5TiTc2wzogPHTHL6PKFrSWie7y/Z3Uql3ohdRy3OCjMsh98HIrDcZxQFDz4Umhk1qOaD@nongnu.org
X-Gm-Message-State: AOJu0Yx1TG1HwiMTfBHiqNM195LNYGx3rbjmO/hPjgKxafW/osBZ1tkM
 3NjUso7CeNr1uAD16DgLgLoLJ3oUXbjRzxogfqhh6uLmpCh4SoDuPBHIbedieBKdtAc=
X-Gm-Gg: AY/fxX7DD5ELVcD0RxauadkWrF64nS38gyLDktZ/CFB/18gLaYYNm/Vh1Hw0uiD9gv3
 qkpWaBaRs02/rlAtFRZPP1dqMKjf4NdzDKVjXGbJqYziC+shAx62u25mlDQSPmT1k8VXrRSq4zN
 b20C39C1wF/4KTPioUW4a5zJ0UoBmsJvJpMpII8Q5zMVslGEVXQJVJjTF1X3Ln3mR1UskyquaLu
 dAFwdnIvXgRx+OflG4Mvs/XmN7Osqbe92hm0aKVRPSnr1UHm66dC1lUZ/C+73CxVWoeY1NYFZdW
 Qgg+OxNTt8JqzMKjwSdymMjN0JMO94+/VlN1MGkXwEhbROpyh+u2brKuB6GDpgOJActwaj07QG4
 wzfT9fNEBCWzuu8vuZsqIP1/OKOt9JeyUQEJJAYc6o8ljWwErcDNq2Ifh/r3x5DXqpvcqAGwdtS
 5ml7fMnERGxlU89AAhb1AsWgUzBfH12A8Jra9PCojMs/XWxPUTf1PIvLIE
X-Google-Smtp-Source: AGHT+IEUM+PySF9fE8H6bjy183pC3XDOTIMWhOvzxGMlStDSQ2Wun5rqsTGiiIaVABn6oh8OTNpFoA==
X-Received: by 2002:a05:6a00:e11:b0:7a2:6c61:23fc with SMTP id
 d2e1a72fcca58-7ff64ed12f8mr27507105b3a.10.1767034074553; 
 Mon, 29 Dec 2025 10:47:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a19d8sm30113899b3a.42.2025.12.29.10.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 10:47:54 -0800 (PST)
Message-ID: <4344a029-90f1-4268-8822-779411de18ac@linaro.org>
Date: Mon, 29 Dec 2025 10:47:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/28] whpx: change memory management logic
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-18-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> This allows edk2 to work on Arm, although u-boot is still not functional.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c | 97 +++++++++++++++-------------------------
>   1 file changed, 36 insertions(+), 61 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 0d20b1d24c..e0db8ace4a 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -259,89 +259,64 @@ void whpx_vcpu_kick(CPUState *cpu)
>    * Memory support.
>    */
>   
> -static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
> -                                void *host_va, int add, int rom,
> -                                const char *name)
> +static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
>   {
>       struct whpx_state *whpx = &whpx_global;
> +    MemoryRegion *area = section->mr;
> +    bool writable = !area->readonly && !area->rom_device;
> +    WHV_MAP_GPA_RANGE_FLAGS flags;
> +    uint64_t page_size = qemu_real_host_page_size();
> +    uint64_t gva = section->offset_within_address_space;
> +    uint64_t size = int128_get64(section->size);
>       HRESULT hr;
> +    void *mem;
>   
> -    /*
> -    if (add) {
> -        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
> -               (void*)start_pa, (void*)size, host_va,
> -               (rom ? "ROM" : "RAM"), name);
> -    } else {
> -        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
> -               (void*)start_pa, (void*)size, host_va, name);
> -    }
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
> -    }
> -
> -    if (FAILED(hr)) {
> -        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
> -                     " Host:%p, hr=%08lx",
> -                     (add ? "MAP" : "UNMAP"), name,
> -                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
> +    if (!memory_region_is_ram(area)) {
> +        if (writable) {
> +            return;
> +        } else if (!memory_region_is_romd(area)) {
> +             add = false;
> +        }

ERROR: suspect code indent for conditional statements (8, 13)
#48: FILE: accel/whpx/whpx-common.c:277:
+        } else if (!memory_region_is_romd(area)) {
+             add = false;

Seems like a false positive from checkpatch, easier to write a second if 
to workaround this.

>       }
> -}
> -
> -static void whpx_process_section(MemoryRegionSection *section, int add)
> -{
> -    MemoryRegion *mr = section->mr;
> -    hwaddr start_pa = section->offset_within_address_space;
> -    ram_addr_t size = int128_get64(section->size);
> -    unsigned int delta;
> -    uint64_t host_va;
>   
> -    if (!memory_region_is_ram(mr)) {
> -        return;
> +    if (!QEMU_IS_ALIGNED(size, page_size) ||
> +        !QEMU_IS_ALIGNED(gva, page_size)) {
> +        /* Not page aligned, so we can not map as RAM */
> +        add = false;
>       }
>   
> -    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
> -    delta &= ~qemu_real_host_page_mask();
> -    if (delta > size) {
> -        return;
> -    }
> -    start_pa += delta;
> -    size -= delta;
> -    size &= qemu_real_host_page_mask();
> -    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
> +    if (!add) {
> +        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
> +                gva, size);
> +        if (FAILED(hr)) {
> +            error_report("WHPX: failed to unmap GPA range");
> +            abort();
> +        }
>           return;
>       }
>   
> -    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
> -            + section->offset_within_region + delta;
> +    flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute
> +     | (writable ? WHvMapGpaRangeFlagWrite : 0);
> +    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
>   
> -    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
> -                        memory_region_is_rom(mr), mr->name);
> +    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
> +         mem, gva, size, flags);
> +    if (FAILED(hr)) {
> +        error_report("WHPX: failed to map GPA range");
> +        abort();
> +    }
>   }
>   
>   static void whpx_region_add(MemoryListener *listener,
>                              MemoryRegionSection *section)
>   {
> -    memory_region_ref(section->mr);
> -    whpx_process_section(section, 1);
> +    whpx_set_phys_mem(section, true);
>   }
>   
>   static void whpx_region_del(MemoryListener *listener,
>                              MemoryRegionSection *section)
>   {
> -    whpx_process_section(section, 0);
> -    memory_region_unref(section->mr);
> +    whpx_set_phys_mem(section, false);
>   }
>   
>   static void whpx_transaction_begin(MemoryListener *listener)


