Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BBEC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRMR-0006iG-ST; Sun, 23 Mar 2025 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRMQ-0006hy-Fy
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:51:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRMO-0001ys-WB
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:51:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fd89d036so65719545ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759511; x=1743364311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0LHmMxcfXYfBbwN2Vn1ZoEDENU5Th0R4oTKC+bgm1U=;
 b=bh/THrbyFp6hq0wm0uhBGTqArEH96Ljw/qvjhaGN8dSU9yi8UDZwkUckpB+jIYmeFo
 ciqOsEMHwUcGYHAC/OmIRhGgxeluce5A9ZtU8Ns/KkXCUj0dzL/1FjVSKBDcsktOxv53
 ZpgwI9fUX5s8xnG4rQ94pd0+pdEQq56exD7P2aCkhJoutXg4osZ7kF204p3F9rL4XEvc
 MUiMk6Exmj4J5Iu2K4Th1aNvsBXC0b1fXnSN8VGO+26TvdfUukeWWOd5+fPgq1BU9Y4o
 5ufVu8G7BZvAmMalA5pCRXh66tGqrQ5A1qibfS/Q4rqyGhFHbW2H1Htw8XcUYnAzhZVp
 8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759511; x=1743364311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0LHmMxcfXYfBbwN2Vn1ZoEDENU5Th0R4oTKC+bgm1U=;
 b=ug4RVpdnnmgQ22PDbCNbybvxnUbot+3xGD41+18HJE4/NoZnoCWc4wLzcPaOuoAhwt
 QHRd8aP+wdWMs18bOI0nemIrePJ1B/xGuWJ80sRK1rKtypAWjtf9zFArUOvjKcZg4g3C
 E/6PwJaliNgS10aXsFcBK7IGb6dyk9+Tlnr03ZraSoTlTnlwgpzAit7DIGnuiTSntcXJ
 infgJlBWm6AK+ZKh3AzUv4sk3XLghhM2FghAN1SSlYoB4ITw4wSfcF6N2FIeMSNxHoUd
 onobjb9tvi9HlNs3XjIUnfiE0neRS3i6Hkz1gltB3Ql8j7AsGJRxeveRf1BWPQ1FvRBD
 4tMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUui1Eg6J7m15Ra/tHZrBqhA7lz56gN6PZddbZ5KSZki4PTOeG/mBSusCir48IDaLIcaIEI+f8ya5LI@nongnu.org
X-Gm-Message-State: AOJu0YwwuUgZknA0TW08U9FPBW08+e1I2eCIHQnPkJrVjMLQB0B7s9Xg
 EsKZaHxlQPbaNiZLhsoWSt4nwf1EZYuLKXEOYjq7Sly6Oat9EWNmsH+7aL8R7i8=
X-Gm-Gg: ASbGncs9mM2IBunaa6p4csOBd5IpRO1KsWOAjEbYFL9LA8ik+sWOovXetwAQEhwVjdj
 tJM/BykSxJF0Gfd01idFG3vsJxtgcAP/SGCTi2o7UBJWhtEoBza4RtzYFDBsdgOOr87PbYJycYU
 5f4Zz64aBQ+Ts2fLldq5SxtiXYsD7S/oYH2vjoy0G8ef123hAmSEBYLDK5uWelxQv+N3GED5uuF
 nlFLH5wIBvuJ21b115YEZ+vfaKIGuWfKILjtrjjJnhhKqc9nQhtYQ5XZa/PUpl7/XUPN+ES0hC/
 XEVgpm7pu5YcLJH6tIlDZhMvYCCHBoId+JHGhmBfatLQsEZjTWmjwz27yE34yePF3xbUXaqg38n
 rnZxKLviD
X-Google-Smtp-Source: AGHT+IGo0frLMbZ3TBKUd7+4E2Js6IRd5u5loZ8jKeTUJjaEuSwwRFZnGgYkJGT64JaP8+5JDD++Lg==
X-Received: by 2002:a17:903:8cc:b0:224:2384:5b40 with SMTP id
 d9443c01a7336-22780db251amr198184305ad.24.1742759511499; 
 Sun, 23 Mar 2025 12:51:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f397e6sm55330195ad.46.2025.03.23.12.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:51:51 -0700 (PDT)
Message-ID: <0edf7841-2e45-4e1c-b521-1f166a8eec81@linaro.org>
Date: Sun, 23 Mar 2025 12:51:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/30] hw/arm: make most of the compilation units common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-31-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-31-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/20/25 15:30, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/arm/meson.build | 112 ++++++++++++++++++++++-----------------------
>   1 file changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

