Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90A6C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuriI-0000Mz-Rm; Fri, 14 Aug 2026 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wuriG-0000Mj-3g
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:12:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wuriE-0000nr-O1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:12:43 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso605410b3a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786713161; x=1787317961; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pVO0gQa3IhGHm2rsc/wKo5/kWzeV9v7mTlTjfwhKrHk=;
 b=BBIRlDSJRcqc3oIZ2E3UvW55BQ3MFfWcml9VzqX7P1aL9rX6LHbuneXbxPV1sKidmU
 S2NatZa7bW+nc+MQpaPrmLjilbxxdQ5b/+UyjRS63UwF7OY5L+NmS4zm2fzZRG4d2I7e
 xuSJ3t2bOkJLO75s5gQSLmT5P7ks6wNn8UzsusO9H8ENw1fBotWDVVCFsKqObef7O1dl
 PbJx3Pq3fEfF7DKfgrS4QbuoKMq5XERVJf6A4YsoEKipX91SnaW34TzO6t83PcuSDUbG
 yERNZp+qnaNGreeyx96SqxHlaedtefa/0Kg07mZ2N89roTA/btdLJ1Gi9U60JK+2AYsP
 6eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786713161; x=1787317961;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pVO0gQa3IhGHm2rsc/wKo5/kWzeV9v7mTlTjfwhKrHk=;
 b=KgLkyEcgyA/B6Ulhg9G7qdFt4QEX3dSxaU9PHOFwrql/vmYR+Eg1f6h4j4KnC9NSRk
 J265eQ4YGRKiYbuw7FvGSL8EaR47RKSWTbuOjcf7H8wa02QtlIJkKypyojeNfFKIEZ9q
 CB6JBGsZOAtDXmLmXZ7bqf8QMT3X5ks1by8WlP7KuHF+0ZN3iEWxxuQBBYc6Qk2tT8v3
 4EnM8umGDZMkL+lcWqIp2gn9G5ciOBXQvsLQVPdSeMoseuKV85skkBrEAlWJMpsgDzfQ
 +8olnMubMJrjStfke0z0IVFQQHmfD3LRJxlmcyPzoE943MktadKdHrieYA4aQsBD/TtA
 ncYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8IzWSjiiWDVBAp8StIsMEKgslDYnls5X2pB1HBJUrFa5NxW1i3wEAlpW2EqrzuBPFkBk3o0ArQFJP@nongnu.org
X-Gm-Message-State: AOJu0YwrqkF+DksIVfi084xe7pYodzfFXVYHC7LgCkd/rLTtnIFRhbms
 ak7FpGEaUNG69Z3VbvRX+6dPHcJnPjnizbMiLXWVSC6djwL5jHDFNeMc
X-Gm-Gg: AR+sD13vsvtHHdrsdbSypcANzsakKM5oe0e2vmzpQbPLRRPHq5x6Bc04DIssvWx/JrF
 cX6bGyOHzUH7Z7Z3vqLc5lcFtwXdo10Ele/Qm33Mh18A0bu30XgFBi7DYFPbbuuX8c+L8sFczfp
 ZYRSSN8+itY8PrYC/toSN1cehvFcI2Y3snWpnPBT4cL+byT3zusHxGwPX7SsW6Dvzgv3pI4oFD1
 VbV1IbI65eTDXcj3rGuxrFX3YKfILR4HhS539fC6wQa8m+kqACY54pCVCJQ6oBaEsWQucZk2vce
 Z2qbmDmH/DBgF5WSFU+ulzD4MgW+X3J89dNKqk41UczIxU8JcSwe6FrHcM/0dDr3If9R3IQ1AOt
 4xsmpRnmeT85lDUEJ0+T5D7CgwKxJ65Qlh/Udot/tDGmNQD43uBxPEN/3x1N1jJRrcGulB5iev4
 MVLyZJWo6OjE3kfmKVuRWX931c+xBbHwPJLKV+thBxfXW2jaLmnkhQE8VTuOCX
X-Received: by 2002:a05:6a21:e8c:b0:3c3:954d:279a with SMTP id
 adf61e73a8af0-3cc71d8eafdmr6482572637.33.1786713160901; 
 Fri, 14 Aug 2026 06:12:40 -0700 (PDT)
Received: from [192.168.1.35] ([112.133.246.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc095a43327sm542621a12.28.2026.08.14.06.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:12:40 -0700 (PDT)
Message-ID: <c02148e5-9fb1-44fc-8652-e2f79b4730db@gmail.com>
Date: Fri, 14 Aug 2026 18:42:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix invalid sstc predicate in gdbstub
To: qemu-riscv@nongnu.org
References: <20260530053200.902591-1-314abh@gmail.com>
Content-Language: en-US
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-devel@nongnu.org
From: abh <314abh@gmail.com>
Autocrypt: addr=314abh@gmail.com; keydata=
 xjMEaaCh3xYJKwYBBAHaRw8BAQdAVM1RsDD2FeoNQaZK2QC/kzkYIIfu2q/KFJAYfDCpNIjN
 FmFiaCA8MzE0YWJoQGdtYWlsLmNvbT7ClgQTFgoAPhYhBG9m91dTkOrKD5lID3UzAekWp6jS
 BQJpoKHfAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHUzAekWp6jSz6sB
 AIyMERKwB5XgphDIZtbjD9g2FiJpQZqqPDhTeQOEZ/AaAP9YDNmDmxEYizl29eYioMxhA+37
 xFTSw6WSY07BomlyDM44BGmgod8SCisGAQQBl1UBBQEBB0AzQxaqj7K6RZqXl4xOIleDubFp
 TQsXvEMWiRnJobgjMwMBCAfCfgQYFgoAJhYhBG9m91dTkOrKD5lID3UzAekWp6jSBQJpoKHf
 AhsMBQkFo5qAAAoJEHUzAekWp6jSrWoBAMgbTZK/HqjOv6Vqwl4uy02pZkeymtrbjARfNUJF
 K/7DAQCooyWGaQ6m0RM3RC+fjSCVa8qyuppeq2wSa84UBhmXDg==
Organization: The Public Safety Devil Hunters
In-Reply-To: <20260530053200.902591-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/30/26 11:02 AM, Abhigyan Kumar wrote:
> sstc function incorrectly checks for avaibility of env->rdtime_fn.
> This causes it to fail each time it's called because rdtime_fn is setup
> later in the procedure (when timer devices are created). This prevents
> stimecmp's addition to gdb.
> 
> This change ensures only the riscv_cpu_cfg(env) check is done. rdtime_fn
> will always be NULL otherwise and fail.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---
>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f5b0895fd..d72df945f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -590,7 +590,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
>   {
>       bool hmode_check = false;
>   
> -    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
> +    if (!riscv_cpu_cfg(env)->ext_sstc) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   

Greetings. It has been over two and a half months since I submitted this 
patch. It's my humble request to know the status of the 
review/acceptance for my patch. Please inform me about any required amends.

Thank you for your patience and attention.

-- 
Abhigyan Kumar

