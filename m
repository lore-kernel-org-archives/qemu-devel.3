Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E623C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZotb-00089Y-TC; Fri, 02 Aug 2024 05:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZotZ-00088R-AW
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:48:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZotX-000662-G7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:48:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso71868115ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722592096; x=1723196896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyXbJajJbGZroM/TtRn5eqWOwHNX10+Vdq5dPkdeSWo=;
 b=L9l8ZBZ83hugGygSzZ5A+5WvRWKU+Xu9YKWrW2trk5dUpJv41bPUjSVw91GJr9WPlS
 i0nZruECVc+XJMVAKJsUDhAUi/5oXdDSg+wbVVidni/Iv8AkCcZ04g5EmQ8HdWCGQTBT
 wSh29TmuZbYzkHmAIftVfUjRE/XF5DfcSwHJIO4+6A4jgzKzbjMyFL16K+3fI0zuiG9s
 Ezd+iwfhJV68QUuEiQnf+fcYv2Ro4Vng2HoLg6H3XXAmVrSE2hbtJpoa1hP7A2EL93yL
 m6xratkfJp2pXvKaL8AUstP8bqsJ00RarppMnlAVj5IK96tZGcQSitm/TH7zjenJFOwc
 jMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722592096; x=1723196896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyXbJajJbGZroM/TtRn5eqWOwHNX10+Vdq5dPkdeSWo=;
 b=pa2GEC1wfzqcS4/nDmyWU3zwlUt875AdnN0fskXR/2n4CgDX5eNIGxzlU2SKEeHurp
 +VPqn3x1IBGjMC6ngdW7nkNQvtlnIwEaI2x9WXOlHInFSkxKxaG1cqBg71kEQdUuCqjC
 f5gMJbEWyTe+3P242RyMrqf3d/y5FlURy+JR1J0RHyQMg9ubAlSM7U3bYfsuipy9jJ8W
 dym/n1NKuXjxPyDvhT6fjbTyHv5dyjhNMTY9gUS9HE0pyvdimgNJfQlmL/987vBlXtDM
 EeM2/HQE+xGLBZSc8JpXe1MhIaTJegy6d/8y4BwVmfVVrA7w/9FqGodYs51oUv/1C7VI
 F3Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQiMvz/Q7MnKysCBp0pnn3LoOnfcIGQkP/FivPUMVP/sBnlvH/C+/Cf5Al4WsMj2+1PBd5m2hahL0J@nongnu.org
X-Gm-Message-State: AOJu0YzyCKtRauIkHNHGnjGMKeGKK/333XrtkjxjkyPt774ZrkDbJMKd
 SZA0hV4N0vcJ81tgefc/vsWOIDUweHCEW6zCDzK1wp1mtpsVceYFzNk/UYRT21Y=
X-Google-Smtp-Source: AGHT+IGBOlwCm2mDADiPA7gioRS5IHMZqj6rIzO3xb7Cj9doFazdeG4m9TNNcj1L8Dv1PMToGmbo0Q==
X-Received: by 2002:a17:902:d502:b0:1ff:4fa9:1434 with SMTP id
 d9443c01a7336-1ff57258aafmr42915945ad.19.1722592096119; 
 Fri, 02 Aug 2024 02:48:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59059f9asm13019375ad.131.2024.08.02.02.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 02:48:15 -0700 (PDT)
Message-ID: <01fe2ff5-d630-4608-9ae1-cce62f290594@linaro.org>
Date: Fri, 2 Aug 2024 19:48:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Net patches
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240802031929.44060-1-jasowang@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/2/24 13:19, Jason Wang wrote:
> The following changes since commit 31669121a01a14732f57c49400bc239cf9fd505f:
> 
>    Merge tag 'pull-target-arm-20240801' ofhttps://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-08-02 08:18:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git tags/net-pull-request
> 
> for you to fetch changes up to 64f75f57f9d2c8c12ac6d9355fa5d3a2af5879ca:
> 
>    net: Reinstate '-net nic, model=help' output as documented in man page (2024-08-02 11:09:52 +0800)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

