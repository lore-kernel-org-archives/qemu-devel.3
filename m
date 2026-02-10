Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D8DEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlq-0001MU-Do; Tue, 10 Feb 2026 04:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjla-00017g-FT
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:10:43 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjlY-0004jQ-Up
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:10:42 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79274e0e56bso6324597b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:10:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770714633; cv=none;
 d=google.com; s=arc-20240605;
 b=Mp0UzTd9BO+gJtYsxDOoSZMWESgEpN2tbkPQhCHRMxIGeTG61owQkkxTM5QjcRvrvF
 Z0pYII5l2TuJtYnZoMRMrAneLPAFjZuc/QD8joWE9MthwQqVDGhMXBy3PfPtSqoVgIIe
 H4UtdO9z5PCa6q3U3yBT7OmpCkeIzu0y2SQLbI2phSgOOR6Sli4YWw7N0hkjTblpa77i
 IjXa3B8Aleo8z8g+uk5mOpGpkr5rX72E3FbIwk3HoRQAW20AaFvMMOY0z+OIf0cQrLK4
 MJQD6WAXnV6ix38jOFVHz6/G7L8udmBTejYfO7Yf8jbs5tHJ5RGouDE3DyRsc5ih/hUo
 EKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=10S2BMcfDPVbWKt/WD8vxB5t6GnNoBBUcP7m2qIPGrg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Zg4KyIWwMMHmXmkB0uKbJ8oY8g47gebXIqi6wdxgoeac2i2ggzceJC+Wya03OEGerE
 xQr4ya+Rm6oI2nycfVTJl8xMvk8dleoOqVMA4FMjluhqCyGaWSQu6FJpnieOepiIMMs8
 iZ743laenIlb8NdXtmR0vFMmDlvFGjX77H66ermRrxuNjeedo70KL7tXt81zUjs9/rFP
 8bKVfk2U3xpEniZ0vRr43G0WdyorTJtqDpX3B/i0hsIWh64NzxvI82hmfj4keDDUp4qi
 utvFpWsnItFYSzxkUiJ6Mw/Lgg/YzPw6C+f611JtDp504Cvcc+GPLrGqdG/Xj/vpAFOf
 Jt0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770714633; x=1771319433; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10S2BMcfDPVbWKt/WD8vxB5t6GnNoBBUcP7m2qIPGrg=;
 b=PTdGoMjNOYCZKfF+xSGkpAu+RjXVKfsi+3rzFB3PihsBbIh4ge6vn6oU2jjZdDMuuc
 3ohOUxuO5FXNSotw3sW7e0t3gAYBRgwobbsplC//1IGnEs39vTIcff1XmMaeyTEyaMeV
 2iyhlPXQ6ok7KasZMKUTu2wY2cV8SSZVLJ3ZupA/myG6H0eKHfr5qt4Jyx8Eb/iC/hE6
 jekbB1MkvmUe2Poc0dUBLf5mXQNvOOBcU8BkhF5R/HdIBt44oYenx0BJKVY7+qk1aC5V
 wgQxidoNoooOIQGP3yLQ1XraEkl97p+oasQCTbEKysi7otRlEnsAtFfV+Y+9EF5zI02d
 SE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770714633; x=1771319433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10S2BMcfDPVbWKt/WD8vxB5t6GnNoBBUcP7m2qIPGrg=;
 b=G5KeTo6gClQ0VeiDsUcCIpWXLoLhGpL/BnhedotXFiczeKHJgcWRQEw+akRmf/gL+J
 dT7Leex4Xl5u2CPODutL/KfbUEjGSBObf95AzxAlELdWB3Gj7Gkv1f2Ex7HqUH1En4s8
 20FHWN1N0DfABVw58FNjnsd+S2LtX8o6fFBJi0S9Rj3OfBp5SKwXC7HrCqxT0CgWXod7
 cfix4r7Sav+GTj/Qmw01NGJ64W5rUynT1NvYNW7YkiLvZynxhpJRPKR7kIWfGjDWcv+S
 wcfiApGi1OzhA2qYQfJXEXy9chD3L1gR1Nh/HQtzcl3QUBqMrNWHYNBeVnRA/wCHFPHj
 L0rQ==
X-Gm-Message-State: AOJu0YyXsJzPeeR2C+DjLzddJIfEajPfkWAFNfzTuDuQfjfSzHk+rKmz
 iFofmpEkJKEvwESQSBolnlO5SD1A9gcX/pSU+4Vu/7yHuF3Gbv9gqIDFLcjjrETMsUeJtykx7wh
 13Yczs/QF1x2zhnvt1yZiJ2MmhDosLNyZzXL5J3URow==
X-Gm-Gg: AZuq6aJlDPGia26TRwvbp5NHDPc3htHyRZuwJyFD5BXq6NHKoUDni4V662hBTUkr74y
 FzZHs2CC1l2hkE8oej6VjmmBlA08QjajJinPp05Ig/cmCrFF1jJ76LuNeTYjfSfRR+HJhyUfWuc
 Z/cFfHKQemuKYHvgOtQDwmQPXCKhLvvE1vHWzpM3O8WidgOT4hwljJeAwxP9vnSDtsIzDT4U7H9
 u96rPe332G+EGVmQYdy/OgjuMN+cjzeOwE3t/gC2mI9IokcrkovfXcHZmAmY1Pii56+7xDeUCE6
 gNmARBHdUGuKf/naYaLXTSstmVyMGo2t3FBYGRt2H+ktv3Nd/SFeitdYlWAulGzzjSY=
X-Received: by 2002:a05:690c:7305:b0:793:995f:25f9 with SMTP id
 00721157ae682-7952aa7673amr124425677b3.28.1770714633449; Tue, 10 Feb 2026
 01:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20260206202320.5546-1-richard.henderson@linaro.org>
In-Reply-To: <20260206202320.5546-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 09:10:20 +0000
X-Gm-Features: AZwV_QjQCsIH9T0A_2DDanP-OGJG6Ddl3YymbA93_7aahb9kQOPU9QDpmyyW-pU
Message-ID: <CAFEAcA-cmCucPUFYV9U8U2h4JWM0m-SZt6r_MwMY9H5m+vX9YA@mail.gmail.com>
Subject: Re: [PULL v2 0/5] tcg + linux patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Feb 2026 at 20:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260206
>
> for you to fetch changes up to 973b0b0e3a5e4c4816cddcb367dfff5dd16be611:
>
>   accel/tcg: Remove a redundant argument attrs in io_prepare() (2026-02-06 16:51:09 +1000)
>
> ----------------------------------------------------------------
> linux-user/syscall.c: Prevent acquiring clone_lock while fork()
> accel/tcg: Remove a redundant argument attrs in io_prepare()
> accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp
> Revert "tcg/user: do not set exit_request gratuitously"



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

