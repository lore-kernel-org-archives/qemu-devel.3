Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86A1CD6E60
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmbu-0003EP-24; Wed, 03 Jun 2026 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUmbo-0003Bl-9F
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:30:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUmbk-0005d1-9W
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:30:15 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so454965a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780497010; x=1781101810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vyWwOo++YFOGVv4/g8nFv0rfbKSqy+6XKmAPVCL3/x8=;
 b=Jd4/NbDfRRehYChM3UAZXfyB3mqllxvaEL0k5LjELg3+EvbnNPmPddZ048euaeo63d
 Ix7v+/+4tMwlUtaWu8eob101/N3i/scue3/wIz3hn3KxAbfPwqe36wLO5bqhEs+2XG1I
 vBETLhReKxXmfw6TqcGg8xws8J4CQz7jipe7uxmo8gZx5nirGEYXqJwQeAQ+phc3Lu/p
 4/+9H8kQmKid6aEqgTvw3NV6m4uZS2+epAqgVjHQ6hTb0xXoFfigLmAZAZy9l1zLXtTW
 qZTvpCBxrwnjNhu0fgrxJ1tHgfO+dyIndgMeT7Qt8b6x6WwpXh0VNhtPPBT9uWc/x0+E
 VspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780497010; x=1781101810;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyWwOo++YFOGVv4/g8nFv0rfbKSqy+6XKmAPVCL3/x8=;
 b=ih0tt2siDUvUVl3laVRYvaamNepLVIgmkhNuB3a152p5VB6gMcW65+t9GPuXrkA+rq
 GF4pLlWgxwApH4vDOXc4fjDiJ6geacXd+wlPNkMnSNjxILX75zzQ+TRM3+lDUD5TsQPu
 +9Q89xQV64CjkF9AR9BTDN808aXWWC8LRzczPrhjnlpTRBLJwubvcfbrlL4yWfMF8YXq
 OQIhgLgnldazS+MQbJ96LDWuG4zQrLEBwO7+vceNes0hE74p7evtp8vFb03KntszQjhU
 Zqa//P2kyb47O/x+mPdT1UtuMOzWJpp7xXGXXfwxyjkE6emaatA4ddYfkUzykQIeT6za
 6Llg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nst5ivQ94HRx+RzCTZSy2VwY0eTVcSniCZBEt/h97ZWVcDV6HYZE1fXLQrXLlfYaCgCu2IAVfevLU@nongnu.org
X-Gm-Message-State: AOJu0YzvIZN4Ay/8qccjvDRt6vjirrmLCNfJAMIIHzJAIG+9R6EjgG/f
 oJn+KIwrMSarwWCv9mh3sfK+NNMLCotmbXRZU6g/i3W14sd9podqQYWo8fvTwT7fpik=
X-Gm-Gg: Acq92OFVpV48BUh/hjT288JLV/ySJyzR2yVBrGzjYYmzJrqtsZExxP2FtQosaGJQWQ5
 +alzJi9j+iF6wMmC5ZICwYW3LBr854Qsf08051tdzlPYlgTHm+Eoq65eJ4WWLvACmT+XXDFBUWJ
 rhWT1sh2MI8auiQ9wUevj33dWJy9e0e/R2RwWjYxNKuuJWnH+kNVLc8gqKkgAVq2LxRtDfWR9EV
 n/x81nhaK9LTlCiVRgYByzc857Cql0cjRFnbqF/F2P+B441lFJ7gxRyHFI040hxQNU1sFDRb3Ut
 pKPYQEZQHsTVye2W9/xy8+KOQBBZAaacsEBK4cHLsZLf+ZKKDL06BrXWlakre5HNEUlK0VB3RbZ
 sROmKmh86nWwNbb8DoXnH9oW8pKqd/BidVwFiqnIQvyDonF3CN7uXI7ucrm2b6DKqCcjZtk6fNr
 K2W5ag1DVj3dObtCuRpAVlQzhW/FK0WNLlLITSHwO5aCeHxcU=
X-Received: by 2002:a17:90b:4c0c:b0:36d:86a5:5b8 with SMTP id
 98e67ed59e1d1-36e3af6d8c6mr2607250a91.11.1780497010080; 
 Wed, 03 Jun 2026 07:30:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36e0a144605sm4324900a91.1.2026.06.03.07.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 07:30:09 -0700 (PDT)
Message-ID: <846d7958-6515-4e4e-8c15-513e282aaaa3@linaro.org>
Date: Wed, 3 Jun 2026 07:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/20/26 09:07, Chinmay Rath wrote:
> static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
>                                                      ^
> I see this happening in the last pointer argument in function
> definitions after macros (like TRANS(..) in this case).
> 
> Richard, Peter, Stefan,
> Could you please advise if it would be okay to have the above false
> positive in the patches ?

Just ignore those.

r~

