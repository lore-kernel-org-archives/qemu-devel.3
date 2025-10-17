Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BB7CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jIO-0004Gc-Dm; Fri, 17 Oct 2025 08:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9jEL-0002ss-IL
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9jDv-0003MW-Ds
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760702769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1x/oC5Jnn+OJC2a26uV7m24hSQxQ7YA8v356EGvGEo=;
 b=DYePG1lJznn3GSo35ZiR1WX7NTrqW9MTDdKWem/aiPPgizI+k+l5CgS0JzvFS5+JUaA9u1
 FfFn7V41VRCKxqZeMDLmcugYp/9kl9EOcPw43S/l8gz0H2zcT0UU8HBCkpMOn4PsAFaLzX
 B9NSpD8XXUTiKlDeLqH1E1HjANm1o8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-TVqT7MKgNAmoofS75bXnoA-1; Fri, 17 Oct 2025 08:06:07 -0400
X-MC-Unique: TVqT7MKgNAmoofS75bXnoA-1
X-Mimecast-MFC-AGG-ID: TVqT7MKgNAmoofS75bXnoA_1760702766
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso10251965e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760702766; x=1761307566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1x/oC5Jnn+OJC2a26uV7m24hSQxQ7YA8v356EGvGEo=;
 b=d7/WrDeOIupBqpkQ/G16nvLSU4tHk2/PUatKMcOfcD5s55INpK4cw7uRM7oTrDNwVa
 pNg8AuusROluNGEC4XC41nooExaGVLK5K+ezXhE+3l0QAAFZNh+P2pNl1qWJuScS4E18
 HCBby25ZK3H1JDRUdkt/xbuoIr0lyo5b3nXXMagrv0qsjKqTG61weCBXQtygMIRgO26z
 Yu+Q7P+dJhG4bg1RJY1U45qP+y+v9mX5FYeElIC+M2iv4O9C2zRvCWcWv4zXNUS/nQ9P
 1yze/oxqAl72wQE+pTh7ixxdl2A4QQiq9TAGiVQi6ldXhPTi23x6vg6CsmXIV3h71rof
 TdeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHdDAmypq1C7dMH/NPDlrol8jZBlwmv5ty2xplABKjRF4gyVgPZ2fj9OQ0QR4x3+TGwFp8HvaQ3w4M@nongnu.org
X-Gm-Message-State: AOJu0YwBLPPnzk925WWlAXgVuZWCDe/Q5RGsPsSRVuMdDexEDsrxKt51
 1hWMlf+SbFhqtpKhJiqEe0IOqQ4Et2GdXsbByLf7TgIfXBf6/zx5kaiD6T3dh7yEwM9QkTe25tO
 7Z9lGCnRMvvPEqb+Xhpx/vlzXAMjop8u0k3w2Bshx8m9ScZEuLZjBaGws
X-Gm-Gg: ASbGncthfUMsYiAh51k9bylrbyp8JeFJUwPv3Lxwz6M8djRGZ4uTIL13HMb6GmYwvz4
 Q6obIqmAS7KGVgLqKGVfHGj17ZTO4ycyd3/GTje+W2OT/UIDm/Tvh0QafRVDI7upUWSnEhZeUHO
 Hk747DzrDvhdr6nT/xDilTFqhGNey6amNB2QVs6MWJnQXLIWjoBJtn+Qbs0LpyPbTji/AACbuf/
 8YeiviiE8qUeZ7PHeylieKGOUTVA/BRh9Kswq7ZCndm26xmp4raHog09VFAhsINjb/BlYFOyjPy
 uem/UtpxlfNgJBbqL5A/+JH5eHtN0pe1xZnNzIAyLG8K7Ex6381ruMsJSfXQvtAHI6nxQxw7G8b
 +qRZVS6vgyYmE9JPK3Eu8keqVL9NDFpFwVqJTNwiKzeCF9g==
