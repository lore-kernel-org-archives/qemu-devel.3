Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70840C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9WNm-00056t-Gb; Wed, 23 Sep 2026 19:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9WNl-00056S-7f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 19:28:09 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9WNj-0005Pq-IV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 19:28:09 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso860237a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790206086; x=1790810886; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/yU4xueCjupV/9XC+Njyo4ezokpJitLj6DKT4/uwjpg=;
 b=bbcgUdv2mje4VPsC17TjYbUzMCaJE+fP0cwLzV76bCQCPxIqV9XOg6u8HhohZL9YnZ
 C2S3MVSzRMcgxamipEr3BKJPmauPbiFU6OF9+fy0S1XCrpM+9SAz1uCaYmLyUODn1Wha
 AjZ8kokb8nRRSDp/IOA7XeRaL8OYCpgs/Ra9OC1wWqrfXPibYJHcpBUTxDIexIVNzLYd
 WyCaHb5Q44Nd22XhjIJH+NLxJ/XcWbhwIympyctMGY9kuLC64yB73Kw1DSQIJrEsoRAb
 AYL5dUHE7snnodIA+z2YDmb5cuZ6K5wtzKtFRnLAx6DGbwhLw/DJ+jcHYSPvmnCXnvO2
 IB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790206086; x=1790810886;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/yU4xueCjupV/9XC+Njyo4ezokpJitLj6DKT4/uwjpg=;
 b=IRshDrHQQN1QAJzyotyEZwJ7cYoFDKPSBRygrOaFERq0D2foalwc+IUu1n0fMTwZnB
 CV2xqGx0lpoNvhbPiac4Mj17eE1zc1MDfJ6mUEDkQgD6TUeQf7qD3txBSjKAx4b+sz2g
 BQhyOwON0Rf6mlsC6vKaIryx4eEtHq/yx6N36Rnuip/KlJ8tDKaBpyxd6lpbrFAvlzaT
 3agWYJFMrDOxmy0TvFpnfTw/ka3SRRgIAgL53Ldb0wZBXfXPVNwzEwO0XvFkylCX6eHl
 zmZZ9lmLFPizkg5p8ci3E65l/lpqu3MKy3OOLTda+9G70PSREIcwtjoYLeEgvWP272I7
 hKhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOCnjDxR40buctkDkyG+QbEUYpDMXyw5mpDbSF9RTfCSwwg719H8ZhaeWCWJG+/6HWRG0Bxb0fFrZx@nongnu.org
X-Gm-Message-State: AFuF++nYfUq1al0XAbLi0kb6pdJ14R3H11d7idtSmK+gbdi19h7VBpCK
 ftCOERlZKUogmmgvY5seIDTvuhQdYCSsDPDakL2+Bf3x1we8dY6zo8bhZGtIbPtCwko=
X-Gm-Gg: AYBFou1kbrdPoJlp6LoiXZpQgruykAutY7UVB9nt0zcI9rjlLZddi6WQOVJWWdoMAVJ
 veQ10pp25e/Ch3yrqjE8hpiFZxVgWL5XtAkM0OUzHvrsJPOzSJA/mSB4h2y98bb3SxWZEb3POXq
 bazKM2VvhXmEwFth+bpIoiUEbkuB2MjdbsJZe1GeoR3HkqE3txNCgNueYzsKDXMKHCx1JAIwsSh
 cb+DKz7oRk6gMyu2/3rEnLLcdNYLxOJjPL0D4/0dQMsk/wmtMazRRlDD3GWd12EDb2Vls8PXbWH
 9X5GDWZCdyl9D1g0uGbbkCo5I6OAeNKwH4t7V7nxEkZA21gZkaLqnI3Kaq0W8SO1Dd+kEqOAeEo
 qcpyBIKvTIVZAorBZO7ii0e1Wx31wh7gGlH7RCjOF3Z2+VisJNrRnkaF/nTpSXSilH8y/jnKN9n
 v6y9wrmWuZ5UnWA7IPPF2YRkWiud+JpIn5kSa3SXt6mhMtLb+4L72R9JuvlfR30CdOBXShXZTgL
 nWWfB4x1EAB926xOgrzJhh41+xHH668Dt5EG+8p5uZQfLQYZBY=
X-Received: by 2002:a17:90b:4a0a:b0:3a0:7dea:6dcc with SMTP id
 98e67ed59e1d1-3a09897055cmr546410a91.29.1790206085594; 
 Wed, 23 Sep 2026 16:28:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972b15f1sm1255130a91.2.2026.09.23.16.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 16:28:05 -0700 (PDT)
Message-ID: <99f13bc5-dc26-42f2-bbb0-b744e161a611@linaro.org>
Date: Wed, 23 Sep 2026 16:28:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/i386/tcg: decode EVEX prefix
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-13-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> EVEX is really messy and the exact position of the fields is spread all
> over the place.  For now store the three data bytes of the prefix in
> DisasContext, later the EVEX instruction classes for APX will be added
> to extract_evex_params and validate_vex.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |  8 ++-
>   target/i386/tcg/decode-new.c.inc | 89 +++++++++++++++++++++++++++++---
>   2 files changed, 87 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

