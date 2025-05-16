Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BE0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFimf-0007Sm-EJ; Thu, 15 May 2025 20:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFimd-0007Rl-6M; Thu, 15 May 2025 20:18:39 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFimb-0003jz-Fx; Thu, 15 May 2025 20:18:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso1556394b3a.2; 
 Thu, 15 May 2025 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354716; x=1747959516; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fznkRcoLGVvNlbbsEeWuNF3jbHc6LUnHK8Cq6hA5OBY=;
 b=chag3TdW1LIifkn/MLSVr9tLi/Izyryt5huH7vpJ+b6815nX4JMy789Ntiy7YvDRXR
 nHi1rY2WPmqzQu54XOf0mZtuquY2MMVCfEhgMaoN/C66ianyge+BmdzQ9gFaxFz9IQE8
 ti37IeeanqzWa3JCFgahAyohP1/UYn8S21dRLiVoNlctZ7S5MJDUHZkEzfpjoKSmJ70y
 yBZVay52o7OS09bl5fxKKhzVJt48uRqgOkuoEWlINAXce9XyWSQSkAjDqeuqrr8QDMPm
 s4hX0+31M5qfh7zFrygrAh/InOiYxCgvT6ZEn9KXkCtEpuiDwl1nCSLIeAmbbLXn5B+M
 RI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354716; x=1747959516;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fznkRcoLGVvNlbbsEeWuNF3jbHc6LUnHK8Cq6hA5OBY=;
 b=rDtEJu2jLfcwodSMfXJL7XTHw1rF9VLdoGcaYyVDHphOHgGFrKM5V0ihwPdWL3VXhd
 yvkvpVyVES0AnyCMm28NO2dW2i24Sn83tHiCgC2ED0j4V6PWrCEVsyljzewYiqBnk4sN
 ReEdBBhgqWGnassBonDv+dKBlR8iJ6+VNX/kwf2L/oTHB+RDiMB0BwNBX9w2oqS2g7tM
 kE1pEQ883NbFgAwwUMjKhSDTulBDT2gcky9BNjtnpLnMV1MONwh3LTiXZ+IdpdOjBHcQ
 nc3e8ggN5HKY4JbsfggAphjsW3M3s7JUDyaBKDhath4fitQzjvc8Qd39dzXlQyE9pApg
 5Q4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzdmJTzRjCdAkGzBK8Cqzka2viB2MViR8cfi7UqeVifUQvE6ADbUKh3nLFn8q+JXah4PL2/nF6EQ==@nongnu.org
X-Gm-Message-State: AOJu0YyQRaAJFL/JWnLP8za9tpO49DoJ4nD5WrnGicUo6NCn1aqmjmvS
 oAwnkKwrGYWhdEqwRCiIBVOeS8gmO+LYPe2BSmLEQ7yy7nlnMRlw0gqDmu7nwA==
X-Gm-Gg: ASbGnctYSFj2UooXxkk+DB5E6By+OE1aoeRboPIm+/d0FMmBMLzGUKEEPFOwlH4E72K
 JpgQRAjR2sXVGO0NTTIhbKPLpCpVg5pkggFENPZl2Qm7teaBxVt8OPWw+Z8dq8YzK5bWmSymFj0
 f9msJrPBid5dfRktQkmRpkYo/WZuiWxZwWHvSoBWy79NT1/+ykozI6ts5U0nqug3DeIFohFK7i3
 9DHwY+OKFW/dwHPADfmRfaju1Y4AOWMumFETi/3EhYlKBawkUHgONQOJjdGqwiKkNoxQKwa4ww4
 9QJajw1BvgzsD9Y0jmzP34MAV3bDbskNHT433+grtKdEXsw=
X-Google-Smtp-Source: AGHT+IHFuGEAqVcTjWAI77JxGP9J4+3mR/az4JcFBGOVmY7NUluPnX8GbCgP0n6HCg5rM33YhNfg4A==
X-Received: by 2002:aa7:888e:0:b0:742:39fa:13df with SMTP id
 d2e1a72fcca58-742a98a2520mr1519846b3a.19.1747354715729; 
 Thu, 15 May 2025 17:18:35 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9877063sm381218b3a.153.2025.05.15.17.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:18:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:18:29 +1000
