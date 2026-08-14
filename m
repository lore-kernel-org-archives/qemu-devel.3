Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B096BC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 06:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wulNz-0003l8-80; Fri, 14 Aug 2026 02:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wulNy-0003kn-Es
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:27:22 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wulNx-0000IE-2t
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:27:22 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66c70e2904dso845099d50.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 23:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786688839; cv=none;
 d=google.com; s=arc-20260327;
 b=bHm90I9iCxyxnJQh0vnxNU9caa+RIyxP2yhFTpBRFEfSpRal/F2GxWsYr87wMvQRh6
 GyD7ig3PZwMkxNrqmg0BBY2qi3xJI1iWSAFgVoGk0+Xx4bvqhQ4gsSR6lWDtWY7t5Q8d
 8AVsCXadhJ22RPipT3Ry7CPjawzgD8Mu97Z0TaKYM6pjbg3nWH9gMOHcMNHBx5xOPgpQ
 Ug1nfszuQfPaPur0029CGVD53iSOtfP7zCAhPLA3GnGVD85jsh0P9+jJiK6V2TXVxT6T
 s0SnHMIrF/BB1aFrFsKOlZEGFqZxuOPHsldwkiALEHUF9hw1S5iN3iWOt6yPDdyylCgk
 dFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n0JefToRXoa94zkgelvodnsgO8JO8c7B1OGjyZtdl6w=;
 fh=rUwpPlqdrbUANYAzzWcu0QQaedGviu0qLFeJnQdHhjU=;
 b=isHnHvXWvA9QOKGXzz/JaQqatFmI1BKVLLkjepfmSFLBJevScK9WUqMgREtobiReTx
 Tzfh6ximirgzyzJ79zIswqOQAeDpxhXAm/bGdZMeM00iOVn2KngVmzvY926QD8R+8Gmu
 ti89zPa/UfffyEm3h5BGYplUtfFQcZ0ysLEbbBFlg203mvuLxgAU3Pb/t47b2MeQzVab
 fIBiNue/UbUfxfJ0yRjj8/Pq6Yl0VotH/epv2ZOeIzYD6tdrcE6rrffpAZNJhVJM6v0G
 WtWztxg6t704u7LjE1Zl3Em3ZG2qIfNbiG6+F5HTY03CTjAeyEfjxME3DtnvEPxRUwjA
 v4Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786688839; x=1787293639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0JefToRXoa94zkgelvodnsgO8JO8c7B1OGjyZtdl6w=;
 b=U+LcYfc1Z6CJxTyL9sY/O2UCFxhDmsf6s7V+4CLDii4EloBTHsBEYn0e6sZeFTzkAJ
 IGAOptiKDSR9ZaY7s9UmY8St1D38SYJmJKR6NK/gHWGTs9UP5tF17XTXAYIg1s1k+gKU
 O4+6G/kNqE0dOgR9R8sWYt7mor5Ff+AyBCKtRGiCpYvzFfpo6ccwfgmBeEbXo6ZACxM0
 OVkz1d5QbG8goc6w06IvoZbxxpeL3tUc+w7C16O1n70NeBazfuNfafTYH2nnR7ov9G1m
 /amxR2ibrnoEK3vxWiiTuDhiUZAJJwW/knTE8jqU5Yb7rJ8KNNJvb3uO6yBazK5jmWC3
 8Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786688839; x=1787293639;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0JefToRXoa94zkgelvodnsgO8JO8c7B1OGjyZtdl6w=;
 b=jNLIO6XyUcn9Qdsoe5YAMCYv0pF6NbMW78ltQb+QFC37lIUt/0ncdvMWxPVPwi8n7G
 hnaq2JAsVLNBgkzjccu5BAuz8GjtuPFq3Za1Lz/hKQeH5MP4zI8ytwkfDHX93PkQXgZH
 yihyOR6iwnzjH6+bSgl0SIlU655LNpZkELyZbX/I/jHUkCU3/u/abLC/efBIqRTp3Udp
 yZjLHA2I+brFafoZwG9HrzF7jn5qBrqTNWnLhcWKtqeSj5rUtalH3dZKXu/PIkfR4RUe
 Z3KyKj8r7Ti+MuIL1Uuf0825BeLVjRoteiEGl9uwPEDfnJINpQNsXp00yILQRAPAOwDr
 /bvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZfdzWJrLP+O8g+OManEfUOw3YWNWASHBmOS9rAmiqppCmNOSuOzB2MZ9hpTQFnzSUfXvrTkffpbJh@nongnu.org
X-Gm-Message-State: AOJu0YwSw6elKDXmTUQbeSCR3FM+p+yrC72dITnSj2z8NXSclDw2R5BK
 ONwZnUJArzKgauTxkIKVsYBORud2VnxHrXdT6pk2kACCQtI0SZw41zS+Pv7eTofWFnD+F9se4GE
 ueLmqRzNl8Q+l4ouw4BJW6O6xuF7XcgQ=
X-Gm-Gg: AR+sD11h/Gc04vt5+8CC4cz3fNSpJ5FTElD5zJEMP2Q+jJL40wzvPco+a4QIt0+x2AU
 0nGO+gHPq/HNnWvJBSLYD9eF3E4db4dGuUbCSM2U5gkKtvfkkSnouaJD/bkRiisjtsXCH8eKbYn
 tq14yTLylqEz2PYf2kr8IE6Xz7ZxROCeujMZ7lYXFIGJ42cd3APDzMHlgfX06X8rfV7vXl8cbtL
 bDWs9O0OWOS182FZovlAY2gjkzOTXMYKJP6Fz/CxgrZBsBO8zGPBiZhAPysMC345YIS+TL155kE
 Im2oFjFcvGtm8e7qzNICMAEAPnM5Dg2mE5KGvop6Ooji
X-Received: by 2002:a05:690e:400c:b0:667:b72c:8119 with SMTP id
 956f58d0204a3-66c72d050a3mr1368723d50.43.1786688839479; Thu, 13 Aug 2026
 23:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
In-Reply-To: <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 14:27:07 +0800
X-Gm-Features: AUfX_mxNooVMH4UKHzKpa-pDdVOIMpBd1wwtGHT_cczRMT6ELJ8fa1wKoS15Ohk
Message-ID: <CAEUhbmWJzY4qZA6DvTKu3gbP=BEe_Byw6+cpiKEruvVCyL-jiw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
To: Joel Stanley <joel@jms.id.au>
Cc: WX Chen <wxchen0913@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
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

On Thu, Aug 13, 2026 at 6:21=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Sat, 8 Aug 2026 at 12:02, WX Chen <wxchen0913@gmail.com> wrote:
> >
> > This series adds a QEMU model for the K230 SoC DesignWare 8250-compatib=
le
> > UART controller, wires it into the K230 SoC, and adds qtest coverage.
> >
> > The implementation supports the registers and features required by the
> > Linux 8250_dw driver, providing an interactive shell over the serial po=
rt.
>
> This is a model for the same hardware as this patch:
>
> https://lore.kernel.org/qemu-riscv/20260616190147.1286316-2-visitorckw@gm=
ail.com/
>
> I'm not fussed which one we end up with in the tree, but it would be
> good to name it generically so other machines can use it.
>

Agree.

Hi Alistair,

I suggest we drop the series from your riscv-to-apply.next tree and
ask WX Chen to respin another version.

The DesignWare series IP should be modeled separately instead of the
SoC version to allow other machines to re-use the same DW IP.

Regards,
Bin

