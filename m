Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E6E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuof-0002le-S5; Wed, 18 Dec 2024 09:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tNuoF-0002i1-Em
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:13:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tNuo7-0007UZ-MP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:13:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso46170565e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 06:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734531222; x=1735136022; darn=nongnu.org;
 h=autocrypt:subject:from:cc:to:content-language:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PW1wHV354/Pv7XvGOyGFzY5d1m920o2ZFJYpbtOX4ew=;
 b=Cj30S7JOJpcHyl255SgxFJDedENBpeykqFET9T4SJcyUIF4XkzUtfp4XBQlp7EYJ5m
 IPE7bZqjth/GZPvNhL+kb+ZY9ls5Bm0tPpnpb/nzhKH2MngLjp5giTqPziPDwIOSAwd/
 3l55xnF+eO+e+fxjWD/Daj1/H5dP2wiRvadFaFpHVOjc95szWPq1epVH6/DUN0ktYv74
 V0PYz7sZm9007LbMgdSsioDlC9sAkcDNAL4T8n/soDJS5iwE6q0zbKOR0luk4edLt9Zg
 9rlQPe5+tYZ3p14SODfUpWdSc5d37Hq/EXNL5zTPuMZ8jWk+VceyZGxtESUCyadWkln5
 KGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734531222; x=1735136022;
 h=autocrypt:subject:from:cc:to:content-language:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PW1wHV354/Pv7XvGOyGFzY5d1m920o2ZFJYpbtOX4ew=;
 b=gn9MJrqHLCaw9ygv3hmXz85YeOuBeqYfRwAWAy5dVl45AaI9XOOME6XInawUeZVkOu
 xt+tdnudplCYk5W8F2vWyNwBPv5rrq5lE509S6BI2LLwkFE7xCKcFV1AS1eub4f15Sj0
 KJXxoIoPj4SGPhKDwpHst49bbOpLlbTKa0UqIt/1VQevGUsAqg+vjyVgfZka22SwF6nb
 O22IYcEs/SrL5GQxl+3R3grRyTlAdgcnqLJmlxtKhxJSLS5fMwERZIJE0bFL7umGBJRr
 O5rWdI0CCOvhUBCKeZ6XzS9I7wpWyZlyshEqCcKBnYenmDFE9Dx8NcDdWQADfaAIJ+hG
 Jayw==
X-Gm-Message-State: AOJu0YxY7ewk2HC4SzExLimwKDs4zB2sLzq0XwmAh45JIg7rc8rZ9V6X
 wXkuUhFHJlHvZdhJIQWU4etE05gGqcW43G12PWkZNa72OhWcyUE4KATONjJ3/FhZ6vyBxsDrK+K
 cC6w=
X-Gm-Gg: ASbGncvmUPlOL9T3ax9rM0Vl4z4iW/SPW+1i4w2gT246gCFS+0bGK0sK1/sdZqm1cpA
 ziSi3ZY+WKxUKv1+uizF8BCRL66bI6/XWWFPNu1JMByyGOhY5vk0GP4ebORsFDSKDkRRI+tV33Z
 xnzYbpAawE9+Xa0zpawVvvOuQCajPypkcXOrC1Y0vmtFfnf9Za9yCt8HXtRrclzUZxqJDUW/NEM
 SXwpMvWA4dOQi60eBIbAdOEr/mZPaPC4cbKtpZrxqqErtmmoCmaTgg/RAtfrtqdqR5+13jLHQeg
 xkxlM2m/GWR3CO0OmBM1uGwsOC+CbXGQwNpEalzbQpDe6b6xCdevgsA0
X-Google-Smtp-Source: AGHT+IHjlGLQh/0Ht1NuzfwFHC7r3NUmSz+8SSoHLydD08jL2KtomiC9JrjhzhUitw7DI7wXOCl3NQ==
X-Received: by 2002:a05:600c:4f11:b0:436:51bb:7a43 with SMTP id
 5b1f17b1804b1-4365534876bmr26179015e9.5.1734531221001; 
 Wed, 18 Dec 2024 06:13:41 -0800 (PST)
Received: from [192.168.0.55]
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b190absm21443525e9.29.2024.12.18.06.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 06:13:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Cvehq0i4AsoexwhQMkalIpgW"
Message-ID: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
Date: Wed, 18 Dec 2024 14:13:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
From: Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [PATCH v8 0/2] target/riscv: rvv: reduce the overhead for simple
 RISC-V vector unit-stride loads and stores
