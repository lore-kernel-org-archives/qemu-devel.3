Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF232C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcm45-0007OZ-FP; Mon, 05 Jan 2026 10:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vcm43-0007O8-GB
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vcm3v-0004mv-TS
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767625201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=elBFd0MKTBZ+E0qoXvnrgrcilar0S8MzWSlDEUAUB+g=;
 b=a107cgblmTHzlJ7at4B2a1ciVTMpMs721kxxsDdJ+/zVrD1JcmSNSRzbUDACogvOgjnUuk
 sx/jTESZ7kknO8jjiTZs7zz5soIDc/jJ/WugiLtkqGTVKZQmR7qDdoAw71KrfXUOYyoZdy
 K0RY1hjBOU2zbrAR1SmDix9V5oFEbDc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-1UpN4HQvMEW8DR3LmFwLRA-1; Mon, 05 Jan 2026 09:59:59 -0500
X-MC-Unique: 1UpN4HQvMEW8DR3LmFwLRA-1
X-Mimecast-MFC-AGG-ID: 1UpN4HQvMEW8DR3LmFwLRA_1767625198
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so10148812f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767625198; x=1768229998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=elBFd0MKTBZ+E0qoXvnrgrcilar0S8MzWSlDEUAUB+g=;
 b=sHC9QXgE119OcaNxAb8SLANfmCqpEy5irHw996JNQ+aV2JFYDMitPej+Pkwo8efhmp
 wz5jx6BtTTUnt4lfR5Vg1KE0RZpY/XAKxORwlYpFYfROaNDOt8Oct90Umfnf15g5hIX3
 cG+QpMhpK4TJ5PikeIpjXFOYMoVnzYjnCpexvKzLwSyCFVhzg5s9U0IRtchvi0tKp3q4
 o0e2HWXhwsqYLIS3fYQcSdIOEXRoQAeKlemBBUGea49ubqzW1nv7sQt0ILH0UL7NF/4x
 o8JJxsuLegqZ0TcccCMQLx5ufPR7Hzo/k7qtHk03Smvhua48CybOhXknLreVo+hzBBfe
 6qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767625198; x=1768229998;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elBFd0MKTBZ+E0qoXvnrgrcilar0S8MzWSlDEUAUB+g=;
 b=cogoOZzXXY+Za/Kl5+YV7G+t9scnMDdzm3MMLFEX4xWno69ve4U4U8hPPol7JUrH8D
 /4D/aA99uN+j036bJp668e8mK0amrdNbKRCY1lkPsBWfSoi0ZGaHJpf/vIMi/rLGDv8W
 BfqjGz8C8zQRLPnWv4pLH+L8bm3a2Gp+KGmhYLwYh1t417b6M5e3bF6x7CsJIgJuRJpv
 ljTObhcU+EY5YR9pvwdtlO1Myh9cWPsF9VltlVcWoryo89UxqAnzH9Cci1p1i4+RKf/I
 58Z/Go6xtMv5exjRRt0WXL9UZGRn6aHzevbvjIfcMSEDW/SIrnpVfcRNF8tnsl/9Q+fT
 EEyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi00OH3JjnxidcWv459Uy8DGaigT/VLWSe3xVmYIBZZsNXxPklnesy5q2s5DZ8eT3Bb8MYU+TtCnkz@nongnu.org
X-Gm-Message-State: AOJu0YzXIjLZgOy1MfBrD8pqcl/wm2Fqoqsa1qHi7vxobrSIKBzHoFzW
 MA0Z3EmCX6cLjNE3dann+rG2jU+7NUXY5AQXCbbForWj91U7U420eJF789lrwCj1EnikYdb2TAY
 FuZrvQjnkcrsIWYtERuM0PEg8uJ7MrbB57fUJ/R3gCeUuVc/bw2YBSTsn
X-Gm-Gg: AY/fxX7kSARrLb2TSVK6+ZWDMNiS+ZItYtKArsJcnePmfrOxPH4Qot59OmGWbE0a1iK
 gEc4VOnAWllGCsstcPNY9UgMn1uHe95c4SxKpapKJQVTU/m1D+jIS7nV8QR1FxugomI8/DcJ5Mg
 zAMPyh/Z0wcLC/fEXK/A5EhalxYlzyXTLDWUOnmlRXFH4h6WW64dKNJYGraolWAlbAmQnMjozXz
 Yyoei0x2xHyC15ryiCZGBjFrku5QJgsNQ0TyENTYHkglNLAtypYchZBES9mF/pFDCU6w40e9eCI
 FHluAopW5nweojK8PlFXwB1Js+SFxZQaOeoe8+BeYLDDeQ6WIlm050mxKTqtUo8I1Ya7HHdTrHA
 SUBHqa0vTKaqXf+e58kyKxxCPET/xC+Mg/u1Otv1WSK2TOQG6
