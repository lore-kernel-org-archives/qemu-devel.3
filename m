Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853D2C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 16:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU6AN-0006YS-03; Tue, 24 Jun 2025 12:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU69s-0006RI-FM
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU69q-0003GF-I5
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750781160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCk2s8wM27Wufe54g1qdEigJtmQmsb2rZ0yOJcY4dQU=;
 b=JzoQLSCACgwZnDky0cur4OZyIhVojKuWcH/KWcGGn7FlmA9YU66vuiQUqBlUWKvHclWkjO
 lvKjh1Lhbp5M5XnhkIjJOsDrwfLr+9Qr8YyDPVeKGfnfuVgshHrApPMtLEkIgaTpodfRit
 1XbA/Bwv5zjWy/f0LIOQ+Vij2+h0jf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-unbMQCl-PaqVTtBzZmVHbw-1; Tue, 24 Jun 2025 12:05:59 -0400
X-MC-Unique: unbMQCl-PaqVTtBzZmVHbw-1
X-Mimecast-MFC-AGG-ID: unbMQCl-PaqVTtBzZmVHbw_1750781158
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so4164165e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 09:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750781158; x=1751385958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lCk2s8wM27Wufe54g1qdEigJtmQmsb2rZ0yOJcY4dQU=;
 b=M6khlyhMifSvMpLyO5c5a0tfFjMma16cMWkcGLcWqQXp5FsPlBQvrCXNg/wTnhEUgx
 l+jggGODGd4chJnEVOGtY0hcny2R3dFTtMbGUTIv0CkJdchxe35IVtRTy9nvaHuitUQD
 gd6+xpT09xYYc+udox5EmhFSDaKNqqeQNvKTKGUNapc9aINjL7OgXGqD2AgK64zJaQbK
 MlgSnz8GtHRITkn0Be+HjW5xHLFRJtBYlmG3D2UnUBwmM7gXsmTtnlro55VEFStSIFtw
 A+iowOhu3BGhzcdbR0Yv1jMG/PlxXCXQV/f3MLwmUbcrNeg2w/HbDjPld5iDbO5cV7Kk
 ofyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmftxR5q+SrJ90ev0C9SZce0FCMiDat/2NloEacPOhcLv3vMoOzqvKIAuINFwjp07bVaeDbRAJd9kh@nongnu.org
X-Gm-Message-State: AOJu0YysV6l6nTNWP/0JhFSVilSRFwOPsSxU7k+yPHOfSrCkCy15sGrf
 KWfHpL45P4wdWZKQbrZfGCfdYUr/99Fou6Yb0f+RGtSBfmIA2GDxL+hvXUB/QgMdcL1bh3X/yh2
 ywSL58JzCEg1H8DwjOt9UiYkDzdU2E3WawKTm3B6dLzJ/weP3JaMM5GX5
X-Gm-Gg: ASbGnct7IgQsyXeh7AY9d+Gh+4UdxvTDNAcRoML6waVybwQuhX00EmciYI/6y4oncGZ
 ZVqxXwNWjD1OHMnHxwLB8+KgO2lR9Tl3MzgdV02BZq1DqIG5pGQ+UTz0PRxn4N7kkm01+A2EEwe
 IjvssoEdHNsT7p6sVSs/j8gSFv4zbQ+QMmYeVvlnnJTSD2OMTyyDC55c1JIJfHsbqpxxKZNMWNT
 y6tft9v2ZLpiNeDMMaD85imTS5HJBlJyrSD52kWh5o/zKdkqn6vJAyTCH6/CfieHTYtbM45hdd6
 CCDvScnp3Rm5Og0qan24iSyGYsiLhpYtCocXNvxwoMWSH7jsiBpLcc9XmvfPG/2PvYYY4A==
X-Received: by 2002:a05:600c:3589:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-45380bb6ffamr13082055e9.15.1750781157486; 
 Tue, 24 Jun 2025 09:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Hyok9Wat8ZHl+AgPhEf4lSI8ACcfx5GPx8oeF+UGFGv+GBy0FEg7dyoEb3ko0lrGlvjqkQ==
X-Received: by 2002:a05:600c:3589:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-45380bb6ffamr13081215e9.15.1750781156688; 
 Tue, 24 Jun 2025 09:05:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e98b48asm181510355e9.16.2025.06.24.09.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 09:05:55 -0700 (PDT)
Message-ID: <a408d74d-bb3a-48a5-8a5b-64664c85ec36@redhat.com>
Date: Tue, 24 Jun 2025 18:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/29] hw/i386/acpi-build: Move aml_pci_edsm to a
 generic place
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-17-eric.auger@redhat.com>
 <20250620101936.00005f96@huawei.com> <20250620142714.4c4b1d8a@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620142714.4c4b1d8a@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor, Jonathan,

On 6/20/25 2:27 PM, Igor Mammedov wrote:
> On Fri, 20 Jun 2025 10:19:36 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Mon, 16 Jun 2025 11:46:45 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> Move aml_pci_edsm to pci-bridge.c since we want to reuse that for
>>> ARM and acpi-index support.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>  
>> A request for a bit of documentation inline.  aml_pci_edsm() sounds
>> like we should be able to grep the spec for edsm and find it but
>> that's just internal method naming in qemu.
> agree, aml_ prefix is typically reserved for ACPI spec items. 
renamed into build_pci_bridge_edsm()

Thanks

