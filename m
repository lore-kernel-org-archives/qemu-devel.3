Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC1BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 19:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2F4n-0006qy-6d; Tue, 08 Apr 2025 15:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2F4l-0006pJ-50
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:57:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2F4h-0003Ob-Vh
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:57:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso1031115066b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744142254; x=1744747054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+51kSVBffFuIunORvKgylrGnq44R958ERVRY+AgGKs=;
 b=B0AqAP5WompS8dDuZbtZeVewvdj0QXe2iJw83zI1JQESzCVk3HD23GUrSM3rGRkBaR
 GvShmfRxASGUIIHrprPS4DdQSTY1vrTjpRcF5d+BxIFyCXMmNRBIA3YPxNvIfR4/P4J/
 oCYyssLdFVZ4ahjkgEIXeAeNK1oHafbeFbRpC/Bwzh/rKUHM7lRKIfUXdQzC8YY0goK3
 oyCLJfBAitYkcsJm/J+OT9VSVVDeWPneK9aptWG+vBtgJwnYhfX1Ww+cQ0QXho3B1Jlh
 WCD3nhf6AIyTFnMenOL653hrhzKEo9cU9LBrB8ydjZ0OZ1CtfYsYgNq4ZrZfbPG4vWd9
 abOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744142254; x=1744747054;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+51kSVBffFuIunORvKgylrGnq44R958ERVRY+AgGKs=;
 b=oUPECk97vsioJCqiBGJwfiv915p5ahVrUrb2ijkz4Zie3at2YaNZrIGo0XC3MhuLiz
 lQQk9dclkWXOid1MF3G0QJkCLC9SXRkpS9frlJYfGtdvqnq2jfGfUHQtSezMzqhDL6px
 xYO7FAgFNm7/cs60t8i5Apt1oNy2WPnHwzJAjs81VGHJdp30NrMKznoSzewHfLhCh2Bn
 DBFnVuNfhWH6lHxHmASXscaTDFFqM2BMPHGcvDUTaZ4sAVe8yM6t58iuLT9WKcsIyIX9
 SAUdk1eKbNEB/RPET9yj6eKbHTs1oZD9YDs1eP7u7yP5HFOMrp+rFIGqTZvCZp6a7COM
 U6NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVPkSBwF454gCNLfQvVBboMQuBvesMOCitPav+RC9MaNikoZDHBAsOf9QYBO0Qf2ikVWIfynVYN6L8@nongnu.org
X-Gm-Message-State: AOJu0YxSgKji2/lV71KIJgkqlqabEPTuAg1Sr6vDpf/ujQ2gMDbVRYji
 /EaIQ31tMImJpYFcq2st+yOCFEpK8C3pFhiXodhsBTLIeVUShkbd
X-Gm-Gg: ASbGncthmyN9Jai7JdghNdatpmtou0qDvi4zp2513E8yngCqbOzZTBNyzqPgXMzXXRr
 Gm5po7qyGnISXE5Nm6f7VQsusJKPAA6p2yb4U1KeTlf4yIu5/c75e9410fYwV3wg8O9AxR72N+v
 SMyxVQ/3uv/C7lOqT1klcqayPp1ialXOkAGPN71JyFFhwG1mDKZcpvxoxGOmyY6RHZLlhy1eE/4
 ZFRJQukUOGQ7axAcwXU2nfGPqtpLPp/0QV/LEWSSCTMXZb0wnvu2WhV83gn7GimC24sJT0TwCvK
 hFYsAs7Nzqtj2vKpGylsI1k02Gn/At3ycxuwOvr4gHXm3PJPF9s+PhwMZHgIEGDZzjF9oDBi2Zb
 xl1lJYI1qhAaCiECKyfHEDACESjA1F9yoUf6yOXwLF/uMrNACAyAxxfp3rRPO2mY=
