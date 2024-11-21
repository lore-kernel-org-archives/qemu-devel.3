Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B07E6400D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDdy-0006o1-DD; Thu, 21 Nov 2024 15:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDds-0006nh-5V
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:19:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDdq-0004rX-8F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:19:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso11484495e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220345; x=1732825145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dX6O0krhvJo8kRyCT6kCHaU/MsVx8mA3o5nw0dAKdzc=;
 b=dABivgU+yjkAz9CW6Uxok/RQ4UjX/MQU0lhqIySvqtmspwZWNMbtAgr59Trv3X6NA0
 drTiwVl6GZFfZftl5VnEwSbF6FaherpoD90VvQaZNtBhlrX8dvNOQSIUfn07/mnIAPlt
 FSm8LMbmXtuP8O/AzG7ZuNST5/5I0YEn2Pk4tlFSn9m129xcTBcm8oQk/2LKYHZomvdA
 t0tMSczxPNJ+AaL2m/z+rbrZUeEQh2VrTSFqrnTCClQkLChRw/XDSMvBmANivi3ie7Jl
 EzYRLDjESnwukVAZZVW4L5Qn+Z7wY1IlP2y20TzmSQzA9yKf0EwwSj9dGcxG5Ot1cB7T
 R+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220345; x=1732825145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dX6O0krhvJo8kRyCT6kCHaU/MsVx8mA3o5nw0dAKdzc=;
 b=O2hE9Ck8m/S5tngyVVxHESAjGkElJgD/wEFfM0chn2d03TSE7sf1NiCCK2l9Wt6xsx
 T3gM9mD7lng7+XFuVrWeFQriL4b1mgDWhleG8ZVcKmKv/cDAYtlW5UYE73CA1FyxFOWc
 Q/A4uUN4Vpb87yZucsp0blDZ8RnG9aS14K/O+1+5UkRi+xAhDu7CFHR6doYuiFlP3EvD
 3CuTcfSNWBTPeXEwO5wZBUSpPjYxLT2eDLkyo9AWzpDTutiFdl2j61ahqBdCkBeIhSqn
 NWfExug0n7quYyhsP4q1cX5+64ZdZeLQ3twTDWwp5znsN21AnKLj9N5iOrHPnf1EhSef
 hwXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhQEisYKc0PfOEvZedSfg2Gvy/ztDu+jZnZ22FaFwgbMhIgNMhBRez22kHNX1qqRtN7Tj2D8/jUEJX@nongnu.org
X-Gm-Message-State: AOJu0YxH1LkxlkulJZOv05jisk2t++jrlkn0pMsrY6nEsGh5cyAXmWRb
 89/ydyqaTAKFvjfgIgwdCIdqrYAtkrutcC+fjjZI71MEgnOOPY6JOdu328/0f7dnghxitgC/tXA
 d
X-Gm-Gg: ASbGncvQS66tkXzyHTU2SKAIpF4ZlfdmpxrgpuHY/uJr7K+MX1padchppYMeezi14e1
 LywOExyD0twJHmYI0OlyvyXxN1bPwxOqD04OL7BDy3zk2ZD0mpDLSAURWED9tOqgAOQ00hLK2wb
 fuvwL4565U8FS3/L85Ole6PJsZwz/SA14NEVrYcD20ChI4xP3vAbc1F09W68UkMg7+22YjV8Gyb
 MsGRPqiGsRmb0bMmtgMxUem2M9ILnzd0atGt+1sqs2jWKU6nmY03PM1fXFywBf6jqwd
X-Google-Smtp-Source: AGHT+IGtbMiMsQ9U38tw7/x0/jN64rA57TpdUo+tuNHLgzakoBPrxZJIyig3jCL3OZgvoDhP+qC3IA==
X-Received: by 2002:a05:600c:3507:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-433ce4264c0mr1488705e9.12.1732220344679; 
 Thu, 21 Nov 2024 12:19:04 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde8fcbbsm3406595e9.35.2024.11.21.12.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:19:04 -0800 (PST)
Message-ID: <2652d70c-04bd-40d2-9435-bf25a2fb32bd@linaro.org>
Date: Thu, 21 Nov 2024 21:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] qom: Create system containers explicitly
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-8-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 21/11/24 20:21, Peter Xu wrote:
> Always explicitly create QEMU system containers upfront.
> 
> Root containers will be created when trying to fetch the root object the
> 1st time.  They are:
> 
>    /objects
>    /chardevs
>    /backend
> 
> Machine sub-containers will be created only until machine is being
> initialized.  They are:
> 
>    /machine/unattached
>    /machine/peripheral
>    /machine/peripheral-anon
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/machine.c |  3 ---
>   qom/object.c      | 24 +++++++++++++++++++++++-
>   system/vl.c       | 16 ++++++++++++++++
>   3 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8fae..a72c001c3d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1198,9 +1198,6 @@ static void machine_initfn(Object *obj)
>       MachineState *ms = MACHINE(obj);
>       MachineClass *mc = MACHINE_GET_CLASS(obj);
>   
> -    container_get(obj, "/peripheral");
> -    container_get(obj, "/peripheral-anon");
> -
>       ms->dump_guest_core = true;
>       ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
>       ms->enable_graphics = true;
> diff --git a/qom/object.c b/qom/object.c
> index 214d6eb4c1..2fb0b8418e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1734,12 +1734,34 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>       return prop->type;
>   }
>   
> +static const char *const root_containers[] = {
> +    "chardevs",
> +    "objects",
> +    "backend"
> +};
> +
> +static Object *object_root_initialize(void)
> +{

(root_containers[] can be declared here)

> +    Object *root = object_new(TYPE_CONTAINER);
> +    int i;
> +
> +    /*
> +     * Create all QEMU system containers.  "machine" and its sub-containers
> +     * are only created when machine initializes (qemu_create_machine()).

I'm not sure this comment is helpful. Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +     */
> +    for (i = 0; i < ARRAY_SIZE(root_containers); i++) {
> +        object_property_add_new_container(root, root_containers[i]);
> +    }
> +
> +    return root;
> +}

> +
>   Object *object_get_root(void)
>   {
>       static Object *root;
>   
>       if (!root) {
> -        root = object_new(TYPE_CONTAINER);
> +        root = object_root_initialize();
>       }
>   
>       return root;
> diff --git a/system/vl.c b/system/vl.c
> index 3bb8f2db9a..15e35162c6 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2112,6 +2112,21 @@ static void parse_memory_options(void)
>       loc_pop(&loc);
>   }
>   
> +static const char *const machine_containers[] = {
> +    "unattached",
> +    "peripheral",
> +    "peripheral-anon"
> +};
> +
> +static void qemu_create_machine_containers(Object *machine)
> +{

(ditto machine_containers[])

> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
> +        object_property_add_new_container(machine, machine_containers[i]);
> +    }
> +}
> +
>   static void qemu_create_machine(QDict *qdict)
>   {
>       MachineClass *machine_class = select_machine(qdict, &error_fatal);
> @@ -2120,6 +2135,7 @@ static void qemu_create_machine(QDict *qdict)
>       current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>       object_property_add_child(object_get_root(), "machine",
>                                 OBJECT(current_machine));
> +    qemu_create_machine_containers(OBJECT(current_machine));
>       object_property_add_child(container_get(OBJECT(current_machine),
>                                               "/unattached"),
>                                 "sysbus", OBJECT(sysbus_get_default()));


