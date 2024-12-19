Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00236E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODHe-0000j9-HP; Thu, 19 Dec 2024 04:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tODHc-0000ib-Dt
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:57:28 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tODHb-0006SW-0Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:57:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so3914795e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734602245; x=1735207045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbdaFBXvdjDmxYhJJQN5vo9M1eUyMNfCbvJoibJ7eeA=;
 b=Svo/MDdv3Abs+roqXtneJyzJ4pqmlk+BbQ5NcWZObwvxcxfUBCYE0zp9mEMGOu2neA
 H/j9F0gZWn/v5QhMqCuwMGd/jkzK6XEeuAY0t67atTcqH3q7OwrNhK8M8WX+B9LmuaFU
 AtNp7ABWcypTrdsH/tXHu4cx/k3UqwC9oWhWY4udrKT3psR1aD4VoFDvO74k89tSeqlZ
 oHiqrCfm89QDn1Sh6k2/55xfOgHIvkF4WSB7QM5tQMwKGfWeT1dZlihK0fpzWWoIsrCN
 +2xt95I1AdGEphnxtmdEH8oiYJvYtRZJtXSW/WsXLSLkyu3nGFSMSmPNdrU7h46y1OzT
 QPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734602245; x=1735207045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbdaFBXvdjDmxYhJJQN5vo9M1eUyMNfCbvJoibJ7eeA=;
 b=MZIeFYgNpAHC/pV+6+xxHe8p/2l7hzhqnzZY64NSTTu/LZe6MUf+Ka+PIjUe5/IuqA
 NQrbGs0NTCF+YtRgUBoGMFRQ47gqBBh0NwnYDbbsuJwjgMVzjNgwN9zJPkY4kNnOFM1u
 ac0MQ9UnayFu6VCSNve9D3JXbUvogYf4WjZ0NE2mnBZGU2s9ge0R1s34jOeViM8GSl9w
 Hh4+Q0EjB0F5Kz5DTqIqJlHGjI44eSr/WNIVaIXqur2/kIydbQweZq3GY72njQvfocb8
 udEKTi84KoJMPy9NoMaHm18PYDaS9OLsUHshQlO203DrOw2QRLaTWhCBnaibxIb8Rkk9
 YbnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXakbRJ/YsZR342Tw7KAvbBHmahVsa3FKtvQuesNtIXJ0p0SRIHs9P7AF39Sd6uWr/9SjD4N095ZCZn@nongnu.org
X-Gm-Message-State: AOJu0YwN/UEitIgmHVirXNU8zvJlXUgcsdfmty4vYD224+zhMYXIkHij
 iLZLeuS2+pF4hJB7h89cPoxSd+omLvbJatudaCdrV8pPyBIODn5dEnke6eqzGUQ=
X-Gm-Gg: ASbGncubysbl9DGKrQygKwsfOpWV+frfbQMWY2emvbQhcbNxqOUO/A8Z6dQsboK9FL6
 ZPG5JWUdua2dt/hVp1gqp+FIYMyxboCajDDKsNKNYGrOxnURy5n2UYKgPRt4MoEcgRrcajlxADh
 /Tm5looPFUGALJtk5AbV7sWnicnUcO/6sydcHFxy8CaisSv4NhN5UK82yOMJy0v3QVvXtnHjD7U
 2L9jJhpKEDyhUBZ/yTel10jNRenrBl4MHKKNZ4SwoiLG7xxaBPdsFRI4fv8OhwJ31Q=
X-Google-Smtp-Source: AGHT+IG0l+iDz45TK6wd1p8m+hjjPUaMT3zkfP46Uy/4RUXipPUjUAz05Tp15U23lOTp+XoRCTgT6w==
X-Received: by 2002:a05:600c:6a95:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-4365fc93206mr11971955e9.29.1734602244706; 
 Thu, 19 Dec 2024 01:57:24 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a08sm13312875e9.25.2024.12.19.01.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:57:24 -0800 (PST)
Message-ID: <3170a353-fcc2-474f-bc54-84d440d5f3fb@linaro.org>
Date: Thu, 19 Dec 2024 10:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/6] linux-user: Use unique error messages for cmsg parsing
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
References: <20241218195247.5459-1-deller@kernel.org>
 <20241218195247.5459-3-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218195247.5459-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 18/12/24 20:52, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Avoid using the same error message for two different code paths
> as it complicates determining the one which actually triggered.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


