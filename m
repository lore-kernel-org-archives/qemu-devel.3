Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBCCFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjD4-0007cR-HS; Thu, 26 Feb 2026 16:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjD2-0007bn-CH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:47:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjD0-00069o-V6
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:47:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43989bd056bso1127471f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 13:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772142465; x=1772747265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4XV0vrs+yS2MHghi2HrRGMSOl96qaN1kJSr8YjN1NI=;
 b=aDw3twD1GEpFmZ3TzVJpIbx0Lp4JORnwf7nSYhgbTlEIS8DUDpFfVxuYszJPZeirJs
 v/yT9Z8YGHghtwoorsWYLyNj08ivrTEtP5AqRuMHAm4vIpXUpcJmtCDG9OWRxhMQHwqh
 AmTQ7am/kY8rzyMbyyYt+/uDzSLUuXlobij1Zjhh9Z/25aK3lApdKUH5cGeyUuJkXjk5
 sYAvKaY34GLe2h0j1R1ffWrg3CtC57aE9OO8zcqFjbtbMuE2xLuzM22r6QSS/db+dq5i
 0m+VMZvKlFj86gmVhDbqHYe/rixvVU7wnvGIbPpA3D6ON0zqiiou6lGv8MKu5fwYlYKG
 FdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772142465; x=1772747265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p4XV0vrs+yS2MHghi2HrRGMSOl96qaN1kJSr8YjN1NI=;
 b=em+HYlBYe/bKmnKLUtgp2FnENBA27YAC37HF6umr1U535EkHYTLYCGb0H7Nln8GLun
 ZR/Qk06MXpRZRrRCNYaI3hnzZ369vfIt8LM/mNabUVXB/YBwPyFy+DiF//BTINuHCo2E
 XUUfitJ+PG09Jjn7RZskMnXt+zod/5c22cNkNDqmfZnwhzyvO8Tu0UE4J3IGMWi3KToV
 3XMfCAKenV8HiACXMyOrqax4ogoRGakE/inq077R/xCySv43FzStRTYz0k9+w9hBZnM2
 RNV1qn0H5p5WQ2nYCnfp5+WxCwr6MNdo6e+XO0WEYjAlQaRjEsNUcc34UzDpfe6nlNlZ
 m33g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKumjHC7tABfUz+Na4do/dltmD4HlRpvLNgrj2+K1WZkOnC6mYC6Mk+S7eOJu28rHA7kW/ftYdYhY@nongnu.org
X-Gm-Message-State: AOJu0Yyi9qEje7lY1FnUtFcP2MIzWSV3mvaLvs6dfklM9WUzEVZJN2/a
 1H0eVr5Ki2823dVrPM8ZsVad9Hn1s06JOmiIJiiCWnfOrRMK2pH0CrxC4ViozUMG7jQVGPZRKU1
 lHcy227U=
X-Gm-Gg: ATEYQzwNKZxLwpYoXzhqdNt+gpA2crlO/H0Bi92dwQDX8iM7WKTtTGzw5UZ3KzlpmQ5
 BvcUWYuC4Zj66hzy9MKdBkx6HF+/dKgk2PnPzizO6lOvjQm2Rc35Wn+Ge5XFHLSsxR0PfAHy/mU
 lM6rhk71PucJsQtv7OHmPPc+6Sk4L9lQBACrMcdtFRQz5uCBrH6umAZDOInvpbonnG4glUqq1Kv
 TbZz1hJ4zeG9fz7jOz/B3uWesgOtPyOirOKOWeV1K4HORq+ObUFsRguKiI7ZH+iHhRAUPsi9FaO
 DH6KpGpb9MCMfMIemNlVLaEBI+Gs4lQC/UOk2AID8PuH//C8iS/UNK564VvwQfBT9UbXhLVwl2R
 lswi0fod3YaPZ9iQ+4K28AQ5kIisK148u0wIPZLteM1Pi40OeAz6qvUjD1j7qG7V3FDuSGaVpyH
 UoNwNBUk7+Xqw0l2+VYi2jE61cYToazFL7+WNaUUTvxlwvPg5Gj+gpXmFS8oMcIbYIlg==
X-Received: by 2002:adf:f144:0:b0:439:9df2:cddd with SMTP id
 ffacd0b85a97d-4399df2ce6emr411069f8f.7.1772142465303; 
 Thu, 26 Feb 2026 13:47:45 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70f8casm4098167f8f.14.2026.02.26.13.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 13:47:44 -0800 (PST)
Message-ID: <02977c5c-0ec3-4686-9030-7023e183ed04@linaro.org>
Date: Thu, 26 Feb 2026 22:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qtest: Support comments in input commands
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260226175700.1319767-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260226175700.1319767-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 26/2/26 18:57, Peter Maydell wrote:
> Allow the qtest input to include comment lines, which start with '#'.
> This allows writing an input file for qtest which includes commentary,
> like this:
> 
>    # set up TCR in bank 0
>    write 0x1001000e 2 0
>    # TCR TXEN
>    write 0x10010000 2 1
> 
> which can make hand-writing or annotating reproduce cases a bit
> more convenient.

Great idea!

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/qtest.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

