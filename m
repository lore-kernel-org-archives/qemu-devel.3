Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74480FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI39V-0004a2-Fr; Wed, 29 Apr 2026 07:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI39N-0004YU-AW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI39H-0000aj-U7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777462331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dExnaxp9gGGuuBAyD2zhMTmy9B0//C2o/HvVCwD7t1Y=;
 b=F0tVek5+jIBYyjzfOPmo6j4zOnr5aKhAsjhXZCzhVh/iQv8x1dKPmTVCaOGlneo9ZEsRmt
 UD30zFZ8/tvxHiSmpbhJQPdxtp3ZjfJUhGXLrnIucazeF6kfnv93ii/1Ft7K1pvDTvSLQE
 ABBHDpthej6/wG8vtaMakkglYxCR1P8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-QmbpPw3pNMq3p0XJJK2KCA-1; Wed, 29 Apr 2026 07:32:09 -0400
X-MC-Unique: QmbpPw3pNMq3p0XJJK2KCA-1
X-Mimecast-MFC-AGG-ID: QmbpPw3pNMq3p0XJJK2KCA_1777462329
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7ba03ecdc6so7666739a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777462328; x=1778067128; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dExnaxp9gGGuuBAyD2zhMTmy9B0//C2o/HvVCwD7t1Y=;
 b=P+AFNtcV01dHQ2E1IiFM+KAHQUP7Cl1BcvRGE2BLi9LjQzEyrf6lRkkqvcF9V1gkrt
 dr0XrHAV5ANEf22Fkb3C+INpkDjdylu8w/ttUdVp/+nwv79jPUAgOGpDgTv2xc36uF/b
 0PvOgsZ0Rv324bvYmXCge8NCIkMHSPYwCY0YtV2yTkwHr6AGku3fbGXsbctWmT5Ckc2G
 IiLCtmw9Wk9qG48fdVOi7TKZbzOIgBC2uoC2wOvD/wHuuRfgib0HG7bsEICOzlDshsxm
 26JeoLrYOaoFUOj6qOSApIGhXbswIO3KLWrulvs56vBIAgGhE8kAG7zRLoA9ShvookaF
 DELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462328; x=1778067128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dExnaxp9gGGuuBAyD2zhMTmy9B0//C2o/HvVCwD7t1Y=;
 b=LWsxzQpnIwvuntSR3rXNTUsgck3ZZhLluvDmqb+dldu/9o7niQVroxRHJh2W9gMN6J
 JRF7Rn5fOzodzryE6SoI6EXxaqRp+g4MvF6U0ZmgXK21dYbiUqvwsxtH2DRc7UosUwZZ
 Qj77p5t8D9HI89AG2sYOjw0p9hgiua6szLhEzPxCIQDhyDbn59V5XuPhMASEtgwJ/INm
 5PlVsNiRBRZO2DCthGTJM+XNFYd+zAbOgAyTBJKR5JZRVrDRV3D7YzVQTOxWAAv7oCLG
 wD9aCfj++nscJjf7dyWbSDkZeJpTXu1HzqzKoDi+4mlzmh7d67Cgy/s4174dat7POH3d
 1BXA==
X-Gm-Message-State: AOJu0Yyfk+P/Ae+cYiGUUU+KugX4Lmw5GRROTF1tEZyBvR4kFHYG2yjS
 +YEFArTNam+jgmXID8jmNdonw5rQzBv7VinKbwbMulGnWISIGbX9LGFcbUf6TVQlOD27jkZPDLo
 XubvPB/HEA+EM7USgV+KEhcgWCpMRLBkHnYUSootI86ZeQ8+sOvDUMhhn
