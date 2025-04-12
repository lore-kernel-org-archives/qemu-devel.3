Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA0EC369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3TTS-0001Ei-8Q; Sat, 12 Apr 2025 01:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TTN-0001Dj-Bz
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:32:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TTL-0003qc-Pn
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:32:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2448298b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744435926; x=1745040726; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAcWOpqOglaOQbx/Q6xDEy97whklKfl1chCDJWnbICo=;
 b=jXMnd3kzuAVntmuClDS+RmjkzR0xV81CsFsQ6Z3avLn4qD/qm9MjTF+zlUDUTr3f6B
 0pZUjZ21KfAXooCxv7Iv9nTWQbGuJfrepHuhBxOtqJQVtHQqNjurJhDtMeKMabXeATmv
 PtlvXLv3+L70FKYYEgCEvidNEXJbYu7D5LenmZCTuuzWe0V5GhLz2Ctf1Soht9UfPGBF
 TvrBI/1pH1mafTlCNbdpMdfa+jVWJfcQQPtQ7lv5hfN78E7yr5byGaBNiWrB0LpltjmN
 mkhIZm/3OQAv2EHbthBFyVOHLoKikg9FwhkxEsac1CSNotikYzX0p/QU2c8Yy1EPIZ2I
 yxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744435926; x=1745040726;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qAcWOpqOglaOQbx/Q6xDEy97whklKfl1chCDJWnbICo=;
 b=ZceqQP/pJeJm4B/QYWHvOC92ZJSpUg5jG1RH7Bmzaq9vzyGFN+TwfW217JTm15oEUz
 LGjoyPClmziYkWOqhd9D9Xy9whLEvRTXfeKoF+kxhvUbmVxYKwa00S9F0AvazArBJ2Dx
 /ciI0wyTEhgC2dN/VB9/HaZ3Pj33mPlFs8TDR1tUbG+8jadI0YFoIwfu310xi7jgO/d1
 v/NV4Aj/SnyOlmuFG+5GbC6kQ5Brom6zic0UElSgmy0g5c+i78Aj991nKoZBNbziu9LZ
 iqt6V8tN99pBi4phwG0o+FPK2LyLc3CRt4j+bkOUmR+stOlJuJnYatvece16KOMffe6H
 HQrg==
X-Gm-Message-State: AOJu0Yz9cHdiin5++VaKaPEG/Zrno3c5+Thf0VYcF2mrbHpVgYj3xSdx
 nQa8qyq73vd81QiwqGFpZuKEFxtAStsTrbhrWKLMfzz3d1WG2QCL5NP4hw==
X-Gm-Gg: ASbGnctR4PhQ+Bu+exyfU4hG7kMt8FVpHhsDJ1rvCyub8akCnbWMWafGP9p0+ZE9CPP
 +Iz7kyGEPgZY4uIBFcdRr0kZDOg2gT3AzB/7SeC/f4phiF0WVhAphnXSioF4Ckq3JANE/EIKkxM
 4xNiNkbHwbP0J1Ta6eTQEMBfz6tpOshITUu+GGNwxgOQ222gQV4P824ph2w6dqrfmDqdUcEQ4li
 CVlgX85xTVEyrwuf7nYagy++mmTZeagEHclxwqJ5bjwEdzK/YixZpzi25EjRGZy5Pgspu/R9XN5
 TlZH0rxVHgoCN8XcaxCQc2BIPPhWsMPjTw==
X-Google-Smtp-Source: AGHT+IHjk+hNF/WNM9eHD3kv9i0wfsllMGFUqfX0XOMvr9VOpo0BjemyIkMxwpr0ONcC9sfv3BONhA==
X-Received: by 2002:a05:6a00:22ca:b0:736:a682:deb8 with SMTP id
 d2e1a72fcca58-73bd11ded49mr8631793b3a.8.1744435926033; 
 Fri, 11 Apr 2025 22:32:06 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd23332a3sm2640105b3a.161.2025.04.11.22.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 22:32:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Apr 2025 15:32:00 +1000
Message-Id: <D94EXATY54W7.14AY0C0HEWTTL@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Kevin Wolf" <kwolf@redhat.com>
Subject: Re: [PATCH v2 02/10] usb/msd: Ensure packet structure layout is
 correct
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Gerd
 Hoffmann" <kraxel@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-3-npiggin@gmail.com>
 <88ac3951-bac9-48d5-bee7-6ca2e465fe0f@linaro.org>
In-Reply-To: <88ac3951-bac9-48d5-bee7-6ca2e465fe0f@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Apr 11, 2025 at 8:21 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/4/25 10:04, Nicholas Piggin wrote:
>> These structures are hardware interfaces, ensure the layout is
>> correct.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/usb/dev-storage.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
>> index 2d7306b0572..87c22476f6b 100644
>> --- a/hw/usb/dev-storage.c
>> +++ b/hw/usb/dev-storage.c
>> @@ -27,7 +27,7 @@
>>   #define MassStorageReset  0xff
>>   #define GetMaxLun         0xfe
>>  =20
>> -struct usb_msd_cbw {
>> +struct QEMU_PACKED usb_msd_cbw {
>>       uint32_t sig;
>>       uint32_t tag;
>>       uint32_t data_len;
>> @@ -636,6 +636,9 @@ static const TypeInfo usb_storage_dev_type_info =3D =
{
>>  =20
>>   static void usb_msd_register_types(void)
>>   {
>> +    qemu_build_assert(sizeof(struct usb_msd_cbw) =3D=3D 31);
>> +    qemu_build_assert(sizeof(struct usb_msd_csw) =3D=3D 13);
>
> Can we add definitions for these 13/31 magic values? Then
> we can use them in try_get_valid_cbw().

Good idea, I've done something to improve them.

Thanks,
Nick

