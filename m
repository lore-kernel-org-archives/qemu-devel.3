Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A83F01829
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTMi-0008BY-Ty; Fri, 06 Mar 2026 06:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vyTMg-0008AY-Qj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vyTMe-0000WU-6e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772796543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGNqqWDxe70U+fqTydKU7ZEOdOKHudeSgsReDp9uYqc=;
 b=XTFl5XdJQay3CxF9AlVEALtjBT4hLjZm4xRE6hs2U2vQncqiHHImvEU6M/ByH8AC4grnDj
 gVcRbavbqJaDQL6XsTk/4qxm9HfS1jpgoRALVnMfaqlkeJX2UZ4RKmjQ3Bgs0IUyk7zY/6
 0Qzfb8oQXtWuTc3UX54ttJ2ztUev6lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-CMpelEMPPCGDeiZU7oeOgQ-1; Fri, 06 Mar 2026 06:29:02 -0500
X-MC-Unique: CMpelEMPPCGDeiZU7oeOgQ-1
X-Mimecast-MFC-AGG-ID: CMpelEMPPCGDeiZU7oeOgQ_1772796541
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbc5fd75so1782100f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772796541; x=1773401341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGNqqWDxe70U+fqTydKU7ZEOdOKHudeSgsReDp9uYqc=;
 b=oCsMgSCljNd6tSwyfY6tQtU8vQkyDa1EYBwJ6Lu9V1j575b6UsT0jwwstbICBaeQv9
 CSWxLqsLaltc54KR/rUuZUq6rN5TK5GvAY4irL53te45xlcYrjMdyqZWUzIfOUjm0DDA
 jxKS4Mr5/mZwRA0GPunXSIk3UpQgw5n0ip6wQOlFvBKqJbPNz2sT8pABnM6rFxF9GAAG
 IwJ7vnbEEBmOVd+TQMHZoDqchFDHr2GYcnFdAOWqZC3uTg7RgfHpcvOqjpjgKLa4pI3M
 a7GUiXZICEN+EKT8h4S4gDoeUgv+XLlv3J0kJVNJmBSaqTQAUfYIWTbP8w6KZdYmfUAe
 0LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772796541; x=1773401341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGNqqWDxe70U+fqTydKU7ZEOdOKHudeSgsReDp9uYqc=;
 b=e84Nf+TO7rhbA7c5U2RSlBPFjRLWPdsfhRF9RlN1rwarJdYFHAbMdA2GNVlbs6Jagh
 R2crLaNrjOHovPqvxkNBWhJ0kp2ZYnKtYCEZ1Y6WN6+/8LcYUCdtS7JoCJO0EyVd9AXC
 XAO5QhnwEgkykOvcyp6hmwV2Y7SStvzCHDJDxwicMytoPdJXeUJiajrVsbnsKwNMxp3O
 nYfP42bZzJQT6/c34ehkYObzvMg2GqJgqFozxk2cZRcRiSmKXt8j9jY8EfgdGcuketv7
 8L5i/9M8wHEKTec9n727y+0hD1kMgMWrVFzenCOziVgGzD2n6biFE3KNF4siiD7W5kBQ
 G01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRTS2ilte2aNdfgCG1D8kFQJf64Wn1kW1n9uFYvwk2wdOqZk7UUD/Z7Nl3yxiL3zNvRa8r9CgYzpJC@nongnu.org
X-Gm-Message-State: AOJu0YxRu9G46vpaO/uHtMTtaa56Bu6ZuPdybWhH6mEhtx7SHvm7BLkb
 HqBVS0aVPL/QMEYLrJhSpzDecS9pZkenViLJ6THTAGv5977IGe2CVWiICOeaBT85+s/Zn8i3K/m
 3NWpivTRrUIlOVVYHTgqvEO7aS2Gb5VspoUqorl6SIKIWKGjBxbbL5xlc
