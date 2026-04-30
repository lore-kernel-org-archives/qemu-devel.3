Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F67FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJP1-0005zK-Da; Thu, 30 Apr 2026 00:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJOx-0005z4-1t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:53:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJOv-0001br-Es
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:53:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483487335c2so4878475e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524802; x=1778129602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HGKi/qzRNcrbu5upwBHRZlzrhlAbhd4BRf2SV7lcuxM=;
 b=p7t2BNfhZr5XJ3lre9Zgw+RQ/FFZel7rhTPTGcVRVjoiG7+0Fepm2lQcjPLcl5COQH
 01yXjbz0n5NgRwo6uIHcMQRQmY1hLt/LV/MBn6dmAFnS7z178hvGs96mj26nNi0lEMU2
 bJP+8F97sMY6KbIMXlENva7K6d6tyjdo4C81IL6jpoAdwcrdrjI4K6ctrOn+/Qxbb58U
 hXnf8O+yeBryuigduPdhjLw0qq3uiFJn3mDOMBnBjYH/5fSA6OeeRBKLUAorsMxMU5fS
 D9CMvpRiJvxjTVCnkLRguJdP8FLbIp2sc37bAmY9EtkKP+F0qMfPBoJ/Q6infl09q6Ub
 9I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524802; x=1778129602;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGKi/qzRNcrbu5upwBHRZlzrhlAbhd4BRf2SV7lcuxM=;
 b=OMXp8tEvoWgY+YMH9jbio1ggEfUaDhpNeiJz603Vq2OZVrr1YQzsFtFQxqxI8uessD
 yVBOekB0k9dnAgnVvHzZ+WaUXf/46JEoJmmtlAOK3dXtUJSw924tLHqpEdCexHJ1aVvz
 TnBrEnGXAYAYiOoUtjJ59E8CNB7nf1ujAPgN2YJCw8N+b7cU6bkbkKK/GHq/Y1b+RSxA
 wC1O64DQFbCa5BeAWji2tRfXv2F8an/6TKB2QUaYYN+D8i2vdfm4Tu7tJIldh9BJccfq
 SV6pPycttXuhDbIXPyU+YKf+cwWWJa7YK2jidx/YXsz8MCoLfxHjs48fKx55MIDMTdpG
 Mljw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80T8tJbzX8MGqm/jOXYkJN5ZrFDy33NGD4nGyb4aVzrI38v8UXO+zsIuFvnIW+/QXITN8NX2OCQPUG@nongnu.org
X-Gm-Message-State: AOJu0YxISM/DyW2kAECdteQshW1BS/tfGw1P72mKBevdqZaOF2T4afpu
 ad1lSVrQxsYb+PYYYCToOjLnnAuOXfU5dbhLqaFYqLnUKdydpfPZvoWtSs/qccYZ2Zo=
X-Gm-Gg: AeBDieu3RCi8wHOLjWi2iLb+Bz0IeUuy+BzBpGQjjmBUe3YWa971tXPWtrICpjFdiwE
 6p1fdwpnEml/RyCl66roaMx/Qs9rCx0lAKWf/EUROfqgmrf4yQUxP4gHpdV7KSR8IHdZEnRJTNZ
 zX8IpN4XHqrnXu9TxlkaUQapY70EvZehqscDlsYpwQapwxU4r3eYN3zeWdjflTqC1nl0BeDY+o2
 rSKhyH1EJBCbYYSrA7KJBG3ehHQMuhha26AlDMOVzjsoWL3IAsDtOJ62LV5QQtUHf6+nBDb0B1L
 8P0KbSn/GeduTqm4g9pOWDeMmFfY6ps2H82zymeHN3TOXd4GRH/0tDSQ/rj5QrQ089mCYssCok2
 Es4fPRHPUOpTtyLTbh4KWyO633fIk9jENn/Ek3WOqSlifNmIGj9uRRQxt923nEWqExLv/Lvs76Y
 uFnZp0JLZhjwr5Pjht9qQLUBBGVk2+pNXHLdjKGM6+8UDFAVW8My7+kTF2w9rTrsV/oGHrvzBd+
 lLF
X-Received: by 2002:a05:600c:4f88:b0:48a:563c:c8d6 with SMTP id
 5b1f17b1804b1-48a844eb8bcmr20732485e9.7.1777524802092; 
 Wed, 29 Apr 2026 21:53:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217afesm10342782f8f.23.2026.04.29.21.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:53:21 -0700 (PDT)
Message-ID: <cb8ac521-8c57-4426-98d6-7df5ae5ef0ef@linaro.org>
Date: Thu, 30 Apr 2026 06:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/40] fpu: Return struct from parts{64,128}_default_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c                | 29 ++++++++++++-----------------
>   fpu/softfloat-parts.c.inc      | 22 +++++++++++-----------
>   fpu/softfloat-specialize.c.inc | 22 ++++++++++------------
>   3 files changed, 33 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

