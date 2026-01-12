Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C4FC9EC97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJfW-0004Dt-EB; Mon, 12 Jan 2026 10:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfJeX-0003fS-6F
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfJeT-0005Rc-U1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768230975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gF3lKzNjds0o/USv5W71XjRmnH7cCeRHsEqSMNCNvDQ=;
 b=f9vFNucYPYC61k/Tnl4cSLsHx/uJfGfb5wQvaNnupVUYW+3PXNMYMZlllfbrAinjhWWQ2W
 hT5BZ2fsCMfcbKpHYkq7OoJE6BXJsfDYwf+DSmq3TJOEC5aSMrv77CPa26pTu54dJWf28W
 s/DtnfSSW4CPHcNNKEQRUWUNuogNO8w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-cT0cSfxzOJGlAsUmdlXXZA-1; Mon, 12 Jan 2026 10:16:11 -0500
X-MC-Unique: cT0cSfxzOJGlAsUmdlXXZA-1
X-Mimecast-MFC-AGG-ID: cT0cSfxzOJGlAsUmdlXXZA_1768230970
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8395cae8c8so664538066b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768230970; x=1768835770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gF3lKzNjds0o/USv5W71XjRmnH7cCeRHsEqSMNCNvDQ=;
 b=BynSwrEif0VwUQWkdcvIbpYOPuYaWhV4n8JIHJY+RdiYNqWA2l9TzWmDKYMZyhh4oe
 NMVn57JVBuWkrOQnn6OzSYunQBMI+Nrk9kB7Aop+MvgP+ZLqWoDF52MDKdNXsnJ4MSsw
 myjIoHPzF7aKGC1nmgGuLF+z8a/XWE+nr6daV9pvwMBt4pJvv01JOmejvt0DAMrog3m9
 bax56Ti/nfGGINMZnb9TpRJZx782yU9ItbOD4eWloIBAVgzMGvdtVp7TWlfAVYlD3qmI
 2mlLD0k7QOzJv1LDQfOqs5sm7NUrzYx0719fEIekuvyp8NDtamrIJgAj7YyEdiadFMhy
 zh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230970; x=1768835770;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF3lKzNjds0o/USv5W71XjRmnH7cCeRHsEqSMNCNvDQ=;
 b=K2pzocfihE/TjRyqbvAyg0yW+qBDI+u3E74nGLl3AamXPliRi9iEeabBmBhjt4J3pa
 Kos6PD1d2BiMJTtc6vI6Zi6CKrntZEBk7QL1dWru4s4V3DPp1Gsy5/H8ZM64a4d/GHP4
 USobEsp9c1Wq3z0LeVhlZPXWD6x9uXwcJYfMBf72460RhCG7aAUgTpKtMlrmrEXiykyp
 v1r9Sj/d6gVU3pt14NdCJ7p3hAU7Jge3Lz8TEyySb5hL7fhJ2rcGc+TGqapgZ8Eczs0t
 IOoW0c9xPPdJm1wFGo8zzCF6dexvaverY0eIFqevrGXxDpuSPdj7VtYIEjMziHZiLmPw
 FGzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyPWvw9IshzsPrDr+zuR8vt6A3hDInQ+j0EBoypi1ehBp1wCK90skMFXlQW74W1qLi0in4rCrowO/3@nongnu.org
X-Gm-Message-State: AOJu0Yxy0T9qwbKxes8hKApHu3vS+5gDwjI+9HAecB3iYwM38AIs+GNq
 ebNClgyu9B6Rc+RTOg7RfqWkK0bsIESl8kvh2nQtLAG3AIT8a+QAAQ/nmiFXZT02k5c8FO7x6qK
 mw4jQ0gQx9TlHce42/Ue5F85NJiJtRz7NGL/Omd5WQjYuwllV7xjEdku0
