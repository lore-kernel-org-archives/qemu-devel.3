Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE99DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9CJ-0005W5-Jq; Wed, 29 Apr 2026 13:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9C6-0005SR-2N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:59:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9C4-0006CN-75
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:59:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so445535e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777485567; x=1778090367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fw+4VP1tFhJEqc3YP+LUHQ2tRwRgORfHZKfCOycODHg=;
 b=mkeghWWlOwp74/xDFlm79yQTVq0Qr5Rsoj1+HjbLJc6da8Rg3ul2QIMCpz9YgTpuVA
 Zrkj6b2zDTxS6OvAZNv9FA5nJH10NSAIvTGC2oCBjjLaWT3FSAesFncRYHgQF00LvPsc
 VU61MGixqrrqzPEUTNnQ3Xyh6jeUnMYyxT5YfDadmMe9Y8haCJIvxtD1e5ARnb7xVVKm
 lVwOT6h5Vj7Xy6rMPee5lc54a5Jz/ghx6sFRMqLTKjzVfjINIADKeHvQgGfTDXSR46dy
 IR5Rk27Xdq720wZIHffhsjycvLWI/Eq2QyZOU2DBcQy9bND6FgV/wJ+21VMn+9MVuVIU
 xGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485567; x=1778090367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fw+4VP1tFhJEqc3YP+LUHQ2tRwRgORfHZKfCOycODHg=;
 b=mooJeblPwHUTvWFeIvKevVkivULoenPAPccB3ZCgM+8BaTzKUt8mB+MTxztugZonQ4
 QCxloInKkiC9OdSx/tXfwVK6qmYSNFUHfDvUol+j7iMr5Ezu9NbQOF5YHnZvjc8iFlfv
 ZPsFsyRHX06k0rUgJ25BWOAcWjdiHUrnw5ngR0A05P+zYuS4WxWSfIUMFRJHBpM1fcjX
 8cM6NTC7Xqrni/OLn16gtK/TTz07damqAqLFNCJIaj3FPfj2JyF1oiZg6+VAI1vupbx0
 sKex4k1pfZhlcAJlbhcqC42zrR8FDGIqQemggh1m10tzB2st3faUWYtXqRLCb5VzQR9h
 yUHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ay+iW+5gnKo6aYhUS7RMistfeK1BIWEIO6olcO9lS8vFg3itnXkRm/asxpNvenUKU1FfCqaihjWmB@nongnu.org
X-Gm-Message-State: AOJu0YxtWzBh8kLfdzYwTh5o0DWjTEsKmqhxc6hIT9VEbwaGvETE0x2C
 8cpsB28gGWJC/0Enk6JzckpmyLd42t9HlaaVZzBNLKqJNJMSWfsAUcNEvZ2taqunRDI=
X-Gm-Gg: AeBDiesocxcy6vdRoHQfQIi9znlExrlUM7m16xXB7L9iQZjg3gr6mQa0UFxN+PD0E3m
 2rM9pg6+ib2MlheEGkDFkG68xlhjiSqblEnyl3/qYnCtXsYkG59C4+y8UZws4XcXDRu3inYQwtQ
 s5bqpJ2szpwU/gtigjiJSOOJpnDpmVpKWHFMf6C+IKqlpHsXr+cySXHmvV5gGdMgMNpFhUlUCDt
 urtcmM8M+fENP2XzER1dWPRFMF2ksjyqQvOwEBuku8ixM+TAC0pSF31U+OuEqK3Ym92mBzey1TM
 +FbPNR2pS2ZxT3u8fN0lMvFTr9zCDxqFD0kp5sReP2LxjGNDEiwQ7av9AtdswbtJbM/G7uc0LPl
 bszaSV3XmT51mLViPa5btXmL0o/CtS9ljAUmuUoLbK200Ez0+RHG8B1wUZeCn0B+Tz5covOflPD
 34u1ZVt9U6eTmRHUOleaeZMzQwVU7xiHCV4PEzlowyOqOG6B3wUrd1EWNk+8cvzFeH/dQgvu/AS
 VK5
X-Received: by 2002:a05:600c:3b0f:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a77b061a5mr138733835e9.17.1777485566599; 
 Wed, 29 Apr 2026 10:59:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm7550980f8f.37.2026.04.29.10.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 10:59:26 -0700 (PDT)
Message-ID: <ad7915e5-5d68-45d2-8cce-dfce3c7292a4@linaro.org>
Date: Wed, 29 Apr 2026 19:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/84] fpu: Return structure from unpack_raw64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-33-richard.henderson@linaro.org>
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

