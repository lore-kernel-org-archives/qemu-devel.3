Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 06:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aAo-0006SF-If; Tue, 15 Apr 2025 02:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aAd-0006NW-0G
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:53:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aAb-000808-1N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:53:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso52818855e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744699999; x=1745304799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsq9XB0Kt/BeYHREkL+MMGT7dUfzwFYgYO2EvCVPc6A=;
 b=ag28Sp+2unb/liMg8MMe3sfFRKu0NU0TQlc3jQt3LqyQUvp0LDR1+0zZYk/BFhZiBz
 bxwkaGwTaIaXVI9RE/4ZfIFJsoD7Y6vefQcu4KaYefiwD9tSv8xP9jSi4vjdlEh0FGU2
 iYRVSgZawz9jdyJ63UfeZHGKvVjRz6vnEHRlAQ97lwfT91ecUN2bbJr6fKkcnmrnRnIQ
 /zplvqsaQHSqvRQSDW80POukbFOgulA6PjbjRfmtkkSb82PUptvu3uDw6gBoJ0/Ar9Jv
 LyaW/0vvqRQcE+HcOV/+eVe/QpmLFJUC8Jh4pzFvF+RfLrIdYLxet3Yicy9THn2n28o6
 WDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744699999; x=1745304799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsq9XB0Kt/BeYHREkL+MMGT7dUfzwFYgYO2EvCVPc6A=;
 b=N5BiSFTfkNNsUBBuLp8teNVY49RBvB5+oc6QY9zaqcGB9S9kZw17hQJ4ezyhPElJvB
 jrIjBidn6e/H1hEGJJZo8IDNU5dr51QefSSFLV0a5dVcfMjYTgGkUug2C64KO8Qkr6be
 lswHS952PNHb/rMTUKnNChIC7m3YCMWAe9mPVPn0BB1/QlTy0D56ELP3RQGbOzyA6GjF
 XPYQoPtR2+2XK2kJe/Axe3NAPKsBLBkRl4kkWBbblckDbFPgh5VZtfgNuSkKRP8wQjwo
 1HnM7mJ8mnOZt4bs0xJLb2oMyPVGLADD5PXYzJuzIVMA7mRzpRuWMXQzK9+gq+F4zYen
 fcGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOQ1n9YNb18/5AIXfHMTe739xMMk8WLEuXYuEF9dZqK45ucOYtZCCEPVfe4a+OY7bAIsZANUdDRTFP@nongnu.org
X-Gm-Message-State: AOJu0YyJC8Vcna58SrGPxI5HdPSrmEmnqORdrCwJeIST5zCBU8icPdRx
 BNqkKdwqItkXm/aXcGxUUJ45BCcwJEZD3TECzXWc7dnLtK7+G/rdjfYIkxJOZhI=
X-Gm-Gg: ASbGnctcP2KuJUtAeI8EJmzimAqRvyeeuFsk8x1G/lF2SZq38GlJ0GGuu74lYHhNBKs
 8exlp6azVZmJbAYuLi7CQ+E3pq0/XxLu34Ay3tjKijMeqxnq1UDIW/TAf7v63QQG1WxEH7PrDmR
 VyNYqjwwKWj3vYil/5HTIOlXB03PVe50uqgy6cMBAWgn6CYZaSB5VzjUcUgQAcde/TQD1zYdygJ
 TxNdVx8nFtzr2pJN9gsgQgn4B1Qc2CHAx5//ufvog742XiNbAP3jB6+1hH3LsCLkMAMKXOoFIA5
 Zr0GyGW9p00HxcqEQeYwK2fm33s8RM/d4UNJJnUOsL3kF8kWm2PBwV7EXEt9GrXfhfzNCbCHQhu
 FJ5+Q9F9L
X-Google-Smtp-Source: AGHT+IHa7G4UDRcNDrPwphJzmH6/1Rj67IeKQZwe+AW67zch+tqxw3tP/okZndda4d+ruSgd1JgeKA==
X-Received: by 2002:a05:600c:604e:b0:43c:f6b0:e807 with SMTP id
 5b1f17b1804b1-43f3b055a80mr122922685e9.31.1744699998922; 
 Mon, 14 Apr 2025 23:53:18 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c49f7sm196030575e9.17.2025.04.14.23.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 23:53:18 -0700 (PDT)
Message-ID: <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
Date: Tue, 15 Apr 2025 08:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
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

On 15/4/25 08:18, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..fea2220013 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>       if (!vtd_dev_as) {
>           struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        bool take_bql = !bql_locked();
>   
>           new_key->bus = bus;
>           new_key->devfn = devfn;
> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>           vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>           vtd_dev_as->iova_tree = iova_tree_new();
>   
> +        /* Some functions in this branch require the bql, make sure we own it */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +
>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
>   
> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>   
>           vtd_switch_address_space(vtd_dev_as);

Would it help clarifying to propagate this argument down?
vtd_switch_address_space(VTDAddressSpace *as, bool need_lock);

>   
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>           g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>       }
>       return vtd_dev_as;


