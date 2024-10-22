Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964FFD1CDB4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AIR-000841-4f; Tue, 22 Oct 2024 04:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3AIN-00083O-6Z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3AIK-0000lP-9o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729585860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XJfwdl2AkT0xYuNVXfqCOD5fJF9PQv5py/IElw6HQ3c=;
 b=MPyB6ASqUyKr43kO10pb0oCylTKiR2eEkH8BUHX6r7TmFYF5tQtLxxPVq7wwMHQMdZrEIl
 +WoldFeDMstCd3lBcYHv+EZoELI5/D9BZAUaUtHwGyA8MfZDuomYDinqlBY36XGHg22VHH
 VJ9oWA72WTqOzl/5KRPcTZ2cAJPb+kg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-xfSVO5f4Mb6I_4Fq7X_VSQ-1; Tue, 22 Oct 2024 04:30:57 -0400
X-MC-Unique: xfSVO5f4Mb6I_4Fq7X_VSQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d52ccc50eso2696020f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729585856; x=1730190656;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XJfwdl2AkT0xYuNVXfqCOD5fJF9PQv5py/IElw6HQ3c=;
 b=bmupPhI1O5A8J9bjn+cywht+XZd60H53gbea5AMul3Jz0rvlPS1ac4hCjdV9vaUXKG
 Oz2Q+q91HsL0arJUgHJmCFMCpDI37i+Dq9ykqG9dXHPb23q0czxLlO/QTdrxJuZ3HXad
 j2hq24n3cb5CfAhh05HAvhilYchxMg+OJwPJsupgePG30zgBVwdtIm1iv2AWPxfBTC3S
 Hqpa5ra7iHK4qcL33HhJwmqQNfjuSzv4KqhuHC7wK4pV/5MLb4oRfxc2lFchyjeHWqRm
 snP5h8s54VaRskD9/RLJFiu4vvAbNgKe6saScW/l+FXpCl9XJKWNz4xb3wYbq6oj9Dlr
 J3Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxwEWHG7ov7a4WTYP8ikyfx9RR6eTEKNkGn3/XonMzm5a/z4EZv0ntbzHukK9+nXvht6whqsK25lHr@nongnu.org
X-Gm-Message-State: AOJu0YxNXiQ87CePhEIP01eIy8UTyOcSLInElUnNm4r04w16TZev4uOG
 DQ2dAQHKChZ1TGNS0IgrgvKGc/zcKDDa6LkcUY30270e98ts7xqaFLemZfh5c1osIuux91A0vhw
 60CmYJX4adjNtYfBb+BQlqDyncEFWl3Sj1fIpPX1NOZp6ERWAJxiq
X-Received: by 2002:a5d:6751:0:b0:37d:480f:9a6c with SMTP id
 ffacd0b85a97d-37eb4863233mr11235235f8f.25.1729585856107; 
 Tue, 22 Oct 2024 01:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5fQIcEShUuEBUpj+0wHKlGc4KsvVqoVzfXcCLVpFrUWEUJPmEZazrpfFmUaMHBe3djUKgoA==
X-Received: by 2002:a5d:6751:0:b0:37d:480f:9a6c with SMTP id
 ffacd0b85a97d-37eb4863233mr11235207f8f.25.1729585855671; 
 Tue, 22 Oct 2024 01:30:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072?
 (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de.
 [2003:cb:c705:f700:352b:d857:b95d:9072])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a3650esm6139882f8f.4.2024.10.22.01.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:30:54 -0700 (PDT)
Message-ID: <ce3c0f72-0442-4519-9c0e-bbd67d25730a@redhat.com>
Date: Tue, 22 Oct 2024 10:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de> <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
 <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
 <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18.10.24 21:15, Steven Sistare wrote:
