Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F22C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4sR-0000ZZ-F8; Fri, 13 Jun 2025 09:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uQ4sC-0000Jv-2o
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uQ4s9-0007n9-OQ
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749822906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=upXUakAYiLS/ewvs37bg3z2O+Mw2PbbTJuhZ4In6fTQ=;
 b=AMlSnWMGgj1qL6skt4Yor04fYq7JYbvPKJkkv/GvLdcqAroCVV52qGzKLuuHfxmspczdv6
 B7ylTLkE1GYDBNYLUQ49sLjxBocvbfPDrT4UMJphRDsHHvqSMDVtBUv8sL6okPmT0i7EKJ
 dFUx9rBkJIbKoNON1Oslaiv1F/7+LLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-eElfdzgPMNGefXPM-LQEgA-1; Fri, 13 Jun 2025 09:55:04 -0400
X-MC-Unique: eElfdzgPMNGefXPM-LQEgA-1
X-Mimecast-MFC-AGG-ID: eElfdzgPMNGefXPM-LQEgA_1749822903
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso1673260f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749822903; x=1750427703;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upXUakAYiLS/ewvs37bg3z2O+Mw2PbbTJuhZ4In6fTQ=;
 b=PlQFpl+f+znVMqWXna+C7Gtf9FeYwW0jy//d9hr5Po29ZTWGZwVkUhdk3SlJFr8mc9
 9ay7DhKT1Jg5xl8cV3YSMQX+Olf2Cov2RCRoTOWprBBa6ZbsopObTR65cJ6ih3g1ibze
 2u7r0OPkpqw72KC96w/Eer9MLAXzDwMirXabtqTHB/Q/+CZF1ZyiKixXqtBvI6WYtkJp
 TTpo65YYx1QRNm3OeGDFOQiyIK/9TB659e67UEMipw0mGJhN7YzBIBvuZKPuuCnczqQd
 SxmcM8gvutPlJexB00jRi/s387xrokVQhAdxl76GBJ7v9OdDnbTNAn0pqpwrJMKVL0c+
 nE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoLzcv3+cDF2XMN0bC/dxHD9n4phLgM8NEgnF1E1dVMWewQtnsxUzvCCwu0fo0P8MZfW31FjyLDGiL@nongnu.org
X-Gm-Message-State: AOJu0YwpElgwZ1SmB87tElfD3Lrx4q0kfRmYz5Xd/q8pp27IlCPJU86L
 Dpr5RTnJhSxnnfVDM2QzQItMk2q8sxECTiJn0b8PGo72RSP8VMvVCOcZd5E1lZw//aEN2Nzp66L
 55D9ffh9pUqmUDDRRwPVjWWVRLEPocMGcB0tcFTKJITq76psGIb6/xgi7thUPOH0C
X-Gm-Gg: ASbGnctsqGEbm4Ez2vsmXs0tHhILHLHs7/FPrwmCDSCGWDo0WN6zNu+7YgK2auH2MhD
 fd6WiBu8irPdgqvN21WPXFNCkmlK1gJLUOWiNx2N+p+OI4XxQXiF6WD9mWU5DZxHXuJvSVxTrCO
 qEjGkFye4LBayiT7UexOSOJRwGXFyNqZ6IreLB4qUTRdkl+uUEvonBnLZIYNm8BBcD1o77c+whS
 3CYcC8ztkhdnAO4HxMvC7F548ObRiId69lqaKrcVCeqdFEVH6cg4lYjjviD0X8WXMFqmUPigLdO
 5/yUQcl4Ap9RQtrWLut/sIg+n/ZuxS//s+BaZth1inhcHJ+Qcr5e0Idur5K9Iw==
X-Received: by 2002:a05:6000:240d:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3a56868330bmr3320966f8f.2.1749822903401; 
 Fri, 13 Jun 2025 06:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfESZTVDe48v1i/4yDtyMFM9EnuatblUHag6cvJIcpk0bDH+KViJogXUvR0I100CL+8RCmA==
