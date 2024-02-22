Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672A6C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCyh-0007Rx-8E; Thu, 22 Feb 2024 12:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCyf-0007RV-O2
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:35:21 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCye-0004dw-8e
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:35:21 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so685593a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708623318; x=1709228118; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mxxx8zDL0M3ohmn9Aox4c3HM2spSYVWqoIJfbMbG2rY=;
 b=n5D1GmKuQWaCRTkWT8e2SUlB54U4G9/qm46kH/oo7xyakgl8UWrm0ujz3ev569qQ36
 E4/PUMODxRkqwUcjh9ckmzoNL4ny2MSk6hId0SRAcl+xL3Kv0j5VwAFT66CFOmBiSTlf
 zmXNOcWdqN99JV/Vak+77P2Kh+Qb2mct1VPcOk24KzRh1pyOE8yytOKWn+vu7Bf/RrG4
 LQKNB9m0u4RA34IuqZIitJzV/ceilt4zcs+h2AV2/yLuavuzeE6mjZho+ziPa8wvRdFn
 N8I5MxD7cYiEpfGiG9eMJhPJw/Te/idMHzEA82AA+4iwvmiOICpyDDYEXUAFQUriaeRp
 mfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708623318; x=1709228118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mxxx8zDL0M3ohmn9Aox4c3HM2spSYVWqoIJfbMbG2rY=;
 b=gxx9QW6tJZQHqVAg/BRi/92NG4p8f7DH9OzB/ITyvnEoRAWF8liRB2v5bBnZPSlnQm
 gM0DSZi+S6mplqbvXnkRgVomz+fwR4goomhme+oRnkZN7I8wIqCPVy46D97yjB5uINNe
 oPEid3/o9uSsk76JFLMPAmqI7Eq+uE/iWFyO47EUDQeddBndThVwLMDbhafAati08IwJ
 QzobffLNWIR2UIG7NvaiZyo31eijq0ol/9rzr/LH7LC6YDAQZorlmFiU4xJo+m45D8Pu
 2cEQ0lSKAV5Tx9Lk+bmNZOFR0upzhUwb29HpcR8WEyqB7kvRR7sgQQXEk4Ppr907CIDz
 4uOQ==
X-Gm-Message-State: AOJu0Yw3BG3zeitBVOM4oilENOD1wuntZxngHejWq28iOvR2D5U9t4nO
 Gq3fkNChhbqWP9dWt0D2+hv82ybIGMW5bf5Mwo6s7UQZxmn5EZxwPs++SWdbPldc2EcybA0zcJZ
 8pPXvat0VTHKMzocLuR+rE7lZ0juqrBCnkpqePw==
X-Google-Smtp-Source: AGHT+IHGc7xzpKMoxOTR/sBFz/bV0sXQFDE8Qb5kuOiSCgx+NvFOofgn4l4IYFpGN/YKzdSyoXV5HvJG/b1jXLKwDZA=
X-Received: by 2002:aa7:dd02:0:b0:565:43e7:7b5f with SMTP id
 i2-20020aa7dd02000000b0056543e77b5fmr1585759edv.5.1708623318524; Thu, 22 Feb
 2024 09:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
 <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:35:07 +0000
Message-ID: <CAFEAcA_F_tRJb-SWJCmmZXAJgvXm_Gs0mNKUwiumwQWhQY3PVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linuxarm@huawei.com, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 19 Feb 2024 at 17:33, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
>


> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

