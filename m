Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4161C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Tfm-0000a7-90; Fri, 10 May 2024 13:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tfi-0000Zn-Ff
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:04:40 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tfa-0007fN-5r
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:04:38 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f2ebbd8a7so2403718e87.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715360666; x=1715965466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eFIsEVetxE9xt96aOQxybh+ry9ydyP+uuAhMcGZnheo=;
 b=KFCmBIpErNWDxSIt8tdRQGmvxN/Efn6jQC9741CdROp7yl37KY/UUAug/lsggnYLpI
 caHxc3LtfAoh/Jh6FsFOVEY1rZd1cqrvgQ6WlL0lQiSlDlIdBv3F0NbK7cJtRvOcXUUO
 KSuF0nHflruKrrWkLrSBamiFrbPmj/23KA24rlCqsMYjHDj53yVjBLERzyBkETYMUCVP
 rAYO+smuhMglTScgQiucAB7HNRRsGUeQdeMu7Dz2gpNXdEcPEjCG+bRDqgk2XoEkEGv+
 jV/SUOp3Z56ROJGQWFvY2xsBmb5XqJ8yBJczIfRPfvHZRG0C9glsTaM25poGL0otKgiq
 ePJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715360666; x=1715965466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFIsEVetxE9xt96aOQxybh+ry9ydyP+uuAhMcGZnheo=;
 b=ejoXBri3eLUTgVVuEhs6XHdSuubB1niBhNkOoCYz0C8OXcHq+z2X2k8K9bfKCttZGa
 HxcyN5ejAZB6njJK08WO8WMNxrIWguXBiUeoGpVSOs7P6/vI34A5rSZiofdTzOfwQvut
 PoM4XxvM4EKULzN/MTa+Hp7/h8t6OabVo4QPZWvyEnaeB/YcI+kmn/IzSdibJl4uDG0O
 R1kx+5RMJl1BBueMKgnjLEnQoJmVwvGXfdVubNhS1XjeMmXSV7a1z4dGw/5jBViakVkC
 hp0DdMKuoWCU5zG6wksPxRuXWqY6dd2HrQ60vv7oLZdlik98LPMS2apzEvXrB+LdlqSY
 LJMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+fkQkBY1pbIQqxH1g+7dWQDV80Dd4XxZLlwkjv4SjkXE39X9E7hai1q83S0DoqnAm8WZsjQnnETZcfaaxMXXFR4/ZUw=
X-Gm-Message-State: AOJu0YwRdYFtgvzANeXOFPvVyODvLkIGoIh+XPLv+0prK+Zayj/OvLSt
 ylcUaFYObvjBz0OOLjHu4DaTUoxjX3dsgDQouOamNP4mlcVC12Gkq96scAt8DTY=
X-Google-Smtp-Source: AGHT+IEefvOl3dwpS2oCHGWafv2laikxxQdi4q/ePATNDCGYEY+jsBeUfCwtYRjkv63UP6s3icdVuA==
X-Received: by 2002:ac2:58e3:0:b0:518:dfed:f021 with SMTP id
 2adb3069b0e04-5220fb749bdmr1695744e87.24.1715360665472; 
 Fri, 10 May 2024 10:04:25 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d2dcsm203158266b.44.2024.05.10.10.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:04:25 -0700 (PDT)
Message-ID: <7fc9662e-a1e5-4843-8a3c-dc63c33d6064@linaro.org>
Date: Fri, 10 May 2024 19:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/41] target/sparc: Implement monitor asis
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-41-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2/3/24 06:16, Richard Henderson wrote:
> Ignore the "monitor" portion and treat them the same
> as their base asis.

s/asis/ASIs/

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/asi.h         | 4 ++++
>   target/sparc/ldst_helper.c | 4 ++++
>   target/sparc/translate.c   | 8 ++++++++
>   3 files changed, 16 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


