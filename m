Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19ED-00064v-DP; Sun, 28 Apr 2024 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Dz-00064E-W7
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:26:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Dy-0001O8-6t
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:26:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1eac92f7c74so27702965ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328764; x=1714933564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bBpmlrVpfslBozeicprEQMu0/EN/yhcALo+T1yTor0=;
 b=eZTwvrisL01uzy+vAp8zGZO+TbrrEd5fzTqAYDVTEE4CwrvSwL/h2K1clbCavL8VAQ
 0/GQsVq/e1vtx4+5HFO/1k6A/PKzvy8F0cQj0K4auiBHXHtdQZBnIXrG/0eWQpyuHlsT
 QP3Bu/8hMKntaRn9DWUIaFHHpgZmKD9M8aR5C3QDGvtKKVNxMpuY4+EM3G2BvLEi+FRF
 Ls6upCcnhnxRUPz0ir/M9FYctk6DOdadNeF513CFJwMvtoqR3ao089C+PZb2EZuz6PRZ
 wzFZQfNXtiqC6PiJtAMW6AjeQYbiaTrXKcVT7GuheK09gC7D3eqfKETB0mwGIKhddzKS
 LX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328764; x=1714933564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bBpmlrVpfslBozeicprEQMu0/EN/yhcALo+T1yTor0=;
 b=R1rtIQljwtxBkYMk5cjXS8rbFTgoa4+lW16to3H1q9vmfSHU6Bc8QVUrcZ6zEENru/
 mNewKeuPAhL/2aIjA3WrNWqgmd87H5kzfmJCzOuahf9DFP7VlVSJ1atVUhoJhkUq3dtg
 7gs4RgRq134yuiFz15MAvb3T2WcJPWBKa7bcxS3k5pzkaKDXMKpRCRtGf5JZM/Q3JC37
 4EwRIL2OSZcYLOszYGCAJZSp+pXka8mYOBtvT4co4hox0iBPrQqEORPspie2gCACoGYc
 P9PJk1mMxm4BzwHzvS34CeBRczLPrIAOg1/RsDVqC8ZItcTvTvHuWtZSd5hqj2/WkV5E
 bBVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rPGzq7DPFvvDJ/IlaFkeKFT86XIfQu1xg42xZVU4q0fFSSKimNZD4L+BQwFuS54fxAx7hvXSY+l52kpSkm4f1tmC2po=
X-Gm-Message-State: AOJu0Yz3vEgPrgpAxERjnwmA/HBbcI1Ax0OX+QCWmCfrq2qZTveOlmaY
 GwTPG2N9UkyxO+/+nuGLGJtoWRfBiNApGlv2Y1zxrYZTdFvG5ftT3NP8KtGaxVnGTXt514kU3Mu
 o
X-Google-Smtp-Source: AGHT+IHAX6069oJkEAgIeGUBapwOCKbMVanApmoXKTkzbKdCGPPLtAXXJ20a5vc+fqmLgwxcPiJhrg==
X-Received: by 2002:a17:902:8d84:b0:1e5:963d:963 with SMTP id
 v4-20020a1709028d8400b001e5963d0963mr7765739plo.68.1714328764186; 
 Sun, 28 Apr 2024 11:26:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a170902c94300b001ebd72d55c0sm277877pla.18.2024.04.28.11.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:26:03 -0700 (PDT)
Message-ID: <4e3ad12b-d322-42c5-b7c7-1a6466e221c9@linaro.org>
Date: Sun, 28 Apr 2024 11:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] plugins/api: Only include 'exec/ram_addr.h' with
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> "exec/ram_addr.h" shouldn't be used with user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   plugins/api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

