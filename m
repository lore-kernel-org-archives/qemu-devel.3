Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EE8CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfZ3-00068o-0D; Tue, 13 Oct 2026 12:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGfYx-00066o-OY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGfYu-0007jH-4r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791909670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sK3ij0fKDN84fNGBxWJ4v18dEp9j9tb/LwUNoPAf8S0=;
 b=dmyc7s+PDEr/i5C7xzxzpo6NN2BtzS1Qp2Ci08vi6bIyjOfWB9HrKPlRYY+9eZBjS/agfp
 dprPV+ZF8i3l3Fhh+2gmUjBTbSHEJhkB5aJxV2fC9vIKBaf8X1AInyUCApn3E6kVgQaAFT
 LAlZg1MIep3na/PEg2ByH6luP+Lrd0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-l0ZsKw3COTOuP_0xi4pKzw-1; Tue, 13 Oct 2026 16:41:02 +0000
X-MC-Unique: l0ZsKw3COTOuP_0xi4pKzw-1
X-Mimecast-MFC-AGG-ID: l0ZsKw3COTOuP_0xi4pKzw_1791909662
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a028616bebso22529035e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791909661; x=1792514461; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sK3ij0fKDN84fNGBxWJ4v18dEp9j9tb/LwUNoPAf8S0=;
 b=pZV/5XjbjCzmfC6oD21hW9rxxl7ts7ABGS3eH0PkfMUmnYPjjT9qGMG9FKIA36tWmX
 inu9ubDuOkC4zH6dM0mx9SNpGRzF9rJq/aaldtBJXbfq42WmbRCkovqoL1xkVodJP2NI
 hzP7tMXIOqpPXgEQkfXE2fayJbL6GLVJGgsVVXTGnClQk2EHx0qhsKu7/orPNSdtaUiN
 xbTJsNqQF5CSckP8whnDsRAeNtx6A45MXcwergeEnsEVflasVI6g0D4p6VAnddjWrfMt
 MxLRJMVB/bWcIzoVQpH107Bi0PAxQdwuLAnfSPYethqTCCFJd9VRBqMo/AEjEzNcN/9S
 BjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791909661; x=1792514461;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sK3ij0fKDN84fNGBxWJ4v18dEp9j9tb/LwUNoPAf8S0=;
 b=SvRsnnBxulCQyUel66YwmkWttb3hIHr0BDDPE2M31JH0USPgNyQg8/oyqNrsuv7OAT
 LPata0Nw07xKXtDXMCVBUKVGz29l4wKDXI4zmm6Ggi/Cg7y7RwYQiG1YClOONVrY5nIC
 Ly57L58eKq6Z+n6HkZbvfCHLrzoSFwYX+Rig7Qeo5M6D9U2xuT2BrhZCIVJgW5TJrFLX
 UzL32MUme4gQ6iDC/SP23+Jhqry9MOhd7/1TuAiODDMIbqpIrxIGxSw9kfJkRxSq8la3
 gVPVKAgBuABmhAgDw21Y5F9134seR0tviJL6oVThBXXrevMHGhb1dV5QkHELtJ/b0feH
 LS8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/dygSiIZh+m8UovFpka1wa6hCAx6LYrDv0wPhl60gOnkua2Uwpkg0fcMGzOnnRGlpw6SS0YtfSadV@nongnu.org
X-Gm-Message-State: AFq9FYJ/OJ0ZPP/25RfyGrAl41S7Ga6eeM5jXIXfzsG6bdFoNaiQ6fdn
 FknrphhHyNYCFscw/lUFFUijxNRSaRwkFgPn2PRAKgM46CkF5YGrhHVgEni0aS4yurAE1Ki3Yhf
 eg9PLWaNJT1jSZ7UJomat10Z1QtFTvuSEHQLSX86ESfQopmXRCy6NZt6zyAGbjY6d
