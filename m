Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54408C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tm7-0003b9-Ho; Tue, 08 Sep 2026 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tm5-0003a2-W2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:14:02 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tm4-000454-HP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:14:01 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8664769db58so21388627b3.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788866039; cv=none;
 d=google.com; s=arc-20260327;
 b=Ryw/a6T/Pra8qB8N21v+gXCadFZWPVYe82lZ+ISMtT7romZ0gAamXTsRqxd3NkLoAv
 x2Q+9HHc8MUjaAaLZPmSVPBHRCt71GxI+Ca9S6mbEQHDL4TeHh1KSgxM4OVf7fqPN9Bs
 qiec08hURoEMdsEx/sjp16PZ1L48vHZ5e4Vlllp4Ez60EBuXHYP1ShV3IfZdTix0jjkg
 Yrw0dK8ZPG8+b1BVKz4Ay8zKDsiwW6LOjrS3/xxBv32lFLuoTbAn+rAnYfXoRfkpxXIV
 /FQDAL/xT4M+WtdIp4zk6mLvEsry0aOfVhsSLPgAmXQEtVwqrMf4zLoyADuq5i9iuWjv
 QQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pr8FLXUb3doRbY2SwJEqxWs9Nho+a2/jsocXp7I5e70=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=C3b//omnvhM7plWyNAExZB8AHKstFXzzGFu1W/E9YWobehTAHuax4yJO+7dOChsqCa
 m9gxo//JnvNYh1HO+wnO2PaHjA8H4t/WPgHkGnweQzIMgQ2WbvY0rTYyFs/hDTttzROs
 3gx42C9FAG2Yfh1aR3G+QQ/jyfrSGRB8MhgCUEuV3gOYFZCv5GVQcAvtqjAkfFQzf5+t
 srXH4FArXMIP9owwe67/xMjQ0gOp/SALaIeJWSbygkeWm9Yf9+wDdBc8vdCXb3bSM9Bt
 jTart/3cy9fNaCN3pjSdWYcvcL+tUsiQmgNrRf3/N7wOW1QhOjPe1ftW/joPq+dRkr2N
 8CAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788866039; x=1789470839; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pr8FLXUb3doRbY2SwJEqxWs9Nho+a2/jsocXp7I5e70=;
 b=VbQ2Juph3zuG7m9xJT+DgeCqUCQSMTlUGWHP5E0OLshHSO/js5U4Q4cuRGL3HhHJU0
 x2rG49zO0YO88N5Xg2oO/SZWnuUb2WNFFkOO/yGo1dK2LltC7pc/o75r9QvGFDeDVlqf
 o15qa4fYyESuFMLe4Diz6y4zhdBuXQ+4Y2hx+MEY4TZiLoMvkZZT54ImhP+kMcus+NbZ
 kpQgHo+3f8bFgx0IBoJz+OPTzzZtDqTBUkv1LyPhAeSciGaDXFWPXi8U76+YszMU9RD3
 u04Z3TykZaVQ/Es+QjbpiXw17osT+S6JIa2+r6nKCc6vHB318o2kQiHQv3U0ohYu6PWe
 HNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788866039; x=1789470839;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pr8FLXUb3doRbY2SwJEqxWs9Nho+a2/jsocXp7I5e70=;
 b=N0UvaKd9nTk4nDIkNXqkTqtSfNWyAgr+7wMOEIPfzAM/S4bAc7jrz/8chTkWA2Pg4y
 M2PbC1KywZ2AwCIcnbSTgBpJArp41pXpT7F77HUcz+1SPth8VTjpCKGTxGNAN15Huc1x
 hSM17zW6PVnIAXfqMXuBJSPHIWDWQDQcjQQYxM4FvrfDIKH+5Qe2g3ZVVYJOYGjRJW1E
 9BfN4Idz/3Pn3IjtmT7kRx7uh2jYVmMlLJaxXIdC4Ehdo6kEihW0s3rS6x/EIzHd/EIt
 82yk8OOQ91+ytqTQQbaMfZcwQYGNDNoPwPRAFuEpOdWX24tVhseZvKOw53E2sdiKWhSM
 gT7g==
X-Gm-Message-State: AFuF++k9v/yh+uQeKzgDrgYxf7/YheUFYW6NH/BK8dXFzXYrM5wGe3pJ
 +OABClaY0opGYQNv09Pgut7ASyStpzoGsWOxLTrcQML/O2ut1Qhx8gLdQGK/2sMjscz5uSAprhq
 eYA1U0Rpc/On26V+jTEl07hB7myZ2i4tvXNtoOweF8QmvEXqGxjWTuIE=
X-Gm-Gg: AYBFou24GpLQDyoxVshe2j3sqI0SYZYG5x2whubxuo1LD5aGfBEmgsi/pVVUujN/n9V
 mbA7mCrGIaOGUGjo8zVx+wNU3aFXZCsHKKFezoJFBXI8AUuOJCx8zpdf7mNIC3GVjTGJZ8r4j8y
 DPTkmlfPSKnjRTviLnxExmUQb0HXpIVcS/76uxbD6N6ncOSvk2QCjMZoTTrmbTfUi6d3al9FV0R
 NI9GkXEnPtxlM09wV3pMjoPd723hRCN5O6ewgFcEncD6LPBLQJqMcx8YDPCqBzguECcSkKjTKeF
 Crv0gGyOYZq91b/qLFaTgNIU2KVlJiwgakdez62WtLkZA+giCZUCjW4PhFyY55wKnxm48F6Au2Z
 T9EayoDDHozb/xO4XcRt0N/XjLRtSB1NZlnbWeOo=
X-Received: by 2002:a05:690c:319:b0:841:8f97:e898 with SMTP id
 00721157ae682-871288e0f77mr131766777b3.32.1788866039158; Tue, 08 Sep 2026
 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-14-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 12:13:47 +0100
X-Gm-Features: AcwNN1UEAJCjMQ8MANGvbxSbhqC5VE_XYXCO42JkUEHmNCAtYlYoJb6zzYN0fSE
Message-ID: <CAFEAcA_ppZoijEhEoOmtJBGwE8GEuk+p5yXmzCaWbv6rtOqKFw@mail.gmail.com>
Subject: Re: [PATCH 13/13] target/arm: Enable FEAT_UINJ for -cpu max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 28 Aug 2026 at 23:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

