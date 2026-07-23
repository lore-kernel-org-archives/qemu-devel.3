Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BC6C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqdo-00068f-0b; Thu, 23 Jul 2026 06:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmqdi-00068E-Gw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:26:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmqdf-0005wz-Iq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:26:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so4172855e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784802408; x=1785407208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W8aFwPIieKT1xuwjrB3a0EY3IqJkrFSQQKzxxhhM4ec=;
 b=ZVBQmutocquZ0uqWE+MkAujbq0z8O3TlFaJFmaEgPb6elslS/xY5T2PuyyROJa9ipc
 sAku6ku9Qj/Exd3tP3Xo5tA5oWfDb0ibXpDzn4zJdQySDEqF0N91OLbVd/xNqirGs8w0
 BqsNPidJwSPX2qL+9yQeXHXrm/bfln9j8UzU9ZOpp9e56ue4Wg3Izg0D0B5OtcATnv95
 Y9z19bYlOBhHIZwNM7OXHeVBkqsmhI8C4B8ceBcXsCvcOQyVlYpo6isKyy55sZRLdWOK
 vjYcNSXYPes0LqKrjjOle9Xvqsw7ELWr/yXxpYo9ua8H26BvwOIQ5HjFRlqHsDZU+jJj
 dYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802408; x=1785407208;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W8aFwPIieKT1xuwjrB3a0EY3IqJkrFSQQKzxxhhM4ec=;
 b=LC+Dm/+4jKujUVRUmjpsckZAKbGiHob3Kad17/IKRy9RoZGMY4QhOoI88GJKp/IXai
 QX3Uu2xZXSSJnO4xNI6c+4h0zaMIT8HwQfxdM48C1FPnclUC+ir92xaLUtsFip9q6s0E
 oZ8uYtL/lBCX3ghiC+FSn9+9/soS2t2b6C1wDZJu41YtsU9+SoIKqv3D1trwZk3Hpe9T
 HVDogqtS09iAdgyQtxVowf33N+lO3rGkflhkMRHYq7cMzjW+U1sPft8NwiF4beoMOMPF
 IYRTXokfg5WvE+XpD8l2kV71Prs69cibQq3mFqwLTZQURmq60DPmdicLtX4CfDkDe4B5
 dCWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGLOnFSG3ocW72PgSP5BizETb84nuC1wziR5AtaiXdppa/KZlH8JwKPJzhTkK+HB4OgUEhZ6LwsHvX@nongnu.org
X-Gm-Message-State: AOJu0YxAc+K85m9gE1QzTbAhDRLPfp03+Jw0uPmPtPeLdakHKGeA/9SD
 L98pCE6sehHZ4uT9pxteTqboBTpUVAbn74CjzbvkTFJENdJRHvzJi/lx
X-Gm-Gg: AR+sD13cSn2Q9jV/uLMDs/Wc4fftd73lU2hdWwrbmjkvKBMQOhTt0plovMMHzuV/Wz/
 wK+e0bJ9ZE9ywJiecaJsst49elO0eY1wzh4lhUbwfZDvDicGUf8sXfUnv9JQ2K/x7yABLbXGzwk
 y4qCZAwQyGynjI1tfrJf44QjT37YK3nK6Lnwmx87xB3Ysy5wIUUA46IL0rD4FtrT+gtmMjRgz8U
 3qye3J0NWxc+Z7/A4s4+FI8RApsNX62gfLsAtLdiu3+KiD0OUylMTIc6P9epLM5U2lqL7bQuLEk
 KUaAqOEcXbR1W+pSsfQSV5P1fw9Tfb8SD6R6ns/kpcGfUJLuVVIpCG2Hl5UeezbtLhLmNVDIn/d
 RlV9FazsQixdbtfjv+FqwrK/M98lri4mzvDUOws0aMm89Q47Vi18D1f17unEHLs4uAwC7rC8979
 J6qGdofCqW
X-Received: by 2002:a05:600c:a09:b0:495:52db:7e8 with SMTP id
 5b1f17b1804b1-49573cf6cd1mr29178015e9.19.1784802407520; 
 Thu, 23 Jul 2026 03:26:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.40])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm198956095e9.8.2026.07.23.03.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 03:26:47 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:26:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
In-Reply-To: <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-8-shentey@gmail.com>
 <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
Message-ID: <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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



Am 23=2E Juli 2026 08:20:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@oss=2Equalcomm=2Ecom>:
>On 23/7/26 09:00, Bernhard Beschow wrote:
>> As indicated in the comments, the `mb[]` a=2Ek=2Ea=2E `mbs []` views sh=
ould
>> cover 0x400 (1024) bytes=2E However, the `mb[]` array covers four times
>> the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size in
>> bytes instead of counting the number of uint32_t fields=2E This shifts =
the
>> subsequent register offsets by 0xc00 which is not intended=2E Fix the s=
ize
>> and thus the offsets by dropping the now unused `mb[]` view=2E
>>=20
>> Note that the different size changes the migration layout=2E Since the =
device
>> model is new, no change in the version fields is needed=2E
>
>typedef struct FlexcanState {
>    =2E=2E=2E
>    union {
>        FlexcanRegs     regs;
>        uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
>    };
>    =2E=2E=2E
>} FlexcanState;
>
>static const VMStateDescription vmstate_can =3D {
>    =2Ename =3D TYPE_CAN_FLEXCAN,
>    =2Eversion_id =3D 1,
>    =2Eminimum_version_id =3D 1,
>    =2Efields =3D (const VMStateField[]) {
>        =2E=2E=2E
>        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanRegs) =
/ 4),
>
>        ^^^
>
>This "consider this structure as a casted array of u32" is very fragile
>anyway, and will unlikely scale over time=2E
>
>        =2E=2E=2E
>        VMSTATE_END_OF_LIST(),
>    },
>};

Any suggestions what to do instead?

>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss=2Equalcomm=2Ecom>

Thanks Phil for the very quick responses!

Best regards,
Berngard

>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/net/flexcan=2Eh | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)

