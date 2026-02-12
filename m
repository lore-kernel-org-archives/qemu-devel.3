Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2642EE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYxw-0001eC-Rg; Thu, 12 Feb 2026 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxu-0001au-N4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxt-00063o-3D
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:50 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so50307605e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911447; x=1771516247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r7fSQvEWA6zG6VDg/Kes7hRwMPYq6oPMB/OIsM6d4yA=;
 b=S742A57Mejy4IT7JaP/HYGhflHB8rFs2J7FYq561vX1y1pZehzivZDTgdFNhGAwGpS
 mp9XjXvPoLJIbtuPGMbtEBL6k5vdu5CKKHQINVEaeYG1fZll4Xm7iTfOUU0kN2K3euBp
 BME9rLcVqszoA0GLc56E2QedEK7TURKTBgIC8NSv9CnxDP/g7od87YErm/OizBneFSyT
 6DyWSeqeNZXvldLCH/YYXu0V33thEOCw5ZsG88hsxjdeIw/INcgyM0puo+3pFVvPbEPA
 audJFlt3CIlekELaZfdGNjs/ICNMJkcOXg7uXH/kW2o2ioaw5uxmRQlBqCFdob64bidt
 5aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911447; x=1771516247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7fSQvEWA6zG6VDg/Kes7hRwMPYq6oPMB/OIsM6d4yA=;
 b=PcE9GSQ3kRlJiVd61R2lzhaBtbrT0ZdOpkL+/ulTGYjuPoqJzDgkDjAN83bQ0Swb33
 AYtKaxFBf995G7HE4STkB3xsqCLZCCK7AFpITakdZbeODbLQqdySCUKiKUYwH5vtS8a9
 V897U7CxwqqBhnA2/AcexhMoVy1oqE8D5SMds9BoSgbK5qGukJ1SZCWwei1Y4eBch3sl
 HAhX2vGmpMJAsG3mLldTpiP5KH8AulISDePsT61Mt6mH/jlaE7gYVJ0fCmBvaN2Y1HRM
 a+Pmv3aAvkn1ba/49eaLPOUCgg3L6rlFLjx+FPwjnoJhUWxdrLUTRDHbLzmOrkyWlYHt
 iFAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2nN48f/Tj2ORZVzlp3hhWTvEVn8+J4OmjpeSzjsn4kOmn9W7ugntdY1q6p5FJAGunVB+7717O3qg+@nongnu.org
X-Gm-Message-State: AOJu0YzSKdyVsqE+TuEIZOKItJjIGD4QfX+VjKT0qmoGm4vVTh03C1TF
 /Sz1Spt3dL5WYpz4eqlPc/w+E+wTz4sKL1sZMXqrwGwQdEJHWd4WutMHGNsUT86KLopQCvAy0nQ
 +iphSP3c=
X-Gm-Gg: AZuq6aIQjc++vAEwQkPfBVNu/EheZM5gyuIZAAsfrOiW7rXXvBwU7EP1Chj5E8vO2r0
 pqT+TNU4E/3ErwKGWsH48SGjzw7+XswWZckKqlRJ2HHA2Ct1AYPmcVndcD5Nw/N2TL6JwsScgD/
 cEpiJHLO1godj8o0B4Dnjkr+f6KfnHnOnG/0/7EqW0rE841sPCfYzWDaCT2fEhmBrTEs2etFOPj
 nA/IN0HN2UE8U5ksgV25O4CdsGpEFnmHGWVWcGlVMevSyUtPuFx2b5lNQuySf0pQ7eyYpSlvHVY
 DsTRGkadjOydW5Fx2SHpjpqtjl4tNMNrBnwlw7pAPEKd67y5iscRPRDK17r82seVYqqAnXc0swl
 YkqdJH/oKlAI3kCd5otIjJe5pFV2cOdbq4HAY5Sl+lAD+Vwuv59SW0C+XE18ShebtYAuNjeSdjm
 JouT9gA4Qacf8mGJvr84VcwAnMXdtdK4nswC7SReBhcOjYXo3DqM4r/MX1moC/LdgVSQ==
X-Received: by 2002:a05:600c:848d:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-4836571626fmr47344415e9.26.1770911447546; 
 Thu, 12 Feb 2026 07:50:47 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm104358755e9.4.2026.02.12.07.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:50:46 -0800 (PST)
Message-ID: <63ca45d9-6a8d-4083-8832-be00d36b10c9@linaro.org>
Date: Thu, 12 Feb 2026 16:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] net: mark struct eth_header as QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
 <20260212140917.1443253-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/2/26 15:09, Peter Maydell wrote:
> The eth_header is not actually guaranteed to be aligned.  We attempt
> to deal with this in some places such as net_checksum_calculate() by
> using lduw_be_p() and so on to access the fields, but this is not
> sufficient to be correct, because even accessing a byte member within
> a misaligned struct is undefined behaviour.  The clang sanitizer will
> emit an error like this if you run the sifive_u_mmc functional test
> with sanitizers enabled:
> 
> ../../net/checksum.c:78:47: runtime error: member access within misaligned address 0x561f52f35011 for type 'struct eth_header', which requires 2 byte alignment
> 0x561f52f35011: note: pointer points here
>   00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 00 24 00 01 00  00 00 00 00 00
>                ^
>      #0 0x561f20608459 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:78:47
>      #1 0x561f20117bfa in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
>      #2 0x561f20115c61 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:78:47
> 
> Fix this by marking the eth_header struct as QEMU_PACKED, so that the
> compiler knows it might be unaligned and will generate the right code
> for accessing fields.
> 
> This is similar to commit f8b94b4c520 ("net: mark struct ip_header as
> QEMU_PACKED") where we fixed this for a different struct defined in
> this file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This came up back at the beginning of last year:
> https://lore.kernel.org/qemu-devel/CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com/
> but we never got around to making the fix.
> ---
>   include/net/eth.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

