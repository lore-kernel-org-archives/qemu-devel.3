Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AC8C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kwJ-0004Sg-Gb; Thu, 10 Sep 2026 16:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kjQ-0000hO-OB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:46:59 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kjL-0000DY-Sy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:46:46 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so213978a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069601; x=1789674401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C1qmsk8rFgxNFPSseWuaQRSOgOPgaPWHcfHj4DInsws=;
 b=lFl9hiLpJJ8TZiKeTo+4ee4lWlJUaR+MvMW30b3jDqmPnztyVrbNiU/pKDCbl3EkZq
 sF03rewaTLlQJR0TuNcKBYjt4Q/lOwUaDLVZARZW+jiniJghGfMWbqmUrO2DH4r/necp
 YVTfcK+ZOCPyIdbCYqic095BtVkB87Etz854YuRfKWLDPA2K9fUUTv8kVAHAikxeBhLc
 yt3FxCQNq/bdFLKW7ChO+EJvdTl/cXynkQCFUXVM/QS30FPgYP4Amf89E53n/2AerlGH
 P0DhnKXbnCyB9RRhxlGdakElUfZa02b28ao/o02OaYPD4kVJg/vI6HNQ2GJz1iu91zCJ
 YrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069601; x=1789674401;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C1qmsk8rFgxNFPSseWuaQRSOgOPgaPWHcfHj4DInsws=;
 b=O+nMXWQ4XCeAPMlvuMRmSJ0j9osOXPeUyCG2NRZdAi90o/0K64dMfvnTWdH4bEt40L
 EpL/u2S4cy3ulFTJRdqAA+rUUaXJ0iBsaW5UJLuLqASfb3RRornwhs5dhHUF7VW0FpvJ
 T25fneQE3zvxocPPvzRYwaMG67o0TjB5Y/pBu1Kg+8CTrrJXWK8TgMeMDXvxXtjGMjC/
 +tJK/C6qPQ9lApJDOnRdMt2p6O8/yOz4vC+F0CktK60z1bNMBLAAiGrKINuw1WBH+vLJ
 n7D0hyIwoonMuwg5yfv7AGQiLA8o+wwWECE4coBGZh4xrUjKPidcAi/aMW1W7hyLDicD
 9bDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvXllhq2es8d+dZBSPVPok5dU4yL1qh/QBoEf5dBMFO8jUWqSZJlTbexZgjJgqwDWI+FO+Bhnvo10N@nongnu.org
X-Gm-Message-State: AFuF++n3dqne3Mzt58i/dQJI7lzU9MwG36CkYP0fJwmDJ38Ap/0Swyc9
 wttPXqywW2n08ND+nYuPiZzXF3lY2uD97uzQqEbm9agBTu1qvKqKmCSfR0RsI6qPkS8=
X-Gm-Gg: AYBFou0xmkOIxtUcM2tVZQ9sHaas35b0eXvKVTxKK/2mwZQ8p4oSt3LGdtBpmt95cAY
 LwxxS4BRNDiI+WvBAEYHxzAEYM0jiy2+I8DiINpj4vTHvaYbk548sfF+9j3ilKnmg9zGFhmy9iy
 vj5T2SWvRA6QALzM+9wbBPxHIq7uA/fMQTBNVnQ/J69kH9TwmDngQ1FySR0wsh52aibCrErkSYO
 i637MiIymr8Si5luc8bsYoo4gcPywpJguw34HAplaNvmcSdA1pKZX4r5abFo1xMTRQJVn0HLvkA
 izKNDkP0N6PSUUR6Cx1GB9PvMRA9XZixp6hZe63cQw017bSmQ7KISIcPqvbWGC5jP7lmI9nSoHj
 9+ANt7ndMuPSjaSr0/Sq7raShsmoNv8U7Hzry3E3gvjKF7iOZ1Vx3fM45YAU/nybq4w4cWqRGdY
 ztawP5TlTSBMRbcbz8UWeb8d5fCvIIgx2tRuhmoCz5zSqAaD7zkQ4KWU/iSWhHkg46DAcJfdaIL
 SHrnzx5lNDcwC4=
X-Received: by 2002:a05:6a21:6f88:b0:3da:755f:a031 with SMTP id
 adf61e73a8af0-3daed20b238mr938429637.12.1789069600642; 
 Thu, 10 Sep 2026 12:46:40 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f1e434sm354515eec.22.2026.09.10.12.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:46:40 -0700 (PDT)
Message-ID: <088c1867-a0c8-4548-b6db-0b3bb2f0e204@linaro.org>
Date: Thu, 10 Sep 2026 09:46:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/21] target/sparc: Constify CPUSPARCState for various
 cpu_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-18-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPUSPARCState when
> the argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   target/sparc/cpu.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

