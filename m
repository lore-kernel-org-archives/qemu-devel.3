Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F790F01822
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySIi-0005DV-Hr; Fri, 06 Mar 2026 05:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vySIg-0005Cv-N9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vySId-0003D4-Fa
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772792448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KTVbBXd4DM2U8UGZY2GuQeP91rTj/2prtEdUgtlSgk=;
 b=CQeVQ0aDuBoGfigN3rKq9/Bwx9VjyR4iG9f0wbEFolBjK3ZfOq/Yv0VCsz6f4XrKff2bie
 BTsI3jERyb1BH72jUJ9Afm+hmMVAVS3KnnboR/1CXCIGexKN9GL7RD9/Ao0tgEFqQVa2Ma
 vOFjObWk7Vnx+K61Az9f/TYKTb9U5Vg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-J9cZ4nuaO6mUtbrAsjMjgA-1; Fri, 06 Mar 2026 05:20:47 -0500
X-MC-Unique: J9cZ4nuaO6mUtbrAsjMjgA-1
X-Mimecast-MFC-AGG-ID: J9cZ4nuaO6mUtbrAsjMjgA_1772792446
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836fbfa35cso50318925e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772792446; x=1773397246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8KTVbBXd4DM2U8UGZY2GuQeP91rTj/2prtEdUgtlSgk=;
 b=FW87ZDgj8VOyVTFBpGQWjc6bw30H46qu74kpZ+olcoIKSjP/nj/ACe7O7zkIklg7wx
 WjIIFqw00jHPSJ3Fxh5pA8wW+Lo25nV3rpz5m48QSfdCRMQoNkyBVQAdOtFJAbV+p/Ni
 6JTlob/LnKcuzniZXC0e645DQqzgp/u9hTPTO3aCqvK7Y/bzZPndq7/+MHrI3P+fU62D
 4HEfv9yQqmafD4Ouony1U6exmzeoSerdThulxgNSFiBQAlFtBc9DDy0QEqjbgfOqsVdD
 1s5bJPiMxtsOcrR8v02ssZLFv30x53cYcLAHjXDizGEd2wA3xpDp/8pmmq/HGtb3r72K
 tPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772792446; x=1773397246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8KTVbBXd4DM2U8UGZY2GuQeP91rTj/2prtEdUgtlSgk=;
 b=gWBnDzR8YB/3g7xWCtYTNy5Pv5J+uDexcJbLkC6g+fSE68SFVzfr8DUd1LDRHevxcT
 uLvqLVaFh2WZdhBGwQ03KkpIHUxmUDDRotQV3B8MFih3/aqrvdBNTQrIgZ06aF2qsFNa
 NqJd/O0qyP8CIVTk+310ZE/tiN3piSFwGL+YYSX+s8fWzkuCgB7mxiewJbuRsIp4IXr/
 2rQFILemGV0cHb3RwMjbDBuMpTdDgfMA+HJ1OYgCepqn31sK+ulyxrhdj8NIr2fy4a6P
 58CE78BJfK21rFLE2G0li1UwpJaTDUs6WwGj/rSVTS8/p2wCtn6o84g0hqZJeuKr3mSC
 DDAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYNhRs8cNvCNelYhJ6YOHdvk3yaKgnL9Y9ta22n1FJq2bWYxgNqxMygf9hUcuPEHgzyoVtQaCXS7RF@nongnu.org
X-Gm-Message-State: AOJu0Ywqq/3hYwQeHuqPuncDPOmR6Vkm1l5GbGVLmvtyy7uPvpwo/72C
 orCgPD8TsyJzz9eCHzennEUY7bJ6x2u2tFWVaSvzgmx+zGh7ZEAn6ChOCihiYJ74+/Cen0y2aeg
 kL0Tw6DBlQWqkO770ohC5A4Ds6VDN6ZcWbZDjr4odRcsP0Ccu2VMB1SobjOFC+kE8
X-Gm-Gg: ATEYQzzXKwJGXyc/vfnnIfSqVmSY6gsgnaf0q9g6ROi8C33PMC0+DpWF8By3mhTMJng
 o657s9Op75jwFsF2nVQdykBSDMpMuiIYH0rOqsxPdizNlP+moaKnrKSUY51FMlafxRYsYEia7IU
 MOwe1VdUEa+/GO7F2GTUmxeD3XDEyV5POrpw27v3y6PONjPybysJG5UEjT6Y2mxJP3dLmLwprag
 PpNElr1xyzSj115oCf0XihaizGGOEmzzOOdgpTN9MPmWunmf256jnEBj6jcbm+8txEzwcf+zEWq
 TZhfKMVM+kf7JQb8zhjUqjU/YOHxSmZFU2Ur5bEz4CMrB8eQhRvjvmeAYYQms2mAHluDecH168y
 HGMJGl1Hz0J7CByno6FXB5zqTD75gE0lbgU1VNTmm5qf8JWgqXAqXlV3z1zHcx4X63LlIyEAw9r
 AuiLVrgNH9a0t0h0Tr2K8iMT3OHpuLHX4xZ0YwNEmKXxIUN5aKktw=
