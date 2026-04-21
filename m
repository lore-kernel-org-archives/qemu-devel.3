Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DAF94CB8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKid-0006J6-MD; Tue, 21 Apr 2026 19:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKib-0006IZ-13
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:41:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKiZ-0003RZ-2b
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:41:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so396131766b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776814881; cv=none;
 d=google.com; s=arc-20240605;
 b=iuY20RPCIDESxZdExDCOyuW82xBlq8Ldk3ETCfxHAaZbPwmoz6+E5F001whcK+piG1
 cRv+oAYtG0ZAROAVdPZ/YUpWM6U6bvgQLoBqHaxiJ4yOj8+8YXgvYmFuh4wuiXgiVlaR
 +cwMVIpjPW/toyK/wbuPKAW3nlQbIISGR73XhIEw30h2gwTj/NnS6qvn7DuaDleiqNkn
 hMoSW/lsZeqNaKsywDWLqWldafYir9kx7zHE2SRYPSmoHwvQ6Y8R5MnSvuyKPVVPyBtG
 9SgFX3NrYEWDsOjZRlKQKYs74KoAPetAO6oM9yeiHmcA36OXIH9Z53RlS1aa2BbYtyCV
 ppsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=locFSOVrGgH1lnT7AKG0Sv1XsE9zv0cOmLslC5JdGyk=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=JfRGCJ64naBZHBbUAQyiuSI4XjcZG/Bg1CYdr8Dy6MEpKL4rLjxe7wOTPfuuBDbX7F
 QbVj0MVdNzRF1lFiI7+4kIsnxSPqVzKi2X1ND8ZN1UHAYJUhjRzZXI6ozwwivzdfjrP2
 u3q3SqttPQiCRb9QJgke8J25WsUM4DeZTrgJ8ry/OI3uwcaOzV4DcNXApQ1T7RcQW1nK
 zn+nAmeBbqNYl9qP25xgUQ3RIk2ZakW2myGO6CxKILYYStwbHZqJSYjwc5zR0X8DFeLt
 OLGAS+3Nsicq4uYtyEBodZKQLLIrQCMGAFOjGTqUcyBka/6SZf+2mgcKmnrgXqZ/eGbG
 Kc+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776814881; x=1777419681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=locFSOVrGgH1lnT7AKG0Sv1XsE9zv0cOmLslC5JdGyk=;
 b=DTi5R/QgoW82RqJYnHZ0LsoEgabtY+QP+TiUHsejlKH9gLvPR+xpiivPASRbNVgLlL
 HqTLNXO264HjuSrTzjrJeEsLdZotWEYKqF84Ea6K1c4Jd7Zx9WwkQ5xNBgdpwkhQF7R9
 uwjqxgscfwX42+rjpR3FoLBCUAusO2qjAqB6hFPFTowyAFJBdWH2KcjB0w6Ha11V7nud
 SBO7UvEz2KM8N0PfKr8NWJ+/tp6Sey5+fC160HElTAHTSlnI1gJSk+u+jCfxVEuw3mxC
 zxn0hoAL05rmUY2DubUgqb5PUyEOxlEuZlRciLzNhPGGhWgrRNah0j6Qdw5kQR6IoC4u
 6buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776814881; x=1777419681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=locFSOVrGgH1lnT7AKG0Sv1XsE9zv0cOmLslC5JdGyk=;
 b=fC5W3A/3dHlNGbqzNLfGv3U5KcZR4TXPt7HOfdq4O1IZXFAqbnXpyW1qA/NsGNdpS6
 3v8+34BODAFnvr3bDrxYp6voPIy8o7oK9o+5xbKq/lZJqsOJGVYMm76pF9b41eqSn669
 jk7kbEy2FyrPNpIsYSzwWRUtwq5QrmsuBkEdYh3ybD5wCFXT155dXdR1j49JNkts7Ha1
 gmJueTbr7qucZCzKlqcgoAylD1kLcQkViuc8NbkifgKDN6SgF86Ovpy/3VIaDwcJvZ0l
 os7ldiFoTa84JUXxIk83EkXkFKRMtcPMFe95PEwD3qAcsMBM3l78R41Cvo4kDrKYBxM7
 YeaA==
X-Gm-Message-State: AOJu0Yz4MBTcXT2uWsNhdFpp6rxpvP9Zr+C/4UzdAIe5EDKMkQpF/TXI
 kafoYcfS86yGs5adUIH/JbsZyqe/wzKQ5ztQV1VLQQ48qpaQjV7ckLsLq9xmKgmPlMSg/y3nEkt
 wPg52VsvCMfCdz36TRW+QwrE43cb/PKs=
X-Gm-Gg: AeBDievjGJVa9Ko5vLjYNel7VfQxb5XSI6XC48H0p3ldDsi0RLT5NzDC/loXZtcJbQh
 TW3h1TIWUgGbnuVVyZ6HYtIG4VxQemXwxlqMDITl5MW6hXYC6Tl/KTZZ/T6UgycrmFvwurRIJye
 as8bv5yg1Tui/zpu7O3APV0tDDVHwm9smRGHMIohZM52ASZyrOQFxJ8vyZwWaTbzrTC8l441eCa
 UIeuZ52mnWRql0B80xWsv5miGMag8loBo8xu8aBTWF9EGyWwPN3MdQHisW1dZQYBUQhgBPZ8NQe
 rTvk7+MC1ghvM8ERFsK+IFrftXAJQCa4qG18KGCOPwE85WwY
X-Received: by 2002:a17:907:9611:b0:ba9:13b4:1410 with SMTP id
 a640c23a62f3a-ba913b41806mr366577266b.11.1776814881097; Tue, 21 Apr 2026
 16:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260421074204.2908422-1-frank.chang@sifive.com>
In-Reply-To: <20260421074204.2908422-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:40:54 +1000
X-Gm-Features: AQROBzBjr-f-yCGYNvkqV_oaAwX8pbc1v6j2Tb_eDzivH7T9gehmSgn8m1_BpQM
Message-ID: <CAKmqyKN95aMOGAXDeVt89fduMiefeA6OHj4x80Nx0wj9_jAL8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add the implied rules for G and B extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 21, 2026 at 5:42=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add the implied rules for G and B extensions to enable the implied
> extensions.
>
> Changelog:
>   v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
>       implied extensions can be enabled by the implied rules.

Can they though?

The original commit  8b3b3451052cd7a115c9352de1bb8c74ee54a62e says

For every RVG MISA bit (IMAFD), zicsr and zifencei, the logic then
becomes:

- if enabled, do nothing;
- if disabled and not user set, enable it;
- if disabled and user set, throw a warning that it's a RVG mandatory
  extension.

Isn't that what we want?

Alistair

>
> Frank Chang (1):
>   target/riscv: Add standard B extension implied rule
>
> Jim Shu (1):
>   target/riscv: Add the implied rule for G extension
>
>  target/riscv/cpu.c         | 26 ++++++++++++-
>  target/riscv/tcg/tcg-cpu.c | 77 --------------------------------------
>  2 files changed, 25 insertions(+), 78 deletions(-)
>
> --
> 2.43.0
>
>

