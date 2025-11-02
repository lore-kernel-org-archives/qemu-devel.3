Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC819CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 09:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFUKV-0003h6-Oq; Sun, 02 Nov 2025 04:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFUKU-0003gm-1A
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 04:24:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFUKR-0005D4-Jd
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 04:24:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47710acf715so16863285e9.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762075488; x=1762680288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pi0S7nGTEIbiDsjLihi0UzL/5hCNEc9KNZux+HwDMuw=;
 b=FyQSrz6T4ov0J9Cc1ad9M4FHmm8eF2WPylTARzC9Eo2jouZRE+qayUEjBVWHC4v6J4
 X4kuBwfO7krGKPim1ZUiocYcDR/hIt/W/Urd1FHPKCB8P3NI+7iP/f5ZFQeO4+iPEDjS
 8Ryb/CavTKvuctXmbCtciBwgTFhvOoQhG/eFsBCZkjO3E0er4nTN3Jb1mTL6bLuMm9re
 9yl+WIngZ+K8SznuPEi9eRnFZyBL9+op0+7P53ReSdDOEkTytiPECGpYM+ipoGJ5rHqd
 ZJ+TxWOg0i1Am5RxU9eI7H0mWWt/zhMvRMYZfQJvb2Ulhx0uSqTM52Yh+NGWR568oOvW
 JMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762075488; x=1762680288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pi0S7nGTEIbiDsjLihi0UzL/5hCNEc9KNZux+HwDMuw=;
 b=q4C7Ll7fHIUdIHdr6WtdKZqx6oqweChNZMWnZelCOdRm2ncxTwOpLA++hs3vMFZZmM
 Y9nt6ybVXv6eB+WoO975sItr6tT+lRjXEmB9VfB4ws8q1kqtp2zhIzVKj4XWtNboQ+Hp
 DH5mLPuWBnwxBi3G3SIaZzfaBjaXtdEJy84j0U2LE+2vOHeo2+1fKgvNAca7wDWN5SA4
 iRTBGz97MlDQpVefWt48oUOgVusM2z/B+E/gF6cocpkfjtD5sw1XDsaOC8dEqqeJLMTu
 IGE+KaUAL1pFXo8Qg/LfuZ1467de9JkxsmDYLFkxUwDkkKZ8qNgskmEAXtlPvyxDP5OB
 zqnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCDYdJJo/QgPB16QXsiRAaVoBCDvdFIq8tc5xQI6Y+Cq3E0fNIcwEbF+UJKTh9HMFBkDJZJb0kFKjx@nongnu.org
X-Gm-Message-State: AOJu0YxStjCHdoVxZLf9/QXtP9U4NsOGUB8OOkUYJIPBYM0l/cgM/AAT
 hF2K/4qiyBwyMKj68iY1yHer33Pyy2G6S2MisEfz4MJdu4dTbn26+MplKMFi9+87UNM=
X-Gm-Gg: ASbGnctAD6Zmkw84zcHuoQG3J6nWoN2zAcV1uhEgpX6XElsU1FNwTtgFwCEQUPgKzlA
 doRLnxagarGOzm+/kDSdiaOp7+Vg6NiBnJLQgeJ4cMGMgHUG7hEHCVaTfsxeiMIgupqwxpAFykj
 Yw5T2+PNpmVZnrQudI0smVaD4/YYEgXobnSeBuC9nNjD4HWzriZ0g6Hr/36c5TsP7zhmgE6i4AB
 BnYC5kiWHGxov3hTB5kpK2cC2o87/t3oTHsNUfGZy1rAKEcghiUIHVV3Gxi9eycmSNVn5F/SbQn
 IlJfJSZoa3fH1o76TSJhoHRD1i8vsDW4ecIZIOnFBr+2DCRkAVu1yqohD0KFoX26hJ6ItUw+rTv
 fjMTd+Qwzci1M1Yz6b2tv4Oi/S4MZxmSIC8CkVO0trS/ucpC9CoWfWMzCe/VWjf0bu9Glq+elNl
 jiHfuQG0p0kPg5L6W5O3aqr5iiE6kRqCUloFv6hfjgITSg/SFedus/V4Y=
X-Google-Smtp-Source: AGHT+IEAIFbDmj7slMEokEimeN7K74PTFXgUALfqI8iX3cmfLsf64svhJR6ScQbD9wPY+rsBkFGHNg==
X-Received: by 2002:a05:600c:4e49:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-477307e22f7mr73517875e9.11.1762075488274; 
 Sun, 02 Nov 2025 01:24:48 -0800 (PST)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429d2952653sm167616f8f.8.2025.11.02.01.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 01:24:47 -0800 (PST)
Message-ID: <ca3374f7-61fc-46ef-a12a-c91bc7fb711c@linaro.org>
Date: Sun, 2 Nov 2025 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial v3] qga: use access(2) to check for command
 existance instead of questionable stat(2)
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Rodrigo Dias Correa <r@drigo.nl>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20251101131456.792868-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251101131456.792868-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/11/25 14:14, Michael Tokarev wrote:
> The code checks existance of a command (halt/poweroff/reboot) by using
> stat(2) and immediately checking for S_ISLNK() on the returned stat
> struct.  This check will never be true, because stat(2) always follows
> symbolic links and hence will either return ENOENT (in case of dangling
> symlink) or the properties for the final target file.  It is lstat(2)
> which might return information about the symlink itself.  However, even
> there, we want to check the final file properties, not the first symlink.
> 
> This check - S_ISLNK - is harmful but useless in this case.  However, it
> is confusing and it helps the wrong usage of stat(2) to spread, so it is
> better to remove it.
> 
> Additionally, the code would better to check for the executable bits
> of the final file, not check if it's a regular file - it's sort of
> dubious to have anything but regular files in /sbin/.
> 
> But a POSIX system provides another command which suits the purpose
> perfectly: it is access(2).  And it is so simple that it's not
> necessary to create a separate function when usin it.
> 
> Replace stat(2) with access(X_OK) to check for file existance in
> qga/commands-posix.c
> 
> Fixes: c5b4afd4d56e "qga: Support guest shutdown of BusyBox-based systems"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v3: and actually don't forget to commit the changes.
>      I'm sorry for the noize.
> v2: fix reverse logic of the access() tests.
>      I should write code more often :)
> 
>   qga/commands-posix.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