Autocrypt: addr=craig.blackmore@embecosm.com; keydata=
 xsBNBFdIF8oBCACwrsvc6YVfzJRT+ZoBfL9jEb8ITwNahDxCGSG6sIWrJ9UFeTwE8fnNhMpz
 RyFRm0OXruS5k/8YHJHrxKxFY9cgZ3CWNftXEjRqURUWGtN/ESiw0J7nVfhSGQTo3LBzpXZ1
 0JHk4ZHKDJKYa+fhybCHOs19BfP3HydHoTlc5QTKMfom0X/xo7WDdwUYeZsjD9u8IzHk7gNw
 05Abk1vqni+J7Fghjp4RI8W3IsjpKOfV3f02OyO/MTSraXNyejO4JRl0A8b3q1Lq+G6Z7o5n
 LVief5JpkRyzWQSawTIBKmRZa9EzAKZXd6IJdY/sZt7pTir5EP7MHq4a+AtKfKuDkrDDABEB
 AAHNLkNyYWlnIEJsYWNrbW9yZSA8Y3JhaWcuYmxhY2ttb3JlQGVtYmVjb3NtLmNvbT7CwHgE
 EwECACIFAldIF8oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGEeRQLLl5WtydMH
 /1nYd9jmOBaF8w5gGgjF5eOO5b/cdUegmO///VYj/5R7iF/zbB6KgF0Obo5h2gG9AIfsZG+T
 ybuTx7oU1DZYEIndw+YP9c9Yi5de5UzEHwbJiV57W0n+MP0Widgw7p6XJmUQ1XbHxdcWp7nY
 EJa8ASKLuuIhO8JFUXbQ8BcUiWbsA/JxgCzeid8iixGrzPWj6iFzoK2mX4GqP+24pXSDUamM
 TXmSQd2taYEsyUdJNiEkUC51ncRcMuThjdtfn6Ok+7lHjh3Zz8q0keJz5pnIp4EXdkAgKSjq
 U42PMrd3v1HoIFINTtr5F23OdkxoQzysu4GMO4pkw5pwz95Uckr08ojOwE0EV0gXygEIAKv/
 luYHmCG/qefgzdbnegwMdG5753NJ+zGxFltFX6aaOPZ8go9Omf6zwjybUKv6Qx6AlDanwCl3
 ewVQs+h9iW8uaQBRgeDmwAGMG/doBiFqs7X0jBf23exMiJezXlKb2ZlKzMAbzJ87408AzRaV
 sZdwEpXHVi2mRPoXtMrqL5iQEyG5hdx2ySj5164DIgVOs/ypFiaiFaDPkIcAQTzJrxsbt6pf
 iI9kT93DO9nRKVV0pPWztV8P5gKM8HY2rS0wQcfrqAU6T89Aa0VFw92J+w5d2spF8MUNPsvR
 NLm9ooCF3YME9STYHXrNH1U9fJUWpIC+b49UoWSWRD9nwl2h2i8AEQEAAcLAXwQYAQIACQUC
 V0gXygIbDAAKCRBhHkUCy5eVreLbB/sHPs1xu78uNV8O4UPTX7D5zBBS3nsrbDr+8stmXRap
 xbvo6kqKzIMAXuO3bYB/NyJ/tFzuFr9Tjd/2g56D2186bp01/kgxJ9CEl/m2T3lG3DlxIoLg
 pCExzTLTb8zH/7/6mdeJ17cdnrK+2QAKYctReVPAC67cq5KmUyU3bv5e1JzhV4ezz/i/O+Jv
 el112ZEsa54ya9KZOUHbgAR6hLnRWIa+8yQTtXqYRc3LxLRfS80Wn0Err1YvqFYzJsQMC8ND
 xAeEuqQ1gfk1b0jmv7tYljNqsHqzGVbuWz6hyzyLv5GjcdSDKpbw/797gRKQSY8Gty5ynfUH
 O4kKyuZPrE8P
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a multi-part message in MIME format.
--------------Cvehq0i4AsoexwhQMkalIpgW
Content-Type: multipart/alternative;
 boundary="------------tp7oad6BKTO65Tc1eyoF4gOO"

--------------tp7oad6BKTO65Tc1eyoF4gOO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Changes since v7:
- Fixed typo `bits` -> `bytes`
- Tuned threshold for applying the optimization
- Provided results for larger sizes requested by Max Chou

This patch provides up to 60% speedup on the `memcpy` benchmark from:

   https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/strmem-benchmarks

There is some variation in the measurements so results are attached for six runs on a single thread on an Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.

The three graphs are:

   memcpy-594c0cb1ab-128-speedup.pdf: VLEN 128

   memcpy-594c0cb1ab-1024-speedup.pdf: VLEN 1024

   memcpy-594c0cb1ab-stdlib-speedup.pdf: Scalar (to further illustrate measurement variation as this version will not touch the function modified by this patch)

