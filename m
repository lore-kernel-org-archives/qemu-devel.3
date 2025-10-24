Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F45CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCF4V-0005xE-Ol; Fri, 24 Oct 2025 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF4Q-0005wh-7a
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:30:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF4O-0004X1-9p
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:30:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711f156326so17214655e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761301850; x=1761906650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DfDNMByKaFsLBbMqvoO7LjFAx26/HQeghQwGV0HZJAc=;
 b=yB4F/49YP+VeVhXHDwUyWRtjQhJvn8T1FXgr4nGPTR6gGzdjhkbH0pjGwHeu95FhsL
 TH5dxzs0xM3nhozhuwD7SabfzzzrJ/SW1tSe+7MUJ8oCwPzEfIZTO/DMrqXfj29PsGof
 n6GyZMyVYJ2kVfhp8RH60WB6PGUlzyCaaViSXBF+FrLnOfA+nM1kyhcXlis3NG2NdK02
 abOoMOCefsJuKPPgEdjbeElq8LOQIxJAYIBQNYESvxDdF0q+Qd/ZgyLzWcLIDUBM0VpK
 KTFYUYJ0+BupQrAseEzly3Nkgc+Q76d9jafNOqaAtLZ1ssKP/EtJVvdWdqpdiK/Di9hw
 07OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761301850; x=1761906650;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DfDNMByKaFsLBbMqvoO7LjFAx26/HQeghQwGV0HZJAc=;
 b=eJ34jEdNXQ0Rq8vTuuvIPR/NLmce6H2Slix+frulUMT3QW5ZvyhhvWPTO2nUziyyM0
 VBhA6Z1J3K9aURa/kmUdDMXGi4HM7qyy3TbGqbdmMJ4C1jeaAlJjG16HhVmRCRiobMQh
 34HsCVUKl+Pt/uno/donSnOfqHChbcn1PyF1BEX8E5FeOwf3CYH1R/SVWvV7LSuX0Dvm
 4jmoUCTw4EZqimynxdyQ0Mgx48KD9cAiirpJkRSn7Trskc+oqxK6JPZ1QRhhIiUQgpK3
 ksUsOC3Hbl9pA2u8SC8BjqAKD3g04blYpYsDMedEQAVi9xNj0QmO3LnJtyFdRwHG/Uv8
 cSFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnHeMmIgdLaHXoC1VNulLZSCgFZlLe69etTBNKgo8An2f80Z9e15XRPWkyGWlBIxkVG834if4WLkY8@nongnu.org
X-Gm-Message-State: AOJu0Ywp5O3DuBHVG4S9pupbpN3hXkoWiHfnvOSIBHBM4DsfJVGQfRn7
 3miyp9J4dJK3XQ8F/JjFrHosrmtC9ayJwlGsCN7t95D88GHJJKHJjMF402Ieq/GgEEY=
X-Gm-Gg: ASbGncvd8Xv3lyUwEl6mYP/8nxhdOoWZRcWXSZHXi00NQHg+LbBvlM3FvqUFXa5cCPr
 kumXy7EqlqTN4KJg1NEQOjXclwGMN+AQmy6JhqIFKWwJts11umPnet+74MJi0X2su6g28nS6JKy
 Wu+fEbkwIRwD8u12t4SkdJqdyeNSjkUMV/V01QPl2mO/7mXE1x0uZU/zaNZiKMS+1Jw6tk0+RkP
 Rxm348p08r0C20AUSNmCJFKIMJNoUJmgjxDhqIzk6NmZA6z7hniQAFTBSzzscmJZhiqIAr+5tPO
 e4uRQyd+ZS7EaTD8RDsZue/AqNT5favnVcQrR2SvZnxGMGq8xJN9uhRJBfa9oSlCISUACGsHlcV
 +8WSRAVqBMoh6iV/VnDBXqjp+8evqDI08Hj/Sc1P9bPdgukx1flKgBcLi2pUsg4vC9vmObnWnJE
 kW8i434tsp1Ihc4XNc4N4TvjKb0ftcQVP9HQMX1WbmMc2E7gUI/TBT9g==
X-Google-Smtp-Source: AGHT+IGrinKxVa+O913Es4KAT4/OQQlfDPN1Fh1SlE3t3UsONthISNEMM3y+hsHMsBTHPkO7IVKYqA==
X-Received: by 2002:a05:600d:416b:b0:471:1521:7e80 with SMTP id
 5b1f17b1804b1-471178768dfmr222409565e9.2.1761301850572; 
 Fri, 24 Oct 2025 03:30:50 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f57cesm8967785f8f.17.2025.10.24.03.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:30:50 -0700 (PDT)
Message-ID: <fa45bad0-8f2c-43fc-9ca9-c27e57990487@linaro.org>
Date: Fri, 24 Oct 2025 12:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 4/6] core/loader: add check for zero size in
 load_image_targphys_as
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-7-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-7-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 24/10/25 11:26, Vishal Chourasia wrote:
> Currently load_image_targphys_as() returns -1 on file open failure or
> when max size is exceeded. Add an explicit check for zero-sized files
> to catch this error early, since some callers check for size <= 0.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/core/loader.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


