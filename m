Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED226C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WWF-0008VJ-Ky; Wed, 23 Apr 2025 05:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WWA-0008SN-9i
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:35:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WW8-0007ly-2f
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:35:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so6178821f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400942; x=1746005742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jHBien2Mb5HSrt+t1XcEEZI+dcEOYuI9Pa/xLHs5+Ik=;
 b=VaZAmIolTqaLL3+wAygqmDuI3dBoNkr2hFbuPvumcQ9+nDLPs2B3BgDdoW8iG7KJti
 ADE/lLqvhNXDZzVTNcICTMmfzVN9mqSSDfLO8cGBbCAGJMpaAUkA9CnzkPjzolzmjpAR
 1LtqTgt9DpjOunfoi9C1LarYDCutoSzVbZCg63n+e1Pr9ojm4SyluoeJe5nUJ1BF3l/n
 +xsVLjLr6RlsRCR6pVeYX3u6g5J68NFipoejnL2AMlaJnh0tvLBKRDyFBahje4nrCI8x
 c3bFw/2Y9KJrvcfbtaHMnRlvwWL4UCbn8VLL08yjkjbzZOuM8HU0JMKre6WslfvRwhOq
 iiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400942; x=1746005742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jHBien2Mb5HSrt+t1XcEEZI+dcEOYuI9Pa/xLHs5+Ik=;
 b=WaSvkBU4X1VO4HgIrkx33/6Fa5QmOz3mYIOKrE9NBnp/pASI2h2REHUx9uYEvdpUEr
 4J+p0+lrNblsBb+wPSFWk7ef7mso1jJDwdFaDK7KTlMXd/UtMjlJtcvPZktjpvbbO9hK
 weZciE5Wfmd4r3UyW851sVfRWR3DxS/2zMtt0RjqqmvAm041r744rk/qGywSq+hOkss/
 11bU1K4+41EI/OuZ/e/7aRXTJ4b/wGRLy6ka40rLmgyQYVy39WmdmNBnduAAVdrB0Z7d
 B9j2PsqFhBa5DckSsH50NYaHTBHSFxW4zrwO7fr8OSQNYSSoEA3Dy+steDiyQDy8VEXu
 +IjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+2i0gPp5FirxttKt34MqOzeDwidpqwVEdyBlVhNY4oYzxrfqfho6xBtYaxT0uIPInfo+AiSdyJJ6z@nongnu.org
X-Gm-Message-State: AOJu0Yy/Iv5oDyqsHRRaCL2YbMs81LGAgXjMq+SJifFDxSD6ZEDRh69W
 gHyw8tZc4eSAEyQ5WZOJAVqE5ox0lK81Q73gG4s1QJGw3BK03ew4FIGBUtN8E7z+R63x3dDfH3A
 W
X-Gm-Gg: ASbGncs2TRk80d6RVeL32Ul17vmdBOjDUK1gDuXfwuR/kS4ofg8zi+Xyn00SeLkn11a
 Tng5fyQcxE2zZXu4sr9kC5RIzrmrRYgyk1UGm3iR6r6SlTDgrzgrM8aCmi5xGtjQgg1WlEafnGE
 SOhAckoFspnanFCnlEBHifa4sUFypx6RE4rlnemhbEfxv9g3me1QmjUBI9mj7PnP+Ex9Oi2GTNh
 k5J46jTQ1FBY45P92sa1vcVdCVFISsIWsvZToLY0f8FZJGoLOSzGI6pQNjkmAhjTlbAzDEf0vfb
 ag8UKoulQN66jQgTfVVurtFI2lPZW306QW7/w4jKJb2NW6Og7UEimD5nGrgLGita+SuwRv2qHvK
 g8uY5+POewE9BKkg8gjU=
X-Google-Smtp-Source: AGHT+IEH6UstsmlSbw/ZqwSOsj/Q4UxcLm4CO9XbsRmlHcur2F4ZNnVR673AbsAKmDpJ0Fq4DA+bKQ==
X-Received: by 2002:a05:6000:186e:b0:391:2932:e67b with SMTP id
 ffacd0b85a97d-39efba5f471mr15532955f8f.35.1745400941939; 
 Wed, 23 Apr 2025 02:35:41 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433354sm18459419f8f.32.2025.04.23.02.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:35:41 -0700 (PDT)
Message-ID: <02ddc89f-f27d-4c9c-8839-3d501da16bab@linaro.org>
Date: Wed, 23 Apr 2025 11:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 047/147] semihosting: Assert is_user in user-only
 semihosting_enabled
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-48-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   semihosting/user.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


