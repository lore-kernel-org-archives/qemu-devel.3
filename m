Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B458C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWs1-00036F-QH; Thu, 01 Feb 2024 08:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWrv-00035O-J6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:12:41 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWrs-00035h-5p
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:12:37 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so287976a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706793154; x=1707397954; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IEOCIMWL3VuVKDjq1KTj5OqvLS5MqW+zEmHNDqgSKCU=;
 b=IerdaSk5RqpvU4EvMPJZ1G5ZFvpVal8aF8pUE5zQrJQvYroQea29z+AwKOrMClAhVY
 uM+1nVX8dV7l9arbcRYPgOhM6ms1gcAgnJpV3pLYHZwUYJqxFvHG81oy4cuQrySMK13q
 AhGro9E5+RT1mL7cvKxKeT2uzRlZPRpLSDwJUfUKehoNE0PWrWTszsijqNLTvuliLNuy
 uScifZbGWO7ZmoV+FDANKeCLnHydS0s2DpfdT2PKjtN62VocEeF9cyzThPVyPKD5hUP6
 NDcJMKCLPgAbCsI+vIfMXBveO94dTOfX5lt6FtLkGNrB2CDCBMd/o5VtyIjf473JHocw
 5j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706793154; x=1707397954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IEOCIMWL3VuVKDjq1KTj5OqvLS5MqW+zEmHNDqgSKCU=;
 b=pT0n57fuylAixnM05EgaYUOFX5eHDBdqyr1o3hAtSM3pjTNNYFlhP/1r8JxSuLRKCc
 UlCSdQ/AheXj/PMbyIMm4Orf8U8EohMhNM9ooXEsQlqzGG81+sgB0XutGJ8w/ljj/7Yn
 TCKcTeP/GH9WJE+rdWtlTdjHjrB2G1+S9T3YKCu5K3gkshpxsvxSQJ9VXlTM6LAq4Jbm
 W6m8VOYuNXi1ZNr+2jBDtHsmTnkHUtynHFTFBIzV84ycJMztwIKwVn/zeai7a4f3olg7
 LdzgrES7C3HYs1RnIh3wpwukX1z9wrvy1oIDvqVz0Ujr+L4r/e5TMnpGqUo7gE0DJKWM
 IA6Q==
X-Gm-Message-State: AOJu0YyL3yO0zbk69dWUVMt6fuhU/e7IGw5G/cscY+5AG261AaQ6HvBR
 HNSmCaPrRfwOmI9wgjb+ud08QOK5uzyAYkTkRTCAqbigjDyH1ha6snct6j3BIPyOp/IoyhulGgt
 wEmMEp6NCQryptQT6sLXVlThTkSm6k78107xcFg==
X-Google-Smtp-Source: AGHT+IFXWxcE59UUQSIEJDGfdMaqYilACqhVAhjyscDVyUldv5RCgxzgprhevI2+oVE7leD1F/Ewef4JRFmR5yxVr24=
X-Received: by 2002:aa7:c156:0:b0:55f:cc6d:9d02 with SMTP id
 r22-20020aa7c156000000b0055fcc6d9d02mr503960edp.25.1706793154180; Thu, 01 Feb
 2024 05:12:34 -0800 (PST)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
In-Reply-To: <20240201130438.00001384@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:12:23 +0000
Message-ID: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sajjan Rao <sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 13:04, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>




> root@localhost:~/devmem2# numactl --membind=1 touch a
> qemu: fatal: cpu_io_recompile: could not find TB for pc=(nil)

Can you run QEMU under gdb and give the backtrace when it stops
on the abort() ? That will probably have a helpful clue. I
suspect something is failing to pass a valid retaddr in
when it calls a load/store function.

thanks
-- PMM

