Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EACCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqX3-0001Xj-2U; Thu, 23 Oct 2025 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBqWw-0001XJ-Jf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 04:18:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBqWu-0006eq-C8
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 04:18:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso3739725e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761207518; x=1761812318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S1oPBOUBDEuWomT4CBHWbMW0sKyB5dY+WT9cAhuIlqE=;
 b=sOPyWTx8u8kYZonj9aoVgT5tsMAdGTFJMk+TnpKS4LBRwaUZLBYNkesELRJqC6dHYN
 nZtEN8S3c/07ajDiWIbUUUKk9p0cMLrvx4jVp7nsShw4v4vO7nTgXdcygaOvHc7Kifn3
 QIqV/08Fc4ZabYGKUTm5x98xAT7AcfMBnkC6VTLEsNsE91lmHCOekEjUlIB314adKdWo
 vbTSyEEvsqPo13j4ZiP574A49v5CIEk5wkT9aA5al2xTKxU4GMFfHvHb5jM6FBOGuFLb
 StX0twRyxMZscwRuh4fYGUllftySquxgsEbvWg9mL8ZXUZlBpV+/m7iAzhUP0tPcknSQ
 xEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761207518; x=1761812318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S1oPBOUBDEuWomT4CBHWbMW0sKyB5dY+WT9cAhuIlqE=;
 b=m3nlf9xPOvPQyabgmfzwwxYfxoKpy6KZAlI8GzZEwAlMOb1/XVtMAH8kT9+msb1xGa
 H9cvQ1jvdtvRHVbdxoU5NVBoYTf0mRIAfcecBSm9Nr4nftx1q4LvVekevAN39aijLp7p
 5j+51n3MLF1OszLUs5cNq4MSDZmuUNSIQymhTCO2Jf8uHIyYRBQgUeso6DU6kQMddUaa
 jLYVF+wcF8dxJQ+SA8XXewgTBrL2sFe2fAFlu9lz4qhWB9cBoa74s3fEaFSu/ZLWp4vw
 SoUem7yFOmIwTvgU9uTzd2pKdZP0HmonCmNFkC3Vdc+p0ssmrft/TvKK8gI1kq2JeNju
 K/0w==
X-Gm-Message-State: AOJu0YzEm2fyxAFp7DQdZE/c7RMH1Kf4aBJsgamjzHNOorfORb//AI6M
 dZM2mdEvzE13VipqTSImfCjb9zR3QL1h6h6gbNW1dXE6Fj4I3nlJLbxqr5f+fqKilWSLkZIyUrG
 lEuFme2M=
X-Gm-Gg: ASbGncsvKwfxvQHrAzCMli7bE4SAHWmCgyMTMBnJOCdeU8KQu4zc25uVcH3MgNgNDx9
 /YOwzqEiDcbQCSx8LsvdXOIJg63hzzavi/KzCM8lO48lyLRynf3rwjiCuHorBULaJO+d2irULAo
 spbcksKMKUQLsTNhX0l3gRxG/9IAUpIjmomRrnk3slj5P0nt5hev38scp5dICnx2mmMwQa6J+v5
 +Rpb/LsO0EVUF6pF6qHUdV35sTmlgM7hdZazZsIYjtoSI3GcHQoEb8YqEPxq0Op/PbHilJkerDT
 W4NisdvhZEHFG9vmWpfjTTZn4gcafCi0I2440I0fKoA65r6caKjT6ZTCHgPn9OeCziElBchnN2y
 +ui43VgKvs65Uo0C91ZbJhIbAruKRJnP808bBfUicYxADV6NwLe5ehc+jo0VciXsQ8PTPokbyf3
 gkp18XlcsoxZZgbnMi70e4/UmvYIBe1PO8v5OLFlsyCM0=
X-Google-Smtp-Source: AGHT+IEsY/5HbGG2Yn22zbAbjOd8n5R94APVaz/0tYEPMKuHBdmQIE1Eaju7F+glZVWnWxVkKVpaJA==
X-Received: by 2002:a05:600c:4f11:b0:46e:37d5:dbed with SMTP id
 5b1f17b1804b1-475c3fd5befmr50891985e9.12.1761207517871; 
 Thu, 23 Oct 2025 01:18:37 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4298bd78c69sm823809f8f.4.2025.10.23.01.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 01:18:37 -0700 (PDT)
Message-ID: <a3ce5f41-359f-47d5-9edc-7a2eb47d4e15@linaro.org>
Date: Thu, 23 Oct 2025 10:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log
Content-Language: en-US
To: zhaoguohan_salmon@163.com, kraxel@redhat.com
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/10/25 08:31, zhaoguohan_salmon@163.com wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> The FirmwareLog object returned by qmp_query_firmware_log() was
> not being freed, causing a memory leak.
> 
> Use g_autoptr to ensure the object is automatically freed when
> it goes out of scope.
> 
> Fixes: c8aa8120313f ("hw/uefi: add 'info firmware-log' hmp monitor command.")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/uefi/ovmf-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


