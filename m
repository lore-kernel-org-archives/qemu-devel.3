Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47BC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Slc-0002fd-E8; Wed, 23 Sep 2026 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SlD-0002bl-Bn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:36:14 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SlA-0007ZW-Sz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:36:06 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so802594a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192163; x=1790796963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YTZsQlU4OWS4X6Id75A+gNq07hKmNaBDfT08SJENRVs=;
 b=njfFxzZ8FocF4ssZbjbVxB8QAv2rbPYhBgVOkZYos7znLzOPWH7uovViVeVDrbegTv
 EmXr/xq9W1HDy0DMi5ZoHPK8N2vX8t5RYzsl12jk2l1glIHnRVxvzUJw4/e7MsdLeXgH
 fTL/pQKH/FSPi+uvMMPTmEKlx/KdrP3wIdMLjZuTNIFAiQufcI7OuSe9Jg0ABmWb9TdY
 pdMX8djqpXmk4egJjuPf9oC5a4o8ZRxo/pgLfCxd0mttJprb4+IyOwuK/FwV1Cl0twXa
 5WMg2etDRtmsLzSfStZBup5zz0Fsah27CiBx57VTpngBgWc4odeN/ya1sq38iYu/mbiY
 CrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192163; x=1790796963;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YTZsQlU4OWS4X6Id75A+gNq07hKmNaBDfT08SJENRVs=;
 b=d9mqu+y07gCadwiaRE3mVJAv8BPGE6if+KfKCh46bvi07bE7t9MKdL0PBZfoU/k2t0
 eSmywMOLqExx3nqx3tDa2lDiix695wWrZrzwQLY9Elo5wfqP9np3sQ3vyeZ1Smpl8N50
 /zC3ZN6GA5QUsd8jKV8QqCM6B/9zZX3ih1Fq0kHTrXmdb6xoxeyDXVdu7hcx5VRAJ6lL
 T53Wb03xFy6M5/zuF258KpQDc4v18lnJugfTAUF3m39yGs2UvkMIkFwGNTlrMlmyOcWw
 4yCVHOnyTw9rAjIjsGJ1yAeszOTWvYyOHPPO/c7GhEJBRoz3Xpl4/08iv204Forzyf9I
 VrYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0M4wur02HFAOqDNmd4Ks2z9QVuumF/JaiinrfC+0BpNW6PZhV+gdoXhzPRu7mw/WLFZi1ORizmQJy@nongnu.org
X-Gm-Message-State: AFuF++ni20yGMYtWfsb+Gjq6JH+Jn1BaD5zeImD/Crk6C2rBpuExjbpf
 SxmpLhZKC+7NIrUXZMQSZlxNaOqrmB7ZrvvZDzXR4ueau5NgHMtbYPkpbwu+OEUFhK4=
X-Gm-Gg: AYBFou3iu74Ct2cK18HWV/wGjs2xg3u3vLSgEIboR1EFJG6qMrVKzZfbD+qIOJPw3ID
 Hd5KQaIRA1uEIkOaZ5L5XC2iR1UW/KbF0hVzonDGlmZBhfTn1nBXTbXn2JaWbUTEHR/elkAUUAp
 Ufr3kG1O1PGxD65I0AbJZ3XOcR0VDqqYrQrn2W66olcBbJTvtkAYdwzTUVB7sUmvqLPSsn9uVem
 uaZNIIyA7V9xLwdTZb9evKi/svI/ugdt6/9XndEVj+JifnXIJ0T19RG9x+GXY7RbSMkiVwOH1N2
 FykBMT/BpuJgG9V+nKCHzv7ainyzsy+ieJwMLgrhZNgOVhtx4KiAHFWUOxmznzz4VWccmdy/HjF
 d/zeCR0Oh1/b2rvmrbbkHIs1R5l69Rx7OKzlQo/7lQECKuOBncAXox+DUFrATuEqL5iv87ZBvdF
 yPuVlHK4Cwb1V1GJ/EZW6M1n2d13AXMpHla2TInQOJluVX/MzfUSeX7ypHIeC+hDG/WT3Je5tvK
 QeFcDkWN5TNP/GHtjM10cRVsHW2OSO5dHCRxUhB
X-Received: by 2002:a17:90b:2ccb:b0:39e:6a7f:eeef with SMTP id
 98e67ed59e1d1-3a0986eda5bmr111270a91.20.1790192162311; 
 Wed, 23 Sep 2026 12:36:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972f2cddsm603225a91.1.2026.09.23.12.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:36:01 -0700 (PDT)
Message-ID: <921a3a2e-e3d0-4130-9a2e-dd47a7ec52c5@linaro.org>
Date: Wed, 23 Sep 2026 12:36:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] target/i386/tcg: use standard operand order for BSF
 and BSR
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> BSF and BSR currently pass their source as operand 0 and the old
> destination as operand 2.  This nonstandard order was needed so that the
> source could use zextT0.
> 
> Per-operand extensions now let operand 2 use zextT1, so that BSF and BSR
> can use the normal X86_OP_ENTRY2.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 18 ++++++++----------
>   target/i386/tcg/emit.c.inc       | 12 +++++-------
>   2 files changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

