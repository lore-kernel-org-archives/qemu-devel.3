Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE433C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZH5k-0003Yq-RC; Wed, 31 Jul 2024 17:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZH5i-0003YN-7K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:42:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZH5f-0001X9-Nd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:42:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368526b1333so905937f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722462154; x=1723066954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0MHeDKejPQn+O1ezZ+77bbqs5YA5Az02kiwBUXFxTyA=;
 b=aqoDLEn/yjx0BiByQHTrRhMpMXrWPAOa0N7jEytU5YecK1wJkSyw36zCOMwFbU0YVn
 9qG4K7O4yEbrP4rKPqMwIAhRiKNDnkfbZjCX+EVL0O0JztRND4tUbYh3/3U3gnZCgyHF
 EsDxuW5O+SXSXZjCbsB+0p3ZPJHWA7GkxOY5cwHHFrVmAyTzCx1uz8mNN9+M6XRIyScE
 geWnExfiaBzZPSCVunB/7uZ9QOOGR+UpQ2mv3/Jn2Hy9+LHFPbka2G4IgevB8SnDCCX6
 AJbuB2vYw9GpdGnkNnpYS2ed+AIzCHtEG7VSYezTnVpYtKVADFqHwqao9SYJqWvTrsow
 CYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722462154; x=1723066954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MHeDKejPQn+O1ezZ+77bbqs5YA5Az02kiwBUXFxTyA=;
 b=n0P/PtM01GfcT4f612oburvZG0TELmcZ/gFRpiPH0du9O7ssuDfAwUcMO/dIRS5NSD
 UtPQtkgIKGZlnRyU74j5osr5Xk6vohp3rGeyAZggK2yzNfbNLyJmd588etGik/4McRWG
 +jBG21Xqh6lXn0qNtLwtjMJ15SlpDRoEKjroUHPheC7X1C95j58sEMDCg7FfAeiyGyb9
 EcISNbUuffXYywoXE3hy9fSlCWmYr8pi1I3fsVCg9/8Hy7ToXAw00UtbJg0tbRcDowYv
 h6oBMKS3OCHJZ+w/dBAWAlM9psy8vaZQPNjSCu+03IhTRkVz4TpS/BdcBYVwr0nNTW5+
 54Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP0jVV0bNYIsybd0XicCKPREyoHHXUjlV3qqYCoOSi3RSyL5jgTtV8HUzTW0WFBUAY/pQuvf+hLPlb/RxSoDbHGh104VI=
X-Gm-Message-State: AOJu0YzJcrxnXX4nuQtqdrJdJlBdRAD7HTp4mbm+ZQlcVJ2umuYX60wf
 +bteCg5LDQMCUBcBjircPFVw7Rx+ynUPr5p7i5Nq5XcR0Yuht0gSUbP2HCmxqI0=
X-Google-Smtp-Source: AGHT+IELhT2A2kmLRHY6QKA9b9L+51G7k6I/so5Pu+qKVVjNwvpi+6YqyADGlHENutdwSupYtlfmag==
X-Received: by 2002:a5d:5303:0:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-36bab48aecemr264814f8f.25.1722462154067; 
 Wed, 31 Jul 2024 14:42:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fd071sm17987619f8f.62.2024.07.31.14.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:42:33 -0700 (PDT)
Message-ID: <248e99db-61ea-4996-a3fa-efc15824451b@linaro.org>
Date: Wed, 31 Jul 2024 23:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
To: Warner Losh <imp@bsdimp.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240731144532.5997-1-iii@linux.ibm.com>
 <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 31/7/24 23:21, Warner Losh wrote:
> On Wed, Jul 31, 2024 at 8:45 AM Ilya Leoshkevich <iii@linux.ibm.com 
> <mailto:iii@linux.ibm.com>> wrote:
> 
>     While qemu-system can set tb-size using -accel tcg,tb-size=n, there
>     is no similar knob for qemu-bsd-user. Add one in a way similar to how
>     one-insn-per-tb is already handled.
> 
> 
> Cool! Are you using bsd-user and need this for some reason? Or is this
> purely theoretical? Is there a larger context I can read about somewhere?

Trying to keep user interface parity between linux/bsd.

Ideally this duplication should be unified in common-user/.

> I'll merge it either way (so none of the above is a criticism, I'm genuinely
> curious) , but I don't get too many bsd-user fixes and this one is unusual.
> 
>     Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com
>     <mailto:iii@linux.ibm.com>>
>     ---
>       bsd-user/main.c | 9 +++++++++
>       1 file changed, 9 insertions(+)


