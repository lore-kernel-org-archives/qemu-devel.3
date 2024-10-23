Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C2CFA44C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dnV-0006GE-6G; Wed, 23 Oct 2024 12:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dml-00065m-6v
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dmi-0002VX-Sy
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729699231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TJCmLK5c12grqiJU4zgqydS0dDdKnDkrJK7DyJdEWXk=;
 b=ixuB1lZdW9LWEDa0LCInRtkArjJCYHIqawIqAACVlegK2/dsm0//7DVmLTZ3TKLGOo05Pb
 UW9LGt0ZtzWAnXeBvrdv536j9fYMl7lSTO0gvqcP43YDZKe1m3ZhSg64xA0jXxpAK4/NQZ
 vDO0H4N2TebVJaHnQqE+b9WXnz6M0MQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-aURBvQhXOKObgz9abx6ekg-1; Wed, 23 Oct 2024 12:00:30 -0400
X-MC-Unique: aURBvQhXOKObgz9abx6ekg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso3660390f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729699229; x=1730304029;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJCmLK5c12grqiJU4zgqydS0dDdKnDkrJK7DyJdEWXk=;
 b=jYALhCE5nko6PhDTNtpBXP8QuG+7Z01WgCj4zQnfIfeSHa/VLwgU99PdorlLpevY8S
 O7LhDTOLmfbObLvsFaFqk7bihm8M7cy0dkspzHQAYKlmoTDNyhVcKJ5s1S9sxbxg6OPL
 kr4fagO3bcx+TvIKwFS4+c2O2KsgwUiO8o19n7n3nQ5kocSM6fx2dtcMNdSzihY4yPLl
 ONkPWaENqJFZ1XLjeuVsIylNY8GlMXg+3x3b9XYez45Q+OlRP+bMXWzstCi6gJsHF8E1
 gtsUoKUxCYpvdBVieP4nkebAPkB9pAXozEfRO4YAeg+FHcee7NoFIcKoq0wyT54Vtzyw
 Zj+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCv0Ad6Q9nTXzfsdUXxXHUdanP5Eb65ebVj8KJ6YEQ65ish8NSJbRvjOhFyk/hQyP/t0pEvV0RxLfw@nongnu.org
X-Gm-Message-State: AOJu0Yzl0916YntmnN0zXjH2BUtU6IxCDJAWbEUKCdl6FDxMbF0gxnx/
 VvRqnzUjOBj3vwUOPql/o7GsfESOcxSKFb3QFBp/HSrwdBLA83LkZeJQagMViz+0tl2babfmmby
 dQmHF+RVlFPYeeYAkTzEgIh7m6Nl6kgyobYheu+UMOarjXWIaxImu
X-Received: by 2002:a05:6000:502:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37efcf93218mr2001835f8f.56.1729699228647; 
 Wed, 23 Oct 2024 09:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZMEqQmj1QqEKtlrdOxgU288EXHQoQDaAjrpHwM9VFYVtN6lTXs1uycwofToJf7+XlQCVAXA==
X-Received: by 2002:a05:6000:502:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37efcf93218mr2001806f8f.56.1729699228145; 
 Wed, 23 Oct 2024 09:00:28 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b93e9asm9216322f8f.68.2024.10.23.09.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:00:27 -0700 (PDT)
Message-ID: <c4ce511b-bdc2-466f-85e6-2495c0bd2f08@redhat.com>
Date: Wed, 23 Oct 2024 18:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
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

On 10/17/24 17:14, Steve Sistare wrote:
> Make all global and compat properties available before the first objects
> are created.  Set accelerator compatibility properties in
> configure_accelerators, when the accelerator is chosen, and call
> configure_accelerators earlier.  Set machine options earlier.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   accel/accel-system.c |  2 --
>   system/vl.c          | 34 ++++++++++++++++++----------------
>   2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..c8aeae4 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>           ms->accelerator = NULL;
>           *(acc->allowed) = false;
>           object_unref(OBJECT(accel));
> -    } else {
> -        object_set_accelerator_compat_props(acc->compat_props);
>       }
>       return ret;
>   }
> diff --git a/system/vl.c b/system/vl.c
> index b94a6b9..bca2292 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>           goto bad;
>       }
>   
> +    object_set_accelerator_compat_props(ac->compat_props);
>       acs->accel = accel;
>       return 1;
>   
> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>       parse_memory_options();
>   
>       qemu_create_machine(machine_opts_dict);
> -
> -    suspend_mux_open();
> -
> -    qemu_disable_default_devices();
> -    qemu_setup_display();
> -    qemu_create_default_devices();
> -    qemu_create_early_backends();
> -
>       qemu_apply_legacy_machine_options(machine_opts_dict);
>       qemu_apply_machine_options(machine_opts_dict);

This makes it impossible to refer to a backend in a machine option from 
the command line.  While this is not done for now, it is not a 
limitation I'd like to introduce.

Could qemu_apply_machine_options() be moved after 
configure_accelerators(), and phase_advance(PHASE_MACHINE_CREATED) with it?

Paolo


>       qobject_unref(machine_opts_dict);
> -    phase_advance(PHASE_MACHINE_CREATED);
>   
> -    /*
> -     * Note: uses machine properties such as kernel-irqchip, must run
> -     * after qemu_apply_machine_options.
> -     */
>       accel = configure_accelerators(argv[0]);
> -    create_accelerator(accel);
> -    phase_advance(PHASE_ACCEL_CREATED);
>   
>       /*
> -     * Beware, QOM objects created before this point miss global and
> +     * QOM objects created after this point see all global and
>        * compat properties.
>        *
>        * Global properties get set up by qdev_prop_register_global(),
> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>        * called from do_configure_accelerator().
>        */
>   
> +    suspend_mux_open();
> +
> +    qemu_disable_default_devices();
> +    qemu_setup_display();
> +    qemu_create_default_devices();
> +    qemu_create_early_backends();
> +
> +    phase_advance(PHASE_MACHINE_CREATED);
> +
> +    /*
> +     * Note: uses machine properties such as kernel-irqchip, must run
> +     * after qemu_apply_machine_options.
> +     */
> +    create_accelerator(accel);
> +    phase_advance(PHASE_ACCEL_CREATED);
> +
>       machine_class = MACHINE_GET_CLASS(current_machine);
>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>           warn_report("Machine type '%s' is deprecated: %s",