X-Google-Smtp-Source: AGHT+IGmps39MfLtOJkefx3BYz3FDWVlo+/OSkBsBx/Fv3tm+mc7ojsM0ge+LfCiV5dOFyNjMnd5Ew==
X-Received: by 2002:a17:907:3da7:b0:ac7:b47d:ca0e with SMTP id
 a640c23a62f3a-aca9b734e8fmr39449966b.57.1744142253576; 
 Tue, 08 Apr 2025 12:57:33 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c01862e7sm970469366b.139.2025.04.08.12.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 12:57:33 -0700 (PDT)
Date: Tue, 08 Apr 2025 19:57:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
 <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
Message-ID: <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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



Am 8=2E April 2025 16:09:58 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On 4/6/25 11:08, Bernhard Beschow wrote:
>[ =2E=2E ]
>
>>>> Yeah, it works with Buildroot as described in the handbook=2E When I =
append `-netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0` on the=
 cli I can `wget http://www=2Egoogle=2Ecom` successfully=2E When I omit it =
there is no network connectivity=2E This is with a 6=2E6=2E23 vendor kernel=
=2E
>>>>=20
>>>=20
>>> I had no luck with virtio-net-pci=2E virtio-pci works for me, but I ca=
n not get real PCI devices
>>> (such as nvme or scsi adapters) to work=2E
>>=20
>> I now tested with the latest Buildroot recipe, changing to upstream ker=
nel version 6=2E14 and using the defconfig=2E The `wget` command still work=
s for me with virtio-net-pci=2E However, I can confirm that I need your xhc=
i patches for the usb storage device to be detected=2E
>>=20
>
>Following up on this, my problem is that adding "-netdev user,id=3Dnet0 -=
device virtio-net-pci,netdev=3Dnet0"
>to the command line adds a _second_ Ethernet interface, in addition to th=
e default one=2E
>This results in
>	qemu-system-arm: warning: nic imx=2Eenet=2E0 has no peer
>reported when qemu starts=2E

I get this too when using virtio-net-pci successfully=2E

>
>I can not get that second interface to work, probably because of some use=
rspace issue=2E
>
>Anyway, I never see any interrupts on the virtual PCI interface=2E From /=
proc/interrupts:
>
>277:          0  PCI-MSI 524288 Edge      virtio0-config
>278:          0  PCI-MSI 524289 Edge      virtio0-input=2E0
>279:          0  PCI-MSI 524290 Edge      virtio0-output=2E0

I get:

206:          0          0          0          0  PCI-MSI 524288 Edge     =
 virtio0-config
207:          3          0          0          0  PCI-MSI 524289 Edge     =
 virtio0-input=2E0
208:          8          0          0          0  PCI-MSI 524290 Edge     =
 virtio0-output=2E0

Note that I'm using four CPUs, i=2Ee=2E `-smp 4`=2E

>
>That may work for virtio-net-pci, but it doesn't work for other PCI(e) dr=
ivers=2E
>If I try to attach any other PCIe devices, the device is reported with ls=
pci but
>then its initialization times out because it does not get any interrupts=
=2E

Indeed, trying with e1000e:

205:          0          0          0          0  PCI-MSI   0 Edge      PC=
Ie PME
206:         74          0          0          0  PCI-MSI 524288 Edge     =
 eth1-rx-0
207:         20          0          0          0  PCI-MSI 524289 Edge     =
 eth1-tx-0
208:         32          0          0          0  PCI-MSI 524290 Edge     =
 eth1

But I get this repeatedly with varying CPUs:

[   14=2E657163] e1000e 0000:01:00=2E0 eth1: NIC Link is Up 1000 Mbps Full=
 Duplex, Flow Control: Rx/Tx
[   19=2E980452] e1000e 0000:01:00=2E0 eth1: NETDEV WATCHDOG: CPU: 0: tran=
smit queue 0 timed out 5312 ms
[   19=2E982491] e1000e 0000:01:00=2E0 eth1: Reset adapter unexpectedly

>
>Tt turns out that sabrelite has the same problem=2E

Did it work with QEMU 9=2E2?

Best regards,
Bernhard

>
>Please let me know if you have an idea how to get the interrupts to work=
=2E
>
>Thanks,
>Guenter
>

