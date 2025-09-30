Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B24BCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3aUC-0004JB-TP; Tue, 30 Sep 2025 09:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3aU7-0004He-UC
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:33:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3aTu-0002Z8-RK
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:33:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso24112585e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759239199; x=1759843999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ngygC6NJy+4PKHvLfL/wAEP3H/h4SsMiI7zVJeRQO98=;
 b=mzNpKoIT9CmX1T7knAbXUnMupLnNM1A1BDd/KwVZap8l9vaaGU0rlHU7FUBWRv2J/D
 E1G7p845Aas6s3o7mCVK1HmWDyctjPXMeJbNtkBnWGeQOgrlACGH8baVNM42mQmuaQ13
 ra19GdHjX98F+UfirnHldbnpdNcuaVk0zEG8zAN2oSiwwgb0krzMAu4Bg2zdtmmrmumM
 c7DodhSV058135izHujNPlHgLRwvJ6apoVWVkJtWS1UVPnFAwF02jlNLVQZMa+wD/qab
 I9OXv7dtx1V4mt5jv6RF8RlZWN52Rcq0sQVSBV/2F6K1vzce0TU4DN1ezswKPKXtPY/q
 B+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759239199; x=1759843999;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ngygC6NJy+4PKHvLfL/wAEP3H/h4SsMiI7zVJeRQO98=;
 b=jyUFLd9xmQgyLZVyKbPxnT93Q3KSHelnWFxkRvvkAVVrsy1cI3OBY6ty7sei2js0zl
 bsaGIQ9sYQ+b1+NMQsrzxKcWV8EAtOJBX0ckv8EM5kAhkQOFiGa6m2lycvQq1L+TIjzD
 rgpFInyfvhnrudmpTJtFb4SmCSoykFP8gyGlpk3aFS+pPnbuNx67c0I4M3vk4l4gDdDk
 O2mgUfYNBwnJFLVzael5lPVax9TcNDTmgC6o15Mdiy3weYaoPasCyN9E29J86VVnTvCW
 OEZrAgN2qbY5Mgmm1jI4VNoyoHkYs6B38UY/9EZuImU2gET70H/8UT0CLz9jmlh3xbI7
 9Y5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdiQmzCFpiTBhoqCx04LjFD7Zusy19+Ki8gCDzUUnHrjNR5QvvYAtPsVGZwgXpIkedS9Z6Ew4OdWE@nongnu.org
X-Gm-Message-State: AOJu0YzrBzyd6Nqr/+F1N1+gjgjAuTECaObeQXZAfsFc6Z7RPTEnwES7
 Fs80H5F4o1PSJ/vOSTTozldvzsIVFYqTeUkcf8t/jtYcuJ5K6dmvUdDehE3V7gaHp94=
X-Gm-Gg: ASbGncuq2PWMW/u/SmLUQFReNFyZLvh6N6aeQNJysOwHiQwJw/XjThUtES3Nf2jW8al
 NHMdNdPfkwOscqI878Mo/kLbnk8Jx9PtQtDKbdHEFaLuf9IRPwj929mle/Le+wXHhORV0BF1DxQ
 SH6fhg16zRH1KOuKr9Kqq/F6XW5YkJNR9GgrElJzH0CNk0WIwwmHjG+cXF6NElRSwrkxGE516rL
 dB6zR9iPHyOPj+kfaZX52LA/i5ghTKauVKKLB7xsKT459A+ssVjz/vwoWoSV/avdCfzz/ZlY2A6
 PacB+D17WPYwMyhgwUsJYBdwEVk82ZcMLxMOybp+rVEwOwqJU3EDuFWCYdv1MD5jdBFxynedRpx
 p+GpUkX9WjUmhUrnc5ZEvRx/c7v/oA+j1FoNWZozGnmASx/hQV0tPfypPLXLXGnksjGkvaRoAli
 anT1QXloBTNws8YQ==
X-Google-Smtp-Source: AGHT+IGtDc/e5rRI8xqQXKOeSCmiVDhN89r/zsavC9X2G54wnOw9P8tJyFOQjnCY33fCmTLzMfpbpw==
X-Received: by 2002:adf:e68b:0:b0:414:6fe6:8f97 with SMTP id
 ffacd0b85a97d-4146fe69107mr9968413f8f.38.1759239198573; 
 Tue, 30 Sep 2025 06:33:18 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6de90desm23160343f8f.47.2025.09.30.06.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:33:18 -0700 (PDT)
Message-ID: <82256b42-f625-4a42-ba8f-00b99bf84d2e@linaro.org>
Date: Tue, 30 Sep 2025 15:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reqeust for a QEMU Wiki account
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <CAEDrbUb+MGXU6k7ZHL4ik-VK8hoS8KVQwmCe6cHNjHis-YySUg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEDrbUb+MGXU6k7ZHL4ik-VK8hoS8KVQwmCe6cHNjHis-YySUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/9/25 15:11, Kohei Tokunaga wrote:
> Hi,
> 
> I'm interested in contributing to the QEMU Wiki, especially topics related
> to the Wasm host. Could I request an account with edit access for the Wiki?

Account created, credentials sent offlist.

Regards,

Phil.