X-Received: by 2002:a05:6000:240d:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3a56868330bmr3320947f8f.2.1749822903022; 
 Fri, 13 Jun 2025 06:55:03 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-114-027.pools.arcor-ip.net.
 [47.64.114.27]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b089b5sm2403173f8f.48.2025.06.13.06.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 06:55:02 -0700 (PDT)
Message-ID: <6916715e-392d-48b3-bd55-31a4ffc2afa5@redhat.com>
Date: Fri, 13 Jun 2025 15:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios/s390-ccw: link statically
To: Sertonix <sertonix@posteo.net>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
References: <DAJ1QOSAP9LS.342SQSM0UZU80@posteo.net>
 <4c8bb61a-d919-411b-afeb-eed15c4b2ab9@tls.msk.ru>
 <DAJ547978XGV.3LNJ0SI0X7GXD@posteo.net>
 <5c9cbee5-235b-4623-a119-0956b981f43c@tls.msk.ru>
 <DAJGZE8R43JD.1Y1H6T3G593IS@posteo.net>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <DAJGZE8R43JD.1Y1H6T3G593IS@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/06/2025 07.54, Sertonix wrote:
> On Wed Jun 11, 2025 at 6:07 AM CEST, Michael Tokarev wrote:
>> On 10.06.2025 23:36, Sertonix wrote:
>>> On Tue Jun 10, 2025 at 10:32 PM CEST, Michael Tokarev wrote:
>>>> On 10.06.2025 20:58, Sertonix wrote:
>>>>>
>>>>> Adding -pie to LDFLAGS caused s390-ccw.img to become dynamically linked.
>>>>
>>>> Why do you think -pie causes it to become dynamically linked?
>>>>
>>>> /mjt
>>>
>>> The documentation (at least for gcc) states that the -pie option produces
>>> a *dynamically* linked position independent executable. (And I verified
>>> that the patch changes the resulting binary from dynamically linked to
>>> statically linked).
>>
>> Ok.
>>
>> Why I asked is because -pie by its own does not change "dynaminess" of
>> an executable.
> 
> I am uncertain what you mean with "dynaminess" but I mean the ELF file
> type, whether or not an interpreter is set and some additional sections
> (like .dynamic) exist.
> 
>> -pie has been introduced for s390-ccw in commit d884c86dcd "s390/bios:
>> Make the s390-ccw.img relocatable" (9 Mar 2015).  Before this commit,
>> s390x-ccw.img has been dynamically linked too.  Now with current
>> master (commit bc98ffdc75), removing -Wl,-fpie from LDFLAGS does not
>> change the fact that the image is linked dynamically.
> 
> The prebuild binary before d884c86dcd was added in 553ce81c31e4 and shows as
> statically linked: (ET_EXEC is the ELF file type of static binaries)
> 
> ~/src/qemu$ scanelf pc-bios/s390-ccw.img
>   TYPE   FILE
> ET_EXEC pc-bios/s390-ccw.img
> 
> and when the binary was rebuild after d884c86dcd in 2d5eeef1c0be it shows
> as dynamically linked:
> 
> ~/src/qemu$ scanelf pc-bios/s390-ccw.img
>   TYPE   FILE
> ET_DYN pc-bios/s390-ccw.img
> 
> (Same results with file(1) and readelf -l)

I was initially also surprised by this (since there was no "-static" flag in 
the Makefile before the change to "-pie"), but I can also reproduce these 
results. I didn't find anything related to that in the documentation, but it 
seems like "-nostdlib" without "-pie" causes the linker to emit a statically 
linked binary, and with "-pie" it's dynamically instead?

Anyway, this patch here looks fine to me, so I'll queue it for the next time 
when the s390-ccw.img needs an update (might take a while, though, so please 
be patient).

  Thanks,
   Thomas


