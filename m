Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4348CEF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJHj-00086F-0D; Sun, 08 Feb 2026 23:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJHi-00085p-Bd
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:54:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJHg-0004H7-R7
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:54:06 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a90055b9e9so16909875ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770612843; x=1771217643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QomsFYmffLkEMnxqCyMdufykr7r2CW8GT+jtuC4I9Q=;
 b=m4FRKSYI7ujALw8dRexGTGdn64PzBsGqPmUiQidic0eePrMvfNF73JS1/yrZgjBvzF
 KDH9QmzayCUkamAWWKZOc1tz4U1GG74j3vC5D92dWfGuLcLN4jEPzNQEi4xJKvqzwwc6
 Ei5oRBHhT79Ch0Bu7tw63PLe7oTrwRtORuFt12ClN1rQFfpxQlPtyS3b2YneGVbDLdVp
 cXTfxx4XHrgnozySD9WldIv4jXSy2Ydr2Hhv+s+l4MFn8/+tiSTTfkF3Cl1SlURFas3P
 uhExbLW4bzQA0C8ZoDOWvGovox5m15dDKpD7W7SMiKKECYSKnRR88s7kT9NWG8XTl2bp
 vK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770612843; x=1771217643;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QomsFYmffLkEMnxqCyMdufykr7r2CW8GT+jtuC4I9Q=;
 b=cLgTTTURaWsSXWFneu1rXmvC9rpVvmaVm/wRlwGeWoUurPSYJ7lpwI9PV5N9elhcjo
 RitrV4iKH1VHw86tvVp0hber+IoRMTqJsjbqb0m5+O8D5QSLrtDRSIKcsQNK+EwQ3sKt
 pT/j9XkbdYL06M6d3Rp9KW2zGedGn2JaG9HqLAwglH1Kyf+t9LeucJxf7yw5xz8DdxlH
 ItIYogEX/16FCDugQMWoSF9/kpcVFywkgrFvSfnEoXmDZzD/w2VU8JEEFdvd+z38fAG8
 uFdYlhe4WMDQUovepBqoK4Xh89IYlbi3I4nhrP+YXAW3US8gUAVqZhQgimnvAI7owhNb
 Ew+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlqIGt7Jz1n15P1RCIPQShHTBge40QZsC97bJm2Qa7rrbk075qbQQhuEeTTlMhEz8Bd8fbTB/fkVUc@nongnu.org
X-Gm-Message-State: AOJu0YxUM8GKio8x9HVUa9jYzpUFfrirpdkPio374L7mtwb6k8qvzURg
 RCMj8z+1eVfbFvxBV4rzN0s3YT6eAeQS3SLylMH/sq13RS/BlmLGHc9KAymV9GqDSds=
X-Gm-Gg: AZuq6aIro2z0eI8Opqc502hFT3JxDGlRO95hm4TPfWmQS9Ka/3x7rEL9Tgp4FHGoIn7
 6gI95WE6rPZmMXnCvTHj6W/l3psSpokMBCM3JpxjG2a/w76+yYhaaJd5gU0jS4CdDgxrTRLt17O
 p4JIhYGhHXrowS0c086aY+gztPOya+y5RAmsqL3VhfrzY0SwrKHqV/9uXMao0HgYIwR5EPR5J4/
 TJcdKKKTBXP6/pdqm/r67wp0EkGCrW3sZYvkK8fKyVDH+CcNB9qI8YSQfljCkPjYKTMI9G2SBvl
 0BrUPwe0dhxVIMFeflTchrajakFSFlQ6sVl8W+n8DRGjf7/kB8gcOAkwn095CobjGqeQ2Ta12NG
 iZ7TsSyko8dsi7ds4zS+G1We/lKMHHJmdfURTWVyRrVEhzKM8WMMqdO4Zttup5aLQ/bii5xtVsh
 ZEC1QBmhzk2MRY1k06cgsdbE0b8MI0Y55U84mRzbvwO+QMa9ld6GK6g6ggUPEp0/k=
X-Received: by 2002:a17:903:19c8:b0:2aa:dd98:197e with SMTP id
 d9443c01a7336-2aadd981a09mr37260045ad.51.1770612843118; 
 Sun, 08 Feb 2026 20:54:03 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c09ff2fsm12553540a91.2.2026.02.08.20.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 20:54:02 -0800 (PST)
Message-ID: <3391dea7-05c3-4e9a-8ce6-b013b3615406@linaro.org>
Date: Mon, 9 Feb 2026 14:53:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] target/arm: extract helper-sme.h from helper.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206042150.912578-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/6/26 14:21, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper-sme.h                            | 14 ++++++++++++++
>   target/arm/helper.h                                |  4 ----
>   target/arm/tcg/{helper-sme.h => helper-sme-defs.h} |  0
>   target/arm/tcg/sme_helper.c                        |  3 +++
>   target/arm/tcg/translate-a64.c                     |  1 +
>   target/arm/tcg/translate-sme.c                     |  1 +
>   target/arm/tcg/translate-sve.c                     |  1 +
>   target/arm/tcg/vec_helper.c                        |  1 +
>   8 files changed, 21 insertions(+), 4 deletions(-)
>   create mode 100644 target/arm/helper-sme.h
>   rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)

  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

