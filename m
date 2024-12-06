Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040ECE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTo8-00086s-P5; Fri, 06 Dec 2024 03:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTo3-00085q-Um
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTo1-0000SQ-FB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a1639637so19067425e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474120; x=1734078920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKtoVP5oIpK8eKjtCKbNP6VuvrQ1xGcCJuh+XBFYC9g=;
 b=znxcYKfB6nR+Ge3CN8MS4qZbvvlmSclXhnmwa0WbL+n8Qb1WAtfRfmb6CobbSmG0pG
 R7vYcAJJwzVojONiIyyj0nhj0O1qnsGYGT4pbE2mAKzbcj6G9GEpVG3AUGRRUbDZXxJa
 2Wha9uw7Ny6JV2YBtEGiXsj4dD1iRlsGD+0rHjmvGd5p57HrH27tqnUEUMc1oHg/HQHI
 uh1pJlYVfAu9IkX4CNu5sswyWSCgJ+Fy1rEq4ICHx/A3cnBtvejF+bjtq7mickZAw6Mn
 oj591daZZw1w8cYLyFKP6d9CjGeRLLr36P/HRAuxF3sK6B2HMTW9czDOkSfd80zVzQo8
 Xg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474120; x=1734078920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKtoVP5oIpK8eKjtCKbNP6VuvrQ1xGcCJuh+XBFYC9g=;
 b=hEK30RrH21ZtGFvJv34RaMxsCxzNhD2f9SHIq4wQTVpEDLkM7iZZFFsEB7r36pYLpe
 L+z9yN7LHsyF/0IYut4hdjuFh5JYxZlQaIN41HLLIwpsz/02vqsacc7XztsTeiL/5SF2
 7fSsaW5qaa/9VWx5JdtfOKYL/6fiX2jKsNL/t3xSAAzl2iFoi2/43Sfq7eehnPj8cxJW
 6l7tRCLQcHkgOpyQk7HqJs8jjsnjelb7ZM3ZFTwBAOx1xxM5KkkE9sWa/A5QFnO85IEg
 Je1x0frCzm4vbLuwNbLqOwy3cl1fkALlY19vxcd55fXLroxA1U23EuGpCipKRq2IeJqL
 CITw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ycUGtjyHDwVGdd8F7lbg31e8JO/LMgIN1xxlQhlomaWdNSstNZ7hzIVsGTEgTfTMXQ2o+oSUlCDv@nongnu.org
X-Gm-Message-State: AOJu0YwvH7YXd6ZWdU2U6YI1P7r3CJLy6sQB8utoT0Uq+pUTvkOW8Ttb
 RdoDtQab3XBYgCQL+3u1P2Xwa5RW/snlTFRAt/eHQZRTG12T5tpko9VeLd5vwcM=
X-Gm-Gg: ASbGncsx29nLmr8gRYsIRKBYWmH6pv94eNM1CNfDRiCqXOKIuIP6B0Hd3pT9jy6jDJ2
 k7WPPMk53QAnh7pauPxb9QmasbYhjXrMvTtfcVCb0KQNU0eaIQoG5NGh7GAsDqRfGTlKxDEgRYl
 27tsajbrz3F6KvgITawDt1h1qEU7t7D9ItByA8L9+SIYGcypb4dbhfQzGKhYHjVw/Hc2hC8EqhK
 DcMmwfUVOonzjC8aLuhwFAkPxP+IFBHYZYH59EVQIZZ8KEQ0xWWjh83aN+DpIoGvL15atJzoD56
 hOY8mbweShWpYWSksQ==
X-Google-Smtp-Source: AGHT+IET2v1EvPu3eKnR8hdw9LeSkFqDiEL4eDYoDzwd4NIKuPQyCtS2suLg75yvWoR570unyGk1fQ==
X-Received: by 2002:a05:600c:1f81:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-434ddeb48aemr17501015e9.11.1733474120111; 
 Fri, 06 Dec 2024 00:35:20 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da113508sm50732425e9.35.2024.12.06.00.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:35:18 -0800 (PST)
Message-ID: <c0e6f8e7-00d6-4f6f-96c9-829419ce86ed@linaro.org>
Date: Fri, 6 Dec 2024 09:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/arm: Convert vfp_helper.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h     | 268 ++++++++++++++++++++--------------------
>   target/arm/vfp_helper.c | 120 ++++++++----------
>   2 files changed, 186 insertions(+), 202 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