X-Gm-Gg: AY/fxX46J/GAVzy7nMYR5yt/UJppPaXl6yHRJstgT1r3V9NuW2VCR2/5IkeYej95nkE
 1xMWFGwX58P39nAnmJFOxQ9LbeLnMwWsnSn6h7mz4CqmdyJ58AjBDAgj6vTqjKFU1Y2mYk/W9W9
 Yye6NK7+Js7DMRw3+xvxBRlv6JPCyubZfoUx8d2H9oMGJDisUsRmtSldf6yvY7pb+nv7ujomGy2
 GPW5cSkLCGYd1gKESCvFel0OLoKFENtv1JYkthO975owJniVGBzlfOCcCTq2qpUKoKARzTb1xPk
 5N68GV/9Cf7GRZrcp77TrSfURs53fKClNeZDAL7UYjz4DZ+dTVrRzRyrXTdMXnLHg47kVLdyje1
 rrsxdJHQKxLDi/OxdVLrYDkM41zOPm3augIxPfXe7bQYKmwWb
X-Received: by 2002:a17:907:961e:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b872471ec38mr251916966b.55.1768230970007; 
 Mon, 12 Jan 2026 07:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE4YgwZMCcuPqweZdg6QXjJJOA9EamhBIWMGk7NuZTtFwC9rqYHhdI2KNqH2HtVjpesOt1cA==
X-Received: by 2002:a17:907:961e:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b872471ec38mr251913466b.55.1768230969563; 
 Mon, 12 Jan 2026 07:16:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be658b3sm17545115a12.18.2026.01.12.07.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 07:16:09 -0800 (PST)
Message-ID: <d999a43d-6879-49e4-b93b-f50fdf19f9d6@redhat.com>
Date: Mon, 12 Jan 2026 16:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
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
In-Reply-To: <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On 1/12/26 09:45, Shameer Kolothum wrote:
> 
> 
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: 12 January 2026 02:33
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
>> cohuck@redhat.com; mst@redhat.com; Nicolin Chen <nicolinc@nvidia.com>;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> Jason Gunthorpe <jgg@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
>> region
>>
>> External email: Use caution opening links or attachments
>>
>>
>>>>>>> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>>>>>>>                                   region->mmaps[i].size - 1);
>>>>>>>        }
>>>>>>>
>>>>>>> +    ret = vfio_region_create_dma_buf(region);
>>>>>>> +    if (ret < 0) {
>>>>>>> +        if (ret == -ENOTTY) {
>>>>>>> +            warn_report_once("VFIO dmabuf not supported in
>>>>> kernel");
>>>>>>> +        } else {
>>>>>>> +            error_report("%s: failed to create dmabuf: %s",
>>>>>>> +                         memory_region_name(region->mem),
>>>>> strerror(errno));
>>>>>>> +        }
>>>>>>> +    } else {
>>>>>>> +        MemoryRegion *mr = &region->mmaps[0].mem;
>>>>>>
>>>>>> Do we need to support region->mmaps[1]?
>>>>>
>>>>> My understanding is all region->mmaps[] entries for a VFIO region share
>>>>> the same RAMBlock. And the kernel returns a single dmabuf fd per
>>>>> region, not per subrange.
>>>>
>>>> Not get, can RAMBlock have holes?
>>>
>>> Yes, a RAMBlock can effectively have holes, but in this context
>>> that is not what is happening.
>>>
>>> IIUC, for a VFIO PCI BAR region, all region->mmaps[] entries
>>> correspond to subranges of the same BAR and are backed by the
>>> same MemoryRegion and therefore the same RAMBlock. The sparse
>>> mmap layout (nr_mmaps > 1) exists to describe which parts of the
>>> BAR are mappable, not to represent distinct backing memory objects.
>>>
>>> So while sparse regions may look like "holes" at the mmap level, there
>>> are no holes in the RAMBlock abstraction itself. All region->mmaps[]
>>> entries share the same RAMBlock, which is why attaching the returned
>>> dmabuf fd to region->mmaps[0].mem.ram_block is sufficient, I think.
>>>
>>> However, possible I may be missing the case you are concerned about here.
>>> Please let me know.
>>
>> I see memory_region_init_ram_device_ptr() is called for each region-
>>> mmaps[x].mem,
>> and RAMBlock is allocated in each call.
> 
> Ah.. I see.  It does allocate RAMBlock per  mmaps[i].
> 
>> IIUC, we should set fd and fd_offset in each RAMBlock.
> 
> Ok. Will update in v2.
I'd like to send a vfio PR soon and this v2 looks a like good
candidate for it.

Thanks,

C.


