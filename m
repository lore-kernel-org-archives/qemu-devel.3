Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A11C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytSx-0002uj-QQ; Tue, 25 Aug 2026 11:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wytSw-0002uX-Nq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:53:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wytSv-0001Ya-9H
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:53:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso46184205ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787673211; x=1788278011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ijOUq3E1AqgH0rZW+CrBeTX5q3V53nWudqXLZTiTPEQ=;
 b=Q5un02r9IOtl86EKLQA5kFID1fTbF3NoTtgpqck4ydpsvNEUjEocrL080S7/k8Bfyu
 A5stswt8TWEZ2HEr6tYcCevKOauQ0dEqbztazcE2gaqrx9mS1Ez3DvlDeDmnjt70e/jU
 Z2a6+Tum0YzcHHpeRrA6kWQ8h6/Fzl8+FAze7bj4kahTXbTIvYQf0iUeu7gCdhao/Cl0
 UhKIk71gR/qVrVq+5m+2KYRE/NMvqyAUVjVQkVZhfviYViNOkQ69s56ggsGUkJx/hdFX
 U2kEfxuFIXEQ+XHq8fjdW7yHm48XLuvrl/ozmensKTk1BRPWTHFn0FOX25QQArc2yqVq
 Ag0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673211; x=1788278011;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijOUq3E1AqgH0rZW+CrBeTX5q3V53nWudqXLZTiTPEQ=;
 b=Dm4Mb27NOcxaH3090jtnclKHfg7MBHeuxnQmA3zNTDHOdh2M1iYzs+HirB+w8UHYp/
 x3c0CBF3ElpuyTeIQD6IBFSOnB8UgsvTQBFT+e9pGIgvx8tuhbua6udRKopeCBU4vHhs
 Qsc7Wka3jgAsHMhulMYGafzQc6FG6J7c5LjNMghqp3p75IB4YllXZO28pyAhKA+dNjgx
 5CM/9buvmzGSq/oz5rKmHJzz8TchA8RrvWNQCQ9Tgi7oq9FLDoao3KpFEPNXaL6zSq5w
 1e3hEBfrTlpP/0Qs8UQAazWT6vLt6EOErYE9Pq9u0MT0gOHZBXt+q4OZDQ0yH1TWd/Q+
 Tc8w==
X-Gm-Message-State: AFuF++kELiHdvqoQbfhLP/7JyyYmyB39zCRKzGPfth38nS8TNR/nD2k0
 0t6Ws5GAFVfGQx6v/g95/j3B5kmTnLCATQVDs8ipWERXdlVpEKvaKmTUHr7QyAoOxf0=
X-Gm-Gg: AR+sD120P/zifCMhv9SQshnlSdnjkLJHqhaw06zW1ABjXUMy6GZyEiNJ151hRFW1Qsz
 gDWvLOsdHsPyMphNX9k7zuU96xz0+HV0/1RtLEZEdaxStfk8ky4KMlLuCRmEZtvMBV0G7SjTWxA
 A/GboiiMLac1RxUb6pqRzxRMVUWzazkBE1xXxsUhdecy4gu1/9Df131aM0T5tiGQz7RFCyunx4L
 MpwtZ/LzHOkwkMdt+xruy7X5fMbcicRpL4c5U+zlumu4YY7DWtPuy8gAuLFkFAygXSl9oyLekDL
 +/ZfYablEcWDCn3b8OojR7nZ39B1DxgMJcVRr4PtfZ9GNrb2k4E0j0mCoHdbaioI358yYT8T5KU
 wR8pgTNoEgG0aoRPtbSIOdIXlS0vN+PpYFzxhj+N/dlC2vt4BZ5IywfJwe48ZEKK6/e10pGMsL9
 Yd1S0+9O3o9NjEgE6vbhpCLy+57ZzB0QfZX16q38fNOx3pPpQFJiJcJ0FRBzQRpT+13+FaoHiyS
 5gxZhIQrTQnHEJE5zzpRzCZsCUi
X-Received: by 2002:a17:902:ec87:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2d64b11893amr556708205ad.13.1787673211041; 
 Tue, 25 Aug 2026 08:53:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d704c11616sm216945ad.67.2026.08.25.08.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 08:53:30 -0700 (PDT)
Message-ID: <684092af-4fc9-466b-a185-2ff4ddece732@linaro.org>
Date: Tue, 25 Aug 2026 08:53:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Replace straggling CS_ARCH_SYSZ
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824143033.306201-1-farman@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260824143033.306201-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/24/26 07:30, Eric Farman wrote:
> When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
> with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
> installed, this causes a compile error:
> 
>    ../disas/disas-host.c: In function ‘initialize_debug_host’:
>    ../disas/disas-host.c:78:24: error: ‘CS_ARCH_SYSZ’ undeclared (first use in this function); did you mean ‘CS_ARCH_SH’?
>       78 |     s->info.cap_arch = CS_ARCH_SYSZ;
>          |                        ^~~~~~~~~~~~
>          |                        CS_ARCH_SH
>    ../disas/disas-host.c:78:24: note: each undeclared identifier is reported only once for each function it appears in
> 
> Rather than making capstone required, replace the constant
> with the same one used elsewhere after that change.
> 
> Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
> Signed-off-by: Eric Farman<farman@linux.ibm.com>
> ---
>   disas/disas-host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Whoops, sorry about that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

