Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7878C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x954o-0002gy-Ew; Tue, 22 Sep 2026 14:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x954F-0002Vb-B7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:18:15 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x954B-0003wh-CV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:18:10 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f0b25dso952615ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790101082; x=1790705882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mv3cHPFYGWMTe3QgAlNG3N5P4lUzLqmm56Bew9LSX0=;
 b=E5x4XRy25CdJXcaha7zd7pmJe8cSDAG7Ix3+q6PGB5ms4sfyGxCTAXexlyvQta8U+0
 D7oE/saBcFcHNaifsZPDq7rWmi7u9SK7RLX9Td2DSN8xMEsBhjkcUP98vwnOVM5kYijk
 6ITWUAw8XfN2R90F85RYnfJeKlxKjkhCjR6Ca5N9qzvd6HBuHKNhtTU5FFCnywwPcUhC
 m7N9wRkdtykxJXFH8Kh0qbo5Aavff2znj+nXkZr4NJSzIBUP/4n9bNCOC/aEUknj1XM5
 aIpEyQNs80TDL0R4ED3lJN2R479Q47vVKpNkMLdGOX6F3fgfE1MK3mP6xSEA54Lli79J
 88OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790101082; x=1790705882;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mv3cHPFYGWMTe3QgAlNG3N5P4lUzLqmm56Bew9LSX0=;
 b=y5Xhv+JLQRf9rISV9cVmNKC0Tv/PEAN+9kx7VtTLY8IMF+EwqZu31YJ0MkJgA1wKfQ
 ZrqHH3rsSRfTUPdQ9igNFXa84OAaPzsxU8JFC56oOyNhe+2+DPStAMtV//sxL3EXXgAK
 NlIA5F879SGQUhXRAd0XQIw9/m1prw/5EqkdvH+HT6M7Ge029E4OE8IBmVKbCzFahPlp
 SlA8NIRDai7SQMndX28w69llFKLgF+fCEl8hKEV25SJoYDzw7ZsKwVPMrpFh+KEdskOk
 mft5KwAqQTXWdFnvx/5VtvdGAOAW7hZXvvWFpmdBTieMnwQ/ilkAmbjHbbvubMcOiuB7
 inmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwG8FmtFAEqbfJrYwAlwH6p+ZGMJCpNkf+PlMYDaOAKCdmN467hfpETNJ2m8afWLInkireTgNtrZREY@nongnu.org
X-Gm-Message-State: AFuF++nMA2CJTCz/5z2pTAqq8gbIBW0UvXS5D5BBOqNvS3uwFN6V2Q1U
 ecfeZibuV9LCCrhaPOT5oVAy3biMN9QSv0ChJBRaZK86PozJLdZYvh2McRWaBjqE4vI=
X-Gm-Gg: AYBFou18IwEwg8R2/zX9v2hhydZpvZPAhEppi3pRKG0roQKBQcSYD84+HkZ14WaZmTf
 rzk6PidBGrrXGH5UpOJuHrE2O6utkz+elmkE16IEWGEhEcg1yc2vrwbu1OHGprUQlDVQcbK59Ke
 0jyPODWQffvwaLj5n9fi4k41Jw23Vm2J97M2kQjCcIK5W38hY+bLb5y7JEBpMSskfw5stDXo/vC
 orG1rFazYq43KknGZC0zQWkZnpPcXjwtRMFLuKNNbXCCfwmwasgJ+mwtD5BD8GIqgz3tRK99otj
 WsXOqhqjkFfmybEwMShLl2ak6QmrP0KgSKrquK/0sQwB0opddaZUL5G+KuchgDfxicABeo0LPJo
 0NhaAKe8eoPXBGf6Lj88LVRiPK2EWkXlmuzhJlBL83hmZlzD996r9ZHS70/+XvoFXf98GdFiMih
 Ts6pn+MmK/g/ztVFA8L5GgKL+VIgQ8KlUAsVvY+npB28Q3Zf+/AsVJMd2zdorELwF8ROxlYbKfv
 uUrzQ9qHqoAHYjZ/W8trgClyWT8TPdQuJzSvH1G2vdlaGZlvuA=
X-Received: by 2002:a17:902:db06:b0:2dd:c054:197d with SMTP id
 d9443c01a7336-2df69db61bamr1840665ad.34.1790101082320; 
 Tue, 22 Sep 2026 11:18:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a0a6661sm497205ad.37.2026.09.22.11.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:18:01 -0700 (PDT)
Message-ID: <17bba942-cefc-4e17-92ba-92e64de4311d@linaro.org>
Date: Tue, 22 Sep 2026 11:18:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] system: Document has_work() synchronization
 requirements
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
 <20260922164936.15189-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260922164936.15189-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/22/26 09:49, Philippe Mathieu-Daudé wrote:
> Document that has_work() may be called with or without the BQL.
> 
> Require implementations to remain idempotent and avoid consuming
> work, and to synchronize state shared with other threads without
> acquiring the BQL unconditionally.
> 
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

