Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8vt-0007fE-IF; Wed, 31 Jul 2024 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8vq-0007cN-Uv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:59:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8vo-0000VK-BU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:59:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4281c164408so29632755e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430790; x=1723035590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLSyX6zFymTvj4jmx0lZAzBqJUXkBdxutZEfpeLOrP0=;
 b=yEeUcFvHZaC2CnzvfeVihvVf9Z3/5JIMsWg6ytD/FSQIMeMHkud1j7pJD14dFQMnfN
 1AZvJs2cJ3VX9mMio8pAbTmDJdqqmfxoQXeW3DNTOX54rXgLx4iOntMUFU/fGAyOII7a
 gE77jY72Vjngd/TBS1nNyWN6+r1/YtqZsNMI0JnPfitMbn9C+cEqoxzcpdTAkp4eyN9A
 8afCABgritHh3uPJvrstNFLuXdYUEn1gsPLhlbUn2wPqikw6Krgie5kN6PskkNf6WeOQ
 rWlkLrj6xJy0ctBly6c0k65upaBfC2H45KxMZmsVJQc62gDMIRZuC9ho/phLi875GG86
 2UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430790; x=1723035590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLSyX6zFymTvj4jmx0lZAzBqJUXkBdxutZEfpeLOrP0=;
 b=MhwinJmDd6MSzDFetSBFzCV2jnGBCz7tgMYoqhOiongBww3RAyjcGu+EF79ysEyIP7
 MUOIWpoU11TbSrqCqyiN6/P6i4oUva2O3GSrX07ASiB7u55fUh7DmyoNxYoM4HCp1Cjq
 G6jlxM04FuseQlPFXOfUbbtrLXhn9ZBZabYKKqBtpTGALhE50qlauybxhmO+zjhRNzDh
 lOAF+NByM/YfpW3Gfnn4EaKu/ecUlb/bcBK4FOgFjDhSWMKhYSF4D+1aHLJ8pPMKY7Er
 1MEMIiRud734kd9ORboKDECcEg/p/zmTi8Cp2qtscXPeLg5EKusGL01F2htXeUMil1ua
 nzPA==
X-Gm-Message-State: AOJu0Yzg0F7MlcPl3UsTHoKp9wTKhn3uqU/OGVqPWYyMxznU7wKPOj7p
 wgCKx2lrJj/jaqhx1vsnvZJTgitRaym3nYAdk/DN4yPQ4mB6qAvEj9gpJy1Zi9Q=
X-Google-Smtp-Source: AGHT+IEzODNRbi7/rn4Hj4nzItw6LqYb1HfON53XWrKiXWNneD5Wf7iw28c2RpYAikKZEZ6WgUqw+Q==
X-Received: by 2002:a05:600c:1e02:b0:428:18d9:9963 with SMTP id
 5b1f17b1804b1-42818d99a9cmr80307385e9.22.1722430790486; 
 Wed, 31 Jul 2024 05:59:50 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb98040sm21289625e9.40.2024.07.31.05.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:59:50 -0700 (PDT)
Message-ID: <bcb99096-7013-4b72-bb64-7ec91cfeb567@linaro.org>
Date: Wed, 31 Jul 2024 14:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/024: exclude 'backing file format' field from the
 output
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, den@virtuozzo.com
References: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/7/24 11:47, Andrey Drobyshev wrote:
> Apparently 'qemu-img info' doesn't report the backing file format field
> for qed (as it does for qcow2):
> 
> $ qemu-img create -f qed base.qed 1M && qemu-img create -f qed -b base.qed -F qed top.qed 1M
> $ qemu-img create -f qcow2 base.qcow2 1M && qemu-img create -f qcow2 -b base.qcow2 -F qcow2 top.qcow2 1M
> $ qemu-img info top.qed | grep 'backing file format'
> $ qemu-img info top.qcow2 | grep 'backing file format'
> backing file format: qcow2
> 
> This leads to the 024 test failure with -qed.  Let's just filter the
> field out and exclude it from the output.
> 
> This is a fixup for the commit f93e65ee51 ("iotests/{024, 271}: add
> testcases for qemu-img rebase").
> 
> Found-by: Thomas Huth <thuth@redhat.com>

s/Found/Reported/

> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/024     | 2 +-
>   tests/qemu-iotests/024.out | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)


