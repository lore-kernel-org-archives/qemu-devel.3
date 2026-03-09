Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4CAF4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdCx-0003lz-7d; Mon, 09 Mar 2026 12:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzdCj-0003dh-Ox
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:11:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzdCg-000315-JD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:11:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so8861885e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773072692; x=1773677492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g32tjqVAu2oP/ulhrFDylX5ithMzIYRR/2FgJayutUU=;
 b=W3ATFtVYzvnvh/OrF4SxNDi2zPnDwKSk2QglDGAj/Ay4AWEPiKcHhBq1JzSuS5MsgB
 uJQbIf9paC/Mg4tWquIf/pfPtoNOcyN4CgPFQygMXCNhgoLkhamXbY6iP1pP8ebOAhm4
 JJCZLrWwhRF9diNiPXYogtJygy3Qz4Ct81WfzFh/JhhYMGe7ROEyZ8GYL5ULXoemDsg3
 uydgnHXfQ2sUOxS+woEIxL9fIWYlKgzR/M3StwWPSf1Q91gUs9ki1uacApi5gdsvaYWz
 0hGX3Bzs0W/cCZYM4E8v8IkvOg1FBN0vJ7vvaU/BO7+BFsANlgqpHJuGEmVlM7L/Gahc
 rHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072692; x=1773677492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g32tjqVAu2oP/ulhrFDylX5ithMzIYRR/2FgJayutUU=;
 b=cIXEVh2x0rr8qyIXxtQo8wXIvyfYV/hENr7MZhUdSJ/3+MvEennw6vDq9RwG6E16M7
 Z2ul5j4WL8K172PlynwW+U46wOTGTOb9MYGBAlM1gJ6+CTJkMTmFemcnzGYvd9iecvuu
 qI80S44r0lppxairH/ZZ4cJVfByT9v2a7mGy7NKPmTYAruWnrkQRnaCZWoD6m18ONvFR
 daECf18DjXCQvzqOpsJar8HU0naHGC0ZfKymGOKgq1B2EyKbw+r8OAkDEKBihCvKL2nJ
 KRPew+wBPtEK49uOo+NU3JYbHptwboHWeD7JmqsPLh9FhYQ8stIuzaBFwteYFwnfsqj+
 4Fxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/UZ5Loi8xjvhRllD4R1SsvJpxbcvh5KBZvm7JiT9WHnHyvsozgCJ7VSYKz2k869gIFrKaIIHE9cIT@nongnu.org
X-Gm-Message-State: AOJu0YyH13CPFwMOz7Gi/OQAw3CiGi200YOLhhNnHL3EI/9Tmwa0+OH0
 DaS0ll23KSqCiIxoCwnVZjkcjlLQxfI3ARO9GIX9f4QHwspzBWR9ZFvtOP1zyR3YxC8=
X-Gm-Gg: ATEYQzymAhseyCFQKEjHoUKWKDzsq2877muzhQEE2xWv1zCHxdzOiFNwFflxKXE7JMp
 QyZ8akgVpRIXMt+5tSj9Xkv4goJVu1QlZV/G8XjLcZDRnxwK77fYd6RWuf3oH3VJjtDbXQ7n4A0
 49hRLr/K18BsFXU/nqz210saKODzOCfEqztnzQf6grLhHzd/UbDK1IlANonr7JOzn6sbDmdmRFr
 vxFlnpUGwsi4aK4XH2KrIg9P+/PkirrPoN1Mw2W1JihMNXr9+2G7wn8xw25qB0QOfm5WZ/oUGSA
 mExVZYXvqEQZ/Fx7zQJhjBMTqLj/FvKrzVIDWIQkuRQPs0SLqKlXa7prOCcoIPc1TIg2J67I7W8
 Y2d5B3WTs+H0JEogvgzo9857BwfVMlg1T5Q7ZOMWtr00iuO4JwX6PkGXEq6fMceL1u0ILhLlBlE
 sfeiOJWN44kBk5Qw3HX8aqVeQKZMDJzpgNH5R3gtlfs7kjFj88uYZEtuKIWToUnB9E1Q==
X-Received: by 2002:a05:600c:4447:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-48534b38969mr102212265e9.10.1773072691546; 
 Mon, 09 Mar 2026 09:11:31 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm135446035e9.4.2026.03.09.09.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:11:31 -0700 (PDT)
Message-ID: <e1a56274-5154-4b79-88a7-bffb292988ae@linaro.org>
Date: Mon, 9 Mar 2026 17:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update the maintainer for the CHRP NVRAM
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20260305192223.6214-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305192223.6214-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/3/26 20:22, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I am not involved in the ppc machines anymore (the pseries machine was
> the reason why I took over maintainership of the CHRP NVRAM code in the
> past), so it does not make much sense that I'm still listed here as the
> maintainer.
> The CHRP NVRAM code is used by the mac99 / g3beige ppc machines and
> some Sparc machines, too, where Mark is the maintainer, so I asked him
> whether he would be interested in being listed as the maintainer here,
> and fortunately, he agreed! Thanks, Mark!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Merged as commit 85c0c6729da6ecce5e74fd4c7615509ace2d60fc, thanks.

