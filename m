Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3A2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxBD-0002oF-Dt; Tue, 07 Jul 2026 00:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgxBC-0002nh-GP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 00:13:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgxBB-0001Wg-2D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 00:13:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so6527439a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783397583; cv=none;
 d=google.com; s=arc-20260327;
 b=IFA1OGXCZ1heLfTgkOTI4aYHfzJHE5WScrO/JSDLXnweqtoKm6JL1ob4QCHJtB2mlc
 TNJ79vkvEK4TDE8Ir8AimVPF+q3MBbRXh39GDXLhD3wDFDIqVZ/qRoIfPcxEYIGuRNuz
 hCggw3gkgbITSrn/KwxOPvBWI7NBmrr7LchF+IyAaVYNdBan+5ZC8wCbYzC6ua05F35o
 sBJQ2ODvceloMX3rDSCjnjLM7d1XA3Xop0uvUj4ZCRGwUlSD/4vM5CAwuTP77fcrwxlP
 +ja9KGq1U2aWZVWCZ1r2FNYcx8HSpyw9xyz2zOXOfHAMiRo/vhxSqRPI05aU95W+YWiE
 2lLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qFyHEuJbiZnwi15luGVMLUH15sNsiwcdRKnHqR67fzE=;
 fh=cngyzARD7sKZUHArsfq0uj8GnyR+QHwzuJTGEShrGLQ=;
 b=NMkz+6yyB8ugV4q7pB9TRxvIvQQJT+P+XkW9IJJ2HuweI0Ec0VF26zedTnTqozFqSl
 V5ToiGFQT8Y6s7uVKxgtU3mouzHc43XfBWrxeHwS88PAimO8wVH1lqM/PLn6mdJAvLoK
 +bREPfS8RKG05XnRJ5upsHRSOYZJhxyWkstN5ea3SdsNzFlLG61z+ZArbtuWjsDYM4oc
 ex0DA9gnVmDPhhF86wtHeNVwOJG9YO5qlI4eE7IoEGQCo+mppd3b6GchbIaHbadNbYk7
 EdMx8wVNfEJrXAWXfdgnpso3TgRVeq29LJeqhGaKOF8r0bp+IP3CsqlYjIOZayGtt1Um
 MdIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783397583; x=1784002383; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFyHEuJbiZnwi15luGVMLUH15sNsiwcdRKnHqR67fzE=;
 b=WUljKFlxtYGNCSegMjqcSq/LXFBIhGDAViKPVAr1Ue3uVdruOIo8Kgtb90IByDNUXg
 6Tdlo0AbLQmhlRfdm6uj3lbQ7m6hUID1Bjjzdm1vx8rkM2LXyWGDpLcejs+TvhezgdpX
 tGtJ1O8C4NXTMns0P4vWTXqFQbH1ppfzhVNitG4LmbapyQAEkJiKFQuxHqMCPRtZa9sV
 e6hzVnthVq35afRBxkkUK1/mZeE2ewFa0GzSF5eEbJmUxR7o/SiUxRzV5q8l559pt2mR
 K9lp4KVtPpdBMAL0MmY2TcAx8qLMTGdSjkSWccI/lREFZv8w/Kvb9rXIs1ZP0a1BDRsv
 IMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783397583; x=1784002383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFyHEuJbiZnwi15luGVMLUH15sNsiwcdRKnHqR67fzE=;
 b=AdtTU/uyLpFNrUunDsLTMb3JT019eQjgCQ23JsCeXGpQwcurtWj3vwnfs4y8XfEqc+
 bimUaAx2YC6p2FTH1CsYmntrl2HI3MkwBfUk8DSubBuhqpwYNMo/tWZkimiACrNsT/7e
 gcGE1fp1++1ol4ctCDdSapzf09FIk+W6a+8kJbLDQktGOC0KZxD3Klw/9evRLDtB2ofb
 jxrBpIXxQLKikSsnIy/55wnmkXdqdiSuWoAVcEka943mipr/Vb5EVV69IeOIrDepcCh1
 meaZtgRFBtLuK21fdXBrsSSABnNI5Qt6eS7P0y4NklLn+7Qii9YR7Wu0Ys1GA5k43FAk
 blqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGVE9j+nXWHKvGtN/zd4iBNwJCEAKC7R/AqdQ32GEE2bGyQXCqyX5hfrFbTFND11x8NTtU/V1aCg4F@nongnu.org
X-Gm-Message-State: AOJu0Yw+4R8N2UfXuJ7icma+8liRdv/XOpoS+ulrUBdDhwUMletSeDxz
 ceI9u6xpyQq+1CX9uC+5HFrr9MgJ0vQAXJVOKOWZS45M3HIf6aDyp59+hGhLR+AQvjMG0pSilPM
 mGKZbA5JjBm/Zrvzwj+glaHj8rQxpfp8=
X-Gm-Gg: AfdE7cmscVVBGxUnSfZyQyzdGJGBpBoO0EUDoo3TPwPSstk3VbwosokU+XXxdey37+Z
 hAxyRmdNUYiK35U4BbgpwtO8ewpRrBGl7KrDcYe2UH1zbjLcsjkpcTDFjdxvac4UazU70dXNwtu
 kAxmDVTi6VkVtYVSiVmq1qFRtjayqgQUQfaB0ZU4Nxvsg07rNp+fa931+8Czyr/Auzyh7V5XktG
 GjSMKs+6k58CMh/a/mOcCQBQLU3cb29/xa0yjRyKJK3onlKJJ3NvoRTa8HbsIWgJKEfXLlICC3R
 MHryby0pDdmo+PnXrUfhvfmiPqU=
X-Received: by 2002:a05:6402:11ce:b0:69a:9355:d1c2 with SMTP id
 4fb4d7f45d1cf-69a9355d291mr264738a12.42.1783397583237; Mon, 06 Jul 2026
 21:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMhqavLeDj7fy-JpY8WGKO0m_o+94UMPX2sBK5Ldsid4w@mail.gmail.com>
 <202607061406240161qB8UHkhWxKejNM4p23xn@zte.com.cn>
In-Reply-To: <202607061406240161qB8UHkhWxKejNM4p23xn@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2026 14:12:36 +1000
X-Gm-Features: AVVi8CdIZvwztsB195yDproBcHgCj89Lj2XvO0vTrsyLZQJdNZTRYUjiN4Ayd8w
Message-ID: <CAKmqyKOp_SQkQF4i7BYxdGSPELCTBGymJrHGz4S2pWpvt3JUOw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/kvm: add extensions after v7.1-rc4 update
To: wang.yechao255@zte.com.cn
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Mon, Jul 6, 2026 at 4:06=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> > On Mon, Jun 22, 2026 at 4:59=E2=80=AFPM Wang Yechao <wang.yechao255@zte=
.com..cn> wrote:
> > >
> > > Expose zilsd, zclsd and zalasr.
> > >
> > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > Thanks!
> >
> > Applied to riscv-to-apply.next
> >
> > Alistair
> >
>
> Hi Alistair, could you please confirm if this patch was applied to the
> riscv-to-apply.next branch? I can't seem to find it.

Oh sorry, it didn't get applied. It doesn't seem to apply to master or
my branch though, are you able to rebase it

Alistair

