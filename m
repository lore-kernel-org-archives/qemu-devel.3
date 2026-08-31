Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D787C61DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uud-0007tO-Cz; Mon, 31 Aug 2026 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0uub-0007s1-Ea
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:50:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0uuZ-0002Eg-Ew
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:50:29 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66e611e7c05so942188d50.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788155426; cv=none;
 d=google.com; s=arc-20260327;
 b=UcukuAofq1hP5YOi/PcjtfYLNT0IrkuzLRMB42H4BMkf1rQyciKp4vgg9JqeYxFp8Y
 BNQZbWdgdtHSo2oy7grniIqA5+/BtbDcd0iY0neD03xmcCdEqgnV2lJBa751wxBX9Vow
 NayAFM+J69cI+FdMV07EH94wyDlTE6fEHw1/KPpk6TiwZFkCkfH8KSoF26L8aCIrhehV
 SGu+9kM24vYvuZHjzsd+kxwntlmijxbz3CWynO135iFEpK8psyl9D28DkTAUdrYx8mPI
 KbZOjNPuVV8iAhLv7BdLa26WrBu6urcjseveoPfQJ4H3bHRIwluxeWGDxZ7zp287ehzS
 8YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TrDTqsDtksxcqWEKP5dvuqCGL81ZMfNxkLMJwHT9lmo=;
 fh=nAqUQokshAIaeQaZ2cXSNWwJwe2W/adkQN3Ye3tofOE=;
 b=Kkztc/0fLI9AMbLkUP2dDFDVhsT+cabmJ4B6AFv02/XAI2p+P57V2DtYvK3rc7ivSh
 U54pNKcmrNyHykiW2n8wfmUx42zUdM0mieTChj3xxKS+CkZUJDfSbdRQbYsd72IZoAQO
 BIjsiwIdVa+qTjW1wLRXC9joPRdk90sLl1z7ZfEcdGAxce35u3bwkIlSNBNvHd3ZeWku
 1kA7kXRQ9/JdgbyJN7NV1ovAtOSNOWDXP05c5tbrIaNAft9SUib+camYDqdFzF5BCv2m
 v2d5UlB02A1MVxEXNsGGv8DGF4OY1Fj3M52kiUI+mylx8LIkwhTpXtpnr0/URZCb+6k5
 pB2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788155426; x=1788760226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TrDTqsDtksxcqWEKP5dvuqCGL81ZMfNxkLMJwHT9lmo=;
 b=jqhugEjp/oNRClf7iVeIABdad4osZ5ewl5D4kQ+iXMJHqbMS2ssMehTOytVD4IDH8J
 v5kM7gQlzwRWUxEqU5g4s1l+cCk5YSYOgtZ+r84fX9SlWLkO6EkngtTf6+ITH1ICaJEE
 0O5dW111cPQT3HrnbzhZsdRxI92lqUmHpynZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788155426; x=1788760226;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TrDTqsDtksxcqWEKP5dvuqCGL81ZMfNxkLMJwHT9lmo=;
 b=kTEPrz5muXUoL6WqxqGl3H5mtm3J7Pp3ULBm9chQDYxE8hpRNuMvmUJZBgf2HwZVe1
 RwkYRROyXBZ4aebcvAD/2Iwl0rxE1VKONl9doq/nu9IWcFBQu2PhIui8gEtdEF1v1gKM
 tsq/jfqRTAa2Wu5zNmuG/wBHHsTQ9LACrriAxzr4N3w8ntR+4KlAuy+BHcJa6y3d+Brn
 QrpSstnNj3N+9ZwetwtsOFCFw6rd9UWy2nc5/lIhdhhoLLZhiCHWZYz6wUCOffSj5bM4
 wc+ggyaiwnPX70Ahb7wgikxeks23SH8syBvFPLMh5wgyQdQpv7mCRd3xh3Ok/GcslA4I
 Q45Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiolZ7WsjtYa97TWWcttOf2/EISf7Tpurh3LuXOPNt0gls5DEFXnPL23INeDBOC+44gGemG/KX6hbo@nongnu.org
X-Gm-Message-State: AFuF++mlGvQ6GkkUu/5wE0sl1HzTgt8kplxr0WsXKaHbS0WCbESR5JPr
 6lgHl2KVP33ZSgGEHEkU/y135FjH8cL0ioe8WujCssv5o+BJ86aGXAF1qjp0vrekCDfihv/HSib
 ikAysmoXP2BAi82h2BLMxTfiXKMVdKEc=
X-Gm-Gg: AYBFou2hFrDhaMdOS2QxiAre4G4zhP56kxbYajV4wVFMhtV2bDs44TXfa7/bdzoxRRi
 sgJpnCh+L4Wua7Zb2fe4zglJXkMK/HflKgDAFICA2SjhTBto79SLeVXZnsKorxm01bnrNHOh3x0
 WB4dvizbIL3L6UIlLBKbXDoMf4Llj2UybAFWWyVxnpzSNpciCRWfQ8U0c2yElNKSu+/N78VjEuC
 B9wgWp8jZ23xkHgyl8jrO2//DrtkFXs6Bvq/uaw7awanyocl8Z/QfKkzX7JOUN7hUQmncGGP5vU
 6sTe0tBqvAR0sz0sAPkXkzwIQyJtdUHiy4yqlMCBMW9EBGK6021nlwukt7v9gRWICDmPcacC52x
 Yerpa1eZe7pPsY2Kbxq8eX7rv+qBkqPO+Zff9Ygsp4yp7oLUdx6689FBbmaUGli5AEfIKvb4kny
 xstbKPzzKfoaFRRrKo
X-Received: by 2002:a05:690e:4191:b0:66e:64b4:3444 with SMTP id
 956f58d0204a3-66f813863c3mr397785d50.9.1788155426042; Sun, 30 Aug 2026
 22:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-7-joel@jms.id.au>
 <b6dde536-bc21-48b3-91c1-03bf900b1e5d@oss.qualcomm.com>
In-Reply-To: <b6dde536-bc21-48b3-91c1-03bf900b1e5d@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Aug 2026 15:20:14 +0930
X-Gm-Features: AcwNN1XsYWA2vlSJHzh-IxSD1Up_ywmKh0yZ6ClV7Ykw0ObPKNncJskpX3IM8XM
Message-ID: <CACPK8XcOwv4JLrO-UnbJWoi_jgkARBZ=DMFf7_6RWs2QLiX4Mg@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 31 Aug 2026 at 14:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 31/8/26 04:14, Joel Stanley wrote:
> > The CPS device maps some devices into a container region, but the
> > ACLINT and APLIC were mapped directly to system_memory.
> >
> > Pass the container memory region to the interrupt controller helpers so
> > all CPS devices live in the container. The location of devices in memor=
y
> > for the boston-aia machine is unchanged.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >   hw/riscv/cps.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
>
> (I'd have expected this as 1st patch in this series)

This is a fix that is enabled by the first four patches; only possible
now that we can pass a MemoryRegion.

So the first few patches modify the cps machine to pass
system_memory() to preserve behaviour. Then this patch switches them
over to use the container.

Usually a no-no, modifying a line that was modified in an earlier
patch. I could fold this change into the first few patches, but then
the change in behaviour wouldn't have been as clear to reviewers.

Cheers,

Joel

