Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC89C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCea-00060o-1a; Wed, 30 Jul 2025 15:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhArR-0000g4-QN
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:45:06 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAr8-0007zZ-Kw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:44:49 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b42254ea4d5so33603a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897484; x=1754502284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76hTb1CMrPHJRet4cKCQ9LkhoQ0Sv13x1o7kkwfPwyk=;
 b=qguOB/0toyFgy0Lhl6srNwj3UQFYA3YZBF1zix3hFvzS2+VG5fW8DGZ7KRfw/9mF3A
 QI/eOJeOoU+GtDQAAj76mfbQ8jSf52NgDhzHQSv2g4Y+quEJYsPMCoINZju0jQckISp9
 ZCKE11YsZ+WuOY49K1KDUpi+U5S4JeCCf7LPOZf71wECdy2We8tcGFNVIODfLUhCnqcV
 xunTCJaKpbi6tPrHhCn4yAqZGsLQqQxWo4rfK6aSG0hPo+H6HAUCPCBqtq5YUyTp9AMA
 mpoViQCTTUJkEQK8itkEyAuoyivHIiMSJTP+M9sO52lVI4fjpJvKj5Dtvmf00MaXcwWr
 UQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897484; x=1754502284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=76hTb1CMrPHJRet4cKCQ9LkhoQ0Sv13x1o7kkwfPwyk=;
 b=mYXhcTTGXYtjrz3RUhS1Fbrpv28clytW1iBuVM1cA+KlhZaZ+YmLJ2x/1QgR7214eC
 tp3QIXe7gID/Z9l/ldrZF0r8JZ3Dyx3mWg9QHCz9hthBY8DugVULT3VfPNO96AEUAt3o
 xqi+acNovJJG2HbYJ4BCQ4Ah5d7wCVMXD5W27hfaaB/8kET871uD7ewG0ptShAQ/QfDg
 jGIdwhX74bSHhteO0nvplpw1G26wgo2OlIzA8cWBcoXW0pLLxpAE2B67DWJDDE6tHws0
 /QOcu0kKQLNNlL6UEqf293Jp35nSpwsXXqA6Q93C0jac9+l4B7MPCg5jAEIKFkz2odk6
 yrHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeGAxpw3fyJYWpKvWLY7URZuPMjTpVoPRO7L4rLJVSc+3Ba6LB7wptGj/0czdn1g7svSZs68JHRAmo@nongnu.org
X-Gm-Message-State: AOJu0YzpLXxBiE31EftfCjHbnQ+rLheOAKJVoUctV4OHMVIT5CHy8+qT
 1B+RTZ4MSnc6zKPcoq4+Qsw75bC5+ezhfd9iSqbfyizjaG3An9d/ltQlwfvHeJTq0Rw=
X-Gm-Gg: ASbGnctWLGrMDvsr1reZedV4ttgkk07RnPN6QaPWggL8gKBdK/BGrrCVH+T6p9NKBLN
 NvgFNCRw3uLGXVlQlCoOC2zcje3PF0gS9PaL7NWASUGfiM92kzxChZlPsyH2SAKorAaf0gt1ZWO
 EZgH+/oSP5jDqHjiLknk8ofZ4YeABWdnM7BIiZFLcld4ebm6uSw2xzSjWItbGxP37TDW4J0dv5G
 JkhfanAKcGzaFvxobd2tsVGZDcdBGd5gx8ng/og4ggykJDUZAinubpMnn8voe4sFtJPaFz4HoY9
 B+MFLggUh11x4BcNOTb0qnYS7CHe1o0MwkBBBL0xx73BBKnsQKlfENGgw1goVgaXSOSekUd72JS
 HHiY30Pmc35WyJhzjr4isVToJV9a3UdZmHZQ=
X-Google-Smtp-Source: AGHT+IG/zwiMldHxpUvmOdIYeLPFpO0JTaB8dJWIv/ZEEYZR/TfHMVxuz+ARqbAQt0r4YVDRLlHVrQ==
X-Received: by 2002:a17:90b:1fcf:b0:312:f0d0:bc4 with SMTP id
 98e67ed59e1d1-31f5dd9ccc8mr5486188a91.5.1753897484663; 
 Wed, 30 Jul 2025 10:44:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dfe953sm2544040a91.29.2025.07.30.10.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:44:44 -0700 (PDT)
Message-ID: <fa039c59-4833-439b-9575-73b0b8015e85@linaro.org>
Date: Wed, 30 Jul 2025 10:44:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] contrib/plugins/hotblocks: Correctly free sorted
 counts list
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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
> g_list_free should be passed the head of the list.
> 
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>   contrib/plugins/hotblocks.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Thanks for catching this.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


