Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0AC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcshw-00072A-JR; Tue, 28 Jan 2025 16:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcshu-00071f-Jd; Tue, 28 Jan 2025 16:01:14 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcshs-0002B2-5l; Tue, 28 Jan 2025 16:01:13 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso139770a12.0; 
 Tue, 28 Jan 2025 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738098069; x=1738702869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTNqOQ4RwVUWCgn6HX+Oj/bHeQslJwkndeT4/tSVYlU=;
 b=TdYLeQ1B5dsY9wxCRwzSDlHYj0oocem4NLXIDJrUCBBHo6+OstAGjjoyH0zAXDY/6k
 gPrNBFyrZSWVcAkz5lrmwNiiME5zl9yx3W95DO4dK87zf9LQMFKaPhoI/9xHucyKqu/X
 o2rZSFg0+O7jN3y8lJWtjZoDZuBr5G+nGWaw9YfLkH4LqozXIZxHeS2FBDlzvYEoAcYt
 ryihuBsOZuCDRDuX3dT9bx6GHX8IkC6/EPeY1fXY0qKXZjKPRZ9H+DMuDyg0ANWmLG/R
 H/UY8cTvM8FnBd0bBgmxu0psKCxmXATxESSh7HET7pTGzaLi3tKBMNfTBhZZtDawOp+D
 fwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738098069; x=1738702869;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTNqOQ4RwVUWCgn6HX+Oj/bHeQslJwkndeT4/tSVYlU=;
 b=B69wR5A9kt6McIdoFmHs2CU5oRDDqX8koyr7o6f2zwfjG5f/70GUy/zlaFaKfUzwdj
 QoRiSLhgUR96B/B30tx+f+7o2Qkm9vUuBA0wYR9UkUOEUadpDApNmmbVDYLTtTBSziDR
 EythyMzChfmvK5XY5pqjPubp/DrkjC+1TOyAQMIqhJInfK8fxq5jHMPBu/J3GFvPHSfx
 PAZjzll73X5PaTGm7IiRDutNpRx7MKk9g2tI+A5aPLf3P9R7JZF97RPNFXFNoV/d3LGf
 IHZyNHgMzcQy1RLxSJay5bGMQuN5H/G8WxOqBM20/MlmecKrptlBgddtMIAJUKR6HQF5
 p3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdOa4WG2qeYY9cF8H0G+96BSvkJ4NSyWRmpdRgyPNUS0PSHdmo3Oz9QkIJQbZYorHNeMkElYYBuewZ@nongnu.org,
 AJvYcCVIaQQ534v2v7ekqUEs0EVYknRFmaxGfI0027iccgyLskKhqma/87SV5Th3nZfnx66OTsJL/+NO5b0=@nongnu.org
X-Gm-Message-State: AOJu0YyedSTEV2cBR7HbLRISwG9Hj0CiZe4efvUWl6U1TcER0z5Pbmnb
 fmCE6mST92BZh8/btAxdCJSbXgg1Ii9dktAcdeuoTFAn8KPRCUhU
X-Gm-Gg: ASbGncu6c9Unw3uU87tbsidZ7fGng3VelpTp0sDpjDFZ4VCTH5XITogdNqdZFFmTZr2
 2+C2LwNr9vbABukm9kIjdT1KSBMJYAnGrZIfa5MSubCumbGuEoHHho0eIU9lk558CjIXpTvP5nx
 xQC8CbcdgpPz9k5a1NOZniPlQ6H3BOHQtQjuU1tCraPknIGpIB5+i2AlVtErbt1mNx6GTzDJdF+
 qIxs1XRVo5Cu87n0h4h/mFsIcFoTfOnVKR3K+MHMJZNM40nx0Mo2QN/qbILzT49uVImZmjPHjvh
 cNp2p5M17JtUKQhZn5VtfqbBhQ9Sj30PNvBhxc6PnqWGgZqQMn82kle9NNj5Lie5
X-Google-Smtp-Source: AGHT+IEUH1MqAsTKouPAgO63mx87B7XD+KP2maJkZHlUr1Y668zI87sZ/y2pdGu6scR74+6RcErjsQ==
X-Received: by 2002:a17:907:3f25:b0:aa4:cd1e:c91b with SMTP id
 a640c23a62f3a-ab6bbaa8a32mr417503766b.7.1738098068537; 
 Tue, 28 Jan 2025 13:01:08 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-042-254.89.12.pool.telefonica.de.
 [89.12.42.254]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760ab311sm860147666b.97.2025.01.28.13.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 13:01:08 -0800 (PST)
