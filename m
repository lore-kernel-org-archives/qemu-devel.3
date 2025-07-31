Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8117C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb8C-0007Sa-96; Thu, 31 Jul 2025 17:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhath-00011f-PE
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:33:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhatg-00006d-2p
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:33:09 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b3aa2a0022cso1031687a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997586; x=1754602386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZiM+h5oL7l+9D1nra9y6zoDW16NW/TLYVAAuAgpvcOI=;
 b=fLqFgBV5eyryieGliP38Ccs+uLtXPjwSgUTfCOltkmDVL+zayyoirKCIsqn4c5wj3B
 UrpWLpSM28LKOEhKNGXmKclnqTUUMJztbqL007zewxjCUL0asM99yk5XNp8xes95QTJW
 rIIyseUM44qfhV6MN5nbBK4pXDILwfzcMStHO/uxrhkIJJi46KGSD3hMyz6KjXhB/ROu
 zIErav0sYTQJgP2tnNQ5Q7PBG5rG9njl6rB9feYTZTjxjq3SEF4PIho7PpfK3+GzmicE
 HReXOGI5IAbG4amgvUutbzWvNvLf/aMUx1a8Tj5mCrPqX0ptgtmrRy8d15skjNk9AtRv
 EdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997586; x=1754602386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiM+h5oL7l+9D1nra9y6zoDW16NW/TLYVAAuAgpvcOI=;
 b=mkFHxG9ZbQ5jmoXoV/hFLqODuKrr/4rSkL1/ePxGc58Ne4D7JNKpuNJNqa2cT9WC0k
 2VTVIV1u6iH2EgWO7x7ZwRTVp7FCpkcveY/eEphv0il2uctUZgKeiMIQAa0EbD5zA+wK
 71MdwCwCP8wxOkO9Wf6rQuLwnsExQsUzQfoEoy3wuNnJm3RHSMMCvSWcvvXbD9K/4FLp
 7Bn98h6kI/0hH0x9ecnsMt3OzC0E3eQt+8BZjl/GFv2ijCppz0IF6TDRstg8uYe2oPO6
 JLobbFzDz9cKnGNxe352EdkqH1irgjTiZ44U0bp4cjQUhbWwBdoiOL+aAhl7a3lRTKGb
 SkFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWehvu5ewxIWhABgk/6eZqvVDM7FJ4/F9C7q0Mw/W8iAdwf+msKzayefSBV00NXZFgHbgjNVSMyrq/Q@nongnu.org
X-Gm-Message-State: AOJu0YzUzXFdXuLJssKpzZjyC2L4VBeThwCuxB0YGqSAdD0p6V/b4J+D
 xW4+2Oae1RoXjEhwkRllT+GdWnOefhCrvKipMGb6RwBTrGQJftQ8Ado68KjQMZpO3K4=
X-Gm-Gg: ASbGncuNGWdf9f7B5zxxKmjEzW9NuJ/FEuVVtdBw15W+mntGe9NsgTGD/UhCEy71pmA
 Fe7iskOCvDd3wisbaacvBas9cKCs9xjhAB6YxjFVvv21kK+QdCR/5h1Rmgso6q8OqvT24f93Cis
 0lx1eE7HKqATLwkV7ox7+MqPXOup2bOq+55GBY9QbPAP1K0QGrOTLpMwb7EAwg4kaiHDJsqJWN8
 pq7eesIKnoNaywu2890/e0jqiOiHRHp4E/KlbkNRidGaeDPJV2aP+CMmh8fHfeGY7MUPy3GGkcj
 RYdFHsE2mw0GmiBe2O8FBqoRlKfbCX146ckMKvPFdUb5fBUnhxIGSbiT1rnwLeBlaoZADscrpq1
 8C3CrmSEaEmeVC4zC7DxDT3cdDHp4BQ7J/lA=
X-Google-Smtp-Source: AGHT+IHzF+A6uPTuT7iBpyzUOuP7NbYkQoWItMJE5I0rKr77GTvp9SKD+VmiJWsMZFWyH46c1F2mfQ==
X-Received: by 2002:a17:903:124a:b0:23f:df36:5f17 with SMTP id
 d9443c01a7336-2422a54c86cmr3357205ad.22.1753997585738; 
 Thu, 31 Jul 2025 14:33:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b5bbsm25919835ad.128.2025.07.31.14.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:33:04 -0700 (PDT)
Message-ID: <24b7af7b-aa8c-4298-8176-aee7341adbbd@linaro.org>
Date: Thu, 31 Jul 2025 14:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/82] target/arm: Implement GCSPUSHM
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-57-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-57-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  3 +++
>   target/arm/cpregs-gcs.c        | 16 ++++++++++++++++
>   target/arm/tcg/translate-a64.c | 18 ++++++++++++++++++
>   3 files changed, 37 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


