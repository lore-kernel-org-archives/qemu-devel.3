Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D4BFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4ki-0005QL-CJ; Mon, 04 May 2026 21:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK4kY-0005P9-Pc
 for qemu-devel@nongnu.org; Mon, 04 May 2026 21:39:05 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK4kU-0003sZ-IA
 for qemu-devel@nongnu.org; Mon, 04 May 2026 21:39:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c8026aa4d53so1259509a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777945137; x=1778549937; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R9fzSS/mZ6X5epkhdzAxQFiioXNyPDiL4MFDldFdpUg=;
 b=bUb0sFhY8ZGoF7DkUckajPTUDEqPC3TxU1s+9WL7Uh/OUb/tJbbmENc90k8CJF5ii9
 wif5S7mK4fZwrS3cwLwDNBHwOFlf89T9wuOfxpWpS9YIvekV4Lh8f4d3HEOJX70jktDl
 pfD4UTDm0HfClx3eeJ8scDRWW13twS/x3Fsk2nNAEM0DSeIr6HK8sn3k1PdJN1OqdXOj
 qMzrXDQHADqMcZ90er40JCK4f13+rTMhSKDG91Ry/Tk8IoKcqAQZkWc+T501F13VFGqC
 fkDkkhckAIgvXrthg9p8yJreeU8LsogoZEcd8wAw5duf1mkYymzugtXn9/eBt7Q9O/OM
 2HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777945137; x=1778549937;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9fzSS/mZ6X5epkhdzAxQFiioXNyPDiL4MFDldFdpUg=;
 b=TND4HyC32azLhiBWjQuAlWCLdvXK9f4VvW+Kjuup4OfRFBpo+C0qKqIkrEN31vOtei
 W+019P9+YuwNZ5eEww5/kJV9PhRkQxBdt7LgQdFTC+F4dt5N0b3qoZujixaVgwflj91i
 k9OrMzRiNWSn3gB1+rehXhYAxyu1zmaypEBrVC1jq6dlLNNRHKeIFBylPdxusUxm5M/R
 6dwxxkKIIUgCALbwmEmSmdR/ww1PWco5N+o3Z23qvUfDBwGiSk15dtcG749FbVLwjIlk
 kvH0QNYPVvRDrfkCpwjY8lySAuLp3TK34RyHlb3sGeT0FMg33w73ROxA6On0xWoTFgOY
 6E4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xEbBMtUXiRVF/M4AIfGkmxWMJM09D0nyXvgJcUqbuDlZE1D5KHG+qO9kZOe3vvL2a+wHGCkV88AKh@nongnu.org
X-Gm-Message-State: AOJu0YycYEFOKY1hI0hDpqKkLenzYWj8m1eNA1wiAXXRf3vGUvZjBRQk
 mdjXf6C586KNXCXL25ZTWTtI2sPY72PNPMfY2Fq8P04x91BTJTfKhrVs
X-Gm-Gg: AeBDievpt9VVxRSzu0eyj8ShHK4wLRLi8bjC37gXA9EulNiasvZtl7xXQKUWBhVoP5s
 n/+bW9FreG+CGoDBFDY8lAhvfPJdI3/2FbIvsadvpg4EKBulZGs2Y6iXenCMMZyV6VTR0v3QTPT
 xcNQ/fwnBiT5am3bEMLR4kVxhh5V1V9kbe/sPzqGE7S4L8e4DBDLkjdRXtpag958zjdnfwu3zov
 Ibtdn09rE5hCLZcZCK3N0a4VUUD5nCCoMOL85w2DqDw9lKo7QzE7K4M1U+y3K3K6xTIeziSJmGP
 34okTu/hHUuLxxBmBsuVaSSvsqmYpCxMITPkMYdB1xYsu8KijJvnY2v0inoWqz/52qOdFAlpPdT
 ycn/ofPH5IJJb7jNAE/Ea4m5D0MTZRv7h8lSaqOu8e4QsB5iCfFqx668EdhYlo+fp056gII49Jo
 OOG84wq/76pNcCXBJBXKvVTjyJguKWG9KAAGAQrvAcmcw=
X-Received: by 2002:a05:6a00:2d17:b0:82f:a6bf:bee7 with SMTP id
 d2e1a72fcca58-83924cb477emr1016446b3a.49.1777945136893; 
 Mon, 04 May 2026 18:38:56 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c9293sm194413b3a.33.2026.05.04.18.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 18:38:56 -0700 (PDT)
Date: Tue, 5 May 2026 11:38:52 +1000
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
Subject: Re: [PATCH v4 10/13] hw/riscv/atlantis: Add PCIe controller
Message-ID: <aflCM09tnv1YORKL@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-11-joel@jms.id.au>
 <CAKmqyKOV07ANs0i1yj6bMJWkWgn7DcME7B0_ZO0LPb0qVnfsew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOV07ANs0i1yj6bMJWkWgn7DcME7B0_ZO0LPb0qVnfsew@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

On Thu, Apr 30, 2026 at 10:04:16AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:21 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > Atlantis has 3 DesignWare PCIe host controllers, however the boot firmware
> > has not been tested with the QEMU DesignWare model so a generic ECAM
> > controller is used for the interim. The system bus aperture and PCIe IO
> 
> I don't follow.
> 
> The actual hardware has a different PCIe controller? This is user
> visible so you can't easily change it once it's merged. Generally user
> visible changes go through a deprecation process, we have some
> exceptions for soft cores which change all the time. But ideally this
> should model the hardware from the start.
> 
> Also if it isn't that should be noted in the board documentation.

Yeah, this was me punting on doing the designware host to get some IOMMU
modeling and driver code tested. And generally being easier to test
other things if we have PCI up.

I hadn't really considered the stability / deprecation issue with
upstreaming it.

> A quick grep shows support for a DesignWare PCIe Host, why not use that?

We should be, I'll take another look at it. We could drop this and the
functional test that uses disk, for now.

Thanks,
Nick