Eric
>
> perhaps rename it to follow build_ prefix scheme?
>
>>
>> More interesting is I don't think this will ever be called as
>> the kernel has no idea how to call it and unlike on x86 the
>> blobs don't show wrapping the call in a _DSM() (see aml_pci_static_endpoint_dsm())
>>
>> Did EDSM usage get dropped as this set evolved leaving this behind?
>>
>>
>>
>>> ---
>>>
>>> v2 -> v3:
>>> - move to pci-bridge.c instead of pcihp.c (Igor)
>>> ---
>>>  include/hw/acpi/pci.h |  1 +
>>>  hw/acpi/pci-bridge.c  | 54 +++++++++++++++++++++++++++++++++++++++++++
>>>  hw/i386/acpi-build.c  | 53 ------------------------------------------
>>>  3 files changed, 55 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
>>> index 69bae95eac..05e72815c8 100644
>>> --- a/include/hw/acpi/pci.h
>>> +++ b/include/hw/acpi/pci.h
>>> @@ -42,5 +42,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>>>  void build_srat_generic_affinity_structures(GArray *table_data);
>>>  
>>>  Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
>>> +Aml *aml_pci_edsm(void);
>>>  
>>>  #endif
>>> diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
>>> index 7baa7034a1..be68a98c34 100644
>>> --- a/hw/acpi/pci-bridge.c
>>> +++ b/hw/acpi/pci-bridge.c
>>> @@ -35,3 +35,57 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>>          }
>>>      }
>>>  }
>>> +
>>> +Aml *aml_pci_edsm(void)  
>> Can we have some comments, or a more descriptive name than
>> the resulting method name?  There is stuff in the function obviously
>> that associates it with the naming DSM but given this is moving to
>> generic code maybe it needs a brief intro comment?
>>
>>
>>> +{
>>> +    Aml *method, *ifctx;
>>> +    Aml *zero = aml_int(0);
>>> +    Aml *func = aml_arg(2);
>>> +    Aml *ret = aml_local(0);
>>> +    Aml *aidx = aml_local(1);
>>> +    Aml *params = aml_arg(4);
>>> +
>>> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>> +
>>> +    /* get supported functions */
>>> +    ifctx = aml_if(aml_equal(func, zero));
>>> +    {
>>> +        /* 1: have supported functions */
>>> +        /* 7: support for function 7 */
>>> +        const uint8_t caps = 1 | BIT(7);
>>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>>> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
>>> +        aml_append(ifctx, aml_return(ret));
>>> +    }
>>> +    aml_append(method, ifctx);
>>> +
>>> +    /* handle specific functions requests */
>>> +    /*
>>> +     * PCI Firmware Specification 3.1
>>> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>> +     *        Operating Systems
>>> +     */
>>> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>> +    {
>>> +       Aml *pkg = aml_package(2);
>>> +       aml_append(pkg, zero);
>>> +       /* optional, if not impl. should return null string */
>>> +       aml_append(pkg, aml_string("%s", ""));
>>> +       aml_append(ifctx, aml_store(pkg, ret));
>>> +
>>> +       /*
>>> +        * IASL is fine when initializing Package with computational data,
>>> +        * however it makes guest unhappy /it fails to process such AML/.
>>> +        * So use runtime assignment to set acpi-index after initializer
>>> +        * to make OSPM happy.
>>> +        */
>>> +       aml_append(ifctx,
>>> +           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
>>> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>> +       aml_append(ifctx, aml_return(ret));
>>> +    }
>>> +    aml_append(method, ifctx);
>>> +
>>> +    return method;
>>> +}
>>> +
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index fe8bc62c03..6cf623392e 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -338,59 +338,6 @@ build_facs(GArray *table_data)
>>>      g_array_append_vals(table_data, reserved, 40); /* Reserved */
>>>  }
>>>  
>>> -static Aml *aml_pci_edsm(void)
>>> -{
>>> -    Aml *method, *ifctx;
>>> -    Aml *zero = aml_int(0);
>>> -    Aml *func = aml_arg(2);
>>> -    Aml *ret = aml_local(0);
>>> -    Aml *aidx = aml_local(1);
>>> -    Aml *params = aml_arg(4);
>>> -
>>> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>> -
>>> -    /* get supported functions */
>>> -    ifctx = aml_if(aml_equal(func, zero));
>>> -    {
>>> -        /* 1: have supported functions */
>>> -        /* 7: support for function 7 */
>>> -        const uint8_t caps = 1 | BIT(7);
>>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>>> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
>>> -        aml_append(ifctx, aml_return(ret));
>>> -    }
>>> -    aml_append(method, ifctx);
>>> -
>>> -    /* handle specific functions requests */
>>> -    /*
>>> -     * PCI Firmware Specification 3.1
>>> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>> -     *        Operating Systems
>>> -     */
>>> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>> -    {
>>> -       Aml *pkg = aml_package(2);
>>> -       aml_append(pkg, zero);
>>> -       /* optional, if not impl. should return null string */
>>> -       aml_append(pkg, aml_string("%s", ""));
>>> -       aml_append(ifctx, aml_store(pkg, ret));
>>> -
>>> -       /*
>>> -        * IASL is fine when initializing Package with computational data,
>>> -        * however it makes guest unhappy /it fails to process such AML/.
>>> -        * So use runtime assignment to set acpi-index after initializer
>>> -        * to make OSPM happy.
>>> -        */
>>> -       aml_append(ifctx,
>>> -           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
>>> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>> -       aml_append(ifctx, aml_return(ret));
>>> -    }
>>> -    aml_append(method, ifctx);
>>> -
>>> -    return method;
>>> -}
>>> -
>>>  /*
>>>   * build_prt - Define interrupt routing rules
>>>   *  


