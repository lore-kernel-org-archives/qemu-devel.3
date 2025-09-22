Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33296CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 23:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0prj-0007UV-Ug; Mon, 22 Sep 2025 19:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0pri-0007Tx-Bo
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 19:22:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0prf-0004vf-8L
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 19:22:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f169d8153so2708117b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758583353; x=1759188153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vl5PVHBJTjoOqGez5M5TMuwdwkg4IWS6MFCIyEgicic=;
 b=HmD9npOQNPd3vKFj2M8Y3MbW+Sob2MAdHbWI/8XZGwf1jAJwaULPS8rZwl+Xx0Tnn0
 G5YYV9yDSA6WbbAAv7pdUD5QDVhJz0FljE/uj+IVCA1NRO0uzYD4Y98xCZ+cYjilsPZe
 zE0t+AegqMO8CM9i9aEUt7Y3no8crdpjuEScmO8WasN83EoM8at9lnaiTEDooNKS1myY
 PtwFFGj8fqLgE5UngfvYJpTBx5DrHDRm858NgXRYRYmHuwh/M+lRSNY8bRxkLqK3xXgk
 Qn5/+/4rBEL/ysXhVnQ9JDGq/XjZuR1a/8H7hJrPQZoFo7UPycPpveSuWdn4uPVFHzLM
 CSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758583353; x=1759188153;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vl5PVHBJTjoOqGez5M5TMuwdwkg4IWS6MFCIyEgicic=;
 b=Qwn0TBm4fxYT/p3Bk8hMeed1wriezpcGMlhet+WYCFdz2BOrIbE+AVl40KdlLI0f+F
 p1erYoEOkugwrQGNpsXb7zaTFXJ07enoUUB/DKBZN90YVr/OfYnqZ5ilgYEKUwwAXI2h
 qhfA/eBvUJjrlPACHJXbKDeJAkZI7DueYDIuchZAWObhjd9twPDn9s7mi+0U6XqulUfL
 j+lly8xNRGS3gWyA1zZgaJ0cMFpWQWzl5xY1a2QB+xlJfjbLHfXzA0xMgMXrS2Ivfr52
 V8474cqo5mgV3R2FypwbwvtUcJpedHguSAyTMnjEi8azMt3RalhJFjIpQI1xKt8CZxt/
 ZS+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHnvCWS2QxO0cdIalMnKKKuXQ7W8ILHVrBwhojirOUzPaDzV9Af5ZCcMUUGf98mxatLOzSaJs5rL68@nongnu.org
X-Gm-Message-State: AOJu0YxS/i0ZTycUD6d+/I7W/N2/TdNqEGIbIv1XbnxA3fGS7RR9wogJ
 NUmkdEyrBmnkjyVWtCOltxfeyrnFBhwq9+Egl/7aN7/5rijW2o904CjPyGGUOVjpzMA=
X-Gm-Gg: ASbGnct3ZFGd1FTcKMpCZYkiNtnWXZik/NborsbYR0faOOjUzkH6SrI3+cDsLP7h9Oq
 6LMonGrgV6aBvXW29hButHwODhHQYgpaySMQkkVTVBQdLBmC7sc812Q7GSyCVYv/pXYYMhfFNxy
 yq9vDd27ey4KHaZHNjrdOgFRsdyRs0GYnayInqT2gUfy9cHHSgwzrJY7ncisrHMm7TQ2q9y6Ufo
 N3FGyb1dLE+LFNLtP0DMY5DiAbBGrr1rvRuTcqEHmyMd5c9R7oVkwlIJ1A4J71eXyO9sXuASitW
 8Dfu4UNkpGmGsXRVAYbzUE4f8SteHakYI3SVKGoDPAwBhDTAVFmD/uF6EWwY5PmQEhiJF7UWvc3
 akp53EH9KzDlmdf2Uqx0rwSL+XKkI0uAbw61s
X-Google-Smtp-Source: AGHT+IEbb68a+ocgfNV3uZbFlEiuLnfdc944cLAO2JcGCO8ynuZgQWBjjlnBxXOAIJNwLrT5noKWVA==
X-Received: by 2002:aa7:888f:0:b0:77e:ec80:b3c5 with SMTP id
 d2e1a72fcca58-77f53b4966emr546816b3a.22.1758583353010; 
 Mon, 22 Sep 2025 16:22:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77ea933bfeasm10473601b3a.53.2025.09.22.16.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 16:22:32 -0700 (PDT)
Message-ID: <42fd4eff-9275-4e0f-8300-eba0dd2242bb@linaro.org>
Date: Mon, 22 Sep 2025 16:22:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: fix self-modify-code problem when modify code
 in a single tb loop
To: liweiwei@kubuds.cn, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: kasperl@rivosinc.com, wangjunqiang@kubuds.cn, lazyparser@gmail.com,
 liwei1518@gmail.com
References: <6F6BF0F431B23852+20250917124734.443966-1-liweiwei@kubuds.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6F6BF0F431B23852+20250917124734.443966-1-liweiwei@kubuds.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 9/17/25 05:47, liweiwei@kubuds.cn wrote:
> From: Weiwei Li <liweiwei@kubuds.cn>
> 
> The problem is triggered in following conditions:
> - thread 1:
>      run spin loop(ended with a direct jump) like "0x0000006f, // jal zero, #0"
> - thread 2:
>      do something, and then modify the loop code of thread 1 to nop isntruction,
>      finally wait thread 1 exit.
> 
> The loop tb which is patched to jump to itself, will not be updated in this case
> and will never exit.
> 
> Signed-off-by: Weiwei Li <liweiwei@kubuds.cn>
> ---
>   accel/tcg/cpu-exec.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

If there's a problem with 1 tb, there's also a problem with 2 tb like

	jal	zero, #4
	jal	zero, #-4

But unlinking the tb should be part of invalidation, so I don't quite see where the 
problem is.  You need to expand on the description of the problem.


r~

