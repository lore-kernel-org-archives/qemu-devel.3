Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7815FCD0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2lwu-0003UP-Uj; Wed, 18 Mar 2026 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2lwq-0003U3-No
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2lwo-0004QM-CR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773821288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tOyvmhp4poXy2aHO05eKZVAgeqzNOYPabHL9vZOxcds=;
 b=d1O2lKpytczj0gQRI5yGVGwn9b6hUdsq7PcpTW3t3a5f9bHs7zGQ8DtpjVYfqM7UsHVk18
 F8JRAtOh5IbzApEtHp87qDOLyJKPlGlvLpYP0WF/rZZH4xNWZg+tEcdqCBFt5fb4SLQ2CP
 5+NIK65X/4mu7NMNdbTb9i4pQmwnowo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-u1h6ASOmPlaWGfILjUMbyw-1; Wed, 18 Mar 2026 04:08:06 -0400
X-MC-Unique: u1h6ASOmPlaWGfILjUMbyw-1
X-Mimecast-MFC-AGG-ID: u1h6ASOmPlaWGfILjUMbyw_1773821285
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b47c19ed8so2778354f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773821285; x=1774426085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tOyvmhp4poXy2aHO05eKZVAgeqzNOYPabHL9vZOxcds=;
 b=s+zx9p0x2U6mbkhfRY2l1ziJ22V/RtLlYdxAKuZjZdSaCeoUa7UopnRaFRdCJF8Cyy
 iIIcwEL2484Olzj7+AjiP356kybD9DONYJeyDHyGZaFh2aVGQjRNJwStgJHVJXCW/Ce5
 w7XaJNmuIpbZOz6e2DyRa08V56FOX1s3t3CKa33cPB1oDXat47Q+LttpQcWj8T31GVC4
 UDlKMbefHubXej/gTZ4lpQbEO/2BsjHBFVXUKGTrftFx3QvyF5KPq/BIrh+rfSr3YS+X
 3a8Aelql9BQ/2VogMKM7SEcOTTPXoLw+8lYp510tQbtKD1RkJ2//l80O+ruKv+UC9Bgp
 PL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773821285; x=1774426085;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOyvmhp4poXy2aHO05eKZVAgeqzNOYPabHL9vZOxcds=;
 b=WUFzRsHV/NLe4nDLHhd2sM4ugwWA3HbjVvMUKIZlBUKg8aXnuzLYqTHZCUSP1xX96I
 OBZmtIPe6u/CYPSidr+ttv3LnsG1Fu9vbPsGgKWtmsj7xP2oFuNi3w1cj1AQvShC6EYZ
 Vtf3fGny1n3q5Aa9Km8pv2vlvU+xAiHusnFtfki31Nbbny3TQuQmXCo8I/3rAK4jC5q7
 nh7M5I9JJYkQ4loSC6ytI1953VI6qH0VlDK9qjFHa31KJK2M46B8O6/GnvMBsInjSkca
 q5VdEpM0qeMFCcUQh/WHDc8K8pNsXMxcqfmYXrVdYBbpEovv8X7+foWD50i9Yje867sq
 ChEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuGgRLZqNLbmYyzkHyxiKbR/0udwS/U0bU/61ggxjJldwiCov7aNspt74aAJAfnfUgCSai9gapGBNs@nongnu.org
X-Gm-Message-State: AOJu0Yz+RW8IuP68wRvTpP+dmOOp+lkNvhI3ZQDGGfcunSWQM4R+iFKp
 xjnQ8pNzl3LqroMIPlKXGcN4TRV1gKxMKk27T/PwjBrEU3vULG1Nl+9bN47oGXd9RZTaornHOPf
 9yhlvhAz0IdLaU/mIJU1wiFkbZTzMDx6Imo4Zh5pYzPUeOAkH/t/dFkbU
X-Gm-Gg: ATEYQzzf+/vt60ujn2U3QhCpImw7zuV/dyEt5wZVs90ZLM9G4K08GuqF//tJSX3xHdg
 KF7GadH/HZ6PLc/oFajo1ErdFMRama4x2hH3yy4yGFLRUKEammxt+Ob99yjcty/2MQRWaxqr5Cj
 547GoXLj2A5crq677HlYPU5b3jYtLnwic2ti189tTwFwiUbu9lCgS3o1YESeMSyZ/wgZqAACJdD
 03t0zQgGRYCV03Y/j/X9nt/+hMg3pRW8ronqlhsLa/bbD9Atf8rkeUfuhkY2OKLPiwfDMvOPsOq
 oCvylNsczcsAjANuzhaKCiU69ZMfsKTqrFCdxQfChBpf9WI7ozS9xInnAekdeM0SOVCD2NBvJJj
 GDsCtUDcloMJZ6cfJmGGtCLKDqpKbzMLjD23hbBfDMtq2URddLHIcgbboQgdF
X-Received: by 2002:a05:600c:4e91:b0:485:3c8f:e4ce with SMTP id
 5b1f17b1804b1-486f4474c39mr41336815e9.18.1773821285068; 
 Wed, 18 Mar 2026 01:08:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:485:3c8f:e4ce with SMTP id
 5b1f17b1804b1-486f4474c39mr41336405e9.18.1773821284582; 
 Wed, 18 Mar 2026 01:08:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ec4c9f3sm112729635e9.0.2026.03.18.01.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:08:04 -0700 (PDT)
Message-ID: <068a3098-4e4d-490c-9cef-ac39a7e9c29f@redhat.com>
Date: Wed, 18 Mar 2026 09:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Eric Auger <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
 <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/18/26 08:36, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Subject: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is not
>> available
>>
>> In case current kernel does not support /dev/iommu, qemu will probably
>> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
>> since QEMU opens it before /dev/iommu.
>>
>> Instead, report an error directly when initializing iommufd object, to
>> inform user that kernel does not support it, with a hint about missing
>> CONFIG_IOMMUFD.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> backends/iommufd.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index acfab907c03..c4eb3de1307 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -32,6 +32,11 @@ static void iommufd_backend_init(Object *obj)
>> {
>>      IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>
>> +    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>> +        error_setg(&error_fatal, "/dev/iommu does not exist"
>> +                                 " (is your kernel config missing CONFIG_IOMMUFD?)");
> 
> If hot add an iommufd object with object_add QMP, may this kill QEMU instance?

yes.


Unfortunately, backends are Objects. So we don't have a realize
handler and a 'Error **' parameter :/

Thanks,

C.



> 
> Thanks
> Zhenzhong
> 
>> +    }
>> +
>>      be->fd = -1;
>>      be->users = 0;
>>      be->owned = true;
>> --
>> 2.47.3
> 


