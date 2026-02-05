Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA0EA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnq5j-0004kZ-PP; Wed, 04 Feb 2026 22:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq5i-0004kJ-VA
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:31:38 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq5h-0004Pz-9d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:31:38 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso292032a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770262295; x=1770867095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CIsgD0ryv2V2yhmYSNW9VtY8BnBIj+KrV00+24MC3K8=;
 b=pnvrbAfI5iR2CCzh6Fxap5c7u8yaMTYENXCkLUZMnvYP4oJXSBRqD8v5h2fdRsLeHf
 MJPPcqrh6xRDwV97aP0707KgmfqkuLs0agxACzlEmW8vI9Tg6NchqNXog7d2cWa0xBvN
 JjWOKQ/JSJQRTIXZo3WAzT1O7XJJk0uWgsf5aV+7YdiUWDlXKewtM3fp+euzcQ8Rc3fJ
 OmWiOFNW+Yh3hX784ecXhUEbtdCYnyYDYuREnuDH7C7/WgPVEZnd5lc/VQCRKEpSu/34
 CrSIGwJRGoNJiIId95SfLESu/mKowvF4JlPZ1yeGN2jqK5JPByHsyH4pDJsLvMQUnglD
 cq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770262295; x=1770867095;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CIsgD0ryv2V2yhmYSNW9VtY8BnBIj+KrV00+24MC3K8=;
 b=OVpu+U6kX0Jx3y+qqiQhk+SOQtGa7Lnk1Nz+OphW4gcdv+DHFY5hfmW+zCU1T2Xse0
 jxJgBeXTPRCEgqjrM6XZc345+V33z/PnsObLYz5ocRtYgfpHCUUh1f1brSGCRITnPOuU
 G45rDk8cq6bxbSAOuQABFoj7iC9mnjYVtGXgR4lkSgD3eQjkqHpSvwC5L9GmvVceCqfB
 Sp2djkW8lxGaOmUuSihSmOrcFiSUcyPiIr9B3nNgwoDAdcRNuPWKl2Mdr39JblKLcJUs
 +UBOSOQEMBgoFquOSEBym0P2VyVX4C+J5rWXI/hThKQvl+NsOD5JBr9dosgWxPZzsJMN
 rLdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5aK9v8P/QsFUjyuwOIaJ4mlaJ6FDfCEuj1E39npoqiEubWfYE9CeE0/mJNV4pacuMpcbjA9LK7srI@nongnu.org
X-Gm-Message-State: AOJu0YxNOatnK2hX4StsyGnMqZLxkbc9TLOc0bmF1Qw1ClLAk9AyXGUF
 fHCytChZb/6hPdVW6vrngxrms0WqNoOID8VsqVOr6wCO0EoaAbLtsQ64zCVHqfLOt3c0Q7FAldr
 jd2TTfNfjUnIm
X-Gm-Gg: AZuq6aK8lCeJwzGU7WkT3L9zyQ/mHsCKZ3RTzD7rMKRIovNO6s40O4wPRxZCf26pnDf
 xiH/Jn87WEAzcIfcl/ozckeWlMT91kR9OR6MycAvaK6HsLpuwRIryCOL1zFBmkLD6ZL360020Em
 kaj6A/ymLNmnX6GPlE3QM0+ng2bQaAv1rjt7Y6tNpZAWOnC5HqLCFNXPEo1qCHjzoQFeQhPg80j
 SjPD20D8jGWG65YtgeTX19VNhfo8tT72KhPiA6Ew8lAxsm9eYtUX9j7WkKrzqHrz//5ZL/V94S6
 BzzsWw+FvF5H+G0dbX4bD+cFWIUzvFq6UugND3eqqiJ+GWADjdV8m81pz9tBR7+Eu9DKLwM7sA9
 hlnoXsz3vwRTZ3Jj044X0tdyWdX4F20YZ91tSvtV3DXkkwIiLrEoxTjc/KhqSRk3DQjRkdBfH8i
 80LDlTIjLh3fATx89RQyAc2PfnKHkk6M5CaEoX4eO6c/4ECrgiBEJVR8Ej/NMtItFJBzyYOzLD
X-Received: by 2002:a17:902:e884:b0:2a9:410:23fe with SMTP id
 d9443c01a7336-2a933ea2e9dmr61890275ad.36.1770262295450; 
 Wed, 04 Feb 2026 19:31:35 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851336sm45194365ad.15.2026.02.04.19.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 19:31:35 -0800 (PST)
Message-ID: <a2b61cab-788d-498f-9e35-152a6c77da35@linaro.org>
Date: Thu, 5 Feb 2026 13:31:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] fpu/softfloat: Refactor floatx80 format NaN
 classification to share code
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-4-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204051756.667397-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

On 2/4/26 15:17, Max Chou wrote:
> The floatx80_is_[quiet|signaling]_nan functions contain duplicated
> logic that should be shared.
> This commit introduces floatx80_nan_is_snan helper function that
> determine if a NaN is signaling and change the return type of
> floatx80_is_[signaling|quiet]_nan to bool.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Max Chou<max.chou@sifive.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

