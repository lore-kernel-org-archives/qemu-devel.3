Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BCAC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSY6-000494-2Q; Thu, 13 Aug 2026 06:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuSY4-00048H-KP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:20:32 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuSY2-0004uA-V8
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:20:32 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66b3803ef19so2469311d50.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786616429; cv=none;
 d=google.com; s=arc-20260327;
 b=nFreikkq47IPeU+ab7DndASvLC3chNe0W/lYLfVBnYmXVolIvkGR6yzt5bnLL7OrJF
 IqwOZ+BNh1Bj6wj8Hfnh5raS6augqccgwhOJOPPwsTBfHYdGC6oavO0Vpvc2Sd5mz1mL
 Ik/ZH4auNKPdGxkiDpaz2MwNi76JeQ+1ORLtYOjXiijANBkZ2++Z4y7VelJXp5gPYdZ6
 tG7b+pcmAUqYL12zv4IBEDFANd7QetfiDUnStl1dglTYhs5l7mBFk1WfxzhwuKBpK5TV
 8WzPgJwXY5Wgh2qgcprceR8v4i97fEULSCjjkBFIxu8o/lImEical/I6BSE318R872ye
 XvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2KJ9zAe7qCB3LtGaL4rohPUD7uiks0q+L7rs3t64H4Q=;
 fh=p4UgEI9ZQbhm37RJ/NYuyLAOtG8No9JOvDsPJ8ysidY=;
 b=iOQuzwD480Zmq9BTB6ns6SoXSV28SuAhP7N1k2ZKWqtgekTGHQphUEXkyG7LKqAcms
 kP7JIoeGBIPJdxkCZJDqZ/cwpZWwjSulQczYHwMzrzUZ7DwpHdC8WVQN4J97oojFxpEc
 n6BoYfCN/+bYNrzA2lcayMajHFBBxMetTpb7CYMlWlHQptNYBUZF93W6IHRIwDBof8YN
 Q/TABbG1PYhgX6N01v+hOQi4kF3WMAMVACMMZjgCsiT+LxwDDhLUZnkYDzzvopG/70Ak
 CHQwjFfVULvJNZZjWpOFYUaVLDZZFcg69cZbZOKDn3I58J0g76P90ZjbPJ3UvTgMFVz8
 avmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1786616429; x=1787221229; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2KJ9zAe7qCB3LtGaL4rohPUD7uiks0q+L7rs3t64H4Q=;
 b=iblVl3ggEaGyCUQB5uduliLtwCmZC8FLgGJa5VNo+LKYYrAFstl+ywcAQ/ts4bivQe
 Twct1lOa2LYAZZqUVLN9dPGhwVU3IyoQ3JuyrGabBr4k7e6aOk/ab5QdI1LRdVLgo8+l
 6i6ypyhzj+dKW9qxPssrJuTBG0w7ehheho0I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786616429; x=1787221229;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2KJ9zAe7qCB3LtGaL4rohPUD7uiks0q+L7rs3t64H4Q=;
 b=Nz+F3wlntp+Qcr/uU9d7d7yhLW/FtJsdmpWbcGf4HH4uxVfFspKfcWUXgJhM/yp+mA
 /V3QG9Rgu8VCQXGUqyB3GrISVgLnaYbvt8gA9vLvbGSuIGV4DbOkVY9OrrnqyfGp+aXX
 m1cyFzaP1c7nS5m/Rarcu3oI3smoxWIuo4LCAllVbZzbdXEZCXnwL1LTQ5Qi7X4p7W7u
 2N+3TY112maLA03CUA0sUpD6Ote7mWQmtHedXmL9W3NT3i6tUX2ujJ3YZWh5Y4/K6CSx
 +1F5lIxXT6w+K9DHQ4XfCvkAjmas0n5D/kSIF6zn2SDg/528bATsJBMOljaiTiLiWoaS
 JYDQ==
