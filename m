Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFEE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIiau-0008Uz-P1; Wed, 04 Dec 2024 01:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiat-0008Uq-4d
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:10:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiar-0003jQ-BT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:10:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4349fb56260so56148745e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733292635; x=1733897435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5C2P8jtVIKmpShQfIfQ3py2oMmwDScCdVNfkV7KTcVw=;
 b=eBrmhMlwDOzBTDi46idZfLwoY563HzfogMO3/tElbXLgg39EE+phgmHjeXYg1J4wEW
 3DMT+yUUi7KM4OQANS6cED55mn11hBdK/bnfLREhpl7sOwoOi/zB3V+orTANpSHaLnru
 UNrzVmY8suqNwDF4fYKgqLjuk5wSIafuoKDq0VuGZX245gdKZO7cOx5wC5E0h9oNV7PM
 b1djXd409dYPjYMEnE/55KJ4HYvHFtKfnK8WzD5awuPfE9FmMtPxDBi+614Psa6Zn+T7
 Y9ic9atwvr5BEAhoh6ri0fmqBycsB71Q0jGOgilnag0/iWJpxaDTq3S/xaoyxD0ts9L7
 WUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733292635; x=1733897435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5C2P8jtVIKmpShQfIfQ3py2oMmwDScCdVNfkV7KTcVw=;
 b=Vd8ea5iORle2uJsa0f3HCqPLpiEvTh8AIMVFjrmEVgxiYJjtYBUDy0HFBugGl5k7zu
 60I7M8enCpaSIqkNCe9TKdOqrXz/a7WiGvHvWS1Ny0ZqWOYkfPh9pCJkc1a4Vd8gkvzh
 zMy6m/7dBSx1Zt5wpvAOArqBvEM33BeBcgyR81+TvN+Vsq+KGDlQ4lL+y9kbvU+h0hay
 8LESSKh3WOiN8hB9nesUF7y/ner+OKNx4pudwV28fY5zVVc+d94V4PgnKerbdqbMd0B/
 0ZKMzqc1SCyiTKAata9+LOynwBmKI9G/VAh+5U89M+36VZSRB+QKalmbTPM3zKnw5cBZ
 bp6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdshmqUQvrU7ENAZW8IVVfmvquaxscEl2g37VBJjxc4qhPVr0Qn6R8qDad/eF2QAvX/GBfrMZOv19O@nongnu.org
X-Gm-Message-State: AOJu0Yxb+TlZ0SbfBDAKNy+u8oxI+qC8sKavCw8FnJ1jWOAdXpp1a2Fr
 S6HomAKT/zy+qCeTZ+/4gD+TSrZDanKprN3ow6m9bxQ+yiZ8yBhcNZokW5ESZzD/NXcdzTemv2G
 b
X-Gm-Gg: ASbGncsH39sHGoZk7E/wKKUdNP43yP4XyPZunONtAyR4KPrQwuRFVTndk1FXg+6pnK+
 TgPGSXmfTA70GXhPZC0aoGTh0aoB8gfHoRO+HhVry2AMFRAlXJLFM7IhWbz8hP7Ne1tQ/AjXsKY
 sm7454jTEngpuP4Ee2jE+7uAgvnz6od+D7U4ygWVmb0gyDWq/30IP1g6WgwNMUebyRarLFyOgif
 zBzuJEJJBXdAn33Bc2uFUckzqvPD7g4UGIm+lcBOjhAt6krgrTWS00zpA+wR0zAo/Byg7hJFr1/
 SI1ULLQRvEs7WQmgPLTay2y8P4KVs+A4BBR4z858LQ==
X-Google-Smtp-Source: AGHT+IGI0lTxMCxIYKaAbK75r0GinRABhgqv1xOeKQnfKVcu1Znvu89KmUIiBCv2eXZRy3jl+DrMnQ==
X-Received: by 2002:a05:600c:3b1b:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-434d09c0c1fmr43745875e9.14.1733292634020; 
 Tue, 03 Dec 2024 22:10:34 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52a57basm12010605e9.34.2024.12.03.22.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:10:33 -0800 (PST)
Message-ID: <b26d372e-e1d9-42a5-9c52-1826b64bcf05@linaro.org>
Date: Wed, 4 Dec 2024 07:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] softfloat: Inline pickNaN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Inline pickNaN into its only caller.  This makes one assert
> redundant with the immediately preceding IF.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc      | 82 +++++++++++++++++++++++++----
>   fpu/softfloat-specialize.c.inc | 96 ----------------------------------
>   2 files changed, 73 insertions(+), 105 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


