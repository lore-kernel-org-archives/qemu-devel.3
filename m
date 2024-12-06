Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D3DE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZVR-0001uf-Bv; Fri, 06 Dec 2024 09:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJZVO-0001te-9E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJZVM-0005Yy-MK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434ab114753so14656855e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496015; x=1734100815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TLurNv+vebMmCeGP2GoUIEDPPuGDwPAy5lg2WnTOBXo=;
 b=bAkGhrOAd/Wrz621et5CqRrlEkIhYVuOzI72MMbW5fHn35jNGoXu7bhR7F7b21bByu
 KxJzhl3p6PR8StllmpjicEtLs4n6w8kpmGVtZhPg4FNn4dE8wlhxSOym5VPwnb5TNR4e
 1PgV3CH+0QxDMCjJG8vQQm7S1yxSFULcJjZuAaTynis2bc/MYvnC/YjJwh1Tm+aQials
 OVnvr/028GOBH2DYaD1vYZxmXDaeneeg91ikyi0ZPrY6q5TbgKs/br0H+sNDIGDeXLdd
 rnyy7FtW5xNeK8SM6HWX6RWjwqA+e8JZiT5jAzoX0vWMPtGZ3NipFaj0cpg+gli8obvz
 ZP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496015; x=1734100815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TLurNv+vebMmCeGP2GoUIEDPPuGDwPAy5lg2WnTOBXo=;
 b=OiTloibpuyVszNEbIvudPLftnPyk00HTewjIFTzpb0j3FMsMQaxKPfZJzlR4MvMd1K
 wbt8pjzbjhc/ZmO9R/8AYTpvQFdG/0uCnImpkScntDPWg6RYkKKLPZ2Mw7a44jlF+UBe
 nvD2VdV0lqWVCPwrFEEmDVulRK+qjzZ0Wr/fc9QhFZ0Ncnd5zSoquSnOUi5gshc0F3R8
 zkQwJW3eGzwhSHGCfwsdDpfQt6KSnbAOhtuxrLMOj/6YhzZXL0fUKcO0U2X/tHH8U5p3
 Zn1x5y0MQ/OCH6KMEIiE2VyalzMnVQS8+MZwyyOxYrjw5PS4otWUn+ErF5OXYoBPNITd
 +ccg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWteCf4gMiD/TuW02Ka3ATNTom7itC4KBP3UwR0igBR7pKJ21LlbfPhZ8ewwA6Btd+0AT5fFn8XM5OG@nongnu.org
X-Gm-Message-State: AOJu0YxpSR9uci2trNW70k9Q1UUHqPTgILwRb1zveEkwg86GdHSo3SR6
 f57jm2IqOCtrBQzPaZQxwkq3YTz1iQWDLRAU09YGPBImbId7nNWFGMeiFY6tLcs=
X-Gm-Gg: ASbGncvfIb0cdWUhfpwXJw65TWeNbmwYKWJ4wq2iHEUy6encbeidMwT4PzlV5VaX4NL
 qwIEFVdoz8dcSnGnFTo+FVqfjxpgDqad/+zjUTwiE+PxnLVcJbEBqMcbySjEFW43YN8BXY5gXfr
 gZ+EfHucCRu7UMVurFc7xqmw9kUWUzkyNe7tl44zigCF7jC56jfn/qAwZalLhYWtpDPVxtH8dJm
 mD5NLFxNNxX4ACGfjPZ+Zp+8XXQHG3r2W22PEm+ReoBZSBiyzEwhc1+SdBJMA==
X-Google-Smtp-Source: AGHT+IE4OKsUD+ye0UtIPo8s2bx4eSdbdfS2ZCpek/UnzazoGUch0EJd2gGWE4b/n1KG4vRQA3Ph2w==
X-Received: by 2002:a05:600c:3c9c:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-434ddeabbe3mr29676405e9.9.1733496015123; 
 Fri, 06 Dec 2024 06:40:15 -0800 (PST)
Received: from [192.168.224.213] ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4395sm4667168f8f.10.2024.12.06.06.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:40:14 -0800 (PST)
Message-ID: <bdbbdbf5-939f-4f58-8d9c-9e7d38ea0469@linaro.org>
Date: Fri, 6 Dec 2024 15:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: improve error from qemu-trace-stap on missing
 'stap'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20241206114524.1666664-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206114524.1666664-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/12/24 12:45, Daniel P. Berrangé wrote:
> If the 'stap' binary is missing in $PATH, a huge trace is thrown
> 
>    $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>    Traceback (most recent call last):
>    File "/usr/bin/qemu-trace-stap", line 169, in <module>
>    main()
>    File "/usr/bin/qemu-trace-stap", line 165, in main
>    args.func(args)
>    File "/usr/bin/qemu-trace-stap", line 83, in cmd_run
>    subprocess.call(stapargs)
>    File "/usr/lib64/python3.12/subprocess.py", line 389, in call
>    with Popen(*popenargs, **kwargs) as p:
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib64/python3.12/subprocess.py", line 1026, in {}init{}
>    self._execute_child(args, executable, preexec_fn, close_fds,
>    File "/usr/lib64/python3.12/subprocess.py", line 1955, in _execute_child
>    raise child_exception_type(errno_num, err_msg, err_filename)
>    FileNotFoundError: [Errno 2] No such file or directory: 'stap'
> 
> With this change the user now gets
> 
>    $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>    Unable to find 'stap' in $PATH
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/qemu-trace-stap | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


