Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8D8C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKJM-00046t-Fg; Mon, 14 Jul 2025 10:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubIlG-0005z8-0p
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:58:28 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubIlC-0003w6-V0
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:58:25 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40aef72f252so1166060b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752497898; x=1753102698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CrCt1f2GP78Tba1HZzoGya3Pie2iZyg4IuKHkDRggtI=;
 b=ajSpzTQixJGMgZGZs0ZmJjlc/3tBoIu+wL49Bvb7W7fSBHHnzSpEIInN+woFMw19qr
 a7VSPCuhAYbU3smpQ8fiuQM4YSENOJAM9G8uSgdG/+ORYT7DDKdqp/Rxxrpe8DE+gbh8
 mv5YxluzV053BuonNEz90CUwc5ar9QYpKV7uUE1sCYspACJCXKPfKByt/OUedmCdo+dr
 yq0gmJuXCcPRQEEGsKpazsbRdJdGzgVH3qbxbjSW9zK3+teNs1wDuHb+ofghjcXJFOmq
 FuUK5jucYS0zVuIikRKY5T5evDQJCMOJ0q8/sueZXLOBAHmeWB3HfOV+kq8bpx2jI2OE
 6f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752497898; x=1753102698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CrCt1f2GP78Tba1HZzoGya3Pie2iZyg4IuKHkDRggtI=;
 b=AUE/K7hYOLRmKQBboQTGMCrSUXegPRyUeqKo5dsrht/AUURA1F2qCIFysIrZZjNtIl
 coyRmeac0L0zaMU/XzrLyuZADrYrQcLM1/7WsJuDPudPtptEiWjhtctWCpLpz1b6vyuy
 WQJL8kvwP3DYwOr1ifbV0JbwTO6VsSo9oErKA0WmzhjODE1D4HShyL0lEQIKqxC6xPud
 htfqkYUkJha1eUZjYZ9FoOaC0UDMwp/Ox/DMBt8K/l9vTWwtOF6b7kRZtO2Qb5Sb/ozz
 arrOvz1eUD+vU8ckdBKPeFGhbm7kTACtuIT3xYqmkXok+OTFsb3HdXQzKWOo8rkhUelq
 ttCQ==
X-Gm-Message-State: AOJu0YyjdNXi0VK8xJFBAcw40F31T0nFZDvVxfI09vGS6Wjv4TQyQzy6
 RAp9HZpScEoeOkMDyve1QfL6gPH1LMe/QGpcqCFcQOV/1VOpfJnmUbJoNgwvMxftLCY=
X-Gm-Gg: ASbGncvv6jQ1AMahKjXK0gPwV10x7oKkvCf63AnsXItA7e0rpKpiWAiXYZT/5A01ISW
 84SXfDHzFIh+ycbJO2TbdnBKv8Et8LoLT48SvW1MTyw4H81xO0YF7BWoys0s9umnHQsi3W8w3l5
 5qlxaQCOmv4FwSankWq5VaqpZ82GqcA2FzbN1wUwH/qcqrwqH3zrTNUHCUqCdnfPiaSDIFm9eA0
 QMWHwonrNwRTdUrGtM1DPnKHA9rpv2sQcaR3wBaLE4+MPYke48gTUnn+MwZMhcFCARH5g8oHkWm
 1QSRMR6C+WNMU7tRZa3ulP4zrSZqHlFmPyVcRppDlzkT/QOPME2zS5McCQw9etlAcDWEVGmY+AV
 h/GBwfnefVvbu9GdlO1+t0gvjvzH6hDPGcg2U6Ct0sWVxFJyLs8CY9tNM6yjVTSd0MzWP6ryV+V
 Jl
X-Google-Smtp-Source: AGHT+IFwMYmiYmYdrlThntJieSU7SPATuB3z4suxOYR+VlJbtTt2lPkFNYNDq4BkBNiDkkTkrWs3bw==
X-Received: by 2002:a05:6808:524c:b0:40d:547d:397 with SMTP id
 5614622812f47-4150f5ba480mr9388435b6e.23.1752497897835; 
 Mon, 14 Jul 2025 05:58:17 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bdc823bsm1532992b6e.24.2025.07.14.05.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 05:58:17 -0700 (PDT)
Message-ID: <f18a652e-b64c-4a33-bd60-63dfa93ffdbd@linaro.org>
Date: Mon, 14 Jul 2025 06:58:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] target/arm: Add FEAT_TCR2
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-5-gustavo.romero@linaro.org>
 <21bfbfaa-f0df-413d-bad6-b69688ac381a@linaro.org>
 <65e20340-e164-4424-bc60-52d78b9a17b8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <65e20340-e164-4424-bc60-52d78b9a17b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 7/14/25 00:21, Pierrick Bouvier wrote:
> On 7/13/25 2:59 PM, Richard Henderson wrote:
>> On 7/11/25 08:08, Gustavo Romero wrote:
>>> Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
>>> These registers are extensions of the TCR_ELx registers and provide
>>> top-level control of the EL10 and EL20 translation regimes.
>>>
>>> Since the bits in these registers depend on other CPU features, and only
>>> FEAT_MEC is supported at the moment, the FEAT_TCR2 only implements the
>>> AMEC bits for now.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> This causes a regression in tests/functional/test_aarch64_device_passthrough.py, by
>> continually trapping on an access to TCR2_EL1 while the HCRX_EL2 enable bit is not set.
>>
>> Unlike the similar SCTRL2 failure, it's not 100% clear to me how the guest and nested
>> guest kernels are related.  But it is clear that the outer kernel does not does not
>> support TCR2_EL1 (and also doesn't manipulate ID_AA64MMFR3_EL1 to hide FEAT_TCR2), but the
>> nested guest kernel does support TCR2_EL1.
>>
> 
> The same kernel is used for host and guest.
> Maybe it's related to kvm support?

Oops, no, the patch fails to enable HCRX_TCR2EN in hcrx_write or SCR_TCR2EN in scr_write.
The same is true for the previous patch with HCRX_SCTLR2EN and SCR_SCTLR2EN.


r~

