Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1D6C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hw4-0002fk-GK; Mon, 07 Apr 2025 04:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u1hvp-0002YE-Pk
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:34:19 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u1hvl-0003rx-M3
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:34:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22409077c06so49282015ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744014846; x=1744619646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K+IIfG+44f0zEPW4A1Y5RVRLSNmHfihzy61vhazHnUc=;
 b=bTW7D8KJZsl/r/xCnfBkSx5hPvtweyUpLPckYTbWLU7coc4DFMQ+jTo3hD+PSNUWC9
 LTmtoNhqoBq4jS+HlvydUqXwX2r69GiQsSZRpRBz4E2pTqmVXjZDx7sQf8LGx4S0T733
 u9KU/bCgswdMUhytSXwtlHtxnqD93/igqivyNTaR1Pl2Jsrt8PILU/Ze3hFnjZ1ia6mu
 JlsXvF3P3d8YwjbYKcHvn1RZRN1+r6/2kdjY/V4m9QKWSVmTB44ubNqo72bEbniLR37o
 xwPJQvLhEnlh80P2D15hWfzifJI7te+wIOJuL0jA/zy71OoAw1e9JARxOmFDd4zRzLXC
 P5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014846; x=1744619646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+IIfG+44f0zEPW4A1Y5RVRLSNmHfihzy61vhazHnUc=;
 b=MkD+F3GybiL2cp4bXJdRkDBicxUCgW7Edoc1SBt4i5Ce5DsuFzi8hRcfX+6ndamJji
 QL5SmFrUzgRfq3cVhLYXvbNabRkwXxw8r1bIZJeNP8ZUdPqLNNodxhLJc+YkxW3oCLqr
 qo2TMIZoO21NN0pf0iv8zWYktapuyO592/GYI6iDUSFeill2ZBVZz26xmobUwcBtPbCe
 wNkBpwD6XtnFyv72wS2oNlXOnMSOgG4KOYQqn/OWsLQbS04Wgsy3anSacOjVGvp1XRVe
 re6W7T2SHljNSTBME3Z4ZDKcv6lAp5ZDjS/GB5lTfcGv+/b1LqWqJnpoqQBwi6e+1or6
 Wq9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3e+WwAnpjCYL9L+MkLIcttaJRGe+uGy2HzTDz0909sNVeFTvSM9uIGp1Oq0LhtcKic8ReM/K5aIKB@nongnu.org
X-Gm-Message-State: AOJu0YxPZ0qRYuHQL8JDydSICLd/VJRVj/r1d9kIKoHUmZNGssSuRARZ
 ZB8UG6pIb+I24BRiROyYO6/KAOuvUl4YgD8Vj/RfuxdXoeGSsCGn75PyeHMai+U=
X-Gm-Gg: ASbGnctXEdTNVIfzxguYFsn4zr2VdKmfM3hKQYaWGnYSnbSc4m/4eYv0C8XIE+k9orM
 wM0Ncy/po29d1bBKJYfxLlp5QIQBH9UR9bn8l0iwYVbVGkwQ9uZ/lMOVAcfn0soFA9TStpafIKf
 TfZ7Hml+75VydMrfNy/1LcpvMGBPfOMy0AqbgRJtdOSWkXr5aHjcO92EoELcma68gfVpkWijp35
 ZQxz2+PrwteVHEOabc1jznpGN+Gi4geIt7o5kJyewGt6SUyMaqYgUxC6OyoXxkFRVskHNAeh81b
 5kSWSbg77UcbwHag7p/e6oFd4lo7l1puF70=
X-Google-Smtp-Source: AGHT+IGoKsOJlkBhytfbgBSoWSEJSjvQ6F1tx2bzX/RVhqWObKpFlHSR9syPFXg0wBJnKgSq5qw8XA==
X-Received: by 2002:a17:903:41d2:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22a8a84af74mr140175395ad.10.1744014846586; 
 Mon, 07 Apr 2025 01:34:06 -0700 (PDT)
Received: from [100.64.0.1] ([147.161.192.170])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978772746sm75480475ad.223.2025.04.07.01.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:34:06 -0700 (PDT)
Message-ID: <ba3a7e9a-51a6-4db5-9f06-c1a768467288@sifive.com>
Date: Mon, 7 Apr 2025 16:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector register gather instructions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-5-max.chou@sifive.com>
 <87129ffe-fa62-4e6d-b154-8e61a22ce13a@ventanamicro.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <87129ffe-fa62-4e6d-b154-8e61a22ce13a@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
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

On 2025/4/5 5:14 PM, Daniel Henrique Barboza wrote:
>
>
> On 3/29/25 11:44 AM, Max Chou wrote:
>> Handle the overlap of source registers with different EEWs.
>> The vs1 EEW of vrgatherei16.vv is 16.
>>
>> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
>> Co-authored-by: Max Chou <max.chou@sifive.com>
>
> Since you're marked as Author you don't need this co-authored-by tag
> in your name too.
>
> Same thing for patches 5 to 11.
Thanks for the suggestion. I'll remove the co-authored-by tag from 
patches 5 to 11 at v3.

Max
>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>
> With the co-authored-by tag removed:
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
>>   target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc 
>> b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 70c19c49ae4..4a0c9fbeff3 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -3478,6 +3478,7 @@ static bool vrgather_vv_check(DisasContext *s, 
>> arg_rmrr *a)
>>   {
>>       return require_rvv(s) &&
>>              vext_check_isa_ill(s) &&
>> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, 
>> a->vm) &&
>>              require_align(a->rd, s->lmul) &&
>>              require_align(a->rs1, s->lmul) &&
>>              require_align(a->rs2, s->lmul) &&
>> @@ -3490,6 +3491,7 @@ static bool vrgatherei16_vv_check(DisasContext 
>> *s, arg_rmrr *a)
>>       int8_t emul = MO_16 - s->sew + s->lmul;
>>       return require_rvv(s) &&
>>              vext_check_isa_ill(s) &&
>> +           vext_check_input_eew(s, a->rs1, MO_16, a->rs2, s->sew, 
>> a->vm) &&
>>              (emul >= -3 && emul <= 3) &&
>>              require_align(a->rd, s->lmul) &&
>>              require_align(a->rs1, emul) &&
>> @@ -3509,6 +3511,7 @@ static bool vrgather_vx_check(DisasContext *s, 
>> arg_rmrr *a)
>>   {
>>       return require_rvv(s) &&
>>              vext_check_isa_ill(s) &&
>> +           vext_check_input_eew(s, -1, MO_64, a->rs2, s->sew, a->vm) &&
>>              require_align(a->rd, s->lmul) &&
>>              require_align(a->rs2, s->lmul) &&
>>              (a->rd != a->rs2) &&
>


