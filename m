Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FFFC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 03:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twY8a-0000wu-2V; Sun, 23 Mar 2025 23:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twY8P-0000vl-RD; Sun, 23 Mar 2025 23:05:57 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twY8O-0003qZ-9u; Sun, 23 Mar 2025 23:05:53 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d42f08219so1502317241.0; 
 Sun, 23 Mar 2025 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742785551; x=1743390351; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEYqHOa7/h0uCByt7ItyqRpjqfJCepGzXZEdZcTkBrU=;
 b=lboHYMhvu2xznIoDJH2u7uw1JH6OJm4rj0LmJbmf5VusqbFm9nEYc4K5Q7K25PxiEi
 0RHXMrM+o90P3+5JrYG1TAUzxp5GzZO75A0CaJPZb14TlXNoHbeCHwe0tuvOLDtsIrVB
 YOyj4kzHWz5A2uMKWabIg2XA5T2mZI6gFi8m9tmCqDGodILQBJ+Zk6UWZd4gCCiIMZHC
 wYVFOoJCP9LBBCwcVIC3UzhQB8M1gI44iCYIrFpN4oy9gnoX5n1OYtD3WTJgj/zN7QzO
 OMAPl6R+GWwPc+2k11sxFu476eYhBILd6tjaCblmp6X86dLiKhZca3BqaiAGY5N9y24N
 X3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742785551; x=1743390351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEYqHOa7/h0uCByt7ItyqRpjqfJCepGzXZEdZcTkBrU=;
 b=EPc//kuSXhzkqSgJfnK62ArMy1LoDfCYKG1OqPH7hNCSitrdrhO4NopDVu1YrkW5fb
 oSFK5aTk5CA4OFVr/H0KKkUQi/9bAJpAgmhxhTr1rNiHd3h34Q7r0MS161ZnczNgKKQp
 NpDhXhd2KTbvG3mKeOfydvCez4u3kbP4uXiTCE1lprM1LdnFlQpeqZYVYhaUoVp18/DC
 KWWOcB+6vlKT8MsRhj1ey7kkXuKxj1Q4NZZQ9cZA4SaIG7Ms2dtc8pRZ2f3ODvRgdW1u
 yMEmoDoL1b649Rkmx3dti5k/fvqqUwfKVmCXhag/YmmBIFpJ8s7Bq1OL1+x4gEHAEHSp
 QSUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDVpWvzLLu6n0xm0qhEI4Zcg9Pu0CSj2LnQ4OYgUWPEngKQhk60jTb4T1h47IJpLmUtFd25UTscESag==@nongnu.org,
 AJvYcCWT6Dofs7Mqwn0jr9cf8lfK3AxRjHYpA/eTzvBN/iMcDMyLqs+pj2u3ByhFxURGAV8otTcCtQHQy0Va@nongnu.org
X-Gm-Message-State: AOJu0Yy5PWQ2Dws7kg2zbSbtAaU3cGliv3PGixAJYRHhe+Ta97akpY/y
 vu53p2EV6bCHCLf1sRweIzJyDCKlOApBnXe6S7UyTSgylEaw7oC/ieHqK4BWEjbgG8NpGZ7hbMj
 tYHQBKEUqdKOtKcjuRMt38OMe/EU=
X-Gm-Gg: ASbGncvzkFV7UioMl0XmEv9B9RMEyoz02kK1/1Fnqv3K9lv9LiDGNU0XeOk2CrhzPKR
 SFvz+VTnn09Ufo+hkpgNN9Tb4K/EdbCG58OsewPupog8cIQwFJSZf2K5hSjZDjc/JQRg13wF9Q3
 tBriugzwTAQoJBdnbIStkqcMufQ7Zm633Sc0XGeCXCbs2+kgxF6CLQVOElcoljv+GY2Q==
X-Google-Smtp-Source: AGHT+IGGJVt6JqxOmqxKrwEEECaJrQ8WFeuvSv0eAK4BrxzKx1X6SQ0XBJb9x7pXFZzBTRXWM6jqCaewVLYXwQoaG/o=
X-Received: by 2002:a05:6102:cce:b0:4c1:a448:ac7d with SMTP id
 ada2fe7eead31-4c50d4b8786mr6953723137.10.1742785550682; Sun, 23 Mar 2025
 20:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250306064636.452396-1-debug@rivosinc.com>
 <b47fd8e8-f0dd-448f-ac9f-f6e23aead1bb@tls.msk.ru>
In-Reply-To: <b47fd8e8-f0dd-448f-ac9f-f6e23aead1bb@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 13:05:24 +1000
X-Gm-Features: AQ5f1Jr2pQ6F0ICfEnwQJSJl8nujR9Gx4LWHN2dq4FuORUnKxrB7NeZmzJMCGxY
Message-ID: <CAKmqyKPEpYKOO8RmoMRxpF=GPt5W+c4RmfQdr70Prs6fv1cBvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: fix access permission checks for
 CSR_SSP
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Adam Zabrocki <azabrocki@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Mar 22, 2025 at 4:03=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 06.03.2025 09:46, Deepak Gupta wrote:
> > Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
> > zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
> > to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
> > rather rules clearly specified in section "22.2.1. Shadow Stack Pointer
> > (ssp) CSR access contr" in the priv spec.
> >
> > Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
> > for zicfiss". Thanks to Adam Zabrocki for bringing this to attention.
>
> Is this patchset (including "[2/2] target/riscv: fixes a bug against
> `ssamoswap` behavior in M-mode") applicable for stable qemu series?

Yes, if it applies it is (it probably won't apply to older stables as
it's a new-ish feature).

Alistair

>
> Thanks,
>
> /mjt
>

