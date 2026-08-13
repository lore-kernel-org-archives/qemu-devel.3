Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7769CC5DF74
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXFy-0003M5-QA; Thu, 13 Aug 2026 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuXFs-0003Ln-2r
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:22:04 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuXFp-0003DW-Iv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:22:03 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-973b676e5f5so587322241.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786634520; x=1787239320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdpLrUtjks6be8ldXCjS+Ky9H3ZhmiPin+lKOFyYJT0=;
 b=KXTfAFNrhsERVnfXaXCwEkpf9wyCIYGAB2EQeEGNJmD8rDfzEsZ1AUpoXa4NHQ4rDf
 NrdrrhZ93QH/EPq6w0qPisbqAoyMSXQO4+SrixsHI+OM7oey9zGyHZzPCfieENYzSrzB
 j+cEmZcoWq/SiNndx066ZAxaOEBNRqspXimXYbM8QKnOIlrZmKBq3h3IAg0Q7uwOjMhl
 NabL0fez8316h9y3o5V0O2/uEvfF439QmxC3uZ+N9qVPsMtxC7V2Gh2otalqgosswafx
 A0WK3gCgJuiTdizDqrO3jq4vjGrfu5faSWARZaLDhextAh16l720KHIYOZorQxcnfc8D
 nJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786634520; x=1787239320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LdpLrUtjks6be8ldXCjS+Ky9H3ZhmiPin+lKOFyYJT0=;
 b=BoScBEYY/rSLpQjxNEPETOUa0GfTbMNJ+t6Fh6yV6gnmKNVUpeaAQdOu/JENT0FFi9
 yZ9cMTeMSV5u9yjL9pByD30qQmNIso9a1Dv/zhHmImueQLB5lWLK6y/kJHOA6cA06boV
 18DKKds+YaspzZNYJnDUyaUqIt4omJlnRXX9xcC8qrSTWjXZPV0dvFqHXAHN18jp/NLh
 FMd9Xb2KOhkS87heuGxqKdYoXYzx3+KLNfQNeq8fdYV4CWUorwMwYnUqur1UgQODvkK/
 CTaPHRgJ6QLE61w1axTp1R+zcv+NGaV3m+xGlOBNzetyGaPd/Elh7qXYbX2kGLVJ7Gj+
 I7OQ==
X-Gm-Message-State: AOJu0Yw4Tt4s2P4VPd8AXNm2rtnX+P+LdvvJoZCUJsaWlo7T+xHUpGjj
 8Y1BtzFMe2kEkYoG0K2kzA8BuzStlbe5RIp+8CJ/HpfMi2GJNhVrD/H7vXoNsT1bhvnkz0Pv3Ll
 r20mU
X-Gm-Gg: AR+sD10g7hjAUH1SUj+zTxQbm83idI2NBy/QYoktVyd4iPyk8joGBgz7k4TztTwuoHA
 9vbPoQmMPs0Mk7/KLdJbnA6LiDD2aDoTC5x1IAIUNHtTbCuhml2Lx3cl3UMqZ7YO9dAnhqt7jho
 YANZ4rIyQ3MoAcEjWZDgwthnnYKxM9qDOZSqDq7/zamqr5aCm16BokFacIFS9OfzAdJ80Bz2KWJ
 9o+7teDlwzMyA7y2swM0YXOHvclFBW2Xnkj9llKE0lwFJBMeabHt75f+UFbxX/182AK6fVPX9ow
 ObXJnMyUKZb7VnQr/+o0CRjvE6xAOaOrIQL89NcYUcXz7UnYGxN2PGKtYq3kjPhyCPUlNXqBu+M
 oVlUMPV30ca9oBBkVp0S2/HSMX0irfc7EggjfhkzIAfE05t7k2R4lAbq9B+1ZHLa/hLOrnM18bE
 WssvYVeRNiJF3mzUwop2CiNqffn2szWSVgId+TUQSnKIE1mbuwyO3tsalvo+JFf/8k8xm6ND4fX
 dqRZoUm6VzqrokQSr82IeCXKr7q
X-Received: by 2002:a05:6102:6d2:b0:737:2ce5:7b2d with SMTP id
 ada2fe7eead31-76db7490142mr1856682137.9.1786634519577; 
 Thu, 13 Aug 2026 08:21:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-76efa511e39sm44050137.8.2026.08.13.08.21.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:21:59 -0700 (PDT)
Message-ID: <64be15c6-636a-4e66-b936-1f7c0d6db254@linaro.org>
Date: Thu, 13 Aug 2026 08:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] loongarch queue
To: qemu-devel@nongnu.org
References: <20260813034052.79094-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260813034052.79094-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x936.google.com
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

On 8/12/26 20:40, Bibo Mao wrote:
> The following changes since commit d49f87606ac1a6e15701b26c1b16c5d7e948ffcb:
> 
>    Merge tag 'linux-user-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-08-12 15:21:53 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260813
> 
> for you to fetch changes up to 77b91aca6148fafcade41516f12a3309f1e1f552:
> 
>    target/loongarch: Set timer tick value even if disabled (2026-08-13 11:34:48 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260813 queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

