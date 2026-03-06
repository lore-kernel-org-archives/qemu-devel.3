Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E454F513EB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 00:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyJDe-0004l9-UE; Thu, 05 Mar 2026 19:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vyJDe-0004kY-5C
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 19:39:06 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vyJDY-00072C-E2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 19:39:05 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so1506737566b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 16:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772757538; cv=none;
 d=google.com; s=arc-20240605;
 b=c/XBQsip4dUjCHArkwrsREOXTm5uaa/30+sU5iuDVfg33y0MWq56HF5DRtNQhQYbkf
 tqcR+xf2SlXCChMLK4SZape/PDQ6kpEegHN8epInZqF2+wFsaUJ7XufU3M1M8B3fbMmR
 HV8ymTVS6+RT2eRsy1ilpUf0W7cUatR7WmnycIFLpcRFacx7zPcgOB0UhYCtXBaLCf6W
 UCyFYhDSw/NON3GMOLuC5XlV7G3NHj8qtExY0NgmI3Ew6xSSSJTRzy/uTFafTR1bawIp
 4ljZSq2JLjN3sYecJkEYDVrgy3//Q2fyN4rz/28NkCHbHF9xYh8M1ROn4gvSkU3F6FUX
 bvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W64aGoKV2TIGzj1uGYg5Rwe4coezONWnzMM4qngmji4=;
 fh=HVnzJEYLTS/kVUhzdIEU09Lnd0d+Qjim5DebhNH1g4o=;
 b=KXzsvTyUZ+BVfY9QVdj0tWMeqy6qsxzbvEcAHhp75IUw1KKLkDwBM6gAPkEQzpes0I
 ONtjpc1q2KG9JMasYWeMScICN2eZ1tm68U8iN1S2XlBoO/hl4OVb6uHYbIpyF6vn8iZk
 0xPrzECkUgcTZNRU6S+wYe/a8CVxMgMimGBZpc6sWCVFVtQWl44Ezahkxo1aJ2L/2Pta
 3CeJo47PTLeErC8xyg4FfIq/t24B5keMmEXghV4ni+Xc+ElFGX322jDhj/8sjRvsCS75
 hQLtLvkPdJuSFJLWk4UZlHR6yaBEioLZYYLh0mwXEFZnqUcZ+624YVjtr51dssCmcH74
 WIgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772757538; x=1773362338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W64aGoKV2TIGzj1uGYg5Rwe4coezONWnzMM4qngmji4=;
 b=Iv+4+JupTP7TouhaOcgjWDUC5LCzdy3c8fsk2fIzVyoUQM0GDBSwFDbtOIeJfmpTfw
 SHBELuoUT1dmVF1Md0c6Cl6vmwESYtQ0+QNVV3OhXsQgH7RFagfMvVqNsNaXzznAjiiq
 zbY/9KkygVwEQkxjSkNAxkq4zUw+5WxRP4P6EdarsStOMhKB1JuK/1tz91hLz/13Dl+K
 oKOndG6MpfM1fSJNtCJcG9J/0HRZfEC81es/V+MGQ3RQciAIJDgARGHEwxeJqgn0NGHF
 ABziT4aWrB2HGXTLC9LFzilWeXcHJKX6d85DkPywjFV3minzvDZ3XKUyVrSnsMaYbQk9
 GJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772757538; x=1773362338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W64aGoKV2TIGzj1uGYg5Rwe4coezONWnzMM4qngmji4=;
 b=sbu+QIitWXVd9VIu6hzcl1fNoykqZpxrZGCNuLYxIPN8sV/nfTQsU+N7F8KmQLGhq/
 S9a8qIrioclG+r4D5vXSzdK9i6D4XZgiv5hLjLfqTPzj27/tB9y7CkdfLwOQSNxyd7PW
 ViT7AN04nrgeixC/F4HkLfZM7yK7K2bVZfRZy04DK9UhdoY8+98CjeFlch6NbJsb73Oi
 UK5jq44ZWQAavKe2gQ3IUc5yzrSweHl8r28Wh9+EtRL4rAil1VQsQuC9wG4/4INrLDKi
 5dd/dHm78/ziFRciT119wMqr35YEal4Op9aw3iia3TDNYqplwGlYtQfinD8LxzjJ6QXb
 9oUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW95pGPK23Y9FYvv/sDJRUinAFfdrxWwdK3PSCdLCI5oy+qeLbB/U++amJOpODcXd644SR8I3bXENRV@nongnu.org
