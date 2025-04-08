Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D752FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 21:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Gvq-00052Y-Sw; Tue, 08 Apr 2025 17:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2Gvo-00051x-Ie
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:56:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2Gvm-00084j-RS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:56:32 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e61da95244so10036074a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744149389; x=1744754189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D/nuzWKWmKyfPyXTbT4MWTi34k7JjeQfu+8a4pzxiE=;
 b=FCJmwna6x7bYtbvmm9Uuf5jU9GqElE2E/cyXn5YRuAY2PjkjMt+EcxWYuboF6bscdI
 z4V0RsNzvOq9NwQXBqNJ0CyS188xkYrmmtmRMk2mxdfW/N+jFN26ufmqIaASc3QbNe2h
 W7kEP2TyEWwnksYDqGz1PdQAglK0XseSRaTkYHAsihgfLtq/RoRfEMpx4muO12hphtWX
 J+qL1ZbjtFdxGaDdtLeCQglrSkek2707pczr0e9Dud2BmgOa/TqCqbIvGNrMTkGdusmw
 qLeW6kJXvUXlYRpvyaqRPkC+L2jASQKmLiUZ0HFunDF2yDDF3//P37ocACpGViDpmXzE
 2dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744149389; x=1744754189;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3D/nuzWKWmKyfPyXTbT4MWTi34k7JjeQfu+8a4pzxiE=;
 b=IeSfs6J7WhlK2bigA5ybllBjEIJZFrGPmRR2ABPNz66cihSMXggrIyt3rAwgnNnmVU
 5S99QG+1+BxHtDODUVqYZCGGNpHa2/rYb6vXZCTgFqRe4Af/HYUpJepzHRJkKEQHAqjK
 W5Vqb+jHkP3I9HAyEfeShiMD5gUeliLo/JEnJ9EMzqRNp0HQF6fg+1P2RB2VpraXXQT0
 UG/9SZBQ40WfpOzAlpuTnQKkE62fujKiLsgQRVDlRpXsaDNwPNSLjn3f4xMyQSsyYbdx
 EBplsIuGj7bH4FN4zIEDUDX8PrSGIJkBZVEGJ8MUI0O4cHn82jshQP3fSTn5uNfOQ8j4
 SQjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnnyKahLyIlQotbO43U1fC3Lb1Pva/ZYcGpxV7xxjG3H5wh4m5Xyi/mGOGmShLwlkRMn3PKmmvXo8R@nongnu.org
X-Gm-Message-State: AOJu0YxHkQd1I0Ar3pRHnMhnyriQaLWScsqGVPt4NOA3Q+4xwt6ve8vs
 yO5szAcE7fgmggMS7wPVpQHFNRHM0XQdAsDb7Zs/xjXoLmDMPszW
X-Gm-Gg: ASbGncsGvw0zdhMCpwHFWMMqmHL/VPOsOpD3yX1BYf+ZxX5xD22Ry/DEQcaeOdLQyxq
 I1pJiQOxXyFUm32dRFxK5GpxqXjl9iCAv6Ihl6eWhBNr+Ts4lQOzpHDpLpzjrvr/d/1C3MWekRD
 euRDBKvsSaE0aqwd2ufWliNuGjh2mxl6yZngCofYHchhdnxUaUCy2rCf+s/MDgzpnfFLfbATcFI
 A+eSvUxDLj6f8XDneyVI1z/o9uGCd3ffrWfWb4R9kiQtbfPwq3b+Fwgp66nl8DXJ9zKJ1nSHty3
 1hoBC8OBH7Su/ze5lWfRi4dzPOi9ZfcE6rfCdwvACCytLXdw4fmy7Km03Ysaz3uhkiq5hdxqean
 xchT73zM4V/2fIUApenHN3ju84by0eyAAiSRTsOGrPhKs2VrxiLS0
X-Google-Smtp-Source: AGHT+IFZB4NwDjR17ln8ZzDO+vEdBuRbIiM/sJFo9Q/+R29FvU7sccNY5ndskfGbMMU23Hvzhx7AEQ==
X-Received: by 2002:a17:907:7293:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-aca9d728cd2mr22694466b.59.1744149388092; 
 Tue, 08 Apr 2025 14:56:28 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfee5966sm974885966b.82.2025.04.08.14.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 14:56:27 -0700 (PDT)
Date: Tue, 08 Apr 2025 21:56:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <3b0367ca-7242-4555-a6b2-ddf546374138@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
 <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
 <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
 <3b0367ca-7242-4555-a6b2-ddf546374138@roeck-us.net>
Message-ID: <A3422A32-92AB-4D53-A53F-DD9D0FD5C1EE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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



