Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5872FCFA453
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eyU-0004gn-OA; Wed, 23 Oct 2024 13:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3eyS-0004g8-4d
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3eyP-0005Xf-2p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729703796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m0dK7uKKR7uPek/XBDB6iqghnZii0CsQJk1dHndIbuw=;
 b=Z+tIA4eqT8wSbl48hXOtktxsCptS8egF59Fok5ALzkY4rYFipdP3aGfWB9NkXCvV9mK6Lf
 wV1vaER+rgfsIx2D2g89Y2pEJ3VK0Sgvuel1WyV7q9/2rAWRZAojH+Z09ynuIBnTU9IL6f
 5LDRqxHhnTBKelbUxFSUbtGseEU3x6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Xl7dFSJfMbSsA_bRmFFiMg-1; Wed, 23 Oct 2024 13:16:34 -0400
X-MC-Unique: Xl7dFSJfMbSsA_bRmFFiMg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so3745203f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 10:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729703793; x=1730308593;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0dK7uKKR7uPek/XBDB6iqghnZii0CsQJk1dHndIbuw=;
 b=gmhekEKfEb9QPAKSR2aTVBAC3P5zml4S6J33lAlMRP60tnKbGKqfGKNSGuHd2BK19W
 OuHxODdJHBHu/CrwNE5qfjSLsGZrSdejVQz57J8m9jVUdhrRan8MowfdfH5tT4u7G0Lb
 kIDdT71fWgW1odcI28kdhjnPQEWH53DrracqIa4/P9BhD7QR1r52u26jYTWz1O4LuD1g
 ntyrx90zjDQsLvzurZUa2uJ41+1FwczlkbQour1CawtPAR8YP57iSe+q7TTHhujnFUjo
 Iqxy8lPiWKh2mjpQxbt+7wR/vav356ucHlHfh4JzxY+b8FCpmnJKzCVDnn3SARC8ql28
 N0Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrahlKNsfdm+08rvOP+8+tD0UYlq5UqSMwyPy5gl6ideKwO5l0WQFLVMwLIkNXUw5nrsgO85C1Koiy@nongnu.org
X-Gm-Message-State: AOJu0Yw3uG74pAf3ESGUPP0FEnMldAkCNgTu26CYT/cLeTmyRs/kXZXh
 pkr/VaFKtoVOryCwt55x6gjjL9p2I3sUkSCc/X/QtngFaObxoFqp6D93uwSBhoi1zl4MOCELwcg
 7r4wk4SaVi2EKu0VcGcehoGvfQEmVBqz8Be7wNZxQyX3iHmdjphTm
X-Received: by 2002:a5d:44c5:0:b0:37c:ddab:a626 with SMTP id
 ffacd0b85a97d-37efcef0f78mr2602136f8f.7.1729703792737; 
 Wed, 23 Oct 2024 10:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsv/mRgAq/R36xomBU229bzAwqWr5zyIeu+5as2+ZfJahxpUsSsHphinj1eDA/H3wFC0cpFA==
X-Received: by 2002:a5d:44c5:0:b0:37c:ddab:a626 with SMTP id
 ffacd0b85a97d-37efcef0f78mr2602106f8f.7.1729703792277; 
 Wed, 23 Oct 2024 10:16:32 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bb42sm9281990f8f.98.2024.10.23.10.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 10:16:31 -0700 (PDT)
Message-ID: <40f0a7da-bf46-473b-a002-b71146f984ad@redhat.com>
Date: Wed, 23 Oct 2024 19:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de> <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
 <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
 <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com> <ZxZ_Y3DYgs8ZlhaI@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZxZ_Y3DYgs8ZlhaI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/21/24 18:20, Peter Xu wrote:
> On Fri, Oct 18, 2024 at 03:15:56PM -0400, Steven Sistare wrote:
>> I understand this now.  The old code worked in this order:
>>
>>    qemu_create_early_backends()
>>      ... creates "-object can-bus,id=canbus"
>>    qemu_create_machine()
>>    qemu_apply_machine_options()
>>      applies link property "canbus0" with value canbus, finds canbus object
>>
>> The new code fails:
>>
>>    qemu_create_machine()
>>    qemu_apply_machine_options()
>>      applies link property "canbus0" with value canbus,
>>      error because fails to find canbus object
>>    ...
>>    qemu_exit_precreate()
>>      qemu_create_early_backends()
>>        ... creates "-object can-bus,id=canbus"
>>
>> The fix is to provide a new function, called before qemu_create_machine,
>> which creates only the backends that are needed to create the machine.
>> AFAIK can-bus is the only one, because the xlnx-zcu102 machine has
>> link properties.
> 
> Wanna share more on the specific solution?  I wonder if the plan is to add
> one more special window for creating -object just for can-bus, and how to
> justify that extra phase.

Unfortunately, I don't think there's _anything_ that can justify an
extra phase of command line processing.  The only sensible way to do
precreate is to get rid of as much as possible of the command line.

There is an old thread explaining what was fixed in preconfig in 2022
and what was missing.  Start here:

https://patchew.org/QEMU/b31f442d28920447690a6b8cee865bdbacde1283.1635160056.git.mprivozn@redhat.com/#7f54174b-4f90-13bf-6905-6febb6203575@redhat.com

Already there I wrote "one thing I don't like of preconfig is that command line arguments linger until they are triggered by x-exit-preconfig".

Paolo

> Perhaps whatever that do not require fd to back
> it (so not affected by CPR)?  But not sure whether that's too special.
> 
> I wished it could be simply put into the "very early" stage (pre-sandbox),
> but I think object_create_pre_sandbox() did mention that we need explicit
> reasons for those, and I'm not sure whether this reason justifies either
> for why can-bus is so special so can be created without the sandboxing.
> 


