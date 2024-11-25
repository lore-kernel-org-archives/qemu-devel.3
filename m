Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98BAD58067
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXMj-000691-JX; Mon, 25 Nov 2024 06:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXMf-00068j-5D
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:34:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXMd-0003lk-DD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:34:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so2528148f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732534486; x=1733139286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=At3YF9Br94Env7R3r+yOHJ5i29KAKPJcZseeYBqViuA=;
 b=pJcIk1R9WDvsQUcVPtSPv6JvtlZexlv2CEXj500x+FmgRD3Asx9jdaYYTzmPJVlk8g
 8NL+Vt3Uud+7ebfNspBv/agARZ023egb/cYlV73IyRppQJF4NILSFQoB7geh2qkdgUvm
 OImRmfJWe2UO5GThHuh8WXMW3KHvC7chLvikQcyieHl7HuuUnmQ65I/UpKffvFEfRujX
 Jg5NgVMQpCZe8qVrQIk+G4yktXrxkKiTMr023Tjr8J+ysFrkDOm5eMdGaBb3mI9g9nDE
 4U2hjH62K4bP+k0rji8g7pYBYCtyReHu9bsRb8NU7PDmUXK1uDWCujqJsojOjhfgZYoE
 Webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732534486; x=1733139286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=At3YF9Br94Env7R3r+yOHJ5i29KAKPJcZseeYBqViuA=;
 b=MX+7lGS4bxRAx7FgWjmZ6zGE6Iqxv5D5TvhQDuwEArKHy8r9Lnf3v1XmN0PnahD33v
 +vHSaOt3KP0dox2wFB8Bl0FRD5SWWyEJ829tZ/AVQnlGVBnh0S8Iq4SQH7KPuH5gIYFV
 WWwGEjg920QK6Wgw2GXeTJSbwbr/MCpKeD81NHE+npaonm8vCDOC/pGfOznpC2aAhxi4
 FHAb3cCzc+KoU2qUZuny8jZbC37a9lmur+tr8JC8YHeQjIJEyrL0M0c16PK/oiJn5cFh
 3sutQ+faj6t5EL4tHoYTaobWG5ijc2/4mFEafAQF+PQwAYaJTZK/7zBpqynIcFGrlupg
 LD/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl8aQQfyMtDbrQ5UrZvcSUIVWWOOeF2lvPr+KboIIMI6dDoZDcgE+hQSvf726xrTCL3keOekLhR0/1@nongnu.org
X-Gm-Message-State: AOJu0YzKkZaCpUYd42DYEuJ9kQClN999c6j+4LkC5x/LYry1FG+BcuiL
 z1YLb1lSRBixFZHmnhJNDJsBmk2oKmmXrgw0jyQ6NBNzLIIZ3yu1xb3Q1r1UC4k=
X-Gm-Gg: ASbGnctOTXpjGHDr3b6hE2GVqy9c+XUnFanlO0WPIoq56lVFEim7kmtix0V03Q2xDbj
 05sai/D32LWnkdo6uUQUAnaYOolpEJ3wtF5B/mxwoh5eMOIXsGwTK/VsmbgKGlcAVjRwjd5KPQV
 L/R8IzuTEA5bVfPifKg8h6kiDedMvEwii0M7TebGe7kioT5BvJoqsoP0tuWqDSnbpP4b9uvOuK0
 ckBJAVPhF1+Xz0B6di0VuM3AZxqUqJ09hN6xkEquCiAr5lehlPXiwmrx0EHWAK7Mw==
X-Google-Smtp-Source: AGHT+IH+/F24/WtzsXxgCCBn5IR2sK5W0nJAOhjmJ1PX9FErDGT3OoDGp3bg/KOijh/OO2LGmKcuEg==
X-Received: by 2002:a5d:64e4:0:b0:382:4aae:68c7 with SMTP id
 ffacd0b85a97d-38260be4002mr9736105f8f.53.1732534485676; 
 Mon, 25 Nov 2024 03:34:45 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2679dsm10298293f8f.45.2024.11.25.03.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:34:45 -0800 (PST)
Message-ID: <73638525-4f0d-45a1-bdf8-f271fcc015d0@linaro.org>
Date: Mon, 25 Nov 2024 12:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/43] Introduce helper-to-tcg
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Thomas Huth <thuth@redhat.com>
References: <20241121014947.18666-1-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 21/11/24 02:49, Anton Johansson wrote:

>   create mode 100644 subprojects/helper-to-tcg/README.md
>   create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
>   create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.h
>   create mode 100644 subprojects/helper-to-tcg/include/Error.h
>   create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.h
>   create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.h
>   create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.h
>   create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.h
>   create mode 100644 subprojects/helper-to-tcg/meson.build
>   create mode 100644 subprojects/helper-to-tcg/meson_options.txt
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.h
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h
>   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.h
>   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.inc
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.h
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.h
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h
>   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgType.h
>   create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.cpp
>   create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.h
>   create mode 100644 subprojects/helper-to-tcg/pipeline/Pipeline.cpp
>   create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
>   create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
>   create mode 100644 subprojects/helper-to-tcg/tests/meson.build
>   create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
>   create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
>   create mode 100644 subprojects/helper-to-tcg/tests/vector.c

Just wondering, could we name the subproject C++ headers using the .hpp
suffix to have checkpatch easily skip them?

