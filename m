Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A21E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6l1-0002tC-FW; Fri, 13 Dec 2024 09:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6ky-0002sH-Ps
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:35:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6kt-0005MW-U9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:35:03 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso12931935e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734100496; x=1734705296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/YCsuHIBb5BNxo6ACdgvtIaSmcGKqG677cUqg/XrZI=;
 b=aNYSjdE0cb2q9NNc5vDt8VYOVNdKRv8VF+Zcdd+TpfLZMoDr977UZ7A7VdKEG5MwzY
 gMqqXmaBhbOAnj0y+9NsF+vxtXnJTf+DrBBaVgemXmf6XVWbItZinBTB5CiTi/7wO4BV
 jYoAPozEUQ2bSa+mSU/37GPuEleYZtrmKzx9ApgkOO4/501cwR/9/gcZ8DyUcY07bBAh
 ANMbtuegGfajJaLnwF9vYERQQfmJ6DOThvlb4bXzbgDQEpjyqo13AyDmnb45QJa/l0fk
 Jnd2PuCQBXzR4BQ+3yNvOxDASRLc/coJvybAPg3xQL+PAeXrVz0qBofMk5gTE/lqS/XY
 /6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100496; x=1734705296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/YCsuHIBb5BNxo6ACdgvtIaSmcGKqG677cUqg/XrZI=;
 b=uIqw0GmJWtTUdGGo4HQEPFL7M+f5bVghCmML0noXk92RZJf9fZ3Fx/wUb0207IpMpW
 rbTaqRhXT0sey9ZIO/E/qPZ4CblL72wlgxz69z9TadQYpGa2px5bIOfrSoR7MuRSxUlz
 1joVBILg1Xc0765H2/qyoEHjFTfyol5rxOzak7Uw8ksayN2wU+b6cCtJMGzNkE2wgxh4
 MpE0uvxrqzz9L1nmTz4CiXeVDPoaFwPphfxBAhdwv4bNz4+VuZugzyxoOXYo3lPiYOgS
 MlZyRevn549Pa3ifWc9Uy/jozLqi5oZucb8i94S5HL9x+Nifn8xpx6p8pRapYVFqg8YQ
 KB/g==
X-Gm-Message-State: AOJu0Yxh3ZyocIrfYkbgrfEl/+X9yx8eXafQa097O5k8OiyzUaU1JfKr
 AtgqkIjy6L43e3xQJtnYnT16sAam+ZT0l3+YLq5Iq4ENMZdGvnxvRPJynujmwVEWRig8gkvTUwI
 T
X-Gm-Gg: ASbGncuZbR3xwGnt8awmznRa30hLE3iL6RTA8fk359kc+iKrOiSoS+kL6QYpYRHkRzU
 cgl9nnkzIKDsloYZwSgRscwbBSHUeiK4gpca6WwXKo/1s1GLCbxshEQH+Fe1qv3HWuphEPZPXNc
 dM7hxo59Np4NunMEtvvmD6XGb9yncWyKhsMfI9dO6WcVxs5msBQHsnBTMaX9jhCv5GubNHny4/w
 8iYgMzRBJw+YZ2brKFjGhL+nlBJaTJC1BDrHsqlBhtdVAEfwT0k4kcIfxqq29tiamLpp10UfIrb
 VRCCARvrDhPjxl+znODgcId1R0AEZA==
X-Google-Smtp-Source: AGHT+IH8dpTtigXXEOchQ5KoUzvI1YPF/xBKGrYpCZDoSGuaMMh8tHGYGzv8GCvkR7I72WPjaS815g==
X-Received: by 2002:a05:600c:4450:b0:434:f7f0:1880 with SMTP id
 5b1f17b1804b1-4362aabacb7mr21750535e9.32.1734100495752; 
 Fri, 13 Dec 2024 06:34:55 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4a44sm7191521f8f.25.2024.12.13.06.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:34:55 -0800 (PST)
Message-ID: <43c0a438-51eb-491a-a445-242e0b3b7d0b@linaro.org>
Date: Fri, 13 Dec 2024 15:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Use actual operand size with vbsrl check
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20241212082234.1572133-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212082234.1572133-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/24 09:22, Bibo Mao wrote:
> Hardcoded 32 bytes is used for vbsrl emulation check, there is
> problem when options lsx=on,lasx=off is used for vbsrl.v instruction
> in TCG mode. It injects LASX exception rather LSX exception.
> 
> Here actual operand size is used.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: df97f338076 ("target/loongarch: Implement xvreplve xvinsve0 
xvpickve")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


