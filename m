Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6658C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJDh-0007qR-JL; Tue, 06 May 2025 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJDf-0007pj-HK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:24:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJDc-0007cR-2Q
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:24:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227b828de00so67239825ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541462; x=1747146262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wp48SLQzCDDOEhX90luVeiVR92Yj3/LBSHBEPyNAS4c=;
 b=VGsUOlauAZ5bh5OIx/qT1PBaeUMq1huvKfOWJSlhSttzxQSxffVPrU/zOfRH02uq61
 WIJHFDeBS/3IlSljwq3A25bJzjkQWEINc/scOVia+VAxQvoXCmC0iKhDavnZyGjA7yss
 ox3bje8kjk/WqoxqrG0sW8s0mt7pH15OaUiP7U3JBLjEiJan4rZptIZ4nXsV/ubWpxhJ
 DxnVcpo3q9c8mZKEtpHm+WWkXb5EkxDg5OJOf+j8vlK3snGMKx0USBCvrJ2Dvsjntgtn
 1psmMhGbskfzBgOxzQtZGmtDjI+ABaIXiEwAe0NI9dfPyYpie5EvmB4parYx5g21w/oY
 8tAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541462; x=1747146262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wp48SLQzCDDOEhX90luVeiVR92Yj3/LBSHBEPyNAS4c=;
 b=ns788rJkcaFea1hnMV+vmDgF5xAHYiz7X9OBgE8GecRTu+T0FiJ59rngJtYK8YvjWT
 fYnjERyFceg4f0X1ij1lJBAcLYT3PaYAPxTuzAKg8rw9GlQXKP28u9yYxq50D0gqQPj8
 AGYLWPRKN+VB3vFjUR2NzHWFaQqn5DyUKlbrqwxw2ZA2hObeUBPTYX92EniK24qv7Goo
 8P6q7KJO+hUADt3binWbN1CoWhsiVkSzdkyjNOjZBsR4RRFey1gYrMFtn4ne1MFoYKRm
 nN3hblR3I8kxCxglbgTR0qyAKRPTZe+ekCypiDdVTZRVksLcQyR98AiviMhINsHf8Hyi
 4+Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLlO0L75k/Wqqr2OshvTs4HVJ2fDiMUd7MDjxkR3D7uH9p6tVtcDVmfi79zo8lntcBRqpbBnVasQc/@nongnu.org
X-Gm-Message-State: AOJu0YxFPqUReFMWPxXfvS5wxvEMhWtpW+oRmhPSZEYgHG5xqAHuFbDr
 uB3/DgUokP0tfXl5wlpIH7L/6VKcokDRh0V3oTcHIbjdUhwkxw+Wwx4X9UMZci4=
X-Gm-Gg: ASbGncvmzu2jEKVDauxdHDvGAptjrcS6Q9GXbgtw9hIUWrmISS1Jiy/9+1q0NzdtmXV
 tHnwqYx4LfXodlyP1XmyHpG3KbwQa4c5jp0vCLzR200BnUdUd6ll7kTav6GTlaE67cQqBRMpt4c
 m/z2JVh+AxPYlPr/1jS7kp4kAOmm1oABbSddLHuNOhpP9tsvJr63hYrb/iJfb37lfsEc8DvhQbz
 sHHziys3hqCDBOQCOe1UA5spK9PFfPaEMQa4/ewdG2i6S5EbkDfn5K0sykr6xJeuT8qvJbBvWQN
 UkwCyPMASk1INNMT03YmWFhEG8YJ2cj72VJQkaY5ozBHJFUsUFEXKF38jxhmfSF6AqysqtGzNjG
 0dGAt/Q0=
X-Google-Smtp-Source: AGHT+IG+1RetG7RJ3eDdo4fn/r93QL0JzzajDVJf57zZrejNoeQdLPPkA/gRRtthzFbovHmaOzdEAA==
X-Received: by 2002:a17:902:f683:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22e36209873mr41616515ad.21.1746541462410; 
 Tue, 06 May 2025 07:24:22 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e4537d437sm12590805ad.184.2025.05.06.07.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:24:22 -0700 (PDT)
Message-ID: <4249c085-8879-4e20-b2a9-5e4c0032c62e@linaro.org>
Date: Tue, 6 May 2025 07:24:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 41/50] target/arm/tcg/vec_internal: use forward
 declaration for CPUARMState
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
 <20250505232015.130990-42-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505232015.130990-42-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/5/25 16:20, Pierrick Bouvier wrote:
> Needed so this header can be included without requiring cpu.h.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

