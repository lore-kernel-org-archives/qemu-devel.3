Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnAV-0001mP-BQ; Wed, 07 Aug 2024 16:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnAT-0001jd-3S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:21:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnAR-00069e-GQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:21:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so3086085ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723062113; x=1723666913;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lWBaTJW8YUN9Vv2IVGuCHyEf8675XQT6DIsnuhv+O4k=;
 b=nTFsUh4OfqzrtTIm7rltuoo6Sxc4zoK9snj84gG7J0/Qj1sqSsBmQvlnN2WWtnKAB+
 Khv9RRrWKk7garmhwZCTEaxho41HZBjI4tRWxlaf67TmJp2ERw/5gFS3zZCB7VdZEO5u
 sCSqGNF4IuoJXeYi97gbFP4C1W9h0FlbKMaTQhO0E5s+iroDG22tUNVR6ERorKaHSK6n
 WDbt9sXSYdZLr4TSq4qWr6Ap5B7DA3tddVUySxtQ5vhkxIqOY7T3BW681MYHJHPXXlbD
 7XbYQdKn0IdUD8FtX98EfvIw8AIZhP066AYxYTSI6y2xiku6WpZJunKN0h4B+TZ7zJUj
 /z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062113; x=1723666913;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWBaTJW8YUN9Vv2IVGuCHyEf8675XQT6DIsnuhv+O4k=;
 b=B/E9fHTO1rMg955ZQuGGCnkaPBhq3144k1Z/1qgy6S8oCR1kELFQlGF3lndAhkDt/q
 7yqRSmS4j0ou6neooy7ZrQ9v7TNY292T2UZXK8AVemaE/0nBRs0KTegYZxYadIBX1CS+
 Y4LN6ev9sP30NlqrI/6VAX4/8zQPxhBV5EFUEYO3HPFnVhnCFBRXcK3QJtZ0g+8RjRAo
 c+2yghbI2rp7OKuVIFWCY8XtlwZxXpztBvmg1k/7lNcHeE0nJDD6Zyz3M2xVyV72x9Bw
 PgOIJitEK/p+PHgtl0rQjNf8mCKdxG4mi5LzOYIqK/2bFF/YCzH1meF6hwTxtkCSHR8C
 fwfQ==
X-Gm-Message-State: AOJu0YxEth0dv9jlQhVDknf4UQ23EcaAEAFxEVySgJ5mtOeRopV7aAAY
 /q+J7iCtwaKeGQVXzIhavm3XnKVHI4fPa/1xWxGs0DCuC/yEEqmBRvF2wIi/1kE=
X-Google-Smtp-Source: AGHT+IGehvdY/LCmIzhzihA59V5sUEgpEiaAoksO39cuwv+c4kNT+f7TkKLDMZx/4Ni0xKpxqLknAw==
X-Received: by 2002:a17:902:c405:b0:1fd:8f66:b078 with SMTP id
 d9443c01a7336-1ff573b55c9mr218868905ad.46.1723062112536; 
 Wed, 07 Aug 2024 13:21:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19af1sm110771295ad.47.2024.08.07.13.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:21:52 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:21:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 10/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
Message-ID: <ZrPXXdbwhwKtyBTW@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-11-debug@rivosinc.com>
 <34411ccd-5fc8-46d8-bf5e-871949c755fb@linaro.org>
 <c530ae34-497b-4cd1-b3a6-d8b575c33fb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c530ae34-497b-4cd1-b3a6-d8b575c33fb2@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 12:12:52PM +1000, Richard Henderson wrote:
>On 8/7/24 12:11, Richard Henderson wrote:
>>On 8/7/24 10:06, Deepak Gupta wrote:
>>>diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>index a5a969a377..d72d6289fb 100644
>>>--- a/target/riscv/csr.c
>>>+++ b/target/riscv/csr.c
>>>@@ -185,6 +185,47 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
>>>      return RISCV_EXCP_NONE;
>>>  }
>>>+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
>>>+{
>>>+    /* no cfi extension, access to csr is illegal */
>>>+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
>>>+        return RISCV_EXCP_ILLEGAL_INST;
>>>+    }
>>>+    /*
>>>+     * CONFIG_USER_MODE always allow access for now. Better for user mode only
>>>+     * functionality
>>>+     */
>>
>>In the next patch you add ubcfien, which would apply here.
>
>... anyway, surely cpu_get_bcfien() is the right check anyway?

Yeah you're right, `cpu_get_bcfien()` works and simplify it. will fix it.
>
>
>r~

