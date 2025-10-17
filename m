Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9208ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mea-0005qI-6l; Fri, 17 Oct 2025 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9meT-0005oa-A5
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:46:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9meN-000360-6O
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:45:57 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b633b54d05dso1476105a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715937; x=1761320737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0x1qDm/tny55L9yhWpq0+6upt+w1IGSdr0TK274fmJ8=;
 b=YZVKWPnnXf9bx8fssK+xa0c6uzZfzp70liN8jVs7Axt2uNK0MM+lg/EFeXPf8JnOhR
 G/WB6poIgkpLhraU6wFdWt8O0kYIqhoPg9iXbGxz1Mvobrukn+c8s3ycLNUYWMgDIj8N
 +vUn8oJKaP1ZFHJhxBUi9pnDtgFteTtBMNdTZ4cQZir4Oo3Gjy4k53FEUBy+gCHc8DTT
 xCj+IqTWuKse+8UBrmJKJi2SZL300uA9ddWLYub/6DNt1YhDlsS0QDyE1q3hZjhNHiS/
 1fSSLgWpJoi0rEsrXcLGDubhhTJjK8eMayPHxkyxLGL9YKfFnF2htsyLD1dudF3REv5i
 UKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715937; x=1761320737;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0x1qDm/tny55L9yhWpq0+6upt+w1IGSdr0TK274fmJ8=;
 b=jcAbYoO284BZ7Q79D61EnlDX+0uO/jy1mqji/Xj/3IV3Z7x/e0+XnQUS2YFZsA+NO/
 +4am5j8TYmz014ISavblvjoU2ePVrMZjbRNbmgaz+emV0Pt0YSg4ta/M5K/I03MtUH+W
 NKleedYuWW6jkNFi9zickdeFSaLWt9ejCjCVXCZ2NJcuWHyrHFGfjBm38s7Wm8qLGvNB
 xfQ+s+Swlhfo8qAjg3TI+9TXfOaJ0IlHuG11Rh5zZ6BItg2ZNiNQ/C/0NIgVHNI8rHtf
 oMwGl3x+yq/o1cx8OJ0NpEVW/j7dNadLQSF3XDu7O1cyQ3KBit161N2p8v9qummphwY/
 bgIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwIGRGu0rP3I6ySgUg70xqVM86gmpVV85ePUzsbrwICDlR1H5o+/YjAaW6pNEV5YrmB2BiHVRGuSLX@nongnu.org
X-Gm-Message-State: AOJu0YxqHeiKJVXfyFvRuWr9L2H9gXMaM4cZq0svEohknc2CT2Kw86SH
 OrZJt3qY/ZFVS+RXbdqRrro+u+AeOlePVqa+dw7IY+UcTPQObHT3q/i7pACWYt8mUzk=
X-Gm-Gg: ASbGncuqKP1daIJRmXqSrY81wKPF2jFvO0nnKbB3rpf8BlenP73LeUw9m3B0lJO6IHy
 6Na0uwu8G6CY970uHvuNyZWrsAvCq+uZ3OJBSD4qKAlYeJgj8PzrDEWxAlI4AOzsn0M5MTO9N/N
 mcx/X8itadyDKHw4VOb75Mii1eEhVPVYLhLiTPUwoynwqTdumiQ72RHrWQyWJ4XZKKXCV2q2/Ro
 8tQwmc2MhzF3QAn8oERvWjJLO7pfjQSK8JwSIErp+Bq91c1DkdKzx+wZ1HVdahITEI1F+fcow2b
 J1YGnr5AkgStilbSrmOITXLwK5+vJJ/dmNN1wU2uLZ30UjU8SkOZ/ltCrnWTBThR3ZjMR1PHWYz
 VYYY3Kxjk1nwAMJCRDTMwVxm9aqr2JpdBTDEEnH2umPJm8UrUEAzkIEW54jEPwvUuQake8KlaiK
 aHaKRiEc77BQREX91wQYYRbv2d
X-Google-Smtp-Source: AGHT+IFs15lbeBxAT0+8G1jvH0ft8vRna/95ANzQuLh5JIFKyjldzpUIysAro6KgOc6bGypzhHCPKQ==
X-Received: by 2002:a17:902:f647:b0:266:ddd:772f with SMTP id
 d9443c01a7336-290c9c89cc9mr55775785ad.9.1760715936995; 
 Fri, 17 Oct 2025 08:45:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-290993102c9sm68123885ad.24.2025.10.17.08.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:45:36 -0700 (PDT)
Message-ID: <8e7b2ce8-e0d6-46fe-9df9-30a6cd983d71@linaro.org>
Date: Fri, 17 Oct 2025 08:45:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/arm: Implement SME2 support in gdbstub
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
 <20251017153027.969016-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017153027.969016-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 10/17/25 08:30, Peter Maydell wrote:
> For SME2, we need to expose the new ZT0 register in the gdbstub XML.
> gdb documents that the requirements are:
> 
>> The ‘org.gnu.gdb.aarch64.sme2’ feature is optional.  If present,
>> then the ‘org.gnu.gdb.aarch64.sme’ feature must also be present.
>> The ‘org.gnu.gdb.aarch64.sme2’ feature should contain the
>> following:
>>
>>     - ZT0 is a register of 512 bits (64 bytes).  It is defined as a
>>       vector of bytes.
> Implement this.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   configs/targets/aarch64-bsd-user.mak      |  2 +-
>   configs/targets/aarch64-linux-user.mak    |  2 +-
>   configs/targets/aarch64-softmmu.mak       |  2 +-
>   configs/targets/aarch64_be-linux-user.mak |  2 +-
>   target/arm/internals.h                    |  2 +
>   target/arm/gdbstub.c                      |  6 +++
>   target/arm/gdbstub64.c                    | 52 +++++++++++++++++++++++
>   gdb-xml/aarch64-sme2.xml                  | 14 ++++++
>   8 files changed, 78 insertions(+), 4 deletions(-)
>   create mode 100644 gdb-xml/aarch64-sme2.xml

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

