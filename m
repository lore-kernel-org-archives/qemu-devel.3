Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6E4EA71A2
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 16:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEUnm-0007pD-Hm; Sun, 19 Apr 2026 12:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUnl-0007ox-HC
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:15:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUnj-00019A-RA
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:15:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso28279195e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776615314; x=1777220114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDcbmTczLybVSLUt2z9CAZdPmGBw249lzetBYCjaOJ0=;
 b=eETCU1IY9f2EhPAJifDD8go8/Yeagd4nbbuKv1Ia+o7yPW6aCPivgqScD8nyz3N3Pl
 MKNW9XzTGWdtRoQnCPU9gayBRbjwZxXzuVlhQI3M/aPlP3wgBy6r6nFNZgotUBikgcki
 pPBVQaYfyMw0MmOT2RNGPN5krAAVbP6P0qzeEmDd0WedgRJesYSpjM2kg9UxLk0HxoVa
 cEf5mbm9U5NF7Hwp0Y/Cjqu/X2z3+AzesAaiyRz/SSh6LTJxIRIB9quCz+WtJSRq8rIh
 a+SRudVgptCcIa8uBG9VNyWVI32fHyXLF6lJu98Et+h8Bx3hWPwlZLC1IGF3TdRcPyhF
 8f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615314; x=1777220114;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDcbmTczLybVSLUt2z9CAZdPmGBw249lzetBYCjaOJ0=;
 b=WKJ5IjKoKlyzALZMA8fFAjjLCQBVN+kFx5JQGuV2N5ZmnpQuoRvLjMVVE1wIZGEHSE
 Csm4trPbjNyP4AW6ESeVT47Xh/hKPOB0cZLodWkNy94mb9aoXy7H8kBnpNjlcHGuN9wM
 ccaNzR/ySfEPJPfxnj8BAsjtoFtQSSLTkVeYNbW0i6+9HkCZbB+YubiNf9pg7jWoIVSV
 31mm7lH5l283EV+VFDAQodoqnz4qeee5S6fpgCA+w8jMX41GMbzgfGvI2JQTY81frxEk
 FDt3yQvgLvPIq2ZEAhS4D07yS1199fZOGM+zIkUNH2PNjvmLu9WRVyXyoE5tafF0IaRh
 DhLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mquVIo56LpJ8UNxsSgWk1J/EVLhB+I9xwFbnZE1DW/odljWP48GIu2KOHyHGCt4M4Q6rxpqZOtbG3@nongnu.org
X-Gm-Message-State: AOJu0Yy291Sb8BVTM4Edox/oOwXve9u6b2xucndwfaajBlDpvsrYQzmM
 5ZL34PHNtuJUhs+Po/7TGTrYes5g4uxpeAP2MTO57v6dvHkpf93+iRoT5kuk/aPDxJI=
X-Gm-Gg: AeBDieuR1vWlI8hOBiAB9tj75kR9T9Vt1n4HU9q9iX8x1SDAPGNQQ14c9y+m+0UnEeb
 wyKuvDVLXBEh52YdyI1V6FT7FMgd4IOpVPbqwn1jgLrRpR3oPKRe2jVLIdXBijgxM5HgB5WcxCV
 WGE/5x0Wv1qwiZxQdPiy52BhjQVHWJehwKGI/QHPyVGDkrNSvC5f8qSpkXxks2HTg7OzphbbiG4
 xmWrYyqbLYm+7KTteUSDD7jTmsiBscgo7VNr0w0fJf52aJgCVMK7KmoQsLMXnDK8+atw3n5W/OU
 sSzIqi+o8IFdgoZyQd/bRRsu9nSSDSL+/Pzj4Pn8FTVI96TezSasXzNsEm4qDZJ/LudU8UOkLYH
 RowBdgygaDtV8Sv5sgY8iiG3GjyaBOvvRRdd2BsaZO72IxJDmu+EnQzjbFZxH8RSl+VGjL+mDaw
 kQokdaS9bVOZ+dPvGaWt09LKQFqA8Jj3BY4mSiTv3d+nXZxQc3Ualb+f7jhQR6EVpVE391ODF2g
 SQc
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488fb8b91a7mr134923025e9.12.1776615313927; 
 Sun, 19 Apr 2026 09:15:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393d3sm319020745e9.11.2026.04.19.09.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 09:15:12 -0700 (PDT)
Message-ID: <eaf49036-0e13-44ff-8214-b1b20fbd0bea@linaro.org>
Date: Sun, 19 Apr 2026 18:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix use of pthread_get_name_np on OpenBSD
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260417120531.2215549-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417120531.2215549-1-berrange@redhat.com>
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

On 17/4/26 14:05, Daniel P. Berrangé wrote:
> The pthread_get_name_np function is present on FreeBSD and OpenBSD
> and has 'void' return not 'int'. We didn't notice this build problem
> on FreeBSD since it also has pthread_getname_np which does return
> int like Linux and we use the latter preferentially.
> 
> Fixes: 215235d365e49c72a85ea2940751e45419676031
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3399
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This is a regression in the 11.0 release, but on the assumption it
> is too late for further fixes, I'm CC'ing qemu-stable so this can
> go into the future stable-11.0 branch
> 
>   util/qemu-thread-posix.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index bd1c2ad2a5..089606c93f 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -568,7 +568,8 @@ const char *qemu_thread_get_name(void)
>   # if defined(CONFIG_PTHREAD_GETNAME_NP)
>       rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
>   # elif defined(CONFIG_PTHREAD_GET_NAME_NP)
> -    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
> +    pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
> +    rv = 0;
>   # else
>       rv = -1;
>   # endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


