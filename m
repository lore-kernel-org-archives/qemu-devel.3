Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7376C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 14:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7bFr-0004ZP-Dg; Wed, 23 Apr 2025 10:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7bFq-0004ZC-3M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:39:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7bFo-0003TP-EZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:39:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22da3b26532so9198815ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745419150; x=1746023950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7e0W2Us3kpFVlm6Zs8N+NUJ6zXSyMo+ct/JP2v3Wcgg=;
 b=ybu/ha9ymGj3grLMdQUYUDwKjNc86hGVRLTV9VssF1pr64b6SDFBhFIAqqXDgcNjR5
 MLAtOQPfli0O/2yS/Bo2p4gJDqVSeO2h3d9gxy6Ao6pcoXtS18WXCJP5rhS50wLMIm1N
 HfglHvxVKChVaJXV3uKb6LHH58FjlbsNo+vm8mZK7moZwXkxZhQ9rpcSbAiMWZhTkrZ9
 DRDBgQQXB16JEjx7CGzS1k1z8zWryqW9XnxjY9Pbrj1B/TjIPkPFnL/mgJNEaBGVZBSq
 unRPuHpwF/k9v5KwCKQqjNmnBCCpIU6w7+SkvZnQ6k6F1hK09SCVobN6McqnyOqTtGFF
 D4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745419150; x=1746023950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7e0W2Us3kpFVlm6Zs8N+NUJ6zXSyMo+ct/JP2v3Wcgg=;
 b=Buujb/yHUrr83fHsSFLhIYaWMglg609pmkiw61OF8e+r6y6ZoTH2vg+R0kN9v8dr1Q
 KhpZ0ur23vRGrbzHyyyFf+c/7VEoYdobrMhrh1/4f6Ga3BJxoh2gwUIgCOyqo4jZ7cAz
 w7UACk8rTAWLVXOa7sP5eZHo3tmlKan+xGV5b1rcn2Ze1Px8WndDmIr8UcVRdhfpr+9s
 3mx/zghPilEHcK1Rs99vsx92+kuO11r5P0ZOlLi+GgaRLSDVq2eQWopiNbM/u7p0ui+S
 bgmK0P0JxN5Qc63vS8RsNzioyAg8gYObPMBfmjL4v/iz+4o0/jTXrbTnvTIuacemkAQd
 4R2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/EfgZxBjeXHJJxVHQLWsX2T3MlTT5cqCxq+bZOLBUeLU3o9RY2W3szAsAyqly4BGhwed0CU1bf3a@nongnu.org
X-Gm-Message-State: AOJu0YxI9BLeH1wcVLiyJuwSIYbGCnpZBF9FV/lVHOW5YTVQCh3JJ8je
 kF4UM+0QjvZxCH+MmtAEZowFhmIb70EO1BnvZovNo/XeSQxRxcrS2kNoMcfgMkk=
X-Gm-Gg: ASbGncsEoKsHeeieCf8h8ZDQWL571Mz+nJ/PfRm6P4LsYqE8Q3cKjsCzgv5IzjVul4f
 8Epk8lnuELXqnopL0qAmRPSYw9nRiqFEWLegHVLpmStmDgStS+RZKR+oG7kWHWgq9XR32TeQQxO
 /to3PuD+h99WKsEtSRl/v9vk76iBav8IlXefTsALpGqlhkiXXQAOM824ZxKvlTWUu8HW61jEMrM
 IWKLwQw6iQ+Qye6LxQiLKxSvj9oGaqH+YBYrWxloMQLpf9v1vJ0v5VJJQBq48bqsMIdtkEPO09k
 drrocLShD6qP3FhsjWmJO1zuekcpFzBb3GvXTW8uKwxciiR4nsH589TI61lWtLSn5JG68HLGwsL
 Mmim6XOg=
X-Google-Smtp-Source: AGHT+IGk9qMFODDuh1HQNAzsU4ViKI02te1S9qJ3mDgwiKjXWqQMh1wB38srju0QJ9A4yN9dxm9GMw==
X-Received: by 2002:a17:902:f78f:b0:220:fe50:5b44 with SMTP id
 d9443c01a7336-22c535add2fmr285324585ad.31.1745419150576; 
 Wed, 23 Apr 2025 07:39:10 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed0ed8sm104664765ad.200.2025.04.23.07.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 07:39:10 -0700 (PDT)
Message-ID: <cea19841-1452-4507-a73d-f5f55f15f4de@linaro.org>
Date: Wed, 23 Apr 2025 07:39:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Remove DEVICE_HOST_ENDIAN definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250423111625.10424-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250423111625.10424-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/23/25 04:16, Philippe Mathieu-Daudé wrote:
> Since the previous commit ("exec/memory.h: make devend_memop
> "target defines" agnostic") there is a single use of the
> DEVICE_HOST_ENDIAN definition in ram_device_mem_ops: inline
> it and remove its definition altogether.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20250422192819.302784-1-richard.henderson@linaro.org>
> ---
>   include/exec/cpu-common.h | 6 ------
>   system/memory-internal.h  | 3 ---
>   system/memory.c           | 2 +-
>   3 files changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

