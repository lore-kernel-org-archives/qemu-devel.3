Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0308C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 16:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqwlv-0004qK-PU; Sat, 08 Mar 2025 11:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqwlp-0004nc-Oo
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 11:11:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqwlm-0003Yh-NO
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 11:11:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22113560c57so54288455ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741450280; x=1742055080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fxUjmsk9NNMuw5a2dswO15JupFUX1TXb2+nK27dchFA=;
 b=WBzNq2b+8LWpOMFq3IDE4/vcdFHfSQbI/8C73ia/IdKXoOeoQTHZ0sIB5fu3z/3h5I
 Cuf+J9cu7Ml08/G1ncYyCpfstAjaf++w1Ofui4jBGIJFHbr02/n/Pb6N0jUr4Q3tCKkn
 Xy61AGSuwvRFclQEaYV8SWpoDZN0qaBou73wa6zkIHjPI4jEWgpNpWE5wUUq+GxDY+NL
 /b+Mylt0r9EBT+aUPorfbBJsDF04yPnun4kTPXtKCyPzqfh4Q9PElW7Z7HYML05OGnwL
 ErAq2l76TWjsz+1OSrFGfuWEPjeIIY+68tg7Tfu8J6LJZvuwZG5KjbfeKz/gUwkxOCZV
 nUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741450280; x=1742055080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fxUjmsk9NNMuw5a2dswO15JupFUX1TXb2+nK27dchFA=;
 b=e1PxKOF2NsnsYcq5vVIrEXaPoFXBaWIe7iV5aRmXGl8GpqOvuSnrp0qJis5VExooq/
 douJR6qAdnnDi1PJk0pRLh7vjDS8iXrxqUfefiF1/yoJRcLr2mNEcuFXqWVKbg3YfLSc
 1tv7Rxj6H4fJO5sli1+fym4vmO7hYVYGrmZTJzirnwMhMSO/hgStiR216QrWfETe2PIb
 Okg32WQtVYrXlprDbGY+3oVLb6w+rK1fPAnkhazYsAWABfj3YserNjxHM/8XUBT3nspK
 x/4s4bH73jEF8vvtXALvz/slxy6m6Ifr+whEmPVPJtrnB1xIjP8N/dW5wYbJjzkLvv2k
 v0EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHiqwvY3Ey91c5DHmkdTH3QUKS4eOf4USW54xYqIYQV5a7mWh8dzAQgeCBftovQi/5pUDGbWPaAkDB@nongnu.org
X-Gm-Message-State: AOJu0YzI1/Dt0WQo/33jRMA3wR3Y/dCp8+nwzirJ9Gly+aGSHspJBju6
 tPqTJBY9GFCm4BQOW02vTDL0ZlYhN1YTeG/xZTrGdRSKwV/PjFHZwUUGSHY1+oU=
X-Gm-Gg: ASbGncultdGt9/iuL6PJa/NudZQtClztIIaMvBeQIzXjDwev4r1nxuB0xc5Y9W1iO0e
 /VzKA9UbV8SYIudwgXTFEmMISy6CqYSl17g0CWHUn/bR59RKuZ1Llk7DvpCpilyfnUAAO3W1/Yn
 wGaG6mfCaRMgBLJQjU443BB23W0XdixER7LOwToTBKgmAhnD06j7GMJJuaeI4Dwp1hlMrEuqElR
 VKDwQqpb9Frk2Awywz5pjb3gkisFA1TlYH+CDSfxoJseUgGlqzKzrJ4+bLQ9HbxKr/V5bxgodsO
 c35yPT3/STF2mVZzms0S+o09BUpCxK4yaFthiVyYeCYkJomrIUBNkLN64NGaj0Dq0HBku0rcntN
 S5hGpsv6d
X-Google-Smtp-Source: AGHT+IEzCp10URjLOERY9w42RdnPQWCMo2kZw2GV6KaEkEEOHZ01F8iikrOMK9wylbsgMM0MzNqvFw==
X-Received: by 2002:a05:6a00:1708:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-736aa9f0b0cmr11878138b3a.12.1741450280404; 
 Sat, 08 Mar 2025 08:11:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736aead3439sm3343256b3a.64.2025.03.08.08.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 08:11:19 -0800 (PST)
Message-ID: <ef66b738-1e90-4471-aa10-f21decde3fc8@linaro.org>
Date: Sat, 8 Mar 2025 08:11:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Consolidate core exec/vCPU handling section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250308134938.77267-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250308134938.77267-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/8/25 05:49, Philippe Mathieu-Daudé wrote:
> Some common cpu/exec files are listed under the 'TCG CPUs'
> section. Move them to the generic 'Overall Guest CPU Cores'
> one where they belong.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

