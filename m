Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991E6C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 19:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u19C0-0007cY-0Z; Sat, 05 Apr 2025 15:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u19By-0007c9-3N
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 15:28:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u19Bw-0000uJ-By
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 15:28:33 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso345312a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743881310; x=1744486110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6n/eFoCG7ny+z75YS/x6GnXIaw7bZdlPnfanH8tXNk=;
 b=h4KTQlIqBrHW1bd45j80KzW1+sh+qYST9+q9nozvpo7X6pFk/9pPRlNFBIoCHYWBFc
 dzLp5LFsvAXvGUjpz5yk+1qIjVKFKIdvbNLQ/fiD2/kp7+v3ENu71Sf71aTA2ekbduGj
 gFrtx9HF6pXofKwGDLwuSbp0Oact2yfB3Cz7DXvL+9/2UVl9QCK0iRxyk2Nd7o2QBgTl
 cj5SZfLpsSkqCqdu+/ExFREhbrndoU/uP2SGv1IuoR/Dip+wJXJjAyhJtkKIsLx5KaBU
 gGicT7vwI2w/dmEBrShDmw+aVV4EoWNccveVDk1de7Hxjcs+E6LvGrsFu1Ad3ztneI65
 5n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743881310; x=1744486110;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6n/eFoCG7ny+z75YS/x6GnXIaw7bZdlPnfanH8tXNk=;
 b=Fo6bSj39u+3VWKgzToeF+EZX+tB9e0CA/C3FlC2ByjW7GqPmbxWsbW9FnCNqzDyMUD
 PBXSI18G2QjyCDPxJ8A1b+yTJTdLffARZSL/ufOxx9Y2fwVJhTKa5XQtoC/EFC83Smw6
 owpJJAcnV3sqHl6cFxJB5Wjea0ZrxtPrQ7dtVes3uPcMCvE6EgPEYEgGXxs+AXKQu2cL
 W7ahyfLRm0/X66YP5MWgNqjYaWc41e7LHITQ2y8Y1nGRfsMwJcTuVxK4XpnC5qZ1CID/
 3HR4wO0QM0A9Jn2Z0o18cx+anNYTA3WJEP1k41UATIXmOwiUJ8FpAtgbnXlxq3h36qXP
 7SHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZz+/ojKsv+kPkVdbAWyIp/DdKOWG1qCwUeoOZs/ktDF5RYcQFZd326t3/4O9ZVkyogEd8Qr+e5u5Q@nongnu.org
X-Gm-Message-State: AOJu0YzOy/h4Vr8r6oPsbs+u8ce7U5COTMe8MdALIoLZPdh+vz6kIZLW
 1RdGz1Ij4RrjrjC7qTXfPfW6pJiQRtTvb+MyvFinVmKkWToSOUlXEzn3ow==
X-Gm-Gg: ASbGncvhnVQUpmHSOvDaoB+hI38r0TC9r6yONKRGnv+w1APcfXI/eXv1H2QrzrYgEiO
 QKrn9e9GAij4RkokEYrH3tLBR/0slW+h35tZuoJ4+QokJ7Za5dJfvqpaBwGBMbE09WGLguhIlRl
 bPytSErsvzOAuE2UOIUISuGtW86TlBUgGp1BYWFOD/TqFG12a91nO/RBWpjZezFdYpvRLKKpQTi
 diDMaBR+FamdJ83rD1UFiv2qnMh+9lwNCA1cL+T2XF9cu8XdYTnDkpLdNOKazIwE0z94XfXl9cv
 C9IZpA/wl/iIRSnAmYqchD+ONs8q32ImCPT6TQA8QwUVbcOuCfHiZC4hOsXzYNw+csrL8x7Ei5z
 +QIBj6Ymi1d037PRsc9V5A1kNiRbjbLT3g0q+TsrNBtpYGS0qlyuK
X-Google-Smtp-Source: AGHT+IHR18VyadspvlEuSQS0guCh1S9aM1zQ2ATBL/xyzTVQF3dkcTZAyaCVx4qgtSbQdxd2T6YnfQ==
X-Received: by 2002:a05:6402:26c5:b0:5ed:599a:3cbe with SMTP id
 4fb4d7f45d1cf-5f0b284dc9amr7033648a12.4.1743881309819; 
 Sat, 05 Apr 2025 12:28:29 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1bf0-7700-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:1bf0:7700:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880850f2sm4206592a12.59.2025.04.05.12.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 12:28:29 -0700 (PDT)
Date: Sat, 05 Apr 2025 19:28:27 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
Message-ID: <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 5=2E April 2025 17:26:14 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On 4/5/25 07:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Guenter,
>>=20
>> On 5/4/25 16:00, Guenter Roeck wrote:
>>> This series is needed to support the USB interface on imx8mp-evk when
>>> booting the Linux kernel=2E
>>>=20
>>> According to the XHCI specification, ERSTBA should be written in Low-H=
igh
>>> order=2E The Linux kernel writes the high word first=2E This results i=
n an
>>> initialization failure=2E
>>>=20
>>> The following information is found in the Linux kernel commit log=2E
>>>=20
>>> [Synopsys]- The host controller was design to support ERST setting
>>> during the RUN state=2E But since there is a limitation in controller
>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>> It is supported when the ERSTBA is programmed in 64bit,
>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>=20
>>> [Synopsys]- The internal initialization of event ring fetches
>>> the "Event Ring Segment Table Entry" based on the indication of
>>> ERSTBA_LO written=2E
>>>=20
>>> Add property to support writing the high word first=2E Enable it
>>> for dwc3=2E
>>>=20
>>> ----------------------------------------------------------------
>>> Guenter Roeck (2):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw: usb: xhci: Add property to su=
pport writing ERSTBA in high-low order
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/usb/hcd-dwc3: Set erstba-hi-lo=
 property
>>=20
>> What about using =2Eimpl=2Emin_access_size =3D 8 instead?
>>=20
>> Could you try this patch, or provide me with a reproducer?
>>=20
>
>You should find everything you need to reproduce the problem at

Hi Guenter,

thanks for testing the new board, much appreciated=2E

>
>http://server=2Eroeck-us=2Enet/qemu/xhci/

I like your approach of pruning the device tree automatically: <http://ser=
ver=2Eroeck-us=2Enet/qemu/xhci/patches/0002-imx8mp-evk-Remove-unimplemented=
-properties-and-nodes=2Epatch> Would you mind if I upstream it with a few m=
odifications like in <https://github=2Ecom/shentok/qemu/commits/upstream/im=
x8mp-test/> ? If yes, please let me know if I attribute your work there cor=
rectly=2E

Best regards,
Bernhard

>
>Please let me know if you need anything else=2E
>
>Thanks,
>Guenter
>

