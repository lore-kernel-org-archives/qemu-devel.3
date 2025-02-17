Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737D5C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2D5-0006lH-Ea; Mon, 17 Feb 2025 09:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2Cv-0006ko-Hj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:34:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2Cs-0002i5-IJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:34:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so30204605e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802884; x=1740407684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sxy6CdutpgQGkUcbc3MpVSTPOMJ7aKTf3YUD7NcXiWc=;
 b=aavXCbypnGp9x7DqLrs+HSc1ORI1Ap+jZHo0FQDjKg0IItKtlmDK+dXc2B6i5f/65s
 PPUsLWt7O2A3e4aC1ee+yZaJLaDw8RMc6tF5J2VPjTC2w/H7IATz9tw+IUijovqPif/D
 m3PhiGwtr7DWnM4T5AOxS5OIRsJPs+ozeoNxlBOctE9KBjlBJNGiu7WdJNLBZ5FB4VQR
 bHPb00Ni1XgqRVl1cd0ox5HR16Rwtv1Q2yY0aG1Se+Ciepe7kM1e30dQoaCsnQv6+ot3
 zoTzgnwjlnnvf0zlkvu6XXZxoJnN/YBmQRoZayIOXIbZAbEXIqjhHZv9vn+8wsPw8lN5
 KkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802884; x=1740407684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sxy6CdutpgQGkUcbc3MpVSTPOMJ7aKTf3YUD7NcXiWc=;
 b=kqtCJZlCuEJk7LKGaBSe660wTjc3GkC0bzZRqRglfn1aO8SYq76BSWosUy+5yzxves
 ssncUEhgazLkScfUiUCHpbrvEOdjC8sXi2bogits5iL2Ri7NsF4P22Ob1dk77P7YWnIR
 sQ+3ccgLy7dvwKFJJGXGsxZcnk4nJFraIOJDo5WYBkm1JX/tfYDi29iTx3PIqpo+MsYF
 HqSM4Em6wy4Xv5J49B5PJR9fjT1bY7LhuxHA+cnd0k2zbuLCc6JKt35Q9fOT+IcypOIz
 RFY1DiBvFs6L63J0cZAWevd/GFti266kkrNBnJermHnugYLgaQYMhPv4nWyCOdv642Ll
 4V1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSSigMJ1F/ZWMHH/01fdby+i7q8y7QpP52bIPQhCbOz7hOpAPqAyZF08aom4UemnJKihPxd0KZ1zrf@nongnu.org
X-Gm-Message-State: AOJu0YyZFFCsz0T6CtTcYumdySxnAHc/IlPjzldtBmiIqrf+ocbDbYfr
 xqP44qN252LcPyK8d7tUvblyfLVec+Q/a0+luyo9MmB2g6FgDR8hxIgs1oB7SRQ=
X-Gm-Gg: ASbGncu/ilQSChOQljiRFmx9pfecuPfkxePF86vSo42d+fIdctHZ74R5ht9duMpWT/I
 lPS8lb/PvlUkW7yTImAtfyaN5PJivVyCleyK0PqomKafYVD+QL8Qv9buI73EboIdHPu3aiSXV8a
 vLfObaHiDyNbI3SkvRHcheK6AqwjXnqncKHC1FTNJBAQSl2QW6h11g4XIgdMsyZrPnD+j7eF45g
 zFSMGhY708dSQlhucg77ywJaKYaBcb39oppirqHQLNIDr2LVYUxjGpJgGSaaIHG8x0gfyBPKw/O
 +I9efYxZxv6tevqxRO7XWpJpRs4512Xv2F8=
X-Google-Smtp-Source: AGHT+IFl4JfYJQp1WM+iV1aILAgzcBMBFGPhl/WWXMxiqP1Fh27CczfuEj4CuEnJ69yzQh98OcEJoA==
X-Received: by 2002:a05:600c:5247:b0:439:5016:3867 with SMTP id
 5b1f17b1804b1-4396e7527e9mr89957585e9.23.1739802884439; 
 Mon, 17 Feb 2025 06:34:44 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439831f209bsm34481195e9.13.2025.02.17.06.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 06:34:43 -0800 (PST)
Message-ID: <aee87bbe-e5dc-44af-98ea-be3ce7237af9@linaro.org>
Date: Mon, 17 Feb 2025 15:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: pluggable backend code generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Victor Toso <victortoso@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>
References: <20250217134927.1288486-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217134927.1288486-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/2/25 14:49, Daniel P. Berrangé wrote:
> The 'qapi.backend.QAPIBackend' class defines an API contract for
> code generators. The current generator is put into a new class
> 'qapi.backend.QAPICBackend' and made to be the default impl.
> 
> A custom generator can be requested using the '-k' arg which takes
> a fully qualified python class name
> 
>     qapi-gen.py -k the.python.module.QAPIMyBackend
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This is an impl of the idea I mentioned at:
> 
>     https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg03475.html
> 
> With this change, it is possible for the Go generator code to live
> outside of qemu.git, invoked using:
> 
>    $ PYTHONPATH=/path/to/qemu.git/scripts \
>      python /path/to/qemu.git/scripts/qapi-gen.py \
>        -o somedir \
>        -k qapi.golang.golang.QAPIGoBackend \
>        /path/to/qemu.git/qga/qapi-schema.json
> 
> The external app could just expect qemu.git to be checkedout somewhere
> convenient, or could use a git submodule to reference it.
> 
>   scripts/qapi/backend.py | 96 +++++++++++++++++++++++++++++++++++++++++
>   scripts/qapi/main.py    | 65 ++++++++--------------------
>   2 files changed, 113 insertions(+), 48 deletions(-)
>   create mode 100644 scripts/qapi/backend.py

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


