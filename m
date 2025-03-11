Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38FBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2VH-0004k9-Mr; Tue, 11 Mar 2025 12:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ts2Um-0004JI-Cr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ts2Uf-0003AW-Bx
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741710611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvW/5G6Q0o35IFHWkI1ctZoRXpbF5XVgT4Z39z0aScA=;
 b=TMzkQ/P+UPvUeCgb/xh1RB/d8dRTUG85346SXcf8moqx4YOMS4VruBtlbefPu2U12UOfEM
 9Ztvku4DXUWowLKbTI9PXQRHiqqVgaE1xieHQoOPm0mvbQIdirTMbnQdf16/WMkXl5fzP2
 k1JOMilT8UjekE0BC+a5uzUmg78D+FE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-3tTvAJ3OOvW-JPvNEWGmNQ-1; Tue, 11 Mar 2025 12:30:10 -0400
X-MC-Unique: 3tTvAJ3OOvW-JPvNEWGmNQ-1
X-Mimecast-MFC-AGG-ID: 3tTvAJ3OOvW-JPvNEWGmNQ_1741710610
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c546efca59so937707685a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 09:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741710609; x=1742315409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gvW/5G6Q0o35IFHWkI1ctZoRXpbF5XVgT4Z39z0aScA=;
 b=MkJqyedbNI8jWicnbkS/MP7ILgQk70KTBzJitRHPexYivQdT3WoDHveF7Jb0bXTHHn
 Tg4FEoUdvb/iyPIhHCDhU82iBKk6HZpIm4iVspEH351CdgUBp3dyZlwgX43gME+4l4zS
 qWGK3bkGyKtsaMRq7Cs1pANqy/ZgjpWojkR/Yen3sxXXjWfVooLxLFkGVybqZgfXu7vE
 a+e1uymcRBlLIDsBpSlqOnvy2N4RmzSuhpD8NdbaG7jGezPUnQ+Nxu8UrPcDKtRp7o6o
 GjhiivRsD0otMqt4Ca0XmRzFOujbCcNJl0sDn/jYK8L6a7t2/2LVLoo2DMCjoGh24eL7
 nR5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQTGq35e1GbBW4+A9XJmg+HFP+GOS3IDKpx/7Gc1VbfK2+0loIXRm06II5Sd3OxRP5e0FgBBvl10bu@nongnu.org
X-Gm-Message-State: AOJu0YwQkAVV6xQe1mepsJz6M3vZfLdSAWV5aKhK+D8rpafSPVV5akJB
 OcPAnQG9v4EXBnf+deumBvvjBjcX2Uia7faV+Glr/uLbAIz4feScDKhGiCSTrJpW+oi6lii45bH
 4lHYl22GCxg1wGkcFUbRn/V9SB3pXQViCJbCNaAN5iLbpwgRWSGRpO7fV+4nW
X-Gm-Gg: ASbGncsgwrxJpSviFZO5mAmGho3IIUsDKaikmUsZFT7Y3BcrnAz2aUb2m0vIByT9YBF
 /eLZsijqmhkYlKnWoHjZJ5B0W2hzFvzZTQvj0nFmmtoqSUtCZ65ET7ZbDq7cwl7S6UFLcqfJz0O
 Pw8PNTOA9KrKqClsYOhA0P6EyCY5dnBhTJPxOAr61TYgRn2Ef7/gS404Aq7J5Pl4cWs3Zr07d6p
 n4/Zp0UGILgoFIiKU2zs1+cLi0jcfN383Zk0PD7fVrxhj4xM+wgCQwLZwRJCeBShg2DQHha5Huc
 5HWezJIECL2khnQkCQNlUdMTDjuCPLjHYYPegTIN+jVYCx177SXuhKV4KIlPV1g=
X-Received: by 2002:a05:620a:660a:b0:7c5:48bc:8c89 with SMTP id
 af79cd13be357-7c548bc8ecfmr1706848985a.27.1741710609382; 
 Tue, 11 Mar 2025 09:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gY/akrsykujmw9iWKT6de/lWT2q9bCkta8KKQrc8cgX8EJd7VAYq0ezW689h0V7wEwlGlw==
X-Received: by 2002:a05:620a:660a:b0:7c5:48bc:8c89 with SMTP id
 af79cd13be357-7c548bc8ecfmr1706845385a.27.1741710609067; 
 Tue, 11 Mar 2025 09:30:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5414c8067sm542616585a.59.2025.03.11.09.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 09:30:08 -0700 (PDT)
