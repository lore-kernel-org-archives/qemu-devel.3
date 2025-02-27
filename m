Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41860C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhuA-000564-G7; Thu, 27 Feb 2025 12:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhu7-00055F-Fh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:42:35 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhu5-0001eT-TL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:42:35 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349dc31bcso23408145ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740678152; x=1741282952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnY5ZCzNgWMcn0ViDYMwJmIW5ikFuj8+sAM4k99jK4E=;
 b=yomRZEzPc1wroHiPGFBO7r2QbcfA169WB+m9z7xKyj3VNxekFZ2v7Yn+B2AdfnNlug
 mGeBPsreToMOHnGZdRuT2a3TBQcZNQc9fn3/G893v6z9Wxg/w0PWRI7oMhuTzirQ2FkC
 9NkYWWL3BKBb7aeuvkm1SLa9wH1Hxa3bG1fGF9rOwjQgpfwxp4pyorE6dCBIskYlYS+r
 Z1/QwftGuUSqqrx6qJgyFqVS2Jp1YRQrnsJTI/WJmiMpZG9DB9oi4L2iZ8ZWMmSutXf1
 IDgC1mkyOYXnXlUViicREBe1GBF5RaEi/6a3BtID3tc5CdGBXVQTwW/LX4dSwHxFhVIo
 LL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740678152; x=1741282952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnY5ZCzNgWMcn0ViDYMwJmIW5ikFuj8+sAM4k99jK4E=;
 b=HAoD5sET9rkeIOvoKzDEPWR4006SVqfQ4XJEOeEDlzppowvw5M0tK8ZZ9GzaD5vQ8y
 l7TbnXW0CvESyJ9Q1voljn+Kd1M1GKLGp3Ktk4mQrtq8fhXuPVQmbHxhIyvmmG/ygCKh
 elJz6y2irPUZZOjO1ZhvenKLCssRUqAhbpimycYzUAtsdesHgePJAAnuviaSty7o7zX9
 ZmSCa2Dod50nMXc9JRaABuqaRYTEbA/E7A+IVrh/ZYwYp48zhwjSNrmjm3/eOkYYuArW
 +/NCTliLYxmz6edkd55vQYztN6qgD5zz0HN8ZufcguJVxZ4ex7dbaHLg+PuGC0Rmr+8/
 Fr4g==
X-Gm-Message-State: AOJu0YxLWm/d5sCwok32vzKzItz08v4iQbok/GiqZ0u7FL2rNKFZfmXp
 +kpyFlJHXPQkqUsK95iBkazOHTetb4d+u9xAaHagwWkvlSDB3NF6m4cXY9oYhd2B4PA4aZpL3Z2
 4
X-Gm-Gg: ASbGncu1FF+gsgiutTaMo4zMnZCkHmldAGUK07uumXEy91bFO0Oq/ikwmPwjdz11Xir
 v5aDM8N8jDQBFlwOWgjDzNb3L7FA1DMW9ojP4qwt7FFpPRp+f3Kjqt79IAYeUeT9IkSG8wS20oc
 BvV2sZFf++xMrMA4MMJvSTNQ9o5xCfxZPUakOv3vFCs5TqfaYhrZp7UVRjT+H385ecjzOJ8A+/+
 S9MmP5UDcjnra4Fp1EpsJmljFznzXytfVesVY5gIdN36d4QkvszJMIvUMmVofJ4JGU78QkxkpeQ
 vlqJGodzHB+2oUba0pcomWq34ProQ9KFxwSmVSV7yD/EhwBciuj/f7wnX/rRon0TfnKiU3RGk4w
 gP8vMTiQ=
X-Google-Smtp-Source: AGHT+IE9n3UG9rmZPyBC4i5jzMPsKj2pHZwKVUbxElLjF63j6ORJdKnzQNM7Dzy95fwWw8ZNe138Jw==
X-Received: by 2002:a05:6a00:9a4:b0:730:957d:a80f with SMTP id
 d2e1a72fcca58-734ac33099amr426724b3a.2.1740678151994; 
 Thu, 27 Feb 2025 09:42:31 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fd03d95sm1941520b3a.0.2025.02.27.09.42.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:42:31 -0800 (PST)
Message-ID: <a8099ad8-a105-412a-b5a5-28c7c9643dde@linaro.org>
Date: Thu, 27 Feb 2025 09:42:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Correct STRD atomicity
To: qemu-devel@nongnu.org
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250227142746.1698904-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/27/25 06:27, Peter Maydell wrote:
> Our STRD implementation doesn't correctly implement the requirement:
>   * if the address is 8-aligned the access must be a 64-bit
>     single-copy atomic access, not two 32-bit accesses
> 
> Rewrite the handling of STRD to use a single tcg_gen_qemu_st_i64()
> of a value produced by concatenating the two 32 bit source registers.
> This allows us to get the atomicity right.
> 
> As with the LDRD change, now that we don't update 'addr' in the
> course of performing the store we need to adjust the offset
> we pass to op_addr_ri_post() and op_addr_rr_post().
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 55 ++++++++++++++++++++++++--------------
>   1 file changed, 35 insertions(+), 20 deletions(-)

Modulo the LPAE comment vs patch 1,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

