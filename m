Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB1EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE4d-0005m1-2W; Tue, 10 Sep 2024 23:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE4b-0005VZ-5l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:31:17 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE4Y-0001OT-VL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:31:16 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d8a744aa9bso4001556a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025473; x=1726630273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J5lyUoSNMtupvnJb+6CG2tyexjeol89leNe2/rqrwzo=;
 b=qxpsHBg3I0dKaWKILMUo2SPkj3KcwLp32+EeiDbWj98AnHnmYg1Hyhafpo0LXfin+k
 OXzMlIXKDYBDYGKNq2+BzC1BjPOJwVUFjU9VzirUqgakQOBRwRXuf95fU7rfAywmzm2J
 iihp5M2GogainPLDR73VVO05uoCZ4s/p5uRT7iGTKP4cQtNPfNhBpbERyxJITEfPeX2V
 /jTbiDfkdOy/Jw3bXkMbiPyWg8bB+oR1DfUsJ70Tq+lbTsYySuGpH1hZGQ2xY4I6Gz2/
 gJ/rZQKgsv8v3l6J1JlcBPYEjmX8JNn9sKNmOH3otjmbNrdPOCwSoMYTL498Mb1B7L51
 IWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025473; x=1726630273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5lyUoSNMtupvnJb+6CG2tyexjeol89leNe2/rqrwzo=;
 b=c2NTwRE4UAU1RfYk+P8VlDxdHug9iCTFu04n5oboOmhSot9ZNZ8NG6HQjfxEjvpv2m
 vHVAniwqJk+C5Ve+c2gGH0L+OzkkhL1klumYuP570zspN2QNTdE9FlF0H7mPf6nmje8S
 DYEG6CYP1lnS+fp9hVHzxTaatZsn02RTfAHMZ8WaaoBUtimLPmrGWh3ZcP73qJ9XtGON
 Hfpg3fko/PKe7viQJLHzJUDTKyX5oFJFouhsIAELyusVVD5Jfx+xDiq0bJ3oPVlWqAsT
 9p2IDvxuvqwZJ4RqP/LmdtjAwucfTaEMjzBDO9Ld6nW7C731QEhnjZOy/YDOi4w+s2Dc
 7MQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+z8ca0kPwv/NzT27xkMkpvopthBeY2Zu7FrVjM8bKovNcgaZdYrmWVig9QCNkmvI7cEKeQZTp9io@nongnu.org
X-Gm-Message-State: AOJu0Yz40T5rKKUMHJa+LTEHkbg5gRlPGYEY37M9IsjC+nzELQK8qfnb
 T2PMLfOQdmLzStvrW9pkQZeCvmasCzdOrD8/aNT+N+C49GLVhu3KxlwMbkqM0zI=
X-Google-Smtp-Source: AGHT+IFs5wqqcjp3ZD5n/RsBQBYA5MPDBh0M7byd4WfLYuqA8yq7sRyRpKbQGrNycBWwIoANaKD//g==
X-Received: by 2002:a17:90a:eac8:b0:2c6:ee50:5af4 with SMTP id
 98e67ed59e1d1-2dad4de4d4cmr14825425a91.6.1726025473583; 
 Tue, 10 Sep 2024 20:31:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe471asm9420557a91.9.2024.09.10.20.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:31:13 -0700 (PDT)
Message-ID: <de263572-d5c4-46ec-9dce-5f2588ce39a7@linaro.org>
Date: Tue, 10 Sep 2024 20:31:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/39] hw/misc: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/misc/imx6_ccm.c | 1 -
>   hw/misc/mac_via.c  | 2 --
>   2 files changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

