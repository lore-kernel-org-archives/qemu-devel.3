Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2FCFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOpp-0000xe-Q0; Mon, 27 Apr 2026 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOpo-0000xG-BO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:29:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOpn-0005fh-0T
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:29:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so8799133f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307361; x=1777912161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VvhaK+3SREO8B77/SX1R4EVjJES6EyGcbh0w9K7dx0=;
 b=B31LuyqRMSPfOYOYd+uJU+h21zoYq4ErSGDJMDnve7XM0cc3TH3upZOz+7aHq9imjf
 YZIBDJ/gQ1AJAnl4VawlyIAD3JSKTBZ17ADylPFKe1rNt4DKoDCdBpUeXH3JJrWeu1wF
 BbnYfByKEk3xF5fbKaYxmW3m68F7uia0O+t4FXndN1691fpGdng3IRelsyTJ+K1UsVpV
 IZdk774TjQPQK0ToZIstYtpfrYzXcxlLpaIEE7fBR2oKlbAqE7/rUkhAjDW3AVsX3yCW
 jwz84qx+pddYJGvZFAOlB+3zdh5Spu9vge+nm+pOi03F50GBKdMrUjkIfAFPWkjNKDNW
 XJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307361; x=1777912161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VvhaK+3SREO8B77/SX1R4EVjJES6EyGcbh0w9K7dx0=;
 b=M1TH5pI8en2rQXVD1lEchARP3TlJ3wCjI9ZUkxGetdIA4H4qH2uF8J7FbAbsLDTjXl
 lWz9BXAZxBgAsMSYU1ysLJ0L+g8N2armNGBGYV9X6x+x2JnoxLTMuHmA7Xoo/EVaSVuI
 7vPXIsZETpdYMCirUDrlPFOBg/fO+qI3v4mpsT5v8nqTSUvUZ+Dbkoqe4WkEUCF0Ocvu
 rSF1yBhhW9UaHP0qDVTcewT7lrSghPj+PcvNQfbBiBPNjcCbZiVZkFEFKGN2faJvbqY+
 ew/IpvW1I67u0gZn6EMjR98QE8ecC+lFCxpspj+WACifNHLZI9xYHBqrBgV6Jz49nBQ4
 +cbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PtvS5T0XsyreR5mSUTV9lGT8QP9+achszXamrPmt+/llec9DbCHwKObnFutlfCxTl6FL9ylYdsV2r@nongnu.org
X-Gm-Message-State: AOJu0Yyf7104dnKIimawed2QBitdV64Pd3z840/TfR9UmF8vgauRl1gd
 L3WDSoQOqzfA88T2d/rfOPGTKldKt5GRMVnyYarqyKx7BiWIImuGHLY49K2t243csVI=
X-Gm-Gg: AeBDietNTL6zhO7ATHL9Ro+InNu7Hi/JED1pGms622cJhfKqPDrbdI7WJd3QNJKnfCp
 db+uBI0ZFHFSriPHY3P6e4r189ovYIqSSOte3ASOySZ+9PH662Khl+CRnoq+caRWQqBP6m4KeOD
 6RmZOwnNAM0x3V0eGFmFOMsal4wg6Hhd2tv6jOYHxlldKlWr5baaQjcAYWVpJE+rAgxyJcg9pc4
 Ts1PQmQDj7MoGZVackIsLGgN2j9O4JrkkDNxLDmLOXnk4nIgPltawqGkPPz0GNI5vh2XSaBgXVr
 zn3WktqKyOikz3d1vbIXL6Fr8aSzMTfwteaU52glD+tvJIRYNkZST0ZJApVcGxQ1x3X3GCAorjV
 2C4pqc79jcjvIEkpKG0F5KZWZFpr58qSO9x2qKi7odUqLrVXCsazOqPM5iwgNmIYRM0AUhB9Etm
 Esp7Y6Qup0CTZjA7nMgOhWT7tsG3MT+2cFzBvxD8sTRR6j7lWWX55H8TerCB6f0nuzAQABdZIUr
 xW+
X-Received: by 2002:a05:6000:25c7:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-43fe3e1433emr68443912f8f.39.1777307361246; 
 Mon, 27 Apr 2026 09:29:21 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm45529471f8f.23.2026.04.27.09.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:29:20 -0700 (PDT)
Message-ID: <31923bc8-577d-4d84-9079-1211a9638c2a@linaro.org>
Date: Mon, 27 Apr 2026 18:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/84] fpu: Drop parts_return_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_return_nan at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 17 ++++++-----------
>   fpu/softfloat-parts.c.inc |  8 ++++----
>   2 files changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

