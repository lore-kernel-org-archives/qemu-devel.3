Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D8C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpq9C-0000dJ-9d; Fri, 31 Jul 2026 12:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq8z-0000YA-LQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:31:36 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq8s-0003Ym-Ep
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:31:31 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6681e7911b0so1480879d50.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515484; cv=none;
 d=google.com; s=arc-20260327;
 b=EbvYNBlLzk2QhU45MrVIBimMJC7OPJldJ3p3DcU0O1eeiL35AEs1O42rHrUqmkNc/2
 2YDxApvGeiTbZaC2eTto4lnku6BjCnWPlJ0Kggo2oUh5CAVzlbpF/8u+4LrHIok8tVNu
 4d4P79s37KQsxtHedNoQhBGKDlocfcsNNbmMAXOv37tqONFE544vk6wI1kbpBj5z9bvg
 mtruQ0NxtLTk5tsd9doJI26jXpb7cy1lcd08f2bpcmDsc/Ya3DBm2faSg7fMPbJms+c3
 SETTw1ILCPR3OHQyM7/Uqeb1J3Cj1149unYC20kcsbQpk1H2ig8RwEMLmigAeKcg4hbF
 kIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WJaBpZj7vITykyjMbJ3XucRmr/SMCWinouZDtxWz//c=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=BwgXjnbsYICHgrbZ28+55jYQ7uw5R9xMT8HcmXtRW2b9ywVv1SWuuaeiVYHt8V9Meq
 8vjPKCCyL5Sk//xedRjEXx7ryZwz+F9k++zpvFOJWmDbJ1aMTzIG0DW0AQmHSFA3c6VS
 YYxsFvDcpVtnQ+x5faAalH1eyIznP2h/fwisNETAtSphV0UR+2wStFVWQdEAiYde7ufw
 THioPc0dIedXc+HHb9J3WazJDNSq53fvUfl6As0SOZx0uIWUxUNTC66i+5u1gFOHI2yd
 an7c2Sxq2tW1l+gjZyin6+Xcy3PEQcS+8zoprf4hEmYXJz1t8snlsIkc3e4jP2CZMOxj
 3T4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515484; x=1786120284; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WJaBpZj7vITykyjMbJ3XucRmr/SMCWinouZDtxWz//c=;
 b=cwI1tmlSn7Yw6um7V+q4dIVPejAY0Hvr+WY7kKYBipYu8ZhbTfod5kp28M6nnWWGps
 MRPXgeLF/aZIsCRsF8AYw06ot1Yygex8peWp9Q+jnzr/Im9HKJ+rf10roxFTUZ/GK4W4
 grpcXs1aw0UNBhFS+E/nAun+STQwoRSlpA9ZzTAPS0DzA9ByMRscps9BySL5PWDc8am6
 /CbuZgAjS4+MDJMyA8rc2sTxsZPxN58JOpMgPi/JDSSsY9h3brNkVhP1mgClP8ihJz66
 t0cBWsESrualoUK3ooS8mhvU6sRkF453ugT9F8S+L3Ic2BSrbZe0rB0WdyFjGiZ8mFDo
 PWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515484; x=1786120284;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WJaBpZj7vITykyjMbJ3XucRmr/SMCWinouZDtxWz//c=;
 b=UpHv5ydbQ/rXxaoywNnfLd5pmoICl0NRhZ6UldEnaiotkrxU4FNBMNVMzF/fIIlPMk
 vzVKFrSSnBKhipP9Q40E644fDx+Ds4tx0IfuBtjG14SlvYlHZPdjCvOuTgkuCfSD8iJu
 TdCCaWADMIieFnMy3Hi8Oy4kz0aidkX34d0BB1OcRqNmj+ThOfuegrlpdBnfTEZhFCDd
 Eali02y6vmtr6rnWDEoYuQexvrA2ObCD95ZNgnc/3llvGk7TdBjPrjOWZUBequ+V/Pla
 pGQkmJ8MedBIBLuB/AB/bCyW+C2vQzmvFcUrYRq9V6GmAgwKpHww1DURPDnsOiQedw4n
 Gt4Q==
X-Gm-Message-State: AOJu0YzTvlG5oZ8zu3EKSDdc7kacICihasQJ6HVZnxvhNw0VTy8MuPpN
 DNOxudkeqACAF7UPqDkxZ/VyCmLsbN+SEEu/i/QMLAmz7X8eMqO8z2TPUc3KKPwCT1jnauoydb9
 J5b3xrkWK9pP8KjszC0f9jl0ScSW9lUQh688lWC+zaA==
X-Gm-Gg: AR+sD12dGhAxl683S2gwg5DIbLVcsm1zT6rTN7HcYXGaoFCq5vPWtmV7Z/wKMtkpBP7
 /crwIBJe4c+Ff+oNSfjOaQNJpqyrHIPCoTyuGyPqu3WMQbVZje+eQzUQ/h8OF5x03M3Zg/xSv6L
 ZHVSRrA+QLUtntwKgrEI30Sk02MJrOzQBrvX18sLdZfVVcGmyCtIqHWYlAwD8VpX+g9gPFrlEQ1
 CEjjF4XI6E1B/O9Uu9nxmgLCyYZBxdmrGrG4NuLT8tPpug5QEXZEGXa8jecI2nTJXxmQ5C3WPKr
 Hqhwuhgc5vMuCk7K3TOgtw3+txVK7wEosDY3C+VkknDBXw7ed/yYLLmF+6zaXdqdr+BKZqQeMYu
 oIEIhrXZeg+5YJ5rg4TMghRetcPXn
X-Received: by 2002:a05:690e:4811:b0:652:5567:b3ec with SMTP id
 956f58d0204a3-6694f1baaeamr565248d50.37.1785515484016; Fri, 31 Jul 2026
 09:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-3-richard.henderson@linaro.org>
In-Reply-To: <20260724030616.76180-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 17:31:10 +0100
X-Gm-Features: AUfX_mxLHB5ABltfNlSq-57T1Rq4pmbG8pGpLlePJrbDN3ZQnXVAxvhw0BiRGUM
Message-ID: <CAFEAcA8eWkwe8FME2WePZ4sdcVVQMtOVVsFYJVejB+TChxEufQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Add FGWTE3_EL3 bit definitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 24 Jul 2026 at 04:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

