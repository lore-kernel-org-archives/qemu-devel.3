Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39589D12668
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQUmA-0007Eu-K1; Tue, 02 Dec 2025 13:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQUm8-0007Ah-5l
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:06:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQUm4-00076I-Ge
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:06:54 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42e2e445dbbso1391728f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764698810; x=1765303610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+2DfJzpMI1L2fCQutUHr9cI239dLMuEBOF2/o7EQAY=;
 b=ZrSTgplBtkyJmjNGaSSiomUzGx4E9qlWvsuhGmhNAdp0tv7oZtWtqP1ZR+N6skyTpk
 omRqPv+fXGN2FfCc58dR7REm8wUcQM+JtQIOF9G6QyDMTWec65CE2k1Po9qGWbhWWp+R
 fzZvQiCPDL9JTLT+uNNnndXZBbbXQpvpETV7NIspIG9rW1ZpG79pcb4kJv9P3j3UXHFb
 HyKmOiQKLwsT8AIqISOT3L589OVSNijqSQC7nS7VHtOCaO7/zfPXd8au55FCESs+9O82
 Ro+/daW6Q+9NiIZwI5bFcSKXOUSImRzJYOU2cev8b5ywxmh/9+QWMGnxUb7+BkDpXfQ7
 GhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764698810; x=1765303610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+2DfJzpMI1L2fCQutUHr9cI239dLMuEBOF2/o7EQAY=;
 b=thnhMwZf9N/LWh50lsYHEvKH3kZB+RqmRAy0xBB1c3GQiPswZVeVxGUoAJwMmtEIj7
 u0Tj8COdoPxMSSPaUecz423d42Rfb5juwy3Pg8btzWe0zF1+oOG694VILIgnHILxiTDg
 ogh3VDz9Xg90XR81UeaY/Kk6DUXkAOVb6JNLSwUTQcHX4uYvJ+v/jjfGZ0LaujyIYaP4
 6HpgpMvKMS+eBjG934EfjUZk0Ynf7N343fbcYuFQqW+5NwLRlCYPn0ALZedVbFPOuaZY
 yvhr5HEUYX57L1coDVRMFpdO5Ofvrar67IDE1IVr3p5rWKrzbJbUB6T9OyjONoVXHnPv
 d/nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCGaONz6R9syoOeWjvoHajbbAGM8JiRaWmAEL1JnPKv2KzgA30Ub0Sp2ci+ZehKqHbueFM7QLANaUG@nongnu.org
X-Gm-Message-State: AOJu0YxGusTAS60hyXjC+0rFeArxFNGzwIQvZCMIQ24gtuIkJ+3qj1CR
 NxHpVqWHmmN9JsMF580UoqMfme2BbHHyVSM/Sv2U5J0vJRHrb1Q0JKf69uoRm1rnAm4=
X-Gm-Gg: ASbGncv4hV1yfGaFZrtGewXbo8VJIdD/TqQIxC01dADnNsHXUtVYqPD9bKPciFOMe6y
 qncbI7XM0c5n86hJ+XhH9EFw4DFmoMSFSdxkDumpDt8f+nduzR49RxM2qvSgFTrx5wR9M2/aV++
 t7AEd9Zuh4CcELUvtS2mH1rSb8VUHH3htCJ7ZURoE2/sJAeYZGMR1uvY1HkzozJeV7mWLaewEjJ
 Z3CKMYDoRxdEk2ERM1JnEXZcb6SoZqTXOTbSsSFf28iS0ZZintO8e1L1pS7YywIp5NMg8N5Q8ed
 CXJqryQ4rmsfXoQn5pFJiQE1HhtPmnS/zbvVbwz0bUty6om2fNw9MRu7FAcLMeDzLoOTGMZS0Oi
 MYVpNkWRrsEUqkzU1pPl9Er+Jcs8Sftw85/MIYy5HSHQDJG+0WtxQAlevn0S2u6E2jbpJbQetgd
 cvQFvP3JpBClwhZGYrtL0mXKPQ8rmr26xirCiyiAaQbPRwNiZt0EITww==
X-Google-Smtp-Source: AGHT+IEI+bLwUZVsWojLoiGl7g467nKC0xR76GqDkVDnEAstQwgMPkwPouGTKw0D60tTS14NwSvY9Q==
X-Received: by 2002:a05:6000:1788:b0:42b:5448:7b06 with SMTP id
 ffacd0b85a97d-42f72208eedmr101409f8f.13.1764698810346; 
 Tue, 02 Dec 2025 10:06:50 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa5d02sm34904059f8f.36.2025.12.02.10.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 10:06:49 -0800 (PST)
Message-ID: <b2524f61-ba8e-4d3f-8852-9a97d3c05d27@linaro.org>
Date: Tue, 2 Dec 2025 19:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20251202011228.503007-1-richard.henderson@linaro.org>
 <20251202011228.503007-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251202011228.503007-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 2/12/25 02:12, Richard Henderson wrote:
> Since d182123974c4, the number of bits in a MemOpIdx
> tops out at 17.  This fixes an assert in tcg_out_op_rrm.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c                    | 19 +++++++++++++++++++
>   tcg/tci/tcg-target-opc.h.inc |  2 ++
>   tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
>   3 files changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


