Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D604D5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 07:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVPK6-0005mg-Mi; Tue, 16 Dec 2025 02:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVPK4-0005lY-01
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 02:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVPK1-0003l0-DM
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 02:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765869491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Db6Wv2XMK7xEwe3M1XYHU8lkWRZq8p962eh/E6L69HI=;
 b=etwBSHNMZEzRx/sRc06QrgnzImWjY+ohiiWeg94BCpxSokEz2oxorcJwhNwdLG4CplCmQv
 ex09CH2HUXv/co3t8fWytgC4wH/yNMrQijJL5OMjPqbL1Sv2WzXZvOVut8c3XesQ6zI50g
 q+nCcjGaQyxb9z8HpPIayT8N6c5Rexk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-pacssJr2PIWHFgC1qRIvtg-1; Tue, 16 Dec 2025 02:18:09 -0500
X-MC-Unique: pacssJr2PIWHFgC1qRIvtg-1
X-Mimecast-MFC-AGG-ID: pacssJr2PIWHFgC1qRIvtg_1765869488
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-640b8087663so5794124a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765869488; x=1766474288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Db6Wv2XMK7xEwe3M1XYHU8lkWRZq8p962eh/E6L69HI=;
 b=Grf9kkEtm5skAoU3FotsUirYuj/J8y+ApYhS+t3oEnyOSgB69oMLc1prrXJbikW32n
 /C12rRjCus8MLiTTDPOoc0xDTX3P0KxXMHswmxdGVS92yqAwSBVPfm09UkGjeyLXD/GZ
 3IhizVA7cz7xYzle40AQu/92yd4loqRBF9DjA0DR+yY9ic4mkbCMX2RsBjk8GJgX1wwm
 MpEODvrX+/ezcF8rMAXL/eAjixyFyoGFtwSWXlAQaurAVyPY4rZHZg7AmSSSOG3pc+Wa
 +TGJlX2A5UM94QnjxiX5Ln7al6xNjm+63t0SiVPtgL7Y24+ZTJjyW0YvedEE5z2r1+nT
 FJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765869488; x=1766474288;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Db6Wv2XMK7xEwe3M1XYHU8lkWRZq8p962eh/E6L69HI=;
 b=mj35zL4wRsry4U7PjQTPRme4MTSUyu9nrOIGL6qTnLpIFeY+CzbWcSozrlvFX7AABz
 kK1dOeQ3CD7ZyUDIhRjwKauhmEqgQBxq1Oaz3OHEw77nflUm7467e9dEeucMaxGONCAS
 ZZm8fgYQW8wIwYnTzpZ15waCYgNZFlmLWppylpBTSs3ro3XKikX7T21B5Y7OdwoFk9w3
 fjauF+ETvPuuCLgdphBELqaEQeYl8Hjr28wIhs5ZGec5Ecld/EYmZGzVPcI1uCaDWaK1
 HbfV/hIF2vy1oZbCa4/QQauLdTHxvkN6auwuU9PYG5RKZ8E+PGRCiMx6NIrpugZ0y9c4
 jV3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Rb3UYSa/rAMctl0AfFbNR7CKw3gott0FJTwx9SEwjJtLk9HUsgqyb/Djfi3BZXvJ4ngMlNQy7EoL@nongnu.org
X-Gm-Message-State: AOJu0YxB/raAPTYhuS35oRYMY/tgLzoJBNhsMa+4H6n6aBSQ0Y4D1OBi
 BdgaLcMMvx64ndrkT2n6jbDbEXDSeSEFh2Jx0N6RL3Zrh3PifKhoKD8gHVV5cF+zbbaZuydatgo
 fUxQDzorNxcTBWejshj3ICux4Yd1GBLORCAF0MZCVsxfwDJ/H/ZoSTW8z
X-Gm-Gg: AY/fxX4f9afS1F9SS2fIw2IRACbc18B/XX3dbHV/2FFqzzG2oIDs5anY99HAm6dsMsj
 IJy53COAUEVORaNY5JHlZRYuJ1Jn9M+Um6IpL/YfrkbP0HPeof4oLeLkMwW11hTa3TMxboPqhNm
 BGGsJkbWGaGgx422R9tSJJOXmS2MRB/NTy9EmTVsv+dT1DmJJ+DZqO4rRakeDKD0NI0V9QwcHlJ
 XJ2evDpCLJ5es70zfaYp9i0QQNgqmXHB9u6TZxbtkZAAgpva8h2RbozLWIvfWdalG5WzXkNMAFd
 iC6Sp3UWN5yerdFZBJUp9EO6QAkNL2ZTuzYnZuPvDmg7vyMlnnzXNWOAqfcTrWiuvq4YLINWOU8
 pRphCc+s=
X-Received: by 2002:a05:6402:1456:b0:649:d81a:d963 with SMTP id
 4fb4d7f45d1cf-649d81ad99emr6514769a12.27.1765869488359; 
 Mon, 15 Dec 2025 23:18:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMsa6uwT8pGdGSq9o0onXVGXzep9nayvRE2Ein+d0YjIEDS5AQpjWAh7C1h23MPKtiKvU0BA==
