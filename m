Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D180C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNU1-0004MU-NE; Thu, 03 Jul 2025 13:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNTz-0004Lu-ST
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:12:23 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNTy-0001fc-4f
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:12:23 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73b1fbe64a6so55376a34.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751562740; x=1752167540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6/h5ogdXiK/uVnXKXSarY5BqW1pH94waISk54G7iHsE=;
 b=PAbZmQjbZWMOrecpb1xvQEXOdqBYjrhfyApqxjcp8KIfBB26ftopZulfo1Hhp5D/pV
 1H/NkZqzeQJfeW3TJ6H0cGAi8tP5Bj1nsgzHambGfk8nlk3VLm/I2Gen+5K/csZ0v2sx
 CCAPAs+N1y1HNzSJLFOv+7ZrX6qRbE+m/LxGToxJtfldxyk52kn0hsLxVxGAEYLjJnCv
 0Tri81OA8atVEYxpDs5WBq0K+i+TzWMIPebKYcM1e1oHptd9Wa76jkEx0RkdgQ2Octg8
 pvWibjuoVPwd5aUrO0iMuGsr3WIk/IFdV+G6qFMD1pOKmQaw+NiP6ybED+JmmDiC3itE
 vfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751562740; x=1752167540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6/h5ogdXiK/uVnXKXSarY5BqW1pH94waISk54G7iHsE=;
 b=oepnTNgzxDhykBr4JBL4N/dIrSR/PG+ftYspouatz3NCG21kx/ZDGQ4cfSv2oG92+j
 on8SExMLEgxoQ9xuAoc2hjaetCfmdVzPH3YKVIVajijwbfAtwFSQ15r6S40SISX0pUQ5
 FcGx6qPZn3IOYBEL8yWIaDSTE6E1VrT8gripmstFyTpKDHs8MH4ETYbYHsqX6801DVWA
 G/0XdcTnkFr/scuQcz9wHgr91JLwHyNcJqdJqzjg7NpR7rrtHMIkpzClGw1Pu0S2uqDx
 DWSoxQaQP88m+MP8nzeLABDEoFBglWanll6Nk5w0Gq5n4k2GTyy5+/fw9YxVo5P10S5K
 uccw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8S/NMQQMhaoCLRbDKmnDrC9hUR1M9jqccF11/7O4xdciL6pqm77zGD8jAd4TpFYTee6CcWM6l9UxX@nongnu.org
X-Gm-Message-State: AOJu0YyRfkM2VW3UORYYinJwsANtAu3TmnJ1crxK9/NEpNA9+RNTcmi5
 JlRq4pNcjFMpBuoWFYVKOdqRM43OHdLKTNibP6eP+ENdUHYHrCu4lTgun5L2ll/1wqI=
X-Gm-Gg: ASbGnctCTrBWR79+XviY762MslN221t73eKWptkwNCSULnsvaqhK/7Zn9Ca+CI3IcS8
 3ACUYv/2RiQIgM1N5BuEUo+4OlnBCaSshmPbPfxjydIB4eO04gQlTGo9I2U9acmhR/76lQClriA
 +wn3R/PmYj4QgB6GdjuSJIi1xOWNR5bfWlpJjLd7xfDSlG/ll0vTBjIfPAJkXawO7SoXiE2aZGi
 93+N65YbUvFlwabEdWs7PPP7vGoTiXkS7ZRPl9dzEbwUeG/kqZYbWJJO8CXSbk7u6/cIpL/c6Of
 RQG508wlM7aNqLbFky4IhTCOIWJWbmcya6kcZalBPP7exyyKnKdJxuFK4t0SzK5UTQvpNiGy22P
 z
X-Google-Smtp-Source: AGHT+IHO3PrCujEgrAw6g6GPk8HJE/F+6HZ9nBPMuesrhWcWeahUViOMPUZmK+mDUFvWB5LU9spA0w==
X-Received: by 2002:a05:6830:348a:b0:727:4356:9f07 with SMTP id
 46e09a7af769-73c896c3e46mr3517299a34.14.1751562739981; 
 Thu, 03 Jul 2025 10:12:19 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f93833bsm29086a34.51.2025.07.03.10.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 10:12:19 -0700 (PDT)
Message-ID: <de651fac-251d-4bec-9b27-6add2da0de4a@linaro.org>
Date: Thu, 3 Jul 2025 11:12:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/69] accel/tcg: Remove 'info opcount' and
 @x-query-opcount
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703105540.67664-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 7/3/25 04:54, Philippe Mathieu-Daudé wrote:
> Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
> released with QEMU v8.1.0) we get pointless output:
> 
>    (qemu) info opcount
>    [TCG profiler not compiled]
> 
> Remove that unstable and unuseful command.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   qapi/machine.json          | 18 ------------------
>   accel/tcg/monitor.c        | 21 ---------------------
>   tests/qtest/qmp-cmd-test.c |  1 -
>   hmp-commands-info.hx       | 14 --------------
>   4 files changed, 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

