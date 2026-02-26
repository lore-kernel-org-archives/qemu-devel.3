Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F788FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ7z-00030V-CF; Thu, 26 Feb 2026 06:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vvZ7t-0002zg-Ms
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:01:52 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vvZ7r-00032m-Lu
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:01:48 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c9a6d68e5so439752d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:01:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772103704; cv=none;
 d=google.com; s=arc-20240605;
 b=VyaOxNt0lPZ0DGhUXzt4y59sXkzUB+se1zWulbZT0O5bbtbJhvCEahPTrKathvVS/d
 QZby2ynz+G2b3NjCQE25ddALIAbZzArVumacHJZChBCdl6qLvTyPisYyy90HqK4/pL2S
 v2Z2VYQZWfTSOhMZ3EE3CvKakjXau+AIsYEjAHB70Hjh/y55pHj4ejg2FruZuzAVrZkL
 Oq0ZL8VQzdo0FBVq0cVNK1W4x9E8QVrIdpmL/vXMqf6XCz0y4GeiMx+mGtATmH783wr7
 MweFpKgODXB4PYWtO5je6HrFz74kiER7E2r7xES2omFeYwoWi8qUK4skxB+gMdblJYCU
 ueqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2gRyvYeB9+f/Pujoy6gORKYasEC56acadoBFA6r/or4=;
 fh=+lkhgrzZfpaaUf562P69yjGYvvSbup7JpxI6sDFJR2I=;
 b=fOXjU9QB7kaMvISpP5EYV1m1aL76/wBvaP22K173epKjs/k94yeoB03425n8iy6Iyw
 nrBYeieOiqF/PCBnEpN263HTSa8GTtgjiZii6erbVBXh5CgFFHRb6VlyWxTrbjc9/uxb
 W3S2qymChgkBcn3zTYcoZj12wjKoRFT8qIXuWHMa61/7RiD3H4VNBmSzv4B3qwTWUzjf
 2KQx1DaxGpkT+TfgwC45bgwnk6SSY2yen+mjlR3pfxyDiXO68pzAakRaVWEwu9JLOdUm
 wtJ0G45lCjOVu9jCIX33OT52CQ1QohjaYqeVp0EOHtOLfraM9IUrjJd+KuGTauGpHBao
 eQLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772103704; x=1772708504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gRyvYeB9+f/Pujoy6gORKYasEC56acadoBFA6r/or4=;
 b=Gjtgr4IIAlfn7VRjfG6oFLqt+G2Fb4CzcFydXmpYXMeNBWICtAJo5l2hyj6+dxAoao
 nNlLqEVUbxhqbK1zyJMvUQdOiPhagdGZpze5BdLUGDnEY+I19MLqg4DAW7j9sM3ESjRw
 H7eFWvliD0BqOhBDvis6HseNFhdreRFxZpaLPZzphhtmnMbTrjCmTJTGiQzHF6xPtJ6y
 MQkR98vhefZT4bRbAvEAKses5Phj3J6oqB9n3NdU23FjwwIxZqTu6ILVoPWQk0VwnRLo
 o+X5N72VV4okGCX2cXadVHm8u8YG4+F3yzaS8umsIZet3Onthw9H2cBMi/BiPBMumdVE
 BOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772103704; x=1772708504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gRyvYeB9+f/Pujoy6gORKYasEC56acadoBFA6r/or4=;
 b=CiF1fYGm2kgtqSuDnRygZ3Miq0mej/X9Cpefa8kJIijQIIG+Moat0Mz1ua82bguOi6
 JzmUaaVfTtIguMFkqV1sSTIDWUgMvbzp4QQo5HHszvLgjgO09X0Rd+RP9S90Iz8n6jyb
 dWiilueSIfA0dwyQULvDD85PWQ/3PBYuiHi4I9Ym0TYarY4Zs4HcHk3z167+g6znKCC5
 F3PLmxh36E5LZD6DnyKFeJOMWR5gywFit9fHyqGvs3js9Aw2/x/mmMQlMBC8I+2WSxq0
 Sgq5spy9nVqoYNCqJR9+jBvgmFZ+mDgbXLJ+wuKcxzDzhwO3p9+OwstI2d7Jn3zeq9ur
 NbbQ==
X-Gm-Message-State: AOJu0Yyj4x3y6JO/uCmYCo+BG7V0YhYYey35KjxprjlsGm/VgegXKXUQ
 kMpwtppao+ojwmEspYA0tp8OeYoxU7LBskZ/Pl4vXuHrUCDowLkadEkObbdFyq/8DSq9kU2c4fE
 fTjH89eGLC9ZlmZJUpDIu69Hi6tmgm1A=
X-Gm-Gg: ATEYQzzQWoFFZcFkkfG22kPTJON0PZgjsdjaSqlijf8u0ieddlW3Rw9ElZoP3XqLVYk
 fR8lFoAUGu7wPFEfUAJQ1hX4PC8AhAbRyKtvDXBS9gzn2UCD3EyJOsgbJ8dnIf2GfshUiKI0dSn
 wIdHAt6BeAvTQjlNxRLxV2RR8xq5o1nsmXyFiLZo1lsbmrlK1JtlScLnFqT5X9I/BM3339Cff1v
 tqy4GtwWQCXKaSU/16DFMO4gtxaf6KIq7dDg9kZX5G+Dj7DaYK0Xm0wAJQnbbJUOB6DSa0MeP1g
 yu6H/9JZAw==
X-Received: by 2002:a05:690e:1515:b0:64a:d04e:a340 with SMTP id
 956f58d0204a3-64cb7bf5763mr1577732d50.11.1772103704219; Thu, 26 Feb 2026
 03:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 26 Feb 2026 19:01:33 +0800
X-Gm-Features: AaiRm506tJnDdgSa2dkpTPGKdiAt8CruaJrsxUe_PPXfnGO3qjWyEgEitFKaaEM
Message-ID: <CAEUhbmWyhk6x1+kNqsy6npaT+dqDcbtq2zSpWSLJKEmhKs7iSA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb135.google.com
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

Hi Chao,

On Thu, Feb 26, 2026 at 6:20=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> Add myself as a reviewer for RISC-V TCG CPU related code to better
> participate in patch review.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>

It's great to see you stepping up to become one of the reviewers for
the RISC-V subsystem. You have been doing an excellent job
contributing new features and fixing bugs here for the past one year.
I'm confident that this subsystem is in good hands with you.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin

