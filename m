Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A94CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IPA-0001Fp-Bk; Fri, 10 Oct 2025 15:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IP8-0001DC-HB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:50 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IP0-0007bI-8W
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:50 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3306b83ebdaso2143865a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760123019; x=1760727819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PF9aAije30IVympYVSl2qD0049UQshA91FzIHdSPVXw=;
 b=bNy14VVxL0nQqDMxStaGArkWAc/wLG4z9JP1AXhEyx6X4uw53B7ObTGtOcwqtoJOuP
 rUbo0q42shCPjY2cdK7yISorPkh28vAASgfiU2nuCCXv/2IJtCw/ly5SlOcbiOQni7u8
 oyt7x/VfEHFHWNcqdBMkEmXlYEe4JutKdpATaXz7pUT+ZC5gBg9dSWjd5lPQmT0PWGF3
 Viyoolfh1dy6n5DczYn2xFxqTK3YsKZpCKakCsUquZuKfFhfq7Vb4ywOl/Cbx/Bygcc4
 isfQeEfVSztnaG+eJYBJ4iijDYTGvYmmV9HAjOMygX3eCBWCRzgDb5NdQBNh4QniUw7M
 vkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760123019; x=1760727819;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PF9aAije30IVympYVSl2qD0049UQshA91FzIHdSPVXw=;
 b=crW7p9bkRd8FP2og/9ubTQ3fCl/AESWs8nPW7/Do+cnRxkmUiE10qgEOgixqFPYgrG
 iViEhzq5gNf1U6g717OjZ+c8H4qkNaz4fM87Xpdru6g7UoaWjB8fT94eARmlkGXPnKd6
 6n16PqcPpt78LbNITkXire24FSJMTQf2PDj0evPd/f1oyLUK4c/jQULXDVyu2+hEvng0
 3FWZgFAd+bU5UxLq1Wwx/ljE262vzXh2suYbD5Wt0GhGMqZNRas1AYz3XCeyAZQzxhyk
 fB2pi4MFHTn+QBr0GTD6D87+5pRwNek1W/9EqS05DAj27G6nhUv9yyWxk0WhXLaTyfwH
 qwQA==
X-Gm-Message-State: AOJu0YzX+sWfTZhM0FiHzk5P3vlxTuySjoUBpAHYI05hTjkT/QcIyKKF
 zXQcz1y2Px4W1xcs785+wh8FWjZeg9zaJwiJeK125PVRVn7G4pwt6BfIxlVtJvOmSlT3++895QT
 AYreJSh0=
X-Gm-Gg: ASbGncs4r0UgSnDqoLihrg+AAipSKPdcontqYFFW375p1inTUBEyObuaJxXBVtV8UZ9
 5Rrsz73ZBJ2vawXgfgAlySliz/glfxpCJYFijNcjknSlo7fYCyZwKGj8y0F6eERmSK+9mX4VER9
 76XvOnHnt9a7MM5cVt7wzules3F5ihF9CaAMdOkrkvSJ4v1r/+5Tu73Df1GlAJpeY/qwvrkMu04
 QSHbLY6lhVT51oWyKQhCo/tXCkJ2s+vc5am4ZQtQU3FU2PGNkV0DOUf8naEY+XBYGU5lJ7XKka2
 sMZRZaf21DdDzOfEv5t6GlbSqM+CvZzMPNbIWTuvSYHR674ysoiC6lMzYozXc+B8xNrEESWdPbC
 SCj4RAn2S4Y4sp4tS+lecizAKXPJ6laM9MmTVJx9u2fabkjGDqPUDTaxjw/QjwVLmdxuY5g==
X-Google-Smtp-Source: AGHT+IHqY75HqgfwquYjfbshpbl/OCCobYnJnHqPJJdrZj+2sM14KBz7J+n1zREngMUHpWcexumMhg==
X-Received: by 2002:a17:90b:3908:b0:335:21bf:3b99 with SMTP id
 98e67ed59e1d1-33b5139a3c6mr16993651a91.32.1760123018683; 
 Fri, 10 Oct 2025 12:03:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df24ac2sm2964238a12.22.2025.10.10.12.03.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 12:03:38 -0700 (PDT)
Message-ID: <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
Date: Fri, 10 Oct 2025 12:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] target-arm queue
To: qemu-devel@nongnu.org
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/10/25 06:04, Peter Maydell wrote:
> Hi; this is another target-arm pullreq. It's a big one but it's
> only two series: FEAT_MEC and FEAT_GCS.
> 
> thanks
> -- PMM
> 
> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
> 
>    Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251010
> 
> for you to fetch changes up to 00936783abf77ebb47a78312a2e6500c6a13d938:
> 
>    target/arm: Enable FEAT_MEC in -cpu max (2025-10-10 13:22:05 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Implement FEAT_GCS
>   * Implement FEAT_MEC

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

