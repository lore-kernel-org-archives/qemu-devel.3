Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ADBEF8FE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn5O-0007Hr-EE; Wed, 04 Mar 2026 09:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vxn5M-0007Gy-Nv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vxn5K-00060y-WD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772634021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTNLtjd++5EwhPshwF2uPEW1UsbxTpJ0xekMUPbdZSM=;
 b=hdZMWVK4nKkbl3H87VdJVw/5/rC6bPH31Nh/IakWsIMUsTehh/NqMvPq1VtzpR4UwFEg1S
 gYauUsoUtw62qdrjUTZT9Hkxd3B4+QujnJAHkTB4Jke1ujiQvXUeq0pcpSAXZ+ALgoFQpx
 NRurS/lC4LOh2FqeyP9Xwd3uGsBwDy0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-B_Ap6dYTM0OewZAfI_pVAQ-1; Wed, 04 Mar 2026 09:20:19 -0500
X-MC-Unique: B_Ap6dYTM0OewZAfI_pVAQ-1
X-Mimecast-MFC-AGG-ID: B_Ap6dYTM0OewZAfI_pVAQ_1772634017
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48378df3469so46514135e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772634016; x=1773238816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTNLtjd++5EwhPshwF2uPEW1UsbxTpJ0xekMUPbdZSM=;
 b=Zvp7PHOVdS8WHwwJLr8DAGQt0FBr3eN8LdE9dGpRzKWLiPgedCBD1+C7ESKFLMwAnP
 lpk5FQmCHei7+/kGFxpno80YSESx6B30fZ1UegfMfZIYLET3ZGYeuNQ4k3fPE2j1U/d6
 GfGMD8omgB5r0s5Rq0A4jd9CNlczo+pXE4LCj2JrRgB9KMcspMao0dP4+R74KMmWqmwl
 f6D4ERc7LpR2cX16E7jmATtysVORct1N0HrIgPlTmJRqkSjLaF7PRBuZtP+r9vCuVgGq
 KIptSFP5xrhmfT96haMu5EF9n+QzRwT0VztLWPCE3PdRCf88jmO/GFmnd/rWI92ZFFoL
 nDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772634016; x=1773238816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTNLtjd++5EwhPshwF2uPEW1UsbxTpJ0xekMUPbdZSM=;
 b=RiMKz9/rwqaDOJ7cvNdwdUoXH1/Nbu4U/6IzHuAvtOLX5kU6//MhozY7l3Ut4y+rs+
 E/SQkDqh5UxqZ5JfXc6YFGkBoy4ZG7VruXZTWz8PZqS74aKMBHt3c0bBu5DCtwj7BT6c
 UXokWuyrvA3tnhxsULZ0zSQ77gk0lz3fpT4ToSBay2IRyMhqualK5AdQDpkeN/B1R4Jt
 TIqpmtZyyRa3bVFO/UmI+3M0RajZel2YI1HKHf6yBHrljvfdO4M/yUkl8aNnd9gpraM0
 Wo90hp3GKPthSSb8obCPmBUnq8lRF0GpdGJbbPiAZVazm64E80dG2CHWoJ5APyrTw7BV
 og5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrk0sZnqmaw2w4MxENjT/1Mbx2oa8oYLCMyBI0wLatUyLW9iB+k8frZce4WeISnxJaOKGxeHx1IdTR@nongnu.org
X-Gm-Message-State: AOJu0YxuVfKK/+762LdkOO9/yxczhT94U3TQCzLG1oeAgm5JWT783qrJ
 rqibQhF9zDNaNIAepqL/1oTXGW6I6GoKM8K1EI8R0K8wtn/c7iJRGTia0OgvDITKLjYfa0nQe8S
 Mc3+eUMQOfNRevAzLqyBKi1qjBYePzwdZ4EEqHxQq6Fz7+Mp8614y6pnUh6s2FE7O
X-Gm-Gg: ATEYQzyQNFdJ69VxdFz9xqBWJBSDBmjw9IcIYV0BXIoV25nTan9ZispTMBOOYy3GbZg
 JKmHpIVnGp56rKCVcD+afor7sRNkoGIi+tGIBX/pJmjaOfROqFSs/iDhSHuTbiOf1L/G/SJzdd6
 5KH3XNvrTMpKuugZgDP1zsCvmnBcDotLu1vMet1eTsGZ9GoBd0IlC7yePvIt8dk/e6OZA+Qm4HW
 8V6VkIpNWJRM7w/3uKYzhYRzSnhKsyXKTwPv/hnRelHj4w4soBkOG8UptRRkb6k5O5sm++dwh93
 j700C2WZaBFmyqabcZbqfOJw8nMW6517H/UhpDfWNgYcJotqhdqxoOTZokXM0//RErhRGU/OHHl
 LcJyKnQag4781PzW9DgNgpX34tyzfCDy7wrrDlFmhxUHh05wiRE3J3XwodnR4IfDgDaEqi+/S4i
 +j85GZRZ1XZFjTX1UOfURuW+F4C44E5Satvot5wF+nV+/vSEiG4o0=
X-Received: by 2002:a05:600c:81c8:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-48519881c4amr37952795e9.7.1772634016301; 
 Wed, 04 Mar 2026 06:20:16 -0800 (PST)
X-Received: by 2002:a05:600c:81c8:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-48519881c4amr37952065e9.7.1772634015755; 
 Wed, 04 Mar 2026 06:20:15 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d046:71eb:fade:f648:b219?
 (p200300cfd737d04671ebfadef648b219.dip0.t-ipconnect.de.
 [2003:cf:d737:d046:71eb:fade:f648:b219])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm25711418f8f.25.2026.03.04.06.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 06:20:15 -0800 (PST)
Message-ID: <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
Date: Wed, 4 Mar 2026 15:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com> <aaWfEfuBZGW4BHPD@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aaWfEfuBZGW4BHPD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On 02.03.26 15:30, Kevin Wolf wrote:
> Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
>> Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
>> pure data (no metadata) children.  These are going to be used by qcow2
>> during formatting, when we need write access to format the metadata
>> file, but no write access to an external data file.  This will allow
>> creating a qcow2 image for a raw image while the latter is currently in
>> use by the VM.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/block/block-common.h | 11 +++++++++++
>>   block.c                      | 15 +++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/include/block/block-common.h b/include/block/block-common.h
>> index c8c626daea..504f6aa113 100644
>> --- a/include/block/block-common.h
>> +++ b/include/block/block-common.h
>> @@ -245,6 +245,17 @@ typedef enum {
>>   
>>   #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
>>   
>> +/*
>> + * Promise not to write any data to pure (non-metadata-bearing) data storage
>> + * children, so we don't need the WRITE permission for them.
>> + * For image creation, formatting requires write access to the image, but not
>> + * necessarily to its pure storage children.  This allows creating an image on
>> + * top of an existing raw storage image that is already attached to the VM.
>> + */
>> +#define BDRV_O_NO_DATA_WRITE  0x100000
> Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
> doesn't allow reading either, but I don't think image creation ever
> requires reading from the image?

How would qcow2 set it?  It opens the qcow2 image, so it can only set 
the flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs 
to go on the data-file child.  Maybe we can construct the graph 
manually…? It would be quite painful, I imagine, but I haven’t tried yet.

Hanna

>
>> +/* Same as O_NO_DATA_WRITE, but for resizing */
>> +#define BDRV_O_NO_DATA_RESIZE 0x200000
> How does this differ from BDRV_O_RESIZE (apart from being negative)?
> Doesn't resizing always refer to the data part?
>
> Kevin
>