X-Received: by 2002:a05:6402:1456:b0:649:d81a:d963 with SMTP id
 4fb4d7f45d1cf-649d81ad99emr6514733a12.27.1765869487957; 
 Mon, 15 Dec 2025 23:18:07 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6498205188csm15249087a12.12.2025.12.15.23.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 23:18:06 -0800 (PST)
Message-ID: <e9f898be-54c1-4253-b3fd-1b3ac1fe57ef@redhat.com>
Date: Tue, 16 Dec 2025 08:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
To: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake
 <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com> <87jyyrv1br.fsf@suse.de>
 <aUAQNaA_sW8hxW2Y@redhat.com>
 <e62e8105-7add-45ed-afc2-9d6b1403b135@redhat.com>
 <aUApJ23dL8JuAayW@redhat.com> <aUAzXwM5iQnscHcc@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aUAzXwM5iQnscHcc@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 15/12/2025 17.12, Peter Xu wrote:
> On Mon, Dec 15, 2025 at 04:28:39PM +0100, Kevin Wolf wrote:
>> Am 15.12.2025 um 16:11 hat Thomas Huth geschrieben:
>>> On 15/12/2025 14.42, Kevin Wolf wrote:
>>>> Am 12.12.2025 um 22:26 hat Fabiano Rosas geschrieben:
>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>
>>>>>> On 08/12/2025 16.26, Fabiano Rosas wrote:
>>>>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>>>>>
>>>>>>>> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
>>>>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>>>>
>>>>>>>>> When shutting down a guest that is currently in progress of being
>>>>>>>>> migrated, there is a chance that QEMU might crash during bdrv_delete().
>>>>>>>>> The backtrace looks like this:
>>>>>>>>>
>>>>>>>>>     Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>>>>>>>>>
>>>>>>>>>     [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>>>>>>>>>     0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>>>>>     5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>>>>>>>>>     (gdb) bt
>>>>>>>>>     #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>>>>>     #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>>>>>>>>>     Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>>>>>>>>>
>>>>>>>
>>>>>>> How does the migration thread reaches here? Is this from
>>>>>>> migration_block_inactivate()?
>>>>>>
>>>>>> Unfortunately, gdb was not very helpful here (claiming that it cannot access
>>>>>> the memory and stack anymore), so I had to do some printf debugging. This is
>>>>>> what seems to happen:
>>>>>>
>>>>>> Main thread: qemu_cleanup() calls  migration_shutdown() -->
>>>>>> migration_cancel() which signals the migration thread to cancel the migration.
>>>>>>
>>>>>> Migration thread: migration_thread() got kicked out the loop and calls
>>>>>> migration_iteration_finish(), which tries to get the BQL via bql_lock() but
>>>>>> that is currently held by another thread, so the migration thread is blocked
>>>>>> here.
>>>>>>
>>>>>> Main thread: qemu_cleanup() advances to bdrv_close_all() that uses
>>>>>> blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name
>>>>>> 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
>>>>>>
>>>>>
>>>>> Has qmp_blockdev_del() ever been called to remove the BDS from the
>>>>> monitor_bdrv_states list? Otherwise your debugging seems to indicate
>>>>> blockdev_close_all_bdrv_states() is dropping the last reference to bs,
>>>>> but it's still accessible from bdrv_next() via
>>>>> bdrv_next_monitor_owned().
>>>>
>>>> The reference that blockdev_close_all_bdrv_states() drops is the monitor
>>>> reference. So is this the right fix (completely untested, but matches
>>>> what qmp_blockdev_del() does)?
>>>>
>>>> Kevin
>>>>
>>>> diff --git a/blockdev.c b/blockdev.c
>>>> index dbd1d4d3e80..6e86c6262f9 100644
>>>> --- a/blockdev.c
>>>> +++ b/blockdev.c
>>>> @@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)
>>>>
>>>>        GLOBAL_STATE_CODE();
>>>>        QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
>>>> +        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
>>>>            bdrv_unref(bs);
>>>>        }
>>>>    }
>>>
>>> Thanks a lot, Kevin! This looks like the right fix for me - I gave it
>>> a try and it fixes the crash indeed!
>>
>> Good. I think something like your patch would still be good for 11.0.
>> Having undefined order in shutdown is just asking for trouble. So it
>> would be good if we could be sure that migration is out of the way when
>> migration_shutdown() returns.
>>
>> I sent the above as a proper patch to fix the immediate problem for
>> 10.2.
> 
> Thanks all!
> 
> Does that completely fix the problem?

Yes, Kevin's patch fixes the crash!

>  If so, IMHO we don't need the
> migration change anymore until later.  As replied in the other email, it
> was at least intentional a few years ago (when introducing
> migration_shutdown()) to not join() the migration thread here.

Fine for me.

  Thomas


