Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031AEC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBeTX-0003Zm-TF; Mon, 27 May 2024 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sBeTT-0003Yr-SY
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:49:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sBeTS-0001WO-AI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:49:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so2334805a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716832168; x=1717436968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffldguoet2nlUjWBuY8PVDtwP96qcH8dgkRA4HMhtkg=;
 b=g4HyppffANwmExx6W9NPEycPAtVuqOk5QW4JBNF1qBvFezX54wxu43a5SyHw2I2dh1
 wX3vTBANLO/NG+JoAa8EreUItQjnI5CjNaeFl/M6C7/cdG8FmXIx90x8w/pqHNuteLFX
 Y+tHZxbkG3dWzZqZdhMyYY5pEqp7wYVPk9LWH+Mm9Xm5lTAi6TUUnQHKPadJuwsxMC8H
 DP8fN27BMo7K+XRbWwuZEYGjy0gEC0jSOOSpV/fuRgBAAbynbJkoBFridO1MCzRIf+Qc
 fPsMkWP2IgkuUU0ntXS5c3vKDdRzsBf7qbW96pxVgx7Rn620fTNM5fOvvqKdH+sh3gyC
 NNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716832168; x=1717436968;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffldguoet2nlUjWBuY8PVDtwP96qcH8dgkRA4HMhtkg=;
 b=l5q+cusdGMBjhSdWeZ0LHfmdHQvzOYNusysPHZVBKdnj7i+ffTiwfHH54K8wIaDzUE
 GrlWopYOC8SblyO0AkMVrwyNscEjyaYyDK6JSJGR1KFUP5SVQ/HSuAMO8lmi3s24hpgW
 IabJQCXqmun37ViNGw4WpGZ0M0c6+/ZeA3apw+7iv3qRMLBzL+0Rrl9xggb5HpRmFn9h
 u02961Dq70VaYMzE7oHZznt1eKj5+zcVVjAE4KFl+j4g3RsGu2mO2YGcGR0RYPeHnzy4
 nA+4MS97NyAkhA2RZHC3BQHPcIdtw0Y3sLVdXYDFhHnvg3yoEtfjY7mb1EqQlCrNhdA/
 mQhg==
X-Gm-Message-State: AOJu0Yya5mm3pU3a9s6DpB2GFloF2IWLqPgZr1xAcdc5ZP5DHGn3bHYd
 zjhZGQZVczCyCrQqeFPP6HHHqpFb6nETzFQHvvq6UDM50fzbOjFF
X-Google-Smtp-Source: AGHT+IEE607fCdtoCXddL2YteTjaF6k/3TUNBnNtbrudwbYNkX6vHTysGVPpsuClHhZK8oE5EuEZ9A==
X-Received: by 2002:a50:d5d1:0:b0:578:36a2:7073 with SMTP id
 4fb4d7f45d1cf-578519f5c09mr6760356a12.29.1716832168382; 
 Mon, 27 May 2024 10:49:28 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5786450bb13sm4341196a12.72.2024.05.27.10.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 10:49:28 -0700 (PDT)
Date: Mon, 27 May 2024 17:49:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_17/20=5D_target/arm=3A_Do_memory_typ?=
 =?US-ASCII?Q?e_alignment_check_when_translation_disabled?=
In-Reply-To: <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
 <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
 <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
Message-ID: <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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



Am 27=2E Mai 2024 16:20:44 UTC schrieb Richard Henderson <richard=2Ehender=
son@linaro=2Eorg>:
>On 5/27/24 08:29, Bernhard Beschow wrote:
>> I think the kernel's output indicates that the MMU is active:
>>=20
>>    [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
>>=20
>> AFAIU, the value in brackets is a virtual address while the pte's are p=
hysical ones=2E Furthermore, the `info mtree` QMP command tells that the ph=
ysical addresses are RAM addresses:
>>=20
>>    0000000010000000-000000002fffffff (prio 0, ram): sabrelite=2Eram
>>=20
>> So I think we can conclude this to be "normal memory" to speak in ARM t=
erms=2E
>
>Normal and Device are attributes on the page table entry=2E
>See section G5=2E7 Memory region attributes in the Arm ARM=2E
>
>But it's unlikely that the Linux kernel has messed this up, even back in =
4=2Ex days=2E
>
>If you want to make any progress, you'll have to share a test case=2E

It's a proprietary guest, so I need to strip it down first=2E This may tak=
e some time=2E Thanks for yor feedbak so far!

Best regards,
Bernhard
>
>
>r~

