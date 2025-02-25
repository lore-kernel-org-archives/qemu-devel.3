Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B71C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzy3-0002dB-TK; Tue, 25 Feb 2025 13:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzx8-0002FV-2V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzx4-0000J1-Gg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220f4dd756eso127140415ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509199; x=1741113999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LhbEIpIBB5sMAWBXwLQJwqkqzuEasaA8LzuKqvtK1O0=;
 b=eIcHvdKBvSyFzCcYTDdbeKIpZuTe8s+oWI3aoHKj4hZS4p+XptR2E3qIYP5BF3N4rB
 LcZbMchG58NF5BuZcJxYn3LQ+pHjN3QmdfGee+HowBpZZWOuRBOe3IRI3Q3d9qDx0MPZ
 LiAVqYgEbKkulJHZLrSzQtr4O/zNKT9n7t2Oj7o8QSOqrn7azk86zVrL/GjZoch1pKEx
 8F7TzLGT75NzNiwfIUHQqEgY9J49gfeeQv+ygHO0oAHRs5w6khLIG8/iPdf2Hl9B1n1K
 9hmOlHxbAs4hKkDXQOib1lPA4ZZ+shzp6xZ7vAoHYljbBW5cKBHJLuRTgWuJyWGkLIfz
 w0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509199; x=1741113999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhbEIpIBB5sMAWBXwLQJwqkqzuEasaA8LzuKqvtK1O0=;
 b=LwMjeAoo3GsjFgHTSUONe8uhBOUtjRMAkVvA2n9mgbgbrIdqfd76VWqney4ux1vp04
 8q3jRsluAdvy24Qd7nKvNBeCJRlGrnVmNmCKoZUDsAN0VX6EUpPj0bYNy/RBvfq8vBWA
 UdcXEr0t0F3gVodv744T/+UileAv9l7Q0xdjDaSjJvScGIzvgtkrxMX9deedC+hwlSYK
 HZ2tiGWK8Dx3Bx844QvsZ38rVtkg6KKm0dnuEpM/WunfeFqyRgkcc6KPplLwEouCi2Ed
 hH+YqV3FaWOpwr8Vns857KBAIg9dIFpEwruRW8cw2KGLhFN1sZz7VOJPJomo1KSSzFR5
 QRgg==
X-Gm-Message-State: AOJu0YxASiEt3hVeEzGzgr8ga/h1x254V//z40ZLX8ea92wp7Vm54HV6
 0Nv06tXlpDW+4LyToE2wClqoXSTCO7tuvsr6fcni/ZuPXWcbbTC9SqPMNKPuBMDSP4EDJZkr5eK
 G
X-Gm-Gg: ASbGncv1alyPVFbxGQ8id3XD8H+MsdShWloHKhVVoc1BoX0Tx4iuErRtCRAo96US5ov
 RlinuuybnZi2NGw3vxlSvIzWhcYC+owj0lpw89nWff+WC2TqHHKBcgQP6vTnfu5C/R5JX7RqOor
 6lQrDMmMNTtODbBOeKkeIzfT2gf+HucIeded9+Y+KZRYgOKA+lwISUTG/ETb+s0v8/DtdavBJCt
 kvD/jrozpZxvkkqIasiD8THzcLqp90PDsyH+Xhxfztvbg2wn5WnHucsDHxhzV+x4EB9LuQ4xZ2Z
 c0Y6B964ZlHxYo3/2q/orZjIZHaPzHOO94d+UDiOQLUMAXtLpVB7tERINLHUu09Df8c71g2pbGJ
 AvP7aAR0=
X-Google-Smtp-Source: AGHT+IFxKsSpT3EaOzhSuYF1r5zmgfX+8g5Z99+cn4Svq4MZtZWK1h0hIq2WstZfkAnOg0hgxUqUCA==
X-Received: by 2002:a17:902:e84e:b0:216:5294:619b with SMTP id
 d9443c01a7336-22307e78b9fmr58482915ad.47.1740509198941; 
 Tue, 25 Feb 2025 10:46:38 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a000964sm17886235ad.48.2025.02.25.10.46.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:46:38 -0800 (PST)
Message-ID: <12c9bc4b-f3e6-4cef-b7af-cae23ea27b0d@linaro.org>
Date: Tue, 25 Feb 2025 10:46:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] plugins/api: build only once
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> Now all the softmmu/user-mode stuff has been split out we can build
> this compilation unit only once.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/api.c       | 11 -----------
>   plugins/meson.build |  3 +--
>   2 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