Message-ID: <baf96cd3-2434-444a-8a16-87abd6e14bcd@redhat.com>
Date: Tue, 11 Mar 2025 17:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] tests/functional: Convert the SMMU test to the
 functional framework
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250311104920.364102-1-thuth@redhat.com>
 <4b7d75f1-12df-44ab-9435-df517beff716@redhat.com>
 <39ad1fef-f5cc-44f6-be4d-84a597b3f9f6@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <39ad1fef-f5cc-44f6-be4d-84a597b3f9f6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Thomas,


On 3/11/25 4:24 PM, Thomas Huth wrote:
> On 11/03/2025 15.00, Eric Auger wrote:
>> Hi Thomas,
>>
>>
>> On 3/11/25 11:49 AM, Thomas Huth wrote:
>>> This test was using cloudinit and a "dnf install" command in the guest
>>> to exercise the NIC with SMMU enabled. Since we don't have the
>>> cloudinit
>>> stuff in the functional framework and we should not rely on having
>>> access
>>> to external networks (once our ASSETs have been cached), we rather boot
>>> into the initrd first, manually mount the root disk and then use the
>>> check_http_download() function from the functional framework here
>>> instead
>>> for testing whether the network works as expected.
>>>
>>> Unfortunately, there seems to be a small race when using the files
>>> from Fedora 33: To enter the initrd shell, we have to send a "return"
>>> once. But it does not seem to work if we send it too early. Using a
>>> sleep(0.2) makes it work reliably for me, but to make it even more
>>> unlikely to trigger this situation, let's better limit the Fedora 33
>>> tests to only run with KVM.
>>>
>>> Finally, while we're at it, we also add some lines for testing writes
>>> to the hard disk, as we already do it in the test_intel_iommu test.
>>
>> for your info it does not apply anymore on mainline after latest appied
>> functional test additions.
> ...
>>> +    ASSET_KERNEL_F31 = Asset(
>>> +       
>>> ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>>> +         'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
>>> +       
>>> '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
>> the hash seems wrong for the vmlinuz. I get
>> Exception: Hash of
>> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
>>
>> does not match
>> 413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120
>
> D'oh, I got tricked by "wget". I used wget to download the asset to
> manually calculate the sha256sum, then manually copied the asset into
> my cache to avoid a second download.
> But wget apparently unzips the kernel:
>
> $ wget
> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
> $ sha256sum vmlinuz
> 413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120  vmlinuz
> $ ls -l vmlinuz
> -rw-r--r--. 1 thuth thuth 25885184 Oct 21  2019 vmlinuz
>
> While curl gives the correct results:
>
> $ curl -O
> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
> $ sha256sum vmlinuz
> 3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527  vmlinuz
> $ ls -l vmlinuz
> -rw-r--r--. 1 thuth thuth  9027813 Mar 11 16:13 vmlinuz
>
> This should fix the issue:
>
> diff --git a/tests/functional/test_aarch64_smmu.py
> b/tests/functional/test_aarch64_smmu.py
> index bba8599401c..4f0492ca50d 100755
> --- a/tests/functional/test_aarch64_smmu.py
> +++ b/tests/functional/test_aarch64_smmu.py
> @@ -123,7 +123,7 @@ def run_and_check(self, filename, hashsum):
>      ASSET_KERNEL_F31 = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
> -       
> '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
> +       
> '3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527')
>
>      ASSET_INITRD_F31 = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> @@ -165,7 +165,7 @@ def test_smmu_noril_nostrict(self):
>      ASSET_KERNEL_F33 = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/33/Server/aarch64/os/images/pxeboot/vmlinuz'),
> -       
> '0ef9e34f80b49fa2ac098899b27075e95c11d5b646f6ca4df2e89237a40f9e4f')
> +       
> 'd8b1e6f7241f339d8e7609c456cf0461ffa4583ed07e0b55c7d1d8a0c154aa89')
>
>      ASSET_INITRD_F33 = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'

yep it fixes the issue

python3.9 ../tests/functional/test_aarch64_smmu.py
TAP version 13
ok 1 test_aarch64_smmu.SMMU.test_smmu_noril
ok 2 test_aarch64_smmu.SMMU.test_smmu_noril_nostrict
ok 3 test_aarch64_smmu.SMMU.test_smmu_noril_passthrough
ok 4 test_aarch64_smmu.SMMU.test_smmu_ril
ok 5 test_aarch64_smmu.SMMU.test_smmu_ril_nostrict
ok 6 test_aarch64_smmu.SMMU.test_smmu_ril_passthrough
1..6

The conversion looks good to me. thank you for doing it!

With above fix and straightforward rebase on top of mainline, feel free
to add

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Eric

>
> Sorry for the confusion.
>
>  Thomas
>


