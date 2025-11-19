Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27816CF6487
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 22:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLqfU-0006Tl-DW; Wed, 19 Nov 2025 17:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLqfP-0006T6-3h
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 17:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLqfM-00010j-Uh
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 17:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763591322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N/Cm/PV/41Zna1tQB0q52TvZpnbnsrwm38rZij0xfl0=;
 b=BNyPoVqZ40f0/G9KpCfKKQpjc/XHfxyMtsBMwIyqnHbn2AD9aJ17KvfmaTUttIQYr9Y4If
 Qe95gb+6+yIU/0MGSxC0n3HWenw/WayEDTOWoXJp6adgTK0JTCdVfEWbjwqCyDmwrk6lwI
 1ObshjBDpiImuEzz19M3x1NoqFfwJ+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-ATu0scvRORKJ3w_dzwJWSQ-1; Wed, 19 Nov 2025 17:28:40 -0500
X-MC-Unique: ATu0scvRORKJ3w_dzwJWSQ-1
X-Mimecast-MFC-AGG-ID: ATu0scvRORKJ3w_dzwJWSQ_1763591319
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2ad2a58cso91057f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763591319; x=1764196119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=N/Cm/PV/41Zna1tQB0q52TvZpnbnsrwm38rZij0xfl0=;
 b=FKLdy1Q7BjNMJ/zZzQAa0RWR9GQSl7BdWt8zFNMWs2rL7cobhbkgyXBQJ9GCi5/Zdt
 1DmAaucsLA8+20npjhBJbOD/zmBCC7aWGpamqR96jRUn1QWxm6mfVTngXFUIvkPX1/s9
 3ezi1TQFQQhh9MA2o35p6kUg3O1icOb/KPKuEAxtix53ClvskSUKilQL+3vMlmYXQxFV
 OjqAMjpakSBOqKaVXGmFbPugKbWjeXKuJut9WK+GvcNJT/LwvVuR5P3mi/NclYs1/CIz
 atGoZYzRQbiogoilP0sSpmNqgJOsms8goPeANafh2YoIqtVwCxdUK42sDw9N6WghMyO9
 HfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763591319; x=1764196119;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/Cm/PV/41Zna1tQB0q52TvZpnbnsrwm38rZij0xfl0=;
 b=hnG+g61byFbWOjkOxJPrltwnnPsN3AWb+sHrbmOa4vHwvHeZGUzlcmi38nrBbMf+JM
 BVQU/W/f1YhK+Bhi8yU6ETTNKaL7iaZ8Lt76tZW/8wqOKNy6cUCweg7+gQ98Lt5SuAwb
 AmrlFCrmolq78k2Pgkj3jwnIXJ8QqvaKQEH6Ug7/xCal7GMU0z4LErOFG1kQ2XZeWHPl
 7phHGKORRsDHoz8YTtFVn54Hu75Gi3hUDGC+LnGGItS3t1TRmtHHOHsQS0aLJLXHLjf8
 RhkFM6f16szoeUWoWD6RAkuPjXMI1bHNu7KHcY2CpdrVsqREcwqDYZhdi/IU60HHMih/
 x7eA==
X-Gm-Message-State: AOJu0YzQo16OAdAQeGb00C4lT6sv3+XneFfshi7c4JcaP+kjGEP0fsVA
 ZXh3+T8+fVunFm+z7iJRbeHVg36JqzukOUSx//eAE+BjdEXa70gkTVqgm2GAh33p3DXhJiw4cdv
 UBCPwnwR/FA01bI13O1qiFQE95iWxvdZCsUcq8LUZfe7HYkvglLgtNbdq