X-Gm-Message-State: AOJu0Yyjh++2+43dgp8+6nq+mWMbAkVzkz28rDldnbsfpheJxuRcbG3G
 1z7zTFqay57OBq6Dt0IL9btdpcwZRV6mNVS8PsN57swNW4FwVytUYG3AionRpbB30Vrp2ULldVu
 UZtM17qGzm2RqUgLqZYtkwCf2QV2uZYM=
X-Gm-Gg: AR+sD13DRF/j7MrbBsi8AQ/I2Dh/TLU2bSYwJnFdqvXe5QUVOvrkR/A2m/DeSKTmD+O
 H+WTSlVR9oNv2Ro6s6XKYva9AktyxceTbgZXQDMuSNjhR4kakvYxwNBgZZ+sqM6CiY+DgKwHYPp
 PeH0a3mLEmhFa3N26AekjCkX8xVhTIOClw7706N4ktLsbGmMp5DM0qfL9c2e9CfIfAzIVHqrESn
 JSKGf9BMGD6spz0Zzs9FAIHtJMLJot/MxL1rQIcJShO1nstNJJUE09YbpGLykmHKPRyJ6sxZNAM
 F3eoluO8S7rlyoPTNXUXG5i3CfXvACKI3hPoLVSJPnRtLb64W5she0DWb7/bsl2Y435rFzvvfmG
 GbKpJ7jcOyeC2uEy1IQIqsgznzSaMO/t1nDE/8W4OMvggTHOrheiCVYs6KyARQovhKw/DJ0Jt9W
 8Et2jHbHxY+yxeqj6F
X-Received: by 2002:a53:b4c9:0:b0:668:8bca:3c41 with SMTP id
 956f58d0204a3-66c514c07f6mr1531729d50.17.1786616429530; Thu, 13 Aug 2026
 03:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
In-Reply-To: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Aug 2026 19:50:18 +0930
X-Gm-Features: AUfX_mxMXl61z8KLSJ8kDOShwc_2crFn0jV7a2KzgZ4VeOsrDkfJFzM3rb-6Ihw
Message-ID: <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
To: WX Chen <wxchen0913@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Sat, 8 Aug 2026 at 12:02, WX Chen <wxchen0913@gmail.com> wrote:
>
> This series adds a QEMU model for the K230 SoC DesignWare 8250-compatible
> UART controller, wires it into the K230 SoC, and adds qtest coverage.
>
> The implementation supports the registers and features required by the
> Linux 8250_dw driver, providing an interactive shell over the serial port.

This is a model for the same hardware as this patch:

https://lore.kernel.org/qemu-riscv/20260616190147.1286316-2-visitorckw@gmail.com/

I'm not fussed which one we end up with in the tree, but it would be
good to name it generically so other machines can use it.

Cheers,

Joel

>
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
> Changes in v3:
> - Removed all hardwired preprocessor #if conditionals from the logic
> - Added a helper for the receiver line status interrupt check
> - Encapsulated CPR and UCV register values in header macros
> - Replaced g_usleep() with qtest_clock_step() in the qtest
> - Link to v2: https://lore.kernel.org/qemu-devel/20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com
>
> ---
> WX Chen (3):
>       hw/char: add K230 DW 8250-compatible UART
>       hw/riscv: k230: connect DW 8250 UART
>       tests/qtest: add K230 UART test
>
>  hw/char/Kconfig              |   3 +
>  hw/char/k230_uart.c          | 816 +++++++++++++++++++++++++++++++++++++++++++
>  hw/char/meson.build          |   1 +
>  hw/riscv/k230.c              |  33 +-
>  include/hw/char/k230_uart.h  | 198 +++++++++++
>  include/hw/riscv/k230.h      |   6 +-
>  tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++
>  tests/qtest/meson.build      |   2 +-
>  8 files changed, 1559 insertions(+), 14 deletions(-)
> ---
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> change-id: 20260808-feat-k230-uart-v3-0ff3651d70ef
>
> Best regards,
> --
> WX Chen <wxchen0913@gmail.com>
>
>

