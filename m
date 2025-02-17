Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0E3C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6vd-0002QO-AO; Mon, 17 Feb 2025 14:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6vb-0002Pp-IN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:37:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6vZ-0000o4-Ng
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:37:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2210d92292eso55261795ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739821032; x=1740425832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnPoxDRkkg3yNYUbz31wqXsXWbEh+jdjiG0+Gob1h+Y=;
 b=ORGG//fGXNcDhfZMnYearKgNo0eQv1JHNe1FBtWWN9nNK/FsP/5BUgw0g29nwNhpJ+
 +3CWwPs5g99ztlEIHvP19iZIk06s7zJBHkHjGeg9ULWzjfjAGZ11y3Ty5/ZEXl5Q24mS
 iOepLt0jdFmAHbdZBBWCucZGVgLjzrgIZMEDh671r9CCkGyA4LOwf4pSsYrNJB+bNg+a
 H9Y4PmplpeEUAg45Bn8i94224fnzA0prY+QNx0GBITfOTVYJc22I8dAIyn54lcTHEPCq
 +hjcxvPPdCdJ/mPP8fNr+aN/ji7n69rmUr7wN/gpbS4MlKdBFgFCkOSKtINxCjbBV2kj
 NI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739821032; x=1740425832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnPoxDRkkg3yNYUbz31wqXsXWbEh+jdjiG0+Gob1h+Y=;
 b=XNERcyHpRdxgtJdGNwjZ+UYEYbw9ywKTI8VFjibrMO1vd+8esjAI3j0dIUvYnvDf2J
 8XWos2iTrj3CJRXKNcEIaGbZZ6w/KyzDAgR7lMticSk2OiYVl07/ma82cGTIG3/fxR5D
 ECRdMb1kdCbi4SMQn71Dh77u8W8p//frNmaH2ZMCozSxsBfd5sEC2KloPykMo95GoPS5
 jr9SbGXBh36QVA9G9ci5iyqaY/5Q8peyk8uRKIMgR5aQnonyXKAYLRlpsQoW6OHEEC/I
 3eJpp+Sgw7k520GNhqTGi++0wUuhVKwsyBHjt6unWPbSWlO9xcYSx3FUmAiJH/qScMQg
 ZttQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU38A5tExyCZz0fzgW3PZQzaSPhXbe8m/Ux0+ipKI+coRvNoBmIgTGXVk10Yojl3T520HRYsKyP8IKg@nongnu.org
X-Gm-Message-State: AOJu0Yx9p502CC49hH5TiPb724Ug5+zPPuG0fBUx9nGx1Yhir+myjKra
 5c6gYJp5nasZkUocdUg7t9AzdoQSZbpbabyC1kNHyKRIb2cESsA6kxUGk2u4vB4=
X-Gm-Gg: ASbGncsDbyn3WzAokpgnXGDRetRAyt9apNMpcjaaANgNJtX981f3S5m6GqjBfZ/62cB
 HwmVThfTNOb0zygCZDXHdVxDGpxIXvDVyG3ok1YjvdH0Xu9gkTz68RtQT9NUKppYDvgb1SD6X5B
 CFfrf6HpU6a6+TbEfrDlRljinnxL5i4vRlTQR4UL0iQCrEE4mqk816OPDU6q0OOB+puO2uDWCCd
 p2ZI5L+XgvPRu9QBJiymN+n/rYhPLcaL0KmmZ7hc3/DYBy3+yT29egaOHQ9QszuQO52oFPUhpEb
 ENix/z1Dexit+qIEc04OgiFia+nOJ9PxfcGMlk0453xnkOMSeThJyCU=
X-Google-Smtp-Source: AGHT+IGxv9e7H1TaFRtzUl3KditkVD46qYl0neiq5cSKEc/i39/QIqRW4V+jlnigD1G/pbqdq0xSzw==
X-Received: by 2002:a17:902:c948:b0:220:bd01:6507 with SMTP id
 d9443c01a7336-221040612afmr152309185ad.25.1739821032222; 
 Mon, 17 Feb 2025 11:37:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d559600fsm74959415ad.248.2025.02.17.11.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:37:11 -0800 (PST)
Message-ID: <0806849b-2e20-48e5-b447-3fcaff49bfd8@linaro.org>
Date: Mon, 17 Feb 2025 11:37:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] accel/tcg: Take mmap lock in the whole
 cpu_memory_rw_debug() function
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250217130610.18313-1-philmd@linaro.org>
 <20250217130610.18313-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217130610.18313-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/17/25 05:06, Philippe Mathieu-Daudé wrote:
> Simplify user implementation of cpu_memory_rw_debug() by
> taking the mmap lock globally. See commit 87ab2704296
> ("linux-user: Allow gdbstub to ignore page protection")
> for why this lock is necessary.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

