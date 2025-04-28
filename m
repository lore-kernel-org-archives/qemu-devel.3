Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B438C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QoN-0004Q6-Jq; Mon, 28 Apr 2025 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9QoI-0004Mc-4Y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:54:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9QoE-0005AI-SW
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:54:21 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af51596da56so4206687a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745855655; x=1746460455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q3aqpTyEo4Ne+b8xIfe/goV4Eq53K8pgzq5YFaS0WxY=;
 b=AnmIjwsH8pyt0f4/MMeEwlb+2Pp+x7vWfbeyZaAaDEH5VLi98TR6RIHEzV/kDozd3K
 M2DGgazrznZIQ+CHlYMt9MAY7Id+WGn30CLv4TVf+KlgclWldqqOTInBBc7PCdbwPTUT
 W2jInIJ4UiwV+M4PNCtqCQAVas2uyV6CKcrpUCGVeINAg+75SHDPg+KyIUDN364CU/ff
 gwl5HoOJDptAv3UMepcye6c6unDT7XE5DcswgX3a24kkfsb/u2jtQIX4RAk4NyKSYGYO
 YtApt2nzcDlsE7iyc5u1A70XDJlQM7pULCJxPX6d/V+UTzsPwttCdi0qBFQowuV6M+hg
 +aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855655; x=1746460455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3aqpTyEo4Ne+b8xIfe/goV4Eq53K8pgzq5YFaS0WxY=;
 b=Gh1rYAAbk8v3SUgDyW9SesssvLpF5eTRYFGABraDvZlKRuD6b10e/83utU0Ar1ZKp5
 7a+maeRD1JGl5S/fqoWZ9TU4CpB7jdOrs2jrkK7BkNlG4yIcuxGj1W5D7/Px71+7/TVu
 A8tYEl+0IVDlU9A9eBrBlNXlNUk/lTd+3HnBhrklE110QMLltSwseU67s+ZAQnFJfgem
 jnxTJxlfRgPiDP2XWqYmBQFqjDP7mPek4SG+jE12xcU6g4L3caM2rTDLbQRy86uDdJ1e
 WCOMh+p7pzLnfVw/nK7rDkV5U4LJiaBSM1Jtf+Fc9KwYwZI8H9r8SG4MNEsO04pT4BZI
 OLOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnpVl5I7TPr887I+dFC4u9qgdS9f+2tKrrpiTO8WmQTJFlEisRm9giww826giB7AtekGymIcL8izRI@nongnu.org
X-Gm-Message-State: AOJu0YzOMfvMBowo8hPFeqItk19cXAFX1uVPdtOBHzxMAkOJTvKy7eAa
 M8TvvzXZiPrCJ+701Nx2iRkFwtSjcYt1cUxcsiVe2TpSSMSg+dSzEzk2KIEsGss=
X-Gm-Gg: ASbGnct6mZ1MJLr2FRrLGr0GvULvdJJTqVZTJ143cNtl+OPz2d34xPZrfYM2b8ROTvE
 t56S+rvPZTSCnadp5x0wVQEpaiBkUwNB6JwsZqTJEwgrhOW8hDUGQoLuI8Et24MqUqERZUDg5Wg
 59NBPC6+NEpXt6KIQUHAmbMwsKMAkLj6pXPFJ0YcRWEZZ1TaIX+bbz1u90BT1nRzwTAn8F7mu6x
 CehhrvD37AsfAB0PngpRSUkLz9jrwSPT12QvoQxQ2DIY42axg8+wRs8CZ2bVS8u6AQskc7XMuny
 fEBlMagOz2TSKiqOTpCNjEmWvo5O8OWOzYz6K5YSk2ZifMs2Mof/6YUgNQBVlYN6eg0FAgWcNTP
 k/ZwicPI=
X-Google-Smtp-Source: AGHT+IGq39Fkm/08Siuzlsmrfgf5QPyWBbk5ihd8aKOtZ1eIcBk7fY2KHAohyoB2LpQBTEJtpPMUKw==
X-Received: by 2002:a17:90b:180d:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-30a2155e3a9mr443786a91.19.1745855655583; 
 Mon, 28 Apr 2025 08:54:15 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f782d461sm8169389a91.39.2025.04.28.08.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:54:15 -0700 (PDT)
Message-ID: <4ae2766c-28f9-4374-ac3e-94213fe53981@linaro.org>
Date: Mon, 28 Apr 2025 08:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/hyperv/hyperv: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
 <20250424232829.141163-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424232829.141163-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/24/25 16:28, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/hyperv.c    | 3 ++-
>   hw/hyperv/meson.build | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