X-Gm-Message-State: AOJu0YzBfSuelXFhK5q+KcS0KaUsiwm3ZYfyRSubhTCvUOr/bQlpcR+v
 XvDdq4tIXqxg/mglVfJ/F45ecDaSVsUPrh+3CVRXKb61IMp8Oc2Ybn9+sFPd3odaFwvoutEbAXP
 Z3RC45xSYgGqusBLfpRUTK+ajs3IjlLg=
X-Gm-Gg: ATEYQzwMF4+6r0MbOMsWvYFeBv5xOSoSc8tHecnpAkalMByrVTmTbBYrlT7CHuZyrOO
 dHJZDplVV5IjhcQ/kPibpTNRe2eCHVt9AgrrHaOow5UJrDY6zXHGVOFG8GLPZrHRZCR3IDN0nDw
 fSJ0nY5+KpVrE8NymPxYrQNazdh+3ODFQXpzJQJPHXE1awKVR+fSnNFKw+xpEuFx1E/Z5cIFbQF
 w88Gnu23IqsDTS2HkmLkYsleOMW/wBm+6TRzPH8LZknH7ZEY48OcVfXlqxu+SsQmEvUsIr9EfHg
 fuW//q88easPLDfK6nAkzeC8VVA7OvN+mLq+eA==
X-Received: by 2002:a17:907:6e9e:b0:b93:88f8:9cc with SMTP id
 a640c23a62f3a-b942dbb8e48mr9344366b.16.1772757537782; Thu, 05 Mar 2026
 16:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20260304121113.117299-1-james.wainwright@lowrisc.org>
 <20260304121113.117299-3-james.wainwright@lowrisc.org>
 <CAKmqyKN6szjMFhctNsV7EvLXnXanERRFoE8ri3woALrnCHL93Q@mail.gmail.com>
 <CAFFhqSvjMegTx5uQK-wZaiCJ3=nVizmgDWzePtMBKQOfmZxojg@mail.gmail.com>
In-Reply-To: <CAFFhqSvjMegTx5uQK-wZaiCJ3=nVizmgDWzePtMBKQOfmZxojg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Mar 2026 10:38:30 +1000
X-Gm-Features: AaiRm52DcprUCyEOPVwOgqQZe9_11P_olB7Zfs4cIQvVcuHwK8Bssy1dQf1syoM
Message-ID: <CAKmqyKM0GVY0+Hm4BWCSzKa=Z-iYORw=7UNSvpCOkhVyg+TPMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: add unratified RISC-V Zbr0p93 ext
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Fri, Mar 6, 2026 at 4:00=E2=80=AFAM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> > We don't have a policy on what to do with deprecated draft extensions,
> but I'm reluctant to add these. At some point in the future they will
> conflict with a ratified extension, which will cause all sorts of
> issues.
>
> Agreed, it's not ideal. FWIW it looks like OpenTitan is moving to use the=
 ratified `clmul` instructions to implement CRC32 going forward (https://gi=
thub.com/lowRISC/opentitan/pull/28511 and https://github.com/lowRISC/openti=
tan/pull/29200) but the Earl Grey chip has already been taped out with Zbr =
instructions in the ROM, so it would be nice if we could emulate that upstr=
eam.
>
> Does the extension being implemented as experimental and opt-in help, sim=
ilar to how `X` extensions share an encoding space? It seems unlikely for m=
achines other than Earl Grey to use Zbr0p93.
>
> > These should probably just be a vendor specific thing
>
> It's a shame that it's in the ratified encoding space or it would already=
 be like a vendor extension.

You should still be able to support it, just structure it and name it
as a vendor extension in QEMU instead of a standard RISC-V extension.

Alistair

