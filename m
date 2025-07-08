Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A7CC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBE-0004Vb-VS; Tue, 08 Jul 2025 16:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDi0-0008GZ-Gn
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:10:51 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDhv-0005ce-2x
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:10:28 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-70478ba562aso3353676d6.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001819; x=1752606619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhWCRVHslwq6uQ1RrYD5pYArFASP6BrAWb7d3H68MWU=;
 b=TvZUoC+zTMIPiglERPDsdLtPm2HukKYszfjsm69rATkBs0IWZFeLktqIBIFFS1nY9w
 7bt5GmEpzLQNx1qNxYu4THBUBUAT0xgPwxVIVL1wZsnZ2RycAwGqPElDX+mXAoUPPvLr
 MhrkPQhY8vl69ccYQvE6LOp05ngEOBZsR7Xgnq855hHEaOFFqn39UZkM3/RrnTnngUbP
 /iEoezstcjyxWOD9hy3MFnHfSQDwdBH09vcMmbC83SRYkrEhAQpbGOMhl1YUlZHMx8LW
 gvHgdCsjOUi+eXOzKRehXjLjTYrgCaxWd6r3maQQn/h+bNH2QXqP5o5bd9w6sbgPPLwi
 FDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001819; x=1752606619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhWCRVHslwq6uQ1RrYD5pYArFASP6BrAWb7d3H68MWU=;
 b=GVohq3AmqGpBW4gNpds5m23et6qRTrUc2qzHNQZevWXdM6Ef+29PYtM+bnPMJuoj6y
 ek8YoeI0fLZjeHCr8cHWpswDt5Sr5D/fir6gz7f8ZHRNYJjO3iugWEU0zViXm2jZxg1v
 yQD7YHwcHtKs4rHfa6toftReYeH0bD58S0G0Odhkzb4PpW3LvoJ9Z1X85hAl+fpZD4HN
 5AacNs1UFzGgffJmZnVKakAJKE+j7zncD0GsCTIw9bcuKtfHF+zhTeBoyotKQ1OMhi7O
 VV7IoLD2RkkgAR/2dorqnIhbvrufzES/2XQ+rBwzCtwJkwoxZI/VlnV/WOi/vOcKuwfT
 zntA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4fZ7QYDZz1LVtk4OeURiz4avP/krI8tjt4Zc7UfgKXLal1iaIQsFWPGvk/7TJHCsDLwY8STOs1Sxp@nongnu.org
X-Gm-Message-State: AOJu0YxaVb9sGvm+ILAbH4uMIhsBA5R/dF5yYIDRaJMgoKSCO3SMRogS
 F48aylzSOeAh01P3vOjx5/Luhoh66BG7XHKKmFfjBjiTfwzxPY/uVW6l9MalhPfG640wRaqPYvk
 Wy8/z
X-Gm-Gg: ASbGncunaXoWqBEaXQ1ja98j/LW+cN6T2nAROWkptZRVgbnEQxymsUm5XqZBudUT4Dw
 WTPAowOMwdzFtkCPGCsWQzUd8oSnY+JOR/y8J5eTWoOBXDegd/m6DtUcOepHby5JeR47TzXaPG4
 KNjejtS3UaT27JmoxEb1/pixkO+TqB+4hZ46v6z5NucIDT5YRY3XzGAP/aUHWVw1lBA2g2Xtdpm
 /OKM0pv+1QStSKujRB7heIOziS7nOey2mBID1gW6Bt0IFjI54fJv8+ca3CRk+cHNI0NGToQkquv
 oTu0Ypb1hdD4zXARtRKn+AHs6KKnWM4Zw2+Bo+leFxU019IesRNTMcQHCgvcuNOM7s0EVITyj34
 =
X-Google-Smtp-Source: AGHT+IHn7j7DwtC37mVnuJxSAyamU1ibclONru48BAOFY7tp15B+Io74D//xDBie9Udp6k0JPh09yw==
X-Received: by 2002:a05:6a20:ce47:b0:220:1843:3b7b with SMTP id
 adf61e73a8af0-22b6640dcabmr5437329637.4.1751995905836; 
 Tue, 08 Jul 2025 10:31:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b38ee4509d0sm12056925a12.7.2025.07.08.10.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:31:45 -0700 (PDT)
Message-ID: <b30ca036-df53-41d3-9234-1f32070915df@linaro.org>
Date: Tue, 8 Jul 2025 10:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 1/8] target/qmp: Use target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf32.google.com
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c             | 3 ++-
>   target/loongarch/loongarch-qmp-cmds.c | 3 ++-
>   target/mips/system/mips-qmp-cmds.c    | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-) 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


