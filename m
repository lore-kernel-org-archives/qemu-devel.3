Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9310ACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNxBj-00053G-RP; Fri, 15 May 2026 14:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNxBi-00052f-4l
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:23:06 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNxBg-0000RK-4I
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:23:05 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso162993eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778869382; x=1779474182; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7tZN6XjI4WwtDkwaarmEa/UzUnar2/5RNKZjM1KwEp4=;
 b=TWedXQzytogv0X7Vo5R85zRMYdspbulFmuVEy9yn3weGPoJMFH0onDguOuuBGxoWJz
 45qA+uTdjLcob77yyk5UIeD9P2uUbDPi/og83PetWVIY8V0/CCFhS0tCoIohkhNjnVMM
 D0czUvrkGzc5HaHo0M9/91lhMXsg4ttuiPqGYpAJbEr1EnfMezStkorkb3EProeL4pQ3
 p2bnzu1FlCN3Cg/+Dn1iV0+LwV8egaMaQDrYTrSleYeIxFW7wd7/1oCFFk/jjohKMMaz
 XSjPr9UbqiaPNntCouzPBbUuLuqXGGGqTL0VqvMzM9hcMPVjDDlke9QAYV5tx28Yi7rB
 FHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869382; x=1779474182;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tZN6XjI4WwtDkwaarmEa/UzUnar2/5RNKZjM1KwEp4=;
 b=ckpjkmvCfEoC5hrbDMGhagEuVVwRHq8R6pIJogWxqb/QoVhFgR8C8mRJo8AcG/17BX
 ZAa1U21OwPDRVDtaGClEJ6pDJqs8wnj1CAifL0zpIP+2mRrTUwJP7KbX4Ma3HXCymeh0
 1yR23c6APCjUDPjpRcad+INKL6S5bIaYIgcdVQdLNHHBLMjhJRLLBZTKQgeEU7VBe3Tj
 MOqem1rXmfRK15JcedzPgmmZP4CWunr3hb6NI7ST6Y87IX9BMRrKRX146ATx8IhkzLq/
 uektbl4pQLH5ulIlDOJCX0kYDzH5wRoKwMekxFS7jHtiseVACjOEqWW/DPqC0mISCa6t
 r4/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m2GKOVQynSTykoGwLwn6wcK4WuRyqRwiXmf3i3fvUbi3Wur2wcDHre5ZoKNcWUW/LDNgakQn7PWS3@nongnu.org
X-Gm-Message-State: AOJu0YxYaSgxIPDctwdZXChcAcHrVwQhQAzXiHtj868vpPoWzcNKEQ/2
 UcGjzg8qmnCJDMIkVIWNA8/L1uY1w4J9BCB383dMkbli5tBZ53/9mwdz
X-Gm-Gg: Acq92OGW/XZ4X3SSJNcRf5u7Tem5fkffgmZ30f0dYHVMzB7T86nojNV0zmK6LImhgH7
 cQIg2VjdLf+Ey/VbCDGxUsmnqE7x2gRwWMRevaIysSLrY2O+NH+K+d/vdjKTJwP61D7VSVRM0Dv
 /HiEEZhw4htf9YzGqloTspbw8MXnn72p8r8BIG0ePe2aGs4dHoiv4aq62UImBqqZcr+d7OB6Gb4
 fY2MPJ3WJF7KySfJkzqRvV3aVtFzEx72Yfk0CXzf8Cl8Y6xS5CWtOyiJUEhU2kGQi96aM60BqZX
 6jNvmzkVxOzcy3GgGrXdbxvPWl9Z0uyNPehZMjaIWiM7/jYVatdkzuGOymRYD1y9gi+ywTjTvXI
 agimzmNyVjlRIC7ErEANVLqgN8Sj1yawDhRtJH91OLA/edbecs9rhtXYZKCHEu2E3Mb+wF4a64J
 Stz23KAHZ+jhs9zBI3hn/bxQv1gYZWEVNMdNfS3jyYUQ==
X-Received: by 2002:a05:7300:6c05:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-3039864d5c1mr2500737eec.23.1778869382241; 
 Fri, 15 May 2026 11:23:02 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6f6sm9237768eec.17.2026.05.15.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:23:01 -0700 (PDT)
Date: Sat, 16 May 2026 04:23:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Corey Minyard <cminyard@mvista.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Subject: Re: [PATCH 2/4] [RFC] hw/i2c/designware_i2c: Switch to Fifo8
Message-ID: <agdi9vz5Ty3XsSH5@lima-default>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-3-npiggin@gmail.com>
 <9c5d66ee-0e50-4311-8dc8-17797e92fdbd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c5d66ee-0e50-4311-8dc8-17797e92fdbd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=npiggin@gmail.com; helo=mail-dy1-x1329.google.com
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

On Mon, May 11, 2026 at 12:18:41PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/5/26 14:05, Nicholas Piggin wrote:
> > Alistair suggested moving to Fifo8, which I think is
> > a good improvement.
> > 
> > Broken out for individual review, but IMO we should
> > squash before merge since it changes VMState format.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/i2c/designware_i2c.c         | 37 ++++++++++++++++++++-------------
> >   include/hw/i2c/designware_i2c.h |  7 +++----
> >   2 files changed, 25 insertions(+), 19 deletions(-)
> 
> 
> > @@ -53,8 +54,6 @@ typedef enum DesignWareI2CStatus {
> >    * @ic_comp_version: I2C component version register
> >    * @ic_comp_type: I2C component type register
> >    * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
> > - * @rx_cur: The current position of rx_fifo.
> > - * @status: The current status of the SMBus.
> >    */
> >   typedef struct DesignWareI2CState {
> >       SysBusDevice parent_obj;
> > @@ -88,8 +87,8 @@ typedef struct DesignWareI2CState {
> >       uint32_t ic_comp_version;
> >       uint32_t ic_comp_type;
> > -    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
> > -    uint8_t      rx_cur;
> > +    /* fifo8_num_used(rx_fifo) should always equal ic_rxflr */
> 
> Why not remove ic_rxflr then?

I did consider that... but the next patch to rework the registers
adds storage for them all as a block. We could still just ignore
the storage and use fifo8_num_used() instead but I was vaguely
worried about complexity of vmstate compat if we change things, but
not sure if that is a rational concern. In the end the code is
quite simple and only a couple of places where this is adjusted so
I kept it this way.

Thanks,
Nick

