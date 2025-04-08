Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD9CC369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2BXA-0004Ue-EK; Tue, 08 Apr 2025 12:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u2BWb-0004Fl-WC
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 12:10:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u2BWX-0007wu-D5
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 12:10:09 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so5931829a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744128600; x=1744733400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=sTapBk4AAeOWrnKgn8nJ6aF1Z70mI8HM7+Dc8fd8z2w=;
 b=cFaJO81wPX8ng28kxs7tVLIU/VlfCMsdgZ5AwpbHnyoFV+Ulz8209VSCevyIBJSWQo
 qAMt5YyMuICqXn8Wj5CMBpeL3/gme0cJVudV1CmcOqB9lAXPYk14r2LasR/2bK9aPmir
 DAatX1Z9RyDX+fJtJITQqrGz5MIzNJIqq1pK1YW7AvbAYn33pmPren56QLaJZ2yJczKY
 HGRDFXJmliz5mFaYxtRaHcimzLLEnc1K0AQxW6z77c8vVLdqKoN6FJRnaRUSWx9PcYL3
 jTEGULulnmmBDB+20JqBNpoiuXmMArr2bLvmN+kjyIGo+LX8paiNlqBIqhA2KuwctKRA
 HRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744128600; x=1744733400;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTapBk4AAeOWrnKgn8nJ6aF1Z70mI8HM7+Dc8fd8z2w=;
 b=dx4P3UVYJsVp6S4C+M5Vzh2bo36MA9LIRgxEKehAvJCmD2QBruizi1h4HPeG8JraW+
 omNBT2ehVuk05OoHnRhvYufDk7120K0YbcyMw00xk5rwFmYENagwnkKANICUbjM9JcZl
 HQo2//tZTMTF91SN2MOjbylc4TpCD04YVY70hDDY154A5WVqSePui35i2wU64WWy9Zmj
 1f3/Z35slbbNbdAPxh+b0/as8LkBlEHmtjgUs6WQ9r3X3MXt+BS4ZUOFpSZkMNF/+iql
 XIRbw1SPkT+P5GotHt40OO4YR8MP7ugroF9LnTra5hTsp/Xol9dNdJ5MqWk1s4P95wHX
 bs+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrCSQZqPVo45YiQe2t8sAEzWVz3ROJc6IAIaXH+o1g3TfQlVKdTYh7zKfgWhLMO4PzxC3Xx/BD5z0c@nongnu.org
X-Gm-Message-State: AOJu0YzNUQmOe6GY6CPIr2Nhg5SAoqd5xxGElV8asy0m/xqhi3KwPB2a
 /XgEcb38/hOJJg5HxJS8XBslaZKFaI69Q24aRr4WlyWkancrQjZfgvPHuA==
X-Gm-Gg: ASbGncsovrokVIzaNYgaOgI4p986APIm6hqe1w4GrlZwml/oXepbJpr2uHdcbTRo4BI
 pqGgkCDYzJEavM9fn5yR80AW/T3NjOxFs4RK/2SvZ8scUlNqWWRxNSQvS+pkG5rm/Lk0/r0TMxT
 OcZWwDP4bPpOZTRleKHZXsJQGpz4Vw1ORVKyZcjvWjMu6PslZofA4j4QeOXFnGMFEdFS54wLMyp
 vk5PoqSJGMB0/aiL5wZAh+ZODiI24LWgMGPLw0djhKDP/mKfjusAsLbw58ZNYR/vQh1oAMJw9+/
 ue75I+f3ZmMIHi7bRe/X4Asf1+29ztpqfOZS7lbGXMvA2jzU+BE8LgO6+HgxjwBJ7KHKrvsWaGJ
 eZ8BOLZ5ivMraAlJMdg==
X-Google-Smtp-Source: AGHT+IFSi287KIkeXU2GWBmT/qQGS4Ze0eGyEs2Eeoshq2HgqjnzaZ9z5StK05AKuX8sQKxGz4sAxw==
X-Received: by 2002:a17:90b:280e:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-306a48b391emr26166147a91.33.1744128600181; 
 Tue, 08 Apr 2025 09:10:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3058466dc0bsm11079578a91.15.2025.04.08.09.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 09:09:59 -0700 (PDT)
Message-ID: <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
Date: Tue, 8 Apr 2025 09:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/6/25 11:08, Bernhard Beschow wrote:
[ .. ]

>>> Yeah, it works with Buildroot as described in the handbook. When I append `-netdev user,id=net0 -device virtio-net-pci,netdev=net0` on the cli I can `wget http://www.google.com` successfully. When I omit it there is no network connectivity. This is with a 6.6.23 vendor kernel.
>>>
>>
>> I had no luck with virtio-net-pci. virtio-pci works for me, but I can not get real PCI devices
>> (such as nvme or scsi adapters) to work.
> 
> I now tested with the latest Buildroot recipe, changing to upstream kernel version 6.14 and using the defconfig. The `wget` command still works for me with virtio-net-pci. However, I can confirm that I need your xhci patches for the usb storage device to be detected.
> 

Following up on this, my problem is that adding "-netdev user,id=net0 -device virtio-net-pci,netdev=net0"
to the command line adds a _second_ Ethernet interface, in addition to the default one.
This results in
	qemu-system-arm: warning: nic imx.enet.0 has no peer
reported when qemu starts.

I can not get that second interface to work, probably because of some userspace issue.

Anyway, I never see any interrupts on the virtual PCI interface. From /proc/interrupts:

277:          0  PCI-MSI 524288 Edge      virtio0-config
278:          0  PCI-MSI 524289 Edge      virtio0-input.0
279:          0  PCI-MSI 524290 Edge      virtio0-output.0

That may work for virtio-net-pci, but it doesn't work for other PCI(e) drivers.
If I try to attach any other PCIe devices, the device is reported with lspci but
then its initialization times out because it does not get any interrupts.

Tt turns out that sabrelite has the same problem.

Please let me know if you have an idea how to get the interrupts to work.

Thanks,
Guenter


