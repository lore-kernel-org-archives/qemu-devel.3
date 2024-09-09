Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7AECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmX8-0008RI-2H; Mon, 09 Sep 2024 18:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWz-0007xx-PK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:47 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWy-0007l6-84
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so2220940a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919603; x=1726524403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=41I4LFJ/R68dkcDRebU1UZ5kETU44EeFqhvLc4eLoW0=;
 b=ZM2eqFnMkAWezm2+8ykCUVwaQnBaTs22mr3sv/G5MQLt8tOVWjVhG4MnnCJmpx5ylJ
 Hzolc67l/nHo3+sqkl/2Acyu1D6fUqbaKdg+uk0pRdtjbJhvsZHBovXv8Yj/LZLg1V4D
 5y8b/nUZiE6JyOLjiUdvkKvXk9o/NX2HVmxMjSjwFAku4edCRdksbs+C/PnYPDh9060K
 1MsWlaOqePbMYyb+qx9dqHoWzH1O8nCGuoS3q58YZFCOdTE1KWq9L7Anif+ozboQBfoq
 W7YBd8UoXKFY+hGZQFl6okLyepXrMMBeiBDrL90LiWicONsiVVbHCoGOIM79uS4sHz0P
 Blgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919603; x=1726524403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=41I4LFJ/R68dkcDRebU1UZ5kETU44EeFqhvLc4eLoW0=;
 b=gZd3jfYAmuG5sCsrF6Zs0/RZdMqIg+eFtCghDvdpjm624/E1Wc0SypMuOzRx6QGUiM
 g21m3x0/J3UO7O8w7J9dQILYmeec39hUtMmJOvMkTRUyF8dIgFkDz+Md97WqYMW805Hm
 U2HJJqfUSnSWBJq7UST7oCq5XuQJAWBSxlWYrXIJrZhXbA+Ru9c//VywJzaQ/nQxjZrt
 zMY7LCOlR5w5Gtii49Ty8KcpEYHbHYQ6s+jRtW3KIo3C/btK7hHqMSqJP/f0cw33QgoS
 yLqtGs+RRybc9v7rrXouHqDby2qu/ZBNuO+xTkdlTcos+X3X/tKFA2ltGkzafnTW9KiO
 1kZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUrDnTakokNpor/r/ra8XM6Ocbcdb1wrTEvllduMhcrf/UkRJj6c8ll8woALTWk+7zH/ejOUerM8Mm@nongnu.org
X-Gm-Message-State: AOJu0YxE4+Vj8Ik/SlfmTBuLsMZqaU6zcw3GXnwiZbuSCYDnzsCIzZ/7
 Y455YHO7vOuqCTMcSxU1aJlf/I1Yt5xTbZ0etCKlHiySlSuQa6lc7U7PWh4QkMY=
X-Google-Smtp-Source: AGHT+IGpSeCOTo6viExt1XLw9R/ft3hRLnHZU4PhWtemVkLNRQGT9zlqokrnpXexth6zNgkl9vyoyA==
X-Received: by 2002:a05:6402:50d4:b0:5be:9bc5:f6b4 with SMTP id
 4fb4d7f45d1cf-5c3dc78aa28mr9209792a12.8.1725919602822; 
 Mon, 09 Sep 2024 15:06:42 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76ef0sm3472164a12.63.2024.09.09.15.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:06:41 -0700 (PDT)
Message-ID: <659283da-7526-48e1-b484-03668890c8a8@linaro.org>
Date: Tue, 10 Sep 2024 00:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/26] target/m68k: Remove env argument to
 gen_store_mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Use the env pointer in DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


