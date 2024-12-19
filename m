Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C344E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKwz-0001qs-9q; Thu, 19 Dec 2024 13:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOKwv-0001qa-TM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:08:39 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOKwu-0007Da-1L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:08:37 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-725f2f79ed9so954129b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734631714; x=1735236514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBWC6kkqugTb4YC+iaVmJCat4XD/WcCRqeGs1OdWKu8=;
 b=QNQWimGLGp2CWpOkAX8Zf0s/MM4PCtf6nF9NY2bITSUycq4r6b9RixqDlD2KUI95Cn
 fsslrcIF2RufBQieZH8ZXbBh99IHpih8T2EtFFhK7ADoVpZQ3l7o6/htqSOnREVG/COc
 dHWJlPZBq30VJnbd0MpRS8kkDAWJb1e3oMcdGH1pDRY6mUzILN/4x/R6woJ4ucwKW092
 8IZG4cZG4p38AnUENYx0Yk1zRQ+si6LTkLNgEllwNAZiQnacgrjmsFoPfIvD/NyURbr1
 QYTpw7fLdTy7vVEZeSL+PUeTnp3rhYZEN9JoO+d37UpK3Zkev8r1V2Cf6I4o/96BVPph
 CKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734631714; x=1735236514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBWC6kkqugTb4YC+iaVmJCat4XD/WcCRqeGs1OdWKu8=;
 b=pZOIiz/TompI9JFvvSky0vAw5jq47Rmb5biK02PsnAGDO2I21acGiKtdCp3sr2Gk99
 VRYh84mNNQL3zJujw5kvTkTVgYSCehqOx8zsjFEFqpOx8IKqYhAr3ryRG8RPlpyH8INR
 JmHJssA5xU5dQdX8cvKQjU5r2nxRvUiptB1ivEOZtlk8rJKT7uQZ6JCwYmxANg72zDIN
 vzBFiK5GAOVZM2swB3D9RX/2wvsD4agb6Erm1GIpv0kyB/X8XdTzyHUxsSrR6QWqA0cL
 wG2KSqi+q92W15KizIUe5u37kzAvMG/e3PHjJdzSRsUvF63Eoi2+qJfWwMqQWdUxTc8+
 zQXQ==
X-Gm-Message-State: AOJu0YxeeYGJHwmmtkksFdGSDABi1sg+rRb6kxT50/coc4KqqzAULGgh
 ZKGTvssqWX2xImwmdHUuiV7VFg6AUnbBLJefwAr3+Egk7sVIYx/WT2rqlC5D1hies8hkGdYv7cu
 /XKzcjA==
X-Gm-Gg: ASbGncsBXAQjcwFRmdpzVHkBtUkd2GMdDJp2jL304ZeanJmcJKg7iyo89UbixKYaK6+
 EISE+n+WsUiyn6MIWmd2RiszV0Te2mepGoP2/gLAIHM2wgTU+SVPN9ay1w77Ngofls3qtHCDuNr
 tdC0R5WoE+mGksK2H4b3+Dj86aINnDfa3c1277H/FeA9cSpPI0GrTFHLjGJT2dnT0mq2oy64+HP
 +XXtrPok86t2GmPFk9BXbxede0euEWe6MCsC46udWa1AnBEUBqIZm5slhSJiZMNwiCk2HLG9ttQ
 SD+yfGsDEpebaNJMc3/JjI9yyLGIUKHLsWZze5tdjA==
X-Google-Smtp-Source: AGHT+IEFDNWflYDaXLazdcY5/k7fkVBhW0mIUPymrOZdR4WBUMw46PW3GM7f3JFBEsL2QzKuuhIm7A==
X-Received: by 2002:a05:6a00:cd6:b0:725:9f02:489f with SMTP id
 d2e1a72fcca58-72aa8f0ceffmr7691483b3a.26.1734631714629; 
 Thu, 19 Dec 2024 10:08:34 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:c32f:435b:9081:64c9:3330?
 ([2607:fb91:1ec0:c32f:435b:9081:64c9:3330])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad6cc885sm1626058b3a.0.2024.12.19.10.08.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:08:34 -0800 (PST)
Message-ID: <6fb3ac43-aa1e-47ae-96a7-e1a175a65bb4@linaro.org>
Date: Thu, 19 Dec 2024 10:08:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] docs: Trivial cleanups
To: qemu-devel@nongnu.org
References: <20241219150203.55212-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219150203.55212-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/19/24 07:02, Philippe Mathieu-Daudé wrote:
> 
> 
> Philippe Mathieu-Daudé (3):
>    docs: Correct '-runas' and '-fsdev/-virtfs proxy' indentation
>    docs: Correct release of TCG trace-events removal
>    docs: Replace 'since' -> 'removed in' in removed-features.rst
> 
>   docs/about/deprecated.rst       |  2 +-
>   docs/about/removed-features.rst | 24 ++++++++++++------------
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

