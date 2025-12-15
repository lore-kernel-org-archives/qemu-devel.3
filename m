Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDBDD5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8qa-0003QP-7l; Mon, 15 Dec 2025 08:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vV8qT-0003Pj-Ka
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vV8qP-0002SL-RL
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765806148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DpFBkStaEW0sH+B4lilHvrxtFQemY/2xIkWmmILGKdc=;
 b=VZE+wTD1KtBeGhjqtkMx8U7yD4IeMpjTK2yBzbforQN0gDZ741OdM2OyoCyA+BNi1o1RE4
 B9lYEgYuk8QUuWK6JJt8W4YpKf+PilZGLYC29XTEFGHFDS0gjSD/ftfe6Km1hN9hg3aShz
 gr6do+c4rz0LiHSb7vd5kQ+WydWq9+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-Mj4WC3RmNlWOZBWfkA0wng-1; Mon, 15 Dec 2025 08:42:27 -0500
X-MC-Unique: Mj4WC3RmNlWOZBWfkA0wng-1
X-Mimecast-MFC-AGG-ID: Mj4WC3RmNlWOZBWfkA0wng_1765806146
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779981523fso33254895e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765806146; x=1766410946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DpFBkStaEW0sH+B4lilHvrxtFQemY/2xIkWmmILGKdc=;
 b=XnOYR55fypCUgboCGPa4dKpfpB2ZtIYuY4lKgPp06D93L34OPRppCfj87O1MaKgcZR
 5UsXHZV8lhDwdfZHlGAQuwztith0y+Jv+4oeP+01W87j4PjvSAl2t1aWFRrfM42ql/AL
 JGd77XJYFi7bOpT/2/8oY4AlK3jtXNFLYz0EGgjPYTvqrb1ZbpXc6Fw5bu57BtHEOFWC
 xv6jL/9Ac/9HtbrKyUV70InLAeq08EdHIOT91OP9IrGpCO0aueA3ZFu2VgYyf+RDaebq
 +uWZ/S88WATKiIv7N6iepHx4Vrw0y/bZX5Vd3xzskKr2v0vE3In5USx8gVD+Eu9dwwTs
 yjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765806146; x=1766410946;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpFBkStaEW0sH+B4lilHvrxtFQemY/2xIkWmmILGKdc=;
 b=KsV+7NWMz2s5v3ZNsrUKC0MGEIvjaUOwrzw5rV2TEpAwcSiiJgA1f1IW7HUaW4iI3v
 rRzDk78ys2WlJk6iz9m2KLtBaXWvf2GydMEEmtzcp1i1sPTnbuxoxqpZwHtu/wYDQK/h
 wfSKJZJJrX+uxECWJ29AQc17IiSTaKTnVDXGg7prR95UhnI+4qfS9E9aKwhRiQBZlPCh
 74ReNr/pUQ9yA87MLg22yrTNEYpV7aYONVdIiin1FIKtY0AbfamTBdeVk7DQRNBqidkE
 Lu/QsnJWsnUsq6a2ueMSvYJnBnAWNVxtAxzEcpHne4jUcvuw8Pe3coiZmB9t1Dl3mr4N
 Fq4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6/zxpLA/fTDf3o/utMy/EWMiFE9Fr6RT9qO1JuBLXzRTFRjyq6MJbdFG7GhcSGfgjq5mHkWmnl9X7@nongnu.org
X-Gm-Message-State: AOJu0Yz/fAG8SKF9zVWFm/xj7d8NcTNML1bogyan64RCMAiPTmmC3klM
 qsYKGAEU0M6ggbvcIDVhNd6n4eq9CcI41joyMNLSyQT78YUsvA31SuSgRbNQ9b8LrPe4Z/awANW
 QYfFsq+t4YWIz4AleUGndxvO3D51VHPxoAhG/Kvqh3TA4mmtv8NE4ymQv
X-Gm-Gg: AY/fxX63DkO2Va4o69ysBNDPooms86mpKO8O1f/V77j50Ug2IZuW9HBcW4I531+/Xld
 JLMjOCEU2SEAvWe707QdvKrK9O48xFuKfYpYQfyExJN87iFaeVTBd4yLQ7O4JYdzGl59qqYVHLU
 yxmtqVF/2p/TjaUQoj2E5I+IrMTIO82OADcn/IWsWGFdH1b5yyLpJa5fg9ILaa6vUsK9hc9WQDU
 bWizh6vUeweXFKVHaHSyJaAGUI6xcCQtmsuFZtj7sahlimdgadR7vzt3TDHZxaJuvwJ/kP9UffB
 12nRpO2t2q7qalSyJR1xFBmo6TKU8K21o9LEHKbG5mq1zjp/G+1EDGqEuRsSf5FXAgiDzucDQY4
 rAVUExdcB9q7Le7v+o/LonWTWrbq+X6LuI3kOggPqcmNB
X-Received: by 2002:a05:600c:8115:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47a8f904257mr113330145e9.17.1765806146313; 
 Mon, 15 Dec 2025 05:42:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrKcMJUiDNGSs5852gACx4k1guy3gq4jTp6cApV/2hk8xRsB3vJSsHxxxgf53QCNZj4sBxTg==
X-Received: by 2002:a05:600c:8115:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47a8f904257mr113329775e9.17.1765806145905; 
 Mon, 15 Dec 2025 05:42:25 -0800 (PST)
Received: from [192.168.0.5] (ip-109-41-115-194.web.vodafone.de.
 [109.41.115.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4b1347sm206546745e9.8.2025.12.15.05.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 05:42:25 -0800 (PST)
Message-ID: <892d9b4f-a15f-4655-b6e1-ffabba9d48ae@redhat.com>
Date: Mon, 15 Dec 2025 14:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
To: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com> <87jyyrv1br.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87jyyrv1br.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/12/2025 22.26, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 08/12/2025 16.26, Fabiano Rosas wrote:
>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>
>>>> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> When shutting down a guest that is currently in progress of being
>>>>> migrated, there is a chance that QEMU might crash during bdrv_delete().
>>>>> The backtrace looks like this:
>>>>>
>>>>>    Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>>>>>
>>>>>    [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>>>>>    0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>    5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>>>>>    (gdb) bt
>>>>>    #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>>>>    #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>>>>>    Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>>>>>
>>>
>>> How does the migration thread reaches here? Is this from
>>> migration_block_inactivate()?
>>
>> Unfortunately, gdb was not very helpful here (claiming that it cannot access
>> the memory and stack anymore), so I had to do some printf debugging. This is
>> what seems to happen:
>>
>> Main thread: qemu_cleanup() calls  migration_shutdown() -->
>> migration_cancel() which signals the migration thread to cancel the migration.
>>
>> Migration thread: migration_thread() got kicked out the loop and calls
>> migration_iteration_finish(), which tries to get the BQL via bql_lock() but
>> that is currently held by another thread, so the migration thread is blocked
>> here.
>>
>> Main thread: qemu_cleanup() advances to bdrv_close_all() that uses
>> blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name
>> 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
>>
> 
> Has qmp_blockdev_del() ever been called to remove the BDS from the
> monitor_bdrv_states list? Otherwise your debugging seems to indicate
> blockdev_close_all_bdrv_states() is dropping the last reference to bs,
> but it's still accessible from bdrv_next() via
> bdrv_next_monitor_owned().

As far as I can see, qmp_blockdev_del() is never called, so yes, looks like 
blockdev_close_all_bdrv_states() drops the last reference here while its 
still available from bdrv_next() ...

The weird thing is also that I can only reproduce the issue on s390x so far, 
not on x86 ... I wonder whether we're missing something there...

  Thomas


