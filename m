Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958BECDD1CE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 16:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suE60-0005rO-Fq; Fri, 27 Sep 2024 12:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suE5h-0005qV-3n
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:45:13 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suE5a-0006UP-Re
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:45:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so1944673b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727455504; x=1728060304;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRrYeoZ2vrk2HfqspxkUqdPoJZWVYEIuQPeMGyAYvZU=;
 b=XWqTsZAP2z8N5pKsdpaDaxe8mudbzDSBuJzaeftARuxobIpB5AxDWK+2NG0fPKFpb4
 vhOaDJO5X/hOQZzQCZQN1KUT38vg/B49QUX5YqMcUg2C4anZHwnsSPaaJbUNvnf82brb
 rNfrNZHZW4aqCRxYfDgqcvruZS7JdaPdTfx0ribwp9ZkOQOOzyywO8OGxtPZtshWbHTn
 IJ44dasWiYnuq2kbHpVbIj10xpjhcpNGHHEVFRow6XACMTwI7ollqFZTxulC+MvehtGa
 Gh5EeV9KsgCrSn6XQeqtxF72iRCg1Tqe0CETpj+pUXkzOXyrv2LkRlKlVxd3/qCOVPsh
 LYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727455504; x=1728060304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mRrYeoZ2vrk2HfqspxkUqdPoJZWVYEIuQPeMGyAYvZU=;
 b=YvVlIPaIZEBx6o+iUjE0YuP3nGmdxk3ZSmYwnqDbEo5hIhlCRpSK5G9q4YG5IVHUpD
 obiZ5DgrKBZUNnVKAw1nBTb0ADnihat0uUlvZgm293aaOBidfCFBx9oMvD633leQwILT
 qtNF4IJNjIINiMNvdOFZtyOU+NrHzdZ9PfzBkf3Gu0MCV7tdpBQdt9afvulzpCijAyAz
 FNuG4TOgs+J7x0IFmyIH+Mjo7Bs7p9ZhjAPeE/tg9wWex8QOSdgGxf6NSAWYdzQPmGoJ
 bjhrSMxrBa0k9duNN8rdhsjBwWw+l9gOeL21Gd3qhTW/2Fy+eCDQTxSlWBPgQhOEBp/R
 DXzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7KlEzagm+PeyRIy7M0gfukT6ylpoo+9N1eVC80YxleYcAEA2l4GlNP8sM/HSUWpBfWrv3YvTTb/yj@nongnu.org
X-Gm-Message-State: AOJu0Yy2r5M2fD4eeADbZYiXdL1ociNAT6SMdfIa797GJfB1RmZoQFhM
 IW/bqJol3pFhZKDrazsKsY5Xkh/bKS2NQE/eF4079LWAOfGv4nnx7kfONOUFXqI=
X-Google-Smtp-Source: AGHT+IEt3VL7noxJs1eAsCrq+mbLPdmnloBIcH6kuao1ZwLTF8u3DeGwADrRhJXsT2hk6TwzA0/mBQ==
X-Received: by 2002:a05:6a00:9287:b0:718:d5fb:2fc4 with SMTP id
 d2e1a72fcca58-71b25f38c9emr5817102b3a.9.1727455503056; 
 Fri, 27 Sep 2024 09:45:03 -0700 (PDT)
Received: from [26.26.26.1] ([165.154.21.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2649a29asm1870801b3a.19.2024.09.27.09.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 09:45:02 -0700 (PDT)
Message-ID: <32cf163b-b985-4be5-bc7b-e729cdd7ce2d@smartx.com>
Date: Sat, 28 Sep 2024 00:44:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
 <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
 <ZvW8LxJsv3pRWom_@x1n>
 <CAK9dgma-RFQ3akWDFHW5VhMPOdbT4nizSrixQK9x4W7W249raQ@mail.gmail.com>
 <ZvbQ0RQx-zxOeo4Y@x1n>
From: Hyman Huang <yong.huang@smartx.com>
In-Reply-To: <ZvbQ0RQx-zxOeo4Y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


在 2024/9/27 23:35, Peter Xu 写道:
> On Fri, Sep 27, 2024 at 10:50:01AM +0800, Yong Huang wrote:
>> On Fri, Sep 27, 2024 at 3:55 AM Peter Xu <peterx@redhat.com> wrote:
>>
>>> On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:
>>>> On Thu, Sep 26, 2024 at 3:17 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>>> On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
>>>>>> Yes, invoke migration_bitmap_sync_precopy more frequently is also my
>>>>>> first idea but it involves bitmap updating and interfere with the
>>>>> behavior
>>>>>> of page sending, it also affects the migration information stats and
>>>>>> interfere other migration logic such as migration_update_rates().
>>>>> Could you elaborate?
>>>>>
>>>>> For example, what happens if we start to sync in ram_save_iterate() for
>>>>> some time intervals (e.g. 5 seconds)?
>>>>>
>>>> I didn't try to sync in ram_save_iterate but in the
>>>> migration_bitmap_sync_precopy.
>>>>
>>>> If we use the migration_bitmap_sync_precopy in the ram_save_iterate
>>>> function,
>>>> This approach seems to be correct. However, the bitmap will be updated as
>>>> the
>>>> migration thread iterates through each dirty page in the RAMBlock list.
>>>> Compared
>>>> to the existing implementation, this is different but still
>>> straightforward;
>>>> I'll give it a shot soon to see if it works.
>>> It's still serialized in the migration thread, so I'd expect it is similar
>>>
>> What does "serialized" mean?
> I meant sync() never happens before concurrently with RAM pages being
> iterated, simply because sync() previously only happens in the migration
> thread, which is still the same thread that initiate the movement of pages.
>
>> How about we:
>> 1. invoke the migration_bitmap_sync_precopy in a timer(bg_sync_timer) hook,
>>     every 5 seconds.
>> 2. register the bg_sync_timer in the main loop when the machine starts like
>>      throttle_timer
>> 3. activate the timer when ram_save_iterate gets called and deactivate it in
>>      the ram_save_cleanup gracefully during migration.
>>
>> I think it is simple enough and also isn't "serialized"?
> If you want to do that with timer that's ok, but then IIUC it doesn't need
> to involve ram.c code at all.
>
> You can rely on cpu_throttle_get_percentage() too just like the throttle
> timer, and it'll work naturally with migration because outside migration
> the throttle will be cleared (cpu_throttle_stop() at finish/fail/cancel..).
>
> Then it also gracefully align the async thread sync() that it only happens
> with auto-converge is enabled.  Yeh that may look better.. and stick the
> code together with cpu-throttle.c seems nice.

Ok, Thanks for the advices, i'll check it and see how it goes.

>
> Side note: one thing regarind to sync() is ram_init_bitmaps() sync once,
> while I don't see why it's necessary.  I remember I tried to remove it but
> maybe I hit some issues and I didn't dig further.  If you're working on
> sync() anyway not sure whether you'd like to have a look.

Agree, I'll try it after working out current series.


Yong