Date: Tue, 28 Jan 2025 19:13:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/9=5D_hw/sysbus/platform-bus?=
 =?US-ASCII?Q?=3A_Introduce_TYPE=5FDYNAMIC=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <990dacab-6cfd-4a18-944d-ba076a80996c@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
 <wkb53fhvfchqa4uvmifgitvcr7t7rfpc3hcohdhzczkzvktetx@yjveswjel3s4>
 <CAFEAcA-QOYcnJi=joKHbRmUCXK1UFOgQRgYP-fDq4h_1SkMGyQ@mail.gmail.com>
 <2893a552-ca6c-01c4-dcc0-6107ccf1c7b5@eik.bme.hu>
 <990dacab-6cfd-4a18-944d-ba076a80996c@linaro.org>
Message-ID: <291CA1E7-6220-4F8E-90E1-D38723E7FDBE@gmail.com>
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



Am 28=2E Januar 2025 15:10:18 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 28/1/25 13:57, BALATON Zoltan wrote:
>> On Tue, 28 Jan 2025, Peter Maydell wrote:
>>> On Tue, 28 Jan 2025 at 10:42, Gerd Hoffmann <kraxel@redhat=2Ecom> wrot=
e:
>>>>=20
>>>> On Sat, Jan 25, 2025 at 07:13:34PM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> Some SysBus devices can optionally be dynamically plugged onto
>>>>> the sysbus-platform-bus (then virtual guests are aware of
>>>>> mmio mapping and IRQs via device tree / ACPI rules)=2E
>>>>=20
>>>> Do we have some sane way to have user-pluggable sysbus devices on arm=
?
>>>=20
>>> The answer in a general sense is "no, because user pluggable
>>> sysbus is a weird idea"=2E "sysbus" means "it's wired into a
>>> specific bit of the memory map and to specific IRQs, and whoever
>>> does that needs to know what IRQs and bits of memory are usable,
>>> and the guest OS needs to know it's there"=2E "user-pluggable" means
>>> "it's all automatic and the guest can just do some kind of
>>> probing for what is or isn't present"=2E All the platform bus stuff
>>> is a nasty mess that's working around the things people want
>>> to plug in not being clean devices on probeable buses :-(
>>> And the platform bus is only supported on the "virt" board,
>>> because that's the only one where QEMU is generating its
>>> own dtb or ACPI tables where it can tell the guest "hey,
>>> there's some device here"=2E
>>=20
>> There are some SoCs that have memory mapped devices but different versi=
ons in the same family have different devices=2E Either older ones missing =
some devices or have less USB or network ports while newer SoCs have more o=
f those or they have PCIe instead of PCI=2E Modelling these could use plugg=
able sysbus devices so one could add the devices needed for a SoC version w=
ithout having to write or modify a board code=2E I think Bernhard's attempt=
 to try creating e500 SoCs from a device tree goes in that direction too=2E=
 We could also model this by having a SoC that can instantiate devices base=
d on some properties but maybe pluggable devices could be more generic for =
this=2E The issue seems to be how to tell the board or SoC where to map it =
and what IRQ to connect it as this is done by the board and not the device =
so properties on the device to set these does not really help unless the bo=
ard can somehow query it and instantiate the devices based on that=2E Other=
wise whatever handles the -device option to create the device would need kn=
owledge about the board=2E (E=2Eg=2E the e500 devices are mapped in the CCS=
R memory region so one can't just use system address space for them=2E)
>
>IIRC Bernard's series takes a DTB as input and create the machine
>matching this DTB=2E

That's correct=2E It's still on my todo list to send an RFC=2E I first wan=
ted to gain some experience implementing a machine in the classic way which=
 I've now done by means of the imx8mp-evk series=2E Once I clean up the e50=
0-fdt branch I'd send an RFC=2E

Best regards,
Bernhard

>
>As Peter explained, sysbus-platform-bus fits TYPE_DYNAMIC_SYS_BUS_DEVICE
>in free slots, then generates the corresponding ACPI/DTB=2E
>
>What you describe seems closer to the QEMU Dynamic Machine project,
>following Damien's idea:
>https://lore=2Ekernel=2Eorg/qemu-devel/20220223090706=2E4888-1-damien=2Eh=
edde@greensocs=2Ecom/
>We are not quite there yet=2E=2E=2E

