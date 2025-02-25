Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D0C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzT1-00013x-3Z; Tue, 25 Feb 2025 13:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzSR-00006Y-Ba
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:15:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzSP-0003ac-4E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:15:02 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-219f8263ae0so127525855ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740507299; x=1741112099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vRjllXJcowBGdo2ERMhc3xLbgXtEnS3OWewJRZwhHA4=;
 b=AvWakTRjckYtc3S4eqkN4niDLXJabEa5Sea02Kp2nvXM3j3OqsMHYL/W9HtHRyWzxj
 pnnyQAGKL61MT58e4Nv5egASpzaFd9e4Wj88h9iolG+cOBANUDVxNUWMDNl5HjKvsUtW
 nVveBBRPv6DuC9XkMD2OgC4b2rcVwWgXMnFYEgp3JwX3ZHuSteZ2BCk1Sr0rsUdWZ80J
 qUmTHhzpk9s4yefOPddkWrml66/WWTaYEg8I8EgezKLDfU7FYIIl76+5cyqvPE5n92I9
 ok0321t+MQFzGoZV6eQtk177ukWHRIGhXZCKYDxvQlB49t1g1+OrB/loBYKAR5ao6gHy
 VI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507299; x=1741112099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRjllXJcowBGdo2ERMhc3xLbgXtEnS3OWewJRZwhHA4=;
 b=DspCHe1UDkgE7KGgYOLs8k8W4pNiGfKgJyIZqnnCt5xcKp/6iKnx9oMuBH8kxmaJuS
 i98pkpRAJd5SSzlSGX9HmezP6b7lagWK35QJSmfxIw4/mdRskxrIBUyIyJR9uV5CiMm/
 0XhV9pwEDc43jFkaiYxvT1ptZNFyd/QmY77IoWSbfGiIZhuEc19cOlo6Ae7aKvWltgww
 CaZSamPj2+h9Gd/05sixTqUYGecng2a68EN3PfO9OId0TXYL7m/jXuPuz5m5/CyRzHvq
 kOvQEXYz6iTron+FJdkIl2ecNGCQbhLMWESTsxodA/3s8NrIUjbs/VfapHdpQCsjUDla
 kqBw==
X-Gm-Message-State: AOJu0Yx1/LqJvS98MHKVMMnhic4GFkzyYvWBnMI0uYOcToBCwQf984Dl
 birUaM/toMDyhkGMYYUC0uZuCM+wNvmsepDti6vYYAXZUAkAzCAect9PzCsOyXiQg8PDTqqUxhH
 t
X-Gm-Gg: ASbGncsi1DEfqZmIBzwnsUvNjMBJwSx2pW/GDlnx+Mv9jfHShdncJ3sI+C5hpx2VuHh
 nSW1fP94opi8uQ2beVTqPyoVfTMHRVrnW/wPtE7nUtB2UHqSspETwbs1OwGV5/HiLtfk0/m9TEG
 4+040QSZDNi2j4d4p+a6nEhEA41EsZAc1mBUOTjU9A3IuFA+A5AzyLLsPqvJGlIqN0/UHsvrgvy
 N87/Qtrud+2Hh6eHu5sbhut5gIteBp0TQf9TVeMeGCaXcqWw9FH9dYeGKYKyROTTAz5EHqJ6TJr
 JkasVMiwjA0dZojrxYve9eyB+2crfaKVRpBZ5Ti2YQY1JhmhU3/gpbAEx6IYa0NwpZt6f/+TdQt
 ikzBqUMI=
X-Google-Smtp-Source: AGHT+IGlaM0USTCBx7QO+YW5hM7b6ChCe1R1r3Qt2rgy/wlbSPtVKVPzDcEZ837YwcdYArxp/9BHOA==
X-Received: by 2002:a05:6a00:84a:b0:730:957d:a80f with SMTP id
 d2e1a72fcca58-73426c7c5d5mr27679922b3a.2.1740507297733; 
 Tue, 25 Feb 2025 10:14:57 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a6f8e66sm1829973b3a.43.2025.02.25.10.14.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:14:57 -0800 (PST)
Message-ID: <21b3f794-2f2d-4a51-9fe8-6646d3af668a@linaro.org>
Date: Tue, 25 Feb 2025 10:14:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] plugins/api: clean-up the includes
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> Thanks to re-factoring and clean-up work (especially to exec-all) we
> no longer need such broad headers for the api.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/api.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

