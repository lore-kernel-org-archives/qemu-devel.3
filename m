Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D73E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOL4E-0005L3-DX; Thu, 19 Dec 2024 13:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOL49-0005Kf-Ps
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:16:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOL48-0008Gj-9E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:16:05 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2163dc5155fso10511975ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734632163; x=1735236963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JGYcyhpa6yfeH3/dLfyzh4mlH+pOslywyNNRxTTB8NQ=;
 b=AfAJ9DBrlcegXyDfc9OGylBiA+lFbroXw+fB2tvYXQeqIenouSS+NejpcM2vSjv2OO
 PY28JCxK2XajDQKxz4WGh5jls5Gd78LV0nx9R4Ub8H/V1WSflulqt11N4RCXNunh2Kwd
 CmOSZ1s5CqbSh3kkTdCMrCyRgT+UP83R/N5gt4w1LnCr98TmuyaJC8njF5wD068Za280
 MGCNJekatxNWW9L0ru+bwhz12hyacORed6wr6gyxz/gX6lAL4LA1gZh6n/mED5a3sRyY
 yYR8U1ifn3itwnQkLdQ0c3DqWFCTV7hAMtyL5btWkj3kp8LCtTMKyv87kQ/gz47M0wME
 jgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632163; x=1735236963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JGYcyhpa6yfeH3/dLfyzh4mlH+pOslywyNNRxTTB8NQ=;
 b=N+0lil7y9nQ6IVB9a6VpnY4KYOHODKcFh30RQvNEoYCjj26onzQ3O2923Pqvf0AyKv
 lpbEFSNBaBbPz3MVKLmuObaoIFo346jWXvka6YnYoV+S/b/631202OVoc7COtM+SUgeo
 x8+6l4r/MQU70OV0lrgI6pZ5ToL30wUnRvhWJilOXi/thcF9v0NQPC6TlSzYdxG1u+HM
 ZrZUK5mwXWTht5LgOQriUEDjQwuuTJAgm/Ix4JVIV8f6uN7oXFsSTCptPFJCzKdMhXTa
 zZyuVL0LJiZn3e5bflWBsZecrRxtESBPfEzpaMI6UFZ4/YSiV6sDxjifOLabFzT00HKk
 277Q==
X-Gm-Message-State: AOJu0YxSgWkV+O9XvkZWDbMI2aO06F7++r6Os5pG1L42Bl7FBUoJ9uL3
 yAPnZjK94TakAOYuiaIgKvkC/39eiqVXW22Af/KwoxCOVq0J1x5iRVlSjuj8rTVmch2w4zjIKA6
 l2T0axw==
X-Gm-Gg: ASbGncsrX4an5jeO/Dhh7JNiOUz2arniY2oR8qYA5En7f7/i9PysvbZp3f484T2M5sZ
 4A/QuS3qR4hT6Kj2x45FpCrgDyd4Qc19rBQpmT2pghF070XWWfy1iOVKTfnMqxSAdic3vr5rtp5
 /L/nRh4Tz26phY3V44/t7TsziDujXlVsvoThx8jT1R7OTjQ0x1jIOqTrGdJaOvwJ0un/QQipBZ2
 mXuyJGvcDlh4T5EEFBoz/3Nc4y7nBuTCzYHpVPQYMJUMLilbOHCpYcHljXqHtjCkOpX8MToNGbT
 +ifi4zPnkvHbykDkeMJwopMs28B6VFFrHAYgN+Ne2A==
X-Google-Smtp-Source: AGHT+IFJF8CuIRcznvO9Ez4GRJz0N0Rw86UpIGvFiyAteuCT7P0WOFGOlB9OduCGgCZWrEmSkhTfgw==
X-Received: by 2002:a17:902:f712:b0:216:59ed:1aa3 with SMTP id
 d9443c01a7336-218d71030ddmr97113185ad.27.1734632162758; 
 Thu, 19 Dec 2024 10:16:02 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:c32f:435b:9081:64c9:3330?
 ([2607:fb91:1ec0:c32f:435b:9081:64c9:3330])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca02a97sm15320915ad.275.2024.12.19.10.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:16:02 -0800 (PST)
Message-ID: <9456cea0-7fc5-48ae-a7a6-c92f74f988c1@linaro.org>
Date: Thu, 19 Dec 2024 10:15:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: use RISCVException enum in exception
 helpers
To: qemu-devel@nongnu.org
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
 <20241219174657.1988767-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219174657.1988767-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/19/24 09:46, Daniel Henrique Barboza wrote:
> Do a cosmetic change in riscv_raise_exception() to change 'exception'
> type from uint32_t to RISCVException, making it a bit clear that the
> arg is directly correlated to the RISCVException enum.
> 
> As a side effect, change 'excp' type from int to RISCVException in
> generate_exception() to guarantee that all callers of
> riscv_raise_exception() will use the enum.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.h       | 3 ++-
>   target/riscv/op_helper.c | 3 ++-
>   target/riscv/translate.c | 2 +-
>   3 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

