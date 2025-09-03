Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF0ACA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utu67-0007pQ-Mv; Wed, 03 Sep 2025 16:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1utu64-0007oQ-BU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:28:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1utu61-0000Ro-JA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:28:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ce4ed7a73fso205391f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756931320; x=1757536120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyPTj8le1xKi08UwG7NQiJcWa3VqGVJ9r2/9tfhAov8=;
 b=hjJH9Sj2Q2jtGx5Q5+Z/3kBk+Qcfmv+mCHD5ZBjikWwHq2vHzQdPnQp+55QYmI/dy5
 szVWLRADv7jsyvVX+CxcgmXCEkG7C54N1wEGpLUosmwvQ5LX5Jwjf9zWDYu5tnYVuOm9
 /BsvNO1UoyXNbtIn95UtnQ6cH7oK3spgZoIr84tplc/e9QwIDyJR19Yu9iWcDV2lhysV
 ZFB6/WmbUOgxgIuxFlf7auXaaJfqdqEFjajhDZqKPGMdXH07wwS8drIbrJ7E7ySJ7/jM
 K4y1/xAPDqi928cZTzFBLoZmC4uHER+iFou15ClPIDsj7Ky/rwgpUUpf3uUZRcjyftfc
 LXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756931320; x=1757536120;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyPTj8le1xKi08UwG7NQiJcWa3VqGVJ9r2/9tfhAov8=;
 b=g6otkcl6ANTvWgWLHaR3DAEy2PJOhS2CZv9noxhcU9ChwTcGVh9DL5v6warI8Le/l5
 IigS5USCzvOJX1BY+NuxUoKw8gxotbJHohnbrKsKJrAWywLzDEQftbjCS6zlfKXUNkx7
 BuV6d+1e1VSRQORPkKjxo9gWw+UWq/BI6/P6YyG/Ux+kqQ399zodWdGgtmB44CSXLKWT
 /e6fdNvGgpPbIncATUhBngd1Zaqv0ne6Xa8utWaG3jJJYKsNj4XWq5uVYB0I6VvhFHEt
 auo/eSgVGECJHNIoH/7kD9kdvb984dxL+dCBAxwkXC2Z7pNTkP9hWkwEl3fQTFWF72kq
 3DhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwuvAi9bDbEa619xUX8Tmp45NaOCjyhzCpWfX/L0TCVFYLB2r8s2y6JMx3fSy8iCQSZDmzzWPGfRaE@nongnu.org
X-Gm-Message-State: AOJu0YzxGNXjwRay9d0d8tacj/0lUQD/Je6KG7Ag4jkZwzflgKCScDGX
 J0EvLrOF1/XxHkR6aJ7Vm8SNhOHXvXWxiosIj330jgTTvKC6RfV8jHq8DyNyHAkN
X-Gm-Gg: ASbGnct3BWrzFurRw4W0qLwDmrD4UZrLJl53slanauEl2qZnC5/DboWig+QsRmAiDYF
 0HzN1Di61pOwrZ4Ii7PIGHeBLlYjH4FvKYJ22veTkMoh5p6UudNMBNh8IY6Qo9GRe4Y4jjt9Mp/
 9+xAfDXBb9EZEnR3wTrutzbLCDMCozjUQ+v8CLO0y/XTfalvW/Cksu6+S5MheCN05yBNcbnX41d
 DoKnFHZYJ0iuxMBvha4RbPLFWOxjTf28ivJoHePbd527bm1Yzb7X7e2Gj8WallWaLs8DS30cVhC
 4jcL6ESIFhjjySmtnPwxJ+Mt0IW0XhTIW9pxWZNY82e7ZnAPcB1VcOYY/U8yWxnckEK15yaAx7E
 mmCbyx9n8GrGqbRuAV+eKcGp7JFGWwPulErszCW+eU6oICPCkcISaD/yj+YlrwtkKmrPpi3kRF+
 g9hZsLjg==
X-Google-Smtp-Source: AGHT+IFXwpaXYh7oToq476qUF4+bM0j4/tGdPP7k9YEWxEvDNC/nS1bhx55HAj0a/mBLjx11oIzQYg==
X-Received: by 2002:a5d:5f53:0:b0:3d7:618b:293c with SMTP id
 ffacd0b85a97d-3d7618b324fmr7978730f8f.16.1756931320217; 
 Wed, 03 Sep 2025 13:28:40 -0700 (PDT)
Received: from ehlo.thunderbird.net (93-32-120-59.ip33.fastwebnet.it.
 [93.32.120.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fbb3cdsm8532983f8f.51.2025.09.03.13.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 13:28:39 -0700 (PDT)
Date: Wed, 03 Sep 2025 20:28:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU devel <qemu-devel@nongnu.org>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_hw/pci-host/bonito=3A?=
 =?US-ASCII?Q?_Improve_various_emulation_functions?=
In-Reply-To: <a4918aba-bb20-4d21-8f72-eaf0329dd508@app.fastmail.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <a972b6c1-5e66-41a9-b3ae-094fd98d6388@app.fastmail.com>
 <a4918aba-bb20-4d21-8f72-eaf0329dd508@app.fastmail.com>
Message-ID: <92B146B5-A437-44BD-83CC-CCDAEA265902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
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



Am 3=2E September 2025 05:34:18 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@fly=
goat=2Ecom>:
>
>
>=E5=9C=A82025=E5=B9=B47=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=
=E5=8D=883:09=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
>> =E5=9C=A82025=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=
=E5=8D=883:46=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
>>> Hi all,
>>>
>>> This series addressed a couple of missing Bonito functionalities
>>> I found when I was trying to test NetBSD against QEMU=2E
>>>
>>> Please review=2E
>>
>> Another ping :-)
>
>Ping :-)

Maybe we can then also apply https://lore=2Ekernel=2Eorg/qemu-devel/202301=
05154440=2E259361-1-shentey@gmail=2Ecom ?

Best regards,
Bernhard

>
>>
>> Thanks
>> Jiaxun
>>
>>>
>>> Thanks
>>> Jiaxun
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>>> ---
>>> Jiaxun Yang (5):
>>>       hw/pci-host/bonito: Implement ICU
>>>       hw/pci-host/bonito: Implement PCIMAP register
>>>       hw/pci-host/bonito: Implement DMA address translation
>>>       hw/pci-host/bonito: Rework PCI config space accessor
>>>       hw/pci-host/bonito: Add comments about documentation
>>>
>>>  hw/pci-host/bonito=2Ec     | 453 +++++++++++++++++++++++++++++-------=
-----------
>>>  hw/pci-host/trace-events |   3 -
>>>  2 files changed, 284 insertions(+), 172 deletions(-)
>>> ---
>>> base-commit: c5e2c4042e3c50b96cc5eaa9683325c5a96913b0
>>> change-id: 20250507-bonito-482759b2b52f
>>>
>>> Best regards,
>>> --=20
>>> Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>>
>> --=20
>> - Jiaxun
>

