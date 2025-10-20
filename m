Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D750CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 17:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAu7q-0007vT-Fl; Mon, 20 Oct 2025 13:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAu7n-0007v4-QU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 13:56:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAu7h-00045A-Ci
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 13:56:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4282fba734bso1083392f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760983002; x=1761587802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYJb7V5ZuM8dItSAc00vCEiwBfQP+gF15LRF3BIKW0U=;
 b=djgFL072e1DqTv0ZwzhwvBbpzVxtYHggPBDGtbQxsHyZv0NOr6nbCTjfwIlZ44a3Ap
 7IKjdyljbeeJcguT+s9Vx1Tj7WFfg3FuOYfARHUrggthUr2UB155zXN7KR3LGiJqRBOk
 MSuCu863LfYZb4fHEZyiESoKHkfg+Oxh+owPtVwuOJvOLROS2qftbBKKfTON0jOf5b3j
 ogDM+peXBcZhot2bhefNsHqTaG8mW48gj7NKTpFSvvfQjU25cjkKvXip6eTcmRPyHeAM
 pEA6AoGz2GXUdC3WLYmd6UbJiGnQCv4FtL5kFgK6TQgXdtG7DU3WQSaRd07DKhjQZJok
 +Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760983002; x=1761587802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYJb7V5ZuM8dItSAc00vCEiwBfQP+gF15LRF3BIKW0U=;
 b=tE73AsLzHX8uFGSxEsVcEY0//PAVNfSMOMP9Hu/h/iSKf/NxkAgSB5i0m0kZWY3xZD
 H/xaOFLfs5knuUYmwNDA7xz3uszhTb1oFV4Kq3NNWkwIpy3Ed3TcQvL8Cw2/+0swM6Os
 3rtp2PDPxeTRgWZZnR75bw/4eQqMHmJjpnLzddpuIo02pmW5P6oRhyspyyDvAlOtqe87
 XSL31O4dYsm9KovkDhVvSpPSVdHHrEQ3ucTEiQkp2xKgholXPT71SJoBgM8nblsUZG+P
 FlZt2PMNbUVSoXY4bPQw8ty2KPp88Uv8lUeCL1YoM25lX9ZplRirHhGI6G4Zbaf4XI3H
 rYaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9xO0cxyGXIeWLvI4VTMguX3AJGu+UeXukl9pQDqI50J5hBraHjoWkX2HEGifoHT8L6es55/cUHomE@nongnu.org
X-Gm-Message-State: AOJu0YzmtgNyopvnsuUKjCYzvZrZq1rt02xEaevNBPG0vj8fWg8PoHBr
 muNige11//zsKocnBEqpjMbRSlgsrozPgbGiVezkbr5ZFNLX+8RDb0Jw6DpV1DFKuQE=
X-Gm-Gg: ASbGncvgew000esaWFvXxUB3mwqO44iPyCkXi9L5LLh8hmPlnTvPJMfcpmcT+nem5Vm
 ZWvmeoyeZKkVaOQ+Pm7tZRQsQHX0uZmEFFVTFKC8A2p76BrHffzvtq65IwP6Gs9ntKTq5PHeNTA
 qhydMKwvg98Y5kxuzUbgkY8MYvmJ7ku4k6q7M/UX8CE33kTBkhkYxyvqny1FfNnd9n97nRlj0Du
 DCSnZ+mBj0E5WToxd0D6lqwcfzawfFSXDTBur/oxpwFu5JbTkyQ4uTDeLVRSb5ldlUR8acP3CfQ
 9ZD80umlolMit2jnB1KtFM5Ml/xq+vsLhBr1nNUJR3EgghJCGz/khkDVXK0nDmKzlYeF2Ym4dVq
 RY9d38Djwy8POlDhK9K0YvnIM3o/f0UXOJfNWE3TyeLTZBDGv00RZGCXkNoUbAnN+d0YM1RBNe4
 H9PwxZAZatBE76DrSqMG/iBVUgMcpXqXFqpGYqKg+Nmp6eklDJwX1/IA==
X-Google-Smtp-Source: AGHT+IEzd5CND2C9k9hY29kJMEDCvwU+rRdPai+OPHl14mkiJNfxZjlUQhXUX0mW4obfLTxSvnhWLA==
X-Received: by 2002:a05:6000:400a:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-42704d9e8f7mr10602220f8f.42.1760983002169; 
 Mon, 20 Oct 2025 10:56:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm16414377f8f.27.2025.10.20.10.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 10:56:41 -0700 (PDT)
Message-ID: <778a093a-bc42-45fb-b466-15be9a655a05@linaro.org>
Date: Mon, 20 Oct 2025 19:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitlab-ci: Decrease the size of the compiler cache
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251020161759.50241-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020161759.50241-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 20/10/25 18:17, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Uploading the cache from the runner takes a long time in the MSYS2
> job, mostly due to the size of the compiler cache.
> However, looking at runs with a non-poluted cache, it seems like
> you can get a build with a 99% hit rate already with ~ 160 MiB cache
> size, so the compiler cache with 500 MiB certainly contains a lot of
> stale files. Thus decrease the size of the ccache to a more reasonable
> value to speed up the MSYS2 job in our CI.
> 
> While at it, also add a "du -sh" for the build folder to get a better
> feeling for the amount of object code that is required for the build,
> and publish the list of files in /var/cache to be able to better
> analyze what is really clogging our cache here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Decrease cache size to 180M and save cache-log.txt as artifact
> 
>   .gitlab-ci.d/windows.yml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


