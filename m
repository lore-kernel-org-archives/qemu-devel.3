Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A547CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz2J-000617-LG; Tue, 09 Jun 2026 12:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz2G-0005zw-Sw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:10:41 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz2B-0005o9-Ki
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:10:39 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-beeba001887so761298766b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021431; cv=none;
 d=google.com; s=arc-20240605;
 b=J2SGbh1MiS2QtBPKDvRuIt/rZ45388G5BWGiNxjI3miN1IU7k6rCdGZbPfbbugvArq
 5vDDc/EAZrRrQiUvowT7VAbrzWBILYvoQk3jZ5P7ItmEqkUIwjcHkxXVz9Zra94CiAXD
 AJrpO3NTEDvn50m+fk5setgBEQiFoDD3kaKLk7KPBp15ZgsooDPQexxp3To2H+0KyPeT
 YpmFgwbY/oznRGs4qdOqGXB1DYRmqflmahv2cZL4Ug/TF5lRcx4aSNZZM1p/bsYW2M8I
 +sqUjy97IHftgUBd8rKFvOaSdeVuRqVNcaR1gFomO1ggU2rOsH6gO9oLIhW9jlI/ysX/
 JoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VIG0MZnjHRSVsFBrIeDs2gVQ0G0tC69GRVVdufLEJMw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=R6mQ9zg3sBaZdYL8I36dcmlAfTOLtP4tznjD6JkfHYv0Pck+jnib+huxLa6T6pBA/e
 ubjxxB20BQLYMlif+sBDyYVm764Cab+F+NcGBunADstoURCpOrMQKOdOaL8eBUfoMlhc
 zA44WR/shEywGmVYGdex90RPakzcnCe08hUWVO8lHtJPvlopBM+vvxJjRq1T5agHOipS
 nagpwhB9BtAq+97X+x2dnFlPaQNe8lccwVqz8k9Oreh1yZdXMkxUEruyjwJCcj90g+VM
 1a1DEF13t1GsJXcNIJSqHqEFKhrRoYqmwcUA226atzI52ctT+CWOmr14JIOMB7t34xmu
 NW5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021431; x=1781626231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VIG0MZnjHRSVsFBrIeDs2gVQ0G0tC69GRVVdufLEJMw=;
 b=cjybZTCB+8aamQNXtJig/anCJj+WLzDYubfCespm2qLNNCu8noZ3o6VZTR+0MSLF58
 aEmtzaEOh30xhw5Bc5ddvAUn9rrYbkuM3KzX6ceWcp/1tZqqcOXQNNrlsZwl6jGkfGpH
 Fy0+ZLGhhgAN7j7HOkcE9FdrAL+tDor9vAKHXECpz3ejDNk68/JmiXmExT9GbzR/zw8D
 keW1k53ZNUko85vxBGn82tuMkrT9gV3iko0bA8jf+NeneX6Z4EJBvs7ncLEJ4UQeSfle
 l98zuxhXzZ2IgKdfwoacaDuwjGN2oAXikb/teSM1NJKdDY0wEbvujt8LQoWJT6ICAAIC
 Alwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021431; x=1781626231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIG0MZnjHRSVsFBrIeDs2gVQ0G0tC69GRVVdufLEJMw=;
 b=T9JVSUSz9rUGA7+ordp99+vc4Djn/yCHkXdIJYLrG33Zfbm9LVF97PiSaeGJtvf9/Z
 iY0ZSplmsDXUTH9WM5XFqcQStHqHbiBiUcSYsMMzIkvtXh9anW1ZnXqQ9cww5aBERamy
 QY7f1xlqHbsyEk3C+MZ752EuzGZF/hXsr6xeB/iTe2mF1EmlNeK40AXpzfaie8Zteso6
 +qME8og3CVJcO/U+k2WmWhkHixk79jc9AeDs1CBpJrBVUdTS8Mbr2mytMOZEBRzlSPss
 bcYNPCbJwgu1sbtBMBm86cgMw3FvdsPt7+lgXNrAVxMMnLId8UthnWJg0dmLtuuYavmS
 F1eg==
X-Gm-Message-State: AOJu0YwgZg+sfb9kelN/Dfu+WR5sjzzDQaa9kJFNPf4kn9OP0Od9eQKn
 aqw9BpyMieUa+sdI4CkAW+b7z8jPhMqGSytToF7i2Pj9IJe4n3MIGIh/nArJaz9BOhpcgb3n0Fh
 HsIoNnlzBsqDddcBJbTBK6L2VzNoEk7ZFVFTknNzjMXmOocCKBrfK
X-Gm-Gg: Acq92OHSS3tT6j7VsK+Ds7Hgz4PA2BhHw0ITgv6rg3ijGhxCdmTucN8HMQsIJ7VYdy8
 TqO3dbXo8SZn18xZdgtinw4QsdFkHpEl1l1dlu+TNUA72vthNdwPOKndPmKkARWmk9hh2/W/+eo
 T0GBfGagFxdepkuGcWM2g6SK3iFKOgZaCsgV2P32wRMnTYOliVEOzZiA73hllxULI+zMv0IaEq8
 VgykawNsP9uVlUSywwa+xrHzAbHa9hKQoJAmQSK35E4ANQ/4LVH/IgqI+ZpXMobq5wt7Z1kEtDO
 niLwnLQsZHSa3iwp5bWhovavj3bQAoKqag66ZRnt7FcxqQY1YSv/hgmmPNI3Rb8uEiuLd3677il
 Q9w==
X-Received: by 2002:a17:907:a44:b0:bd5:2c3c:616a with SMTP id
 a640c23a62f3a-bf3743e3051mr1079574666b.37.1781021430792; Tue, 09 Jun 2026
 09:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-33-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:10:17 +0100
X-Gm-Features: AVVi8CdRY5ThLQElmzgJukreK93-MzxXx4iJs8SRVDtMPE-EgEE4Z_b1A3ZTIso
Message-ID: <CAFEAcA8fCEU6hmDOGpFrdzu51=MoGHzU2YHUexQyowF1Zn3-5A@mail.gmail.com>
Subject: Re: [PATCH v9 32/45] target/arm: Implement FMLALL{BB, BT, TB,
 TT} for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 3 +++
>  target/arm/tcg/sve.decode      | 5 +++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

