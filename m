Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F69CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43oi-0005U9-EQ; Wed, 01 Oct 2025 16:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43oe-0005TG-1w
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:52:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43oV-0002Y6-95
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:52:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-330631e534eso398175a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759351952; x=1759956752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DnM2eA73wUtTCL+80LATCvBN4aYheI/8sCfu1B4dJ7w=;
 b=U1YkL9VY+Yv31pWxZrrKCCvw6go6hDhtM3eOF8VViWFEvSRAzD02hV595Uq/t6fY5s
 KzcVIy3bCe2FFarcV6NUhFKI2x3k/PHeUVzN3siwOeGJVWkkCi7jdtjIlt9BEHYuHLwH
 2xeeN5YVkOLkxs+scKnCCZAPWNIgdm8N1xzAU61gSoqXYOFpS6DrBc4ntYHqFIR1m0Bx
 UNDWcBgI5MXDdBio9qLbIGghJi4vgP/1NNobdi4rxk8wg3ddzACE9OvNhMGjKKoyk7dw
 ozgkeoHckDYRCe4qgB0Y7/dC78gfGbGKTmfC1a5KeivZFAUuyXcUpDLz/zOHVe2bDh6N
 bpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759351952; x=1759956752;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnM2eA73wUtTCL+80LATCvBN4aYheI/8sCfu1B4dJ7w=;
 b=FBIqraUpTWXicIInR6nYMn8nuhNdcXTj0siYY1BDjSqZTmSCE4760MiqU1jV1tiFu2
 PC/DPtFxnOkus+lN0OR2Ek7pu37WH9N4hVju9/vW5HqSYr2ZAIRFX6cHWVMhk0SAshOU
 FCycsScRVKP4rUsZ/XwwMbYLLJzJT2FHahToDc/2DNEoSdI6vE+MQCwzRooivTomAlvy
 J6SRUL2iZYT8/UyNK0FIZGXhyYvH0SvZhPf2QvZoX8hAiUyXvLJsuzFuTRovkA6bDm4y
 ehXi1KvdinZxz+3tuox3r1w2tIeg1A8OCm3vQ8WqAViguQUaotxobHqnz093xJKrJEF3
 hfDg==
X-Gm-Message-State: AOJu0YyMV0P7bCfAT1FvP1Ec0OrwDuKRbpdlTVDZlkdYUWjFaBPip/ig
 CdZtQd+7Axxr+dw1BxoRvofMx4WAnE3UZqsbQE8TkZ59akhGKwF2P5gFepa3DnCEta+QXqE+x4n
 7I/9ozys=
X-Gm-Gg: ASbGncuVYj4DBHE8Hq34UpabSqHUn4ivawDDMRDGtM9oIvNB9oC6sU6bJwOSkdxxwn7
 vM1fTXQlaiG046F8MKjD4nQy7/0N7JSEUD8k6dVqg84Gryj3ZsnFVC7RG7Vv6SRjsV7J4IK/uA0
 R3yHSanWQGpKk4ameNyZ3V5dozmg0zbpV/vCKJAU/Jxp6NT4l7my1qd35SQye9DNHfC/H7g+X5V
 WtgVtD3z7h7j9x+bRfWZIPJpX89Dl/ExszUa+Sm4q3IxAS/HnyGDRjK9uIWH/t+QLxM9t3csBvM
 pU3PeYweU820AE702bKQEkURfEMrUXaR/cTkFdDP+hBHyP+BJi8tfOID6oSAGWcEUTBcQGDnHNQ
 BwLj7wYCku9mOqYWcYg9mGF6/hAWILrl9UHc6bkjul+Ocs70fxu1ZmJTzpbRq
X-Google-Smtp-Source: AGHT+IEpP+XtLUD8x0acUhAOtp8KQMh7B8nuAsrAvQUPLRWAv2zlwJmH8DZtzfacRYs7IjtWFwVUKg==
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id
 98e67ed59e1d1-339a6e2821dmr6108798a91.6.1759351952169; 
 Wed, 01 Oct 2025 13:52:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ec12fdsm3167208a91.10.2025.10.01.13.52.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 13:52:31 -0700 (PDT)
Message-ID: <fef88665-c816-451f-9517-fa6bec2ecbc5@linaro.org>
Date: Wed, 1 Oct 2025 13:52:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] gitlab: move custom runners to Ubuntu 24.04
To: qemu-devel@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001170947.2769296-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 10:09, Alex Bennée wrote:
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/custom-runners.yml               |  6 ++--
>   ...4-aarch32.yml => ubuntu-24.04-aarch32.yml} |  8 ++---
>   ...4-aarch64.yml => ubuntu-24.04-aarch64.yml} | 32 +++++++++----------
>   ...22.04-s390x.yml => ubuntu-24.04-s390x.yml} | 28 ++++++++--------
>   4 files changed, 37 insertions(+), 37 deletions(-)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} (78%)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} (89%)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} (88%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

