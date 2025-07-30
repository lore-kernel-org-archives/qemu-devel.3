Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A46C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCcP-0003TT-Uk; Wed, 30 Jul 2025 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAoB-0002Re-RH
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:41:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAo9-0007aM-Mn
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:41:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-240418cbb8bso622445ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897300; x=1754502100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XaCAPuFpwxlS0x4PnpRe/XfO6P6segGrufbdGIRSJE=;
 b=PHcTte79WbbFKHKCEIXdyVyYf2odhsCsRrQ3uDPUans9baNGSHRqYgW1sJJnrBDtJu
 5HVbOzNQbFZfNJbaAk5bgqz37SMCyRpkuH1paa/4Rf6EUdkw6oXWCsJHYmBIOUiYjuKl
 jwdpv5sJaXccnAnyk2is4KyULSP/TxKftk6n82Hkxc+S5SEUD72TaJNinZ+23jk/39e2
 ++QMt3LaoWgFALxWpcMhaDQeuh8GXimivQ2+SCec6KpfqofUybJrIFwdBYKvGaaMspWk
 ZIhcYSApsrSjo+P/f7Afg5MhZFDHEvo/rEnE4o+CfKiJUpCa68OE/NTkeNB4e1MGXqMb
 c76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897300; x=1754502100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XaCAPuFpwxlS0x4PnpRe/XfO6P6segGrufbdGIRSJE=;
 b=fpKEcOutof6aQkUKKejT+UMuLn1Zhgf1mmZdAQ+zU5kLGvFx3CXycPtgPKsDgtJEEO
 Sy23mRo5jqYV2I1slPZgEOOurcfNboWh0ZZCugV2hL1JYoWpxOmZVzWz4lBsA6uhBpWi
 F/XTGJCf7NyYbd9vViUhNh0KEC8JupVPKlcn71kMRPChLVMggQe94u8gMeC1GsrcCAFc
 me0EiB7hjUFooURwzE5Ux9lMCyP3Dbkn3xuCAmBiBdMfg5HUcTZp03QUl1SARuAGWehh
 FchM0qghujcI7fo54RFbfSOaWyWkbzrbaOPqpru2vYHcLDvBi4c0aMfrTIW5St8Cmtmg
 b4SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6VUz2PD1c65Zisd73qFDHDD+oS2BUR+juSNfYckSJnNONjGx65MidJ5co3XZOBX/HjFSubXzrKPBi@nongnu.org
X-Gm-Message-State: AOJu0YzLhDai6JzAIHxSOA8MSBEUjoB+COZFo3sBjUtfIhMbaXz1p60A
 fc9oWJrry/7Bo3bpM2TAxrqhJRUhNapkG6gvIVpLll2vtpL7Wrq/sBS5XPEqGaYrzJE=
X-Gm-Gg: ASbGncvUBCeDyvq7M2Oo/XtWIThj6HBXLPUlaLzYkS9gftwSOfR6NtlX1nXddp0M/aG
 SlDugnGyzNb178VmOrgWl/bUHT46hVy9PwE+a5P76ramV0rv1x4ebRsimz5Y0kDNuWywq/NodWi
 +GXmsjjQQtoU6KCxW2mOqoa2oD+rEAibda2QcgsVfgmRpF2UqVi69B7uXoN1IKL9ICj9qf5fcG2
 +7bs2MNWu2qtY7dSP1hOyWrTWNcY0I0vdkWgtsXHnYHj6GzU28v2Lsf8nYppyZm/kKB3/ZNbg0s
 JDkQpV4wOEMG69WpyfG68AAuQ6U3hb2EpFJeMjWKmuXreIya/vZnzfOrwaCha1oOrH0jbRV7Wdu
 O6ifT986tgw5VuJ4E4sWyaBsCAjODvr325N1zqpi5pwdDFQ==
X-Google-Smtp-Source: AGHT+IG+mtCFCPrcV33xxgYSesCZm5mGfqV6Qcz4Nc5PIAzjxKrgrWcSAofAKNiJ6TtCOC2TrHShmQ==
X-Received: by 2002:a17:903:2f48:b0:240:1879:c2f5 with SMTP id
 d9443c01a7336-24096a4f774mr74341475ad.1.1753897299464; 
 Wed, 30 Jul 2025 10:41:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe32a2c6sm106633195ad.60.2025.07.30.10.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:41:39 -0700 (PDT)
Message-ID: <ec6d5295-77c0-4a47-a0ae-657925d9503f@linaro.org>
Date: Wed, 30 Jul 2025 10:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] linux-user/aarch64: Split out signal_for_exception
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250725230849.13026-1-richard.henderson@linaro.org>
 <20250725230849.13026-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725230849.13026-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/25/25 4:08 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 37 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


