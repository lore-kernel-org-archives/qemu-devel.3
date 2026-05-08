Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FDBCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLRpq-0006bh-KQ; Fri, 08 May 2026 16:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRpl-0006b7-RY
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:30:06 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRpk-000754-EP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:30:05 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479dd56d016so1702898b6e.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272202; x=1778877002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UeM7oFxWLQi96Hb63YGcOGM8vjstoAaVeioxyXyfV2A=;
 b=Ty6UbUi+AHXzzC2z/FGp17xjxYH6B8dNc9nS3m++1TjDbgkK3awFEUklTU3lBkkD1n
 oeMpfZaoqz7B933ONeHWE12Wuw64DNrICedB9/CbI4BvqxU4u9jRYeyVz9nVPaeTC52E
 R8LNbrB1j4Tm2eO9RBZRgS2+ATQMwKNPaUsoAn8dPotzDw5fc9vsD6pfuGMQe5eKDqbX
 WHSqmLZkiCnbzrjV2v6kj0ObYZ5bG7dnjiAJeBMMzp7A1sB7ErveyRgSqLeiLqTTg0Au
 8pjSkEA/5GfeIfp6BpFnEkqL96Ly+ER0y63pXHDuY6brSxcHTN618wOvbpWu0c7dYhdr
 M1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272202; x=1778877002;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UeM7oFxWLQi96Hb63YGcOGM8vjstoAaVeioxyXyfV2A=;
 b=UjGpz8p7Q0+UH9i4xXcj66dS4TcOor/I/4/0oUfdO2VIJk9bDcxacncJQZQ9K35ceN
 dSWORIG9XEIoeEnLDg9HjkU7Cp0mvlBgeWDHB36TdWt5JcfHx97fchx8vdZVGgcScG+N
 5TXDpsNAFt8IQG4GzIO87y+fYSzCxwjYJny0USsJHxsG0fEMMRVHW9w3vk3UISggsciH
 okodRyo8tjpgIDKLApMZTwTYtnIOedDT7Z/ns1Bk83pM3pxmJ1qno7FaijugO2uigEvB
 fzjxRMRoWnNRM5oxldD9Vo747Jh+nvBL5wzCQDV/S2jUW1G7Ysc3jysMmF7EXp5mS1uI
 XEnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LYonjBDHuVe32YhGqgTdbFhT5zKUNctauhVazToxfE8zblsM3OqpO3wAcheZrrXHU6MSFxYN1c5tX@nongnu.org
X-Gm-Message-State: AOJu0YxvkgvD+8ufJIiXXYNBq6HO2yCBAy0+1xfar3HdCKW8e5ICYkAY
 G9T2zYQyuSyUsDC/xxX3b/IQtOm+ANODoKTHCJkhs3vYR/3fualGUefEBMeDCUZFYfs=
X-Gm-Gg: AeBDietP4nnRNhsf38pDH2T+zu/JFfXJd4qnoHg712Qaa7RxxQjKrUT3VUaU0cV4QOM
 Prf+ejLk5B7flm87nfpfqG2udffkdNGByU7rUEfTsmbCMYzrPaYIBUzXS8UCpgBYGmynZuhNC8N
 UUTWDo1OHFIlaRo6m850gdf8uL7v+uQpCJnjxPAMhs5SVNBpMhMqUh24r/+BVE2sDumipq+nFW7
 zRURjS1RMhR/MgNziyFNUaSoXRtq41aXpJqYj3WQNJcn2Nfa5VCjqFmxoIErc8edkuX56YxK4Nu
 9BnLmZlX9VZ7B/toRlJMc4lD4l3jRfPjTCjzQEouAk+NGfYAByuSoX4IgTkqrhR/uvcST3THArl
 IRW8GjwI/D1KjiVkRUJUBGHRZrqBIkHOuFfSXLo1depSUm0gFJBVb8y7MTEhyjfmA4vCD95PUzU
 6JRtbWHoG8h/gQsmjKkfitKjjycWtLl3qoo2h5dDTIfSO+PhSFANUkawvHuryOYO+aUMMq5kp2v
 v94SaxNRxGbFFMKag==
X-Received: by 2002:a05:6808:e649:b0:47a:2b9:dd56 with SMTP id
 5614622812f47-48042236c97mr6273608b6e.21.1778272201829; 
 Fri, 08 May 2026 13:30:01 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76986f9dsm15491794b6e.16.2026.05.08.13.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:30:01 -0700 (PDT)
Message-ID: <130b63e9-f618-42b7-b0ad-f4db14dadfd1@linaro.org>
Date: Fri, 8 May 2026 15:29:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] target-info: replace target_info() in system-mode
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-7-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/26 17:48, Pierrick Bouvier wrote:
> We now can use TargetInfo information available from QOM, and remove
> duplicated target_info() symbol.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-init.h | 5 -----
>   target-info-qom.c               | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

