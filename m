Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04906D767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6WHK-00081d-8T; Thu, 31 Oct 2024 10:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t6WHI-00081Q-3X
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:36:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t6WHC-0005vB-El
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:35:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so6398255e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730385350; x=1730990150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ulYpTjDeZag//WThlC70rNrZet2A1R1XnVC5a5LlhwM=;
 b=WxDNJtmmfduaJi1NIGtUeQQTrwaBIIJmqUQlYhl8tGu/zmeXzg2tyZITsCQnT+lxVg
 8MiLwoOcJ7PLA4vgU+rqB6qIKitSOQLVl9gqWqJc1VBsEDf16gxGYAzlJkCetW+h3lba
 ZT6GsjBkwNAGz8Ad3SgNKjk+XYKY4ZmEe2gW0C/Tp+1WD8PAkHnud9L+H/ykwjKMgRZP
 g3KCDGmm9BivIzdG9EHToi75wxTwEcDKKym0ucfrsElH6wSEVJ0V+bm4R05dpYLTvHwf
 /Ci21x8Lgd8d4ivclrDui7y7bCDZ0GrUoLXqpnEfRvz+cq/mJrQmtdgSC2PGmBpV4Xq5
 Bhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730385350; x=1730990150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulYpTjDeZag//WThlC70rNrZet2A1R1XnVC5a5LlhwM=;
 b=kcings+4dRhY4DqO/ltSss28SPN23vwEOHTwMr7f7igqUcS183/qgD/qUk6W5MeoL9
 ZKVmizzXnMqZ71ROHd0p3bUdSJ6feHVBvG64BYSVs1ZOHQQa+a9GWRX5S7lXV4n5/kko
 b9Eu3SPATuzAzcEgTPhRWgTmy8k9r9H7vJoYtJ5uSZ8+4vUCtsC4RD5Z153MM3CyzJF/
 mOhCgDfBIKHA1dklhc24dbahTI8hZIZCQnD8xsk6MfzzDgKT3urFSnnWkbUBuEcJKF31
 HOmYeVSRp+MM6JYCgc1QhCeo/xjAbl/KnYCAjvZscrvK73AmzCcwyzxG5Qtzw8gReW0T
 yvZg==
X-Gm-Message-State: AOJu0Ywk8q4VtqhyZdCj5+CyZuHQC7E09WbOGN5Grbm0tfmwVpmEB9ij
 RVW50h9EH28SiIeuMt5NChfXaVfERlvdblNaNubmducxwbNgcOlnvPtD282pfAI=
X-Google-Smtp-Source: AGHT+IGexTux1jmtrLFhzOf7rQq6/dh+5/Yo30eYwGDizV90Q+AeBD401P7ce/MQWtvXQmo7ja0Qug==
X-Received: by 2002:a05:600c:35c1:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-43282ff61d5mr2287365e9.8.1730385349988; 
 Thu, 31 Oct 2024 07:35:49 -0700 (PDT)
Received: from [192.168.21.227] ([89.101.223.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bb78b809sm70539355e9.1.2024.10.31.07.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 07:35:49 -0700 (PDT)
Message-ID: <36722300-bdfd-4add-b70b-8e99182325cc@linaro.org>
Date: Thu, 31 Oct 2024 14:35:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] linux-user: Allow custom rt signal mappings
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson @ gmail . com" <ltaylorsimpson@gmail.com>
References: <20241029232211.206766-1-iii@linux.ibm.com>
 <20241029232211.206766-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241029232211.206766-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/29/24 23:17, Ilya Leoshkevich wrote:
> Some applications want to use low priority realtime signals (e.g.,
> SIGRTMAX). Currently QEMU cannot map all target realtime signals to
> host realtime signals, and chooses to sacrifice the end of the target
> realtime signal range.
> 
> Allow users to choose how to map target realtime signals to host
> realtime signals using the new -t option, the new QEMU_RTSIG_MAP
> environment variable, and the new -Drtsig_map=\"...\" meson flag.
> To simplify things, the meson flag is not per-target, because the
> intended use case is app-specific qemu-user builds.
> 
> The mapping is specified using the "tsig hsig count[,...]" syntax.
> Target realtime signals [tsig,tsig+count) are mapped to host realtime
> signals [hsig,hsig+count). Care is taken to avoid double and
> out-of-range mappings.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/main.c             |  12 +++-
>   linux-user/signal-common.h    |   2 +-
>   linux-user/signal.c           | 108 +++++++++++++++++++++++++++-------
>   meson.build                   |   3 +-
>   meson_options.txt             |   2 +
>   scripts/meson-buildoptions.sh |   2 +
>   6 files changed, 106 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

