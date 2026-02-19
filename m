Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E3E9A05B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9EK-0008OC-BK; Thu, 19 Feb 2026 13:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9EF-0008Nj-Tj
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:58:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9EE-0008Fh-HJ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:58:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso10192975e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771527500; x=1772132300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4jY2TKQ/6khl0TswZ38/HGZjrhkE2U1OAjxsEygmsQg=;
 b=fVIM+1Nq6QRclHlzeQ6QjwLOSR2vPNx3dgplJGl3bVOdF71T2Ex03O47mRXN3v+IfQ
 7klvTLo2pNumBH3HgI0R+O+gYvhUX/U9Gr4qFpNFR/7bcvn3sX3UcoHkuYHYjR0SexOQ
 mBLmgo6eF+JuuYsJqXmmisScrLIOFX6aMqbLAbqWalPd36UMLXladBlg2zhf/0uR4fOV
 ArvKdIfeRgDUfJ9mM20cEuAKrKOdxcIF2FvWwpPBNG2crUMh1XSpGHjndDzj6HYFsLyH
 0s/kxV5v3A7IyCKDVMmxOwLygP2O2GHX0XpoicC1WZvlkFAZoLyMWBaYtDxhsy0x73UK
 BcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771527500; x=1772132300;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jY2TKQ/6khl0TswZ38/HGZjrhkE2U1OAjxsEygmsQg=;
 b=aUQTFFKASzXZza7meyIuwB3F6fjdc0sfS4QAB+mrejHh7XJtefF0vBH0pRguNAFoti
 dEu4opd3kNwxbPvBBW0rrnApNmbNf5xUysd+3qvSzfoeaPJds3VcXVVkIf7yH+quJWSp
 /MBgpG7N8EDJevd0YFz+IBz90Xg8tR6ygoDx18QLzUt+vTgjLa1f4gT5CpmYYWdrQvS+
 65RK8V0M+CnjyCJQMDUGgGNjpeppqHFI1Xnw+YdY+0E5cFtl4TsgXUoCXTJ7VCmL6HIC
 G0NEcX69R7j4THFYgkmbFAGDJmdhm1kxpv9JH+P0y33oxOwEdzGk9NZLxeR+S/EMUxxh
 SpIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlQfPqa9ITZBP6OIUtx5y1V1j7BJp4cD8qx1dkiLq5CtqdDShcD6PgKavrCnm4WNzE25gu6UtYcyn@nongnu.org
X-Gm-Message-State: AOJu0YyNjW92XSRxLEVtq4+zYIYFlVq5hX+b66SzHXf0Yk9BiNUbYp2j
 MLR4Qlhepv0F6aF9Ynrb5F+r4PHFuim4E4vzrsf7/Rx1GLoRaRrk+LVaoHHpE7wdWSE=
X-Gm-Gg: AZuq6aL/z8tk4BgLhyADL9ZPreAvtz4qufB8r9wMt7tNnSGSvNpAqtnlwJn23ryocmb
 0PYNYjB82d24AkL09UoOqKY/vGF0I5a1/2oKjsMY4jY3GXGn1RsqRt8xjYfucNtxKIHPawRq4Wl
 LmVVRXWLF49pWuz4nY6+iI7Lo0Nq52or8lg4EXFW4YnTPu9zWlKZEePHAt87XAyniJlP+XBnSfY
 aiUQZ/JD42ceY3XX/HqX5bcOCVq7A4EKPtfpZwsS4DgSf6pj4slIsU0MR3CCeLxNWZ3m1kDvER7
 sZHKXLANuo85ythnZWNhTomGx/GBpLLcAjMDovdJH6PhR/LhUGHpkZRDMrtm9aDk1SvGnk7bX+Y
 V7rRYb4U1+Fvm4kfqbaRJNybHiJX6yywdh5f7QREbnQmRohW4AwpVxVzyZoB3NQfLeHYuJ9MSpg
 tnO2ATp3KgpHsR7S+Qd5CglhAGi84n242WUjA3p1IcUa0nPcAkoGPE98vMNmr8RzCrcw==
X-Received: by 2002:a05:600c:310d:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-48398aefddcmr101909595e9.34.1771527499986; 
 Thu, 19 Feb 2026 10:58:19 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3e140aasm1341755e9.22.2026.02.19.10.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 10:58:19 -0800 (PST)
Message-ID: <17d7732c-4518-4e96-ac54-d46a3573060f@linaro.org>
Date: Thu, 19 Feb 2026 19:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Update error message for bad gic-version
 option
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260219110228.3804482-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260219110228.3804482-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/2/26 12:02, Peter Maydell wrote:
> As we added different valid gic-version option settings,
> we forgot to update the hint in the error message produced
> when the user specifies an invalid value:
> 
> $ qemu-system-aarch64 -M virt,help | grep gic-version
>    gic-version=<string>   - Set GIC version. Valid values are 2, 3, 4, host and max
> $ qemu-system-aarch64 -M virt,gic-version=bang
> qemu-system-aarch64: Invalid gic-version value
> Valid values are 3, 2, host, max.
> 
> Update the error string to match the one we use in the help text
> for the option.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

