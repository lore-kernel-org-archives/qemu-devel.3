Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5F3C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytlL-000097-Uf; Tue, 25 Aug 2026 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wytlK-00008k-52
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:12:34 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wytlI-0005I4-J6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:12:33 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81dfdbd86d1so63726777b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 09:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787674351; cv=none;
 d=google.com; s=arc-20260327;
 b=MDOtJGxEmxEvRLHQKVuLC9OkZtBcS5+WuPapA6Xo0jDTT606eVk+8UdDCNcP0OF8mU
 qiiD8A0HZiOhwIVtGTAM7YnLEi8QvrUpVpTCk1Hw02R91j8IXJHPkm/DZ5tklmS1Nbh/
 YdawP5oFZa2+tR7m1EOyzXzxFOCBRFiC7ORkpv00mIecTRTf+D/53Ml5DimVKPYnOUeL
 KLR8XoxfzDGKxwKdWp1MrUG8h5lEBMXVJex1boGiXo0RDvqN0G/99VQfJ7H4H62DUCPo
 LgGI9Y1jOCM4IdlrN0BCr92bUr1Z1OuH63rKPm/zqFPvkAceftt4cfr9P8zXGJp+dP+G
 95Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wQ31H9YBahmwtG8dgrwkyVsM2gFvSF6wuO1KFZ+AhII=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Cj9DsSRrGDu3ZzWh6aSXAwhDkZKHdQlX5nOqsaZo+8bA0m968nUR95ad9ym+rqprc0
 zLLs2ie4qw1wP7uPlKngyDPmMBEZVsT/ZyQXfHJnmgIgI7fqwNzQOLrN786cYvZfZ9Ys
 CyE/cxPnh+X2T9GNZtH8KccTuOSFa05sbJJLoQY+Fh7CVy/NLF6L3L7SmIxDfxq5H+r9
 ChGe+8srXX0gNb1ErKVVl7mawe5G9H9Fe6YYT3ma201Jc87g/7V1jVXUtdK2RQg2dbp5
 jqorGX7S0kpKeM0UOcP0J9+nt2QhtFVDYr9CzLefCVr+jgkCksq0d2lMeD+xxtvlKYOp
 oxeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787674351; x=1788279151; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQ31H9YBahmwtG8dgrwkyVsM2gFvSF6wuO1KFZ+AhII=;
 b=Z3aY/aS+CODUqCBQf3hVq8MO+Q25iF4yNd1dHODqoui2eCqFZz+2SDZaLebXqFaV+C
 fU6bJVfbDEkbnmtkQOiJhm6wL+AIktBIjOI0AWP3AtFHcv2hfNPqF2cLQfAr1A59UgnL
 8TmfKdDiVpnqp0pImw2On4fQ5987oAaU9FPs0RS6vrSkFlSOZRTB0verkqwYBy7LNWEs
 Ny6yAtw0VceiOBJREuwbLh/MhzsoezVuUlrSt8DE0UsBT7Zlm7MFjuNl9UjoQQ7PN+J6
 W6AgltbTgpDAVxMrspyfunXhoKz2pLxVgFpqMWah+tGvBOKBFbXw2oc5W7KO5uaKry4I
 JuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787674351; x=1788279151;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wQ31H9YBahmwtG8dgrwkyVsM2gFvSF6wuO1KFZ+AhII=;
 b=DZ4+ZL7cRdDC5p/NJhN4YfELtnGBqrJEjlZEdN9kI3IzpG4Uiei9N20keAIzTWS02D
 ChO/uIZXGhOwQJj5momsiCFZmBPG2wMp33dkkMcPJBa7D5sA6Jl7zej4kqTlC9iGcsoW
 +54E8aOQTa15ZzRv+wfCXOD65n3NFexF0ydZvm/ZddSwu22+HrUY5AXb6jyyN7tc4/RG
 nyQm3dL7NbtVV46veW6bCKmyiyaxLsrpkm+fehTuRT+dqVsXdHrLc8JqAIkkwuGzV2AW
 IU1661u4I0I5bJOLasP9jEAF1u8rOpcyEzCKO9G4mDGpx5y+Heo8icnkxPvqqgbZprg7
 KVbg==
X-Gm-Message-State: AFuF++mxfLHRW39V61mcJtMFE5LJTjydhGqHPERaL31htfFBg+iM0RdZ
 lZGlEsSvMl+ijpU5s+0YewNLAoChqi/1K1Kkd/AU/gulnV0CC+UqAOzlwY2Qyrg5fkUotFof9VC
 ZK53xEh6GgujV2bqOPFH5rB1j+lGShyHgfn83uass/XvE5ZGlCKun2eE=
X-Gm-Gg: AR+sD12adlnQbgSQ4BiiGIolYI5v0hTrtwT01e9iZXc1S7H9I4l5JG6emGCmeFU8lcE
 yznKBUC4m+izMcW27El6PwF9Z2or9p6zr8rHqoUB2g49wJjFXAmYEqh0mGS3OD4wsPJcaFkzAEh
 XMTMGDM67sSR7PXJOVNnHWnddgazqhBg925TWbzu+V2UJaiBFCpm+iks7C61Obk/o/hPgehjfZF
 b3mDnj7eiuoi5vgU74M4Wi5uEnmkICRylORxDJU6XVhG02W0SVkRNZwwYoKgsKi0P7eUtMFDZQr
 90qrI1P1KPbt30p7K2e/gM9gauGtjDNPYhe3p9xw4omukZ4kp11gmc2AYVZlyF8uYWuY87sOcOT
 q/pVEkIfUS+FxR9oIRNiZjOqSfhcH
X-Received: by 2002:a05:690e:4295:10b0:66a:b622:5974 with SMTP id
 956f58d0204a3-66d14a46e66mr2248243d50.22.1787674350967; Tue, 25 Aug 2026
 09:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260825154908.20472-1-richard.henderson@linaro.org>
In-Reply-To: <20260825154908.20472-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2026 17:12:17 +0100
X-Gm-Features: AcwNN1X9fgnBD5VQ06cApntIy-umRSLuyFgf1fhaogLoidds-HO3gAisKDikLPM
Message-ID: <CAFEAcA_tqeXuERJZnTFyaLUjwMJoSm2XONoB337OR_Eo-x8SuQ@mail.gmail.com>
Subject: Re: [PATCH] tcg: Fix typo in tcg_gen_hswap_i64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 25 Aug 2026 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixes: 288d39e26d ("tcg: Simplify bswap/hswap expansion using bitswap")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4229
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 28d3b2a847c..2c88f4f7ca9 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1887,7 +1887,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
>   */
>  void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
>  {
> -    gen_bitswap_i64(ret, ret, 0x0000ffff0000ffffull);
> +    gen_bitswap_i64(ret, arg, 0x0000ffff0000ffffull);
>      tcg_gen_wswap_i64(ret, ret);
>  }
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

