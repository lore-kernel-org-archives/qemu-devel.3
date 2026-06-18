Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE54CCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFlU-0002h5-Uh; Thu, 18 Jun 2026 12:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFlS-0002gY-T1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:38:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFlR-0008Ub-IC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:38:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84540eb70b2so564920b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800728; x=1782405528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpuG7e4oqxaSqCsh3x5flvcG/4AeWmxle7R06GM6eOQ=;
 b=dsQ73E+6U9EtqeMM4bDwDP9JjGlP8ORwQhkBOguhWt73+xxfyS3VUWNxWd4LEO1X0b
 Vlk9V99U4+JHDT9Qc5M2PWLu47FI9gNZt9uFb73CBjqVAd52XQdbU03j7lHYt4UdoFfx
 eUvibVW5LAmeAIiI+X/fnsMcTqBtrBrFFz7hsrpFdQ1A0qWtdC+46VgS2nz/T9wF9Nx2
 ykpUFU7bcvoyV8vnENSVraGxaJ8//cS59NNtOSgLcrqJMSLS874aF5S2b8yjMgdVrWXM
 PWdQ7LbB/UL7bZfSRCaUnD8xrzdltg5LYks0jkhN7QdEuYBO2SmkQmdOqjJcYBiDUelo
 PdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800728; x=1782405528;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpuG7e4oqxaSqCsh3x5flvcG/4AeWmxle7R06GM6eOQ=;
 b=Ik+A8Cnv1Zv6hSxCT8FkL7zvNjoEZsNH1TasJrmowqtZGCKfmjS3/iVBKwK5l1LY/a
 wMOxWEX6qgoJq57IeQq/Q58RCXQeAjoaHyajQ/zxJ6HqIb+1coDvQTcWAeNXgKkwmiqS
 0zaznRjIejwcbZCi9SnWJZ6HxvbvAYHFrLw7L1LmcUvwyqYoF/sjbmmgSCKSnQ7UhWQx
 GnDHPsa80GyDLeIgCGYuUNSwNP16KBUpqDcDvMOfv7B1pQywbUJMJeCZADskEKaniSmM
 LAhRSttSezOpTISk3l0K/qj3+Hb6+OyyxPRt3GVbZ3gl0GPSYSGLS+h/xuXIs0/QXv5n
 TUdA==
X-Gm-Message-State: AOJu0YzgY5BhRDcZ8/2tT9fmgTezfaLkLL1bKR+TcP4CIdMce9O5VGow
 0VrPxdIWkVtaYsR3A5xRs8jifU44xpbZTJuSYppD+tEmDH/lu3AB3SbVthgYq1yJChKRCCi1MQw
 yYHQP
X-Gm-Gg: AfdE7cmjfQ0GzUgG5XT/AHAR49eT+x3fMgRwXhmDLwvXpPHLSjGzoKJXcVUFQLTDRzI
 QgiOOYC7jYiIHpyM1c3GlAh5yfIAJxpbjtpjb3oBzKdcpwKJ3EGMVOCzJgIWGLcRuUPC74/XrB4
 EHQ2h/X7h2Uv+Q6CXfyQd1n1txgbTuAzWiC0bUPyQkRaqQLCmjt6wFUncJPEoxWkXeKs/bQllDV
 /KTOP7JTFMsqVT8aA4v4PPFcthDrsC09z7vqCZblfZ2i60H+g2/5VtYcrwyl5AAlDoqOQvd88Uh
 IUuJBNKBBEXv/uTgkozDzheabM/0BQmAHwVTSq7FR+iI0TX3D/9EixknQtBBH2gNgSC6netJpLJ
 8jJyAW5G+4t8fVho2+jKhYwZwZTaaHjL5aORnDjh1OAQ1zeD20NCC5lpxHaHN+FX5H31iUU2rE/
 wBYi4ZWaWyuXQuaYXUs06iXWaooCNRzID1XbCZYeH9l1irATKP4ZhLm4GLuQ==
X-Received: by 2002:a05:6a00:124d:b0:842:614e:cc9d with SMTP id
 d2e1a72fcca58-84541d58880mr3833585b3a.27.1781800727726; 
 Thu, 18 Jun 2026 09:38:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accbec5sm19917726b3a.16.2026.06.18.09.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 09:38:47 -0700 (PDT)
Message-ID: <9f835723-8f9d-4364-9918-59f572b707c8@linaro.org>
Date: Thu, 18 Jun 2026 09:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] target/arm/ptw.c: Add Granule Bypass Windows
To: qemu-devel@nongnu.org
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-3-353e546067e7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260618-jmac-gpc3b-v3-3-353e546067e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/18/26 09:33, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   target/arm/ptw.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

