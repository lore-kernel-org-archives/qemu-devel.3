Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1BD44C5A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOce-0004tW-FH; Thu, 15 Jan 2026 09:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOax-0003vO-Dl
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:45:10 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOar-0001ov-Ja
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:45:03 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64472ea7d18so705720d50.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768488300; x=1769093100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0kStazpEK+tQh/bB+hGCrN08JkxnxoJZhaDYNhSHMk=;
 b=du69JuKP8SSe5S1NMgd8trSMb0aAfQ3e+DwPnRj1f4xepmnEhn7PbWiwoCUVY8eGsv
 KlNa9v4jOGuQUNncM0Ur5a+aRN2OH5r7OlMN6tPSnMIjwbiF72vfn8TYVnnADTCttOP/
 KTHf/qcjAHfw5Pbr8hUH+dL1jkVrYlj1MBX0bKxu4lZVvwR68LPWmPRUPaEIFJ6e5Zuz
 /vvQv+Eji/Q1MKjUcX9oA04yDvBqxxmq/L0T0Ce9Rtto5SmdlP4FDUKTncta2g9O/PF9
 OrGIe8qZOmSxVQFuGcaFGGI9rDhU4CrGXdpSlD744xv4V+IEtOuc1z0k9KYklXWOqBda
 EShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768488300; x=1769093100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0kStazpEK+tQh/bB+hGCrN08JkxnxoJZhaDYNhSHMk=;
 b=ZReHs8E2pGIh4V7BGUL+oTOO/U2W938e6PKxb45SOYi4XATA55EcPudMeIOffh1BDx
 S7iGWEpA3fozcMJyhyPPjYlhGAiyBIkIXaPTs6iWfch7O8TZrMieWVv0W6ie9ACYUxYs
 trIn0Cu15iAIg25y2SfdeFQI1/9xnAzo8pGGEnxiJtBt6OzQHmD9LNUeAUdh0oTbByEA
 VDUvKed3Fi0Jn0SVko/7Ykc27b0qBmuWu5Pjk+8OyTZJPC/gNqwhBjRBnqwtHpwzTQ/D
 2GP5xtuerCjzSziV1lU6YXmcFRDGLgo3MCTUjN/RddzOrhffTMAYZzL9+vEfhXhYniav
 aPyg==
X-Gm-Message-State: AOJu0Yx6HSOP4CLFuBobl/Sr/Gv5JS0HYykV2HpT+kaLs0lIOm4BceHu
 7W3ua1cFg4WuIbdq0IKnNUsf2iDHhXBGOzVm+zSO/AFTDuZ/onZycimuYHU9Fdnr00VnIYTLRy3
 82FEyPgtNXOBezCMhU1Ao2PYgMpLuPYZ9JThB+yyo4Q==
X-Gm-Gg: AY/fxX6YFnOUeNwPsmDw7epvfEbNqHHZX+JgNaUleBcV4yL09vlT0/Vr1f7WCzbQiKN
 dbLlXmfcZ4dMj83UFfbVgkmsRh/02yGI3NWtg3P4zxE1RnRhj5LAT8c5IhxYClBbkgfd0YQ5hxm
 URG9X9vySsGDlssEAN9zOKff5W8/LDfcfpbKRoPcKJ+0Wmr5wNJ+0ZlyUMGruA9Yo3crRZZrf/q
 6NAkaupYeg3mg4vvimkWOac7SRH0U8EitLpmHuaJgkbQQTZ1M1LGRReU0Gt+GtckhbwBBQ24cNU
 rON9woMKVnBclx3xi+TrY/Y=
X-Received: by 2002:a05:690e:1407:b0:63f:b444:da92 with SMTP id
 956f58d0204a3-64903b11c5amr4059761d50.31.1768488300253; Thu, 15 Jan 2026
 06:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-13-corvin.koehne@gmail.com>
In-Reply-To: <20251204093502.50582-13-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 14:44:47 +0000
X-Gm-Features: AZwV_QjuwcoS2662mXJ9L3tbarrdVmTq0K_c0pPmhV23RABKYzKzF1azr9AFt-A
Message-ID: <CAFEAcA8+2dgKtZ6MmL9qoR6F-NvZsHBAHei1cG11kvVwqjmbeA@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] hw/arm/xilinx_zynq: Split xilinx_zynq into
 header and implementation files
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Create xilinx_zynq.h header file to expose ZynqMachineState and
> related definitions for machine inheritance. This enables creation
> of derived machines based on the Zynq platform.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>


> diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
> new file mode 100644
> index 0000000000..ec80441e7c
> --- /dev/null
> +++ b/include/hw/arm/xilinx_zynq.h
> @@ -0,0 +1,36 @@
> +/*
> + * Xilinx Zynq Baseboard System emulation.
> + *
> + * Copyright (c) 2010 Xilinx.
> + * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.croshtwaite@petalogi=
x.com)
> + * Copyright (c) 2012 Petalogix Pty Ltd.
> + * Written by Haibing Ma
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Checkpatch probably complains about the missing SPDX line.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

