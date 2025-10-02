Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A8CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4O5g-0002eU-Uj; Thu, 02 Oct 2025 14:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O5c-0002de-Be
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:31:40 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O5N-0006yD-NK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:31:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so1197182b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759429877; x=1760034677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QenMkYWauVGV01nDlAUFXnRKj/Tff3MbRaW8+7hjj2s=;
 b=AThUeis94838A2SboMhlpQZrTWlwpwh12WBmR2mJcs/8eALip5vxbRlEspsqZ/4A0V
 Whab9fkZwEz5Iu5DCI5R2Lal7yxyY51j3BQD3mXjh35tteTdojum7mUsa52sMSQh/tXF
 /xZeDe+DUduE+aOPFlMjgTvxPS1Xi/RzkCmzxM91ieuXuA+n0IpF2448BEZp7nX5chex
 0Sae5jrrwaqvTdX4eHCk8WQUz4lDknahZDjMIU2TQmslLXJKgOohUFFH0g9echHLsu5G
 RYyEQSu4MRdzdoImReUvrK65wvZVGDV+dOSsd6R+vjiEYtYXxhD3ktQgPDSZ4F3LqugO
 QS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759429877; x=1760034677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QenMkYWauVGV01nDlAUFXnRKj/Tff3MbRaW8+7hjj2s=;
 b=S7GfpuDbDyidAHGyyktzCWGDJnHanq0CMVXwfWL09cutdqnXyhBLsuKTTP2bOemiBQ
 f4rLGBv2Nki1phPt7Nz5LOAIdcn/chALm+6scC6HjP7I1hjV1siYUu/sGAXB9AT69PAz
 +Tiw7uPK7o+3r9ceK3sg7SYkWnS2TiBWgAbCDPz8PGj5twlYBLjQ/dFolSpWX3Eagoz5
 w/Hpt1DUU9OzfRH7UAvrfTKyiB5rYXlntZZm6zhb9cby45dgTeBAGzguW0lASea05/KM
 jQezU3svpLt03aygQmytktHWSD0IGm8k0stOP7gihaqBTb4sXYIJmi8lKf1cEQUZs4Gu
 +MOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEEYi+d4I4+/FOnqzZuMohSb98VnOZNl4xUkbWpwRq1iEnpVKdfcp+H2FTHmAppIkftdLR5XJ1fQrY@nongnu.org
X-Gm-Message-State: AOJu0YytSOes5IIzPNR1uPTqe5lwLEO6OgimCf3M8wtmNYwjOnwy0jA3
 /nIopmHE+vABDbMJjAVvWSmpDP1o/FbAgJOPoW7D+IazVWxl1yxhb3tkVNW9ZpInuLc=
X-Gm-Gg: ASbGncsJBAPB9AXTauCcXTDZ3T8hf7JOfUx93ta51LcK73h9ZkfO9yYv6/sIIqzOs15
 HSLJt1JPL6zVIhvbCqAPlGuCGlPTibBhfXLZV0vo+yEFpokxyxjioQgtE6kyspT2Q23GNCwKzdA
 I3IXZ44lway28YMxWCpFZgtEE9IJfIRXZCJPq/r3hE6k8nj+pCntb6VDMG9CqEvuApP7UjcLnHO
 /BCU51cGBrHCid13mvD5HafHcMmqAj8/Lj8gZT9QR3U7Obsg33ZGWd/hcUN7jq0qifejr7FRky7
 3zAHvK8ZJIqf88gFEtYXuU3yR2p6EiNMrKfP9O+tOiPw7D6vuW9H3JeJntlpx7U464VzRdODtqc
 mdzGUEo/wBV9x4G+25DxhEi/D2n21AuNkK0O1T095cci/lGmzgNZlGtv4OinVyIw=
X-Google-Smtp-Source: AGHT+IHVgyyNLFgtQiQXPweACym0RrRRrnHyBmp1tR+1pwC9SIECjKDOwHphpSL9tjf4ippwEN5jDA==
X-Received: by 2002:a05:6a20:3d93:b0:2c8:416:647d with SMTP id
 adf61e73a8af0-32b61e6bb44mr494555637.23.1759429876932; 
 Thu, 02 Oct 2025 11:31:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099af2deesm2546910a12.12.2025.10.02.11.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 11:31:16 -0700 (PDT)
Message-ID: <8b314249-6972-4f83-86d9-a459b8968a48@linaro.org>
Date: Thu, 2 Oct 2025 11:31:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] target/riscv: Use 32 bits for misa extensions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-2-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> uint32_t is already in use in most places storing misa extensions such
> as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
> RISCVImpliedExtsRule::implied_misa_exts.  Additionally. the field is
> already migrated as uint32_t.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


