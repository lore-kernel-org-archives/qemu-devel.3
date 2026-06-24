Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A8CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTCg-0003Lv-R1; Wed, 24 Jun 2026 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcTCd-0003LU-PB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcTCb-0007yR-Ik
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782329039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FKYm9TlZb6molYW3HFk+O+XVtaYBQ8v3CWaFEcPv1wU=;
 b=fJXhqMpznqFLkU7xGJEin67GmPEPSs6lOIU9T8Z3+tmUHAeosHQw8ygP8i7AQv4ZYMfmMh
 rjgA83zUPx0hcUEF/KmywrjciZfIIdroYZPx1f44XFKq0z5hC7p/qciSj/vRMJwsZLgdZP
 y9t/PbajDHar/Dm9awD0cb0sjQGiBmQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-K1k9tEeEPPGXRV1UtXMAyA-1; Wed, 24 Jun 2026 15:23:55 -0400
X-MC-Unique: K1k9tEeEPPGXRV1UtXMAyA-1
X-Mimecast-MFC-AGG-ID: K1k9tEeEPPGXRV1UtXMAyA_1782329035
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so834449f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782329034; x=1782933834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FKYm9TlZb6molYW3HFk+O+XVtaYBQ8v3CWaFEcPv1wU=;
 b=LhWx/4jPOx1rbwhdRHw2dLnQTXF/QG8tMlustV5boEJbSsfRAqR0/r/gNtqf151ifH
 PX1enoJybYwnf7zLhuUWpliifJ+ujt/w3ZJTi/2MoPqYgecwWD45e1rgR63ToiKCcXLF
 K1XyWfFlIROvcdNz0Aus2ps2xtVQeEb0CyVlQ5ls9t8kocQhj9LagCCpVsspAi2bP1Nv
 r8VKPD9oFIcu4y/t0BgLLj1L0hc+DAy5xkf/r3o4XhFBuCbI5/0o78gZlHNHPB57IswD
 Y8TEhlP4+qXoQdvYytiebFI1MpuQYyDSFGVtHfq5LvuV10PezcEHPWHxfW4Ttt0BaT73
 c+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782329034; x=1782933834;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKYm9TlZb6molYW3HFk+O+XVtaYBQ8v3CWaFEcPv1wU=;
 b=g2exOQA2x2UomJ2qAZCctxwJu8FqTy9yrwCwlAYt0TpkWfrLC1sA2M830WSlMebEox
 71o7qNvvO0y9TLg50LUS4R+A/2mZFk8lJV3plW09C6J1DDJXwW+XqshuXOF5Y0ldPs87
 +HS0hS/g61+rC6M6IDlYlD87Uo2S2SVR8SoIm9htg7K29ltgwx7hdnuZj5yYaC130FmS
 KX8iyBIjluK8HL7hAkeG4/3zVySITB9eQVOIAAWZT8M1h36zX2jECPOp0tdp74gvcyQ2
 vxBK7TSeRT8c8mJs6PhPKBdxWfV+4cW3od+OMpTRdpABHcAybG8lGb1QzD8/hKz25YQ6
 LHdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpqs3n+rPdLNcHc0V+HMzTYCPKfAQ6q+l1W3YAD+xxv4W9GDhI8O5vEJUw6292sdVlMjVmB8e2EoAkj@nongnu.org
X-Gm-Message-State: AOJu0YzlvaVczj34ABIA99zTKSi0Ag0JE3hYyfuEYNUHaX8KGdB8+lEB
 0638JKmDNfDt3CzsolMast41sW4BkO5ehYUAHeHT6u1H+NbvjXYODwVo8fe/yj/ZErTY3hPuI/G
 BDYlZukq3VuxZQcEYX3fCe8vQctSO0DjGjWhbjwvtpX5Y0L/QABs8qiVI
X-Gm-Gg: AfdE7clujy2WM+gl1SPbyWsY9MRLFPY65TSGldQuf46cIUROf2dcWfJAuujUs+HM4Cg
 j8l2XIp8xZ01A5hyJPiC2omURurxWXMa+lXWWamBFO8iTKRHhFOpfOZro4GWCLkEeVKDJ8+tnTU
 WecuXyqs7oJvQqq9Y+r3RwkxY65Nz2jZZNGLBnEYe7O61pnIIgmcapDmMCKpHy37yc+PZp4D9nJ
 szDNTi28yF6LWpea7a9qp54TeAPdTmIhkSFKAHiydgAdt+z8sA7pG6nzraGEZHeZuv5XRSQY6Xg
 HAVOlNsi5J7uioA/JbxUumIbCOxeowl9CmfbaTNTtfITrCRDtBvv+KPM/yd//nDFAMasjUJ6ANB
 TDIi1hMaYFr9CLpAZWUp4+Q8BWDlGMmPNMl83KWsuTY/z1iL0G+1Mhgw=