X-Gm-Gg: ATEYQzwonzwVpZjBixrCfbmJ26UGuvDU/6M3Dx+uZTuWnohKOEHFwj7nZzBMNXIO+eT
 WQSanQO1sHo6zZT79vSrgaQMdKmCrgs0SOiwB/Lgk2YEOosczqaCbKwOjllpQt2Ae7Y/ZY3yO3t
 xvA5igDvSn7xPlZporQWG79a1xDbJ/BhbWzbefKcRW81ZDEc1/CgmTsnizNG8hjwuvKgEPE1cPV
 f+v66bj2aI5wjpfmUSlGjIxgoaQH/8MPoHEvhIOiXfertrf0axY41YiWqEK6UMxjUgrQYL4FC5w
 M6xNS0qLelbsL8drSnIx2hsX+g00cYF8fOGsmXILiX57I1bm83uUqFQ2DnG7cUyZ4ldlcFe/xWc
 zgssanYDavnTsv3tsA7tjr9jZw6ErOoLpjr0XzyWJAzM6dV2pnWehJqmmZPzwy9wDI+ENfaV8zR
 04geOzhnot+Pa+6cYsfKJlPmYq1ekEvJp2BmDd2v5MsZmf6lJ8Rik=
X-Received: by 2002:a5d:584c:0:b0:439:ac53:a94d with SMTP id
 ffacd0b85a97d-439da6694dcmr3019731f8f.29.1772796540842; 
 Fri, 06 Mar 2026 03:29:00 -0800 (PST)
X-Received: by 2002:a5d:584c:0:b0:439:ac53:a94d with SMTP id
 ffacd0b85a97d-439da6694dcmr3019675f8f.29.1772796540318; 
 Fri, 06 Mar 2026 03:29:00 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d076:615b:37d9:f4c0:4867?
 (p200300cfd737d076615b37d9f4c04867.dip0.t-ipconnect.de.
 [2003:cf:d737:d076:615b:37d9:f4c0:4867])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3c80esm2879448f8f.29.2026.03.06.03.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 03:28:59 -0800 (PST)
Message-ID: <538cb2b6-5a4f-4927-afbf-ce4512320d21@redhat.com>
Date: Fri, 6 Mar 2026 12:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com> <aaWfEfuBZGW4BHPD@redhat.com>
 <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
 <aahaDEON0LMkioKz@redhat.com>
 <0331f8e8-8654-45a3-9049-0d4c7b43172b@redhat.com>
 <aaq2rtctmiYgi-4y@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aaq2rtctmiYgi-4y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On 06.03.26 12:12, Kevin Wolf wrote:
