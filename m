Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C60AD2F7E5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 03:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1HYd-000878-Ol; Wed, 16 Oct 2024 23:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1HYb-00086b-Rl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:52:14 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1HYZ-00007u-4q
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:52:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e28b75dbd6so365075a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729137128; x=1729741928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dvj9UMnouCqd3RtyWrvRc5S18+3bafL37elaq+xd6Yg=;
 b=kTFsfPYus8D4znO7J4Mmg9fMkySG4lOwmrQJizVEy8HC5UK79DaPne859ByNl8PhA6
 ZBdjiSFpR0Hae0SmD1ZcA8d/B4tCJ5TVXwlpFrQx0GxlchgkNl67YrxjQJABIMzg/H/y
 mp0ZSVEh55z4dEmC76I4pF4ybBae/E6Wo6d6mWgmgENYCrWU0IY5keN6ts7MG0e29t1k
 I7+OiH1gXp4ANS85yLCVbzHYc9WqcHs8yQqj0og8IuQj8lxvo7Mj2GIcw8Jqc3BwbmXd
 +zxFPDKinXFOcKsCNa5bQrpF/A8LwlNPLHQcwNi1pNwsaUgCpIkP4IjwkLBTdcgXNa4e
 VW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729137128; x=1729741928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvj9UMnouCqd3RtyWrvRc5S18+3bafL37elaq+xd6Yg=;
 b=j8ICRiWRLuh6J94LYWO0+F4NanAS24jtQBXG58ZX+Wtmqbrp7x9ISIQtoL552I1qfT
 dRWh3uB7YMmI04jxBKAnbrApkfnROptzJl6VG1h8ik3oSq0WVFUYQnfzNANoqH843gYq
 4VUvImbEizizm7JBZvMxqttVf4yU+9BWCkK2xRGu2agQ8CjR2CTXo6BwthsQKGTBI/73
 w6o5LJ1rtxHPNUH7LFJCcW0eKTq6Gy3y8/6i6e7/HDF1QdxA1JWlUGEvL2yA8OgulhgS
 r6qgj4+t9Qhumwtg1k+krKJtwi6ApW7iAMJUN94zS0P3LX3cHE15wb9FEyp3UaJsnFsX
 /j0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8GDL93f2RuRLPR17ZD7glBx88WsA3VY3qWu5Dk+Fe5v3mxykzlGtbmYl8k4OQrBaR7UxLKsY75EYB@nongnu.org
X-Gm-Message-State: AOJu0Yy+LZGMrQygjbglCnNfCy0h4nU1W6MiKSv9an2HLL/5Ctzcxu+X
 IqXVEjHQlhSYxLLE7wXmN7SIbkEt/Srr29FQNW5NN9GCK4ZnPxSJlKr4gHKVwK0=
X-Google-Smtp-Source: AGHT+IHV2DDLQNeN2FwfDQqrbCh8m9ogWs4kVMkFKdTfKWkby6W+FbPJRozolZJaQiRPxOsvJdMBWg==
X-Received: by 2002:a17:90a:8a92:b0:2e2:e660:96d5 with SMTP id
 98e67ed59e1d1-2e3152f4b3bmr21750251a91.24.1729137128537; 
 Wed, 16 Oct 2024 20:52:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08c18a6sm705777a91.21.2024.10.16.20.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 20:52:08 -0700 (PDT)
Message-ID: <8b1e3b44-1cd6-45a2-933c-a7a599598758@linaro.org>
Date: Wed, 16 Oct 2024 20:52:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Host riscv disas is broken
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liweiwei
 <liweiwei@iscas.ac.cn>, Christoph Muellner <christoph.muellner@vrull.eu>
References: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
 <da7690ea-a02c-4402-b798-fc29bd07451b@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <da7690ea-a02c-4402-b798-fc29bd07451b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/16/24 19:57, LIU Zhiwei wrote:
> Hi Richard,
> 
> On 2024/10/17 02:38, Richard Henderson wrote:
>> 2595: if (dec->cfg->ext_zcmop) {
>> 2690:                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
>> 2716:                        if (!dec->cfg->ext_zcmt) {
>> 2726:                        if (!dec->cfg->ext_zcmp) {
>> 4028:                if (dec->cfg->ext_zimop) {
>> 5044:            if (dec->cfg->ext_zfinx) {
>> 5051:            if (dec->cfg->ext_zfinx) {
>> 5058:            if (dec->cfg->ext_zfinx) {
>> 5065:            if (dec->cfg->ext_zfinx) {
>> 5371:        if (guard_func(cfg)) {
>>
>> This structure comes from RISCVCPU, a target structure.
> Oops. We missed this.
>> There is no such structure for the host, causing null pointer dereferences.
>>
>> The zfinx references can be changed to
>>
>>     dec->cfg && dec->cfg->ext_zfinx
>>
>> but some of them can simply be removed, e.g. zcmop and zimop, which are otherwise 
>> reserved encodings.
> 
> Should we probe the host feature like what we do in tcg backend support and then do the 
> right disassemble according to the probe result?

I don't think there's anything that is currently checked in disas/riscv.c that needs to 
know about the host.  And, as I say above, some of those checks can be eliminated.

Host disassembly needs are limited to what tcg/riscv/ emits.


r~