Message-Id: <D9X5JS1FMOBZ.H36CCA3HZ553@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 21/50] ppc/xive2: add interrupt priority configuration
 flags
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-22-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-22-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Adds support for extracting additional configuration flags from
> the XIVE configuration register that are needed for redistribution
> of group interrupts.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c      | 16 ++++++++++++----
>  hw/intc/pnv_xive2_regs.h |  1 +
>  include/hw/ppc/xive2.h   |  8 +++++---
>  3 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index c9374f0eee..96b8851b7e 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -605,20 +605,28 @@ static uint32_t pnv_xive2_get_config(Xive2Router *x=
rtr)
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(xrtr);
>      uint32_t cfg =3D 0;
> +    uint64_t reg =3D xive->cq_regs[CQ_XIVE_CFG >> 3];
> =20
> -    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
> +    if (reg & CQ_XIVE_CFG_GEN1_TIMA_OS) {
>          cfg |=3D XIVE2_GEN1_TIMA_OS;
>      }
> =20
> -    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE=
) {
> +    if (reg & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
>          cfg |=3D XIVE2_VP_SAVE_RESTORE;
>      }
> =20
> -    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE,
> -              xive->cq_regs[CQ_XIVE_CFG >> 3]) =3D=3D CQ_XIVE_CFG_THREAD=
ID_8BITS) {
> +    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE, reg) =3D=3D
> +                      CQ_XIVE_CFG_THREADID_8BITS) {
>          cfg |=3D XIVE2_THREADID_8BITS;
>      }
> =20
> +    if (reg & CQ_XIVE_CFG_EN_VP_GRP_PRIORITY) {
> +        cfg |=3D XIVE2_EN_VP_GRP_PRIORITY;
> +    }
> +
> +    cfg =3D SETFIELD(XIVE2_VP_INT_PRIO, cfg,
> +                   GETFIELD(CQ_XIVE_CFG_VP_INT_PRIO, reg));
> +
>      return cfg;
>  }
> =20
> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
> index e8b87b3d2c..d53300f709 100644
> --- a/hw/intc/pnv_xive2_regs.h
> +++ b/hw/intc/pnv_xive2_regs.h
> @@ -66,6 +66,7 @@
>  #define    CQ_XIVE_CFG_GEN1_TIMA_HYP_BLK0       PPC_BIT(26) /* 0 if bit[=
25]=3D0 */
>  #define    CQ_XIVE_CFG_GEN1_TIMA_CROWD_DIS      PPC_BIT(27) /* 0 if bit[=
25]=3D0 */
>  #define    CQ_XIVE_CFG_GEN1_END_ESX             PPC_BIT(28)
> +#define    CQ_XIVE_CFG_EN_VP_GRP_PRIORITY       PPC_BIT(32) /* 0 if bit[=
25]=3D1 */
>  #define    CQ_XIVE_CFG_EN_VP_SAVE_RESTORE       PPC_BIT(38) /* 0 if bit[=
25]=3D1 */
>  #define    CQ_XIVE_CFG_EN_VP_SAVE_REST_STRICT   PPC_BIT(39) /* 0 if bit[=
25]=3D1 */
> =20
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 2436ddb5e5..760b94a962 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -29,9 +29,11 @@ OBJECT_DECLARE_TYPE(Xive2Router, Xive2RouterClass, XIV=
E2_ROUTER);
>   * Configuration flags
>   */
> =20
> -#define XIVE2_GEN1_TIMA_OS      0x00000001
> -#define XIVE2_VP_SAVE_RESTORE   0x00000002
> -#define XIVE2_THREADID_8BITS    0x00000004
> +#define XIVE2_GEN1_TIMA_OS          0x00000001
> +#define XIVE2_VP_SAVE_RESTORE       0x00000002
> +#define XIVE2_THREADID_8BITS        0x00000004
> +#define XIVE2_EN_VP_GRP_PRIORITY    0x00000008
> +#define XIVE2_VP_INT_PRIO           0x00000030
> =20
>  typedef struct Xive2RouterClass {
>      SysBusDeviceClass parent;