X-Received: by 2002:a05:600c:821b:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4852693049fmr24796385e9.14.1772792445954; 
 Fri, 06 Mar 2026 02:20:45 -0800 (PST)
X-Received: by 2002:a05:600c:821b:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4852693049fmr24795985e9.14.1772792445463; 
 Fri, 06 Mar 2026 02:20:45 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d076:615b:37d9:f4c0:4867?
 (p200300cfd737d076615b37d9f4c04867.dip0.t-ipconnect.de.
 [2003:cf:d737:d076:615b:37d9:f4c0:4867])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470a654sm13711845e9.29.2026.03.06.02.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 02:20:44 -0800 (PST)
Message-ID: <0331f8e8-8654-45a3-9049-0d4c7b43172b@redhat.com>
Date: Fri, 6 Mar 2026 11:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com> <aaWfEfuBZGW4BHPD@redhat.com>
 <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
 <aahaDEON0LMkioKz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aahaDEON0LMkioKz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.03.26 17:13, Kevin Wolf wrote:
> Am 04.03.2026 um 15:20 hat Hanna Czenczek geschrieben:
>> On 02.03.26 15:30, Kevin Wolf wrote:
>>> Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
>>>> Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
>>>> pure data (no metadata) children.  These are going to be used by qcow2
>>>> during formatting, when we need write access to format the metadata
>>>> file, but no write access to an external data file.  This will allow
>>>> creating a qcow2 image for a raw image while the latter is currently in
>>>> use by the VM.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    include/block/block-common.h | 11 +++++++++++
>>>>    block.c                      | 15 +++++++++++++++
>>>>    2 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/include/block/block-common.h b/include/block/block-common.h
>>>> index c8c626daea..504f6aa113 100644
>>>> --- a/include/block/block-common.h
>>>> +++ b/include/block/block-common.h
>>>> @@ -245,6 +245,17 @@ typedef enum {
>>>>    #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
>>>> +/*
>>>> + * Promise not to write any data to pure (non-metadata-bearing) data storage
>>>> + * children, so we don't need the WRITE permission for them.
>>>> + * For image creation, formatting requires write access to the image, but not
>>>> + * necessarily to its pure storage children.  This allows creating an image on
>>>> + * top of an existing raw storage image that is already attached to the VM.
>>>> + */
>>>> +#define BDRV_O_NO_DATA_WRITE  0x100000
>>> Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
>>> doesn't allow reading either, but I don't think image creation ever
>>> requires reading from the image?
>> How would qcow2 set it?  It opens the qcow2 image, so it can only set the
>> flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs to go on
>> the data-file child.  Maybe we can construct the graph manually…? It would
>> be quite painful, I imagine, but I haven’t tried yet.
> Why should it go on the data-file child? The child permissions are
> defined by the qcow2 node. If the caller promises not to do any I/O (and
> I'm fairly sure that apart from preallocation, creating the image
> doesn't involve any I/O on the qcow2 node, just on the primary child),
> then qcow2 doesn't need any permissions on data-file.
>
> Or am I missing a reason why BDRV_O_NO_IO can't be set for the qcow2
> node?

First, bdrv_co_write_req_prepare() requires !BDRV_O_NO_IO and the RESIZE 
permission.  We could bypass this by calling qcow2_co_truncate() instead 
of blk_co_truncate().  Feels wrong to me to pass BDRV_O_NO_IO and 
!BDRV_O_RESIZE to blk_co_new_open() when we actually kind of want those 
things and just bypass the BB to get them, but only morally wrong. Not 
technically wrong.

Bigger problem: BDRV_O_NO_IO makes qcow2 skip opening the data-file 
altogether.  So we would need to distinguish between qemu-img info and 
this case somehow.

(I also thought maybe the bdrv_co_truncate() in qcow2_co_truncate() 
might be a problem with data-file inheriting BDRV_O_NO_IO, but because 
qcow2_co_create() puts in a pre-opened BDS (without the flag set), that 
part works.)

Hanna


