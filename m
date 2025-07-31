Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D19C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb0O-0002Lu-Dq; Thu, 31 Jul 2025 17:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaiu-0006OA-Lk
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:22:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhair-0006eV-UN
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:21:59 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so146594b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996916; x=1754601716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RFA6186/i4KLp1+T6vxVdoG2ALb/XuPkvZRmSKuCI0o=;
 b=hIm668WA4UoaBPLh0wnonb0K8jNcyww+vaFaf/P3BtRJK8gvLdn6I8Gb05llbTUeW0
 PsPISVDB67MrbOiwVMTp3fk2ueQo/OR4iHlo6n8RFyeuLJw2/qyJA/UHYyrKKNF+Nlef
 4WK0lW9Q8mgjPOvY2SZNtFHpAsjp6scw184nKm3ycN0TxsnRdd8lhcP4Yf7YQgeOPyEZ
 bM6Pt30pymTH0YPIYPBIaRV1Dm4ZxmgqxTAAMkm5Og5GW1q/TTqQHhkvX7crL2cUNWgY
 7TIIJXmIeMNcrqGG5lkBXI815bUelVizZ6oBybjPGREQ5sWxiRl1TXYDK37S/pi/uH9q
 HQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996916; x=1754601716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFA6186/i4KLp1+T6vxVdoG2ALb/XuPkvZRmSKuCI0o=;
 b=D5KdxPpscfLJEbpI4C0Pcwq8fdern1wZoIE5UTGL4/JPDTu/j9LAkinXfEqF8kvbC7
 DGkcO8+plqH+k4CQXzSJ/mr0SHwD5Vp14VMi95mQQAazaxdjmUGdZPmScSe9MdNUvw5V
 rwPk1frADx3+6MquMkc7zVMAmSKRK1exwTb8dcmKaeCyIYMWOvlK75rAXckJxDRkgVtd
 I0yHROpNhi1ClPHx4qvgSftRbC+Nkk2t1F/YoZC6X9oknZoBTCd8OgKwiReiNlGlN19s
 ANj4Xte/b2D1N10PhJ2k1Q66uL9FbP6NrXWNRMnEYF/sgxlc1od96Gd2MwI/YnApsw/s
 DyEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgKkjYwsSXbAvdqTopxDSYyb5k6BqxpKfTbVwUjtsb6/G7SS904+UqkZDEud0q2VWIMlDRCTkaGGZZ@nongnu.org
X-Gm-Message-State: AOJu0YyrffAs6j8hA7po6jBa3iyv2lW8W2fecbGi23K73kvB/K50QOio
 FyX1kIzeyGYhmbBnVWS3dTT1XpYI8AqUitwjS0GKmDgzDxE/MOZJan4E+tzJkzWFuDQ=
X-Gm-Gg: ASbGncsJkke9AyMaUOdQegTIagq0fS3lfjtcqTF3XwipM5y3Z6BkHz+6UFunhV8lNRz
 KgF9H1bYH33Di1lqT4+oXwbj/6NrDO5UDG3rPXpTWQ1G7xtOMDMdCJMSefMEsxt9ym/Xds23STs
 XF8qV8JfKwGDipcvY/Y2DzqHel0DGfHZUqsSCBA3/MvpmtGCfp+Qz3YUHMl+SSjOFvvGLe18zPk
 YcRMwmiUXY9jV8m/MszcoxKegFvqfk37KT3J4yPWWMDYfunpnieC4V0JNfIYlQd6/F4yafwF3hv
 Kn/nipDLJ5t2Jy39ltsCbP0P1PFVcSi/3SYQEjSoFAAnafqYPbPOASrlyPEQtMiAnkr19atPIPk
 Fmy67H92bwRFL2J9AiS2LQ7GIs9cR2kW4EKQ=
X-Google-Smtp-Source: AGHT+IFbqQtjcRDPShJi+eUr3eRfdEYo/RZeMmll0w5f/mQToK34K/bd6E8E/Orns/unyli65sRXtA==
X-Received: by 2002:a05:6a21:338a:b0:239:2bcd:a08c with SMTP id
 adf61e73a8af0-23dc0e1efafmr14811880637.28.1753996916210; 
 Thu, 31 Jul 2025 14:21:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6d8sm2468307b3a.2.2025.07.31.14.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:21:55 -0700 (PDT)
Message-ID: <006a95c0-7a44-43db-96f8-271e5dcd7523@linaro.org>
Date: Thu, 31 Jul 2025 14:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
References: <20250731134338.250203-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250731134338.250203-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/31/25 6:43 AM, Peter Maydell wrote:
> In commit 655659a74a we fixed some bugs in the encoding of the
> Debug Communications Channel registers, including that we were
> incorrectly exposing an AArch32 register at p14, 3, c0, c5, 0.
> 
> Unfortunately removing a register is a break of forwards migration
> compatibility for TCG, because we will fail the migration if the
> source QEMU passes us a cpreg which the destination QEMU does not
> have.  We don't have a mechanism for saying "it's OK to ignore this
> sysreg in the inbound data", so for the 10.1 release reinstate the
> incorrect AArch32 register.
> 
> (We probably have had other cases in the past of breaking migration
> compatibility like this, but we didn't notice because we didn't test
> and in any case not that many people care about TCG migration
> compatibility.  KVM migration compat is not affected because for KVM
> we treat the kernel as the source of truth for what system registers
> are present.)
> 
> Fixes: 655659a74a36b ("target/arm: Correct encoding of Debug Communications Channel registers")
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Fabiano's suggestion for a migration compat mechanism is
> https://patchew.org/QEMU/20250730205245.2118-1-farosas@suse.de/20250730205245.2118-2-farosas@suse.de/
> ---
>   target/arm/debug_helper.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


