Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E7BC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0v7N-0002q7-7j; Mon, 31 Aug 2026 02:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0v7L-0002pG-7J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0v7J-0004Y6-KY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788156216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCDBNus9TBiBwZTC1+pGakvksppGAl5R+lI++O6o6ds=;
 b=bZ/7yI4n33LAZpycnmyT4TQCs5qD5yMP5oi3wjchs3Vzhm69SFx8BUv5obxPiBsooEIV/z
 K+9pABSSjRCqi3R08hKZY22ZrA4s5iG2P5IU4aHyRfi6FgbV94TTdXsI6gYe2OJs7BDoid
 tu1praMwfo1Tw7ljPNlM6YyvkzzZCK8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-591un8deNoqEiTg9ydCQhA-1; Mon, 31 Aug 2026 02:03:34 -0400
X-MC-Unique: 591un8deNoqEiTg9ydCQhA-1
X-Mimecast-MFC-AGG-ID: 591un8deNoqEiTg9ydCQhA_1788156214
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso25584275e9.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156214; x=1788761014;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zCDBNus9TBiBwZTC1+pGakvksppGAl5R+lI++O6o6ds=;
 b=C/RazHttrU5GX5O+AqTt/5pGbTLwKEi3AhuBmr9jqdNynVn0FRsU10n5C+/0rUUNDX
 d6P2bVuRvLFp86Bkv4Yx7fpXH2H4QmD35t8piapIlitnVFo0bbGzntMnx3wUMIG8u7rE
 nyE542GvLvjUtjCVKy4W8z2Fq7Wygf5nQeRAZMxB9pBqqacLHRZ9g0XuqyF9OumsmKA5
 Cc+p4Ahd2cyfpw6pvbTUDi71YVUBt/hm47KdmBEAQsbRf+C3yHP+AViBj0qCqUMDHK9p
 KVkxnxUkE1MyczkbAZKRyrBVLG4S2705fo0INvAKdN9WdAAMNB1NGZMIcYrNpFEMZ6oy
 4tCA==
X-Gm-Message-State: AFuF++kxkVv+ngMmT/atNvQDy+n8qNT2M8RPTzPOqW5mXyZKCNPKS1Aj
 l/Ql7JZu+dpnHd1ygecpXBNdNlJALfxouTDNC+0CdEbmdYEH2gOyHzO6w9K27cx0x5VxhXFHfqH
 TrJoIqytDjMLqM4YmkxpdiGzIKVT1uNWIXd5gYXjwbu1pxhHVD20mSlLB
X-Gm-Gg: AR+sD11Z7qXEfz69gqCXjXTi8x26tO0VlEUkya3bpWJ21SvqMn1a4z+QfCZoUBaKR0g
 xS6AqeAPdboeZUOYN8RNF9OxhoUFJlhhRIGP717GytBHWjiZqaeRNCMLwQyfPp8U3DyAcyokA2f
 yZqiwaBdAvYk1J4qCKf9GYfgJdjwQrzveQMC98EOpc9GsCk94g7SKUV54D30bThGPiR+nILYY/9
 QM7mwWu7o+kP1eb+n6XGPAlYzPLRUx85vj1dX+6gN3ZDws4I438nUvYXJD8xMGFQH9zlWTGxsw7
 cNKpqIOb+c6E+rnUpQH69/kpN5xprUY9e0aTx1EsMhkfE6XEv8HCHcT3Pr+01NGSxvs7wC66k9G
 T9IGLSSwg7SN3w191SLl1ks7sSb4gHvhUsA/tGDE/NK8V6HUT
X-Received: by 2002:a05:600c:1393:b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49b91c2660amr326613785e9.1.1788156213557; 
 Sun, 30 Aug 2026 23:03:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49b91c2660amr326612875e9.1.1788156213067; 
 Sun, 30 Aug 2026 23:03:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b963c3c0asm468566735e9.10.2026.08.30.23.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:03:32 -0700 (PDT)
Message-ID: <d39ce149-8479-40bc-8411-a52a635c7a0a@redhat.com>
Date: Mon, 31 Aug 2026 08:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 23/28] hw/pci: Add sec-sid property to PCIDevice
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 8/13/26 6:21 PM, Tao Tang wrote:
> Arm SMMUv3 uses a SEC_SID (StreamID Security state) to determine the
> security state of the programming interface that controls a transaction.
> The architecture explicitly states that the association between a device
> and its SEC_SID is a system-defined property, not something derived from
> the physical address space.
>
> We need a way to represent this system-defined SEC_SID for PCI devices
> if we want to implement SMMU's Secure state. So that SMMUv3 can select
> the correct register bank and configuration when handling their streams.
>
> This patch adds a new char *sec_sid field to PCIDevice, together with
> a "sec-sid" QOM property. The property is intended to carry the
> platform-defined SEC_SID for the device; for now only Non-secure and
> Secure security states are supported.

You shall add PCI maintainers in cc.

Is it only SMMU intended? I mean if you set this property, the PCI
device shall send DMA requests with secure attributes too?

Eric
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/pci/pci.c                | 7 +++++++
>  include/hw/pci/pci_device.h | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d3191609e28..b86135af96d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -104,6 +104,13 @@ static const Property pci_props[] = {
>      DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>      DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>                      QEMU_PCIE_EXT_TAG_BITNR, true),
> +
> +    /*
> +     * System-defined, statically configured SEC_SID for this PCI device, used
> +     * by Arm SMMU. Only support "non-secure" and "secure" security states.
> +     */
> +    DEFINE_PROP_STRING("sec-sid", PCIDevice, sec_sid),
> +
>      { .name = "busnr", .info = &prop_pci_busnr },
>  };
>  
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e16886..6e6c49fdd19 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -187,6 +187,9 @@ struct PCIDevice {
>      uint32_t max_bounce_buffer_size;
>  
>      char *sriov_pf;
> +
> +    /* Arm SMMU SEC_SID */
> +    char *sec_sid;
>  };
>  
>  static inline int pci_intx(PCIDevice *pci_dev)


