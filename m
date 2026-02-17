Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2C7E909A9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsLga-0000Q4-HE; Tue, 17 Feb 2026 09:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsLgV-0000Pr-JK
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsLgU-0007sT-2P
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771337052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rFKAlXnqq6N0QcmVaxOmZP16e3DD4SfoNa+t7G243RI=;
 b=EgwPyPi6iy8fxqv/Gi4yxDjFxP7MucWpSQGMTSnlQHici8IK6Ghkq3ZlaiwnTdyS5c9lQa
 MCfVI4015KISGoNzz3SoKu2NsspHnbJGhHwFBQJoGrZALbI1K/XM7oWuj/qRjshdgUNorm
 J5iZY/SXBpIo4FQxvSut04A87s3dtRQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-nhJWQef1ObmRJhohTv2jnQ-1; Tue, 17 Feb 2026 09:04:11 -0500
X-MC-Unique: nhJWQef1ObmRJhohTv2jnQ-1
X-Mimecast-MFC-AGG-ID: nhJWQef1ObmRJhohTv2jnQ_1771337050
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so24072825e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771337050; x=1771941850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rFKAlXnqq6N0QcmVaxOmZP16e3DD4SfoNa+t7G243RI=;
 b=I0VL99TJGyS0CbpY9aMWek0eMO4rIOH1trBfNgpku7eG8VeAjVuYvTdc/DXL/jCsNT
 /fI3NqTZa3rjuU4wtCGn6JHgBe64FDFGZQIdzo5Z1d0nm7V/PeHNc1Q0Llx5HF4JXNB1
 L4jgw0Roe4j3lO3yLohfPwLZEKCG6If4+f4TDx8gID1L8xGzPrEB1oWbV7v0XbEbOuO7
 5Ysq37qY09lmv/oHvvEy97us200ExAd0tiM5mkMnSI4XDYPbRK395oRixyTBQ6QjcIMV
 QmHGgxVbdC+U2E3IsSPcDGUY9AHrINbZApveciHlIHYkMpfBSZGnreBjJKFsmb/IGWy8
 RjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771337050; x=1771941850;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFKAlXnqq6N0QcmVaxOmZP16e3DD4SfoNa+t7G243RI=;
 b=B4rHgtLzK2GYDiTsuYNnr9szcrZtPoqsPJ5HaoPUDqSex1xy1q8dWaU2v0SvBxoazY
 G6lGcA0gd9an+r5IIw1ha9zlVn7uL/Hm1ceE44ld2Y4Ddj7DmqbbU/2n870BpX/kTX9z
 LM6Txp2K9gVN2KDzgQ4/cMdryFC5YuONUOKEYIOgxLhmEnoVId6ifMt0NpJaXONRZ1hr
 77PrF2Pi0tYLvx/xN4MhX2XiS0g1QmW65DOKaEdeJNexdDaNrgzZt6w57J/ZblK29rbF
 vfXMb0ELVGpal9GutFEvT5mktqVO8ukIbtEwzpaXaJem74CM52OIvGmscAM/Q0lxS3d4
 2gsA==
X-Gm-Message-State: AOJu0YzLMFTcAo3etwD67Am+931CwSXokxmd6f8KLFAWk80YbDM8iQHG
 u2UK+5/9tMXJXAVcSMjuBEX1+iuli+VU7y6BkKUT5/9rLljrrfKVcmv4tjCq9/JTdlUYcniNrKP
 4MRiCX0RdzHgCBomv4ZaJ8bPUy+zbJw2Ml42yA8Ae5nuXO73vRRv+aBGY
