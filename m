Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F1C02199
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1th69a-0002Ee-R1; Sun, 09 Feb 2025 07:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1th69W-0002Ay-Vh; Sun, 09 Feb 2025 07:11:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1th69U-0004FI-5P; Sun, 09 Feb 2025 07:11:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so1705405e9.3; 
 Sun, 09 Feb 2025 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739103066; x=1739707866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4KfBju+0bfsHZpa8yGFjHAnw94bvr4VcYutTLIBhM0=;
 b=Mly0J9qiLhq9DQO4Xc93egeVYFN2Br6Dr2Ynd4BuOqdnFzV+BiiCbtHTisGBlchKv0
 HjIdxOX432cmn5x3/59/THNR+PgenA2UEo4d50csgriXAynz+8nucpR3OYaF+AD5fWBP
 hxYffEsqgiN/yISPaHTxfAsf72Fdrfk4rKWTHDCV6IauincDQLKUF/Bg0rwKZgVChslj
 ohbyoCqpx/PoPCyyf3du/udmivI5cmmCgUS0gfXf/Buwdd2j8a/1JL+4OXwIHqFoFlKs
 ALce9URD/Q0rBkzHJqzcszCSKPgRF4Ypp3cddTefCd9R0Bz3qztgTYQGmjjiXJv0m34o
 uLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739103066; x=1739707866;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4KfBju+0bfsHZpa8yGFjHAnw94bvr4VcYutTLIBhM0=;
 b=GJ7SbfJwMzMgeSGdcz/XPQx9jUkm+RlELbiTRfrlOC8aPY+k5FCKRAFjg4VZzdQr9x
 iDjl2mBM31q5HD9aAtAAllyF+Iy1W2aCv8WnCW8tgvhAxT6ke3PX+/KhprA642n0I8xC
 TO7TT+AjH+zNQ0/5NmgzgYIPo5kiP12D8VCkAt53/77Z/RYbkqFt/wzkOvWaWuxcm1iz
 7EGcaP+iuT+TEIqLCbWJoiIIEfC1eqpo8ntubAlX7tLmxh5rGAtqaeDxqZ2tSXtQ65nY
 3YoCHdxhAvyELdL/8IaHDZ8LaWUkG8A1ejYQjf8jU0pSKoow9Pso07IMAe8bOQmQiAGy
 4yXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8KWLUiFn9RjVMtrCGjUSDNm5Rbwd9pxdixQVwNXBmnzYXItSlsmy9Qu7HSsvm8Hg/2sM34NG6PxbL@nongnu.org
X-Gm-Message-State: AOJu0YyRz7L5BXHzjijtYdk/0k5piqTY9QoZCAMWG5mTbgnNDdFjs5M6
 hN0YnLAo7htdXiLFlwa2ePT/95o7KXvQ1/Vl6rbb0YQuvqL7TBPiMmuSUg==
X-Gm-Gg: ASbGncsWe98TdR/Bbhb7gl8QA/nXfEUNdqTslB9hTLgew8KH2ycfoebFvqn6wEocjS+
 5dgaMiSED9h00VnvAZtLqYo9AOXPN9tZPYtY2hOolq1YG4+MJVNZQ6pS5gjNq0t4Z+ConvNu6on
 x+HuyaPmdj8YwtmQava8sQ3NQXvB1RlvBTdc7idL8rFzFoDRgJmV72bzsd2dVZ3GzO4obu5g+Ip
 zizfdkKK3JPF/bfxWQsfSV1ho107v9OX8tnYvyYWCkJjXT1FwLI9DixPRq3KqF3zmL8bqvfmyX/
 dKTvR2QC0WUdjuX1sy6oosbi0X8j6CMysMbJ9493Yo1PQ4lDIXn6UYk8eLHRI9c8wRBsTMm8R+E
 =
X-Google-Smtp-Source: AGHT+IEkibGrQia9sH4sltfHccW96gHqYEbh3moDFZfLmikOTQR+0ZNx4I8Hylkf5LgjCO5oDfpiSw==
X-Received: by 2002:a5d:584f:0:b0:38d:d544:8bd7 with SMTP id
 ffacd0b85a97d-38dd5448fa7mr3873817f8f.33.1739103065290; 
 Sun, 09 Feb 2025 04:11:05 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf00430069d256f6a5af50a8.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394376118esm2206745e9.40.2025.02.09.04.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 04:11:04 -0800 (PST)
