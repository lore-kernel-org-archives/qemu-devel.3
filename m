Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22954D7879D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAzW-0005Vo-DU; Thu, 21 Nov 2024 12:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAzS-0005VR-RF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:29:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAzO-00060L-SA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:29:14 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3825c05cc90so580587f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732210149; x=1732814949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTZhcFrMb+DXNjxZsvVDt/FOKGCCUzP+3euHVOgpBq4=;
 b=VvlkX/HoBbanIX6gMa4BET1NEkZmqu50u+xJMeKQoasSb3kQcGwyz1FOb6DFV24KgZ
 iCbhq8V1ulOhlMdfWYf16bUOsufm9THEB76dYzBWxaC/03uYUnYXLcNmXpXlIIroKFRo
 8dkf6I+T7kt9+a47zkSgBlJe4SowD/bRoSliboJQQZOOETUEB2MRYQqGJlX0QmUkUNVq
 SMCjtXqwqWby2uhfukf4t5QgL2zlas825Mj7+DsVetIugKYDUlIV176AQY3H/CzyEB1U
 +Cr3ecUBhaurmma0U9ltqMwPCRAPdax9kZ9afamEPgjXaD+JmXDfnfMuXHbyuSXR8MKz
 6r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732210149; x=1732814949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTZhcFrMb+DXNjxZsvVDt/FOKGCCUzP+3euHVOgpBq4=;
 b=D95dJyvGAtsx9BeZtDtAfuFE8QfS2IRCxiIsPlsb3ipu6txe/CDznqNwUfz0UQeg9I
 m/6IcvFFGeJDqK8bRtMhGKtKWxOboW+2nOCHS0zYTbvZabZOZ9tWGz8Ti2y/FQhWLICW
 xEkAuqi4CF467xoOOu1Yv6+/5lVGH9R4KpqhJAQSEf31+iKJCFDQgQNka9eYfx6lRFes
 qrolPc8trdbdwonVq0oE0En5inHPynkLoCTBvIx0g54X4jLKQn+U64ZMK+wfHD0Gwf7c
 GUn80Xhk/2jNYn6Mwoi3eljDt/Tcptkvivqv8dhVvRw8CwzP9QsLFHcuXLV7mmbU+AoD
 G1Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwBaEm9/hxv+4oD9dfj8la9ZS7f1XRapMEQCA3wQVPOj6M5C1NhVGTQYVtym8/XpmwGt2yvFIV0yXX@nongnu.org
X-Gm-Message-State: AOJu0Yz816p+97zgQgBA5kIdRV4Y+YuJopMk9qfYGTw03Ti7OHRt+PpG
 EMuynHv8t+DA+DXbYxi4lvvGvMyQfwPTrCGkQxfWQyrWNhL4alSuOyHmSuJWyjA=
X-Gm-Gg: ASbGnctLd3CJip6UHROfUuKQij6K7Jjqxm5n5PBJQvlqyz5prw/dL6nIgFcxdPky6PP
 My+TVQ6gzYz9fiCYETlGl9mhn9zrb2vGW09JvLDXaHLWseoT2dDJRroX483GBb7FvJpLnobz8/P
 vaCuWz2kxJ5BNA2BOXEQDx3sYAijJnf0nqo8fTdO6L8U5YT0t/t2GSPCdvGS9BSNh04ZALUd6en
 fHhcvHOCWs6A8eEG/XbW4EGNg7eSANhZg9hIQ6twfEaEi1LPtkks3Z+0whLAxB8
X-Google-Smtp-Source: AGHT+IEOvHxBqFC7f0dXPGpcQLS5XK5GBpkClHO/sEecfUf4FzhOjhYeBTDSvJsFsZPZxgbuI5aplg==
X-Received: by 2002:a05:6000:2c6:b0:382:4126:f182 with SMTP id
 ffacd0b85a97d-38254afa64emr6920131f8f.25.1732210148682; 
 Thu, 21 Nov 2024 09:29:08 -0800 (PST)
Received: from [192.168.69.197] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d17e3sm65112955e9.5.2024.11.21.09.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:29:07 -0800 (PST)
Message-ID: <c68b260a-b4ee-48ec-9f5c-3c72a58f424b@linaro.org>
Date: Thu, 21 Nov 2024 18:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com> <Zz8LwhXsa6ail5qo@redhat.com>
 <64d02784-adde-459a-a019-10cdca93734f@linaro.org> <Zz9rDA_xlgweZzeP@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz9rDA_xlgweZzeP@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/11/24 18:17, Peter Xu wrote:
> On Thu, Nov 21, 2024 at 02:01:45PM +0100, Philippe Mathieu-Daudé wrote:
>> On 21/11/24 11:30, Daniel P. Berrangé wrote:
>>> On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
>>>> Always explicitly create QEMU system containers upfront.
>>>>
>>>> Root containers will be created when trying to fetch the root object the
>>>> 1st time.  Machine sub-containers will be created only until machine is
>>>> being initialized.
>>>>
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    hw/core/machine.c | 19 ++++++++++++++++---
>>>>    qom/object.c      | 16 +++++++++++++++-
>>>>    2 files changed, 31 insertions(+), 4 deletions(-)
>>>
>>>
>>>> diff --git a/qom/object.c b/qom/object.c
>>>> index 214d6eb4c1..810e6f2bd9 100644
>>>> --- a/qom/object.c
>>>> +++ b/qom/object.c
>>>> @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>>>>        return prop->type;
>>>>    }
>>>> +static Object *object_root_initialize(void)
>>>> +{
>>>> +    Object *root = object_new(TYPE_CONTAINER);
>>>> +
>>>> +    /*
>>>> +     * Create all QEMU system containers.  "machine" and its sub-containers
>>>> +     * are only created when machine initializes (qemu_create_machine()).
>>>> +     */
>>>> +    container_create(root, "chardevs");
>>>> +    container_create(root, "objects");
>>>
>>> This is where I would expect 'backend' to have been created
>>> rather than ui/console.c, though you could potentially make
>>> a case to create it from the machine function, snice console
>>> stuff can't be used outside of the machine context, while
>>> chardevs/objects can be used in qemu-img/qemu-nbd, etc
> 
> Would it hurt if we do it altogether here even if it won't be used in
> qemu-img/qemu-nbd?
> 
> IMHO we should either make it simple (assuming empty containers won't hurt
> there..), or we should just leave "backend" to ui/ code, so we don't assume
> which binary is using the ui code: whoever uses it will create the container.
> 
>>
>> What about creating "backend" container in qemu_create_machine()?
> 
> I remember I started with that but it didn't work.  IIRC that's because
> machine_initfn() (or somewhere around the init code) requires the
> containers to present, hence it's too late even if we create the containers
> right after this line:
> 
>      current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));

So qemu_create_machine_containers() really belongs to 
qemu_create_machine() =)

