Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3599C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZcv-0002rx-QE; Thu, 27 Aug 2026 08:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzZcu-0002kC-4U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzZcr-0000yN-3U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787835274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WWeWQZ+6wD8cYEoKezHIE3Yb6Nv4kTvXOyeWYstJ0DU=;
 b=dsm62b5tS5Vxcfq6TBSHvaskFtl/0uMODmO6rYf8oKXW3sbivU2w5TkOTr/Arlrv+koO9R
 Hw/s0Gb9i8hAA2iSg54K5GvcTvhlJlXrLS4WN5yxsA95Xlj8R+E9TTMHLUjcurDrpBZIVQ
 8wToV2oxbGHf5p+ifP2SVJtEiS2ZznA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-FkY6jgjvMtuoQ2ZJE7t4jQ-1; Thu, 27 Aug 2026 08:54:33 -0400
X-MC-Unique: FkY6jgjvMtuoQ2ZJE7t4jQ-1
X-Mimecast-MFC-AGG-ID: FkY6jgjvMtuoQ2ZJE7t4jQ_1787835272
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1418680f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787835272; x=1788440072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WWeWQZ+6wD8cYEoKezHIE3Yb6Nv4kTvXOyeWYstJ0DU=;
 b=f0KCKMovyqijohWxQZNU4diWf3lPa1xdo5TuRmfjL/CJLlKQZbLYYuyoMYuKd3xx4v
 zrLyISs/E5Va+0EwuY5LMjPH/MU5hhxKxVUXR5Y1RgxYC04A5FSGHHIGK/TADvJ0M6MT
 P/FnSASIxrO60cKTOrUWDjAdMGF3i0ZOT2mmTxcsWxj/f3JOBihpv5/3+RhbIE7xMlI+
 B77NxaKdWfZckorfRrEIuyORtiVEn2sPbIsXdzgIo5Qf0GIx+HrVMXScE8+2iF+KRbWZ
 NaeyesRcDbQmEvQehkCRdnZ8tAt6sp/7xZ6fKKXB2usO/Boem89PIVfk0QWrIKj14q82
 iSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835272; x=1788440072;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WWeWQZ+6wD8cYEoKezHIE3Yb6Nv4kTvXOyeWYstJ0DU=;
 b=o1ay/wbrtgfwd76Q9a4Dkz75kO8AA753fVE1OEwQH1QNtozS3oZPOlxj2II7g7riaU
 xTAA+cbLZ7MIKvop4NoNVg7XAZl+ZENz+cYsPbdPOH0U7wNfEWM62aR0de+whwumH27G
 07WllgbgkCnydviIdreU49Na40aRzJTBCH2kPxaHZcw5ktohACqK3ntwIzgIMK3IZRoq
 d6c85QIq6gTajqIqsyJSkQ0zqveLixMiNhNJxo01UvxbZ1qbPftNHTds+ag1CpY1G9lr
 E37Vul+8j1MiB6thS6UqoVAAQOvEK9JDrRXs8pmD7wD2xa85cSb0+bkqCaXxE4p2vdG0
 +q6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMZ5u/jxqLhth3clWlqy+5kiVnba1lT6th6vMxA/D2AsdUEC5HLMUDTLT4ECKwdfxDHXOq7rKrrtpx@nongnu.org
X-Gm-Message-State: AFuF++kWw4Ec58wr6pbE6jNuaLUiHrBlROSZoAloE58QgcAUMRyWopDE
 M5UYe/piXRj33YI74MFDKDxrkfZShjtvz1k5nuN5QYKS9olkczxs9HszRQ2G8dkswSUdAgA6YLA
 5/IeSmMh4VnjS/0DBcpdL34sdk2OVnXZpUNCIcmhilrK5xL6LtVcoWc+Ky7u0qH+f
X-Gm-Gg: AR+sD13yJ7XBD0weR7UbR9W2jZ9XcInmU3tM5y6yUOKRxZcWWa/kqdVxW23uAtEhf+0
 QK8rLHLnjD/TSWcvFG3YkUo2BRe/a/La0B4g1USNyx+QdJmfrI1SjjNQ78ZsytPSZU+c4QjgS+k
 Xa2db6w0RY8Fi75FhvNI5s9BN69LydP3xemL88DrqQuK3VCow2PUlNTsKOJ85pKNdtgrOcVAXv3
 TyUqfcq6U9WRnPzYlyQ62rxBvloHDVhIHx+/rIpemIrc/9AzAkUXiKUFl8n7M+Ei9mWt/83pGUl
 8v/oKTgn2e054rzvGJ6V0eSF8oNkztcVPj5YBEFL2KNsUnOLxkICUaKEHANkH9Gmteq+5yL0jA=
 =
X-Received: by 2002:a5d:4f82:0:b0:482:e263:2c7e with SMTP id
 ffacd0b85a97d-482e26de754mr16336434f8f.13.1787835271813; 
 Thu, 27 Aug 2026 05:54:31 -0700 (PDT)
X-Received: by 2002:a5d:4f82:0:b0:482:e263:2c7e with SMTP id
 ffacd0b85a97d-482e26de754mr16336358f8f.13.1787835271321; 
 Thu, 27 Aug 2026 05:54:31 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f231dsm8611538f8f.31.2026.08.27.05.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:54:30 -0700 (PDT)
Message-ID: <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
Date: Thu, 27 Aug 2026 14:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2023 21.39, Mark Cave-Ayland wrote:
> On 07/10/2023 08:23, Thomas Huth wrote:
> 
> (added Natalia who was the GSoC mentor for the NeXT cube work)
> 
>> The machine is incomplete, and unfortunately the hoped-for improvements
>> never happened. So it's maybe best if we mark this machine as deprecated
>> and finally remove it again in case it gets into the way of a code
>> refactoring or other reasons.
>>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>   docs/about/deprecated.rst | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 3b074b9ed4..2f6dadd12f 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -253,6 +253,14 @@ deprecated; use the new name ``dtb-randomness`` 
>> instead. The new name
>>   better reflects the way this property affects all random data within
>>   the device tree blob, not just the ``kaslr-seed`` node.
>> +``next-cube`` m68k machine (since 8.2)
>> +''''''''''''''''''''''''''''''''''''''
>> +
>> +The machine never got fully implemented and can only show the firmware 
>> prompt.
>> +Given the incomplete state and slow progress on improvements, it might get
>> +removed again without replacement.
>> +
>> +
>>   Backend options
>>   ---------------
> 
> I'm torn a bit by this one - on the one hand the NeXT code could do with 
> some love, but then given that the code already uses qdev/QOM then there 
> isn't really much in the way of maintenance burden. The main concern for me 
> at the moment is the use of the old-style memory accessors that pre-date the 
> memory API.
> 
> With my latest ESP patches I think it shouldn't be too hard to update the 
> NeXT DMA controller to get SCSI working, so perhaps we can leave it for now 
> if it doesn't cause too many problems?
Almost three years later, the world changed quite a bit. We're getting 
flooded with AI-generated bug reports now, and of course people are 
discovering problems in this old and neglected code, e.g.:

  https://gitlab.com/qemu-project/qemu/-/work_items/4303
  https://gitlab.com/qemu-project/qemu/-/work_items/4304
  https://gitlab.com/qemu-project/qemu/-/work_items/4305

I think it does not make sense to keep this incomplete and experimental code 
around in (upstream) QEMU anymore. If someone wants to complete it, they can 
do it in their own repo first and resubmit it once it is really working. So 
unless someone comes up with very good reasons to keep it in the main 
repository, I'll include the deprecation patch in my next pull request.

  Thomas


