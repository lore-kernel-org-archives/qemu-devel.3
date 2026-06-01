Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2454CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTt8t-0000C4-Tf; Sun, 31 May 2026 23:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTt8r-0000BY-UC
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:16:41 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTt8q-0007sk-D0
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:16:41 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so102212766b.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283799; cv=none;
 d=google.com; s=arc-20240605;
 b=KJFiL73fdc3dmcunGmWdSsluJ69EveRqhDpHMQQPC64BiHTeT04vqGC++wdp5ePYUt
 6n6Dp1SOMgqRb8qXYZlHZnlgMgnBE9P8QL8V85WtGUUvxqUQZ8mZhorvjk8kbvTAxGBn
 3dp/Lv3WUUzYPXL5cmcLDN0DSbsXjThf0tctQvz+pf/RyiIvi8ZTTp5gIfOrRvLzhqBm
 btRwx5eVgigJdkocpEcV8B/a9xG3ja4iwO/RLvJKt4zT6Y7dEyJ35HbZxLl8CV0uHxSI
 CqAtS2hjLwiAFpu0NFe8RLy3iLHBWSEvHSpDvZw15bocLo5V+4lEx6nU3BY5qS6k7keb
 Anhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RXoDANf3J8QHeoQGdRR8wDPh6TPDX0vUUUjR7ERULJI=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Ps9/y+QoGLiFdMWtBkJSNqunkYnzLnkDwzMztJJG2jF7L2Cxn9qlb4M2ubIJf9+GjG
 ahaaWqE3rjMEoAmJgFkw07JaERYtWjSAzYBjaWXSdhhp6lVBVQtI6QLG2kHTgIp8/8x7
 2gykYq8eNeew1sAofsinO+zhnpC9oQLho6osHInUJwlAkToKo2bFQzoLwuyGNU8/fAzm
 U1lqZrZBPZ+WLhdexQpdnuYxXbz6au/lI4IR4DxjIsdbpNp6h7VasEGg7HglMtts7wPR
 jEbGHDKwb6KejYxju5gYejj+ltAuSjt2/xXAuwh6iGmllF+sNFUNE94cfHKQ3MCoNSxb
 V+nQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780283799; x=1780888599; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXoDANf3J8QHeoQGdRR8wDPh6TPDX0vUUUjR7ERULJI=;
 b=FaCTwBcNud5SGplPN2/zYCngaJ26aKnjL/elVEG1nnoWsi2kaSb8W3+GRr1/Vg0vqc
 GOmIDJc2es+iOOyY7/tkx82L4SA6MDlYLLqreK1ORgGq5Z3OCZRJBebn6EJLGSTAdIYA
 lepsfXa0wmqmYU6VpPvf7+X9ZyXlCqSOe/Drxfxys4yT/deTB6EIXZdvOIL5RSb5DBgi
 I028YQlFuF/FO6jTzmAeNj/HVBZg4EwNap988bQO8IPaqJGnpNjYHD9buz1gj4x/kTV/
 6WTopb12E3ZPSWzBj9qaDxqomO93oL4yUvDfvHWVlV71kilbXjjsTtzK6gLD9+My9Zby
 qXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780283799; x=1780888599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXoDANf3J8QHeoQGdRR8wDPh6TPDX0vUUUjR7ERULJI=;
 b=mClOEibe7z7x5gkW9KlrmVpRNgIwWkvAvNu/tenwxJhM9DbLazL2G4U6lcl4FaPImY
 /9klL785Zey0owE+n7B5DWgKy7O2l77O3tZ5lYKMYGJ0FX25CWskF4rMfkAcVEA6kAEO
 BbNcEHJP+VB3tied4X+OMb+oLNMVxjVW/1f61LcbQOV6BFdgbSGgOsLVARzgc0HsWUcf
 uWhD1u8LZVx4ZaKHun3KR/Dh13Qrd+8PrHFmOVgVlZeGA5fEVlzv89zmQ0QtdbJmj058
 w5CPlAk04F5fddEiRfe48OhFCZu/Mo6PWCDYmGTYvKEqFAJphmgpKnzI1e0WR0rGQV7z
 hIRg==
X-Gm-Message-State: AOJu0Yw/ObhTrrDqA0o/NoTL3HQB/AAvqIPp5HK5b/1Zs6nQTjVNWu3+
 es/yCoeI0TV34hkQvibsQefeYe/lktahhlgBFkKtFEVQ6WwbZdh6y+qJt5z7jZGj8vq+YDLvKfy
 IkWh6aD6Xi0Vqif8hKTzdTMU4cSy3wwA=
X-Gm-Gg: Acq92OEYG89z44t+5AfYWnmOPHfhqfYoOiCqGeCI7RTxMTUVwW/v9TO3WwYR4jiFeXD
 pHZZKSs4z6F6+/3ry2rRdNnCrhDWTM293Fb4LJngcBr9zHUMIIAWVo1gRfOSOKvTYUKPro24cjb
 d2uFM6as/vN6H2Rle0gBXW0ZfL8kcLDal+MlYwKuSOoACZfYtKLn/06pY4+TXQQHY/exrmFubuR
 83/Ro+s55xzQ4pvKVOFPmx2C7PM/LKMuBH4sfDX1rnfhbkUFxDbI5uvVdWOPUdoWRqex1BBuJrX
 VGy1dXas9BQ8nfLgpkBLWeoCsxU0TycgS187NLB/67X561aL
X-Received: by 2002:a17:907:a2c8:b0:bda:916b:c87e with SMTP id
 a640c23a62f3a-beab01dcaf3mr396407566b.12.1780283798490; Sun, 31 May 2026
 20:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:16:11 +1000
X-Gm-Features: AVHnY4Krq8bZIPAXGudAgWrN43R-V_ISpZtF5RdXU3hB2BspUz2YL-LdUR-f2fE
Message-ID: <CAKmqyKOA7oD6AmwgxiwPjV9R4NBVXv+4bgAHeUECiqiLQv+dhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] disas/riscv.c: fix inst_length()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Thu, May 28, 2026 at 6:05=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hello,
>
>
> In this new version we're fixing the disas function by reducing the
> encodings we support, which is super fine.  Thanks to Alistair for
> pointing this out in the v1 review.
>
>
> Changes from v1:
> - support only 16 and 32 bit inst length as specified in the RISC-V
>   unpriv ISA
> - v1 link: https://lore.kernel.org/qemu-devel/20260520173522.1794433-1-da=
niel.barboza@oss.qualcomm.com/

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>
> Daniel Henrique Barboza (1):
>   disas/riscv.c: fix inst_length()
>
>  disas/riscv.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> --
> 2.43.0
>
>

