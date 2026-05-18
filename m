Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89708CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzqx-0005xU-1B; Mon, 18 May 2026 11:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzqu-0005wY-C9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:25:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzqn-0000sj-3T
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:25:55 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c80170db7d6so1001078a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779117947; x=1779722747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/spbYvi9fi6N7/D6iOObzUFEd0ICVLb/3HoNZN7d1A8=;
 b=JajAzADBf2YXPv4qLvzm/QK2DhKeJnLFKD0u2eA5ULxFiCc2ueJx+dfLwDjjbRLWo7
 c4jYpEdad8phGIO/0x8uccHuday1y92Io09TTowxdQTVMtblkUpBy0l1qVzGd28zbyiz
 gGnlzqw1D7C/xTfOtt5zaCF35PDCWxef8qVHIV4JT3HfIqQVAgzpErFO/tEHjVSpb5Ht
 dQqnGXOqMpBCfhP/AAEeQFdjz0xmmRvo9KKA52zDJxEvKWysU+H4YqB1H3W96ck6TDup
 pR3DjzIQQvLDmCWpd6E4jPy+MpL/AdG/OqSLG5qUw4GKxZkcOoeynsxDPzEezLjxp71R
 IUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117947; x=1779722747;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/spbYvi9fi6N7/D6iOObzUFEd0ICVLb/3HoNZN7d1A8=;
 b=k7pA1ngHOD8NxZ8Fw4vUeo7IRQnF1dKe9ct+6iBIAqfiC1B0H30ZmJWcMqoFv/91FO
 zkeRbsajaEnlo4gFYWFtn/5JFLwEGOViEhaZNZ3ydmxc0W3UPKmO7+pn56tUfEcol11y
 KxMQjpVfSiJIq0Qdf1mTS6M+HB7tX1IkWHVtFRexQLdTViMTeRlqD96/VBypcGOCZW2k
 ljtWokFg/cSCJHXzWvnglK63OORoxn2IBn1v3w6ueT4F3PA/aneeEHOPymrtsC/geT2O
 hGVuG9vxj0zy6/pw1Q4WHA3ZLxNO8bBLdVORDShEwFhoyeKdEWl6ueA/ix92Y4uj1DqE
 l0dA==
X-Gm-Message-State: AOJu0YyogA4yERTPnHfTuyR+4Ra2dGu0+pRty9H3E88CCPIaHAHci5q7
 gfSvCTvR8BM0N6sdHDJBw0aDzKNt20qHUpLlFlMTsulul6HlnEDKpuo7lVVJq+4i1zaM85QkMY+
 g1FjXE1Q=
X-Gm-Gg: Acq92OGmqhP+iBvzJ0iMG8yrte+vVuAgJTMXcDaAsu+bJszUOYpEGkxxFKv53wbg2JE
 65con6f1JLwyhhGWKguuPaeWgg2ytFpi768VUXhiI2ag0fTNGSfKfu9Hv40GA63NbFoZF0blVXg
 7SG788tGAvXznELzEwWCrqwrA8AYD/bnq2v2ft/ooU/5L1I21K93g2NBuTqil26c99B0Q5BCpJ0
 SM/j9eFJ7y/K4Hn8f3e4MdNR4hYhyrMoNBdGkFRFZvcQoYYSs61McSq5Y6Agf2siaJCylbQzMz/
 a1MKiL8iahkV/UDQfPciJbyVAoYnv8XyLzUDrkpSOk/cfE99GOCTDcjNK1FtQo02FbDAwDxLQdb
 UMJBD8p56OsqOer1VSNs9JN1GgzFwcVIAqdlUN6xiPjB3tdYApWQwVY4Pvj3fGJAYNVGTG/nuI/
 1zeS7jsz2nmO1gdCiVRDLpgEG8hJ9dhEmCwT0F
X-Received: by 2002:a17:902:9887:b0:2bc:cb56:123a with SMTP id
 d9443c01a7336-2bd7e8e730cmr113972575ad.15.1779117947416; 
 Mon, 18 May 2026 08:25:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm150102495ad.25.2026.05.18.08.25.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:25:46 -0700 (PDT)
Message-ID: <11fe6b65-26a5-44b4-adb1-a57cae2cc0cf@linaro.org>
Date: Mon, 18 May 2026 08:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/14] target/arm/ptw: Flip sense of
 get_phys_addr_psmav5 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

