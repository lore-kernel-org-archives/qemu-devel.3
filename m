Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3030FCD0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ihk-0003Xm-LP; Wed, 18 Mar 2026 00:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1w2ihg-0003XC-U1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 00:40:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1w2ihf-0002sY-4m
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 00:40:20 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-667f8794e97so134164a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 21:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773808815; cv=none;
 d=google.com; s=arc-20240605;
 b=aRtr/3hriYXLF0p5IMQNNeu3RBeg7nsNd1/ebaKm1Z53XsHnyTnvf2ZDldj2QbA3cT
 hOypLvS9uA+29hC6tC4tvRpRBH3rG9lRhHpnOgMnlfMcQxiNV8xWMn5KFAD/oEXk9EH8
 0rHJb0eVynllD7DwB3ZPX63OioMPOq03ynHeW6FpaauZ7zVskiP8UQWMHzqzhRRmebWW
 i+JosPq5WNu2vW+9nL2J7B3aXgEmkkVV3e2eN4VIjhxoUVqA9PDmVYKtGkBZK6Qu3yi9
 EGBDB6lnenLaXusgFXZBr/j4s8eR/IuIETa7BHBtaufRyLtD8DKLBG8yBoHYXAfwPFtV
 +yGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vuwIiXqAxMx++vD693Uzn3ZjQfSxf49VPGnUdkE+Wo8=;
 fh=bu2ZrHDXs3FhRCEK57XcXWlfhM8WXuf6PCAcBelvNxU=;
 b=A7jAjePnUG1qIt/zSHdC09rZCZ2YhT3zt2NGfiGvoAf4wK5aOCKAOhldZayZ6d/5HD
 ajtxMhL3yPHxhv/BYYnDgz2gZxcTpKnqR84bZVFGVMxiALVWeyhRODpeDbLMRQBlebVy
 B/guyblKQOAOeE3tGR9RNXZ029ZxrfjomRhNsez1OhIVofACz5Gy4harfnwvDw0CU0nG
 m6xJizefox//MKVC+Ks9n8zAVmy/tCDrbBOH9tbBDkZFgilTYa/mEd5/XeXPHoQHkmpX
 sWC/EOS/a2fSKc0pIGLMvS2+9Hiapv/sgitKVMoT066oYFQG5xkr/EW8OASzGHGCPUX/
 lZdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773808815; x=1774413615; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuwIiXqAxMx++vD693Uzn3ZjQfSxf49VPGnUdkE+Wo8=;
 b=Ernb1LG8vTmNv7wdkGC0e614jouEpt8YUz2ZyH8iHGH0BrgXr50Jfix/lZCmM+evle
 +bIHgzqnNm3hgFwIMLeFeJELM17x1Eqln5yyu9LyBsMzdYC/dAYLq6Q7xx+jub9JGN3r
 z1nwsIgxehQBSqDgWRRcqA8xEJT8O9FcdDxTwqVYcHzpWdi8nQ+SlLlF2hxd7hJGLsU+
 VEtePXtc1k0GPpBazQb4BKxkBTiGE0+pB5HV00l70OkU9envk7IFXN5NIG7pHO8GTP77
 80RHUopTln7h12PZeiR9XAhqLgDIN1BJ/1DsFV0rO3a1KbRavHAQVUvci+Wp0duccA+J
 ub0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773808815; x=1774413615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vuwIiXqAxMx++vD693Uzn3ZjQfSxf49VPGnUdkE+Wo8=;
 b=UL0d/2E4ILDldAP8hOgksN+IdGzdL9FN6W5DgNJRn3ailmZdtK5w2R7d1LyqZSfmNb
 +cAZT4tdjLgCiQQ7H/xQ0SsZQMehgUEwcmsdGe49xh1I6a24ucH0DTqTxtEmFDDgs7xB
 n+1EOIvLoXpNxLuLPWAd2me4TcdzobPBJ9+wzYaWb+DUJlpvAIYs24nor4fepK8Uxvnl
 lS6nNJV7GNwWglLRowviBYtdzG4E7s2OtrvY9J57N3AX0kfLSPMXSV6BRwY2tXucVNjo
 rWubPOl50uN/tutgn0FkjipOB9ude03VFSGCZKjh8Y1ZcoUM5mI8r3yCmwLYfPW1eD+8
 frCw==
X-Gm-Message-State: AOJu0Yy7ODXYz2PO7xP75TvDy65/fdIXSuUbRh/eN3UKtcysCFR1NlH0
 Gjh+ncO6Pho11Q5RBFTXOKGRaops3LbNUCJ39fg71v50E3CCFUm7QFz45c0zadSzdnrGFhANUWZ
 +ui9KMok+nMb9lXQe/CV6pJnskkS1IUUmII/A+ufbPA==
X-Gm-Gg: ATEYQzw+HTKlwRW9kCZOaWA10vmMoBRqAb/YCXbjnuf7ulmJCpBPaMTLrZ6CC7Jx8Gy
 9eZKLQqegCvtoBvGoObrZBS/6cAsHk20/McFGHKcuPr1kj1ZIWSUpSDTwMgWsnTu05rB/JQkqP4
 riuC/I/7VDB1/YGvOESeIAt5yowjwtaiuKv/0yBFCS1W+Pcb3TlMFDNi9ygFt1d2IEnlcZzDrFE
 CYl7JhpsoXa3owI73zUrG/79qfrHbIkfCeXICW2RpRoCWTHySXwSgC9BTn/8G3v0MTCrOsGm2f9
 fTDq75VW5w==
X-Received: by 2002:a05:6402:42cb:b0:665:57ca:901e with SMTP id
 4fb4d7f45d1cf-667b2ff7955mr1269890a12.15.1773808815538; Tue, 17 Mar 2026
 21:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
In-Reply-To: <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 18 Mar 2026 12:40:03 +0800
X-Gm-Features: AaiRm51wIubBE7texOWWV6r0g_bGK-xy3Ou-gZXq-51NaL_xlR0blBfA2C6dXF8
Message-ID: <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Feb 10, 2026 at 8:25=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
...
> Hmm.  This really overlaps the secure and space fields from arm, and poss=
ibly some of the
> others as well (e.g. user, requester_id, pid).
>
> I don't really have a good suggestion for that right now, but it would be=
 nice to not keep
> expanding the count of these sorts of fields that somehow specify the ori=
ginator, but
> clearly cannot overlap.
>
> I'm reasonably sure we've had this discussion before, but nothing has com=
e of it.
>
> Time to paint the bikeshed again?
>

I can union the 'secure' and 'world_id' fields, as they are not used togeth=
er.
However, I have no idea about the 'space' fields.

I have seen CPUTLBEntryFull has the extra union to support ARM-specific mem=
bers.
Another idea is that also adding the extra union to MemTxAttrs to
place the RISC-V worid_id.
We can use this extra union to as SoC-specific signals in the bus,
like AXI AxUSER signal.
Do you think it is suitable?


Thanks,

Jim

