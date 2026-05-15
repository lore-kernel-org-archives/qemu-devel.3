Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7037CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNxMq-0006iB-8S; Fri, 15 May 2026 14:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNxMd-0006hi-3S
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:34:24 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNxMb-0004H1-IU
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:34:22 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1331e851faaso39155c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778870060; x=1779474860; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HxyBNmC1jV171Qs4hlyCZtRG8zDuOe5XpBt61mfaLZg=;
 b=soVUZqw7MOGrqNGCpBYJzB2iONodbY3jTldA+DVyhFYQbF/F26k7AjEQ2oar1j3D2d
 OdpHuis9bSvMaz/4UEkdvth/wkzbGqqYQ/NTSvXE2KPRG4vcjVNbwpY8X4GhuQCiNVdl
 SO5Xb+lRBoUgghswdtRzhTbW92YtgijFq1Ket5YCTMJVeQfjXBxqXP+DtROGRun87a0J
 UTiF5okRlMae4VLHhdbEKd8XFPZ7MPGL34wUCSCmPVBHV3lZsse0ExAqScfaeLlb6Ifi
 hcwCYvl9VPESwFZAWg0qUZvgEAKTJkTK2t3WGyzQa/xFopJ8k1fFDygdrphnlsa9NmUH
 GQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778870060; x=1779474860;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HxyBNmC1jV171Qs4hlyCZtRG8zDuOe5XpBt61mfaLZg=;
 b=aJy+A4HJAQA82to5gT8B6gq068I8fCmsb3EXacoLCOYyy/xwMWXYmH4OFnxJGWSG3d
 ZfRFeBn6Xq+ZBDT4nG8PppiaAt5NEXg2J+tUb0e82WQKTY+3JGjQNGXrdh+Krb1XBstG
 0zqhXuCqyR6oCn/z975MAgzzK1mxE9dOjaEvvvtcbwWBmynFQ/+zbJnzic+Qxz9KHp58
 Jc5aWWwcTeUhu3UpyMjIry78/oFox1t5qMsicllfnjOIZ8/k74ZQfxx2tHTeozppw2Dw
 j/efPRTz0ulIt1TYvne4gF+SdVQWrWB+vnEmy40tJwGnAM/ub3nT3dGIzXaLycs0YASq
 0aHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bkcWR63Nh3ACaA1YLAHpq0bc/So0Ptyv47aM3MidM1UHjCsqHAbd6/2TaKnL5Vv7vMg2nJshM6dDz@nongnu.org
X-Gm-Message-State: AOJu0Yw3IrsEGPgRLgq/mcKJDSzTGyOc7+WX+fI4R6geHoXKROQHznWX
 pTulG8ZL0mmtYyUk5fgvcnvu8u2cFGrMPiJCsxWAXf6liSYaTFP8/zNz
X-Gm-Gg: Acq92OFCMivDNY1Ji1JJF/VkasfSEuaask4oS/XQv/YS8evKYJrqUFRpxYxjP5YIpot
 y2vKd9DY5tsB+hAGCpQZI05PvPm35jLnFK/7GXwAh6Azwa1CnBkhGmWf90AHkgJKqgTHwZVyDT/
 fUpf7Qd9HcbKmxAqUOhYeYWpo4IYHXRNaqTW4lTpFZdkKtkLfp11aUYL1kjE7ENLP46oZJSRnLV
 j7r6GP2bol1zjCo/KqABLqJJ14j2CK5sz/W9VTeLuA6mAJokHIDhCu2qMhBas6puJBbaMWEthTg
 aUmpve7Rc4ew+i0TbgHH+gJQyen2/Cirydas8etNntn0yAorQe3vtjBkDqg+T3XMrsaZ4EKzt1s
 kMf5TUyiFVjdic/NYoGaro/25MVf71Kl1/ryFpF3P2WzIkMZ86FPQlhkiHY0xzRBiUSPutHgAEc
 NGGkDdNpGACXQFJXsush9wofeCzlipRUI=
X-Received: by 2002:a05:7022:427:b0:135:2588:6314 with SMTP id
 a92af1059eb24-135258863a8mr1112197c88.8.1778870059752; 
 Fri, 15 May 2026 11:34:19 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbed531esm10640431c88.8.2026.05.15.11.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:34:18 -0700 (PDT)
Date: Sat, 16 May 2026 04:34:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Corey Minyard <cminyard@mvista.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] [RFC] hw/i2c/designware_i2c: Switch to QEMU register
 API
