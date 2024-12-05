Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE0AE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAMv-0007yb-6J; Thu, 05 Dec 2024 06:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJAMt-0007xG-Ky; Thu, 05 Dec 2024 06:50:03 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJAMr-0006e3-7k; Thu, 05 Dec 2024 06:50:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1226902f8f.1; 
 Thu, 05 Dec 2024 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733399398; x=1734004198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHGgnDUDFqP29QAfgrUhZbjEZRlc0GfwQoBy29KuvPI=;
 b=SUj24MZQygiMAZU8vVxDkniotzkQBEeGTIkNLL39QZgj627vqdlQJuDwa+T6HABsMO
 BqK+HwfkuoFfsxBbGCKoNpYoxzlaApjkUmKAAdFdGipzwdrKdd/QdUEowzLE5nMG4bXm
 uZAFu21MwXr//nNso1CHONFLJmyAilPDssixRn7ueyiDs0tFd8R05Cb89miwP3ynZCZp
 q2nsfzDhg2RgSoR+paZTlhvfAPWcZdJdLAixF/X9afqPTRhs8Fd26YTV/CGHrIkZqXDi
 6qAtOcWLr+pW9zfydYBcIFHlLbywUQP7t+GI0xaQgqUj1fiETeHVFLnI47kBoUfKCnAM
 /7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733399398; x=1734004198;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHGgnDUDFqP29QAfgrUhZbjEZRlc0GfwQoBy29KuvPI=;
 b=SgGLn4aZHguRpwS6CFIfb9eKvGie60fKg0lU5DgYoc2Q4GWc3HAC4pvadQwfJKnxaA
 HDJyu7tKMEP7yW6rjktuA4LLbHwsbLtt6OMTpcuUq0sbWYFVxfX3AHob7Up9a+2+sS0C
 erU9ny7yhgUnzIfLiE0UzTJSHuBOxujDqahyZ+BwYhzbWZBrZkx4T8yhDlDWX4gkU1+M
 YgDkRWXOXA1/iGS2fFFQN2RIETI4rQu/nghNFrGZUZPBBQu5/StKm28AhZfcdS4DGquh
 cwOQL5+Ryo8yMuWwiGpG+8kxBjq6ro8BYQcgkbTny5BfoSJ4pxU2L1SzHSzNUthW6xd5
 4egw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLehLQ8pVLmtlPLHqE1xwSl7Xbc7ynqQq6/fU9YiGXENzRNcxlfBdH7ivf8VAqOhwTgmFJqWgtdOzK@nongnu.org,
 AJvYcCXpNnwxl9f/nLUhnSsZVUBe3BMtF0KKXCheagnfT58TvWGLxC6SuWXCCJrlI3hLxKDyzVwVNijHRLzVaw==@nongnu.org
X-Gm-Message-State: AOJu0YyIAQYB1y0mvF4f+JxyASzbXKDJ9y84EW1N9p2v0fS8nkmLuV5x
 WXOUV4X+TDxRneWDdKe6BBw4tHF9Pq5HVq3DYfDhi/H4PcIPe43o
X-Gm-Gg: ASbGnctUQLZVKSLc36sYHnmk6Mi1sndAooSzoRmuKvfakz3SvB7HrnBvls4OUqY6KJD
 asRopL7iN4JJjxvsnXFlne74o5i9ci9uB4LMLMFfInAU+0AIvEZOPnOirV6gjQDyVUXXnVjmUyb
 gQ7F4MvVVmVt6oo2i4IA3QaqVkcSZsqb1lZctc8S+Q2hstILjyz2bLQNK4P/TQELYXr7reSVapd
 Ed7nVDe8HCz99mzHCl+752SRZtyHCSssFfXIA1FPpi3SaGWQexlRGNlgojhtNzN7G8pAPJBfkQW
 NiyLstNryMRgDp8UiH2EJw==
X-Google-Smtp-Source: AGHT+IHC4T586FDi4k3r88O6uNDAp4Rb0q0TTZ1FZSrLYSmMkif23GpavdvJSaXKBTT40Bw8aq366g==
X-Received: by 2002:a05:6000:2c2:b0:385:efc7:9335 with SMTP id
 ffacd0b85a97d-3861bf96e06mr2685340f8f.24.1733399397948; 
 Thu, 05 Dec 2024 03:49:57 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-030-063.78.54.pool.telefonica.de.
 [78.54.30.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da118cdasm20938225e9.36.2024.12.05.03.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 03:49:57 -0800 (PST)
Date: Thu, 05 Dec 2024 11:49:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/ide/ahci: Check for PCI device once in ahci_init()
In-Reply-To: <79005a21-00f9-4642-b93e-2ca9cde821ba@linaro.org>
References: <20241121100152.65476-1-philmd@linaro.org>
 <D1B09E85-E00F-4E8F-8332-51CB33A97E44@gmail.com>
 <79005a21-00f9-4642-b93e-2ca9cde821ba@linaro.org>
Message-ID: <C3A21155-1CAD-4390-A17E-4CAE6D12D56C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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



Am 3=2E Dezember 2024 09:12:08 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 3/12/24 07:46, Bernhard Beschow wrote:
>> Am 21=2E November 2024 10:01:52 UTC schrieb "Philippe Mathieu-Daud=C3=
=A9" <philmd@linaro=2Eorg>:
>>> object_dynamic_cast() is expensive; IRQ helpers are certainly
>>> a bad place to call it=2E Since the device type won't change at
>>> runtime, resolve it once when the AHCI context is initialized
>>> in ahci_init()=2E
>>>=20
>>> Reported-by: Peter Xu <peterx@redhat=2Ecom>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>> include/hw/ide/ahci=2Eh |  2 +-
>>> hw/ide/ahci=2Ec         | 17 +++++------------
>>> 2 files changed, 6 insertions(+), 13 deletions(-)
>
>
>>> @@ -196,13 +192,9 @@ static void ahci_irq_raise(AHCIState *s)
>>>=20
>>> static void ahci_irq_lower(AHCIState *s)
>>> {
>>> -    DeviceState *dev_state =3D s->container;
>>> -    PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(d=
ev_state),
>>> -                                                           TYPE_PCI_D=
EVICE);
>>> -
>>>      trace_ahci_irq_lower(s);
>>>=20
>>> -    if (!pci_dev || !msi_enabled(pci_dev)) {
>>> +    if (!s->pci_dev || !msi_enabled(s->pci_dev)) {
>>>          qemu_irq_lower(s->irq);
>>>      }
>>> }
>>=20
>> By always triggering the "irq" property, it might be possible to push o=
ut the above two methods to the caller, i=2Ee=2E the parent PCI device=2E T=
his would make this device model independent from PCI, essentially turning =
it into an "IP block"=2E At the same time this eliminates the need for the =
dynamic casts and AFAICS would also fix the missing PCI dependency in the K=
config file=2E I could send a patch=2E
>
>Oh=2E Please go ahead, that is appreciated!

Patch sent: <https://lore=2Ekernel=2Eorg/qemu-devel/20241205114453=2E1848-=
1-shentey@gmail=2Ecom/>

Best regards,
Bernhard

>
>>=20
>> Best regards,
>> Bernhard

