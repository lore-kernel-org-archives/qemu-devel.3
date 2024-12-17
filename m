Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E9FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZM1-0003UQ-Rt; Tue, 17 Dec 2024 10:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZLz-0003TN-Jx
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:19:19 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZLx-00041K-T9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:19:19 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e2bb84fe3so2580459a34.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448754; x=1735053554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9p0LNm3qLFAFILVMQAcHC8igwxSVDzlwvkJZiPpER3c=;
 b=crWaqRtUVpO6cM2cYl5b1KYI29SquORPkHaksG5yWT5bj4mfnblfPHb5cGC+9M0wyz
 twGOrlDwxjXRz6NKm1HipuRku2grtU4F678cIVHjr900PXWBRf5iDkx2LhaF34idiJKU
 madc8xrtXrI4R+NyC+FwDtWBB41uYlR2cfUqydFdHYDESJTcBQBcU8o5PP15XUXNK6oG
 OWhrBbZ9v3EbKbgwVwg/AtGOWufxZaG0azVrNrNz/dr8Ps7gVeb+KAbRjwvAQOinH6GR
 E++WKog93F0AsqhyBIEza2LkHz9hJsWQglIEWG5OCu+hTzTn2yHkWQ/q2GJZTa5vZOHn
 j3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448754; x=1735053554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9p0LNm3qLFAFILVMQAcHC8igwxSVDzlwvkJZiPpER3c=;
 b=pbbOrMZkG7/AnUeYH/taPfy2OyMIcGAJS+G87tO5f/+ca/YP7W8JxdqgnPCLWQXcBu
 xk3PT5zgcf2V1rO/4rq2f7ugCSshyXRWiC9poUvPQMFZBwRx3P1LArfCzCQMDiVKGz87
 Dd6dSrBm/siTgu2pdYZ0H6H3DaS0Yv0hOT5ZpkYv4No+Rryw+4ZwXpeFmPrx+MZH5EpP
 9QmqR2rrCFKfG1UrfCFRU6tfrvXftJVEHvl+BQGZ5dlfas52SxVcOKfxj8WwJLv8DZtx
 4B3i4R0Qb/OuXcgRBuh7MeszM3PhUJ5M+gWQOPUWUnYZihTQW95I2RaeDO2eJc2EtQ8X
 7eFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXC9iz5UWZxhrsf+BjXDD2iQ4ma8T0rMs9YYru+hCG6ZHh96ZLzebP00yED4N6VyvTZsoqFyZtBc0j@nongnu.org
X-Gm-Message-State: AOJu0Yybi1EdRM6elnpZDXJqq/IirnF7SNlaVedC9Fj7Wdzhngo2Lt7b
 pcSfnPLhMjg2ObcK/zhzbgALpKiXwbsBPASQjtCxhNUZJdY6JbaRIsAlx3P6rNs=
X-Gm-Gg: ASbGnctxbIU/PuSRZenTKosXImhV7rTDfFLNPfXb9qUNkGvr38QXyqvFunREFam4OtD
 FGqUPuwvwms8W29jwkHqUmOvJa8MWt3CPYW+nHpNXhB1t+nBefaEzCVXfADCh/UczB+IC4lT75L
 PBHo/X01O0CfXxuoycpOnX7cEzPhpEeq7DAXcL8XSw/gP1/7T5jb1VAWDJ+T+RIcZYG+lMezQj9
 gHeE4+J7LKn1iOHQq3TkHNkcIAjFiV1hOmxUXYZXZEUrlhQUjngv+2aLglSJoYS3Jd/MhZ77Q==
X-Google-Smtp-Source: AGHT+IEBFpSNws9dn8lVnNFeuYsH6lQhznbDpUSEISBhFPjmflCQ7u21bQo8m3B3IuYdf96qjy2FXw==
X-Received: by 2002:a05:6830:7109:b0:71d:4050:b9c8 with SMTP id
 46e09a7af769-71e3b859038mr9568389a34.9.1734448754539; 
 Tue, 17 Dec 2024 07:19:14 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484ace9asm2058220a34.49.2024.12.17.07.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:19:14 -0800 (PST)
Message-ID: <49bfe1f9-f4cd-4f5a-b279-e08637364bc4@linaro.org>
Date: Tue, 17 Dec 2024 09:19:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] contrib/plugins/howvec: ensure we don't regress if
 this plugin is extended
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/16/24 19:06, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/howvec.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

