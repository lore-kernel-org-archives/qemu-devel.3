Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF41CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZGi-0004Ly-Fz; Mon, 08 Jun 2026 08:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWZGY-0004CW-Ea
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWZGW-0001cC-QH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780922379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRnmyyU0jc1FKsuQoMfDeL9Q5YE29PO3wiwZ7cCvTps=;
 b=ZqcRzyqRrXT7trKVvgPyaMvPlbKqfjL9GCaF4q4DxICQvPyuSaGEB3uV+KcMFqTeUj4mDj
 rCD97wM2lgg/TXXyzFO+cR3/1iHO/OItJ4hg2EeT/mYE5KdS4Y/7UeTK867tDFYGwzhxrF
 ckQ4+Sb5uoUOvJTqpYMWungBQF4BwfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-5cyNAruTMYiO6Bi-ZKKmfQ-1; Mon, 08 Jun 2026 08:39:38 -0400
X-MC-Unique: 5cyNAruTMYiO6Bi-ZKKmfQ-1
X-Mimecast-MFC-AGG-ID: 5cyNAruTMYiO6Bi-ZKKmfQ_1780922377
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b37e1ebfso20863365e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780922377; x=1781527177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TRnmyyU0jc1FKsuQoMfDeL9Q5YE29PO3wiwZ7cCvTps=;
 b=czNYPSqkvY2UY6RA99Tp8OjOfgQlHxwbZpgawA6SPfLzjMPsQStlry/LeMneRTF+z3
 2q2ebCpCsD1x5TYObbzCKSTXfvDaF9cU70njYaN4gOn/rBkxs4COQ4/KQBOioTCByu/e
 f+NM5sZ4eUV0rdDx02D87u4+6i8ojVp/pKmfU7c5PwvJbixX5j184WH7Rt9M50Ye+RV+
 mkf/l3o1cmEvDH1FGtB1iW+30cl2KbPZh0RLeJWAgikETNRtIKYWp+S32fewwp10nrIT
 IABKoP+Jt/JfEaqLTez/HiOswvy/elfTXbe7/Z8e+bsvmmZsJMXeId+4Gz3xvO5WxsUB
 MdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780922377; x=1781527177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRnmyyU0jc1FKsuQoMfDeL9Q5YE29PO3wiwZ7cCvTps=;
 b=rCbYNAsO1eUioEaOC1rh2wKxuK0vrYKuDRAHGEC7lUaEWjA0nzyVCH/BpFFSMfhC9F
 /mUBeZaiqJi8kuscz5Qhymvh6pCGZj+QqVZazjxYRCWinSnaMaasiCvUJW3fJo/zD8ib
 mbqgeTc+ilhZHKEP6wbJXFsOQmPQ+EGXptwRjkKKmx5dnVoFVEwxH2smh420NFLMy7tQ
 eBUjaX3lg2OuWmWdvI2qZa3GprA1Ea/efYrsJ0i238THQASahcbURr3zw849LOBx1AEZ
 SBKDquEecU6hS5n4SwZ7XhyleA3f9TTdqaU21u3BgByUA3uVIk228YaPITwQ3TboahEH
 LlSA==
X-Gm-Message-State: AOJu0YxdhLRkGPxBY1aDu02YHhHpjZzmDdoZr+50BiFcUQ5MvrEwgvXE
 vwazRVi4FU553zb10P7l+mr2oiW+LmmqNmz2NAxrkJLgQufP+ttLm9Wi789fE/jjJS7XWI2iTeT
 QswQD6juI5JjFQQySYydxfaz0Wfc+AitX7BIIhr+PoVvpFV6C/D2P+K3a
