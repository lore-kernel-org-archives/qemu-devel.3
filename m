Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC24C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Z7k-00029L-LE; Tue, 15 Sep 2026 15:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Z7P-00028p-8o
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:47:03 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Z7N-0005rA-Ha
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:47:03 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso115297a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789501620; x=1790106420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEWqA4funNE75edyvGA/woE/lXH91/9o0skbK8mM7R0=;
 b=MQ48NJHZelxIDJubCzSjwu/u6By8c+CcLN7BkUZXe1YdpH8fzB+kbp8PViPRPJ7c0s
 ELZY2RmeCSOzAhwcyo0OXdmufnyujiNR4OYNqqf9ErM63EHv3OsIaosoAf0rbzk1o0zV
 mNQrAmCFugazV6Ht9edUpcqg68Z+r8MdAJjdeJ/L1K8MgBbM28JZBmHYX1eb38Ci2pI8
 pwTuw3f1zZnh4nbWNggMSb0DgA5el4U2p+Ffvw9L3V+SC/XLQ0f/wH1LREAjI60nXDAW
 egnT2tYzQsQbylbwhQzm2gBXK23ggZBILemKUvH/V2OI2v+BiPlD3g+JlIMRS/FDnong
 /bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789501620; x=1790106420;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AEWqA4funNE75edyvGA/woE/lXH91/9o0skbK8mM7R0=;
 b=rGTamgMMZO8hMUCYNdeTXupc/SC71V6XsES2vl/nkNSXTocP1kJSuYIrPTdbZ+wU4v
 vCFemjXLNDxCpvo/rvQRQPAHggNtDIY3cnisbnFh7hF6uWGttS27hRD2P30Bi8WCEXTd
 anrZumz3MvbvoDaczQ+lwjda3nRXQw3eN+LsG9Q+u7hVavjVhnzA9doGsGEGOuouUSV6
 mqQJlKvQR4qaijlrZDj5cJm/L+Lo/5kSS8aMEfBp6lkSribFe7Bt0txA+2mCBPML/eAa
 GWms8IJOcR6Vdqie4yS31IpmtLxJFX66SaOCe1w1GxhQAhTm066FkarySVNaCokI04Ad
 dhHA==
X-Forwarded-Encrypted: i=1;
 AKwUvByAp/5s0YehDE3qiSOVWnATe3fLlx3ukSgm3BB/li3N4a3n8Fydq27oq6WZq3p9VidQ1QYcR2NdsDVf@nongnu.org
X-Gm-Message-State: AFuF++nOIF3EbhtMv7vfAW87M+gDarFG7hf9Zwquq0GAc7Hs5vGmqVYS
 uYh4mmGB6Qb7mtmUBYo7LgAHZCx7DZKKUulVWpsIPVz8x/LTvVW8aW9zCKTqfXCwBek=
X-Gm-Gg: AYBFou0YPH0xCorJVoNwJ7blgLY+InwJHbQnjUeSDGYCXKgwJ9PkWAOBq8RHsqxe001
 1K0/nPQtWmzlwrl6HAWe4pRGiB3NwkXR0Akc1+4nbuZojHJizV5spx9tPWzJ7ke26x8Re+oNKvs
 FEd3hq5Nd3bWke6eGmvAdK4EkCiigUIxxnxdt9yLkhxIsfXNo1y6YSgoquvRCb6uGxHgWixyNHS
 W0SpjD00FBq4LB4SNtwdC24B0wq5ELvvv0sIM7McB/XNplD5y/h5nM+P6FzsbbbYN54y2ZmQj5A
 OQLyuWpUuWypZk6nNB5tFA08dv1UdgpYMqMQDk9CAfa29by7fw7T2oAzKe7e6duiS+fE3QoVIhM
 JqxhyiCpdtqLEt108Md6S8UakNU31dBirEcLmbxEhBT6ze2UGyWiJyBpGv9y9+kCrghjZDbljG6
 vJzWuifpQOzkD5ws8d8ru0CSTRN58QsI7eYu/7LlYautNv78EwXBc0RpzJXZ9w0Fp1eHFy8jEQq
 L0UpP6NAS2Y1/Q825lfJJXkqC/DNKDe+TK8xIQqRdIbuGHZNDPEsCas/D8=
X-Received: by 2002:a17:90b:4f45:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39debf6f167mr15902251a91.3.1789501619614; 
 Tue, 15 Sep 2026 12:46:59 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:c119:8717:353:53c6?
 ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm1338554eec.14.2026.09.15.12.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 12:46:59 -0700 (PDT)
Message-ID: <ad494979-4302-49fe-a8cf-13052be16720@linaro.org>
Date: Tue, 15 Sep 2026 09:46:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] Misc fixes for QEMU Guest Agent (2026-09-15)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

On 9/15/26 01:23, Kostiantyn Kostiuk wrote:
> The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:
> 
>    Merge tag 'ui-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-09-15
> 
> for you to fetch changes up to 839bc113fb5e2aea3fd0d68a929725f76cd6a9b1:
> 
>    qga/vss-win32: log to file during COM+ registration (2026-09-15 14:09:40 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2026-09-15

Applied, thanks.

r~