X-Received: by 2002:a05:6000:24c2:b0:427:376:2f81 with SMTP id
 ffacd0b85a97d-42704d498efmr2941930f8f.5.1760702766189; 
 Fri, 17 Oct 2025 05:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT5/A7dVhmPWKMECeVGhmZpq8prz6LysqOF6lFJu+rCFDLZo9mpXiwtRUrtzZ7aZ/EgneEdw==
X-Received: by 2002:a05:6000:24c2:b0:427:376:2f81 with SMTP id
 ffacd0b85a97d-42704d498efmr2941885f8f.5.1760702765700; 
 Fri, 17 Oct 2025 05:06:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ed9e7d7sm48560215e9.3.2025.10.17.05.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 05:06:05 -0700 (PDT)
Message-ID: <fb96b52e-e631-4e2a-bb02-3137a673bf42@redhat.com>
Date: Fri, 17 Oct 2025 14:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
 <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/2/25 6:44 PM, Nicolin Chen wrote:
> On Thu, Oct 02, 2025 at 04:34:17AM -0700, Shameer Kolothum wrote:
>>>> Implement a set_iommu_device callback:
>>>>  -If found an existing viommu reuse that.
>>> I think you need to document why you need a vIOMMU object.
>>>>  -Else,
>>>>     Allocate a vIOMMU with the nested parent S2 hwpt allocated by VFIO.
>>>>     Though, iommufd’s vIOMMU model supports nested translation by
>>>>     encapsulating a S2 nesting parent HWPT, devices cannot attach to this
>>>>     parent HWPT directly. So two proxy nested HWPTs (bypass and abort) are
>>>>     allocated to handle device attachments.
>>> "devices cannot attach to this parent HWPT directly".  Why? It is not clear to
>>> me what those hwpt are used for compared to the original one. Why are they
>>> mandated? To me this deserves some additional explanations. If they are s2
>>> ones, I would use an s2 prefix too.
>> Ok. This needs some rephrasing.
>>
>> The idea is, we cannot yet attach a domain to the SMMUv3 for this device yet.
>> We need a vDEVICE object (which will link vSID to pSID) for attach. Please see
>> Patch #10.
>>
>> Here we just allocate two domains(bypass or abort) for later attach based on
>> Guest request.
>>
>> These are not S2 only HWPT per se. They are of type IOMMU_DOMAIN_NESTED.
>>
>> From kernel doc:
>>
>> #define __IOMMU_DOMAIN_NESTED   (1U << 6)  /* User-managed address space nested
>>                                               on a stage-2 translation        */
> There are a couple of things going on here:
> 1) We should not attach directly to the S2 HWPT that eventually
>    will be shared across vSMMU instances. In other word, an S2
>    HWPT will not be attachable for lacking of its tie to an SMMU
>    instance and not having a VMID at all. Instead, each vIOMMU
>    object allocated using this S2 HWPT will hold the VMID.
>
> 2) A device cannot attach to a vIOMMU directly but has to attach
>    through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). To attach
>    to an IOMMU_DOMAIN_NESTED, a vDEVICE must be allocated with a
>    given vSID.
>
> This might sound a bit complicated but I think it makes sense from
> a VM perspective, as a device that's behind a vSMMU should have a
> guest-level SID and its corresponding STE: if the device is working
> in the S2-only mode (physically), there must be a guest-level STE
> configuring to the S1-BYPASS mode, where the "bypass" proxy HWPT
> will be picked for attachment.
>
> So, for rephrasing, I think it would nicer to say something like:
>
> "
> A device that is put behind a vSMMU instance must have a vSID and its
> corresponding vSTEs (bypass/abort/translate). Pre-allocate the bypass
> and abort vSTEs as two proxy nested HWPTs for the device to attach to
> a vIOMMU.
>
> Note that the core-managed nesting parent HWPT should not be attached
> directly when using the iommufd's vIOMMU model. This is also because
> we want that nesting parent HWPT to be reused eventually across vSMMU
> instances in the same VM.
> "

I would add 1) and 2) also in the commit msg. This definitively helps
understanding the whole setup

Eric
>
> Nicolin
>