> Am 06.03.2026 um 11:20 hat Hanna Czenczek geschrieben:
>> On 04.03.26 17:13, Kevin Wolf wrote:
>>> Am 04.03.2026 um 15:20 hat Hanna Czenczek geschrieben:
>>>> On 02.03.26 15:30, Kevin Wolf wrote:
>>>>> Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
>>>>>> Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
>>>>>> pure data (no metadata) children.  These are going to be used by qcow2
>>>>>> during formatting, when we need write access to format the metadata
>>>>>> file, but no write access to an external data file.  This will allow
>>>>>> creating a qcow2 image for a raw image while the latter is currently in
>>>>>> use by the VM.
>>>>>>
>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>> ---
>>>>>>     include/block/block-common.h | 11 +++++++++++
>>>>>>     block.c                      | 15 +++++++++++++++
>>>>>>     2 files changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/include/block/block-common.h b/include/block/block-common.h
>>>>>> index c8c626daea..504f6aa113 100644
>>>>>> --- a/include/block/block-common.h
>>>>>> +++ b/include/block/block-common.h
>>>>>> @@ -245,6 +245,17 @@ typedef enum {
>>>>>>     #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
>>>>>> +/*
>>>>>> + * Promise not to write any data to pure (non-metadata-bearing) data storage
>>>>>> + * children, so we don't need the WRITE permission for them.
>>>>>> + * For image creation, formatting requires write access to the image, but not
>>>>>> + * necessarily to its pure storage children.  This allows creating an image on
>>>>>> + * top of an existing raw storage image that is already attached to the VM.
>>>>>> + */
>>>>>> +#define BDRV_O_NO_DATA_WRITE  0x100000
>>>>> Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
>>>>> doesn't allow reading either, but I don't think image creation ever
>>>>> requires reading from the image?
>>>> How would qcow2 set it?  It opens the qcow2 image, so it can only set the
>>>> flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs to go on
>>>> the data-file child.  Maybe we can construct the graph manually…? It would
>>>> be quite painful, I imagine, but I haven’t tried yet.
>>> Why should it go on the data-file child? The child permissions are
>>> defined by the qcow2 node. If the caller promises not to do any I/O (and
>>> I'm fairly sure that apart from preallocation, creating the image
>>> doesn't involve any I/O on the qcow2 node, just on the primary child),
>>> then qcow2 doesn't need any permissions on data-file.
>>>
>>> Or am I missing a reason why BDRV_O_NO_IO can't be set for the qcow2
>>> node?
>> First, bdrv_co_write_req_prepare() requires !BDRV_O_NO_IO and the RESIZE
>> permission.
> Ah, I wasn't aware that truncate requires !BDRV_O_NO_IO. It's not what I
> would intuitively call I/O, but it's also justifiable because it changes
> the result of reading some blocks.
>
> The part where things start to feel questionable is with the way
> qcow2_co_create() uses truncate. It doesn't actually want to truncate
> the image (especially with an existing data file), but just allocate the
> metadata for the full image size.
>
> If the problem is just bdrv_co_write_req_prepare(), would a request flag
> for the truncate solve it without having to introduce two global BDS
> flags that can never be set by the user? BDRV_REQ_NO_DATA_IO or
> something?

Oh, only one new flag.  We can drop the RESIZE flag, as you said, and 
make it !BDRV_O_RESIZE.  (If we call qcow2_co_truncate() directly, that is.)

Dropping that flag changes the error messages sometimes (because without 
this flag, WRITE will always imply RESIZE, so with a guest device that 
prevents concurrent resize, you will then always get RESIZE conflicts 
alongside WRITE), but that’s OK (because it’s only when you get a WRITE 
conflict anyway).

>> We could bypass this by calling qcow2_co_truncate() instead of
>> blk_co_truncate().  Feels wrong to me to pass BDRV_O_NO_IO and
>> !BDRV_O_RESIZE to blk_co_new_open() when we actually kind of want those
>> things and just bypass the BB to get them, but only morally wrong. Not
>> technically wrong.
>>
>> Bigger problem: BDRV_O_NO_IO makes qcow2 skip opening the data-file
>> altogether.  So we would need to distinguish between qemu-img info and
>> this case somehow.
> Do we need to have it opened, except for preallocation, which can't set
> BDRV_O_NO_IO anyway?

Yes, for resizing it without preallocation (growing to fit).

We could have qcow2_do_open() distinguish by checking whether the 
"data-file" option in the QDict is set and a string (a node-name), 
because if it is, it’s safe to take that existing BDS despite BDRV_O_NO_IO.

I’m still not sure how I morally feel about passing BDRV_O_NO_IO when we 
do want to do I/O.  Yes, only metadata.  I know.  But I understand 
BDRV_O_NO_IO was introduced specifically for nothing at all, just 
querying image information.  And it works, yes – you just have to make 
sure you keep BDRV_O_RDWR in there, too, because otherwise the whole 
thing will be read-only and not work.  Feels really wrong to me, but I 
guess we already do the same thing at the end of qcow2_co_create() to 
flush the image, so…  Too late to protest now, I suppose.

Hanna

>> (I also thought maybe the bdrv_co_truncate() in qcow2_co_truncate() might be
>> a problem with data-file inheriting BDRV_O_NO_IO, but because
>> qcow2_co_create() puts in a pre-opened BDS (without the flag set), that part
>> works.)
> We should probably skip truncating the data file for BDRV_REQ_NO_DATA_IO
> and we want to make the image the same size as the data file anyway, no?
> I don't think we have the intention to actually resize the data file, do
> we?
>
> Kevin
>


