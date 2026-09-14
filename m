Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E750C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CGt-0000Tr-Hd; Mon, 14 Sep 2026 15:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGl-0000Nv-UA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:23:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGk-0002Ip-Ct
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:23:11 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so1358937a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413789; x=1790018589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FqzJgj5j0AKSdxwMHcgpuu8Vtht+GEYmg7TRFHJbHSs=;
 b=iVaZO2NYx/prPpbAZDbntN34ueF0wq3HFjuvXLsYiC9i/G5fHJgfH/qcqU2Sd3ZlqW
 ZkIDaLudxLTBYibp639pVNgF0GIqFti2FZsj0m6p1+m+5ftcNwRUbrtGsVmopX1b3gmo
 C/iSqvuKgN5oRWd3ujfKMMICuwCSw94g3RTgIob2vytxQvl01nnAQK8NLBy/sL2lvOb5
 kOBpKq8FAorDcs4HiQHM2uV3yui4GvUmOWLx0ucqzl2amzSW5MgZbfYaI0lqgN906Dg7
 vMMP0kNbAfeMSZXFC/CZDhqmqcR+/9xYPw2Br5M1bJf2hx0NFueX7/Xpm1archTgWqWc
 2mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789413789; x=1790018589;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FqzJgj5j0AKSdxwMHcgpuu8Vtht+GEYmg7TRFHJbHSs=;
 b=Np0t0cROp5EBEGGEecEFDXhfMrA/ndyYykFSrjYu9QL8k4LyHT4qMk2RTUoWn8D5Vl
 moe8Cw8nRb0C7abAX7n9UsA0UpBKg+RYy4STmRECSCZJ5zKD3xAC0kVn6RJuRZCuduHF
 +ohUeHcTBL5f4M4NT7yPgcJps+QMXCY3TVBB16YagFYFALE1+6QY3Ql3vL5v1QjrHLan
 0cCuOpctxJC0xLiKWgc2CL6NdWeOLLkkplhTfvmkvBm2xihmbh4LjMXxhD1qXZohDw7Z
 7FS8YcHKSVXNDvcPEH/OAB/OgqVTv4KOQDtxuzQ1bHVAnWIqnxMHODTTBKkCOXM8SKuC
 bgHg==
X-Gm-Message-State: AFuF++lm+U20khSXybyMErGSrOAoFNrWBPacojhnSz8LTenOILr7CKPs
 eMboc5yt4NOrcccYmTniDvnnHoVUQizsvUJbZI55EVyNi5EjvVtT6LSy3dJ1uSqeKAQQj8Py74j
 3AhyU
X-Gm-Gg: AYBFou0C1VoTQn8tFBHi2wrxMxyRBYwyD9oIUht1ccBynQPNFhTkbIoVpcE5vuWQwsr
 jJDwaOKETxHb8VRX1NzRYVg08Y2XsFoSHIRXEgre/gfgHrtQrXBfwcE74chezBI7A4WonlTzT7c
 Qgj9nxlxNcb+ERKonuE+yrBcJ/wjKxQvWmQSRLKq7e65FpKvN/i5gxX5DZXTYAuA9f8MNADO1Ab
 NBdOiUE7bu+O+fIxHX7ErFFsvzOWYgcobmG62WyOwYGYQw+MuzqQNiNjiHyHu6g+MeChjK3ZBLi
 jFtidV3bb6LgguiIBmW0iUUN57j/o0s0I2eRU1HHCvWE7iHop/96LCFr+Ijbh7iU5Ayq82hvlqC
 UMlkYznmsg6SkPGS3jl3tYWWZTkdzr03ydeCV+rGvRyKD6y8CmALRhEdYP9EOOTRUPtqCT9b4z1
 yxOycX0xEJkaBhTyX+hJBLfgbSJBCLia074YCcQ/o2xdmcoQFX9v6cc4Oz1jAjii4oo6XEJ/OI0
 SHtHb2sCyVv69pzmQMwQtwmySs1x3l+2XecWrT2fUBeiilv1PPNJ6e4+9+7Jw==
X-Received: by 2002:a17:90b:3812:b0:39d:fe64:5732 with SMTP id
 98e67ed59e1d1-39dfe646221mr1189240a91.2.1789413788657; 
 Mon, 14 Sep 2026 12:23:08 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bd8ad03ccsm9352294eec.2.2026.09.14.12.23.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:23:08 -0700 (PDT)
Message-ID: <8012f136-1ade-40fa-878b-0258bf214f7f@linaro.org>
Date: Mon, 14 Sep 2026 09:23:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] system: report device security status in help
 output
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-10-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> When '-device help', 'device_add help' and 'info qdm' are used, report
> the security status of each device.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/qdev-monitor.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

