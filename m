Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E712C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SxA-0003WD-AX; Mon, 13 May 2024 06:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Sx8-0003VM-OE
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:30:42 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Sx6-0001xP-Kk
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:30:42 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e3e18c24c1so42113301fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715596237; x=1716201037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QT3EtYa3RXHw6cGpIVn+n/8tHbo07XgHGrmSVhozY/g=;
 b=LanhUZE+YRuzfpnncgmSJYHmb180F9rsadLfTADQavBlVwOFllLBshLh2D0atIOsK2
 F2F2G0GHMU5qcVYTsqyQP+viQ777CYuXCJ0ge1su/8KCnVy3MlEXIrsa7gyX0qASq5Rn
 yPg9U93+t9itvCxBiDFQ7X73KKsLjPtwbGcwl7LxnwYJonMScxwPJBzlP1z+uUgZv0/I
 7OTcDtk6PZ930GBJ3f3uNZ2NEVHuyClfm2E44Z17gxiPcdG2IG93BV1EmnYDOD4MiWRF
 x0mKEfvNnEgkHNFw08fnxUZpVvsEmA9zMria2oJf8PQHe7mLgc7DfaG6mgaRIqdUTbwv
 brHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596237; x=1716201037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QT3EtYa3RXHw6cGpIVn+n/8tHbo07XgHGrmSVhozY/g=;
 b=DZkzNSd61RTk/fOj5KqmVCjwJI5tzAotXJ0NzFC8o4E/EISYwQPgo57eGrfKAQHT72
 fjTfZ9p69jdty+8z2woAFNaioLd94ZHes1C4QTXVwqOvPFygmIOxmkubeV45Qx5GuE/k
 2E/Ymvm5uI1LyPYZvz5Nh9gMBLmpWXuu57wK6CP1VXPmV3LYdFATcKn1fGM86nVKi/N7
 QcrzPKT98k50dmE3d0O1yYVgJRoDHnLatnawRcYsmk2jzIRjuXoBJ81XUhs20UwlA4sf
 slteOfN3FYjkV3U1f1SvqJ38b/JFc97WFzhe7dsruah2/5xlI3UCzrRs+6Wv1Xs5i6yq
 0Jzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsefpoJvkwnC/skTWxvUVeMXojX0BIKEA3ewzATxQ+vAgVPAMyMGzERZeS+W0zYjzuXS6h14TSJ5zCs+K+ZI1712JHVQ4=
X-Gm-Message-State: AOJu0YyDKUEgiCy0FwGTtsZYm6za32E6Vj1a/P9Yq4HI/1Qr94pERHMF
 cgyUbwJiCrLqyq5YiltkdkG7XJsmCpMzshxOmI350yCGq0ob3YD/TZZhCSNUI8k=
X-Google-Smtp-Source: AGHT+IGYlpZzIAp4B3ISAPVhwoYY/+e5Cs1z2KS7YJgXO0XxcO+tl+Moewq1Nd4P/jWebme2gCJp0g==
X-Received: by 2002:a05:651c:1542:b0:2de:7046:b8f8 with SMTP id
 38308e7fff4ca-2e51fd2e6a8mr90970571fa.5.1715596237445; 
 Mon, 13 May 2024 03:30:37 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe36f373fsm131737615e9.20.2024.05.13.03.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:30:37 -0700 (PDT)
Message-ID: <9ffdd3d2-07d3-4af6-bd40-b36c0fe997f9@linaro.org>
Date: Mon, 13 May 2024 12:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/45] target/hppa: Split PSW X and B into their own
 field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-36-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 13/5/24 09:47, Richard Henderson wrote:
> Generally, both of these bits are cleared at the end of each
> instruction.  By separating these, we will be able to clear
> both with a single insn, instead of 2 or 3.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu.h    | 3 ++-
>   target/hppa/helper.c | 6 +++---
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


