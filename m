Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F21CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10Vi-0006kr-BD; Tue, 23 Sep 2025 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Vg-0006kI-CO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:44:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10VY-0006Ty-3A
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:44:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46d40c338b8so15041935e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758624266; x=1759229066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0We0Rhabq8Wz/Cu7h2GK7NceKf1CQ0BwJAJBr3tJyw=;
 b=xEsbz8dHyixUsG1ZITLS7vaX4j3Nxy/ypEydyNYpHf2td3VbD+R81ZPAiu2shgcxoP
 gZSrAhYjf1TtBtKWjDJXWkO1qzNsrFjjsJIcnE+EnMf4iRNS4i90V3zXJgTY/EhoPJW+
 duGuVO60lrbcbW+ztZxOmeGbSJ5+Cu4RBCwoUEO5KESQFeN70DS1bLzXIK8koHpVFfG5
 OftPoFSuTVcazPobpRIUJM7+aDgaq4GS8nXseC1+mtA7i3q+0w9a7Jl5qalG0d92UcvE
 wSQ8Rtd3e27NGcngjc5tAXv0/rlA0VheMEh3ZJSGtDGpsPDQyFc9FLGI3YbmW59+s9VF
 aAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624266; x=1759229066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0We0Rhabq8Wz/Cu7h2GK7NceKf1CQ0BwJAJBr3tJyw=;
 b=dxRHQ/SEmYvTXCFnvKzYCu6SURhFSYNiysgij43DUe2GablR3VTOQWxixbsbpI3YoR
 bXrdE5wK+L3+uvVDkg09Qopai7y9Ub1pDD4ySd+OUN8yiJ0Il+ju5q0v/qsikH3P1eRN
 p8/YtOpZF5crL6U9oD15B2+3Y+IvDy9hnACGcJOwIxQK12CK4VGlO5omkjrbRrysPB9B
 cI/OEyju2BVVPUSid1acpyQy99jGB+KyV0LfAxCjo8tWWplthuRHnjAzXdzYg3Eh3yDa
 ++iHoAdoSjP5XYqlX03FYMUfSpZ3NoXDOf1oTACf3jtT+ynoAgqG1R9skEzIHU2oTvj/
 3Yhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgYenaM53DBW6zIaJt3RsY5fgOfDFXJ4QkVqr3L89A8XPyCatGDj/vfiKlCDPprFPQp7aVsycrrEvX@nongnu.org
X-Gm-Message-State: AOJu0Yy1YTyFwpldHjX1HlqzoUyJDrjCvy81OPg9+DoqIiGfwDs9C+Wd
 Qo8+ounpeB4BYM8a4eLDvKa5y3toOMJjNpK+48dEpc88KiaZSscZNKcbjAJDbeueckM=
X-Gm-Gg: ASbGncs8zoQfEQiUXUvxa81qyWux3BvU8UUfAlB0oPvzHk0qToP2RQZAAJHB/iR5UQy
 vAF97Uy3/qx3XJpDG3ZNErQEfyzQLGvLSWJ0y1Lbxghp3DCYElVLv91qQXOJJIwDmy5+AteBLk3
 tASA8i9m95IDcmaTQkesEutAPwYt0IczhD1wvER4OqZt7jE63fbSAYar0pzvadPIndbDP6xujrl
 gEKHQk6ywN1CPvi6+cNYiOw4e3Vxw7kv1v5KSvl7yS0Cu+bu2UJTu5MK7Ozw2wtcbwg+dS0+WrZ
 JEpJDYg1jLziy+Q4LEl5prll5RhLcGvrHRdErmd6jSGgnV8O5Iz9J420Di1w+MzbxOrW7zrehyd
 fk5FqNCjL55ZGlTBewXmdqNuab6mhmp/jk5wVCNWT0qkv59ZT08B5eY3sw34NigGmXeVr61uZ1V
 Iv
X-Google-Smtp-Source: AGHT+IGtOwW1fTFzJbp/4xMYYtvPuSFLmXkqMQ6mvv8+4uusPbIWc5JutUyvTsUXZLkyq6KKULq2PQ==
X-Received: by 2002:a05:600c:4ba5:b0:46c:fc4b:89bb with SMTP id
 5b1f17b1804b1-46e1dacaa24mr13147275e9.29.1758624266069; 
 Tue, 23 Sep 2025 03:44:26 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07411f4dsm23285070f8f.26.2025.09.23.03.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:44:25 -0700 (PDT)
Message-ID: <c577cfd6-cbcd-4ef3-b6c9-478d09db8be0@linaro.org>
Date: Tue, 23 Sep 2025 12:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/36] target/arm: Drop
 define_one_arm_cp_reg_with_opaque
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16/9/25 16:22, Richard Henderson wrote:
> The last use of this interface was removed in 603bc048a27f
> ("hw/arm: Remove pxa2xx_pic").  As the comment in gicv3
> stated, keeping pointer references to cpregs has SMP issues,
> so avoid future temptation by removing the interface.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h       | 32 ++++++++------------------------
>   hw/intc/arm_gicv3_cpuif.c | 10 +---------
>   target/arm/helper.c       | 29 +++++++++++------------------
>   3 files changed, 20 insertions(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