> On 10/18/2024 11:40 AM, Steven Sistare wrote:
>> On 10/18/2024 11:32 AM, Steven Sistare wrote:
>>> On 10/18/2024 11:08 AM, Fabiano Rosas wrote:
>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>
>>>>> Make all global and compat properties available before the first objects
>>>>> are created.  Set accelerator compatibility properties in
>>>>> configure_accelerators, when the accelerator is chosen, and call
>>>>> configure_accelerators earlier.  Set machine options earlier.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>    accel/accel-system.c |  2 --
>>>>>    system/vl.c          | 34 ++++++++++++++++++----------------
>>>>>    2 files changed, 18 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>>>>> index f6c947d..c8aeae4 100644
>>>>> --- a/accel/accel-system.c
>>>>> +++ b/accel/accel-system.c
>>>>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>>>>            ms->accelerator = NULL;
>>>>>            *(acc->allowed) = false;
>>>>>            object_unref(OBJECT(accel));
>>>>> -    } else {
>>>>> -        object_set_accelerator_compat_props(acc->compat_props);
>>>>>        }
>>>>>        return ret;
>>>>>    }
>>>>> diff --git a/system/vl.c b/system/vl.c
>>>>> index b94a6b9..bca2292 100644
>>>>> --- a/system/vl.c
>>>>> +++ b/system/vl.c
>>>>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>>>>            goto bad;
>>>>>        }
>>>>> +    object_set_accelerator_compat_props(ac->compat_props);
>>>>>        acs->accel = accel;
>>>>>        return 1;
>>>>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>>>>        parse_memory_options();
>>>>>        qemu_create_machine(machine_opts_dict);
>>>>> -
>>>>> -    suspend_mux_open();
>>>>> -
>>>>> -    qemu_disable_default_devices();
>>>>> -    qemu_setup_display();
>>>>> -    qemu_create_default_devices();
>>>>> -    qemu_create_early_backends();
>>>>> -
>>>>>        qemu_apply_legacy_machine_options(machine_opts_dict);
>>>>>        qemu_apply_machine_options(machine_opts_dict);
>>>>>        qobject_unref(machine_opts_dict);
>>>>> -    phase_advance(PHASE_MACHINE_CREATED);
>>>>> -    /*
>>>>> -     * Note: uses machine properties such as kernel-irqchip, must run
>>>>> -     * after qemu_apply_machine_options.
>>>>> -     */
>>>>>        accel = configure_accelerators(argv[0]);
>>>>> -    create_accelerator(accel);
>>>>> -    phase_advance(PHASE_ACCEL_CREATED);
>>>>>        /*
>>>>> -     * Beware, QOM objects created before this point miss global and
>>>>> +     * QOM objects created after this point see all global and
>>>>>         * compat properties.
>>>>>         *
>>>>>         * Global properties get set up by qdev_prop_register_global(),
>>>>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>>>>         * called from do_configure_accelerator().
>>>>>         */
>>>>> +    suspend_mux_open();
>>>>> +
>>>>> +    qemu_disable_default_devices();
>>>>> +    qemu_setup_display();
>>>>> +    qemu_create_default_devices();
>>>>> +    qemu_create_early_backends();
>>>>> +
>>>>> +    phase_advance(PHASE_MACHINE_CREATED);
>>>>> +
>>>>> +    /*
>>>>> +     * Note: uses machine properties such as kernel-irqchip, must run
>>>>> +     * after qemu_apply_machine_options.
>>>>> +     */
>>>>> +    create_accelerator(accel);
>>>>> +    phase_advance(PHASE_ACCEL_CREATED);
>>>>> +
>>>>>        machine_class = MACHINE_GET_CLASS(current_machine);
>>>>>        if (!qtest_enabled() && machine_class->deprecation_reason) {
>>>>>            warn_report("Machine type '%s' is deprecated: %s",
>>>>
>>>> Hi Steve,
>>>>
>>>> after this commit:
>>>>
>>>> $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
>>>> # random seed: R02Saf9b44f2d88dd417052905692ee79981
>>>> 1..5
>>>> # Start of aarch64 tests
>>>> # Start of net tests
>>>> # Start of can tests
>>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
>>>> qemu-system-aarch64: Device 'canbus' not found
>>>>
>>>> I tried briefly to figure out what the issue is, but I don't really
>>>> understand the dependencies involved. Hope you can tell us.
>>>
>>> Thanks! I forgot to define the preinit method for the qtest accelerator in patch 1.
>>> I'll verify that fixes the problem and send you a one-off patch if you want to continue
>>> testing.
>>
>> Actually that is not a problem.  qtest qtest_init_accel does nothing, so preinit will do
>> nothing, so it is OK to not define preinit.
>>
>> Still looking.
> 
> I understand this now.  The old code worked in this order:
> 
>     qemu_create_early_backends()
>       ... creates "-object can-bus,id=canbus"
>     qemu_create_machine()
>     qemu_apply_machine_options()
>       applies link property "canbus0" with value canbus, finds canbus object

Now I am confused.

I think the current code does:

qemu_create_machine(machine_opts_dict);
qemu_create_early_backends();
qemu_apply_machine_options(machine_opts_dict);

Isn't the relevant part that we may only apply the machine options after 
creating the early backends?

-- 
Cheers,

David / dhildenb


