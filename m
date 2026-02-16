Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FEFE81A5D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2aM-0007kl-2E; Mon, 16 Feb 2026 12:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vs2aI-0007kO-3H
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vs2aD-0005rC-Vf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771263628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WCtsCUh6yir89PRzfLaqp1HPi2b8excmso8MCzFxxdw=;
 b=Icy9g2ZCEXCZ84NK3py/zqhwGbfb4GxaXidX2gW0eCpjOX+lj7ZMlUpFQ+f6ci5zfogHfo
 d3M7cZlPgN1LVHE/syCxyMtIa4h+jQ3fGKvNB9IbCKp1pYvAMiE8+7Eb3VoygrMm+wM1K4
 pUnW+0vnH7qDS1oVY5qriFWVA3KOoYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-h45l2TztNvG3T4hhIemoWQ-1; Mon, 16 Feb 2026 12:40:26 -0500
X-MC-Unique: h45l2TztNvG3T4hhIemoWQ-1
X-Mimecast-MFC-AGG-ID: h45l2TztNvG3T4hhIemoWQ_1771263625
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483101623e9so30718005e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771263625; x=1771868425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WCtsCUh6yir89PRzfLaqp1HPi2b8excmso8MCzFxxdw=;
 b=Pbd20Hu9gs19wH0Ey4M9it/9G7FjkcmQH8sbIGuH9w6+9crewQSjpzGWkkA7npa808
 atSuzAyGLgzO7h8sfrBfihlRqWzcS6j2u8Ud0fshPc4E8YAnoEAgnbPS1zwFNwEQYNJZ
 gc9cpkVO+AE1z2EHT/AA16kLjSo3NnmdMg3kV6oEoWuP9vYlzJ2ftuxYmqD2pKfUi4Hi
 RbyCar2jo49l8EGRB8p065Jpa0bt4rsTdSH/zww02cMCOWcU6/loUve5Et4yQQ5KcwcU
 ofQ3wZagNARXXry5oP0e3AbhDCiy88/NELKxviBnKEMobWnkkX6wQsD9IUdGexOxO+r+
 CqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771263625; x=1771868425;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCtsCUh6yir89PRzfLaqp1HPi2b8excmso8MCzFxxdw=;
 b=qBChzVLF02xNfQeU7SiuVmybbdOHDBFFTrG3W438JaPZJ+1dXp+1y1XRiX2m5WVgI1
 4bcHoaiL6U/hyR/yyTJOA5aYQdbTp5zR2HNalkv3uzOdQnTGgFB7euQ9Rz0IQyv6/XoZ
 JK3cD6y4bnZ28cFE+ItuRf9zswOIXXVfwtvGZ86LREUPP3vnjL1b6UbjSkHWvpTXH034
 RAfXihPTmgNQFVoMcss5tccVKPT5SP+1ZNoxdJq3wj3xnKk4IH8rAZU5i9Zt7pliykwx
 MbOZHY1rINILxLUo9Ql3NbSBKHj80jjc2XWyLkJPyzhIVJOpbW/5KpLsYdE3pID3Q6rI
 Fkhw==
X-Gm-Message-State: AOJu0Yz8QdQJoJp3/hAptQX5mLkZtTG0aKdbrJBB/BFpZRus/AZYEXQ4
 PzJrDfLcppYtn2+Z18uNXGbnW8cCsLmXnTWA5RD/YLlgbdBUdyHQ3MYZeZhNNEwR5qxfhiwmK1M
 npetaPT+0b1QxmgN14IgPhr1Xw4TipFzdmas2kCt4whHX/EoCrDkMNgsT
X-Gm-Gg: AZuq6aImQKPijIMfkH0nWhuBPtbENy+L9vve6ve7M5XpnkngqKIBPF0dDf82kAJhwTu
 /mwX3xnL5g3Ydy2n/zJMyf+X/d1ogB9Nr2eLkQN+jmvnmGcf/SRQldJBFkGU7YImzyQMYXi/o2S
 fby0dmDOkwQZW9n/7DM4BSDkezwRlxgNOZeHtUtAocCI5xp8HPsCGJbQ8B4lAY9GofReGdMAfKc
 StU0+QSgbzEVEBgpk5EjWMAttof0QnKMLoWuV5Eiqoo7XpjDagjt7woKyy5Ka0ELCCLazTS+abx
 f5Rb82VCi8G+Q6OrjWY6DSGmOIooYGU8iTeSdrm+X4mUQghFHdk9RUT41XYvMV7C4F3n70Ds4A6
 k2/zRMPzUZP5slsO1H8xiBCZawjq+/LlUGXw3BCuRRfZA0+1up08KGRM/N3kf
X-Received: by 2002:a05:600c:1f8d:b0:47e:e87b:af8 with SMTP id
 5b1f17b1804b1-48373a5ba01mr202713105e9.21.1771263625439; 
 Mon, 16 Feb 2026 09:40:25 -0800 (PST)
X-Received: by 2002:a05:600c:1f8d:b0:47e:e87b:af8 with SMTP id
 5b1f17b1804b1-48373a5ba01mr202712595e9.21.1771263624966; 
 Mon, 16 Feb 2026 09:40:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm410765065e9.11.2026.02.16.09.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 09:40:23 -0800 (PST)
Message-ID: <7701d5d2-bf51-4c2a-bf4a-e371264d5874@redhat.com>
Date: Mon, 16 Feb 2026 18:40:22 +0100
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <28ce755d-c562-404d-a096-09b5f32f0945@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/16/26 14:25, Avihai Horon wrote:
> 
> On 2/16/2026 2:22 PM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Peter, Avihai,
>>
>>>> As for enabling the VFIO migration events by default, I guess we
>>>> all agree it could be done. We simply need a stakeholder to change
>>>> the default behavior.
>>>
>>> Ack.
>>
>>
>> There could be value for the sysmgmt layers to receive a VFIO
>> migration event reporting progress. For example, an event could
>> be sent from vfio_save_iterate() including relevant size metrics
>> to indicate progress (or not).
>>
>> Any opinions ?
> 
> Amm, I am not sure an event is the right way to report VFIO stats, as it's not some change that mgmt needs to be notified about promptly.
> 
> Mgmt layer can query migration stats when needed using the QMP 'query-migrate' command that returns, among other info, a VfioStats struct with the total amount of VFIO devices data transferred. If needed, this can be extended with more info about remaining data size, etc.
> 
> Makes sense?
so you would opt to extend migration_populate_vfio_info() with more
info on the VFIO devices. Fine. mgmt should poll then. My knowledge
on these layers is limited.

The extra info would be "precopy initial" and "precopy dirty" sizes
I suppose. Per device (more complex) or overall ?

Thanks,

C.


