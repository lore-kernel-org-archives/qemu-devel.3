Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F6FD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fSA-0002Hk-05; Tue, 29 Oct 2024 02:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRv-0001vJ-I1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRr-0007LX-F4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so52669485e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182281; x=1730787081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jE2BT7EGIKvBQJ3ORlP36YhCMobQCHTdfKNvbMTdSpc=;
 b=WgiaTSFZhYajq4ogKgA5o+3jwt9TMRKQ/xlMDxyfeJhXhp83Dte/fmL2KCgHVoUXpj
 br5uP+HCnmqWcNJafLSkwUhvGJJjqlEYrlxhX+z3uUUtrfKF9p/Y27nCYfKiQZu29rZF
 vE/j4axWOdBHCC26mw3OknN2I//aPvky9ACJ/t1vskPdIv6O0hB/mfpFQobJQKJHAe8x
 DL4B3n+9m7KUf9a6quFyRGnXMsyuBo3cuHRpG9NDeL5GRxuLxcyku0Kff71a8AjiMETw
 RICR19thRok3DCuDACC30iYU9p6RZL5tvOG6qgfQubtarUr2nh+ilyqLYgadkoZqcFY4
 8VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182281; x=1730787081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jE2BT7EGIKvBQJ3ORlP36YhCMobQCHTdfKNvbMTdSpc=;
 b=MJDcDzOXwmjJ/+mtxsH/cJo3QqPFylBtDaMpW7SoKW0s/Ka7AlyJDOolH3l3fDl12f
 PxFoNP9LoSeumh1f9AeL6AA6KAOz7t3FBUNHTHOH0vPyMBnNyrjPwkTlzZtpsGxSod+O
 ESNdXRNfLZ7VKV2uvERLfdZy5vIk/dUEYmBWVRkeVAP+v6Kwr7PFMZi0sW8cupLOVX2N
 GfxP5ZNZlxphVX70/BRMZVQR0/7wYfO+mh8Ovfhy0vOqwAHIri5j9Nxksa5o6ZK25291
 rG6yeQ6vEK8+8kBA+m0is6TBd3YDz2wG1bd/xKP9U8qNFWda5CCrnG0ZmN+O1wgTuJvJ
 UurA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKOEmsIpKp5TtIgAX53rTds3ue5easa24bqtAgwLVK4KMQ3YjgEYvWKK+4laLerJ5R3Wad2eIl18E@nongnu.org
X-Gm-Message-State: AOJu0Yz4QVvJfSQyWDvTpC50RxpYgQAcqCPnragliCdFH/M2O9gkIi1R
 VNn0V66RVsbLxct2YTWezL2WRv+EPIMvjH8ZD6MhmiOzmLzudSvqu0ajQRfcjyU=
X-Google-Smtp-Source: AGHT+IECOb9SHYbyTj00TCPx1nQpVJVfrB/mxIKC34O7m01vTfaIa2d9yxZMNlvFjH71EN91MovWIg==
X-Received: by 2002:a5d:4c4f:0:b0:37d:446a:4142 with SMTP id
 ffacd0b85a97d-38061158e44mr7282810f8f.32.1730182280800; 
 Mon, 28 Oct 2024 23:11:20 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b566f11sm161756735e9.20.2024.10.28.23.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:19 -0700 (PDT)
Message-ID: <be77ed82-f936-4fe6-9fd4-87a0fada176f@linaro.org>
Date: Mon, 28 Oct 2024 12:28:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] softfloat: Remove fallback rule from pickNaN()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <20241025141254.2141506-22-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/25/24 15:12, Peter Maydell wrote:
> Now that all targets have been converted to explicitly set a NaN
> propagation rule, we can remove the set of target ifdefs (which now
> list every target) and clean up the references to fallback behaviour
> for float_2nan_prop_none.
> 
> The "default" case in the switch will catch any remaining places
> where status->float_2nan_prop_rule was not set by the target.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h  | 10 +++-------
>   fpu/softfloat-specialize.c.inc | 23 +++--------------------
>   2 files changed, 6 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

