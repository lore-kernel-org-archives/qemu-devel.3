Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5DCC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 08:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ratK4-000874-1R; Fri, 16 Feb 2024 03:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ratK2-00086v-Uw
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:11:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ratK0-0001n8-T1
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:11:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso16820665ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 00:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708071107; x=1708675907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0nvs+DlMktNMhiA9OqUf4bQ5k7B48R9mI5195GPHO4=;
 b=N4gRJ1vhbb4rCEyUVYzv+KjLy9SzymrxIhL4yHnEiSs1TIxs45gn4a4dkW7LKgtidW
 YKZelS/FKcoFd0Sl6zghOCCaklRMiT18UmDvfwguyO2Moq9Ncv7lhp6viWWBCYO9HRmB
 fnFjqxPST+XG8di+cnln9FKB2qq1eXP/Xy95QkeurIYO7Loj6W34nYYk9y11LhSuRWoo
 fB1mKFXoNA/RjLl++V8u07iMWdOmgLDWAxeV03EVM+7VPsK+DWcwrgYHpucbyLkYRzqy
 K20QPtq/GsLUyV7PG2SCFwnOwGuEck5iIC870jdO6vZOHLDfkrvNzSnCAyYkCJPDxIz6
 VArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708071107; x=1708675907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0nvs+DlMktNMhiA9OqUf4bQ5k7B48R9mI5195GPHO4=;
 b=SaEMPGqDOkgRFCxL1PyrfcaFa8JbzI2lyKgXuZWR9ZRUUuOs1tKk23JE9dmIu9eOfU
 oDWTgfk5YcLTBpJEaD+Ev8q2cMHI9VMCOJWvYIvSN+/1FJtjGjw6q33Q1rfaxYapoNR/
 KouWr28iXCLN7ZJ0KSwkEsrDu0n1gXMSGiWLFvzHHGNcaDNSjri6NkWjcc9ooudJc0/q
 mb44sLhRHivmsKiMJbcATkxauy6wJQCQACxD7O5p9rJqG2/+5hPZX/2jP3Laf101RG3J
 IrtRVTvgysbbXbrZs1D17/DCsqjnMp4bprKq83dgd0d8XjgUMZRr4BtOzugFIaQJiC+4
 foIA==
X-Gm-Message-State: AOJu0YwFzBBiDqroUfcb2fdDnjLYjVxrNVrM1LJvWWG3kztkCsl8REhn
 aFW4goN5wlchXMNTdVUp5BAoWaWU51fUqiRM38oQBPhaSyAr45WaERjDWSOMuDA=
X-Google-Smtp-Source: AGHT+IGy3bG48CrY1b12v0eZaPXVzmOGRhVEImI4csgEpZkJ1MSZ6VgCdnz+HpyPaAV3YFuino83yA==
X-Received: by 2002:a17:902:e748:b0:1db:ab30:38f5 with SMTP id
 p8-20020a170902e74800b001dbab3038f5mr893915plf.44.1708071106657; 
 Fri, 16 Feb 2024 00:11:46 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 i19-20020a17090320d300b001db3be9eeadsm2461501plb.16.2024.02.16.00.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 00:11:46 -0800 (PST)
Message-ID: <08ce9292-75a0-4092-a12e-9a12826847b0@linaro.org>
Date: Thu, 15 Feb 2024 22:11:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
 <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
 <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
 <aa9996fb-a5f8-25aa-96dd-48e4797967e1@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aa9996fb-a5f8-25aa-96dd-48e4797967e1@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/15/24 13:37, Alexander Monakov wrote:
> Ah, I guess you might be running at low perf_event_paranoid setting that
> allows unprivileged sampling of kernel events? In our submissions the
> percentage was for perf_event_paranoid=2, i.e. relative to Qemu only,
> excluding kernel time under syscalls.

Ok.  Eliminating kernel samples makes things easier to see.
But I still do not see a 40% reduction in runtime.

Just so we're on the same page:

> Retrieve IE11.Win7.VirtualBox.zip from
> https://archive.org/details/ie11.win7.virtualbox
> and use
> 
>   unzip -p IE11.Win7.VirtualBox.zip | tar xv
> 
> to extract 'IE11 - Win7-disk001.vmdk'.
> 
> (Mikhail used a different image when preparing the patch)
> 
> On this image, I get 70% in buffer_zero_sse2 on a Sandy Bridge running
> 
>   qemu-img convert 'IE11 - Win7-disk001.vmdk' -O qcow2 /tmp/t.qcow2

With this, I see virtually all of the runtime in libz.so.
Therefore I converted this to raw first, to focus on the issue.

For avoidance of doubt:

$ ls -lsh test.raw && sha256sum test.raw
  12G -rw-r--r--  1 rth  rth   40G Feb 15 21:14 test.raw
3b056d839952538fed42fa898c6063646f4fda1bf7ea0180fbb5f29d21fe8e80  test.raw

Host: 11th Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz
Compiler: gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)

master:
   57.48%  qemu-img-m  [.] buffer_zero_avx2
    3.60%  qemu-img-m  [.] is_allocated_sectors.part.0
    2.61%  qemu-img-m  [.] buffer_is_zero
   63.69%  -- total

v3:
   48.86%  qemu-img-v3  [.] is_allocated_sectors.part.0
    3.79%  qemu-img-v3  [.] buffer_zero_avx2
   52.65%  -- total
     -17%  -- reduction from master

v4:
   54.60%  qemu-img-v4  [.] buffer_is_zero_ge256
    3.30%  qemu-img-v4  [.] buffer_zero_avx2
    3.17%  qemu-img-v4  [.] is_allocated_sectors.part.0
   61.07%  -- total
      -4%  -- reduction from master

v4+:
   46.65%  qemu-img  [.] is_allocated_sectors.part.0
    3.49%  qemu-img  [.] buffer_zero_avx2
    0.05%  qemu-img  [.] buffer_is_zero_ge256
   50.19%  -- total
     -21%  -- reduction from master

The v4+ puts the 3 byte test back inline, like in your v3.

Importantly, it must be as 3 short-circuting tests, where my v4 "simplified" this to (s | 
m | e) != 0, on the assumption that the reduced number of branches would help.

Diving into perf, it becomes clear why:

  57.36 │       cmpb   $0x0,(%rbx)
   4.02 │     ↓ jne    89
  21.84 │       cmpb   $0x0,0x1ff(%rbx)
   0.64 │     ↓ jne    89
   8.45 │       cmpb   $0x0,0x100(%rbx)
   0.26 │     ↓ jne    89
   0.06 │       mov    $0x200,%esi
        │       mov    %rbx,%rdi
   0.07 │     → call   buffer_is_zero_ge256

The three bytes are on 3 different cachelines.  Judging by the relative percentages, it 
would seem that the first byte alone eliminates slightly more than half of all blocks; the 
last byte eliminates more than half again; the middle byte eliminates a fair fraction of 
the rest.  With the short-circuit, the extra cachelines are not touched.

This is so important that it should be spelled out in a comment.

With that settled, I guess we need to talk about how much the out-of-line implementation 
matters at all.  I'm thinking about writing a test/bench/bufferiszero, with all-zero 
buffers of various sizes and alignments.  With that it would be easier to talk about 
whether any given implementation is is an improvement for that final 4% not eliminated by 
the three bytes.

> (which does tell us that qemu-img is doing I/O inefficiently, it shouldn't
> need two seconds to read a fully cached 5 Gigabyte file)

Indeed!


r~

