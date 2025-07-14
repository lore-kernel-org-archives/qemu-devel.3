Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRm8-0005eP-Em; Mon, 14 Jul 2025 18:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubRi1-0006Qv-DG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:31:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubRhx-0006M2-MW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:31:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so2752994f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752532294; x=1753137094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYl1wwLlzSxiPeejDCnvNrvbQlhxiAL4jpQ84EECmf4=;
 b=wFLZrsc7v75eVGEpt1mCj+oY9vnw9TOa2bpM6rrxwkKKy7TNuqP7yYiWFWJNR242pw
 IJeDYOPwmB8P1qllR6Kr6VN0AQEY+nuu7kiUOy+zmB1FbuPa8pZoF0jP6xt+3FkS3vlm
 B9JTmGtniwFekAwI0o9N+VLMQCMmJ5u1rLDAj8V0XkVBYNlXqreVrW2CphGVA7DZEYNi
 7/Vc0dh4tl21sVPgzPVFIL3O/7M2wyguuCK+s8OrCCQrWWeq91maSR24p5pm1Rf9lpZb
 x84JGuXhZ3AorcbxRVKRSEPzRyAJUTP4wtkfz2lOuydEZ75eISQGGjWe4w8AYU6RrpbH
 UfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752532294; x=1753137094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYl1wwLlzSxiPeejDCnvNrvbQlhxiAL4jpQ84EECmf4=;
 b=n05bJVKNtmzjPlh5eqszfSsKT3I+glE2KwAa6SznPuVpSIV3/vsh9btgWwwLpWOZY3
 m+rpjwDwKzSRAfBulOr/cYuHRSoKKzXuSeCujg9QUijeISNM78tF6aivE8gw5e1HZi7o
 iptbgzx8T80fpJ0rCsW86adDCCzSmNC7oJRLgPhT7Z5HtyTrSFEMS2L2uq45VfAHVdqn
 HTBp4ODzyynKCscHcBuGEgOy67FT8lA5OKM5adbEOebvpK+9G733IacvQdW6Opy0g2yl
 ZIWvHxLrHsi+1fs3oSDJ97m/7eODbiiEUDwsQmVdepbPw9quu7lkvkdyIppY5/x/jByc
 CEWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHhbomxukzoi4s3Eruq3VZl2gpTaeWgIRCPx3aB6veZLojiRFI9t78TGfd1uRW1Whe5tXRtu461hNB@nongnu.org
X-Gm-Message-State: AOJu0YzMpXH0tA57nGg0jgNrwMd/faB+4f2UpOKy5TqwhZXFnuKSmCFG
 HL8MFQDLtaIUTcogAccsZdYiB8pJWjZpkAFHZ8Qin7E7Iv+WcDTzUwDIlVvweIlFUBk=
X-Gm-Gg: ASbGncv9xABJvlbxaMQsDiOfXgzThBYq1YGusXIvNHdJigvb2OtUa9OPJAdfjn80S4N
 geiZfZf9n9WoGfCWiCe1nUiUfpdqoy33bseTE+QymQJqFMC+4zfSQQ8q5aqj3GVb2ZEes80YwV/
 aoCF9jX/04O2zDJ69ql8XwcddCuIc6WB3MJ9IGSrlkmjTfRIXkS9firwsTrqd982nO1kDWDOiXC
 59VORS6DLqZf10NLiGphr72rpJCZVXHlQ/fXql2zP6ibRbK86rqGv/P9+mKa0Ya4r3s2rp3Xqs2
 AFcJy8ddLuzyPhnY6wiL8HE0CX8+HrGv4qcVG6m18lVPlBchbCA7MvWC/N0SrwDB0oI1GZuvsO/
 7Cho9bycCzaKFGwYBmBziyDQ/Aookgdbb/TCRgJ5Pha2sE6FwwtaMl3N1BbWLpO7MTzrbata7ry
 Y+YCGOcA==
X-Google-Smtp-Source: AGHT+IFN2s6hioHP4otrdk4oW/YwJJhwpesex/XruQRcGKhDnXjrhrjAPa+v+z1lRVVX1F6zxkNu2A==
X-Received: by 2002:a05:6000:4b1a:b0:3b6:1e6:c9fb with SMTP id
 ffacd0b85a97d-3b601e6d607mr5186774f8f.11.1752532293755; 
 Mon, 14 Jul 2025 15:31:33 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e211dcsm13175769f8f.84.2025.07.14.15.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 15:31:33 -0700 (PDT)
Message-ID: <735bcaf7-d32a-4081-9888-66d21cb03310@linaro.org>
Date: Tue, 15 Jul 2025 00:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap: fix net_init_tap() return code
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <1752525414-223746-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1752525414-223746-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/7/25 22:36, Steve Sistare wrote:
> net_init_tap intends to return 0 for success and -1 on error.  However,
> when net_init_tap() succeeds for a multi-queue device, it returns 1,
> because of this code where ret becomes 1 when g_unix_set_fd_nonblocking
> succeeds:
> 
>          ret = g_unix_set_fd_nonblocking(fd, true, NULL);
>          if (!ret) {
>              ... error ...
>      free_fail:
>          ...
>          return ret;
> 
> Luckily, the only current call site checks for negative, rather than non-zero:
> 
>    net_client_init1()
>        if (net_client_init_fun[](...) < 0)
> 
> Also, in the unlikely case that g_unix_set_fd_nonblocking fails and returns
> false, ret=0 is returned, and net_client_init1 will use a broken interface.
> 
> Fix it to be future proof.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   net/tap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


