Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C22C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCmH-00067l-TP; Wed, 30 Jul 2025 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAtA-0004yW-Ne
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:47:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAt9-0008Sq-5J
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:46:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bc55f6612so24378b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897609; x=1754502409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f6WZAn6VaKN07tv/UW7+TzF+vCV8/Zhf6mhs9CL9uFs=;
 b=wv+ZLcdUaLUpFGbHr+mgAAI5plD8ds1+D4iLDqYKp8SUh0ga2EUGD9bOF7ZwN1YI3D
 kY9VSBNoeMjTO68297N7k4hGtqz6SWu2BmGjn/GxZF8ga1wQMgd6dfPIanaVw18o0ZhL
 0A1j6OpH2h1Ro4ZoouUdj6s2U3FhfU3l+TirzfANA5lcwxEmputlzHhctsXAuIMFjC+/
 7rPu2PVm9ggkaEA4OCm0WYNWPvCxanVi7ptzCqFuHCGpDdVWIFA5FBRxA7n8xMhHXJr2
 /nmtjj2laVh8FwBcAi0iCk1AmX5LzzUiIs1lfrUOznXwLT8iISY336Y+4pFd4bh02rk3
 IvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897609; x=1754502409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6WZAn6VaKN07tv/UW7+TzF+vCV8/Zhf6mhs9CL9uFs=;
 b=hao+IMyTQwnKBY7cLOREfEwUCew1e7PI5mc7niEYWCHfYQhMvtPLgOpqhpHM+UMpv1
 qOqTlu5ITZPydNcJvqDGSYrhTa227H8wkQa6YP3iR3ltNig/7TH1fk5yQafrZgb/0nEG
 0pX2RnRu522KzoUq3Tk5+EddI+nK+GFKi+AmfEdgZSHL3/DGYg00rT0fMPQBDprOl6Nx
 6QVdpeNtsX0a8p4MNXNSnnTh9wmS+MF8YBxO1c1zVkqvdLYmO4GFRlrVuxp2iTNe4bAg
 Q7X5m+m5O4GN3ojpi944ofV+Jmnu2FGiDUwftTOeANAHNDFd4hQLg9438wF8d97l4I7X
 AKiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/ozSfnHDVpiobkKvT30kXjA7OOXbianDQfQ8o0Gke6sPQAOjHTaDbjEDQ4bWoODyTh29c6dUJP6A@nongnu.org
X-Gm-Message-State: AOJu0Yy4JARFMA6oeHlAO/WRO7Dz9GoCC3RKCUlDtgEQKwRGxBJSgZ0s
 JinuL80yc8aQb7VfU/MmdpEdjJyrZW3EM74uQPaNBxvfQd/dKF0BCxJt8YkHyel/v3M=
X-Gm-Gg: ASbGncuBOf04IgW1PqdYRnXeqMPgnNHslcOSbp/CGTXsyEB/NTyZqoGypyRCi9YcoL6
 XKdCwxW122EAvMSsnxGwZwQ6CrmGPnEcbYV3Ka4nwtpn5Ss6+gi8Hb9Rqtu/a4VcFPdb40i+jLS
 AgF2aBVaxZuXs6xcq/irkVAocUX5sBmEdP9mHoQc/3e25vh+hOc/CVn9ewW+43rSQIbSyhcFYVX
 M/0gTPj71YAki4Zl6sNgSqbK+BnC82SvmX/jZytyxpNsWZx0jokJnFqdFSy+I18KVrP4BqIjbXs
 QEharMY0inIS26jbGSeGiC2c6/i1Bp/JR4w0Uup6IhfQAitidzcq353MigtzZpXwGULuD4TODuV
 K9gTLAyFayFNBKa2hCizaJvUHuRgKnJQN7S8=
X-Google-Smtp-Source: AGHT+IHQwNPjmuL6lAseQr1e687/5JXOgBFzYa/AGFOQO92YZ/JO/bR0SFcp7CdxsF0fCKHKZB7ASw==
X-Received: by 2002:a05:6a00:4a81:b0:746:1d29:5892 with SMTP id
 d2e1a72fcca58-769656fc218mr8605420b3a.4.1753897609146; 
 Wed, 30 Jul 2025 10:46:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764087294fasm10535473b3a.9.2025.07.30.10.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:46:48 -0700 (PDT)
Message-ID: <ea55952c-ce00-4d3a-bde0-257b5c6967df@linaro.org>
Date: Wed, 30 Jul 2025 10:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs/about/emulation: Add documentation for hotblocks
 plugin arguments
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <35128cc5a86a0c18418f9d3150fb8771c54ef7d8.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <35128cc5a86a0c18418f9d3150fb8771c54ef7d8.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> Currently just 'inline'.
> 
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>   docs/about/emulation.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


