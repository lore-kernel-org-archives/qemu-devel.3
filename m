Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89853CAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1rpP-0001mk-TY; Thu, 25 Sep 2025 15:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rpK-0001l3-9I
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:40:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rpC-0000WD-0r
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:40:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so20426235ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758829212; x=1759434012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Q3PiAnlLHNn7onRG/35+0y9XycEqkYWWxaGTfbXcus=;
 b=Wz7v4KtWB2l+q8a6MWwe7Af3tQeLkIzUM5Bn+sqjSAaqG5ROQFau+Mv0Fu+LmwkFFy
 2xONmtRdbFz6BUUW66e3AP5cfOHKWOOD1cvXAkIggLGfftbUkqq4sJmo/uav9uPDY6q2
 x7wHr1SRDnMw9VQQyL6lvxePxPRJ3wj/TNY2Q55kt6shhI7xVbpRqb0sGKwD6cgEyR+Z
 NQIwIKPKgQzlZbNWOWx/SPq9gFrOyC/wNojIB5Dtv9FHuGycfLU54rxwuEBCHOXrVtk/
 3VYB/qVXPePlKL6r4n8ocdS8B2iuJs7MrQnvdOpuyStacx1UklyGaCqYSr6JDA52E60F
 TyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829212; x=1759434012;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q3PiAnlLHNn7onRG/35+0y9XycEqkYWWxaGTfbXcus=;
 b=ofihbJketI3Ji6Xaakx79GSlZw7OUElk58HvGVjuWPP1oPycMgjEF7Gl+/nUfKFDqg
 eBxZ4WX3XlsCYcF1SXW0h0cvF2TsQGliGt5ZZmSVPT+zWWLOgmE8MZ9tmviJ8Ay3hCm6
 iQ04vQOhzwUxJrykJBEjbL69DvkNLwPtXLdrPFwKQmWMRVAKn/LlcYjKR5Pj0GWKxwJz
 Uf9bb729Y9Y2RIPUtufIgXoYU5ioztVOAXLJkaq6ZV4IYkd/ZeBWlGWlBEYCb46ts7n6
 Z+D26ke62eQ5YMQfJlblZ0PS+QdCQ5z313oQckR2wJ/NlYgdzzeXmvek397RYShDMcQO
 5fHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAKLunuNmD+z1R0Z44hcEJXaXqdkiNo+Nz5lx3hNvVrkecSu+tOt7I8RogW4mTvLo8TmSCtdhruNZk@nongnu.org
X-Gm-Message-State: AOJu0YzSkLqXCGykEP5yUPEQZ5kDllYPayJJ2/5xVYWDjo4jP3eE+bkR
 LliLVa89DuVzmEzG5wcr/nTLiDSSK5kVtW713l1+DXe3KifHFxh4P7sNNTljjFPtNMU=
X-Gm-Gg: ASbGncuJ4ChgpowKHwBu+em1TsU75+JJprtkEnAI09OTDUocv05wx5RB1YFK2fe+Hlf
 qZQUxWKSdDvJQKLIFWoUHdDdqyf1IeP8rsL9M7/iX2zzz6Vq/3GLWk0U05IzGbKdsem0rb4htsc
 nwUDe9fBmUyX+OL730T35Zke++10FjL5YYHlT/VUKe5nuEISVfXmI3JWIe946Ag7KkX/nlDpkMF
 5XpFCSg8DCJ7vdNdz/OhO5WP8oB5143/fsGdwAEV0WfnL5caeP+Aj3XFRIYaNKn3iR5JZqP7mg8
 R0l7ATTzJM6yulxKQ3uX58m6OukETdxrpexi7PPhGk5J8OPQbcocf9lKwFPsLR6rdpUSC62jLsU
 eFyLMTU8gPqTSx0QV1kWv9kyLwPKRGpm2epU1
X-Google-Smtp-Source: AGHT+IEDSdJ9vxaWDLhoFSwA7e2QM/cUd8TjoZoJ0YI3UBAicUte6jItWul3PK31VW+3Go/+iPrZnw==
X-Received: by 2002:a17:903:b8f:b0:271:7eba:a49 with SMTP id
 d9443c01a7336-27ed49dd8bcmr50677185ad.19.1758829211775; 
 Thu, 25 Sep 2025 12:40:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed670b315sm33440545ad.40.2025.09.25.12.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:40:11 -0700 (PDT)
Message-ID: <69793f56-e5c2-4075-838c-6304ea4d6d1f@linaro.org>
Date: Thu, 25 Sep 2025 12:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/23] monitor: move error_vprintf back to
 error-report.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-14-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> The current unit tests rely on monitor.o not being linked, such
> that the monitor stubs get linked instead. Since error_vprintf
> is in monitor.o this allows a stub error_vprintf impl to be used
> that calls g_test_message.
> 
> This takes a different approach, with error_vprintf moving
> back to error-report.c such that it is always linked into the
> tests. The monitor_vprintf() stub is then changed to use
> g_test_message if QTEST_SLENT_ERROS is set, otherwise it will
> return -1 and trigger error_vprintf to call vfprintf.
> 
> The end result is functionally equivalent for the purposes of
> the unit tests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   monitor/monitor.c    | 15 ---------------
>   stubs/error-printf.c | 18 ------------------
>   stubs/meson.build    |  1 -
>   stubs/monitor-core.c | 14 +++++++++++++-
>   util/error-report.c  | 15 +++++++++++++++
>   5 files changed, 28 insertions(+), 35 deletions(-)
>   delete mode 100644 stubs/error-printf.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

