Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6C5C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6kH-0008Uh-3i; Wed, 16 Jul 2025 14:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc6gI-0005gl-MC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:16:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc6gC-0000K8-ME
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:16:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-237311f5a54so667105ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752689790; x=1753294590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmXkhU9cXb7ZCQ3ywq0ZeSrFAdPVD8d7qeWBdr+HihQ=;
 b=WS3BtvnuYXrd0HEwKeH+VhilccEtUO0arxd2zgW/TqMZ5JZgFmKG4XdSpp2WB84SNZ
 qeF2xC58qDscWmyT1aAI8gR0z8HCO9D1uEhP/jZYj2zL14RbjA/nBL4HweVFzCsP1sPh
 voNT/l4eQeOIZT3oXMvPHbaVr2evi8VRsdmmc6DDiV4JpNR7a8CrxD4c4VZA441N/AwN
 A1e13rRCWB6t/tuBQdIK0/0xI0kNAcnLYiZXmqRM7pJwdcDvcXuhEw4tgBmrGeizM5CA
 WcFsue7Kho4WaS4rZ9JkJtApakEW2PixLmyqVu6/LIpnuEERGwXHJhUF1EUJcsPpedNe
 SkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752689790; x=1753294590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmXkhU9cXb7ZCQ3ywq0ZeSrFAdPVD8d7qeWBdr+HihQ=;
 b=edoMelco+oWvzBvr2QVJ3lHNd9xjyVakyTYg0nNd5PKzgHs261DRnxkJml8vn/xp5X
 rr8RzFVMZMYqwd3DGpNjSdmna7neofjF7woO0kWfasQYSOjGNF7vYElVzbap4tmowuIi
 NAr6B9Qz1hzysKNfzROJE5CaQs67njdJPhUUVaiorN3cLrLMVWS42j88aOUL4wtBKPkG
 IpiqmFu380RBX0hW81pSbDhPL5gWJ93J2bAJ1fMIM+BTzOTZZohNuVhU52rF7/Tpgp69
 Lwn+QobDmMTa9cpWiRPSUrIS8s9ZgEdMNHBRA62M6zRQbfX2xhaoXrd4sdKyqqVlC6X3
 TQqQ==
X-Gm-Message-State: AOJu0YzmFTmzMX8HcL/yoKyB0YE5LOAMzHClaigqY+IFeenHe5dqQeAM
 4CkIC/Vgb0oEvDNnHHZb3aacGJet6Y+bDl7Lg/mXeL3cGBHTIT0CK733bfiq0HlEXWE=
X-Gm-Gg: ASbGnct9iCT3R3kVyC0gDJj62V7pvbWTiofJPE9kouJmdaMS6f0YmsQNojmvf7T8IIY
 BbOS4pHrVHNCn1lAZIRapzNab8vhUJ86Iz2ZMbCnrtywoH3gfvwyD9EQn6xZTVndkYDXeiJTT/V
 9eL5a1qXVzmj0Io4OzMDlKoht+oZYOB0ChHIpPArhOUZchiSUbjWphVCHs4K+9v/RXUQSWQqB3g
 FZCmlFzhoNc2D8c4aYchAlUGKoXTM4ERSK/4C4K1KXeQbTp8wipvecWA+NR+yMZJ3p+POyghd32
 Fax07Az+H5nV26cAiOV9Q7igyLnJkhDApDxGAk/PrGl/ZTqVcDSsb9ERPIg2Q73WIciJwaH2X+m
 QBjFsulnjujwhDx5SZqRYUH5Ij45vgfMH22BtHkFYe8tncQ==
X-Google-Smtp-Source: AGHT+IFBjWJ9KvGODVlpl1Kb9GO6QsZQgWAL9j2b92o0if1VE9RGKGMSuT13hM2/VLmzPUQsResKdw==
X-Received: by 2002:a17:902:c944:b0:234:8a4a:adac with SMTP id
 d9443c01a7336-23e256b741amr54178435ad.20.1752689789763; 
 Wed, 16 Jul 2025 11:16:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ae9f5sm129174945ad.66.2025.07.16.11.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 11:16:29 -0700 (PDT)
Message-ID: <ddbd0892-6ce6-448c-9a86-df70133e69b1@linaro.org>
Date: Wed, 16 Jul 2025 11:16:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] aarch64: update test images with new trusted firmware
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
 <52c5ed4a-0225-4360-b1c8-e3866041c4b3@linaro.org>
 <1de7b0a3-846b-4e7b-b4a7-1b753f61ad0f@linaro.org>
 <CAFXwXrn3oUHeo=h2OZshZj3C24bf=tY6Mdz+rDX4YO0MAk70xQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFXwXrn3oUHeo=h2OZshZj3C24bf=tY6Mdz+rDX4YO0MAk70xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/16/25 11:13 AM, Richard Henderson wrote:
> On Wed, 16 July 2025, 10:50 Pierrick Bouvier, 
> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
> 
>     Do you plan to merge FEAT_MEC for 10.1, or prefer to wait for 10.2?
> 
> 
> We have missed the soft freeze window. It must wait for 10.2 now.
> 

Oh right, I thought it was end of this week, but saw it was yesterday.

> 
> r~
> 


