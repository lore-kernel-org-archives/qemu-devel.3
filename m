Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B248CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urAVV-0000s2-TU; Wed, 27 Aug 2025 03:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urAVU-0000rC-HG
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:23:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urAVR-0005Cs-Vv
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:23:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2445806df50so50867105ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756279418; x=1756884218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QRlFArM/UDWpvqiG0eW4eiGKl8lUlVgAUfErF+E8J7Y=;
 b=L9fMxs5vA8U3Oj9SwLk1M/NLIMlVvwmf/rLKFCmaacTEsnE4PCX7JvuUeOhZ1T5hkK
 4kjYwZl/HfSDOoWpSyQ/K/b0ZI16KIH0VzlS1Xc7Kspu1gTyVH7JXUVxOgiagBoLazVK
 vk8/ijkNS2khK/P20j+BirDWjyJffUNFIS5xsHU/+drT+TVr4wL+TpiIKewjJ7qNuUkH
 xMeDBoZLaY+JNkxNzXk4J795GaXI4jo2q4xNVHdlLusWJCVaVZEs2vxhlyvS6orM0CFf
 L9bt5m1+66RjSaRBJHIPab+WIvg4bsbWPOVm9z6fOEiUyLTTo04mb3zcXVfbtdb6tMFR
 3ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756279418; x=1756884218;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRlFArM/UDWpvqiG0eW4eiGKl8lUlVgAUfErF+E8J7Y=;
 b=AQ5jJca8R3DhLaKLTVef5QzxKwTKpfVf75EVk2ixB+s9hmFnbx0HuUZ5AyX6GqO7Dk
 VEnjFpAwK6ch9KbIMTgNozNi9OhgpgQUKgYibNYyPUGfgoZeraVbpRs9oCWL8dHB+/Vt
 HCJXn2VH6DU0Onc36eR8XlDL8YxcfWNdumOsGggVMmKVRihkgFTBcknJjWjnTryrgOJE
 QDWIMpmCM9Y+KQkJ/Yt/1isAptkzteddQiNVf3dR0l7eQfVObYqdJDBz5nxNb/v0T93H
 6xlgn90ofRBXvcFaJOoc1ctYhfi5RJ/tmLxaDRFfERnH+axhmVXPK6fP8ACQuSiO56UD
 Y2FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyXhAKZLHocS0XMa8effzUREmKms77lBKXCfw74y1XXJt8XHwoW+RMjfVIUJruHuh1K1RtRntRzXCt@nongnu.org
X-Gm-Message-State: AOJu0Yw7bp5iz2ZQcurH7CfJiqxa14vRgG3BVumgg9qp5DK7TdBZ8qvJ
 YtQcldm/g9EhQDzpPr9/QD5qMf6zatVAnxGKb5+V+XeoT4PYluslJWQfwA0NcI8BqUE=
X-Gm-Gg: ASbGnctxet5Y0I1EIQUuwIWdcQQn1KADhs8bKtb3SHalWwTOaomqpeP9FcoUR35pFyu
 ZsDLaB9QnL9DZK9DZR4OyjUb2YXN/XHvWahM2X1YOHyg1uRi8ePnIFh6s4dEpmK79+2NKiIvm1Y
 Zt2gLooX+GGMTunGD+JrPPy/UL8M9+ILVmKfi7h+PZjR922CJSA1ooe09XQCRL38khY3QGYr4gA
 TuDtXHazL5w9sSUmOxfQlDT+++8VrD9AN0dk2x/KxavjYyhIn9Z/0XQ1yYLByrUN6tWdv57f88/
 ezBXEqrrQXWRHLoDwvQy7tCx5lpIuawKLmMiBGQhcddD59glmnO4sRrXdqnDfmvq2v9v4aW0lLg
 M8z1GWRuGvyAftpCpBlvtJ3WDOEjB/y1+aMoO3yNrzz4fhso=
X-Google-Smtp-Source: AGHT+IGVDUJpLoGGIxywyD4WKRU6ulwN9JdNvLDgnNjormuSm6GDJp9FdV2dUjS6aspd5EIz/5d8wA==
X-Received: by 2002:a17:902:c94d:b0:235:ed02:288b with SMTP id
 d9443c01a7336-2462ef40318mr226377535ad.30.1756279418392; 
 Wed, 27 Aug 2025 00:23:38 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771ea46b3b7sm6705489b3a.57.2025.08.27.00.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 00:23:37 -0700 (PDT)
Message-ID: <4adbfd47-5108-4ab6-9d52-b91280c3460f@linaro.org>
Date: Wed, 27 Aug 2025 17:23:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/ppc: Move floating-point instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/19/25 19:58, Chinmay Rath wrote:
> Chinmay Rath (5):
>    target/ppc: Move floating-point rounding and conversion instructions
>      to decodetree.
>    target/ppc: Move floating-point compare instructions to decodetree.
>    target/ppc: Move floating-point move instructions to decodetree.
>    target/ppc: Move remaining floating-point move instructions to
>      decodetree.
>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