X-Gm-Gg: AZuq6aIj4l/NwHuBCzI4TgnOMvY8AvLuex2mQZPiLCjIXicJ3abp6GqyMr8qD06d+Rt
 3dOgVke2OoatU36VQ2JT01TWLVuexwY/XH2cjVxhmraT8w1Ycv4Ctm5vAfz2cIQ4BqReFnx2S16
 RXAsvTal/75/v0pcTx2z6SL7ygVgWJ+EjHJZuRP30EhDS73OTpCGrXT35DiOIL3CpmkCBSmUG96
 5B1BxtEY9RABk1aOIRDaLPyzeDDTu6TDBoMB2xl2Z97kF5H77vpEqJ4GK37W/LDE44FKPYMGRKL
 B3LRXsDsdmXTDy1KGZnzPKLy0YZF0MBqS7miK8acPw1M8j6Q9VTDYwF6hdJItU0pc5BJN0o+L67
 eNIBLnRtc3NB8iNrm/y6pV20C6GSEsJfLO7j4rLnmPM3p/qbhEpa4rcU8wrHV
X-Received: by 2002:a05:600c:a113:b0:483:7ce6:1efb with SMTP id
 5b1f17b1804b1-4837ce6228dmr152731205e9.17.1771337049945; 
 Tue, 17 Feb 2026 06:04:09 -0800 (PST)
X-Received: by 2002:a05:600c:a113:b0:483:7ce6:1efb with SMTP id
 5b1f17b1804b1-4837ce6228dmr152730715e9.17.1771337049510; 
 Tue, 17 Feb 2026 06:04:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm564851535e9.7.2026.02.17.06.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 06:04:09 -0800 (PST)
Message-ID: <93a65840-73ff-4587-9321-09cda8654f1b@redhat.com>
Date: Tue, 17 Feb 2026 15:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
 <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
 <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
 <28ce755d-c562-404d-a096-09b5f32f0945@nvidia.com>
 <7701d5d2-bf51-4c2a-bf4a-e371264d5874@redhat.com>
 <68820edc-9527-4c8f-8651-64ea75db8380@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <68820edc-9527-4c8f-8651-64ea75db8380@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/17/26 14:05, Avihai Horon wrote:
> 
> On 2/16/2026 7:40 PM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/16/26 14:25, Avihai Horon wrote:
>>>
>>> On 2/16/2026 2:22 PM, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> Peter, Avihai,
>>>>
>>>>>> As for enabling the VFIO migration events by default, I guess we
>>>>>> all agree it could be done. We simply need a stakeholder to change
>>>>>> the default behavior.
>>>>>
>>>>> Ack.
>>>>
>>>>
>>>> There could be value for the sysmgmt layers to receive a VFIO
>>>> migration event reporting progress. For example, an event could
>>>> be sent from vfio_save_iterate() including relevant size metrics
>>>> to indicate progress (or not).
>>>>
>>>> Any opinions ?
>>>
>>> Amm, I am not sure an event is the right way to report VFIO stats, as it's not some change that mgmt needs to be notified about promptly.
>>>
>>> Mgmt layer can query migration stats when needed using the QMP 'query-migrate' command that returns, among other info, a VfioStats struct with the total amount of VFIO devices data transferred. If needed, this can be extended with more info about remaining data size, etc.
>>>
>>> Makes sense?
>> so you would opt to extend migration_populate_vfio_info() with more
>> info on the VFIO devices. Fine. mgmt should poll then. My knowledge
>> on these layers is limited.
>>
>> The extra info would be "precopy initial" and "precopy dirty" sizes
>> I suppose. Per device (more complex) or overall ?
> 
> I think per device would be more helpful.

Yeah I think too.
  
> Extending migration_populate_vfio_info() could be a nice add, but 
> I am not sure how is this related to this patch I sent?

I was just extending the discussion, thinking aloud. Sorry for the
confusion.

This patch is in vfio-next. I am waiting for Ankit to respin its
series and I will send a PR.

> Or we're discussing this because you initially thought that this 
> could be a reason to enable vfio events by default?

It could be a reason but it really depends on how the sysmgmt layer
wants to consume the info.

Users have been requesting more fine-grained VFIO information to
improve the migration flow. Leveraging VfioStats seems to be the
safest approach for that today.

Thanks,

C.


