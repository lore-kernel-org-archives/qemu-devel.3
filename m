Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD44C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCjP-0001uE-SX; Wed, 30 Jul 2025 15:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAvB-0000Nw-7W
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:48:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAv9-0000D4-2E
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:48:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso1189895ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897733; x=1754502533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=13QXE/ZfO1Nn8URO78dJAYiXd+Clbs8PJ2mL3Fmhypk=;
 b=dC3HbhiVO/2TMYIYvHVq2HXO4sVl/cGSnKqSQ+JiBlHN2rMAEQIk3s6DtvllbGe3XR
 M7o1uDECsmiOBMD35I3e+u+2kfebxaEDCVJXpa2KOx6As8042sweBJgxfUuyxfp9X3qq
 5a4aqQRl03QZ+IjfYIYIP20OnW5MSYKvyQvIJvowQ8cJwyc+hMvzzaUhnMYXF7ANN8xq
 qT8m1YcCcIx/XiyPixkC3eRewyM2Ztdbnd9NaiZnQEu3zIPDBq+n8L0Sz9QjQBhT3yTm
 MKozjIKOiE1HfZawmRZGaO8HgCjceqqNkbn0mUDi54K0KHU6Gf7cDU5LnW3HQ2+BMfa5
 C6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897733; x=1754502533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=13QXE/ZfO1Nn8URO78dJAYiXd+Clbs8PJ2mL3Fmhypk=;
 b=ckAeEgKC8FBFfTmxgtDCojNR72TNTWYYmgJy8cMuonu+Vw42Ho0UMxC97qSC5ePefZ
 nOsvi9Ddj+f52/1zQOxOMhA+ddDxD3skOzlzR4CbAlGwOmxsXjEzNIDTW3HNKuZRjv03
 sVb3nZdgSUcHQKOcAdqOW/dECx+xZGZyhWTtNpvV8LsyT4GE0IzA5jSt9UsEPCjg5ByO
 0be//RTPCMnRenz5XsKw/NpkJKFTpxl+K0ZrDlB2CD0woMO3WNCkXeCM+0BAMxVVM/N7
 Xha8AZpm11zfHgbxuuKGsFe1l8lkyoRNqpGemQovERu3rLB5dV1P6d01d40wK//8WU39
 6G2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgJkNla4yYPoPoNUIdbzd1gasnzbxYPvQd9i77ly92vS3crNYEMLGNu15qdc9afDD39i6Gr9H6AH7A@nongnu.org
X-Gm-Message-State: AOJu0YxYQCI1RCdL4fwGKcdrphBURhogZ7K4L08yk+2Im7dS+MkCN1ti
 tOBYUQaLKTueo1wVpuN1MT/bx+etEvvHE8fVm3du/iHGABespC9pxnCb4syseq7IVfg=
X-Gm-Gg: ASbGnct/k9douDWGPHGA4BDlBuXaXavqbt/PKaA6yxpWvY6jBh9Gw7be8ivq4tkgKiq
 CkM2OSPiYyYTLSuYTU2w7RXJhIYoyRlN8ZAyVQrEVglYZGXHdPcMIDxZism223Nl4zoiLvzQoY+
 +iaZz47g8Q2d/gyOpRy7V69gtQam5WtSzZQuO+j5mkbDIv3F1k36T+8jkTCNZ6gGcI8m1Az7xYG
 HVmInR/IU4Ln0SFMAVt5QZ4Mqc3ZnPQj2pvCIxdGTRc+YaqR4cBTWFaJdkaGgPl/qnbWhDSOG+y
 IoO4C9NnjhnqRquo/LOGhMg6CcApFCjqdzEq1ZWMQzpf5ptoI76aatr/IieytIqbNf+RhSZzVec
 nBJEnZGhFKxbeptqisj5IMlOlserEyvPQvms=
X-Google-Smtp-Source: AGHT+IEmaoyHGcEFH6UnyCb5DAEM/OVWG5qUI0UuB2/yRIMnsJbwTEatXQ4DOv6rWpZ5eal820pgiw==
X-Received: by 2002:a17:902:d503:b0:240:2774:8372 with SMTP id
 d9443c01a7336-24096b06d61mr62926575ad.36.1753897732820; 
 Wed, 30 Jul 2025 10:48:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fdf168907sm98677085ad.90.2025.07.30.10.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:48:52 -0700 (PDT)
Message-ID: <aa061a96-8552-45e6-b5a5-af12d35332ba@linaro.org>
Date: Wed, 30 Jul 2025 10:48:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> This series contains one minor feature addition and a series of small
> bugfixes/improvements. The addition that motivates the submission is to add a
> limit argument for the hotblocks plugin, allowing you to control how many
> blocks are printed rather than being hardcoded to the 20 most executed.
> Setting limit=0 and dumping information about all executed blocks is
> incredibly helpful for an analysis script I have downstream.
> 
> This is my first contribution to QEMU. I've attempted to follow all of the
> guidance in the "Submitting a Patch" guide, but apologies if I missed
> anything.
>

Thanks for contributing Alex.

As you probably read, in case a v2 is expected (the plugins maintainer 
Alex will be back next week, he might have additional comments), you can 
add the "Reviewed-by" tags you already collected to your commits by 
ammending their messages.
For the rest, your series looks good to me.

Regards,
Pierrick

> Alex Bradbury (5):
>    contrib/plugins/hotblocks: Correctly free sorted counts list
>    contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>      blocks
>    contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>      PRId64
>    docs/about/emulation: Add documentation for hotblocks plugin arguments
>    contrib/plugins/hotblocks: Allow limit to be set as a command line
>      argument
> 
>   contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>   docs/about/emulation.rst    | 12 ++++++++++++
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 


