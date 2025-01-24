Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ACDC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbN9f-0005Ap-W6; Fri, 24 Jan 2025 12:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN9L-0004ri-1j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:07:24 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN9I-00054C-Iu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:07:18 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso3490399a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738434; x=1738343234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9HIhApHPUcItsyCSDsIoULth5Mm+x0u9g6ZWdn8PQzQ=;
 b=yGzGKQOaUD48z638PoNe4DB/iRWW+EQZxvrsh5HPY9lNqyenzpgP3QXoIIKVyt8gGx
 ZENMiIpAXV0+yaI6XUD7SZlKa3Oa7mWI6T5oiUlty36i90LcHgIBE6RCi1Ew0A+VVcBR
 dW7c+Nvb8PslCFesS7S2BAkZbiJ5+GseU//Fy5xahJdMglEaOZBKlCC/7hdGCC56+HjO
 gvWey2KaTYTivqtSvwtTCmUrA7ClJj5u68Xn90MHvnW909uaESX+7FflRTs+/zn3G6TI
 DXuJNYWOtQynMtbfqNj8jF+vEhqynMC0p4JaL7/QY0B5/bcYDvfixwrpKOe5wyxri+2H
 IAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738434; x=1738343234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HIhApHPUcItsyCSDsIoULth5Mm+x0u9g6ZWdn8PQzQ=;
 b=wNc8BdGd3LAAA/0XAQp6klI4O/gyiBFvFBXbMaucxMMSWQyBQ/PwTcwNvPOI1RedNH
 adhZEFBRfOCwkRRkcNS+kdwBPwO0eraim5jytBBDo335WwdNw+7vUKQEgqdFcSTL6YmH
 7GEohA+DiNu6ADh9ZgTMqg3updHWuAKxHay4MFhIbn0iiSJvG+JdFfQv6d029xO8685O
 SDvcQrUYeTbWDUgvYg5Z+h8OKzr9ItVgxqvjKt1k2uB7oDjmkMICUc0IcVvZYvaCAX0a
 cVSeh6QJf175Rs9ImyNJNZMd0zGAsHID+lHC8MDIE3vRB3s70kciYNSiHkmtaCK8i8WP
 1Z0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXefa/HwQjFaCL1P32jzissS2FoH626QFCWr4LYMk2btN/RMH2tSctB/VACDPt1vr+IQDQ0zYfAlC1/@nongnu.org
X-Gm-Message-State: AOJu0YzpbeOrBuoLbLbseb6lGyQppSkDWB1G35gVfFIInBhFP9e8rto7
 FpgJb6DeNEnB0ulwXmNfWhMB6AcKLwJETPD1aLLiArgnS2ZFjKjuK81bgK0h0qQ=
X-Gm-Gg: ASbGncvcveK1bH9ERhd2mI/536C6oaS0LUT9LQDpW39QEqGWuN2lTdn40dYoKO8H7tv
 YxIKIFKdzvK+I3qCE5JzVnn1OCBmo7fFprpiaZ/bJns3SwWYIL9GuEK/h4pgXk3cblqXq5awUn/
 iAstGun/EZEu5Z3FWZWkSBw08tpp/sZLRVDUnUp5o3/Be7PQ4lokq4IAVDnKGpJK1ZtVCmrQBaE
 wndE3WNbvLN7CQCTzOg75prqx0wtFjvOpnWRPqO+WXwfnDPEZLWPsOco81SLQnqzB3kNREfCgYJ
 MRKVIhXRxSOd4j7nASyK4bAV
X-Google-Smtp-Source: AGHT+IGuvC4H41KAWyICSvtvXJAn1n/1/p6ciomsUtc7hknZQVPxOcqPsXqUlJDCimSebwlSFwXX+w==
X-Received: by 2002:a17:90b:5344:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-2f782c90af3mr47169962a91.11.1737738434530; 
 Fri, 24 Jan 2025 09:07:14 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa56147sm1994652a91.15.2025.01.24.09.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:07:14 -0800 (PST)
Message-ID: <6f83fee6-1149-45f9-ba1a-0b1965078951@linaro.org>
Date: Fri, 24 Jan 2025 09:07:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] target/hexagon: Remove CPUClass:has_work() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Remove as unreachable code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

