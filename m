Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ADDD73606
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 15:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHP5C-0005r0-3c; Sat, 30 Nov 2024 10:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHP5B-0005qf-0o
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 10:08:29 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHP59-0000pz-KD
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 10:08:28 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f1e73033cbso1119500eaf.3
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732979305; x=1733584105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6TWJLkKKcQwsYPR93UhKCx+m1nYnurFFE5mQP8DK7I=;
 b=Y4IjgoWco/6Fjky+tphkidst20yojWelDeTIUAXTwGtOSDG7h8vpSg8TNvN9diGzCE
 on0Y20rFHJnVTFLwlRfSxa01FBLetthu5D4eHTh+M0OKdzWHh/2eJZg+z6mWqYofoGiY
 up4vQWBYjYG9QNTQvP/gZqDxmTWJg/DPgpfQD08rN77WUacm2ad497k2WstpIEmQ6/M4
 Z4DT/9GHOyZW8XmV6UqvyGWSWgk6T8Hzcv/bQghzb9K1zYuT1cNgSXUtDQmn8f6MkCI6
 cICkoxSY76yg1sRrCrOYBiVGeS7fY9K0YkQpQLCNIer9+1xgGAIxFCej+rIVOwK+pfu5
 EDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732979305; x=1733584105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6TWJLkKKcQwsYPR93UhKCx+m1nYnurFFE5mQP8DK7I=;
 b=FF5cOGOteB+znB8uJ1V2mf0TTPtZi+mZRxnY0HtDFRlGBIaY2ORc7kCJFdQwg8Ou2r
 HXb2YU3OJTeOB10GSHmr0SGekClElSSPCebNYW7oYuN9nUdBoN5AZZ5PuOZryyx8VTnW
 HiuIQZmFUdb9YJ8MOmV8bgIwC2tAjSmMYQnQRAiDkWELhhhQPtumzDzzpmSHACa2rHt/
 icNNjCBpU/BWCV2dID8v4v10oMJpjBwZZDebf79IT8KHIPE5N4DqN+Pfq72y/6dKafGd
 Z3SZ14yHv/ArzH4r/FbHWRyoKLorcX1ehY2tC5lXm5FR518tVygfE1rNhbx4p8ujuGBq
 cDkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj0apPOQUlJR0d6QusqR3RoiDvmewnJCuC6vCLsO2PJY2gHTow6Ss7zTH9T4fDesmiNaP/9H9ICs3e@nongnu.org
X-Gm-Message-State: AOJu0YzprjOa19GcPbgXSQBvlABw6LDO5Sn6XA4p90XZqymyd7S6yDrD
 3LLi/0SIIPeh/rScukjVW4bJXRgWvTwWJnwVSwMUHPN4AyHWDwEkaU38Z8lxnGg=
X-Gm-Gg: ASbGnctXQfNWvey6QdSlYdAjFFbw2fFNcY6/OCU7daTZxf+zOKb3/5Gopcd0EydDL9q
 Z3DWl5qlBVhZnGAwKM+mw2A/x1AqBxLHWgMwMLdt8WHcNmXQbi5VLaP4RLqqA2I8gY/oBsTgosm
 k5BDOk/w8jNNNLeotsqjgcHcnZmXrRQLVJ5CsQL4hqUMThw8paUrP2TR1hjSKqyaJ7yoX6PhKF7
 dmOEd0VkNKg6XKGUeGH6laP2ZYHOu4A9fgvXnT2I9swOaU67EAvJHj2xy7BlbBwwTcpz1EQgI+7
 EY5lNk95axgZGC+jG9YvbkLNUL1f
X-Google-Smtp-Source: AGHT+IHD4z+qZmosgNFPsyEiQtLtYxg5DONZy7/DVBwEL7h8SmeXpqoA0NyQPF57gSARU1/2a0Yskw==
X-Received: by 2002:a05:6830:7318:b0:718:19a9:434d with SMTP id
 46e09a7af769-71d65c7dfb6mr11850892a34.1.1732979304822; 
 Sat, 30 Nov 2024 07:08:24 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725638b4sm1285106a34.41.2024.11.30.07.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 07:08:24 -0800 (PST)
Message-ID: <0c4fc00b-d016-4e12-8c0b-370c392c09eb@linaro.org>
Date: Sat, 30 Nov 2024 09:08:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] tests/functional: remove duplicated 'which'
 function impl
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-6-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241129173120.761728-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 11/29/24 11:31, Daniel P. Berrangé wrote:
> Put the 'which' function into shared code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  2 +-
>   tests/functional/qemu_test/cmd.py      | 10 ++++++++++
>   tests/functional/test_acpi_bits.py     | 13 +------------
>   tests/functional/test_ppc64_hv.py      | 13 +------------
>   4 files changed, 13 insertions(+), 25 deletions(-)

As code movement,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +def which(tool):
> +    """ looks up the full path for @tool, returns None if not found
> +        or if @tool does not have executable permissions.
> +    """
> +    paths=os.getenv('PATH')
> +    for p in paths.split(os.path.pathsep):
> +        p = os.path.join(p, tool)
> +        if os.path.exists(p) and os.access(p, os.X_OK):

But surely exists() is redundant with access()?


r~

