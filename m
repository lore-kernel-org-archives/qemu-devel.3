Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01732C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwXB-0002nP-8x; Mon, 04 Aug 2025 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivBU-0004Oh-KL
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:25:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivBS-0006id-Ds
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:25:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso3330529f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754313896; x=1754918696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97dFiWkFWB/i0zL6QqfC8T9NssPBUxEbXa4b51KzaVI=;
 b=iuOjXDLXCKR86K9D4gon8uEHwTLLlIY9QiBewOZeTaOPcAr2553cezVdH6cVK4T/J1
 XD0iDi7lPLTxKtjaiTPGrpdDArA+0L4SZAchKiPoSfHcNeUZ0kswJzvY+ElkEDX/1nFO
 dsfqR2Br+yuSpuviFegYCtYGM726d2VOKxDi4EP+ucvF7urEhouQLDtmfJU4pdYRAwNb
 PhGtZ0roKbxTfn7i3E6rbAsdJiUTzpZh3j5LAwhAn6aEBMzyMilZ97fvL0IxeLF64kas
 9jzgD9Aznvy8IWOrUP+o/h/vI/YLg+A5lwucT/RmyjdJQwbLS35K5Uil2M0SBdkupHor
 nnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754313896; x=1754918696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97dFiWkFWB/i0zL6QqfC8T9NssPBUxEbXa4b51KzaVI=;
 b=BIKrLFf34wyOoW7rosQXaRRZzvuyMLB6bbbFvqVkSVzb4cBMeXCHEqndpHXlAemynA
 8KwMDlI+lvAmS1sTTfGyC6C81DuUScSN4XNxk81SA7VksjuNrO5M/1+Y6vDCczQ8jr9x
 7qR5bhJQOPUvc7HlXeAb032IOmYbKWQucFWPRVukP0NAM2h7AdlO2irxBYKn1tn1Hhn/
 kr5sbYhCs2/7pkXgfrcF9/DFlHQUgCkToatqZpENVYobJ1uc7tEFSvYWeco4A9+RcNa+
 YRy1G3uvonEjAUqNkeg7mKI4LUO2nhHX6xNBxkaZ6664od7zdMDi+lbzxImY0uDNtqqg
 glUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGwy0FxlD5hYScw/gEhazcvS/3bI459WQ1uC9/0vyNisAHG2M1TskJFrvcXzziciVZuXN0r9B0wTFR@nongnu.org
X-Gm-Message-State: AOJu0YzBy5U7W3qOKkxUgx/ege+Nj43gtlDP9+HEQFpQpECCQ0KfVh1i
 AwBNTmhIa+CfB2OK8J1ouHv1OMIUUHY9PhdzjxDWNDy+59XB8DH9U7smVAiFsuh6UrI=
X-Gm-Gg: ASbGnctrU6585zdPJWCHXr1P1DFlKvKo3oe7ovGbKoF3uXbtoyp5mZFvkC2YV5B7LxN
 WkS3xGKWHP8S92wu4wTW0aqeob0TnH3P43IBABoREOEPLNZSFU5Sl0irBDt94tlheiSOCGI4WUI
 YKDRoA2KxMStFA2xylhTK6Maf5nN17jnb5I806o5czFf1d3/ly/ZZ7Si6VyFgUj6thPKOKNQgEA
 ryCM8SWf5KUKSJld/AhvmG38PTX3XUiZwhumj3YC6/t69MokIoIT0Q9Fwj50BPeLknGraydvsa0
 C3UW2zrVCcJpoP/XKDkFZPz90ReSSMbS27+w5N0O3X3VHAnb6MTSmUiYzDut1pyRjOBOk2nZz4T
 6O9qEhMXIo3gvz4gZTVWYaY4ps31/gDEHm8x9erQQmY+cK0MOSn/IYD6ijZ9HBIHcyQ==
X-Google-Smtp-Source: AGHT+IHXCrZrByL0ogMB3u04EAeRRWQw6uZPVU2k+HY09TlP41owUy96djoWbsOI+7BiGvMrBMncsg==
X-Received: by 2002:a5d:5f4c:0:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3b79d4e387emr10775962f8f.13.1754313896393; 
 Mon, 04 Aug 2025 06:24:56 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458f713eb44sm69011535e9.14.2025.08.04.06.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 06:24:55 -0700 (PDT)
Message-ID: <3a0626c4-a2e9-44dc-8437-271adddd0499@linaro.org>
Date: Mon, 4 Aug 2025 15:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/command: Avoid generating unused
 qmp_marshal_output_T()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, berrange@redhat.com
References: <20250804130602.903904-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804130602.903904-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 4/8/25 15:06, Markus Armbruster wrote:
> qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
> command C that returns type T.
> 
> We've always generated it as a static function on demand, i.e. when we
> generate a call.
> 
> Since we split up monolithic generated code into modules (commit
> 252dc3105fc "qapi: Generate separate .h, .c for each module"), we do
> this per module.  As noted in the commit message, this can result in
> identical (static) qmp_marshal_output_T() in several modules.  Was
> deemed not worth avoiding.
> 
> A bit later, we added 'if' conditionals to the schema language (merge
> commit 5dafaf4fbce).
> 
> When a conditional definition uses a type, then its condition must
> imply the type's condition.  We made this the user's responsibility.
> Hasn't been an issue in practice.
> 
> However, the sharing of qmp_marshal_output_T() among commands
> complicates matters.  To avoid both undefined function errors and
> unused function warnings, qmp_marshal_output_T() must be defined
> exactly when it's used.  It is used when any of the qmp_marshal_C()
> calling it is defined, i.e. when any C's condition holds.
> 
> The generator uses T's condition instead.  To avoid both error and
> warning, T's condition must be the conjunction of all C's conditions.
> 
> Unfortunately, this can be impossible:
> 
> * Conditional command returning a builtin type
> 
>    A builtin type cannot be conditional.  This is noted in a FIXME
>    comment.
> 
> * Commands in multiple modules where the conjunction differs between
>    modules
> 
>    An instance of this came up recenrly.  we have unconditional
>    commands returning HumanReadableText.  If we add a conditional one
>    to a module that does not have unconditional ones, compilation fails
>    with "defined but not used".  If we make HumanReadableText
>    conditional to fix this module, we break the others.
> 
> Instead of complicating the code to compute the conjunction, simplify
> it: generate the output marshalling code right into qmp_marshal_C().
> 
> This duplicates it when multiple commands return the same type.  The
> impact on code size is negligible: qemu-system-x86_64's text segment
> grows by 1448 bytes.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.rst | 25 ++++++++------------
>   scripts/qapi/commands.py     | 44 ++++++++----------------------------
>   2 files changed, 19 insertions(+), 50 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


