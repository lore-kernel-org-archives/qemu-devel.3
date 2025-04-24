Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7229DC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qNA-0001UP-Sj; Thu, 24 Apr 2025 02:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qN8-0001S4-8D
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:47:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qN2-0000B1-PR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:47:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso3621895e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477259; x=1746082059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLIwpe1d4OYBJQ7SpclsUJTPPc8sysOW+QazN27/F4I=;
 b=GyTkKnI4Al/7p4PEyitIKIpV6ep/6nN8eJCnmWdAg3dIZ5QOuyD1et7bSy9oj9WKAO
 bZnxDwmMGcGgirbVBlF3tU5LccMQsAlTekl8hXvw1SCf5QjS2lxCWS4pINiEoPkehtte
 9wHsVOwwBryTOtCxevbe3Ufmd/npYRjCHJdX85Ty+EVLNKKCAGCl8dQwjI93nsApoleI
 7JhSETVSlfL+FWrxGqjdTQONigkK6w+TNiRbuv/LLEIhwvlU5r6rbKBjgTeJ1W6KV+bP
 0sNcAv8pqav0v1f1b73T8gGzUFGHGS+MEzAMKcIoe7ENSHfx9DSOdFllXcVTey6hs0Uz
 +8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477259; x=1746082059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLIwpe1d4OYBJQ7SpclsUJTPPc8sysOW+QazN27/F4I=;
 b=iy2Xbbe9XGdoMsD7z8cDOO4hmiJKrj0xTlE+LgVdr7ULcgCRhZBk46RW6KNuIROq4D
 +ty0iDtSb1Coi5vvT8qqV9yjJ0HJLS4waNZEpyFEd8EEzq0NqeKeAmZEG/YPyOrg6qmn
 TI1jI07Jh2S0m+moeG9WYagsxumdnfSD1kvB8wohWbznX6JF/yOdNonPX38VmH2oEZFW
 uAoIExStxEmn4mc1h91pcPDDZsEi+02XLPOwbZ/hFcY8ATGwTUV/x+KpjMJLIfm5KPIi
 rjHqvfpkYkYOx2sf5Q9wOqG9NpIN7h9JY9XpySd0ZbnxgVf1PZ5W1R0LuG1rNPjjjNc6
 xDJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV8KbjE2iGdVcWw+/cWcEBjWXczMdPCtqPRdN/DmetGMuBq+jdMqDFVal/32suG7wx3eyvCPRJsfMF@nongnu.org
X-Gm-Message-State: AOJu0YzN088f5qkSzIOHfQAHvj0xNVdbBwoOIuvrnN+DYkeUNKezf9S+
 bIUmxGo8vv1Om0IjcX/vepXCpTeBpykEZFkiALSERd+wH9AUvYZJ2XcUHMsLDPE=
X-Gm-Gg: ASbGncudOn38l4Tq0gWADwrVc1++NTxNYbvxTlBNJfJKLt5jH/5giemx+xQIA2FynOT
 QVdfSek/F1Lz/a55a0HpWapjeZbcHL2oPbivZ42GzXK6RneYSrNyKS6Oc9ZkeMB5ho+8STQ6Bz1
 rNZXXzw5Nqqef22tWyeTh6PXPtCVpPE9e2WEMVVAeyJKHvHidGReZIPPfqxc7559OIXKpuZuaG2
 A2/YKrNmLTno/l/xfU8qbofaQor0hhkFbaehvg1BlIDy3lGzR70/k7AkJPAj7WOQYSfnD9LuwEJ
 stGKMroU2l+2UiS+Sd+Twi6/1rC1yw90K3pAyDJfEKb/XD7C4J+wnAyKtjLMsDHvmsBhJ0KD3PX
 oHRjZh35Pu5rDgQ==
X-Google-Smtp-Source: AGHT+IFkg5gtvSuqn9azKrftuMQqBpnpMnxfudZEtUPNMQJPiZu53yOPX61QtkIZCjX0JwJPTwsDVQ==
X-Received: by 2002:a05:600c:3d0c:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-4409bcfb42cmr11870645e9.4.1745477259170; 
 Wed, 23 Apr 2025 23:47:39 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm8252395e9.0.2025.04.23.23.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:47:38 -0700 (PDT)
Message-ID: <f6b3ec2b-b480-474a-ab67-e79604acc24b@linaro.org>
Date: Thu, 24 Apr 2025 08:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] meson: Use has_header_symbol() to check getcpu()
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 devel@daynix.com
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
 <20250424-buildsys-v1-1-97655e3b25d7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424-buildsys-v1-1-97655e3b25d7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 24/4/25 06:50, Akihiko Odaki wrote:
> The use of gnu_source_prefix in the detection of getcpu() was
> ineffective because the header file that declares getcpu() when
> _GNU_SOURCE is defined was not included. Pass sched.h to
> has_header_symbol() so that the existence of the declaration will be
> properly checked.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


