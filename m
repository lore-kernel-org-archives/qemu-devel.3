Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E334C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcthA-0001ti-2f; Tue, 28 Jan 2025 17:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctgv-0001r1-9G; Tue, 28 Jan 2025 17:04:17 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctgr-0003xa-RP; Tue, 28 Jan 2025 17:04:16 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dc10fe4e62so11647197a12.1; 
 Tue, 28 Jan 2025 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738101850; x=1738706650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuGyuN9SnUjh2crkIjE0gAGw4/S/C50O6CaHRBPgFmE=;
 b=H5AJxnbAhSEAwm8O/OepxNwN9UCZ4RAVVS/ms+vyWqjPLcIDSI1syZU6aGZNcfOcCM
 xGmkF1okjyP7cawuQGeh7JnL5258pGUBKjXNerRdpzyioddKA7krPHZP+KoXBrbVCIr/
 mZDy32HjYGCzF0o6kXjuuw4PdefHURG0oBD/M4h5r/Ec7NzHgP2dl5jZGedZ4THYJKlT
 5mfcL10WJmoyIpvYx/ANuseWgF8U1ycmH//I/aIWtyvqElKVJohL3LAjIouLPh/4RwgW
 o7iWkNfuoz0h15vTXkbj9XHUkVIxJmdV4nqocFIG8lt3sff4IJONwF4pg4VkhuqHo+B2
 CMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738101850; x=1738706650;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuGyuN9SnUjh2crkIjE0gAGw4/S/C50O6CaHRBPgFmE=;
 b=I5W6FGiyrO4ntnttalmRXpkAkPElhxFldddKYNj11UKP560Mmnv0az8pv4spYiUove
 X8RGfh2IDykk2uE6T+Mr5wm5DAL4K5XAnNFG6/xGuOjv2iQzW04CTfc0QoD925CW3R1R
 SUkq5VHOXNraIyjjmw4rXgHl2j8xfE58dCy3B2HYFNeghfSEZqjewGKqBVIeM5nlj+F7
 VJNWeudQzrXW0g4NNXsQvT383zwhR/YN5/yQYg086x4MpISbXrnN+zcE0/iUotjrb6qI
 2hShv3VhN5wdkfSbytK8fBAu9U1P0flpvVYsP6B9S8R/2Yv2XBP75t/u3+gZrsdJ0cuO
 CZiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzTCO+cTH7OrNZ0JLtd9JzcHOqOyjJ+XJNsdL79/BS3tVttvBumrRCqUXR0Z8QBje3wSMuXHQyYw==@nongnu.org
X-Gm-Message-State: AOJu0Yxews4Uu8R7NrNLM6n5na8NhygCxrVmA98qn3CwF3JN6a3+XUMX
 mJqS5ZjByOGth3y+bmcmkjmWgQnMBguezuHlzJl9GIVTsKSKvR9oys6+lQ==
X-Gm-Gg: ASbGncvUq8FA7DKtNzwaqJXhVTYzL02jAxav7BgrX/PgHNTAhjbqUP5cb3bLV0c9CLL
 tyN2AW63WBtgMyJgtKnnQxwIwxwFlSGPk3jL7oTDKBYElDwryDDZTmEtAXeWpP7l1mLrWPvzMu0
 ld+h7B9Cy+4Ut5V8aB9MiB8nfyWF1R7qkTu7ltyQnX+3L86lKwNjLHSVYE0jYkfTu+01FetRtvd
 ibQiH8QBYeaelz+2h0pQTzwUdAvJ1cj/4dhp740P5/o4XpeZwMmKlJq1hDaUpXiYtPy1JTVLu4K
 K7o978GZHQ9yxE0Oi5bl809liL/B/xFoQJ/3w70txu4Pmh/twyrjuXrSpwpRqWLQ
X-Google-Smtp-Source: AGHT+IHdfxyO0g3BoX8ePLnngW/h90/cYja/L4mhtjWNrRj/bSVSLlSiUQLlIk2SMsv+zsryYi8kQg==
X-Received: by 2002:a05:6402:13ce:b0:5da:9d4:ad6 with SMTP id
 4fb4d7f45d1cf-5dc5effb09bmr549712a12.28.1738101850231; 
 Tue, 28 Jan 2025 14:04:10 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-042-254.89.12.pool.telefonica.de.
 [89.12.42.254]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc18628d00sm7899905a12.27.2025.01.28.14.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 14:04:09 -0800 (PST)
Date: Tue, 28 Jan 2025 22:04:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 09/21] hw/arm/fsl-imx8mp: Add PCIe support
In-Reply-To: <CAFEAcA9efWMDxaTCfa6t8MiCgFUEU+nsyurNOqVDxAa9=KS=-Q@mail.gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-10-shentey@gmail.com>
 <CAFEAcA9efWMDxaTCfa6t8MiCgFUEU+nsyurNOqVDxAa9=KS=-Q@mail.gmail.com>
Message-ID: <137C0579-19AB-4D92-82DC-6CBE2422AD6A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



Am 28=2E Januar 2025 14:33:14 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> Linux checks for the PLLs in the PHY to be locked, so implement a model
>> emulating that=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>> diff --git a/docs/system/arm/imx8mp-evk=2Erst b/docs/system/arm/imx8mp-=
evk=2Erst
>> index 1514bc5864=2E=2E8d48580cb4 100644
>> --- a/docs/system/arm/imx8mp-evk=2Erst
>> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> @@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following d=
evices:
>>   * Generic Interrupt Controller (GICv3)
>>   * 4 UARTs
>>   * 3 USDHC Storage Controllers
>> + * 1 Designware PCI Express Controller
>>   * Secure Non-Volatile Storage (SNVS) including an RTC
>>   * Clock Tree
>>
>> @@ -62,3 +63,15 @@ Now that everything is prepared the newly built imag=
e can be run in the QEMU
>>        -dtb imx8mp-evk-patched=2Edtb \
>>        -append "root=3D/dev/mmcblk2p2" \
>>        -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmc=
blk2
>> +
>> +Using PCI Devices
>> +-----------------
>> +
>> +The PCI Express controller spawns two PCI buses, of which only one can=
 be used=2E
>> +By default QEMU assigns the wrong bus, so the correct one has to be sp=
ecified
>> +manually by adding ``bus=3Ddw-pcie``=2E For example, when adding an In=
tel e1000
>> +network card, the command line looks like:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ qemu-system-aarch64 -M imximp-evk =2E=2E=2E -device virtio-net-pci=
,bus=3Ddw-pcie
>
>Why does this happen? Isn't there some way to make QEMU default to
>using the right bus? Otherwise there's likely to be a lot of
>user confusion because PCI "doesn't work"=2E=2E=2E

Yeah, this is really confusing and I forget about it myself=2E I'd appreci=
ate any hints here=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