X-Gm-Gg: Acq92OGOu7GVJRHHanTHJaUfQdcE3qvy8OTFwfTOU3/hLl2r/IHSN20Kl2SE/+zR7lr
 BX3sEQLPyGjn/vfrwxL0EU+9Vxpouz6Jh2bXrf9TGUrwfJgU2WLSllhDHmJbjxWbE/veKXIyrSt
 Xkcgx22J0LuZ+tjR4vlb06DNYjKiT46Wg9Jadr1c04WqwN8WEBIMt+dTw9iW8RmTQxpBYt5s/dE
 ob77nrbMxgQ7yElXiU8BQIsws5L3m8sH/3Grql7suWk1qNCJJLhvEzmKWRfV9tY4DiCgiEm3RQr
 JG+ab6tScucw55cMR7nwUTefYBBCQLtns8Ycl8cUhQifBFU6pMEIcsEaS1/K7R6L1HjruTeolrs
 0lfMjzP43uVbHwfQGui2sUcqAzYKH6N7qnPyfMBIqGaT9A/3+24g6prbWCMP4w7q3YicJgENQQh
 U=
X-Received: by 2002:a05:600c:a088:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490c25f9100mr250971775e9.24.1780922377018; 
 Mon, 08 Jun 2026 05:39:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a088:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490c25f9100mr250971435e9.24.1780922376682; 
 Mon, 08 Jun 2026 05:39:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490be1f69bcsm424959065e9.8.2026.06.08.05.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 05:39:35 -0700 (PDT)
Message-ID: <f320e3f9-a89a-4c56-8d0f-a7694ec6ddcf@redhat.com>
Date: Mon, 8 Jun 2026 14:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] arm: sbsa_gwdt: add 'wdat' option
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-11-imammedo@redhat.com>
 <e443a026-3511-46f5-809a-7555789d330c@redhat.com>
 <20260527145534.7e96da78@imammedo>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260527145534.7e96da78@imammedo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/27/26 2:55 PM, Igor Mammedov wrote:
> On Tue, 26 May 2026 16:24:59 +0200
> Eric Auger <eauger@redhat.com> wrote:
> 
>> On 3/3/26 10:25 AM, Igor Mammedov wrote:
>>> it will be used by arm/virt board, to pick WDAT compatible watchdog impl.
>>> and act as switch over to WDAT ACPI table vesus default GTDT ACPI table.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  include/hw/watchdog/sbsa_gwdt.h | 1 +
>>>  hw/watchdog/sbsa_gwdt.c         | 8 ++++++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
>>> index 307a4f291a..dc77e6be60 100644
>>> --- a/include/hw/watchdog/sbsa_gwdt.h
>>> +++ b/include/hw/watchdog/sbsa_gwdt.h
>>> @@ -73,6 +73,7 @@ typedef struct SBSA_GWDTState {
>>>      uint32_t woru;
>>>      uint32_t wcvl;
>>>      uint32_t wcvu;
>>> +    bool wdat;
>>>  } SBSA_GWDTState;
>>>  
>>>  #endif /* WDT_SBSA_GWDT_H */
>>> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
>>> index c4dd8005b7..40d80f7f2b 100644
>>> --- a/hw/watchdog/sbsa_gwdt.c
>>> +++ b/hw/watchdog/sbsa_gwdt.c
>>> @@ -265,6 +265,13 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
>>>  
>>>      sysbus_init_irq(sbd, &s->irq);
>>>  
>>> +    /*
>>> +     * WDAT supports only upto 1KHz resolution,
>>> +     */
>>> +    if (s->wdat) {
>>> +        s->freq = 1000;  
>> where is it specified in the spec?
> 
> next patch has link to WDAT spec and
> comment around relevant field:
> 
> +    /*
> +     * WDAT spec suports only 1KHz or more coarse watchdog timer,
coarser?
By the way, in above comment, you can directly quote the spec:
"The clock interval that the WDT uses must be greater than or equal to 1
millisecond."

Besides:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> +     * Set resolution to minimum supported 1ms.
> +     * Before starting watchdog Windows set countdown value to 5min.
> +     */
> +    g_assert(freq <= 1000);
> +    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */
> 
> it's the hack to make gwdt usable for wdat and is applied only when
> wdat is enabled, if not the gwdt is instantiated with native 1G and
> provides corresponding fdt.
> 
>>
>> Thanks
>>
>> Eric
>>
>>> +    }
>>> +
>>>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
>>>                  dev);
>>>  }
>>> @@ -276,6 +283,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
>>>       */
>>>      DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
>>>                         1000000000),
>>> +    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
>>>  };
>>>  
>>>  static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)  
>>
> 