X-Gm-Gg: ASbGncuIZ8fBRZTqwk1vjBsJtKHwdMrP3JY+RZBen7k7WY0C0613XSEQDvAKa78g47u
 kHvpAJnwWpeg4M7ZBR3TbsXjwtIW4XAuTomVh7alY51uTKPBR/Trro6Y6D6f64Kso9S1p6oyMaV
 0I/7mpOM36QuJvmzyWsq7dqoJInH3tE3njRYYSYoZjkhuYbTpPbB+KKLC1EE95w8KAn7EXaAOqp
 kFVaUAl6SBny8jzbSnFbP91vh/tFEGqRPL79Kv5Um41/TOmkex7Rl+gX/TG2G0p9OSCMVP2bUFI
 RMgmbD+sVGva4XQLc7iLsJFc5KcSIAIdBngMXvPTGCThg+xDeim4jp0DjRWGAFzyS6qorZRqjL+
 dpKXYJX6gMAoI0zE/8MgfU252VHBspkh+hXNE1LorFQ3Tu7a0Tc0NbmEvJ4Tn1rtuH6E9FBeHb4
 cw+3HkgPPQa6GJ+Bs=
X-Received: by 2002:a05:6000:2385:b0:42b:41dc:1b5d with SMTP id
 ffacd0b85a97d-42cb9a0bdf0mr360308f8f.25.1763591318781; 
 Wed, 19 Nov 2025 14:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUv9WjeaAxngoexi4ww9b7KWOrfXw/ZpMWF9C6McfRh4wRXJElDz62UUL7iTkrYl+kIXO8Hw==
X-Received: by 2002:a05:6000:2385:b0:42b:41dc:1b5d with SMTP id
 ffacd0b85a97d-42cb9a0bdf0mr360295f8f.25.1763591318406; 
 Wed, 19 Nov 2025 14:28:38 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8baesm1478117f8f.39.2025.11.19.14.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 14:28:37 -0800 (PST)
Message-ID: <91bf0b22-33c4-46f7-95fa-f634eb069ea7@redhat.com>
Date: Wed, 19 Nov 2025 23:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] rust/hpet: remove BqlRefCell around HPETTimer
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-4-pbonzini@redhat.com> <aR3fhvpIsXRnQcj8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aR3fhvpIsXRnQcj8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/19/25 16:17, Zhao Liu wrote:
>> -    fn init_timer_with_cell(cell: &BqlRefCell<Self>) {
>> -        let mut timer = cell.borrow_mut();
>> -        // SAFETY: HPETTimer is only used as part of HPETState, which is
>> -        // always pinned.
>> -        let qemu_timer = unsafe { Pin::new_unchecked(&mut timer.qemu_timer) };
>> -        qemu_timer.init_full(None, CLOCK_VIRTUAL, Timer::NS, 0, timer_handler, cell);
>> +    fn init_timer(timer: Pin<&mut Self>) {
>> +        Timer::init_full(
>> +            timer,
>> +            None,
>> +            CLOCK_VIRTUAL,
>> +            Timer::NS,
>> +            0,
>> +            timer_handler,
>> +            |t| &mut t.qemu_timer,
>> +        );
>>       }
> 
> I find this way could also work for BqlRefCell case:
> 
>      fn init_timer_with_cell(cell: &mut BqlRefCell<Self>) {
>          // SAFETY: HPETTimer is only used as part of HPETState, which is
>          // always pinned.
>          let timer = unsafe { Pin::new_unchecked(cell) };
>          Timer::init_full(
>              timer,
>              None,
>              CLOCK_VIRTUAL,
>              Timer::NS,
>              0,
>              timer_handler,
>              |t| {
>                  assert!(bql::is_locked());
>                  &mut t.get_mut().qemu_timer
>              },
>          );
>      }

Yes, but I'm still not sure what the final shape will be... I don't like 
this too much.

> 
> So any other non-lockless timer can also use this interface to
> initialize their BqlRefCell<>.
> 
> (BTW, I find BqlRefCell::get_mut() / as_ref() missed bql::is_locked().
>   right?)

as_ptr() doesn't need it because the pointer can be dereferenced later.

As to get_mut()... I think if you are the only owner, you should have 
the guarantee of being able to modify the content freely.  This is true 
even if your &mut came from interior mutability.

So, in the above case you only need &mut t.get_mut().qemu_timer.

> I think it may be better to add doc about how to use this for
> BqlRefCell<> case since there'll be no example after this patch.


