Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A393AEA4FBB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuVuV-0008JZ-0a; Mon, 23 Feb 2026 08:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuVuR-0008JA-2u
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:23:35 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuVuP-0001c2-Dd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:23:34 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65a3fdeb7d9so6090389a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771853011; x=1772457811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xAue9mhPwABCuGBhK6+ntcLVK7yBDT6Qs4uIDTyPVA=;
 b=kU7we5DGmxshrHyVm79tNa3FktaKvzDAvY0HY1cz4GF6DtPo85SBfqvpQg8Vn0YTLa
 Sq0IRnUIGbYeSPysiQUAvKjGwD9vQ1IV2JndsgLfA3wt0Gd4Kcl4AecUpw8+dY384B3g
 hwAsE4a7QWMxVlPvKQgFNqQlIhXSIasNR5MB1M2OJaLfNqbjZ3u+yjMbV1bITEydRvdc
 qyN0KesaUniyCJlBnjZWG3Vt9fmA9A9JgCt6o8A1sGtcrTQdcpreYgVQr1fMesgZ0Bss
 2hoKdAS8nCTKBN+v+JgsuPRICbdDCFgyJRYxrPT32r12e+2bfgqX0VA6eDGEMdwwiPyx
 qQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771853011; x=1772457811;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xAue9mhPwABCuGBhK6+ntcLVK7yBDT6Qs4uIDTyPVA=;
 b=OrV/ObFEIBknzS9oGrKQx/MMZQj3lV8kGfyXVIflNC79F8S04VSKN0S8w5WOZnpew5
 +bv5JBOqFZ7KuazJTEQep5XsQsW4h2GaVkZawsFPZP45n29uOAChyGB0Wfy8o4xlwoCG
 mnzCYDPJ33v6junY3phDB+LZFhh51j1cGz1xqJpeHn+ug+phxFaLLknFgtHI07MXz/I/
 gfypbzm4uzOk0eAwA+jjGs+nuTxauTiTXuHAyablEds07fcRYTELmSAU5nonzAFnSW81
 u/5gb6bdEOgEbwcTHfwxyuxDfKl8fIOqzPQFfOUojX4dKaB0BGLec4OL+TevPvbzOLZ3
 wYyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFLbSIdYWY19DR7x3ts4ook9YZfniavNYwT8/E3zfK1nLOStNbBN6n41X6ApTDvUJZaxMJH+CFk/IH@nongnu.org
X-Gm-Message-State: AOJu0Yxo3z/J7xBAO+sUN8UhGyd/JzpDnmH3BzRU3a1qJf5VNJk67YpC
 2SG49pncXkK+4AYViL6sHQCjcW5yri7ciXxpQUMIVEZQbAN6u12znXWx/2ctFuav8d4=
X-Gm-Gg: AZuq6aJAzQ7T5jVPxMm1lMDiz7Zwg/8l3S3pddRlMLGeFfWLGkLENp2EkIOHXzwsKok
 IPMwOyf5Ww1eCvUvqP0RNeaDS0wbb9dswNXb5jpEEziC1/X9q7EyGLuNkrXSQxaGSDvuw44bryF
 3SMa7ob6m9qbBLlVV/X3XXpaABRCHRiCzmE44bxEgDd5a/OdGMnBNGgqo+nxiXTITXbq8vGHuZC
 dhkWYm3wCto1WERpLjWClXJ4aeZAE2K8lIsDBYA9bLBgcUl66eNjJHqted1nPEueoVqaMMC3hHX
 SthGhCilOSJBn/c6VLrhceKxPCRhNvitrSZ3orVJENrsns8jYYdygmsXji4uyXS1V22haLrly0c
 UJx4pu6Rgm0sNOpW1/VnhA1elR4uJDIWpVDIZlO7Q95vs5AoZMoN1AIx8gtYXG+ikyuuAOkm0hS
 nPdCEJOWbQgHIAKZt2SUGhv8hXcQMrFX5h4A==
