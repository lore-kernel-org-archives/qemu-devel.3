Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D359FCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL4k-0005LQ-7o; Thu, 15 Oct 2026 09:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL4S-000575-T2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:00:44 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL4Q-0002WK-T9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:00:32 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6767d92cde6so5394166d50.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792069228; cv=none;
 d=google.com; s=arc-20260327;
 b=CFsQXXjBVk8ekyRue0XF2g0+eZrT5bXhqMg6VzGQq5R5pcu0EJmTu8m6TOiDrr+2wl
 uaxtr/K3Cxz0dBWT1S/RF9ETUjU9gMo5Bk1Cseq5CTXRVp8IFWqR87Y/s20hNsct8YDe
 hILpAZsFCY4GaAECLw86Aa1BlZ+/2XVCBr2s1FLjAyerk/H7g0uvuH1Ta0MhGl9LuBDB
 JbKddFE0i+BY4QKu2aTVOJZsuOMG6oqj7lKMWm66WT2J+/fBwiTEZxTrt5Ow/esm3RKB
 dFvHpDMwXd7gfZHDQUGZWLrIjanzO5vvQ+GKxG7Yf3Ppjup9Cr0xfWLTTVfEjd1CkI5z
 79Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bn/3MWZ6+pzWmy5HApT88TUDX3P4dHWElt2hPV96Ees=;
 fh=Yrx4vQe00BZsIPxO4F8lg1/YapBrjycVHbvHsbUERps=;
 b=GON11ijuLtYgLPGTzi8biRNDGoFabqfLVOWw2pYQbgah0fVqB0DrkqZY6yl4tkxSnr
 kGdyjrf0/PH+i65/diadJ2qp7lu7mSz9uVW2dhlFfVRTFINCUkFUzLuMyqMWublGdLQB
 6p+1PiOsksVtr0cT18/u+o7xm8Vpn5YuWESAywmU7kOB8QXYGH6jV2EwqWgdg2HBKy1t
 Ka/qLhTpQtwxZemWZs7R9qUOcW0RXIXIxKpwEaTzV5DI28J5n6WhXsyFC0D9NEhQ+hlm
 mN1CGOErEAfVDXPglLeef1aMWpT/1EeZF0NCSeH6enYLejEZd6S6rewKf+zsL4t5AC8S
 ozlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069228; x=1792674028; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bn/3MWZ6+pzWmy5HApT88TUDX3P4dHWElt2hPV96Ees=;
 b=yJm0kXxVOxBieC+GEMYRFL++c387u5K3PLd9D0Z7WKW0W/a5zG0F9R5OoY3rpIP2iC
 8UlyAHUePlN7YnUJtUxhcPynLSYouJacXFgtHzs/s+Bs2DxdR2TCSiAObjb1277t/EGO
 /fnx4p70dGYz1b1OSWTFm5n7YtsQ6d8yiO7/QP8a7CJXzCYbtcKWlXqrPcR0yM87NT0D
 S7qlMHKELG6pGi5Tp6M9LihE+sJYIuOxGbRYXMDJ8g0uXd3Lo+DOAUk4Gynal4M4guQ7
 8scHvHHmWoBNfmmlprXVJk31CqAO5Yk6ylotHwwEbQTUxo+9dS8QVDlzfWC8ENQbQwnW
 2kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069228; x=1792674028;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bn/3MWZ6+pzWmy5HApT88TUDX3P4dHWElt2hPV96Ees=;
 b=ctJ92nj9t0I5UVjYjzy3DhP0UT6kohtixoqmUPc1UouCImURTe6K7ZYbxkFKJt8dXe
 fhX/jsI9wIDJ/7KjAeN5EOLBe5Vm2tBYOlLTTdeuQ6O1orh3fhNpeIvZUHGahQ/Nf3XI
 u6WEyfDONOgW9huNFivKqs/xYkUSbptNdk63qcqXhpqkknu8U4yij40cUIOP5z4OORJS
 6hv4+2qRtfUrPhSh1HRIyhYU0+QinCOH0VVZwlbm+a4mUrh+77RzEn83UVPBuuXuuOOL
 xqJPKVkeAXmLAv6jgwP9rXiBhD9ejy049n2xotu10byGOrvbGbLFr0wW0fZH+XUIGqDz
 2Lpw==
X-Gm-Message-State: AFq9FYJRUQtoibDVwIdEVnmrMzI5rqAY9ZOq0M7eF4Bz6hnmT+4IoqMm
 EBpv6FxvHPjrMR4f/7uFlsgU0JmD+fk1kWsCf/Ktsf2xcAWBwzGs/JPECrHufOq8gUGqzLlZbIq
 lRUc3lBnf9gEO1blmQlzH/HjmUYCYHGtnEqdKPPccoQ==
X-Gm-Gg: AYBFou2YMKJBGf4HFSr5N4LVsOtSoYFzVd2HXpFqemtO+y5TrkAAulMENKx5VdXeBtb
 pzXmkg8IfFj1oqyjWpYs8DWHzPRKC7kOlODasYnaf7dNqvihNykwpIY3/8KiP2rBe4CGgTTqP8q
 mr0R+cCT80YVdpexdaiE9DBRq5r8nxGqBuOC2p+13H31XVzeQnIVfhZGle1188MJHxUrCLs2jsW
 3/fdo8/ZZBgqKmoP2PMCE1ngL4TDQSHUaMzn0c1NwLy8YHFd57xD1PaVHbj9AWsKjndoLNBbmrt
 owsW8ebqiI+DL37Kgv2AWUhABk+WBCuPLHK7CDvYP5hC3YJHnSH8YjyA84ZXB0mZ2JBI8nNTal/
 pQVzVdXfkTECh9LAxLC4lFRPyg4tkDDeb8Qr0myY=
X-Received: by 2002:a05:690c:f04:b0:8b0:aba3:a3d1 with SMTP id
 00721157ae682-8b0aba3ab78mr44146037b3.54.1792069228245; Thu, 15 Oct 2026
 06:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260725012635.4925-5-marcelomanzo@gmail.com>
In-Reply-To: <20260725012635.4925-5-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 14:00:16 +0100
X-Gm-Features: AclHuK-Gv1nvvdERFlt0jDjABa3TPDTn7ppCfJRs3QZBT8d8G5bYw3ohfxm0faw
Message-ID: <CAFEAcA9SYNyjUnvf2S_8E82Jm+uOX2nLC=iYHktZHeqic2f+tQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/arm/bcm2838: enable BCM2838 thermal sensor
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sat, 25 Jul 2026 at 02:26, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Wire the BCM2838 thermal sensor (added in the previous patch) into
> the SoC: instantiate it in the peripherals block and map its
> register region at the real BCM2711 physical address.
>
> This is also the last device masked out of the raspi4b DTB, so drop
> the "brcm,bcm2711-thermal" node-removal entry -- and with it the
> whole nodes_to_remove[] mechanism in raspi4_modify_dtb(), which is
> now empty (GENET, PCIe, RNG200, and this thermal sensor were the
> only four devices it ever masked, and all four are now implemented).
>
> Adapted from patch 17/41 of Sergey Kambalin's Raspberry Pi 4B series
> (patchwork series 829638) against current QEMU master.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