Previous versions:
- v1:https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2:https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3:https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4:https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5:https://lore.kernel.org/all/20241111130324.32487-1-paolo.savini@embecosm.com/
- v6:https://lore.kernel.org/all/20241204122952.53375-1-craig.blackmore@embecosm.com/
- v7:https://lore.kernel.org/all/20241211125113.583902-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson<richard.henderson@linaro.org>
Cc: Palmer Dabbelt<palmer@dabbelt.com>
Cc: Alistair Francis<alistair.francis@wdc.com>
Cc: Bin Meng<bmeng.cn@gmail.com>
Cc: Weiwei Li<liwei1518@gmail.com>
Cc: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
Cc: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin<helene.chelin@embecosm.com>
Cc: Nathan Egge<negge@google.com>
Cc: Max Chou<max.chou@sifive.com>
Cc: Paolo Savini<paolo.savini@embecosm.com>

Craig Blackmore (2):
   target/riscv: rvv: fix typo in vext continuous ldst function names
   target/riscv: rvv: speed up small unit-stride loads and stores

  target/riscv/vector_helper.c | 26 +++++++++++++++++++++-----
  1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.43.0


--------------tp7oad6BKTO65Tc1eyoF4gOO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Changes since v7:
- Fixed typo `bits` -&gt; `bytes`
- Tuned threshold for applying the optimization
- Provided results for larger sizes requested by Max Chou

This patch provides up to 60% speedup on the `memcpy` benchmark from:

  <a class="moz-txt-link-freetext" href="https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/strmem-benchmarks">https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/strmem-benchmarks</a>

There is some variation in the measurements so results are attached for six runs on a single thread on an Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.

The three graphs are:

  memcpy-594c0cb1ab-128-speedup.pdf: VLEN 128

  memcpy-594c0cb1ab-1024-speedup.pdf: VLEN 1024

  memcpy-594c0cb1ab-stdlib-speedup.pdf: Scalar (to further illustrate measurement variation as this version will not touch the function modified by this patch)

Previous versions:
- v1: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/">https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/</a>
- v2: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/">https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/</a>
- v3: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/">https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/</a>
- v4: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/">https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/</a>
- v5: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241111130324.32487-1-paolo.savini@embecosm.com/">https://lore.kernel.org/all/20241111130324.32487-1-paolo.savini@embecosm.com/</a>
- v6: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241204122952.53375-1-craig.blackmore@embecosm.com/">https://lore.kernel.org/all/20241204122952.53375-1-craig.blackmore@embecosm.com/</a>
- v7: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20241211125113.583902-1-craig.blackmore@embecosm.com/">https://lore.kernel.org/all/20241211125113.583902-1-craig.blackmore@embecosm.com/</a>

Cc: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Cc: Palmer Dabbelt <a class="moz-txt-link-rfc2396E" href="mailto:palmer@dabbelt.com">&lt;palmer@dabbelt.com&gt;</a>
Cc: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
Cc: Bin Meng <a class="moz-txt-link-rfc2396E" href="mailto:bmeng.cn@gmail.com">&lt;bmeng.cn@gmail.com&gt;</a>
Cc: Weiwei Li <a class="moz-txt-link-rfc2396E" href="mailto:liwei1518@gmail.com">&lt;liwei1518@gmail.com&gt;</a>
Cc: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>
Cc: Liu Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
Cc: Helene Chelin <a class="moz-txt-link-rfc2396E" href="mailto:helene.chelin@embecosm.com">&lt;helene.chelin@embecosm.com&gt;</a>
Cc: Nathan Egge <a class="moz-txt-link-rfc2396E" href="mailto:negge@google.com">&lt;negge@google.com&gt;</a>
Cc: Max Chou <a class="moz-txt-link-rfc2396E" href="mailto:max.chou@sifive.com">&lt;max.chou@sifive.com&gt;</a>
Cc: Paolo Savini <a class="moz-txt-link-rfc2396E" href="mailto:paolo.savini@embecosm.com">&lt;paolo.savini@embecosm.com&gt;</a>

Craig Blackmore (2):
  target/riscv: rvv: fix typo in vext continuous ldst function names
  target/riscv: rvv: speed up small unit-stride loads and stores

 target/riscv/vector_helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.43.0


</pre>
  </body>
</html>

--------------tp7oad6BKTO65Tc1eyoF4gOO--

--------------Cvehq0i4AsoexwhQMkalIpgW
Content-Type: application/gzip; name="memcpy-594c0cb1ab-graphs.tar.gz"
Content-Disposition: attachment; filename="memcpy-594c0cb1ab-graphs.tar.gz"
Content-Transfer-Encoding: base64

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
KCgoKCgoKCgoKCgoKCioX7F/Ai7KQE0A8AAA

--------------Cvehq0i4AsoexwhQMkalIpgW--

