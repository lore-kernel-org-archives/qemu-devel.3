Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54234C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4kU-0005FC-54; Tue, 07 Jul 2026 08:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh4kQ-00059v-Ji
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh4kO-0004gS-Tj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783426676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ECDQsxluyho4egc8t6HHc4AFDsro4kisteGh+3jEU3I=;
 b=E9/IPB780aPBrbTf5Gr1QAcyEXyBHVEhuczZ+rGv9CrY8nxcj8Yl1TpXA+t6BZ+6vlCcD8
 wWT7tzr6KT+GsKX03AtX4UMZz61l6t7ybwC8gS1lWZQoLJhniicthUVMat/4jAgh9EKEKK
 2J/kwN/cHY2oq9UM/FTdqQRvyPIGvUw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-2QvSBOkoPxyYUO1-uUQbSw-1; Tue, 07 Jul 2026 08:17:54 -0400
X-MC-Unique: 2QvSBOkoPxyYUO1-uUQbSw-1
X-Mimecast-MFC-AGG-ID: 2QvSBOkoPxyYUO1-uUQbSw_1783426674
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49244130073so28349235e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783426674; x=1784031474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ECDQsxluyho4egc8t6HHc4AFDsro4kisteGh+3jEU3I=;
 b=SITk4j30HVS+Ra8HxKDZTaad3ZDPf596qeRQxLq+KY87OxZ2mPbqGhIHux9U+Xjt0L
 oegU0NUUU+HqbHTNmXYZt+hBKer9YCZM0Oh2pvbbu8qY5H0Ubc59cjc9qXflsS+Coit5
 CY41V576sO0sHY1E74QUPyhVzBXCwJ3j+dmZqbpvnCeRg0XShVhg6y0JDLb/Dun0UkpD
 WAmOWoKFEhW8Z8qrxvX5pOFtv7pR53repqJJz1j/t8gV7ieImUGz5kXdq/97EjVhCfxg
 cq/uWcsH7F2n2UApg3V8qlNkZFseKT3sV76Kc5jixnQVk456BkBC0Un5AWi4Osg7CGe7
 xh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783426674; x=1784031474;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECDQsxluyho4egc8t6HHc4AFDsro4kisteGh+3jEU3I=;
 b=PDVl9N86auVxUsvegAqfji3KexzbliBMzKNykYVqDVS3uFTIxMRLSUNS6DVx0DO1FM
 J++HbLDtLGqLtVqqPJ4TZT5POdYvDS9U/q3089ZlPZ/y7jtOndfNIefmmO1+WIzcyskT
 gcn61u7pYf08QvFXxrz4fSVyht9nABnmKi92DoHSt9X5nXRzMG9ZBLDfa+Vg2GyMfx3d
 ffISL/k16nb1zhf6oGeL1xb9nSXPPPDP1qB9LMzC0/Cc/Oi3eq4j1kX30tukClgyeuIe
 ZaVW2lPaQ6GF4OwFj09GcIEKBBM2TzNPaTWPh6J+EJtyn8L4bgpe/H8GPbGp0YBqbbYv
 V89w==
X-Gm-Message-State: AOJu0YygUw5fobT7XLmus/0vEyfXpJ0XNcIFer7ZZAsrMSqp+sb3QESS
 7MIVxnjsKKuHJAxcS6EHlSWMHtQK26fVD22A0AuHXSYACdjCXsvJWWoFmAeZ/oxOHASYu3OIEAa
 RNE0Bia5haDLMm+NuSW/LHaWbvRFYFE9tRJQMe92ZBsVIdSLUTLmf1YL7
X-Gm-Gg: AfdE7cnVmmX32rFnEXKKxeiMGfqLltSTdrBtGHGBaeMkvyx29vPoDQX0xn4AVyOcA/+
 Kf/HoQAtwdSinwIB5WtqtgGJjpUJbiFvnsQARqigwNE7KGf2Ihmk8Tv+ZI0+j/gZFBK+lG7TBY2
 j2xpJ0aWryRSQBD0dnny3SkBRPv4+oq5TBhlTMRomEgDO5sQ8z9jUnBfc4gj+IwcsSQUwTD/LO0
 B2NAwYzNRm2cZvVk7Ock8RXMrCfcIEcV62N0jAUNUXLaD7lU0kocpzuNPw68owuJq5JeoCzFn/V
 pUp3ySefjS8N9T+cXgtOMhvSenj1FBytVGxPadkAy5WI7QECSlhLEk0CfsjT7znhu2ZY2gC4Yrx
 MRnk2BjR/iuqFIb7b8aYgeqfIoxmuQwi0SWrKPiJAPG64RsqQMA==
X-Received: by 2002:a05:600c:190f:b0:493:bcba:46a4 with SMTP id
 5b1f17b1804b1-493df0641e6mr58078065e9.20.1783426673655; 
 Tue, 07 Jul 2026 05:17:53 -0700 (PDT)
X-Received: by 2002:a05:600c:190f:b0:493:bcba:46a4 with SMTP id
 5b1f17b1804b1-493df0641e6mr58076805e9.20.1783426672816; 
 Tue, 07 Jul 2026 05:17:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3677asm48059215e9.4.2026.07.07.05.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:17:52 -0700 (PDT)
Message-ID: <3da451ff-f251-4504-bb71-b935ea3d3d54@redhat.com>
Date: Tue, 7 Jul 2026 14:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] migration: Run final save_query_pending at
 switchover
To: Lukas Straub <lukasstraub2@web.de>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-4-avihaih@nvidia.com> <20260707121609.40bfdcf2@penguin>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260707121609.40bfdcf2@penguin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/7/26 12:16, Lukas Straub wrote:
> On Mon, 6 Jul 2026 11:51:58 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
> 
>> Before switchover, the source needs one last exact pending query so
>> modules can flush dirty state. This is currently done ad hoc in modules
>> handlers. For example, RAM syncs its dirty bitmap in its save_complete
>> handler.
>>
>> This should be a general concept relevant for any module, so extract it
>> to migration core instead by running a final save_query_pending before
>> switchover.
>>
>> The final query requires special handling by modules (e.g., it's called
>> with BQL locked, during VM stop), so extend save_query_pending
>> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
>> flag so migration modules can tell the last pending query during
>> switchover from periodic iteration queries.
>>
>> Call final pending query also in COLO checkpoint, which needs to flush
>> dirty state before the checkpoint's live state is saved. Unlike a
>> regular switchover, COLO reaches completion repeatedly for every
>> checkpoint, so this must be done on each one.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> 
> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
> Tested-by: Lukas Straub <lukasstraub2@web.de> (COLO parts)

Thanks for the review and for testing, Lukas. I sent the MR earlier
this morning, so unfortunately your contribution won't be included.

It's on the list !

C.


