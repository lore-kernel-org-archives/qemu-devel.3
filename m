Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AF1C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thX4S-0006g4-SK; Mon, 10 Feb 2025 11:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thX4Q-0006e2-NJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:55:42 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thX4P-00087A-8T
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:55:42 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa1d9fb990so7089387a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739206539; x=1739811339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWbH4LHrYId6HnVWgLDEfGrGLTypeOAA7e2MXBbcbYo=;
 b=YCExSfeufamPh3s5zpx2XAyWT8hRpUMHUkXd238ekKgEfgrTcjvlERf+Cb4Nzdgu1C
 D09g8C5pBdvkYCUt/8YCEadOgB8B9uYPQ3c+fADxpl9xms/rL/v1mYDilKAIJrtGrB0H
 J3dkQdk2qhNLhkZ07AGSc+s19gbJlBz3uQCJP1PfbsVMA3/vR2HTW8OnYSPJGmiSrw3+
 8G+s387lQsP3ZYuCYs+mVNpkU5OViOLslpAK4rgOZEW/zf1bHjcSxqFZOWYsX/q+D/Ud
 +yXLbcs14vRNd788Moc+TJ081gT9lcJgFLUzb5vYUyBVhtHe9JtbrabSd00ChCuePSd2
 V3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206539; x=1739811339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWbH4LHrYId6HnVWgLDEfGrGLTypeOAA7e2MXBbcbYo=;
 b=Gt1WcguVF/eG3/P1mzlAgS/qfwu3X5iuXkW/LO8P7z5ezdja2cwCoa3yWjyH5tQOYl
 F8oyEJMnpLS3n5J5pzhhHXJ2cUiQgmH5xFPaKkHuv3yLazq9BOz1N/kPfop8B0rvNyA6
 wtcERc3ILdJflY4JPhEVGsihd8eEZFTsjDYGLjUOlnGYvZE5fSp3F94VtICpDd/B0Lkp
 LQpp2f8VsanjGjYM1PjNUdz3KbVFqswL/qCi8rTBcaDRRsYSi++u1RL/6B8wby47T30f
 H+daUamfv4mA2dVj9iobxzCp3/1EUZ+FRR4tnUcWCy0lzV9TI1SMnD/HV1Faknicl62j
 BzSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgM0v/CAT3XSeqPg48MCVBFdCCInI/zb3h6nYVbTFBKllMMmlyewC8YACXks0YGV5QIR4CtCZIRPys@nongnu.org
X-Gm-Message-State: AOJu0YzIdkXRptOtNL9EH9jGshWuAdTZBWIhjcZwX6QX8w40oIvZa/4V
 TBxqwZFvr6baKSCLX2VOcPBERWKY2b/aG2sykq2qaZuh8WfiZsmYMWJPcXoIWLU=
X-Gm-Gg: ASbGncs/f/hl0GC/jYOvfiJ4Ghl5NwudwYUwRU3fyPh01VidxiHYLVoOZIltPdqH50Z
 WAOmfwZ0tEx5KuXO0p8DMVBrrt2gvDsETDLl0keODIauc7R5TCS2KILeZkhJd5sGjQlD7UY+GaS
 4Zu7rYYDEg2B8km5aUH7inaoSfSrRZpip0+BV+EXvykoRjjU++pVrbmF5cpb/sn0vQTr9jcqTyv
 D7Rj2eN69WJj11X+d+C1/QIBs/JOlYiu7ldGfRWKMsXmR/ON6BEBUIztpTLeiGfu/CmDX14bqWF
 4/+NXFiGbv3+s/J6x41FRaEEk+cfMhCsB4mS94MXjNrX+NGxkOaZHh4=
X-Google-Smtp-Source: AGHT+IFXBs/5Yvyw68pZxHwn+fxV/vcTBENe5AMMXM6yatP6enrz9LcHd68JxfLV46HE02mcC/eexQ==
X-Received: by 2002:a17:90a:ec85:b0:2ea:9ccb:d1f4 with SMTP id
 98e67ed59e1d1-2fa22b997b4mr25858651a91.0.1739206539353; 
 Mon, 10 Feb 2025 08:55:39 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2842eadbsm6977540a91.36.2025.02.10.08.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:55:39 -0800 (PST)
Message-ID: <9fe089ea-3b41-47f2-8b6d-1591a5f43365@linaro.org>
Date: Mon, 10 Feb 2025 08:55:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] qom: Constify InterfaceInfo[] interfaces
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Mechanical change using gsed.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