X-Gm-Gg: AYBFou0AOoJvluoMHvdZM88hs8FC/w2r7P+e0cxWI+YQERHN484aExMkV4Ix5h9iuqW
 FojuxOX6HGbh1Rq9PjRPOj3jpXV+u152NnFxbgh4gfvpeb3OoN6TyjJCxK4cDqsQ1v52Zs5rrKG
 pqhBLYXCr3baS9ixsD3cVRtq/fO40BrV7OrSq170EaD+I6FjVhnKZU3sW5la1Rr+/xzJZ9q0YSi
 V+KHTWnp5Iyw2OK0QalFnv/FIkXwn8Zu0yi+OUgDjj8BYZHqE2H6UePpi4RJ2NTVQ1iIrWKgfXm
 TeUk7Abn7S1DoJv8Vx1/dxMGtUNCkSwcjj3GCXMFMTsJdXdAmHJ1cytPaL55Qn0fckgm5646rMR
 mBqGxHrqDiVoY1Z/TN9uVIzmcj25Bb/tjMUiUrTsq
X-Received: by 2002:a05:600c:4fcb:b0:4a0:1fe2:d4f1 with SMTP id
 5b1f17b1804b1-4a18e4d1686mr243021525e9.28.1791909661417; 
 Tue, 13 Oct 2026 09:41:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:4a0:1fe2:d4f1 with SMTP id
 5b1f17b1804b1-4a18e4d1686mr243020835e9.28.1791909660798; 
 Tue, 13 Oct 2026 09:41:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a193f2c992sm279635555e9.5.2026.10.13.09.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:40:59 -0700 (PDT)
Message-ID: <1d0935c2-14c4-4d0e-96af-2a20a2095c10@redhat.com>
Date: Tue, 13 Oct 2026 18:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 10/12/26 08:27, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
>> from multiple ranges
>>
>>> In order to create a dmabuf associated with a buffer that spans
>>> multiple ranges, we first need to identify the VFIO region and
>>> index the buffer (represented by iovec) belongs to and then
>>> translate its addresses to offsets within that region.
>>>
>>> The qemu_ram_block_from_host() API gives us both the region and
>>> the offset info we need to populate the dma ranges so that we can
>>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
>> dmabuf.
>>>
>>> Also, instead of iterating over all QOM devices to find the
>>> VFIODevice associated with a memory region, introduce a helper
>>> to just use the vfio_device_list to lookup the VFIODevice.
>>> And, introduce another helper to lookup the VFIO region given an
>>> address.
>>>
>>> Lastly, introduce an enum to return the type of error encountered
>>> while creating the dmabuf fd.
>>>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-device.h |  22 +++++++
>>>    hw/vfio/device.c              | 109 ++++++++++++++++++++++++++++++++++
>>>    hw/vfio/dmabuf-stubs.c        |  17 ++++++
>>>    hw/vfio/meson.build           |   1 +
>>>    4 files changed, 149 insertions(+)
>>>    create mode 100644 hw/vfio/dmabuf-stubs.c
>>>
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
>> device.h
>>> index 8472420d3f..c05430be8a 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -41,6 +41,13 @@ enum {
>>>        VFIO_DEVICE_TYPE_AP = 3,
>>>    };
>>>
>>> +enum {
>>> +    /* The Guest passed addresses stored in IOV are invalid */
>>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>>> +    /* Guest or Host may be at fault for this type of error */
>>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
>>> +};
>>
>> Nack.
>>
>> As said a few times already : it's a VFIO-specific enum leaking
>> into vfio-device.h to serve virtio-gpu's fallback logic. The
>> cleanest alternative is to use standard -errno returns and
>> make the fd an output parameter.
> It looks like Cedric remains unconvinced about the value or usefulness
> of this error enum. Therefore, to make progress, I intend to adopt his
> suggestion to use standard -errno returns for the next version, considering
> that this series has been stuck for a year.

Well, v12 was sent in March and v13 in October; that's a 7-month gap.
If you want to make progress on a series, sending updates more than
twice a year helps a lot. Maintainers context-switch between many
series; long gaps mean re-reading everything from scratch each time.

That said, converging on standard -errno is the right pattern IMO.
Widening the fallback trigger to also cover -ENODEV would be a
nice improvement for v14.

Thanks,

C.


