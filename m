Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A6FEEB59E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooBq-0002Sm-15; Thu, 12 Sep 2024 14:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooBn-0002LT-MN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:05:07 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooBl-0007be-MV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:05:07 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so946415a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164303; x=1726769103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ci7/wYOhFdnEzUjbmqqjDMouOJ2UrD31x7Ogo7bmBUs=;
 b=TWLPLJz/2dAaUNEBE/u5x8EqOTvUh7kp8bAbtLWWKrtbg/RnHWFxG8JUKKZbHmAUiR
 FD3JMAO6SeaCraQ4Wc6JYXEIhGFQC78G/Hn0e8v0/CkgATyqmWRYfpzt+QfjzwI28GzM
 jiUliVSGjgfdLMWUVw3CcfVxl7rfnMCkZ64deE19tGiPToW4YBORo/q3g/tUPkSeEu6D
 pFJJ4XM9RDCqrVDq1WsVa2LXmSW40kFqcrXAUNIHs20PeC2PnnWg9vwBIYBp3Qkqf0tk
 MsNwkVrwWMpa6uFcwjxmPSbcvEmxTHunXhKP9aBPFJcjWBegJBa/jiP3Ex4vctAbWERo
 g7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164303; x=1726769103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ci7/wYOhFdnEzUjbmqqjDMouOJ2UrD31x7Ogo7bmBUs=;
 b=q7IZdgtRvprQm0Ux97dn871j1C4i0ZLUR3WzrRMESA2qwHq9pz3g1S4lXQ8xgqQhG5
 TVsN7xESGEZd7eDd7yDaY+gNVHXTsyCtHTpA1D99WGvd5Fz3qwAWFcotunxxOCE9Lzkr
 X1uW3uKEpy0R2ZDH4iEfdsM1DpYopVM0iPz5GQBLlxiBbQaSZaTRohLjDKJr7u/oy2r1
 G37OW8/kVrLtlSy4q/CXyrHwP3pPc2JMLyzEViQ8tAb080piubALJeH21Q4sdpghVbnu
 I8byeZm/9f3ezARzSO3sctPStlvlM9hVagOm0hHbdX4dkUi2cny8fDFxG+1aZ+gtD4t1
 XtnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJB0jbWFrZ9oW26uesGs0SKEpMhVWD6ngAC+UjP3HdKNGaiXR5fNrmp5ytiTUIioiuSMNbGQQwpzAS@nongnu.org
X-Gm-Message-State: AOJu0YxYgBIRIrlMartroX8MuzdAA6g/pm1klaBC7foAtlg+InOry2EF
 25otwKnkJb7aF+UmRTqrXY33+aUJ+SRede4ax2RhltHix2vzDkWZmoccPWCJQxxygX+IotPsu7S
 U
X-Google-Smtp-Source: AGHT+IG1X43/XPbEBCcr6HDNd9TqTKyJ4xa4jtrqJMTyhL/m3B5t/qGyXED6zCx4aBeQAQ86JWPDmQ==
X-Received: by 2002:a05:6a21:3987:b0:1cf:4a69:6349 with SMTP id
 adf61e73a8af0-1d1128a7d15mr47403637.0.1726164302833; 
 Thu, 12 Sep 2024 11:05:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fddc705sm2044301a12.58.2024.09.12.11.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:05:02 -0700 (PDT)
Message-ID: <a2139664-053e-40ed-a133-1da519591fb1@linaro.org>
Date: Thu, 12 Sep 2024 11:05:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/48] hw/hyperv: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-41-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912073921.453203-41-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 9/12/24 00:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/hyperv_testdev.c | 1 -
>   hw/hyperv/vmbus.c          | 3 ---
>   2 files changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

