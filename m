Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23FDC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5A1C-0002Ak-9H; Fri, 11 Sep 2026 18:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5A17-0002AX-Jg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:46:45 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5A16-0006t8-0j
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:46:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so1617472a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789166802; x=1789771602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SzxwgvJp+FhZL7mIrBBgfUIoGMsjcFHKZlNZrXmcGr4=;
 b=AkerV1Jsx10wGjwo1GarseZV4kXvqeM/50GzZstCb+FL5aM5K53pn814XtG2LaJ2dL
 IYPjWPyesZLQnwO6b5djFwHNL0tUHSkrrWNIoHWPVQZUsHzptgZwYA1Ucw81dBbxjvmx
 lK5CF3T8lP4cQMX24q+gkOI5qvmHxEi2IFq+FU5x818yMn8F5A+jc47X6v6xgl0547da
 9FWpxUjLXY7hFkOPQTHhsLsw8E2VEc5e6FhYZfHKh0GgYrRl9HTgcmBLSvVmfvsThaKj
 FbHzyFdJcAVYSVYX9BWUEYg99beug4PzeJc+taZ+ajk8iQS35jvTL+V0hznbeFuQyNtk
 lqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789166802; x=1789771602;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SzxwgvJp+FhZL7mIrBBgfUIoGMsjcFHKZlNZrXmcGr4=;
 b=tRvJgba5FvsIEg+JRo7raU63olihn1mXZCgzZ5TK80vO1SoZPqDp/CUcYB1RMmU+kT
 a41rClXRK82LEuzFRZ1iMMxXRfK9sugz2bOyIdn2TFt5U/leCCQcsKqj5Kvqpm9tpOm4
 GeLOCWqYWuXoJqekFQqC4XldvjkZssvxsquW//Yv3fdF4V3wrlsiypjniNtVgzlWChqs
 2ERQg12QQqKKFfn8Li43lXj0sIlvIAYeJRwNLwItZxXpSVsXbUTGd+7gVrq52KNysr4U
 KsBKp8FWlKoL+1qwFPmP0r0aMaLAtIwmjiJaf+dDtaC1WolLsW+Lmc1JGN4FY5XSQJkG
 vElg==
X-Forwarded-Encrypted: i=1;
 AKwUvByI9EOtNapGTixoDqC2FM5UkShfUnrhV35r+1vR35H2TIpOc5YSSThpvm/5gDcp8SLu/CMdUtkEZpcr@nongnu.org
X-Gm-Message-State: AFuF++nC9y7JvUq4jaWi61WNszVdVyvChK4JHw0EY/bB2H9JfsRLIl+1
 A7clnOb/E0R7B2nXRaYsv+uHMW411690Vd0uxxJZ59iSSGQHagPC4EEtBIMDkmEQyws=
X-Gm-Gg: AYBFou0W+7gq8eNJ0iRF0XwyuOO6S/O/24CPF2wEX24ATiOuVYlK3dqHVL0906yFGkr
 xnILAZ7/lc61RncmEOAYZPIHTzjchssl7WKPKNKUgMymgDAK56auBlJGiTox1B4Dzcv5S4FmUSH
 L9xuMkOBVRgIcATv6i92/n10VtQR048DNzcDXbFxCSNdzQa9j+nEnhNG50pnALfIYrvYc/8p1mE
 IYCsZMr8k1tzPYWQZ3N+MrkfLgZeDUbM3WMqB6utd/N/dKMnKPiiBSoTM1ypSkdZXBubCFQR6sW
 fAeMF4fuxYocZmzNTsBfTIT4QN19yr0eKwshgOc69vmTyyT0h7qmorEo9eoKPxPu8ENxOiOWmUX
 QDn/WkgynGYdZt+qi+ypKMd+io9fqB9tttvL4y5kTj4roojlwTr1qPh4dwziCx+aBN77JBR/6Cd
 NJCCDZnR33rDGGqi1cKhXB/B/xX0na8fTTCf2WpvvOKqOCMYGuSBaToW2PR7xPI+0dHnqmef0wo
 x3uTWcUAMX0o8Sie2brMdvgTFQ2rumizR+Q52Z+94+qpF24B97fReAVxTg=
X-Received: by 2002:a17:90b:4cce:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-39d9bec4d91mr10698935a91.10.1789166802322; 
 Fri, 11 Sep 2026 15:46:42 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm10241975eec.28.2026.09.11.15.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:46:41 -0700 (PDT)
Message-ID: <2c2a7188-d95d-4ed9-a026-f505ab8b14c8@linaro.org>
Date: Fri, 11 Sep 2026 12:46:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] tcg: add base arguments to the gvec 2s, dup_i32
 and cmp expanders
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
 <20260911204334.1264922-3-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911204334.1264922-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 9/11/26 10:43, Brian Cain wrote:
> These three families still name tcg_env directly, so they cannot be
> reached from a _var entry point.  Thread a TCGv_ptr base per operand
> through expand_2s_{i32,i64,vec}, expand_2sh_vec, expand_cmp_{i32,i64,vec}
> and do_gvec_shifts, and split expand_2i_ool out of tcg_gen_gvec_2i_ool
> the way expand_2_ool already is, so the out-of-line fallback is reachable
> too.
> 
> Add tcg_gen_gvec_{2s,shls,shrs,sars,dup_i32,cmp}_var; the existing entry
> points become wrappers passing tcg_env and generate identical code.
> 
> Note that the operand swap in tcg_gen_gvec_cmp_var, used when a condition
> has no helper, now has to swap the bases along with the offsets.
> 
> Reviewed-by: Marco Liebel<marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> ---
>   include/tcg/tcg-op-gvec-common.h |  21 +++
>   tcg/tcg-op-gvec.c                | 256 +++++++++++++++++++++----------
>   2 files changed, 192 insertions(+), 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