X-Gm-Gg: AeBDiesqN1cEggCu6Daqn0LSi38ua2TZ9qSLCzvKhOLFXaUJytlDmAPeEqeZBdJ0L/0
 A0w3ywRV5+Qf/4he/fC8zS3/3gUgejJOosI/NNFuanaM3V9ktVIBkIpUbEu1RjsgxH40Iri+4pK
 gsSh44zEuSxStjemrmWqC2TYjEypm8F9jYb+R7tg92RNcmuLN1NzC23C11MnL43L5FRKhV1pjr9
 RTw60QNnQqDv595Ttw7F0onKOIQKsEUwtwvYXWTidRLtMHldFPPhIReIjFlWJDqcHI4fNK3d6Zb
 K3ihSiwcU4FA8p1fbf7GL+BIrB4vU4KN1V9J6X+3zDdqI4mRXuRlt+O/EVFhjivirvy2KTSJdL8
 DRX2V9u/Tx/yCmpHJO7bfAvc=
X-Received: by 2002:a05:6a20:728c:b0:398:a33a:71c9 with SMTP id
 adf61e73a8af0-3a39c368f62mr8427791637.43.1777462328315; 
 Wed, 29 Apr 2026 04:32:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:728c:b0:398:a33a:71c9 with SMTP id
 adf61e73a8af0-3a39c368f62mr8427751637.43.1777462327822; 
 Wed, 29 Apr 2026 04:32:07 -0700 (PDT)
Received: from fedora ([49.36.106.198]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd5e6c682sm1891770a12.1.2026.04.29.04.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:32:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:02:03 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 5/6] tests: Implement aspeed_i2c_restart to reenable
 selection of master
Message-ID: <afHsM-XJk_yq54aw@fedora>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428130718.1325177-6-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Tue, Apr 28, 2026 at 01:07:17PM +0000, Stefan Berger wrote:
> For some TPM  I2C tests it is important to be able to reenable the
> selection of the master. Implement aspeed_i2c_restart to enable this.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/qtest_aspeed.c | 8 +++++++-
>  tests/qtest/qtest_aspeed.h | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/qtest_aspeed.c b/tests/qtest/qtest_aspeed.c
> index f6da9adea9..13934cc660 100644
> --- a/tests/qtest/qtest_aspeed.c
> +++ b/tests/qtest/qtest_aspeed.c
> @@ -15,11 +15,17 @@
>  #include "qtest_aspeed.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  
> +static int once;

can we make this a boolean?

> +
> +void aspeed_i2c_restart(void)
> +{
> +    once = false;
> +}
> +
>  static void aspeed_i2c_startup(QTestState *s, uint32_t baseaddr,
>                                 uint8_t slave_addr, uint8_t reg)
>  {
>      uint32_t v;
> -    static int once;

Can we check if the A_I2CD_MASTER_EN bit is set directly without having
the need to store a global static variable? For example:

static bool is_aspeed_i2c_master_enabled(QTestState *s, uint32_t baseaddr)
{
    uint32_t reg_val;

    return ((qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL)
            & A_I2CD_MASTER_EN) != 0);
}
>  
and use it here:
>      if (!once) {
if (!is_aspeed_i2c_master_enabled(s, baseaddr)) {


for restarts, we can directly write to the register
  qtest_writel(s, bus_addr + A_I2CC_FUN_CTRL, 0);
and the subsequent call to aspeed_i2c_startup() will handle the init properly.

>          /* one time: enable master */
> diff --git a/tests/qtest/qtest_aspeed.h b/tests/qtest/qtest_aspeed.h
> index d35b0c7cba..c0a095bb46 100644
> --- a/tests/qtest/qtest_aspeed.h
> +++ b/tests/qtest/qtest_aspeed.h
> @@ -23,6 +23,8 @@ static inline uint32_t ast2600_i2c_calc_bus_addr(uint8_t bus_num)
>      return AST2600_ASPEED_I2C_BASE_ADDR + 0x80 + bus_num * 0x80;
>  }
>  
> +void aspeed_i2c_restart(void);
> +
>  uint8_t aspeed_i2c_readb(QTestState *s,
>                           uint32_t baseaddr, uint8_t slave_addr, uint8_t reg);
>  uint16_t aspeed_i2c_readw(QTestState *s,
> -- 
> 2.43.0
> 

Regards,
Arun Menon


