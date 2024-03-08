Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CCC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVyg-00053s-2Y; Fri, 08 Mar 2024 03:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riVyZ-00050U-Rd
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:53:14 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riVyX-0007d0-2a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:53:10 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso2151885a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709887987; x=1710492787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmJizoCCaKyZaOF+64ZgaBez+SETXJzHPRiAn9QJy9s=;
 b=T8OJ1q0gWXfvbN72374jJbmuYr6QFUrr+xU2RsCMXFLEebDRSXH8/MJwIxuZiWYgDX
 nABZ+xOlO3giGyIpkHHCDBgaXe+aWy65269VbXLUYEiXXnHw3z2Hvm/g48W6gcBLYpEO
 J4pZFqRjrOt6OnTjuxwNzWb5SH1WT30KpKREOsccICBv8UihRRFmK+ujGt2TQh6iyMxR
 OPt2YygUEtFRizbLWFNsLls97p4miI8FG3lKIsoOFs0fTGlW38ty4FwY7jrbRFov2SWD
 VumfaoIg3XEgUe6UqvGsnvAKTx+SEgKvhIw9Db0yD/JDTni58j9BTUD1oXflgYEE8C/8
 kfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709887987; x=1710492787;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmJizoCCaKyZaOF+64ZgaBez+SETXJzHPRiAn9QJy9s=;
 b=BSmMMu9l0L++TBrO6hRQof45ZjOzwlK8OWDSKh5BihsJhsEsDDxxU+ydfwp5VBBCqy
 YkTPewThLQzlV/SeehVgwgkN/OLq1aLIsXEXEh0pzkotDn/Z6zU4BAEHwpzr/rcWBDMb
 j56SmfsPvGt8EXSTY+MewluncoqdfinasAcGfOXNwTZxpm64yQWgc+s/idurRprWfsMc
 tLGbDXtSZnxOiTcEbxVn+Xpp1kDu9WozcJ2fNlzYagsQ2w05JrskJl9R7lA7xi1PZRmg
 2aWhR+TcGWXEjWcInTAN3ZNzLE2/6BUx+Gzp0eLr5Y8jHPZEZ5yuNiqH4Q1L1VuDuisH
 cRhQ==
X-Gm-Message-State: AOJu0YwQ5rixOQH+rw/jpJnnYdFKYfe4t8H56l82yoXaP+6CXLvNKfvG
 SuSe/u9+nFCxnXdDPBjIHiT/k3EvyJbArsKYl9ml88xAWGUNUwe8BSs0OtE+
X-Google-Smtp-Source: AGHT+IGgLLyVFG2rJvOOSCDhoQXioweq9ufSAfT7mCXZM/hxQnyjPkUbnc4dJWXm0Jx6MZi+i4ZSDw==
X-Received: by 2002:a50:9305:0:b0:567:a2d8:ca92 with SMTP id
 m5-20020a509305000000b00567a2d8ca92mr1506237eda.23.1709887986891; 
 Fri, 08 Mar 2024 00:53:06 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-029-194.77.191.pool.telefonica.de.
 [77.191.29.194]) by smtp.gmail.com with ESMTPSA id
 es14-20020a056402380e00b00566d9c8e6cesm7681177edb.21.2024.03.08.00.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:53:06 -0800 (PST)
Date: Fri, 08 Mar 2024 08:53:04 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Laszlo Ersek <lersek@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
CC: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_4/5=5D_hw/i386/q35=3A_Wir?=
 =?US-ASCII?Q?e_virtual_SMI=23_lines_to_ICH9_chipset?=
In-Reply-To: <7212177d-e4d2-5875-b6f0-77991e0e38af@redhat.com>
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org> <Zd9iz9aIwM3cOqwt@intel.com>
 <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
 <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
 <7212177d-e4d2-5875-b6f0-77991e0e38af@redhat.com>
Message-ID: <CAB28920-F997-4E38-B170-5767AB57EE13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 8=2E M=C3=A4rz 2024 08:10:24 UTC schrieb Laszlo Ersek <lersek@redhat=2E=
com>:
>On 3/8/24 09:08, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 7/3/24 20:43, Thomas Huth wrote:
>>> On 28/02/2024 17=2E43, Zhao Liu wrote:
>>>> Hi Philippe,
>>>>
>>>>> +/*
>>>>> + * Real ICH9 contains a single SMI output line and doesn't
>>>>> broadcast CPUs=2E
>>>>> + * Virtualized ICH9 allows broadcasting upon negatiation with
>>>>> guest, see
>>>>> + * commit 5ce45c7a2b=2E
>>>>> + */
>>>>> +enum {
>>>>> +=C2=A0=C2=A0=C2=A0 ICH9_VIRT_SMI_BROADCAST,
>>>>> +=C2=A0=C2=A0=C2=A0 ICH9_VIRT_SMI_CURRENT,
>>>>> +#define ICH9_VIRT_SMI_COUNT 2
>>>>> +};
>>>>> +
>>>>
>>>> Just quick look here=2E Shouldn't ICH9_VIRT_SMI_COUNT be defined
>>>> outside of
>>>> enum {}?
>>>
>>> Or even better, do it without a #define:
>>>
>>> enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ICH9_VIRT_SMI_BROADCAST,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ICH9_VIRT_SMI_CURRENT,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ICH9_VIRT_SMI_COUNT
>>=20
>> This form isn't recommended as it confuses static analyzers,
>> considering ICH9_VIRT_SMI_COUNT as part of the enum=2E
>
>Side comment: I didn't know about this (so thanks for the info), but
>that's really a shame for those static analyzers=2E It's an ancient and
>valid pattern=2E :/

Another pattern would be:

    enum {
        ICH9_VIRT_SMI_BROADCAST,
        ICH9_VIRT_SMI_CURRENT,
        ICH9_VIRT_SMI_LAST =3D ICH9_VIRT_SMI_CURRENT
    };

which should also work with GCC's `-Wswitch-enum`=2E

Best regards,
Bernhard

>
>>=20
>>> };
>>>
>>> =C2=A0=C2=A0Thomas
>>>
>>=20
>

