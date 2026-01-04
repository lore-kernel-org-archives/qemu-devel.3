Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234FAC2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 21:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcW40-0002hz-BP; Sun, 04 Jan 2026 16:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcW3N-0002PT-I4
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 16:54:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcW3I-00053B-5d
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 16:54:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so154426965ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767563656; x=1768168456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l28eNT0s2HQhubb8enm6f2kzdu0qWF61f0Sq1o1gJhw=;
 b=a65+UBRNDYZtN1qoEFDRH2RAs2mpMdkL+bOxlN+UhSmD7wDOxaRToaNlKS7Z4Yc2M2
 xoH5ta1lfPu2pPEmz61YRpEgwsBKYCRs25/31inv784XAZE9Zm1cj/deswJn2J5Ysba2
 Rw7MeigMyk+KpSQwPUOerr3thUCjzmMyVk/6qfQfW+1qnt5O3mcr55WaDfzl2JEnXbpI
 sxmz+TbTgkuXgQAN3/tV1+f4rJanMW/c70/z6lIP2wCMHAIHU+uPOCsVwVCWmuL8KcRH
 xVVjydWO7vonk9pesm36TmcQAyi7Jc6lzEfGIkzPL/9jdRY1D33GtRjDhV8Ua9z40SMv
 pIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767563656; x=1768168456;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l28eNT0s2HQhubb8enm6f2kzdu0qWF61f0Sq1o1gJhw=;
 b=Ue815i3ftkuu6gmLmW+WpCJS8zCePZgSJ33TeU/7sQG5Bw7km4UO4JV0WsTm21PxDU
 Hi3Hd3FyTJ1HcOxff1vXwFsKeTlwQ1pftgnQaSOuOd/Z4g0bZn6a41oVYhm191gTtkQT
 7VBrcZv16dRBHbcFKVbLrPI2oVTWbkvIo0f7AS2ILxvgc6yqAW4fCwyM1ZyGJNrVaVky
 Hq1At5BuG3hWPz9S6caR/Bh/P5S2Wp+ibW1RWWKhx2EZlMzRFCmbUKAo3sOunosDt1tO
 inGKzAPi6kkDaarijvdVlg6MQAoDJvSa8+nFKSpFYT2K5olHv6x44p6jNOWRC3nsq5h7
 HZvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFqG0bJh6vuJE8aaaoSfBblhKdCOccNVpDUyBoinwk4l4GwDaZG7Hxr8X7dM0x5ph+ppkYvDPMNLED@nongnu.org
X-Gm-Message-State: AOJu0YyxdASwgex3bMwIFe+FJe1KMwBW70+NSHQVe+sSobKEXgHmKLgT
 Jr0Wvzr3iFHSr7tH8TaJkrhqoEpCtazpOu41ANENnDgdbvK4dq9t9BB1lyzJZinYFgk=
X-Gm-Gg: AY/fxX6faxzjSL8iDuAgQVqBm+boB71FjHz3XqR+LH11r+C0+5MYirnhNoGC6gDo/Se
 b11On48Anx1+kkEQ9wyHrMhjo3OGOA7Uw3aYiBvefr0sURsEGCs1hE5vYC8n/9LzzUTv+nrfXpt
 18XpMePbMueGeBkUdLTroBbPcKamu8jHRpPRAXbYOVk2tco5xqZ3nQynri3f8kvq/NN63Z2dEFv
 qT/gzQtxt/16D7zXMSMjp/QDt4114b67LVQuKfxBiyDB5wkCakJ+kuBA3dj3nUy8jXICbKxQhqg
 kk9LuhnYJDrnr6Iy+rvcZ2cW1Q3fNaK8TH75y6931YvQqhJandNqnV6OL8grg2dcs/NTxb+/W7r
 lOPmOyMQvy7Wzrso81A2lJj59mhRV9JzxXGpP9+cJP5rg8lxT41QP2Qyf6tf9FqwhV9P6xVZJv/
 1wSDsvXE9uCd5kht+dl2C9wj5WtEccxw==
X-Google-Smtp-Source: AGHT+IF5k0AtGlRFu/k386db4yd2WcPPb4X0CIfUZVQfMOTo56WdDqWdRaWsTyQrdC0WVl2HxOvTLA==
X-Received: by 2002:a17:902:ccd1:b0:2a2:f465:1273 with SMTP id
 d9443c01a7336-2a2f4651332mr435915185ad.35.1767563655979; 
 Sun, 04 Jan 2026 13:54:15 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a39018dc8bsm182290105ad.43.2026.01.04.13.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 13:54:15 -0800 (PST)
Message-ID: <fc1e064f-cccc-4f6e-8fbe-372f4659a02f@linaro.org>
Date: Mon, 5 Jan 2026 08:54:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/3/26 07:11, Brian Cain wrote:
> The following changes since commit 667e1fff878326c35c7f5146072e60a63a9a41c8:
> 
>    Merge tag 'hw-misc-20251230' ofhttps://github.com/philmd/qemu into staging (2025-12-31 16:44:17 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu tags/pull-hex-20260102
> 
> for you to fetch changes up to 15722c774ab2fa6904464cd531bc1120d9553896:
> 
>    Hexagon (target/hexagon) s/log_write/gen_write (2025-12-31 22:57:44 -0600)
> 
> ----------------------------------------------------------------
> Bypass packet commit for implicit usr write; cleanup


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

