Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989EBC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tm9ma-0000hX-4I; Sun, 23 Feb 2025 06:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tm9mX-0000gg-Kx; Sun, 23 Feb 2025 06:04:21 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tm9mW-00014Q-1K; Sun, 23 Feb 2025 06:04:21 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so697052066b.3; 
 Sun, 23 Feb 2025 03:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740308658; x=1740913458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKhBEk8OZmEDZrO5s4bA9/+2wz9qC3YRX5Dq1TA18UA=;
 b=gSjMF3/YfC7Wf8nA5eF2ZUwortn/1uUvOZxvMsiTQtgH8e2IDc+yPRRsgJOEjJopDI
 8x+V+r2eLagedHkRV7hhHfeBHsNTOA/PrsJGuyenmYw6Ma16fdt9yH+YzUzHMZO/KDTV
 PcqQSdpXxrMZ6bfNkX7Iq5XS4Bqg6tFiSAoi9oC/ven4yCYVolCJb1LVH5DnzJ42Ga6O
 qwBaRLteSV4oawwCF7aeUVkhcrbmjUGAxzGM2HUpuDgd/Epu5wNQpk0QGKoeffHrTqGB
 kZxjkOBkuk77YalUCEVUq5Kbb8yHMMxgGt2uY5xtXsSEeOkBJuOmx9qYuGscnK8kb+kd
 aA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740308658; x=1740913458;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKhBEk8OZmEDZrO5s4bA9/+2wz9qC3YRX5Dq1TA18UA=;
 b=J4sAYkgaiGVwwPQKqoRiJ4KtTQckZUav6LWeUjLYvVC579Nw5ITrphxsupKyjpHipg
 IvjULDvwtz5Jg3gnSrqAw+Ofdie/bss7qGVH140fHktYlIIWij4Pjb1T/6cq2Ew1sq/7
 T1rfT+Rlt9o7PAyBgXzu4nVPKG6sF7zAT39OV6VqdPjuo88AEIxhW0QRPEkqfTRPmdMu
 bxhP2gp31SIQaNOSeCjQf7aCcqqyDu+K2F/pszk/CmGrl6cuJUp8lQcyK7HO0ukqvJ9n
 hHW548otNlSAufHPxRmS3Tn/LecSXcuFLcVRmgT7bjslExleiUUkOrhHxUqvmneAeBvZ
 QIAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvOi+IZgfUAKck+onZw4+cMMkBC/IU7zsY+Mp0NlZxIdyNPzfkXHToFKhRa0iuBmrNVwzPdILc6w==@nongnu.org
X-Gm-Message-State: AOJu0YzeEeJMTNeBI5/7KoX7oCIBSnH4wl+DckOO5VJUHtH3wXeVuyMz
 kGdlJUJew7Q72XzgbhQIscl93stguHPzhqKTVZolryl7QHxgnmTrfQcCtQ==
X-Gm-Gg: ASbGnctsgUEFq7QQJCTyIgNYmGKN6LP2o/HOj13YvWOvTYeyTeWNhJbwGYWq8wvLved
 KWoJWyBNr/SSKaNIiDX21qG4vhLBna0bK6/r0VZtBI6bD37vgDisvPkpMbSg3BfdnIfzTSSNGTm
 cwgN5RgiZ6aAArMvLzfQu9Y2LICheKrdzskirs7TFMlj4PXlQBqRqDeYxQAHeN+vCAnOhHCPa89
 Gg9kNqSlRmpx9+8XNc03GZ6V8hvb+PLCtl6fsXK9zqT10tQZLkMd/npBDfILBrAT6epbLF4MG4D
 P0EMpHVfXdB6BAxbRdi4xanN+ulqN7rntongFGsnJjysG9uVMoT06kYmX39eWju9bfdrHXT5fzE
 =
X-Google-Smtp-Source: AGHT+IH4KOMX/m8wsfqsZAUog6ECZK2U/UM9tnpuQr+bAYHGhxufErf0aW8+w6dmJPQ993D8b/VZbg==
X-Received: by 2002:a17:907:1b22:b0:ab7:ec8b:c648 with SMTP id
 a640c23a62f3a-abc099e0270mr1114205066b.1.1740308657833; 
 Sun, 23 Feb 2025 03:04:17 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-011-167-038.77.11.pool.telefonica.de.
 [77.11.167.38]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbac60d938sm1196463566b.147.2025.02.23.03.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 03:04:17 -0800 (PST)
Date: Sun, 23 Feb 2025 11:04:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
In-Reply-To: <382AF9A2-4339-42F8-9C32-E7F6960CD4A8@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-17-shentey@gmail.com>
 <CAFEAcA_Kasz0jMTQO1F32bMwSh6tRoDTaS2DE0sSruLENdcu8g@mail.gmail.com>
 <382AF9A2-4339-42F8-9C32-E7F6960CD4A8@gmail.com>
Message-ID: <47416DFA-2D7A-4277-828B-D11D548B5085@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 17=2E Februar 2025 22:48:23 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 17=2E Februar 2025 13:28:42 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>>
>>> On a real device, the boot ROM contains the very first instructions th=
e CPU
>>> executes=2E Also, U-Boot calls into the ROM to determine the boot devi=
ce=2E While
>>> we're not actually implementing this here, let's create the infrastruc=
ture and
>>> add a dummy ROM with all zeros=2E This allows for implementing a ROM l=
ater without
>>> touching the source code and even allows for users to provide their ow=
n ROMs=2E
>>>
>>> The imx8mp-boot=2Erom was created with
>>> `dd if=3D/dev/zero of=3Dimx8mp-boot=2Erom bs=3D1 count=3D258048`=2E
>>
>>If it's all zeroes, we don't need to commit it to git as a binary,
>>we can generate it at build time=2E (We should avoid having
>>binaries in git as much as we can manage=2E)
>
>I went with this solution since it trivially works on any build platform=
=2E Any idea how to generate the file in a portable way?

Besides this question, the compressed size of the file in Git is just 276 =
bytes:

  $ git hash-object pc-bios/imx8mp-boot=2Erom
  5324b5eed200e723d048f8476e4d96d45622fd4d
  $ git verify-pack -v =2Egit/objects/pack/pack-*=2Eidx | grep 5324b5eed2
  5324b5eed200e723d048f8476e4d96d45622fd4d blob   258048 276 787647

Is it really worth generating it during the build process?

Best regards,
Bernhard

>
>Thanks,
>Bernhard
>
>>
>>thanks
>>-- PMM

