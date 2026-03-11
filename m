Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDAA1062868
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hgr-0003kZ-JQ; Wed, 11 Mar 2026 07:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Hgo-0003jq-7c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:25:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Hgk-0003wu-DV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:25:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so630391f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773228316; x=1773833116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KwOLdfYglkXvEbpjeXL/9obUVa6Ww4oqmXmr77l0E64=;
 b=gnceOA8JKAF3Mv1kvBgAw9XbzTG39BYyC/T+kcmxRyaLYDmxpEX2cTqcEc5eQnVr+R
 hX+ZZt3IRM4+IKpdMaFGJ91bqsrxxWwi43UU11Qzw4hSbhd0+SCBCyzPACHO00Px3crz
 8rJj1o5t+RK809IQctEg4q7qTxgt6/Om7N71Rrxpo1fHqQ69lox7UEKE8d4YkMep2tnI
 OctRKo7Ed3EaZpuGBFLmx0bZ4pvKcC5Seh04WHHUOrrf3k33/91IoaMHIiRSGzEFSp7p
 dPF2K0ZDhbmRoXZWfjlI0wGPWq3Ec/QJJowj3mcr3CWUBxkavFlNnjhz1BfeVZREGHm0
 FwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773228316; x=1773833116;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwOLdfYglkXvEbpjeXL/9obUVa6Ww4oqmXmr77l0E64=;
 b=RRQdYDSSTgjXLJxp7YSckIx10JgWLl83gogiJRix3EpM1JkXRhOUKklXzUqAvr3i2W
 xyQLNbrZWZQAcrmBqQbVPhLbHVpWCQg/+ZE2FnQQd+qdqYPy4d+QttRLp7UanmwbeLMd
 Ln7a3SorQjrsifaS3z7C66kehuFtRXePZ8I7Eqc1jAeAiREPV+ffetLu1M8Ig6lvZ4Qo
 /9cfmdBxfrV9egapCcwcZExCfEeQPkW+xBrqvjVp8BSldgj/OoiLFf9sILd/L8qrDQqe
 evYEP58oDUSX/dcSPKFTD2JtwHuqGQNXbJU9bPokUXMEn3b2WmVIs6fjxSDASrTITXrm
 GTtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEPan8uo6/wx0vrAvhBCYKVIUsjp75r15G7MFEPXlpzevIa4v05JcV2wHyQrtgxn2KHSwx2QIYpsTl@nongnu.org
X-Gm-Message-State: AOJu0YwewQqy0qHiKM9Qotcxjc34a1xQlvJKpWQHB8+TftiQga+Wk+ru
 3rd0jKdFM2FzoAfjc8fO2BAiu9sf/+kCwOAqNo1d+w1Fj4qariTJlb9gNaRUgY+G5h0=
X-Gm-Gg: ATEYQzxX9/7ZNKIyT5uS/6hO5d40duCvxNlh9NYGP1SowIzb8vEMSE/yH2dk/ASriKk
 WVJIYoeKhi3V0ofURAqw8rs8OxFtUwN39YTClZNIeu7f27mULy9QZyxe8b723Iv6frYSI80cgpx
 fF3elYfqQ7XqqnaaddEShVPED/ElYNy5Fa5PBbNO+AAu/GVXziQwuaRMMaN49ycGQYRt/YdrjfJ
 WcFi6SbgeuZ4zNqsobxPcjcoSptUH4yq4qZ6uE7zLATLRrVZxPnRh4MBc8t4gpH73hs3Q9UPqWO
 UDtyuTLk0iDMZPYheqYGF5GVC5aaKFC/4IT2APpEU2nTdlpOpELtTi2X2PQmPwB1k3rxOu+dX+w
 Z6+SfmWYa1UxRxXADp3gXBDpWYwIkKuSQL08mcoW6iR7t4QzCfgjxc3gKnRNb4ViTSINgCMJ3qk
 cGJxYf9GT0jH5fHTaOvdz7dPCf383N9Z9mCWBN7YHDp6+77UX63lhX6Hn2g3S53rRxVo6QxJbNQ
 VRA
X-Received: by 2002:a05:6000:2013:b0:436:1597:7c7c with SMTP id
 ffacd0b85a97d-439eff27f89mr13375935f8f.13.1773228316124; 
 Wed, 11 Mar 2026 04:25:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81acc22sm5677957f8f.16.2026.03.11.04.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 04:25:15 -0700 (PDT)
Message-ID: <02ff7f80-25ea-4617-a6f9-a938bffdc04f@linaro.org>
Date: Wed, 11 Mar 2026 12:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: fix typo in variable name
To: Alyssa Ross <hi@alyssa.is>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20260311095315.25013-1-hi@alyssa.is>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260311095315.25013-1-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 11/3/26 10:53, Alyssa Ross wrote:
> Fixes: 94a8d39afd ("kvm: Consolidate must-have capability checks")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>   accel/kvm/kvm-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

