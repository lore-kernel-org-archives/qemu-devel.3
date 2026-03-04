Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E8DEB7EAA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhkG-0006m6-F3; Wed, 04 Mar 2026 03:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxhkA-0006lC-Vx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:38:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxhk9-0005VW-7v
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:38:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so74794255e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772613488; x=1773218288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tA9xqt+1xXwJzMMfESy7xgRSKeTYmRcLBwsJpXqJZoE=;
 b=KXT9rFZuXed/3v7K9t1ML6cpVzyKLbQ/uxaSvMrk7Ujs89u8uZvR/OIshg1tSDIjwb
 xHvp58l0xzxecYnj3H4Iac8LTI11yS5RuNxws/SfslPJ5Cnq2NJ0xjQAuSwi3eQm/m3d
 etNtal0MeILCOoIWdLEANBPpuQYfV5WCxVTmjrUwpvxPWjq4vgSrh4dFCDwT5i/QKPFw
 pnHl+000AelsEPEMZfi3WMjiDv548nVCOiXc9xz9jRat4Upd9MSuAmbjingBlY2fdDdG
 GoG3dajXfWMjT64JKLzIoDb+/Ymf7c6UcI8GbYR+gTud7v4UrKEvaruU0VQamskCPFQ4
 rpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772613488; x=1773218288;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tA9xqt+1xXwJzMMfESy7xgRSKeTYmRcLBwsJpXqJZoE=;
 b=HJKIktH16i7r40uUVWwyexxvKEluTXdoRxubVoxxAnKhj2IMcJvjFnqKBFXNl7tLMM
 Dv0REt7vPYjDF3Pr/sMJZErTAuZNnAKjaoqOiOmzJ7FEWVGCXYiqAqsVG6uH/ggzsLEi
 Wkh04fQneZGXH0jeofAFekY+eeH0LhvB1AAZI4UCeNY6Jr8zuUdLrpNLJn2AZdCisCmj
 TUan4fbijaQU6Va0lNFIpQeB1uBwPnZRr9DJ4CC7yx9kHdiFJoxyZSQUAIv193mPZKwm
 8A8C5UF4wkae/UJ6aolMQ+srez8Se6UBt30P7HdMPMoBXA/ooAod5YPYcVAdCsIJH4ac
 Dbsw==
X-Gm-Message-State: AOJu0YxJ5UVKB8VVO6eIHd3ZR/mmG11eVXR6GH/smzq5hvQVbYzqNPTE
 evRGq17bxRpNiHgyg4T0qzz+xcxN8vVzlpfAQ4+purnebkDK0dK6LxzK
X-Gm-Gg: ATEYQzwFWwudbgayToCwM0hUfoVvS0Hf9Ta4c8WzCsa67uHN/hZSqS7rLPq8/+yQJ2K
 xzJRYx9FWf5OlE65llPd1ywjvjZUflKM/DGnk5hKsCPDpZl2xkk67jfjdGEv+gVhGhvPgvDov24
 Xe+lKKJYSjVBt8kHsv9kKfKAR9fAPA2FSZEfzTVW0Lfs7bu01r6IHr78ocFcObiZdvLvAuT7qKz
 1/vdruIKpYVjlmqWLxbVo+o9CyutucicXYXTKZvi81tyvbhrZn0z1MKEOLw/xFQ1ZQkIhVQkOtG
 h0CDU3D+lc/idXU+uMao8w+gzFIOmE5NDn9hQTdhUdAGoqy5puwAL1IUXtFnEHMoWSo+y+OEyrM
 dvdFFH8x0m6tSil91ooPCuPSpW5lTUL4FBAYW4EJcBXR5wbvjn+fc/P9BbjsmdcU/hiVBfPEQdI
 7ucnLMeDaZ4F+DV36om9SoFURO83C67dmLf0ry2bakPoMAvw2EnS+u9n3wbGLMRp1CTQUAFDLtg
 pVmJTFxL15z1LASI++i5Mk=
X-Received: by 2002:a05:600c:64cf:b0:483:456a:514b with SMTP id
 5b1f17b1804b1-48519854f01mr18086915e9.12.1772613487395; 
 Wed, 04 Mar 2026 00:38:07 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-191-023-054.77.191.pool.telefonica.de. [77.191.23.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851880724esm69825425e9.9.2026.03.04.00.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 00:38:06 -0800 (PST)
Date: Wed, 04 Mar 2026 08:38:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
 <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
Message-ID: <8055A7B6-482C-48A2-BC76-BDCB670CF4DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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



Am 3=2E M=C3=A4rz 2026 22:56:20 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Tue, 3 Mar 2026, Bernhard Beschow wrote:
>> Rather than requiring users of TYPE_SERIAL to initialize the MMIO regio=
n
>> themselves, make it generic enough to be configured via properties=2E T=
his
>> makes TYPE_SERIAL more self-contained and prepares it for being turned
>> into a SysBusDevice=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> include/hw/char/serial-mm=2Eh |  3 --
>> include/hw/char/serial=2Eh    |  4 +-
>> hw/char/diva-gsp=2Ec          |  5 ---
>> hw/char/serial-isa=2Ec        |  1 -
>> hw/char/serial-mm=2Ec         | 51 -------------------------
>> hw/char/serial-pci-multi=2Ec  |  5 ---
>> hw/char/serial-pci=2Ec        |  1 -
>> hw/char/serial=2Ec            | 76 ++++++++++++++++++++++++++++++------=
-
>> 8 files changed, 66 insertions(+), 80 deletions(-)
>>=20
>> diff --git a/include/hw/char/serial-mm=2Eh b/include/hw/char/serial-mm=
=2Eh
>> index 0076bdc061=2E=2E4c18e2a609 100644
>> --- a/include/hw/char/serial-mm=2Eh
>> +++ b/include/hw/char/serial-mm=2Eh
>> @@ -39,9 +39,6 @@ struct SerialMM {
>>     SysBusDevice parent;
>>=20
>>     SerialState serial;
>> -
>> -    uint8_t regshift;
>> -    uint8_t endianness;
>> };
>
>This effectively makes TYPE_SERIAL the same as TYPE_SERIAL_MM so you coul=
d just merge the two and have everything embed a SERIAL_MM device=2E

I've tried having TYPE_SERIAL_MM inherit from the SysBus-TYPE_SERIAL=2E Th=
is resulted in failing migration tests, so I stayed with composition=2E

> But the idea here is to make TYPE_SERIAL a superclass of all serial devi=
ces and SERIAL_MM is the memory mapped version=2E Memory mapped devices are=
 usually SysBusDevices but others are not so this seems to be trying to mod=
el things in the wrong way=2E Maybe you could just add accessor functions t=
o TYPE_SERIAL to get the memory regions and use that from subclasses to avo=
id poking in the state struct and not try to reuse SysBusDevice for this=2E

After ruling out inheritance, adding just accessor methods would basically=
 reinvent SysBusDevice without the benefit of the reset tree=2E

My goal is to rewrite TYPE_SERIAL in Rust which requires it to be accessed=
 only via methods=2E Not Plugging into the reset tree would be an inconveni=
ence I'd like to avoid=2E The rewritten version already works except for mi=
gration=2E I didn't "advertise" this too much in the cover letter since the=
se changes should be useful on their own=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

