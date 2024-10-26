Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8228DD10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Yb0-0000KO-Lf; Sat, 26 Oct 2024 00:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yay-0000Ho-EF
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:40:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yav-00018W-Ot
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:40:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e5ae69880so1918113b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917608; x=1730522408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKvTzTd2ANidL74ryN8G09s4Libe61Whgnlswc7fVp8=;
 b=S9nX/+SgOBgWsA3IrTRoH10uSokbYE55izIzlHJODsyzWQW4hhpsH2Du+I62fiwvN9
 V7XznI39bETZe0KrMrLf0kqPwZcpiEGGNaj6UpEQgplccUbuFq08k3t458CgZ2Dan9p4
 AHP6SEbBwaREEYE63r9kT+nEgO3owK1EcTLtke5Fe/raXzXoSjeaTOZRQnvHgVtGi5aq
 mPLoAm3MEs3lc3p+LXodFAEWu9VtUXZj+yLGRilJY4Fsq9SWBq4lcxCeTRvp/vfwcfRV
 oEiDKJz5nJHPILKR3ExqdO716gQ+2/ASDYpEzhMH71MX/ra2kFIVMH6Kuv8S302/3jYc
 OGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917608; x=1730522408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKvTzTd2ANidL74ryN8G09s4Libe61Whgnlswc7fVp8=;
 b=lbYnaO8zqMj7Lx/VnyBMh0YNiG2Jm9YCySNpmnSTn5V8jypDiJMuyhgtnnF1k722O4
 tmEhuJlL5W+QlgNOGf8VerAZ9TaqDqP4ZlmpW2EPUmr5vPYAVp9HtNRnGgw/fiT1rbnl
 kTWADJ5jiIE0taTB0/9c2ZQ5uCr8+CyySGPl3PZeUgrH3eTzCkFPC6e+/fhB2m8HLXQA
 sra4m528NzlO6EoINzkWHSTvCjdBw0Hm4WPLi6KLlVPAmisSYuWVT6HdIZFqg4XKBFvy
 DhyWDFFr0o5C0Q56ouaCQBk+WGD5nEJi8ipAtn0NTCZHZoNM+G94dP21cXYKvfZlwfyT
 jnug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCnoKuIFV+CpPOSAsqjWgKt5QoLXNeGCo3Wzylm52U/Ly3ZqFY7K0du2eEYncazyzdS9fcHeXvdP2L@nongnu.org
X-Gm-Message-State: AOJu0YymyAhlxrfjlSNknziarhEyZ/goWRUeM5PD1dmidnTSX7XTN6Ph
 S4dQg9r8ul+ydR3IQkNhhpHvNU3gJNxYF7wT+H3wiM0/wv8mk67HZs/iAAbUq8g=
X-Google-Smtp-Source: AGHT+IGcMwTrhA4GquFtAw/OAkU/5sXiscLyVf5o6L+IC0teyPNwdg2NJVY5QYBPMx+soAotXkJoLA==
X-Received: by 2002:aa7:8891:0:b0:71e:44f6:6904 with SMTP id
 d2e1a72fcca58-72062fd9eb7mr2854808b3a.13.1729917608339; 
 Fri, 25 Oct 2024 21:40:08 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0cf09sm1952054b3a.135.2024.10.25.21.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:40:07 -0700 (PDT)
Message-ID: <3ba8e29f-0e23-4b8f-b654-8416b9725fa4@linaro.org>
Date: Sat, 26 Oct 2024 01:40:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/openrisc: Explicitly set 2-NaN propagation
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-20-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in the openrisc target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/openrisc/cpu.c          | 6 ++++++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


