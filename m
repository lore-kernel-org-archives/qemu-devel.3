Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF6C9831F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9q4K-0006Cg-Kd; Thu, 24 Sep 2026 16:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9q3r-00068H-5L
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:29:01 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9q3o-0003Iz-7d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:28:54 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-87c90648f99so249870b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790281729; x=1790886529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=upyDFWsf8NcSsuDhronNYZbyKMAvF5U/xx9LzmEYmq4=;
 b=c3ksiANtnels8NHWeh7bqk0g55IkFuVWY/swZtEJXFxKu3/64hiQVDmkPITRVNUZce
 bontmIshZTyFyAi//6TOMYF38Y6hd7DgYytwV2bVR/2I2vrYJDmE9wLXQ/AVGep2Kbri
 fOl3+CbuLzh62aaaNMUz4nRJjiyPjia0VBviVmCP4IVAxkTk1GI4+q/gN25Cjn5BuLQc
 PhHZ9S7dcDPHnm3q7ShtuuHQoBE7nMynZzrnlNPIZC+ru7nHAAR1po9TsGHdxtaEtyVb
 RgyNCoTc6KOdgRHgxfouhtRCy1gsFilzC+eLy1VxsGQJiFK0mdUiYelp5MEY7yRE3llR
 5Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790281729; x=1790886529;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=upyDFWsf8NcSsuDhronNYZbyKMAvF5U/xx9LzmEYmq4=;
 b=b2Wsvzg3d2nAKOR65pNBGJ93oWKjgw6Ridb+Z4Xm84VIVivrLomgOc7y2A2A8nDdAn
 QFGCAsxFqlDcThRWhQCUWaGTcMZ8iokrEw9qHFQglZmMCIvTjYVh9r7W9vgb96GCO7re
 ieE3uve7EI9Bb2VeUEY72G1EzONzLcWQ2M1fhbT7FbL//jG9E+NPKHV2ibYhJ1ZKjMWE
 4oMr1jwKhKbfDiqyYH0uDCPP+XsKGvxC9YgPXKkLzPWNHWKjnUiucYHyATvKE50Rl43D
 ZcX7gCVS20E+226UvE6ser0s4azzxKP8WVD7b5kOl80PbHssEFMvzgKLB4pWdvCMwMtV
 ReGA==
X-Gm-Message-State: AFuF++nflWkvoGkQxddjBnvXIcl4aipdxvvX8q/zd442zXrtVww8yc6q
 ZkO4b7qxqp+kZ9BmqO15A9aoCOyxDZGQWFmGIjKzNgegi44ows6bJeQpjbqdxALe7M6nAnht1Rv
 DyYvv
X-Gm-Gg: AYBFou0nEbQVSxnXJTVnurdzRah0jbBMhXnRFFSJGPTRauI5JbG1UKDCMgyxNc06laz
 Y//dM6//tu+BvTP8wjqamhSUIW5ClQHSHw3+4dPJ9l9OjgyY6s3gjrHVgDgqKjUho25CbMJHQ+8
 oSDqVrCQVhO+rRAAJHwtKC9HHGlgxcuJi3iB4subuhpj6c6Pstna6EkA6cK1fJpqLV18m1Lj3gb
 noAHyzvOIWbGS7nYWRvu3JUh6JZ5p0LKAceyl9k2ZJDgVACl5TGjQj2viagR55vNVhNJxmmjR8g
 rR+iAQOYk8x02jnaEkSuZA/nwNx9GusoCXM/5NR/ep2OfzC0VJtAlbmmsVhTxcXSerMAptici8v
 GT5xkr56A6b2LF5aFhT8kO5qq5/ACNWJ0hoZ8aVB8w2lGlFJNziJDPCP/nNDazR8s+Ul18WFz7c
 SUWtZ5fJywQT1sr+87fSa7T/Fglt71VS7kC7awxLhguRgYKwtPUeLEfFEksdkFL/9rdr/1Im+Zb
 0itLPdmuUwfofoEZX/vWkWFchSRYp6SnaJ4pzmw
X-Received: by 2002:a05:6a00:808a:b0:874:708d:b640 with SMTP id
 d2e1a72fcca58-87e9e96dc18mr3068746b3a.33.1790281729337; 
 Thu, 24 Sep 2026 13:28:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18f49csm160569b3a.20.2026.09.24.13.28.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 13:28:48 -0700 (PDT)
Message-ID: <22252c4a-3958-4227-91dc-5c0ef6b86651@linaro.org>
Date: Thu, 24 Sep 2026 13:28:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] tcg patch queue 20260924
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260924144931.161335-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/24/26 07:49, Richard Henderson wrote:
> The following changes since commit 942229961efea74b153c44c59188eb08375f10f1:
> 
>    Merge tag 'pull-tcg-20260923-v2' ofhttps://gitlab.com/rth7680/qemu into staging (2026-09-23 15:14:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260924
> 
> for you to fetch changes up to b9bf2135a7e4adbc1c7a1a64818ec7e2d3ceca66:
> 
>    target/hppa/tcg: Always initialize DisasCond.{a0,a1} (2026-09-24 07:29:58 -0700)
> 
> ----------------------------------------------------------------
> Never pass NULL to tcg expansion functions.

Applied, thanks.

r~