Date: Sun, 09 Feb 2025 12:10:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
In-Reply-To: <bd8e216d-df13-4842-9a5a-5f274237359c@eik.bme.hu>
References: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
 <8cbad5be-e67b-46bd-9198-f7c90ad5ff56@linaro.org>
 <cc92e02b-c20d-974e-8b6d-bb30ea5af452@eik.bme.hu>
 <800dcc1b-8bf6-48e5-843a-99e630d4b494@linaro.org>
 <bd8e216d-df13-4842-9a5a-5f274237359c@eik.bme.hu>
Message-ID: <11A1B948-8230-4F4B-8809-ECE30A6A34F3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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



Am 6=2E Februar 2025 13:49:38 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Thu, 6 Feb 2025, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/2/25 13:49, BALATON Zoltan wrote:
>>> On Thu, 6 Feb 2025, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 15/1/25 20:04, BALATON Zoltan wrote:
>>>>> The interrupt enable registers are not reset to 0 but some bits are
>>>>> enabled on reset=2E At least some U-Boot versions seem to expect thi=
s
>>>>> and not initialise these registers before expecting interrupts=2E Th=
e
>>>>> numbers in this patch match what QorIQ P1022 has on reset and fix
>>>>> U-Boot for this SoC and should not break other drivers that initiali=
se
>>>>> (and thus overwrite) these reset values=2E
>>>>>=20
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>> ---
>>>>> I've also noticed that the work around marked with an XXX comment ne=
ar
>>>>> line 600 breaks the U-Boot I've tested so I need to disable it:
>>>>> if ((s->sdmasysad % boundary_chk) =3D=3D 0) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_aligned =3D true;
>>>>> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_aligned =3D true;
>>>>> }
>>>>> What should this hack fix and could it be now removed or somehow
>>>>> restricted to cases where it's needed?
>>>>=20
>>>> Cc'ing Jamin for
>>>> https://lore=2Ekernel=2Eorg/qemu-devel/20241213031205=2E641009-2- jam=
in_lin@aspeedtech=2Ecom/
>>>>=20
>>>>>=20
>>>>> hw/sd/sdhci=2Ec | 2 ++
>>>>> =C2=A0 1 file changed, 2 insertions(+)
>>>>>=20
>>>>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>>>>> index 58375483e3=2E=2E88eb0bfcb2 100644
>>>>> --- a/hw/sd/sdhci=2Ec
>>>>> +++ b/hw/sd/sdhci=2Ec
>>>>> @@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->data_count =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->stopped_state =3D sdhc_not_stopped=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->pending_insert_state =3D false;
>>>>> +=C2=A0=C2=A0=C2=A0 s->norintstsen =3D 0x013f;
>>>>> +=C2=A0=C2=A0=C2=A0 s->errintstsen =3D 0x117f;
>>>>=20
>>>> I guess the problem is earlier:
>>>>=20
>>>> =C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0 * Set all registers to 0=2E Capabilities/Version r=
egisters are not cleared
>>>> =C2=A0=C2=A0=C2=A0 * and assumed to always preserve their value, give=
n to them during
>>>> =C2=A0=C2=A0=C2=A0 * initialization
>>>> =C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0 memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintp=
tr_t)&s- >sdmasysad);
>>>>=20
>>>> Not all registers have to be reset=2E
>>>=20
>>> Nothing seems to program those registers before reset but the reset va=
lues are documented (for Freescale eSDHCI) to be the above so just not zero=
ing them does not seem to be enough=2E Bernhard has similar patch in his br=
anch, not sure if he came up with that separately or took this one=2E Do yo=
u have some docs on which regs should not be reset?
>>=20
>> The header precises what is being modeled here:
>>=20
>> * SD Association Host Standard Specification v2=2E0 controller emulatio=
n
>> *
>> * Datasheet: PartA2_SD_Host_Controller_Simplified_Specification_Ver2=2E=
00=2Epdf
>>=20
>> I can not see the reset values you mentioned there=2E
>>=20
>> What is wrong with adding a TYPE_FREESCALE_ESDHC, like the
>> TYPE_IMX_USDHC / TYPE_S3C_SDHCI types? Then you can add your
>> reset handler fixing your fields after sdhci_poweron_reset()=2E
>
>Nothing's wrong with that, I just did not notice those existing variants=
=2E Maybe that's the way to go then with this too=2E Bernhard, do you plan =
to do that when cleaning up your tree or should I do another version?

Feel free to submit a patch=2E I'm actually in favor of a dedicated device=
 model which was also my first approach: <https://lore=2Ekernel=2Eorg/qemu-=
devel/20221003203142=2E24355-14-shentey@gmail=2Ecom/> Perhaps we could have=
 dedicated source files as well=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

