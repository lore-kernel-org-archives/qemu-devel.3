Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EA2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpRF-00016K-Vu; Tue, 26 May 2026 06:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpRE-00014P-Cd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:55:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpRC-00019u-Qs
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:55:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so6478990f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779792905; x=1780397705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0rhAlZ6p1lCvFFQd02A86PucgLsfqydlLMnu4fH49A=;
 b=ZPHzcDgW/tgwPSmcfEvZvIjN72zkzu9E6gqTd8iVAx/LdWFPAz+K5MMPnBj4uB5woc
 bfN2hu11P466jyCS8YjhtEIm2tWMIyE1CawL0CJqkI3dAaDwPdRpC/YwkhOyUCpmMKcd
 OXQcQsSwIVsDSVhF5zYBfHTQwnj4q+cCwClMoErKfqrl1/39GNH/JA0vnmgXE2e+KSH9
 6YtcMtyXTLz3v8qGxQ6PtpCA/L0ZBIB9N5feu5/a1Ym5D3QzSY+YFZv1XPa2lnKX9VPo
 a4ucxJoebL0sCrE4+Ono45eKSQzIcCXTMdfoON4HQ1LwGCLM8FoZ8nU1StDj0cfvVn4n
 JzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792905; x=1780397705;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0rhAlZ6p1lCvFFQd02A86PucgLsfqydlLMnu4fH49A=;
 b=P6FcIfRUH/j+5C3nzSDQ7TS6VHyMfwooAT99vOW2f254z4TaaA/ZPeBaiQgL+4g+UE
 bPQHyhKEBqnGDigOkBvP+5Ychd/WrOI17o2tlnR0SmnHnN7Ho2zKBSKUcszB+U/0py+V
 W5ZnovvEnrKUofkToC9VheMnzZ/ahh4a1mIJnMPwxXIfjn7uGN1d4efxvXHmhNf7hS2e
 TbOzdgVrsJLPT1voklH3T83fuCmAeruPlRov/aNTDvTkMhB9VTTmn8FkuEKsKipIvieV
 9lN0a7PgSOVq49nm43/BVKchX/yyHuwAZRKz3ss/l5YgYQHMCJAOgsUrG7xI3127aETU
 WAdg==
X-Gm-Message-State: AOJu0YxrIn2JlQaiFDhU5E1t05A9PKxwjNLe9VfIn+qmgvONCLSBRAnY
 B9MFD2YIDXRD8Lwza10mITnKunFf5xD1HVDxPrM7A6cZt4jY/Tl71DqWs7CB84P3gXw=
X-Gm-Gg: Acq92OF4SmcsOy0ng+2S0BfNoRPmXpPOV4DQKTIA1BpWY7mrVg3Pa9RKrn1GRrZhRI5
 vhBIZvGd6SpdcqpZV5nNXKKYgO8/hPduMLYoWDwUu25qRLjCgfP+HfqXJOY0zQnp+DnuGz1dc8E
 bHm+ICgXktursA1mOdIsNgRrXKxk8wXn9z1qSLQ1Oi3eMOpwUEDwvzCentRizWN1EwKQOCqPZ1m
 pVeJ3l6P8Qyf8QnH6zY1j5E4yQhnn5yB96Sa1KfHaQUlhDc4i37zP9+0H63N3JWURAariDWZ+wZ
 DwRC8tmvGLFFgvYdgLzXaacx3iGvhXOKDBGhBJhmbKPS7TouR3uZL0+J7m5xtUhJIrRG4Ga/8DE
 WRKBvo9Dp8IJhm6d8BQ39YHL12/R6inI8OwXgtjxSZ4vaeQLVNltDpylYW0oslOhVqYGBunTy77
 /kdnjvtkD3mJ7sOdAArU0NmtU=
X-Received: by 2002:a05:6000:290b:b0:43d:7e6f:3816 with SMTP id
 ffacd0b85a97d-45eb38c359fmr33133949f8f.40.1779792904760; 
 Tue, 26 May 2026 03:55:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd151asm33841725f8f.13.2026.05.26.03.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:55:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 388265F810;
 Tue, 26 May 2026 11:55:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] linux-user: Fix typo in function documentation for
 pgb_addr_set()
In-Reply-To: <20260526104102.5283-1-deller@kernel.org> (Helge Deller's message
 of "Tue, 26 May 2026 12:41:02 +0200")
References: <20260526104102.5283-1-deller@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 11:55:03 +0100
Message-ID: <87ldd6zbi0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Helge Deller <deller@kernel.org> writes:

> From: Helge Deller <deller@gmx.de>
>
> The third parameter is called guest_hiaddr.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0e757787d2..f7625c0952 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -848,7 +848,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uint=
ptr_t base, uintptr_t brk)
>   * pgb_addr_set:
>   * @ga: output set of guest addrs
>   * @guest_loaddr: guest image low address
> - * @guest_loaddr: guest image high address
> + * @guest_hiaddr: guest image high address
>   * @identity: create for identity mapping
>   *
>   * Fill in @ga with the image, COMMPAGE and NULL page.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

