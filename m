Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F67C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm45p-0001to-6m; Tue, 21 Jul 2026 02:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wm45j-0001rh-Ci
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:36:37 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wm45h-0004PZ-Py
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:36:35 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a381bec3f4so7090702eaf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784615792; cv=none;
 d=google.com; s=arc-20260327;
 b=nEwRHALhNbZgsEsWGUzRHRNMFtSSWQ3m9IpQpj/r4AgWVZZyMSnevHWEh/6eVSmnjj
 YSVtAukCl71FZKFgnecxYA0lwoBgc6Fw1pFnNDP96oQobcRDlXFAhOZ26OwN9rS1LWv5
 /l/i4v9HioDkYR1Vplw0ZaDCPiruZddJq+pEUEN/o3tgKre4Jt7AVUHeHLgC1eJ6kawi
 reDvwLttdLxyCASco5L3hR787bGZfk4symzomuPIHtrh7qvaaIfhRGIfdKwirtiFTkhr
 k4aVx2FuHqSl3jwdLVT2skffYo1XKTUX/0XWKLB1xJJP2/oikodqilGtyJPsyqVTH+I5
 +iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LmlgzZqlI/7CETKV9QdjUehLc+l/GSfoUdaynNXB6m8=;
 fh=fFeJ78lFa9lnCpPghx2AxVWoi5ye4Cd0cxKXNwuO4CU=;
 b=tBJWmslj0YNpuHKkQGolM3BL48WaE8f8JjWj+P3E5S+uEekfo6Nkmj2Cp9k7o5fDRs
 vFExOX2nSwRZh8reUDnq/58RUXOYJWdC/BIa+im9htB4W1IU59rztLtMK3olFmeDzZnO
 JDWOYpzqvyuZcgWBw0kxFlTsFMHuycPkxkSwBzF+xZjX3tA7vJL3VFzGTdWRpOJvKNuv
 BjWXB5q8Oi38k+CTe7LbHeRs/AxeR3hPmzoDVBoqtvQjORrfdumF3Adj0+NQb2mepT/i
 Kqtjss/7p9xKaMkeU72M4tNgIiXKU7HXaRfp1Vnmw+EAf0SSME0SRhqXggnsSXAw9rSH
 teuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784615792; x=1785220592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LmlgzZqlI/7CETKV9QdjUehLc+l/GSfoUdaynNXB6m8=;
 b=nLUs47c2iooLd1njWAfa6LImoMZuaXjG35qRLLBUevhZ40qMCsNURTpzWOsbpq+g8X
 AYhL1a0AEwdtK1QHOMBwkzeTtajxY1OZ2NVemv8lmW2qntrLNpM0gHgy98tTUsIPRsIg
 VxtRyVQJ6x5KhvwJ2cd5BWbKdApnePppBdMXULCMZ9pqRQLmqtwOdYpmzEvhQ9bJkZne
 QDqKiCXiubMWhowzx60FdU6L5zWHySKJMqCSlfZoe8VP/SwgGyTchigT6TFgkY55jBCp
 WhRZuP6CCNd5DNwrcd9FTX59bAWUZWLmfeqQjmV5pWKBGbGtJReXTuXfmZfqf26NQkTZ
 kn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615792; x=1785220592;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LmlgzZqlI/7CETKV9QdjUehLc+l/GSfoUdaynNXB6m8=;
 b=GPaIxM9Hf1Hl+yNz7ylhR5dTx19OK+b8bvIlNUROxkmgT3vIRaJmr0o10k094NkaJ7
 MHvC/Hw1wGrhjpjSkprf2rnA6g5R4Zn84IpVPqle5JENKo2wjxv2d4IDRt++4FmJ2REA
 VyTGNVThamenrASokAeajKKU4DwQiHlsRx5Fy5i9z47uoEhlDN2nNAuxWVri1+77t305
 Nueiv1givXNRFNCqlX9Ds2VdaEIJaf8ybsObzCtA8FLU/QUVA3+bCDKWb7Wrk4jDrHe6
 Nfkx5VlRnpi9n+qHrhrFmoMkCGZg1vaEhw+5vZ0a6aWSRBwnXXOyC9LJO0KO0i4z7Ti3
 6RIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOl5Zw8h+gP0VXg7E4KR165h1U9ru/Z2bsdvIlfYXhuiV7F7raMYmIP8NT9S1BVbnOjsjL+CVuUAJi@nongnu.org
X-Gm-Message-State: AOJu0YwGmVViO9nZsMSBiFpv7B0P0NolqTzfXutY3UumkGlo1xbNRbHD
 pTtfOYOuBLVyZM9Dy34USgwyIOQwI6PuX68E4c/qRS1pNm1HsXRaTSen+47pxlCJII3gkmGTlrq
 A89xDevddM/oHfN3QDyIAbMlV2NVniaN8cEUVEpqS9Q==