Message-ID: <agdlhBe4DiL74-Sb@lima-default>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-4-npiggin@gmail.com>
 <CAKmqyKO=pivPx5ohQdZXOE1u4sp8tU8dwpN10+WtaNGBhuofXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO=pivPx5ohQdZXOE1u4sp8tU8dwpN10+WtaNGBhuofXA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=npiggin@gmail.com; helo=mail-dl1-x122e.google.com
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

On Wed, May 13, 2026 at 12:03:17PM +1000, Alistair Francis wrote:
> On Thu, May 7, 2026 at 10:07 PM Nicholas Piggin <npiggin@gmail.com> wrote:

[...]

> > +REG32(DW_IC_COMP_PARAM_1,       0xf4) /* Component parameter */
> > +    FIELD(DW_IC_COMP_PARAM_1, TX_FIFO_SIZE,       16, 8)
> > +    FIELD(DW_IC_COMP_PARAM_1, RX_FIFO_SIZE,        8, 8)
> > +    FIELD(DW_IC_COMP_PARAM_1, HAS_ENCODED_PARAMS,  7, 1)
> > +    FIELD(DW_IC_COMP_PARAM_1, HAS_DMA,             6, 1)
> > +    FIELD(DW_IC_COMP_PARAM_1, INTR_IO,             5, 1)
> > +    FIELD(DW_IC_COMP_PARAM_1, HC_COUNT_VAL,        4, 1)
> > +    FIELD(DW_IC_COMP_PARAM_1, HIGH_SPEED_MODE,     2, 2)
> > +    FIELD(DW_IC_COMP_PARAM_1, APB_DATA_WIDTH_32,   0, 2)
> > +REG32(DW_IC_COMP_VERSION,       0xf8) /* I2C component version */
> > +REG32(DW_IC_COMP_TYPE,          0xfc) /* I2C component type */
> 
> This looks fine to me, again no datasheet so no idea if it's right though :)
> 
> For future reference, generally in QEMU when people say the Register
> API they just mean this maco part above

Ah, okay!

> >  static void dw_i2c_update_irq(DesignWareI2CState *s)
> >  {
> > -    int level;
> > -    uint32_t intr = s->ic_raw_intr_stat & s->ic_intr_mask;
> > -
> > -    level = !!((intr & DW_IC_INTR_RX_UNDER) |
> > -        (intr & DW_IC_INTR_RX_OVER) |
> > -        (intr & DW_IC_INTR_RX_FULL) |
> > -        (intr & DW_IC_INTR_TX_OVER) |
> > -        (intr & DW_IC_INTR_TX_EMPTY) |
> > -        (intr & DW_IC_INTR_RD_REQ) |
> > -        (intr & DW_IC_INTR_TX_ABRT) |
> > -        (intr & DW_IC_INTR_RX_DONE) |
> > -        (intr & DW_IC_INTR_ACTIVITY) |
> > -        (intr & DW_IC_INTR_STOP_DET) |
> > -        (intr & DW_IC_INTR_START_DET) |
> > -        (intr & DW_IC_INTR_GEN_CALL) |
> > -        (intr & DW_IC_INTR_RESTART_DET)
> > -        );
> > -    qemu_set_irq(s->irq, level);
> > +    uint32_t intr = s->regs[R_DW_IC_RAW_INTR_STAT] & s->regs[R_DW_IC_INTR_MASK];
> 
> Which gives you advantages like this and the FIELD set/clear which you
> aren't using anyway.

Yeah it's quite nice. I started using FIELD set/clear etc but it looked
to make the patch harder to read and a bit harder to script it. Things
might be cleaned up a bit, although there is not much multi-bit field
manipulation in the driver where those kind fo macros help most.

> > +    return value;
> > +}
> >
> > -    /* This register is invalid at this point. */
> > -    default:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: write to invalid offset or readonly register 0x%"
> > -                      HWADDR_PRIx "\n",
> > -                      DEVICE(s)->canonical_path, offset);
> > -        break;
> > +static const RegisterAccessInfo designware_i2c_regs_info[] = {
> 
> QEMU doesn't expect you to implement the RegisterAccessInfo struct.
> This struct exists as it's easy to autogenerate from RTL (or some
> other source), but you don't have to write it out yourself. You can
> use the REG/FIELD macros above and not RegisterAccessInfo, which is
> what most devices do (Xilinx devices excluded).
> 
> Sorry for the extra hassle and work or converting it to
> RegisterAccessInfo. Keeping the RegisterAccessInfo is fine, just
> letting you know you don't have to do it next time.

Hah! That's fine, it was interesting to try using it anyway. It makes
things more consistent and hopefully less error prone, and ended up with
fewer lines of code.

> I think squash these 4 together and that'll be it for the I2C patch in
> your Atlantis series.

Thanks,
Nick

