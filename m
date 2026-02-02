Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F2CD172CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmY6-0001Cf-90; Mon, 02 Feb 2026 00:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmY1-0001BQ-Lb
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:32:30 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmXz-000235-4K
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:32:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a7b47a5460so22497385ad.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770010346; x=1770615146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qy1EW29fGsMA6PVaRFRBb4zkqrM7TZ98Zacmi6dGfs4=;
 b=tNKhxMNNZYxmrocbssYQzGm29Crn3PP67y2pNfJ9HCb+xuWu2662H6pvnL0Olv7amT
 zyDkM9wi9h+UQ3tXyIBARc+wrfVZmpTQ0mOozIMm5B0bMOR4V8+HdRAV+VBw1NWvYlAm
 XnrPcpKqZYP4dLoxO1s4DYeAoRfUc6DiC9iWBFy4oBuNBbVWmnXMyknKF6eV68tSZuSv
 LphiDWL9rj+YxZ9p+wcln6CsM28MNUzMncNH6inpiqXrouP6391LwaGuBecA6mN/O9z0
 FTf8f0eMOACT8LAWzDvzwT9mc/7YvZECDUhizYyAU1WKGS3Itrgrk8zaRbtxnKkwQITS
 zedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010346; x=1770615146;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qy1EW29fGsMA6PVaRFRBb4zkqrM7TZ98Zacmi6dGfs4=;
 b=AKR9KrdmKk8l3rfJCWnGSwqdNaxcYknu4MbT3ifgII6pBabei5584nxb1CsF+Sj90J
 jRUa/699Sk6WUVnYsaYqgc3+75q4xm3xuVPKLnuvbvofB5WhW9hpS5r7zbpurQimUgUZ
 jf3T70gRtUZkIoTjDmgSqEpZXG6v64e7hNTBPNEc1fvdBruPBdoBU5ybomHxVitOZQcB
 Dv7fdziKunLK+r0QtRjkIlf0Lf4z/MwMKep7xpGUD0Mng8+UxdZTuYBWDN9GC+GxB94y
 qGX3rR9u1Mv2vBhF6sxdc0su0ITgtxoTGyjiCE3HDOkkfX/Ejh9gDjcuQDkZkoHQ136d
 mscA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+R5yhAac6hnyZ/VIJiXj1mqdWXoGy65JS8fh/GbqhGXFQvuWEP9Ubt+0saBRAIfRNcuciVG6DrpNa@nongnu.org
X-Gm-Message-State: AOJu0YxIkatTMajyDDdN5VcfGBDdwbMk3rGszDeXkNpiQi2NfUcgqIeb
 vffpGzbQOroq4jLJfD3nX6vdG0DGlQDeikcD0UNws89bDXEglJD6lm0seuT/py3LLtU=
X-Gm-Gg: AZuq6aJ7BAf/vMIu+ElMNtIb0DhdI3FntdXLbLpYVBlb6H4UANAzoXPH8fHBpkJz/E6
 WsfKx4rPwAgKYb1PndpBEh8vzi6uxRVretHl6emEMw8pmvaGPhq1G5Y4Ip28jHkmQwukxnZEOMS
 bx9oWXco6KH+Z6GJdG+wsJIg+jF9P37lmXUlkO7ankzvNedgd7HSzE4jZ9WoTIFxPSDUo2aB1Zm
 lBG0I/Tl3s7GBrJbMV31Qk9DGBm+wbu4ArKK4xK9BOO3giIoewMPmv4olYYMLzV1rPyo9dGrFfW
 YevNRbxHj+1xHXG1wIih3AvVP/i2Dsd6h2rjtXd9s6+c4PO5dOQlLMUk+R4n0QbQ9Xhmoj3EQlr
 uUVvGF7/9mGhKoa/VxCZKE+w5T9HCTI1eycqcBidmTOMPwCO1ikfQuuVP7iUQFei+ULZrZq7/W/
 EacBKMQrwC5FNLHBMsFaaTjRNYGMWhxhcFDikwS1k0mkbWQ7A3OWEFx4X/0S7fmxPJvZzjfCd10
 vqwXilmCgRMmpVjmzj+jUmzCP7Ug+YAYccJJ/KuLw==
X-Received: by 2002:a17:902:f115:b0:2a7:516d:18d6 with SMTP id
 d9443c01a7336-2a8bd3eb79dmr92049025ad.5.1770010345626; 
 Sun, 01 Feb 2026 21:32:25 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b414f7csm135844375ad.35.2026.02.01.21.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:32:25 -0800 (PST)
Message-ID: <6ab2e035-c4b5-4c00-93d7-4af78b9d42ac@linaro.org>
Date: Mon, 2 Feb 2026 15:32:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is
 not present
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129113455.1283266-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/29/26 21:34, Peter Maydell wrote:
> FEAT_SME_FA64 allows Streaming SVE code to access the whole
> SVE instruction set; it requires FEAT_SVE to be present. If
> we have a CPU with SME but not SVE, squash the FA64 bit in
> arm_cpu_sme_finalize().
> 
> This doesn't have any effect at the moment because we don't
> let the user create an SME-without-SVE CPU, but we are about
> to lift that restriction.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu64.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