X-Received: by 2002:a05:6000:1789:b0:430:f463:b6a7 with SMTP id
 ffacd0b85a97d-432bc9f6564mr33681f8f.45.1767625197980; 
 Mon, 05 Jan 2026 06:59:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwyc9CkDMmHM9YjMxwU7lDE2hut6Iuyi+rhoaw/PoBzObHtjtra6ph16l8q+C/y2Qs2eoCQA==
X-Received: by 2002:a05:6000:1789:b0:430:f463:b6a7 with SMTP id
 ffacd0b85a97d-432bc9f6564mr33648f8f.45.1767625197405; 
 Mon, 05 Jan 2026 06:59:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca2f944sm17816f8f.11.2026.01.05.06.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 06:59:56 -0800 (PST)
Message-ID: <33c35507-2a7c-4ff7-ad93-79b56896715a@redhat.com>
Date: Mon, 5 Jan 2026 15:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
 <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
 <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
 <e219df64-1712-4ace-8358-d825de26fc1a@redhat.com>
 <9e07d4e0-c407-448c-ac5c-10d153a1a11a@linaro.org>
 <dc8049a1-0d6c-428c-934d-f8b70065aa3c@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <dc8049a1-0d6c-428c-934d-f8b70065aa3c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/22/25 21:17, Farhan Ali wrote:
> 
> On 12/22/2025 12:35 AM, Philippe Mathieu-Daudé wrote:
>> On 22/12/25 09:17, Cédric Le Goater wrote:
>>> Hello Farhan,
>>>
>>> On 12/19/25 18:30, Farhan Ali wrote:
>>>>
>>>> On 12/19/2025 8:30 AM, Cédric Le Goater wrote:
>>>>> On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
>>>>>> On 19/12/25 15:51, Cédric Le Goater wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On 12/17/25 19:42, Farhan Ali wrote:
>>>>>>>> The VFIO pread/pwrite functions use little-endian data format.
>>>>>>>> When enabling the Bus Master bit, the value must be correctly converted
>>>>>>>> from the CPU's native endianess to little-endian format.
>>>>>>>
>>>>>>> How did you find the issue ?
>>>>>>
>>>>>> I presumed using VFIO on s390x hosts...
>>>>>
>>>>> yes. I have been using a nvme drive for over 2y in an s390x VM and never
>>>>> saw any issue.
>>>>>
>>>>> C.
>>>>>
>>>> Hi Cedric,
>>>>
>>>> I have recently been experimenting with QEMU NVMe userspace driver and PCI instructions from userspace [1]. On some of our test systems I noticed the driver being hung. After some investigation we realized it was due to this issue.
>>>
>>> Do you think you could provide a test case for it ?
> 
> @Cedric,
> 
> Just wanted to understand what you had in mind here? The test case would use VFIO and would need an NVMe device, looking through QEMU testcases I couldn't find an example of using VFIO. If there are examples or other frameworks that is used to test this could you point me to them?
> 
>>>
>>> Also, I think the LE conversion should be done in routines
>>> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config().
>>
>> These config routines take a void buffer, so have no clue of endianness
>> size.
>>
> Yup, exactly.
> 
>> Maybe we want intermediary qemu_vfio_pci_ld16_config() and
>> qemu_vfio_pci_st16_config() helpers?
>>
> I did think of adding in additional helper functions. But since qemu_vfio_pci_read_config()/qemu_vfio_pci_write_config() is only called in this one place, wasn't sure if it made sense in adding them.
> 
> Another approach I thought of was limiting reads/writes to 32 bit similar to vfio_pci_write_config()/vfio_pci_read_config() does today. Can we do this here as well?

I don't see why we couldn't. The vfio helper routines under util/ use the
same kernel interface as the vfio-pci device.

Ideally, both should use a common low-level interface but that seems a bit
complex for this fix.

Thanks,

C.


