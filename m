Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD72C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypAN-0008Tn-NU; Tue, 25 Aug 2026 07:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wypAJ-0008Sk-MP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:18:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wypAH-0001XS-5W
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:18:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so31622395e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787656679; x=1788261479; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NXEB9Wku5bRHDkNsh9wY6W5EuW8k1uhaqYa1LQ+jfcE=;
 b=Ep49Npyf6OxwM5r7TnKQkHpokGSe0pVbT+1z4WT8eE+4VWkmXhKumSabVHmZ2+BGpd
 9Lpq+jO8LPmDpL25vR+S33GDe55kYzbvHwCJSM7IYj/FKgPKNB2rPFAUJ18MFGIA61j6
 THCKgijEK2/ev/R+rCXj4p39Gusbk9UMq5zgnTON7SgSwarmxhAl70K683R93VneTqYL
 zH0R2nmpTEjiIunJuhqNqrycsHtdwRrL3pnv0vzszGTh2HdJWCjSMmkKUvb5mUdxZBY8
 N/gqaL/hwGsYVxxaMyKilOJA3lSedofDWs1hf3tzrL6k49623F9wSZNbILF1ow07z5Cg
 HUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787656679; x=1788261479;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NXEB9Wku5bRHDkNsh9wY6W5EuW8k1uhaqYa1LQ+jfcE=;
 b=tCBm2FPoqxBKtxAJF80F9y8Fs733PpIbFHxmeSt0q2DK2rPPsHDde4lfspt2XiuK/x
 lZej3oUe/gdgAT474tFI4s/MLuKxu7kM6qoRIMuEl2klZW6jWera3kflXaMcj5k9ctTn
 eYdXOn1D3qrWbMjd7NnUdoRFt08i0iuGNIa3bBw/tb2gwL7So1wuTEmBMO/CLxWozAWw
 L4MiWVnO4y1Z+u3nzr2T2VUzFvgh+3eud4sZ1liaM7s8SyUzYCkHDpLnQvUS4dGyTdet
 rCg1TuCfTly9hzJ8dvbPltyPlylM6Fdm9BX+pg52/TWgjZ9jbUzURK+9+fRHaWbBLsXR
 NMkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+Tda3zm3GlrEHGBllnrRlvZhqeyQyqNbu7hHhDUEVVzyRwG8RT+2k74a1aosAF07hUM3EeNdvsKPq@nongnu.org
X-Gm-Message-State: AFuF++lFtVtbdNK+CMWzE/miswFXrrCLYYGXjILu8MndAineDwB2S2Ms
 xarsxX8StgAoYGaLf39faAmCOQFYejNEavS/7wIC4l8V2xTYE9MPnuwMYfxxAhsTNa4=
X-Gm-Gg: AR+sD10aKa4im1QfZi9wLvkSZDEDBRKifuTmMAJrLQBullEb/49qr4qIY/ZOFp0tG+X
 BUBzDDAdAgoUewsYcnTwJGNdLG79Ir0O46G3IAQq9PQLlA8HwZT5iZg3T7wB0yjTvigW5U6ntVG
 aOO2py6zpkZZL84HwYfYyvf25trC84O9PSwHeoYfOkKv0ay5TZS3yygU0AvEIOjUDzYe7Ma/Hph
 HPYrPxiNdaZZVE1O0htHSgcd7pKlHdOvf0147cjnfls+PCv2Uy3U0ZR/01UagjnSuy6NEWgY8JS
 UX//bERGs69HDlQIgTTS6xYmuSfsULUckby+6f7AGZ3cpIelQuCDWo1u6Nj6xnJP7khm8irsDqn
 gXMUNn1HUzuOwMU8SQRn/TwF81M2l1zA1r2tO72fHMRwZsp1UzfPuqpd6TOWz0HHCSDrT4/+2PM
 bUzzDGJ51rxYt/f+qoSCV1aIZcQQJ0hfahT9QQgYwB4U75AmCmDQ2NHOXm37tH7KcozkuX1cJau
 20=
X-Received: by 2002:a05:600c:a01:b0:499:bdf1:7578 with SMTP id
 5b1f17b1804b1-499c19bfd2dmr256070885e9.3.1787656678581; 
 Tue, 25 Aug 2026 04:17:58 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:8679:ff59:1b3a:5e93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d5cbd702sm18213095e9.0.2026.08.25.04.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 04:17:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:17:56 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 19/28] hw/arm/smmuv3: Determine register bank from MMIO
 offset
Message-ID: <ao155KStbs_MFr7m@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162558.2808607-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x333.google.com
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

On Fri, Aug 14, 2026 at 12:25:57AM +0800, Tao Tang wrote:
> Modify the main MMIO handlers to select the target register bank from the
> memory-mapped offset.
> 
> Offsets in the Secure register window select SMMU_SEC_SID_S and are
> normalized by subtracting SMMU_SECURE_REG_START. Other offsets select the
> Non-secure bank. Pass the selected SEC_SID to the register access helpers,
> where the normalized bank-local offset identifies the register.
> 
> Keep bank-specific differences explicit, such as S_IDR5 being unimplemented.
> This patch implements Non-secure and Secure bank dispatch and prepares for
> later access checks; Realm and Root programming interfaces are not modeled.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


