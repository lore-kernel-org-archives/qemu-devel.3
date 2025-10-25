Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024A6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCjv8-0001Jd-Fv; Sat, 25 Oct 2025 15:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCjv5-0001J8-3k
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:27:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCjv3-00039o-CQ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:27:18 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso718240966b.0
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761420435; x=1762025235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7t46aHdwi2u+ocHrknEDU09h+Ad/TXg7YFYmx+cXj28=;
 b=uuBahF0XUAviCXCdT4HtBxo2ITNd4VMVxQZn0rQMbw6iTTAs5FJg2DTQ1qceFRGxpt
 yn/rcrjYN2KHLneDzG2hfB6DIFnyuoGN9rNtd2AcMX8hSegC4hHoZwGMTGPN7dzohscY
 GIUTIlWmBxmSCnVRTSaXN+tGsdXwsadHr9+tUq3s0EEUiKMggjXASkjjMGyzOEuLbuTO
 uv99nT0PTQ59w6+/WsPVEyKd5Kn/w8AISZud31gKxetG2ocVn6Le22EVzRidJXIAnZq1
 72jJs7tWWJKPW3Rl2SKcqfnNcanIn8MVo1FhnBV8eoQaO63Lw7jlXmjITyDzzBDx34Qu
 avxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761420435; x=1762025235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7t46aHdwi2u+ocHrknEDU09h+Ad/TXg7YFYmx+cXj28=;
 b=kPbv2H9lW1CxGpO6a0PnMA7UvtDrHeaCR5RDP3rupxdEsDPKSRKK+k3IGmExxTq7SV
 Akk0EncEUW0BVOz1g7PT4yL8pv8rpdYzlnsBqFwqPB5SpudA5HtDlRlH1UBRAkJaDvRw
 7UOcfkVDq9Joyd+GNpliz4ukm4N/xpJLkgwKXw6kbyH84TFgUTX6kbnbbvzATDHtNRjo
 XqMxxrbiibR2I0xts884ygs5DuvnruU8u3cUoPKT4GNWMpVc1nntJzsUX8mh0NfW+72k
 AQ7vp1YbBCOItId7sRRipqdS0Yk39S00L/FNtEOavgScrrCNGRoIYTxNnqv2LcAz/4cf
 47RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNqox6pm65TiQ9IWoRwN3KPIKfSu4SfwlDP+ZOZ1weNks24Tm7MoCcSjkXuQe7XzvVMqTnWuKKC9bz@nongnu.org
X-Gm-Message-State: AOJu0YyAcWeFKndp4sXcqiBO/VP2zKi0bwWotUONFZcCzT2O6uyLpsE4
 xyG1fNX8voHTh/7e0vH9GLjZs/ZpdOjOer56fOXek7NY1vsXYsZZquWI+uW+JtKXHNc=
X-Gm-Gg: ASbGncvs8Tv55EueWQpwBm54tz46tWbJ2igWvkkWdDpojEkzCGg3KhONVDQbZaMsowb
 CWou0z1q2hC/F4SZtB/kAXqScLf5AUWAEj+gPavHUNKdWYS+HrTqo/MW9O65trNSX+KZYaTeghC
 Y92B4ihG1hULBcz4J80yosENS4tZpBI6qts3oL+tyNyCxGbUtibil5Tk++qKujutbgQenUFLna2
 DCgmjZkDGVZ5Bi2C6qBFFlPo6L9XqnfU+Q9esTlMHaOKLMuBCYvoW7OEN97TKN0DSlqT/XifRwm
 D+1F+j6cdRRId6L1GZNPdJDYwa00S6cLfW7SxKP97Q+KQkLxoZRgPIXNQ97HAulxsRwKFDCCwCG
 jqaAvLCz/WKzdkVj0705scDJXQuPLLFXeuFEgpDUnyJKq3jd9m1LJDOjYndf86AcMhTNTCH1wRP
 0/nOy9CSh9sNww0say3cmC1VaofJ+QK3D0EIXzNbsIKmxZbvnw2HIi8vjqdTIYmBw=
X-Google-Smtp-Source: AGHT+IGbLao4fff6dgi/d/NLWKP9Yuq+HBURBq0obxPgYYbpiQ200zL/c9un01B/PUypiAKDMgkYow==
X-Received: by 2002:a17:907:9629:b0:b4b:dd7e:65eb with SMTP id
 a640c23a62f3a-b6d6bb96071mr723531566b.25.1761420434387; 
 Sat, 25 Oct 2025 12:27:14 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541e99fsm268026966b.61.2025.10.25.12.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 12:27:13 -0700 (PDT)
Message-ID: <c50e3ae5-44d0-440d-b0dd-19a7c0459594@linaro.org>
Date: Sat, 25 Oct 2025 21:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/58] accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023130625.9157-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023130625.9157-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 10/23/25 15:06, Philippe Mathieu-Daudé wrote:
> Return EXCP_HLT to the main loop.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

