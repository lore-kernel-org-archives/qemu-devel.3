Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A56FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 23:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK36E-0007Y8-QU; Mon, 04 May 2026 19:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK363-0007X9-6k
 for qemu-devel@nongnu.org; Mon, 04 May 2026 19:53:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK360-0001fd-A7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 19:53:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35fb0bb27e7so2989912a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777938783; x=1778543583; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iXXzTgA5ctfsDhwTjZo6M38mWjlSEtUHICd53GcUrts=;
 b=f35SBDCoKp/HeoefzLUyZyabS1H6dPxIa5bIoV9ChdD5kBaJ+4N6kfN8+TiUX3R9D1
 axPHf6LX4LJJpwAbHUBFMNjFo4nTbSDrlI42XAq0y9UYaF+AYfP/jFVv7mVYrj+IqCOJ
 jK3JOhXtCF5MNte3An4ClPy0VMfqzB4HtFzxLdEQDm/q9e6Zag3utxz8kan1lbBrG4I/
 ArF84Mr/6p3hVb+dwDwENChyEVb7V5pmA/YPNE5dRQk/Bwefzg0AKLA6uufFYRhC9Xkg
 6StmAc8lNRrG/8gJLGpBuhQe9N+pWHZCcGIO9Xox8BlTqtABbawUhSb0gGKNg0S4509h
 sINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777938783; x=1778543583;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXXzTgA5ctfsDhwTjZo6M38mWjlSEtUHICd53GcUrts=;
 b=B1oZ9dDyLmqoIO7AdCMghnFwFxXjQ+frqPiIxJajIslOxbsh9Hu/8ZfqqoSbB5vB5m
 FBw9hsfFMWoVTYrbSNEoIy41/j1YQdAUiytd2oMcZJ8gbSfP4J29lfE/I5gPjaHoXtcq
 kZCcG+w9vUQJBl+BwLicouli+m382QuLB9A1cE9Wv0n/l9A0dWcy0LaxQqDaxX+ynSxA
 bgUnz5M0C2SnVnGT8OGY9D/3Fn4z/cUJO5njir0CYRe94E51+gKqOmtHU7QLYgGauUAg
 7B5zacQEGQoSMLol3TbgVTcRp7smA353cMGwWQq9jN8McmYFkijjCqPSQDGE9UE2EjJH
 uFVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fv5W9JBDeV+5o3S6fAntnpMBydB8eZ9Ww29EsPHC2MWghHBMIFRUnfNAXQiDyZrJQusj427gUAcjp@nongnu.org
X-Gm-Message-State: AOJu0YwdIRK99vz8dMqDHugeZdPfhAn/F5xkQqF5q6/a7qHBBcXs9AF7
 WwgCERCtEdlfkW6OmibD7+gxNNGlrtfkSr0d1JJ5sLSEf1WOhgHjHfWt
X-Gm-Gg: AeBDieukLivKdYHTCJPoPO7Hg67CWgIDtjxotgEtUpOgHjgZDOWXm5jCJtoCPSLeXWu
 uF/IjzWkNMInJdNJj7SyMR4IcgFUEdoGZPq9BY5T5OSA42hf2gJIyu5hesxYTw2vXYxNDsFn6+f
 uJyf1Wgx5LHvgTjfH3Cvo8Lrpy3ntLQiJuH61vN8n3rexWGCWZIW4xtFRJpX9fH02kkwiPti24X
 /8wEGNWjqNZG4OyJnu+Ifbgu89qr32oNJUYoWhdYbsLcPWDAdbAJJuzvVHOiF7oXxn8uTRzWiKv
 yYlDGzMc3fZP3qvU3JgHa4vjrOvEd0sjizWlnxy0E8vkMH8b4w3hfAc/Y/19agDX0c+cmzXTG3y
 nA6JA25iPADtRbtGEzkbSL//QPnVFnBvz0tpcX9z6qJDuaDN1UWvjD41FMKUdRIE7bwdSh1d6SF
 ks8U3XdlDmGkYHrL3xowmWs6Ht/4DsXqKiiVyqnGRzx4k=
X-Received: by 2002:a17:90b:1648:b0:35b:e4f8:7cc7 with SMTP id
 98e67ed59e1d1-3650ce2358amr11068820a91.17.1777938782791; 
 Mon, 04 May 2026 16:53:02 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec736dsm12765467a91.3.2026.05.04.16.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 16:53:01 -0700 (PDT)
Date: Tue, 5 May 2026 09:52:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/13] hw/riscv/boot: Provide a simple halting payload
Message-ID: <afkvnrQveMGC1lcE@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-5-joel@jms.id.au>
 <CAKmqyKNiJ9hGQVPsq8pEz8ydEWydW=umT4XwWanwk-etADgf_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNiJ9hGQVPsq8pEz8ydEWydW=umT4XwWanwk-etADgf_Q@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 30, 2026 at 09:35:33AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:21 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > OpenSBI hangs before any console output if the domain init code sees the
> > next stage is not in an executable region.
> 
> That's an OpenSBI bug though and needs to be fixed there and not just
> hacked around in QEMU.

You're right of course. OpenSBI has other no-output crash cases in early
boot code (not just this), so it would be nice to fix properly. It wasn't
trivial to fix (IIRC because serial device is not detected before a
bunch of the early failures), I have some hacks, but I need to go back
and come up with something nicer.

This is only related to Atlantis by coincidence of the physical address
map. It can be dropped out of the series.

Thanks,
Nick