X-Gm-Gg: AfdE7cmC7lKQC6BAwOeFQjDgjCtf7IIDW8uKpfS00K8BGf1CtsW0z3WAqTGPvr3rDjl
 Xn8geh3e4I/lwWCpCR13wFGbJpJj+HijGkfnKjIzTr3QZpvPRIl7/jWD/towBNaAG2hwsh6TIbP
 XiZ14T5hMndiRQc+SikNeMr+Zn7K8XDLr2WZijqE8JxAsDTsrwCe/CxhALbq+wNmAbolbZPyavx
 veexV22eaSlLE/k4ATMbCh4MK6cFAnwutj+2CVdjKOBJ0gLWmt+RradUJtbkcZjxeq9hrBM458=
X-Received: by 2002:a05:6820:1507:b0:6a3:8611:8ef5 with SMTP id
 006d021491bc7-6a53668e887mr9047848eaf.1.1784615792056; Mon, 20 Jul 2026
 23:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
 <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
 <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
 <CALw707pP_5a_EeUQLRw51nLCoFo4vKkKPGaVtJJdWEqR8K-u-A@mail.gmail.com>
 <CAFEAcA8V-eNMTF6dmR2AHwSjWj_MWaijgG_inepf62BRLYo8DQ@mail.gmail.com>
 <CALw707pb5iKy-CAnVn-npdP8NRGwaz+yZKGi2ZbjafqNLNJtKw@mail.gmail.com>
 <CALw707ozF4se+s7CUYNHY+f7xHCc5mqMiQQf+GK8eM1WrjN1qg@mail.gmail.com>
 <CAFEAcA-O1OsvisDF9CiFXvKS-2FDG=+mrxU27w+HfyQpRiF1eQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-O1OsvisDF9CiFXvKS-2FDG=+mrxU27w+HfyQpRiF1eQ@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 21 Jul 2026 14:36:20 +0800
X-Gm-Features: AUfX_myDm4gBheCEKEYTTx9bhYJJyGHtHRBrPS1l5akgnJea0zWVQsiv-BO1IBk
Message-ID: <CALw707rzojpHmatHeP5LJqhEcvd8ZiU=a2+EC23H3nvS=yZf1Q@mail.gmail.com>
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=jim.shu@sifive.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jul 17, 2026 at 4:59=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 16 Jul 2026 at 04:12, Jim Shu <jim.shu@sifive.com> wrote:
> >

> >
> > Thanks for mentioning it! I think re-use requester_id is better.
> > Then, I think we only need a boolean flag `src_is_cpu` and we can
> > rename it to `requester_is_cpu` to match the naming of `requester_id`.
>
> But, what do you now want it for? If we put the world ID in the
> MemTxAttrs, do you still need a CPU ID? (There are some situations
> where it might be useful, but if we don't need it right now we
> shouldn't put doing that rework in the path of implementing
> the worldguard work you want to do.)

Yes, Adding the world ID to MemTxAttrs is totally enough for me and
the worldguard patch series.
I just explain the idea if someone still wants to use CPU ID.
Sorry for the confusion.
I will try to add a field that combines ARM secure/space and RISC-V
World ID bits in the next series.

> > > > > The whole plan is to add the following 2 fields
> > > > > ::
> > > > >     unsigned int src_is_cpu:1;
> > > > >     uint16_t src_cpu_id;
> > > > >
> > > > > src_cpu_id is the CPU ID from 'CPUState->cpu_index'. src_is_cpu i=
s a boolean flag to check if the transaction is from CPU.
> > > > >
> > > > > Moreover, I think this idea is extensible. DMA device transaction=
s can also have security attributes like world_id. We can also add src_devi=
ce field to 'MemTxAttr' to store the 'DeviceState *', so we can get the Dev=
iceState from MemTxAttr to get security attributes. If 'DeviceState *' is t=
oo large to add to 'MemTxAttr', re-use requester_id as DMA device ID is ano=
ther possible method to support this.
> > > >
> > > > I don't think that having the thing that receives the memory
> > > > transaction get or get hold of a pointer to the source of the
> > > > transaction that it then uses to get the world ID is a good idea.
> > > > (Especially not putting a DeviceState* into MemTxAttrs: the
> > > > size of the type needs to be kept small so we can conveniently
> > > > pass it around by value: we currently assert that it is 8 bytes.)
> >
> > OK, I think store the DMA device ID in the `requester_id` is another
> > way to keep the small size.
> > However, IIUC, the current SysbusDevice doesn't have the concept of a
> > device ID. We need to add an additional device ID to the device to
> > support this idea.
>
> What exactly is it that you need a device ID for? Earlier you
> suggest that you would want it to get the world ID -- but we
> should just put the world ID directly in the MemTxAttrs.

Same as previous responce. Adding the world ID is enough for me.
Sorry for the confusion.


Thanks,
Jim

