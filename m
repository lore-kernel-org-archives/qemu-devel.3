Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F3FC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVll-0002Lk-8b; Mon, 10 Feb 2025 10:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thVle-0002JM-RY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:32:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thVlc-0002Ic-Mz
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:32:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43948021a45so7498115e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739201530; x=1739806330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oenO1W94cVye508wdyozys7JL+m9rUg1uFJD6hc3nzM=;
 b=j645LIergyTterRBhYP/JZNPi6ZNUCrjxasMXqyvlrjGHhSb40HyIKIv2DOH2CZD5W
 CzmVEq4v2nLXAGd2XjMF5gQGnyERTmqkdFpDkcKaeEE2T3abJv3FdoNUqYnJz6L1Wzyh
 pX7DtaOLZMonYcjlaUAvy85lAQRynD1PJNpxebVIvc+89geLj7/so64lFDF06vCZTWPh
 tzUWD+PUogKK3SKmhs2dt3OxXjBYtzLv9Lo+nxvP2dL80Eb47ipI4BhXRL/eisuUz8xG
 eSD1L2Bc7V+UWi/TjuyaPNJ1HbGGnpx+Vgxynjey5zHDl2AB9YJ2XrE7qYVxLeaCl5OJ
 /wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739201530; x=1739806330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oenO1W94cVye508wdyozys7JL+m9rUg1uFJD6hc3nzM=;
 b=BkvRlYEWmCyK0z63mJjGEkoLTdWHOhtmOaLCkLq6+yDIBUi2VtUDNctxl3DNTn5r+8
 cMKnEnyuYRF7Sk8pgeesG5NxVzRad+bnXiF0lEiQk2qD1bFL6fd4RCg6Q6uoF6Hu7B88
 oNei6PJFryXgSW3lfXL6lSij1qmDzEiK8erpuk/bUiS2+qJcDe6wqViGb8TxCrGf5+Y2
 Ek79Ce/ohB+19IgZ2DzynPKZKVsVAo5MSAxDcZKrM+Ui0zJerV2xKa7JQKID8zDbZvNb
 RFudqGX7p/VgSHZNbJ233dG7pA6zcLnknIIWBchL3zZsvhBjTj3D+qB1HW6z3spesAyj
 Czuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUryS95SvlaG69/IIuHygpbL2UR0smUt27+HQg4Bkc7VjbBb5Npn9bGXcZj6P9t/DpzVuREvQY9ueiE@nongnu.org
X-Gm-Message-State: AOJu0YzDlJun4Gnel92L2ZKqQ5ht9JMBU7Ux9c4egazLPmPl2t+FM6Ub
 vEvxfwZTbSU+fpP90wEjt1FXwslxAIDDSRWEaZknTrBc5PHd1hmq/jaN0DkmtEE=
X-Gm-Gg: ASbGnct5NxVQVdai1Yqny1PG6YCb0myzhsBHxsbP4iE6FR8Zmi6fUdlqJplEr8aC/9f
 m3/lbYy+GIZcAo7y7BOx5ctIFBxc7kwchkqWidmKiCRjzVyhFQWahARqrMrkOPzHKuyV1sGHxq5
 0jAqergk4FsiJOe4sc43Z17eijidPy+McRS3VghiXUzUUrLK+wE1tFaiVZmmoX53LBDzYRxENga
 KTtSfSdgoMBv5H0rIQaKBk3NAQBWA6ptaMf2OtAmgWmxGkZJaG33Ay+Pd1u1kpYM841hT6MNa/B
 +JfH/bY2ttO0Fup1iUnwWQsM23aEIpZO0De5FVpK7f/BT1hH0siipEoC64Y=
X-Google-Smtp-Source: AGHT+IExnc56mu8YTkAPMABcnxXoztceLtLnKDhqj/ffub+WOzKCG/RFk1AS9GEWzPjL6iRAKpnbVw==
X-Received: by 2002:a05:600c:1e25:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-43924972ce9mr109769255e9.6.1739201529677; 
 Mon, 10 Feb 2025 07:32:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d964c71sm181978295e9.18.2025.02.10.07.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 07:32:08 -0800 (PST)
Message-ID: <2cfca5f9-4c2f-4777-bfb9-4700005780ec@linaro.org>
Date: Mon, 10 Feb 2025 16:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9pfs: fix dead code in qemu_open_flags_tostr()
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/2/25 15:33, Christian Schoenebeck wrote:
> Coverity scan complained about expression "|LARGEFILE" to be non reachable
> and the detailed Coverity report claims O_LARGEFILE was zero. I can't
> reproduce this here, but I assume that means there are at least some
> system(s) which define O_LARGEFILE as zero.

Is O_LARGEFILE a Linux-ism?

Commit 67b915a5dd5 ("win32 port (initial patch by kazu)") started to
define it to 0 on 32-bit Windows. It isn't defined on my 64-bit Darwin,
and apparently nor on other BSDs.

> This is not really an issue, but to silence this Coverity warning, add a
> preprocessor wrapper that checks for O_LARGEFILE being non-zero for this
> overall expression. The 'defined(O_LARGEFILE)' check is not necessary,
> but it makes it more clear that we really want to check for the value of
> O_LARGEFILE, not just whether the macro was defined.
> 
> Fixes: 9a0dd4b3
> Resolves: Coverity CID 1591178
> Reported-by: Coverity Scan
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   hw/9pfs/9p-util-generic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> index 4c1e9c887d..02e359f17b 100644
> --- a/hw/9pfs/9p-util-generic.c
> +++ b/hw/9pfs/9p-util-generic.c
> @@ -19,7 +19,9 @@ char *qemu_open_flags_tostr(int flags)
>           #ifdef O_DIRECT
>           (flags & O_DIRECT) ? "|DIRECT" : "",
>           #endif
> +        #if defined(O_LARGEFILE) && O_LARGEFILE != 0
>           (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
> +        #endif
>           (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
>           (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
>           #ifdef O_NOATIME