X-Received: by 2002:a05:6000:25e7:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-46c06ada51cmr7304834f8f.23.1782329034598; 
 Wed, 24 Jun 2026 12:23:54 -0700 (PDT)
X-Received: by 2002:a05:6000:25e7:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-46c06ada51cmr7304784f8f.23.1782329034032; 
 Wed, 24 Jun 2026 12:23:54 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d3ba68d8dsm1869378f8f.27.2026.06.24.12.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 12:23:53 -0700 (PDT)
Message-ID: <10936003-6199-4cf9-92ba-f648f070d841@redhat.com>
Date: Wed, 24 Jun 2026 21:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in
 region_del
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex@shazbot.org>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20260113093637.1549214-1-clg@redhat.com>
 <20260113093637.1549214-29-clg@redhat.com>
 <2b70ae68-aee7-4c81-8799-6610a582dcb8@redhat.com>
 <IA3PR11MB9136249C19B0F0108D1C9A1992ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136249C19B0F0108D1C9A1992ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/24/26 10:02, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in region_del
>>
>> Hello Zhenzhong,
>>
>> On 1/13/26 10:36, Cédric Le Goater wrote:
>>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>
>>> If a VFIO device in guest switches from passthrough(PT) domain to block
>>> domain, the whole memory address space is unmapped, but we passed a NULL
>>> iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
>>> dirty pages.
>>>
>>> By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
>>> set dirty bits correctly.
>>>
>>> For IOMMU address space, we still send NULL iotlb because VFIO don't know
>>> the actual mappings in guest. It's vIOMMU's responsibility to send actual
>>> unmapping notifications, e.g., vtd_address_space_unmap_in_dirty_tracking().
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>> Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-8-
>> zhenzhong.duan@intel.com
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>    hw/vfio/listener.c | 22 +++++++++++++++++++++-
>>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index
>> 62699cb772d786c1510318dff73973ef4d297177..813621f22f8b5ec284388f9c5f71
>> 9525ec5f282c 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -713,14 +713,34 @@ static void vfio_listener_region_del(MemoryListener
>> *listener,
>>>
>>>        if (try_unmap) {
>>>            bool unmap_all = false;
>>> +        IOMMUTLBEntry entry = {}, *iotlb = NULL;
>>>
>>>            if (int128_eq(llsize, int128_2_64())) {
>>>                assert(!iova);
>>>                unmap_all = true;
>>>                llsize = int128_zero();
>>>            }
>>> +
>>> +        /*
>>> +         * Fake an IOTLB entry for identity mapping which is needed by dirty
>>> +         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
>>> +         * only translated_addr field is used to set dirty bitmap.
>>> +         *
>>> +         * Note: When switch into PT domain from DMA domain, the whole
>> IOMMU
>>> +         * MR is deleted without iotlb, before that happen, we depend on
>>> +         * vIOMMU to send unmap notification with accurate iotlb entry to
>>> +         * VFIO. See vtd_address_space_unmap_in_dirty_tracking() for example,
>>> +         * it is triggered during switching to block domain because vtd does
>>> +         * not support direct switching from DMA to PT domain.
>>> +         */
>>> +        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
>>> +            entry.iova = iova;
>>> +            entry.translated_addr = iova;
>>
>> In an experiment involving a nested setup with L1 + intel_iommu,
>> an L2 VM with an assigned igb VF can trigger the following QEMU
>> segv :
>>
>>    bitmap_set_atomic(map=NULL, start=1, nr=1)
>>    physical_memory_set_dirty_range(start=0x380004040000, length=4096)
>>    physical_memory_set_dirty_lebitmap(start=0x380004040000, pages=3)
>>    vfio_container_query_dirty_bitmap(translated_addr=0x380004040000)
>>    vfio_legacy_dma_unmap_one(iova=0x380004040000, size=12288)
>>    vfio_listener_region_del()
> 
> Hmm, looks a range in PCI space, I suspect it's a PCI bar but it has 3 pages.

It's the nested VT-d interrupt remapping table.

> Is igb VF a real hw passthrough to L1, then L1 pass it to L2?

Iit's an L1 emulated igb VF assigned to an L2.

> Seems L2 crash, not L1?
yes. It occured a few times and  I can't reproduce anymore. hmm.

That seemed to fix it

-            entry.translated_addr = iova;
+            entry.translated_addr = memory_region_get_ram_addr(section->mr) +
+                                    section->offset_within_region;


Thanks,

C.


>>
>> The VT-d interrupt-remapping table is mapped pretty high and
>> translated_addr ends up as a very large value. It seems that
>> the correct value should be :
>>
>>    translated_addr = memory_region_get_ram_addr(section->mr) +
>>                      section->offset_within_region;
>>
>> as found in vfio_iommu_map_dirty_notify() and
>> and vfio_ram_discard_query_dirty_bitmap().
>>
>> Is that correct ?
> 
> Good catch, it looks we lack a conversion from iotlb->translated_addr to dirty_block offset just like in vfio_iommu_map_dirty_notify().
> iotlb->translated_addr is designed to hold translation result from vIOMMU. How about below(untested)?
> 
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -71,7 +71,7 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
>   static int
>   vfio_legacy_dma_unmap_get_dirty_bitmap(const VFIOLegacyContainer *container,
>                                          hwaddr iova, uint64_t size,
> -                                       IOMMUTLBEntry *iotlb)
> +                                       hwaddr translated_addr)
>   {
>       const VFIOContainer *bcontainer = VFIO_IOMMU(container);
>       struct vfio_iommu_type1_dma_unmap *unmap;
> @@ -109,8 +109,8 @@ vfio_legacy_dma_unmap_get_dirty_bitmap(const VFIOLegacyContainer *container,
> 
>       ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
>       if (!ret) {
> -        physical_memory_set_dirty_lebitmap(vbmap.bitmap,
> -                iotlb->translated_addr, vbmap.pages);
> +        physical_memory_set_dirty_lebitmap(vbmap.bitmap, translated_addr,
> +                                           vbmap.pages);
>       } else {
>           error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
>       }
> @@ -134,16 +134,27 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
>           .size = size,
>       };
>       bool need_dirty_sync = false;
> +    MemoryRegion *mr;
> +    hwaddr translated_addr, xlat;
>       int ret;
>       Error *local_err = NULL;
> 
>       g_assert(!cpr_is_incoming());
> 
> +    RCU_READ_LOCK_GUARD();
> +
> +    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
> +    if (!mr) {
> +        return -EINVAL;
> +    }
> +
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
> +
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
>               return vfio_legacy_dma_unmap_get_dirty_bitmap(container, iova, size,
> -                                                          iotlb);
> +                                                          translated_addr);
>           }
> 
>           need_dirty_sync = true;
> @@ -155,7 +166,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
> 
>       if (need_dirty_sync) {
>           ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
> -                                    iotlb->translated_addr, &local_err);
> +                                                translated_addr, &local_err);
>           if (ret) {
>               error_report_err(local_err);
>               return ret;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 68f2ae6f9f..969629b0f5 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -65,6 +65,8 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       IOMMUFDBackend *be = container->be;
>       uint32_t ioas_id = container->ioas_id;
>       bool need_dirty_sync = false;
> +    hwaddr translated_addr, xlat;
> +    MemoryRegion *mr;
>       Error *local_err = NULL;
>       int ret, unmap_ret;
> 
> @@ -72,12 +74,21 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>           size = UINT64_MAX;
>       }
> 
> +    RCU_READ_LOCK_GUARD();
> +
> +    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
> +    if (!mr) {
> +        return -EINVAL;
> +    }
> +
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
> +
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
>               ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
>                                                       IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
> -                                                    iotlb->translated_addr,
> +                                                    translated_addr,
>                                                       &local_err);
>               if (ret) {
>                   error_report_err(local_err);
> @@ -103,7 +114,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
> 
>       if (need_dirty_sync) {
>           ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
> -                                                iotlb->translated_addr,
> +                                                translated_addr,
>                                                   &local_err);
>           if (ret) {
>               error_report_err(local_err);
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 109b5d61af..e1b078a7b3 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -97,8 +97,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section,
>    * Called with rcu_read_lock held.
>    * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>    */
> -static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
> -                                          Error **errp)
> +MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
> +                                   Error **errp)
>   {
>       MemoryRegion *mr;
> 
> Thanks
> Zhenzhong


