Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70F7C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmPp-0007NS-Dy; Wed, 24 Jan 2024 18:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPn-0007K0-1G
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:12:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPh-00043D-Su
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:12:14 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6dc6f47302bso2785088b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137928; x=1706742728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zL3mSug7ypJbX1MFggy4uUYgCNI2fpmdw45ztge7c4g=;
 b=Gia+n8iZ8zowOcI2DVXy2cyATlqper31GrokJmblpkhocve3Pcl/6Y0eTxnlZ/MXAE
 Ze+JTFwSNQyZuQy7mn2MsibaETrOPteCBIbDAwurViUCrAJjPbN4+nWJZ9JNhVPvwvq2
 L2fUCPNotcGOYGAJGploullroDD4M/P/GYYm5xr8/bQ+tQ8miFtYtKxTW1P49zOpaA23
 /nsrzG4rd25jYblE4kszaDnW0Rr/AetEVkO9S7lnr+y2BIEAMZkSBQrl5vnVMRXNtHYy
 LYmA3K/kq2qNLbX58cxDOCcNzfnn3NrpiPEWhLBbax/aARmNQwDW72K96Z0wxlv6Gxkl
 0lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137928; x=1706742728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zL3mSug7ypJbX1MFggy4uUYgCNI2fpmdw45ztge7c4g=;
 b=oAmED8gC5IMTHzRSOOXtfGZ22pd/mNehAwZU/y8bHQTwYSeStnOtyrmHRU9Mb1T6zv
 7ArDngoD2WASKC2BbCmgJpSi5Az8Ne4H5TFw+kjQ+y82KUuwov0lHOiFmXVwQIU4+Di7
 y8XIkTHmBhy3ymskRNY/WxwsMIGWb/XFpnHyq8zz+BnFP1QbI63k9bi/2rGrP5Uvc6oG
 sUebfEB2U5DVKL7m1c6v9/GiGZbaEG+98PxfcWfPeNNVYj49rhSbcVUmGJ6mzEjnDjYF
 YHyxjgcd6ohcA8HhZDVidDPZ1PdbhcncSwBDP0edsiVJld/R9fXMtYzFDA/vcp4+Bu3p
 BhyA==
X-Gm-Message-State: AOJu0YywPt6OsVaMHQLqssvnHT1U67hmu+8h2mywpOEXzTx5Mh8+VB51
 TF+aUovhRdGejE2liVDd3BnwUBjnhP+uKfvuBIqgg6sGLQNujZPcPlrsb3K9Bcg=
X-Google-Smtp-Source: AGHT+IHo5qpYtEZY9ogdI+E1LRI6TZngKgj8KgmY/EJoimCb2QeSMGaV3l8aFSctNVXKU/3o6FO0WA==
X-Received: by 2002:a05:6a20:938d:b0:19c:5651:adc1 with SMTP id
 x13-20020a056a20938d00b0019c5651adc1mr237077pzh.38.1706137928455; 
 Wed, 24 Jan 2024 15:12:08 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006dbc750ea5asm9684090pfu.196.2024.01.24.15.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:12:08 -0800 (PST)
Message-ID: <647778a6-9711-49d8-a160-76be371011ef@linaro.org>
Date: Thu, 25 Jan 2024 09:12:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/arm/aspeed: Remove dead code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123224842.18485-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> Remove copy/paste typo from commit 6c323aba40 ("hw/arm/aspeed:
> Adding new machine Tiogapass in QEMU").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