Am 8=2E April 2025 20:31:58 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On 4/8/25 12:57, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 8=2E April 2025 16:09:58 UTC schrieb Guenter Roeck <linux@roeck-us=
=2Enet>:
>>> On 4/6/25 11:08, Bernhard Beschow wrote:
>>> [ =2E=2E ]
>>>=20
>>>>>> Yeah, it works with Buildroot as described in the handbook=2E When =
I append `-netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0` on t=
he cli I can `wget http://www=2Egoogle=2Ecom` successfully=2E When I omit i=
t there is no network connectivity=2E This is with a 6=2E6=2E23 vendor kern=
el=2E
>>>>>>=20
>>>>>=20
>>>>> I had no luck with virtio-net-pci=2E virtio-pci works for me, but I =
can not get real PCI devices
>>>>> (such as nvme or scsi adapters) to work=2E
>>>>=20
>>>> I now tested with the latest Buildroot recipe, changing to upstream k=
ernel version 6=2E14 and using the defconfig=2E The `wget` command still wo=
rks for me with virtio-net-pci=2E However, I can confirm that I need your x=
hci patches for the usb storage device to be detected=2E
>>>>=20
>>>=20
>>> Following up on this, my problem is that adding "-netdev user,id=3Dnet=
0 -device virtio-net-pci,netdev=3Dnet0"
>>> to the command line adds a _second_ Ethernet interface, in addition to=
 the default one=2E
>>> This results in
>>> 	qemu-system-arm: warning: nic imx=2Eenet=2E0 has no peer
>>> reported when qemu starts=2E
>>=20
>> I get this too when using virtio-net-pci successfully=2E
>>=20
>>>=20
>>> I can not get that second interface to work, probably because of some =
userspace issue=2E
>>>=20
>>> Anyway, I never see any interrupts on the virtual PCI interface=2E Fro=
m /proc/interrupts:
>>>=20
>>> 277:          0  PCI-MSI 524288 Edge      virtio0-config
>>> 278:          0  PCI-MSI 524289 Edge      virtio0-input=2E0
>>> 279:          0  PCI-MSI 524290 Edge      virtio0-output=2E0
>>=20
>> I get:
>>=20
>> 206:          0          0          0          0  PCI-MSI 524288 Edge  =
    virtio0-config
>> 207:          3          0          0          0  PCI-MSI 524289 Edge  =
    virtio0-input=2E0
>> 208:          8          0          0          0  PCI-MSI 524290 Edge  =
    virtio0-output=2E0
>>=20
>> Note that I'm using four CPUs, i=2Ee=2E `-smp 4`=2E
>>=20
>
>I must be missing something=2E Can you send me your complete qemu command=
 line ?
>I'll also try building a buildroot image to see where it gets me=2E

Will send you tomorrow=2E

>
>>>=20
>>> That may work for virtio-net-pci, but it doesn't work for other PCI(e)=
 drivers=2E
>>> If I try to attach any other PCIe devices, the device is reported with=
 lspci but
>>> then its initialization times out because it does not get any interrup=
ts=2E
>>=20
>> Indeed, trying with e1000e:
>>=20
>> 205:          0          0          0          0  PCI-MSI   0 Edge     =
 PCIe PME
>> 206:         74          0          0          0  PCI-MSI 524288 Edge  =
    eth1-rx-0
>> 207:         20          0          0          0  PCI-MSI 524289 Edge  =
    eth1-tx-0
>> 208:         32          0          0          0  PCI-MSI 524290 Edge  =
    eth1
>>=20
>> But I get this repeatedly with varying CPUs:
>>=20
>> [   14=2E657163] e1000e 0000:01:00=2E0 eth1: NIC Link is Up 1000 Mbps F=
ull Duplex, Flow Control: Rx/Tx
>> [   19=2E980452] e1000e 0000:01:00=2E0 eth1: NETDEV WATCHDOG: CPU: 0: t=
ransmit queue 0 timed out 5312 ms
>> [   19=2E982491] e1000e 0000:01:00=2E0 eth1: Reset adapter unexpectedly
>>=20
>>>=20
>>> Tt turns out that sabrelite has the same problem=2E
>>=20
>> Did it work with QEMU 9=2E2?
>>=20
>
>No, the pcie interfaces on sabrelite don't instantiate for me with qemu 9=
=2E2 (9=2E2=2E3,
>more specifically)=2E I see the pcie root port, but nothing behind it=2E

You need to add `bus=3Ddw-pcie` to the pci devices' options in QEMU 9=2E2=
=2Ex and earler, otherwise it will end up on the wrong bus=2E This is fixed=
 in master=2E

Best regards,
Bernhard

>
>Guenter
>

