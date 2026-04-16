Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80EDF8E486
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVnB-0007g8-Er; Thu, 16 Apr 2026 19:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVn9-0007fy-QD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:06:35 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVn8-0005ja-CQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:06:35 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c79467f128cso17740a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776380793; x=1776985593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZhBS2K7rFqQDlqNU0wfiHvCdwY2ra4Pfyk0+ZCu0kc=;
 b=o5bBKOULJzXl/TxlPuH+u9dnWUOqPeLEE9Yx6KGeqNeB6GTrZixoVNxhCN68DuM6VQ
 MgtduBV3jWEkUoSNRu7a9VDD+ZACVCTq7uO+iv9+lBaVMQNVrveTuIYDJbe9g8smhPfJ
 +nuyZhbq3UyXagjARgorXrBvd/DWTj3Y+774puzJgBzzOC95P9MLPB+D9rcwFOagmS3u
 6GWMAKsDyiTT/oxWKd8fDIv/KXAMovuWOnkOSCMC+WT6fvnRkwgDd2WpxxWjDXQI9aY4
 hFJ+UejX6iFGwOelhP/qV5kOytkTIxWs+nZgm11Ps4pNyGY1jchnvl3hZvCXbouM0oKJ
 pMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380793; x=1776985593;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZhBS2K7rFqQDlqNU0wfiHvCdwY2ra4Pfyk0+ZCu0kc=;
 b=iBxK4x6zhfGi0LGC5FBdfifZXQCeHDtQk49H9yGRKBuIyjTFh6Q106Xnk04XmusU+p
 fVOjSu7IUkel7lP6r8SX30pObY57EHzkh28j40sXIp9sX1e0gbYAID02ieWohHl+GTH2
 malWhb1iZEQscH8pv8F6GWFmII9pPQUSCPbO8DnxmCgIu+0FzsYfEDagHI34WrTU7ItM
 GKVibHkp6Nw8Ao1b4AwaPVw9e8fzVv1t0goTh00BHrE8FEqpyk0zdtQrS/SuhAxkehcg
 d3i6VdQ0feLOzTzhpEeaRsS3Ut6r4781K9y1p0X8Hb6S6aJmYI57QXfjRWtcJIu6eK1p
 ja3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C7mwYcwnvKSlkaC2//0NfFNmlPF2dGsOWTeHwLFMRUK5wspOpMdY25pI+P6GXkQBp/or9MEt1kTnL@nongnu.org
X-Gm-Message-State: AOJu0YxvNTxxRQpnzoiuqxc/yQyREwdCFGF2wIj2oSukxYHroLEZSuwU
 VGz/FPbKZ87kPeGDt+8FW7GaQmpjGpf/RKGThbdF9r68z1ejISAEliPYtDzq9Z8B4TM=
X-Gm-Gg: AeBDieuUmJO6icpVYjkazJZDE0E2Nmagfu9Kf8iX/ubWAbBX32xNRZsV0lUqgOTz3eB
 wU7SqlrWwTfMfCun5B1cJ8wjXEU+x4AACHGysmSDm6MyFYzyXiALszsnJxDAtYVL2jJT4L7f4qE
 0J+qJymHii7KGdmw7friH13rnbnZIfLR6Z57wUtnPIJ5VUINfp+/BCogzPOYZppDmzzOGrh9eJB
 TcD+TSMhabvMAQ3klmybOlMWcH8fUoG+GrnMCepFeL4CWOt/eqqxo5en378ZErtiVIdgI9uh8sZ
 6jqGMLNgYzUwuPB7qZAsd+yCYZsKhN57rraSkhfs2AcwEaPXbntHbNPTee3n99mz92P9y+shQFg
 argo7u6SySV8zgtFpiEHaTd/FF5slxbu80VGejLI3YswdWaKDcqnyoAL4quDvWgVSga7K6LYF2G
 pyIUqLNfnG9bXtghP4pOjT31Nthk01pTUjj5REXD4m6KGaqo1djOto7+qKPMnexhcl099V0Ycra
 ucT3+cF92o9JxD12bJURsLpMcradr3Rts2C4UeCnrnQiUfG6DgPh/rU8rLtWfw4oA==
X-Received: by 2002:a17:902:db10:b0:2b2:4a9a:b149 with SMTP id
 d9443c01a7336-2b5f9e79dcfmr3647545ad.9.1776380792675; 
 Thu, 16 Apr 2026 16:06:32 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa4716a8sm825655ad.28.2026.04.16.16.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:06:32 -0700 (PDT)
Message-ID: <dbe36ccf-6f89-4aca-8c45-f517383931c2@linaro.org>
Date: Fri, 17 Apr 2026 09:06:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210508.30686-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ld*_mmuidx_ra() and
> cpu_st*_mmuidx_ra() calls, inline them. Expand MO_TE to
> mo_endian_env(env) in gen_ldst_multiple().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c             | 40 +++++++++++------------
>   target/mips/tcg/micromips_translate.c.inc |  2 ++
>   2 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

