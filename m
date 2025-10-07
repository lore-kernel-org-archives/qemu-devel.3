Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E1DCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62vX-0001IG-3t; Tue, 07 Oct 2025 04:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62vV-0001DJ-9D
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:20:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62vT-0002Gp-1u
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:20:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso43853895e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825201; x=1760430001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MsMSxujLYM14Dnqu7gKvJG7wCLV3w69/rzjoYanDMMM=;
 b=hHocgOzNvXc1PcOux7Lj0mgJjMigE0wpc6VrK7KT/JJQWVAUBltaFIL/a2d64SN9Ps
 jIxLEFxoODKe8WlLbhmEEOrzNt46lqXZ56o+g321vXQSdX8kpzHiJ7vnnP9PtcltQSuw
 Sp3KzN+/MWSY/XaOgBQtaheR6jqQKXCCY4+eDKzBZ7z7bGlzks5XAEuiBS8x1M0ZkQCL
 ChHAF5q8/a9PHbO7XSqjrmoEXF6RLHSfAwLPztY44hMM4cFycfS9vfuxvraVtqlJPfOi
 US6Dv6tnSPzfsImpZJDkvBCklM9VyzkR2UBXAadyk7WadOQShRvU1qTNqehLn1YV3Zwk
 r/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825201; x=1760430001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MsMSxujLYM14Dnqu7gKvJG7wCLV3w69/rzjoYanDMMM=;
 b=ubYX59DyjQGbAV3F8JEtrh4ttFxtOy+T1il29MnUd7S2dy+TomQXSZwZA2HORdkw5v
 Sf3CX/OukaAaEQnyZCoge6UXY0CAyGP+lxoYyjrXxnRdUb6TJR8/6zZPFTiEq+vj0jiA
 GwTJuvcSQp6O5pGFSHZxvZ6PUw0gclx+g7wpl78JsW1Ks/ZY4cszw8H+wGtdm/DvDwZv
 UGJDzQp7vatPC30kshLC0p0wOon0Py1Q72yaod9dzo3U1LKA44DN9OVl0tinN/dEs18R
 wexgKxgHMyPnk9w+yqU1+Gad4EQtKMiQ114jFsk1xrQeVty/EWvL5lK7jpbwsBK1NWaA
 JhkA==
X-Gm-Message-State: AOJu0YxFkdNCH150jfrN9RPtSINN42uhklAMjXGYmy+6mX0D3euTkr9u
 iIjqyOfCu+y7jCChapaRbbuKOn75PwjEfeuUEFobjBFBDccdgf4U7LGtj+D/AuhPFoQCkkZclL0
 MbzDy5QpsbA==
X-Gm-Gg: ASbGncusm0XMJXZMQw2eAZkgDEL0WpsiS9vd5ZTyCnhvcojprX67qqVrdqshy0oGjqM
 OFRA+Ce0A9dxmsLdlCYXjxUC50RBWjhhl94nLWK69+5z0BVNWnsgjG6jAMDfElHLosagrxuvnZd
 DUdvIkNO2/T0XXjrMn9CaLXpWyufSU7MLTAWIbGOpWuE15XwPLLPeTDzAJa8v0lSDlXOpqiG2qH
 NaBLLfWjhxcbRtUnyAbiiME3IKO2j0r/Z2bZCzTRdPRyfzNbZBjnNMSUpK9JZLG9xY5r1Ct1/1X
 /ilDWifNISV+7kg0KtEMfEjo4aEi/Ci+Wy0GrsGUVvDhPlHwDeoO+RfWBGJyAxss17i7rfXI9CB
 6ZyDxvNzid17enzbzAyf5NYWmyL6dXsFvYIEEdvXxPWyhMbQlfLDNgH/oJWI0iPN+QDSQaXrzxc
 It9G/ZGUP+nD5J0TnW5A==
X-Google-Smtp-Source: AGHT+IENEb/USYE/0zuDpUlj+pkmacX0VCfFQzJ3LBeqZPzEovPwb/wuCwaKIgPsqDJw3UX9yBI1Lg==
X-Received: by 2002:a05:600d:42a1:b0:45f:2b0e:b835 with SMTP id
 5b1f17b1804b1-46fa29e1b8dmr10092795e9.10.1759825200764; 
 Tue, 07 Oct 2025 01:20:00 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa39ee063sm11945455e9.3.2025.10.07.01.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:19:59 -0700 (PDT)
Message-ID: <45f4ff25-7c5c-43c7-a6a3-c1a425fa4c0d@linaro.org>
Date: Tue, 7 Oct 2025 10:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Remove unused @cpu_exception_index TCGv
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250924171308.53036-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924171308.53036-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/9/25 19:13, Philippe Mathieu-Daudé wrote:
> When moving the @exception_index from each target ArchCPU
> to the global CPUState in commit 27103424c40 ("cpu: Move
> exception_index field from CPU_COMMON to CPUState"), the
> @cpu_exception_index TCGv has been created for m68k target.
> 
> For years, no code ever used this register. Simply remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/translate.c | 6 ------
>   1 file changed, 6 deletions(-)

Patch queued, thanks.

