Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93093FAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjk8-0001wr-Ue; Wed, 22 Apr 2026 22:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjk7-0001wN-10
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:24:39 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjk5-00018m-Ho
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:24:38 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-8a15ebb3abbso86811046d6.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911076; x=1777515876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=87k6iRM0cq1AqOpbg5l+FkvPIn8YNQEGfN3gaSKDurc=;
 b=E/gBvdb4QeJf76dJYrTvcFcpoij4A93dZhNm6xmWittpJ7JwQrco9oadTJOtxe6j0+
 s71BZwBLpv040so+neMYXBARDQiAfhWl8MdYo72l2ottKnf2zkkSpn+j1i0+O/orYYUx
 YPlgDMLHHzWn4iNLca6SKRA7P+BW87qEKQRLrU8PF0Dv3OzCb5rOq39KsbeVM7fAR0/J
 EMWgnghBUWqa7yAwWTamvrOcRlbjKBQGJZGuK1bZuMy+0n0czOVQ6ysJSq3G4Szo8Aa5
 fHLSnndjp793RUkB9SqWhU2RpW68wmGgGpFzyWmttEbaupsPGUyASvJw0mUzHICixtcE
 Squg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911076; x=1777515876;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87k6iRM0cq1AqOpbg5l+FkvPIn8YNQEGfN3gaSKDurc=;
 b=E1tk9LNYGY1MVWeoepF27kQ7U79icxDUPV99lImfxULPc7CdU0U9iLuPqDvRcNRoW7
 1BPkmkxTRdvLNGvl3tSylMUngNTSi3KqfT2fZo/y7UxuFz2ZIas4ObJ1RBRL5AwHL15Z
 NquGrxf08/wFSSqo5fUhvEN3VdEIApKH5MD+AArG6CpwHoVCwJ1b/UT4g38fTuMN5XOE
 hIMDsVSIE+6/tZJz364Zf1997YT9p+4EJVc0LssaZMz2MU7FKFnLf7tIWSH5HCtX0Rqw
 4f1cCfoWrWVJydcXYBgyNPWT59ixHB2KYppQfmSBeBN0dpZ1w/UTgj3osLGZskeOEGTf
 tx+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cwWotueheyRpsYEF4QAtk6Xt/qCoqM0MM7rcWmxf1Sh3hpifkjgpO22BvT1h/1oLx3QCpUJVXoknn@nongnu.org
X-Gm-Message-State: AOJu0YybHWpDilnS8kijLODaqETPgCudj5YkzUdu6hkRCErPi1JQpQ+p
 hH1xIK2oSUPgukGs7MIeE/E3X1VbSaclHd7mky7qYkEV3pydFLhAxAvDElQoeRNZ+vQ=
X-Gm-Gg: AeBDieuo5yVgJuuWioIG1YeeljISv2L/3xo4U98Caa6Fqw+072Lxd/T75BRBe8aSeDP
 fPDr6EZuPYpx0+7POww/NhHIQaCuDk8hPCcrNoruXoACKy75RCODAel3+Umgc15aAkWRfGc8cUT
 mHHASs7E/l3bwPZODAGRu4nJUcgcJDXjng5SCi9NiDx/4VCuUDNhCVakGZKpQlAA1yC1O4OUWrr
 bZUsajgISspWfpU1P6CDSmMl+H6nBNHG2J/GktyS3rtzXd420LfV/81V2ztm2M6jCJ2qCsDrleH
 6bdzWWlGgm8o0Tl1RfjiWx4UwRiFQS4S9ht96F4LM8+YIJAyPGtzPaoXUknGKeIEjlHD1NsknjO
 F2SvUrBYw23HHvRyz6cvMgza6a6Jbeg7UXIfM4xv6jCsm2GXnUynzFDjDAmsPtSz7RollJYL+n1
 31LBHz0A2aR0fLs7yLN9jfyZqijNwCGjKl/Li2xp77ZyR7EfB5dC1Xulrwcb/vyu0q3OYBI5C/h
 XWEVwUz2b23ySgNhNFhMa50wWcD
X-Received: by 2002:a05:6214:29e9:b0:89e:cb8b:a77d with SMTP id
 6a1803df08f44-8b028159107mr390823046d6.50.1776911076351; 
 Wed, 22 Apr 2026 19:24:36 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae6133dsm141599606d6.25.2026.04.22.19.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:24:36 -0700 (PDT)
Message-ID: <175487b3-cc23-4771-9ccd-0c033a13dcda@linaro.org>
Date: Thu, 23 Apr 2026 12:24:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/microblaze: Make get_phys_page_attrs_debug
 handle non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Currently our implementations ofSysemuCPUOps::get_phys_page_debug
> andSysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> For microblaze, we just need to remove the explicit rounding down to
> the page boundary that we were doing in
> mb_cpu_get_phys_page_attrs_debug() when calculating the output
> physaddr from the results of the MMU lookup.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/microblaze/helper.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

