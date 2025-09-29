Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E21CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mui-00025K-IZ; Mon, 29 Sep 2025 19:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mug-00022T-Ux
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:04:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mue-0007Oa-UX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:04:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-78104c8cbb4so5391808b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759187047; x=1759791847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3Ci0n5vYi9+06itrB0ZpX/zM3GVQ6A+MGoQyG7UbBA=;
 b=y430UIpnVi/SG7vhGjqOE4TMosFNzFW1SFX6qNrrcWomlZtk8wN/OacDYQV3x2MPAH
 dZ1jg78zU0VL5ZiBrSAMMh+xYTYC+CZWxinZ3mCMPO7ktLLobxTiH8WvafJm65FzKzjr
 QLNfZeygkWZnLBuajKaOBU6gEWW9PvULQiLGcKINwDye3fSJlO3bauVMWty7hV5EmB4C
 F9RrMCHbcoArpdsf/yJ0PWguU8AOzRVN1IDDnNS0A2tsmorqMSSEGKdhFq061Tr4xXGB
 gohgQRqIQgolV5S0jdLAe+aYBIrhfrPPJo2DSzMuZd2Bz45AfBkrwkUSbYcNrveSxcAd
 nPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759187047; x=1759791847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3Ci0n5vYi9+06itrB0ZpX/zM3GVQ6A+MGoQyG7UbBA=;
 b=oYdihupYE4SUTT6E9AougPgak+D9ljiXvbZVgBgmDO9sAMZdNAueC4VOtaVHBzVpC/
 /utnMDmhU/W6Q0Lvc9MYAR70aoEDZ6Ym7fBKpcD50NXJd9ARiR5oe882uZSMMEerh4I8
 c1MpeS5ZaPKOpfoTYq7UpGpGPkKfNScpORSdRlWTEmiSYBeS93R0UiwhyE4SctFKssVU
 WnT6xZv7LvZZVsSntU1Aaj1Ac8sPFBkDV3yLT2lcuKbiuCq36ZRjACJXr+U6QDOR5TVz
 4G8Yi22hFruI40zjYD7NSpwQAKoM8wizSzsPPtH1vibLS8dAqAaPEyY2yI0EQIsny69w
 /KhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3iPcHzZpVSvo0Nbq3Gy8P5xfR3eUl86uGfbfH84YV++TGVKlk55nd1Nk8O83Rp5hq+MWE75naSFet@nongnu.org
X-Gm-Message-State: AOJu0YwYFSVrsFaZeXbRNbYVC85ruUp3peTxvEVDvJpaEvQVvvBKN1Ha
 MFgFLlLGEoTFj6+1EmgtT2qizxZu4injqfeYW++gAlunyT1+HM/bB+/0wKN8Hr5GluQ=
X-Gm-Gg: ASbGncseqpTtolafhwZFv0bggEcYD/c6efJ4XZL1uK6TPjCebCyjwz4PYxqfSuuN8gW
 BDKmQiXXrXcjSeF/Ibs3BEBCyscvnIflC9S1WQq1eSbZRGEIDq6RkgSMeJoYBbzArV6R7bsBxHn
 /kxD4CDEMWNiFzCp8nlv8N6raBBtCYx6lMEuL7Kght3EZzkB9g8ZTQdmossZUVNQFGDpwhORuDp
 /fRfloHiDwHVUJ8NAR610ltLE8H2yPlpkdc3K7TwIA2vOCgbufiQjNTclP9efnffKGChUAJaKDO
 JFlceB3KC/7llgqQSwXgWmRBJCC1AvXVb2SOUD+MWao7FcFP9pR66jO23Rzeji91t6Ojczaf5ze
 BVEc8PD6nIauEw2HeixySkSNOcHkvj2YBM9k=
X-Google-Smtp-Source: AGHT+IGz2nSbJn9+Agz4L1eOLhLathru/fsjiLcTlKYRzXbYKEmeHNzDzKkiKR62bSeFBNF0pLYcKA==
X-Received: by 2002:a05:6a00:18a7:b0:781:2069:1eea with SMTP id
 d2e1a72fcca58-7812069208emr14441051b3a.24.1759187046938; 
 Mon, 29 Sep 2025 16:04:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c06fe8sm12002567b3a.77.2025.09.29.16.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:04:05 -0700 (PDT)
Message-ID: <c7365afc-ef3c-4783-aa13-f0afdd05748b@linaro.org>
Date: Mon, 29 Sep 2025 16:04:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/arm: Implement GPT_NonSecureOnly
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


