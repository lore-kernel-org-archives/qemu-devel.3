Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA7CCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMUh-0002Xb-Ow; Tue, 16 Jun 2026 01:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZMUf-0002X2-OD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:37:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZMUd-0005Vr-Va
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:37:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so4409848a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781588265; cv=none;
 d=google.com; s=arc-20240605;
 b=INIjs7ARnwPXHfJ/lzgVZ3neqA47ZLvdNJHYe/7m/FlknJQ4ErweIii+Xix2IuVwwo
 6j0TuzrsGmGH0koLaRFCU+IPK6MuAFtroOYE/XYLFgy+wIBjty56i8PZWdRFwRHZ+DnM
 epYsZdbNQmEZ6rs/lqCL3l0vjVrM/sbwCcpbiHPuNJy4rtr1MgAiZE/rG++dJTAq/VAF
 5ZbOqc3HO6uF6X1pmp1b9YHDQf6fTOak8h7vTzx6US02C6dwK3ypRaJzAdE9Z8yzrB33
 IBL6//TlXDSbmA3fxk/bcw4us/1Wc6+v9/1psZSZzdL9DlapdTron+dw+JDpE5MEqoT8
 IGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5uFwkG+95qzaTNv1FdhD4Kjfag1rKFrdZyhPBHtmxOY=;
 fh=HO6AeeajR5enZhXSEEgDgVXmUUOt6KEXigxo0yCCr9U=;
 b=lX2b++4ZgCYHSiXqaZqykXEOMjDmpeCDGOn/UztRrxd0ZF2+lcAg7T+O9ZhFX94CVO
 AdtM8v1IoJq+XmnbGY5Lo87yV0T1dFUmvDjW6XL9cQH9btKHPYS8KAH2usQgGEOJLuUd
 nQdJssDiVPW7+H3WIVUmWX7/l6bkG+tuyUUHCTA5UwnK7PSi5F7kXA0jCRoCuwXlxZ6F
 AfDEOW8N4cbWrP556S4SrysjrErqew+StCSvewl/PZQq+jQeB6KjT9vM36HEmbkcbguv
 dF3qZorPfT0WHpz84WE8xwMnHZ3JSD2klyHxL0rqYH19kdpeU02Wv5+X/vSJETDYrsQ2
 Olwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781588265; x=1782193065; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uFwkG+95qzaTNv1FdhD4Kjfag1rKFrdZyhPBHtmxOY=;
 b=LkjW74PAf74H1/vI7f0Zm46N9j6dgwlwlP/Sepunb2u0gLrYW6XphUSjAp1vr/KdMz
 kynWbuR0GGVlta6jZQt8o3b0GUBKshqPVW8XQqbbH8xeQ2+2u3sgpFymKG5K6Y05Sy2R
 AXqINTeNIE/Z7JXbaAPFIY4DQiJ3nifsxdG7Gy89OwysTuxlUN8moRHMHH7Zi37ihpNp
 jRUN00UY226xsu/nooQN+ssyAqbwY0nDxuwbIERK2vWUP9nkM4TsaeqrOE1AmydW4rkB
 vlKACMuWwH7G38FmZvcCjWj1nfWvlMQL6nLd0sA3i2APuSe9fa97XEq2ghk16KXp5kum
 ZI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781588265; x=1782193065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5uFwkG+95qzaTNv1FdhD4Kjfag1rKFrdZyhPBHtmxOY=;
 b=hkuK7V/TuLQzLeBztxFxGrGl2S0a90RNff2FqvFoEN+lPSXuHgH+FtwaHkZ3sMSOBk
 acv9S1pUCo0bQ+Ff92PWTtcCbmHbVtN9Op8Ywyp5E1iw9R/ze9CI+pqcca24sR8CQc/j
 BGM+2wfrnTmqk/g6nqnGjqBmM4Qh6UCFfqndoZ4i+oGTj24MxXKpxph+1NPpHZ2hjj4z
 8mcosiv1XihGyXrT8v8QC6Nr71J/ARv9tdH08qElIL0cy5V3JfSxkINk3y04hasruQ0A
 0Bpw1mNqvMF8YTTNLWR9yK0HfjrTqeSZIj+cVOFpj0MlqE2/YetaTqTkRVVvNUq6YPNy
 oaHA==
X-Gm-Message-State: AOJu0YxnT0N/Ybsh+xrW8RCFCbAl/xleypXrJbbougW+AAjmHRBY7CaI
 /eavawQGeTSWlKPm2UcDIGwKuxCRLVuVzqGPpaHX9Q4llHe+Q+xCkkk5Y7fKRSs8zg2/BDLWklN
 wOmtA1wrfL47AVr0aN+lafGWk3kFoCTg=
X-Gm-Gg: Acq92OHw723Vwvl8tImRWJ0ajFd+9UIFZoyLk4WkyqoJKYAW/TAD3ByAqk9fkPnMYm6
 HTNPFq52gJS8mrwJRH4/EUViUHzlxRMm6Cnp4Hm/uFzEmBw1FwbRfY3aKEI5+QaONgrIANywyxg
 5zr8ZDlLuo8aC3EjXJMLHfFlpy1Vmkoo688xy8eD6B3o4gbMzV/5i9cAWr9lgIlFa4zQ9/4Fm/k
 AP+8lpVRNn29brauCRkKLFVa6MVZks3eAAxATjYOYyF1UB7yHhSmC1g2e+hh7aGYJvo0JcYlcSb
 aZGaBT0mWfGMeGa7ULAhQ+cYjIdV8Kee88P4pA==
X-Received: by 2002:a05:6402:3907:b0:691:6fca:c1a6 with SMTP id
 4fb4d7f45d1cf-69378a5a009mr7720299a12.26.1781588265291; Mon, 15 Jun 2026
 22:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 15:37:18 +1000
X-Gm-Features: AVVi8CepJSERSEEcvIrkW3C0kjRtmyqoZQBrG75f486f8udXUrNnyJLJhl6tqjo
Message-ID: <CAKmqyKMUN-iDhhAF176eZsVsdDd7_-soL4CYL0vYfxGHkFEKhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: parametrize debug trigger number
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Jun 11, 2026 at 10:34=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi,
>
> In this new version we're adding Phil's comments in v2, in particular
> the need for an unrealize() callback to free the stuff we're now
> allocating.
>
> Patches based on alistair/riscv-to-apply.next.

Hmm... I can't get this to apply. Mind resending?

Alistair

>
> Changes from v2:
> - patch 1 (new):
>   - add RISC-V CPU unrealize callback
> - patch 2 (former 1):
>   - free allocated debug trigger arrays during unrealize()
>   - change version_id and minimum_version from vmstate_debug
> - patch 3 (former 2):
>   - do not touch vmstate_debug version_id/minimum_version_id
>   - added Phil's R-b
> - v2 link: https://lore.kernel.org/qemu-devel/20260610205457.1868701-1-da=
niel.barboza@oss.qualcomm.com/
>
>
> Daniel Henrique Barboza (3):
>   target/riscv/cpu: add CPU unrealize callback
>   target/riscv: dynamic alloc of debug trigger arrays
>   target/riscv: add 'num-triggers' debug property
>
>  target/riscv/cpu.c     | 26 ++++++++++++++++++++++++
>  target/riscv/cpu.h     | 39 ++++++++++++++++++++++++++++-------
>  target/riscv/csr.c     |  2 +-
>  target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
>  target/riscv/debug.h   |  1 +
>  target/riscv/machine.c | 16 ++++++++++-----
>  6 files changed, 109 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>
>