X-Received: by 2002:a17:907:1c22:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b9081bacc96mr509281566b.50.1771853010784; 
 Mon, 23 Feb 2026 05:23:30 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5cf1esm317330666b.7.2026.02.23.05.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 05:23:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFAFA5F88E;
 Mon, 23 Feb 2026 13:23:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  peter.maydell@linaro.org,  artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com,  takahiro.nakata.wr@renesas.com,  "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  Ruslan_Ruslichenko@epam.com,
 balaton@eik.bme.hu,  philmd@linaro.org,  wangyanan55@huawei.com,
 zhao1.liu@intel.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 19/33] hw/core/machine: add '-hw-dtb' option for machine
In-Reply-To: <dd8a92cc-51d6-4404-bd09-75b1798f925a@redhat.com> (Thomas Huth's
 message of "Mon, 23 Feb 2026 10:04:40 +0100")
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
 <dd8a92cc-51d6-4404-bd09-75b1798f925a@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 23 Feb 2026 13:23:28 +0000
Message-ID: <87y0kj4mr3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Thomas Huth <thuth@redhat.com> writes:

>  Hi!
>
> On 19/02/2026 15.48, Ruslan Ruslichenko wrote:
>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>> Add new '-hw-dtb' command-line option and corresponding
>> MachineState property.
>> The 'hw-dtb' option allows to specify a Device tree
>> binary with hardware description which Qemu should
>> emulate.
>> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>> ---
>>   hw/core/machine.c        | 19 +++++++++++++++++++
>>   include/hw/core/boards.h |  1 +
>>   qemu-options.hx          |  9 +++++++++
>>   system/vl.c              |  3 +++
>>   4 files changed, 32 insertions(+)
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index d4ef620c17..affd24cd49 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -363,6 +363,20 @@ static void machine_set_dtb(Object *obj, const char=
 *value, Error **errp)
>>       ms->dtb =3D g_strdup(value);
>>   }
>>   +static char *machine_get_hw_dtb(Object *obj, Error **errp)
>> +{
>> +    MachineState *ms =3D MACHINE(obj);
>> +
>> +    return g_strdup(ms->hw_dtb);
>> +}
>> +
>> +static void machine_set_hw_dtb(Object *obj, const char *value, Error **=
errp)
>> +{
>> +    MachineState *ms =3D MACHINE(obj);
>> +
>> +    ms->hw_dtb =3D g_strdup(value);
>> +}
>> +
>>   static char *machine_get_dumpdtb(Object *obj, Error **errp)
>>   {
>>       MachineState *ms =3D MACHINE(obj);
>> @@ -1145,6 +1159,11 @@ static void machine_class_init(ObjectClass *oc, c=
onst void *data)
>>       object_class_property_set_description(oc, "dtb",
>>           "Linux kernel device tree file");
>>   +    object_class_property_add_str(oc, "hw-dtb",
>> +                            machine_get_hw_dtb, machine_set_hw_dtb);
>> +    object_class_property_set_description(oc, "hw-dtb",
>> +                "A device tree binary used to describe the hardware to =
QEMU");
>
> Do the hardware dtbs differ from the ones that are passed to the Linux
> kernel? If not, I think you likely could use the existing "dtb"
> property for your new feature?

They have to - the normal DTB cannot define the whole system because its
only concerned with reporting what the kernel can see to the kernel and
not defining the whole system including what the firmware sees.

>
> ...
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 33fcfe7ce6..1568f3ce4c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4518,6 +4518,15 @@ SRST(initrd)
>>     ERST
>>   +DEF("hw-dtb", HAS_ARG, QEMU_OPTION_hw_dtb, \
>> +    "-hw-dtb file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
>> +SRST
>> +``-hw-dtb file``
>> +    Use <file> as a device tree binary (dtb) image used to create the
>> +    emulated machine. This dtb will not be passed to the kernel, use -d=
tb
>> +    for that.
>> +ERST
>
> Please don't add any new top level options if it is not really
> necessary. We already got too much duplicated logic in QEMU, so we try
> to avoid this nowadays. In your case here, it should be fine to simply
> configure the hw-dtb via the -machine property.
>
>  Thanks,
>   Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

