Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC94F9D0D0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeE3-0003AZ-De; Tue, 14 Apr 2026 09:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCeE1-00039e-I0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:54:45 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCeE0-0001Lf-2e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:54:45 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-649278a69c5so4504910d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174883; cv=none;
 d=google.com; s=arc-20240605;
 b=fo2e6Yu5RevnmHm8ogRSvcrNYu5WrugEVBhXrrLNkrJAl4qdHMltgJXqnSp//XlLvQ
 JsKAX0jxab6CRlupsx3T+iuGrVWL7mz8eb0W68JgcQIdhoAyHUENwjsHEtXC9+Ood01h
 WnoACZPNfvar3PsaXumVoeBN1Gsc8I3fEPpTKOwIZXEOe16/kyBhSIPtdiPMJkuKfGIV
 8K+zMyEXzThaTurLSsdakXbGb9ZapKCXGdUWYrOwkEnEYuAC0GNEF4NV8NITvVrh9x+5
 oSjmYiihlZQqCfzN3EL4sShWwY9O/GNisbCZqg/AWP85QP8sUFtIj2s8QTPGpy8pZA9u
 EB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
 fh=VqS+tPLsGlswY454e0dYtkegTr3u8RL39VDhCWIP5Lk=;
 b=JDsl7r1tGvdMW9pRgO6S9U523QAgCMUOvqXNuA6FpA8xVbOuN8Js0/AAu71mREOxOW
 5AtE2CcW8P6Fu5Ns2U1TEKW+dJA/xhyqW3EhZmi4qPNjzxtbCFCLyjt/nyvWq6fAbVUh
 Ml5RwNAiIGZl+dfUm8HQ6EDI30N6UPd1DWMec11Tk7OZK5u+aomroo0ZBUKxXAxC5hRk
 leqSnG4GcdtjmoOTmkSuAr679IsVEWJGTDpAdvFlXvFlQCnaIIUb8B19b6bEW6aBcs1r
 7vLJjIAJLhiIelyNk2asPEJ+bHanmX+TCtYF6tY9AOsjL/ofSvFu4274cJti9MErvi2m
 sdSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776174883; x=1776779683; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
 b=Z5FA5lns9qX9gmazwgilfCZwpwQPMliblu2E56Ww4ZyJN9Lsv151h5+P9dSNVTzdqp
 JgRkSOnCiZaZG+QhUA2XcUCRsX8Fch3uXeF1Fg25v75snu0yCmlvd0wJOfvyCu6uyTzO
 T26U3dbYzSI1c9hD9NwsN/Udx9KSURQeDV81xrelT+wwm+/mvfpegyfZqNCYSYznew3t
 7AHcQjraPh0wDB14aezRVo4XMU8gSwaYa/3zZ4NeXe2uI0n2IDump98zKytN0659n9rT
 ALSrc9KKd8RwF0a+IeNLFXnKMqdOcPhtyQzTTyNn+9bSGHCnt1qpfGcE6awKBugs+/mT
 zwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174883; x=1776779683;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
 b=pOLeD2k5Y05O5dnZXsm0kgzHydrCN8KQ7Mhh3mIXNOuagyh5NpxY6sGYf2rGyIu2jY
 FldprYGp83qNc5R69/3gRfUrMLhObHHiEgfzXQEtnb5PpcmTgHJfSG8Z41ViulH4W6yv
 JhZY1BFpMOc8G69xsI+SefxQM8C9GBfJtYxad1qR3/bKKRVAub2T+y1uyr1pjSwrrLCs
 VqTbwvvT4Dw1ZfLBkv+7YTgjSvO0QiS6EJy+llpj63ulucHRhAsb1Tif1w5mtVx8cyR5
 GjKzF6Kmp/d4kUpV0seIwHjODFUeCEdAJSwU0x4nytHoHWJ7GL29Bid7oNL1gnRP10Eh
 z6jQ==
X-Gm-Message-State: AOJu0Yw7hZpgtEvz8g4Oi2EwHC/NskWK5+9xk5Wedg/Bx1nj4mHRIB90
 lwFS8zf5fw7gyjkxIZwtVUa2M3LZbbEmIia/H8Lm4sTpLUg8PMmAewH1SAatet+2SBv7hbr7EhH
 S43sOPEdwZei4fhm3zCdIz6nAApy1yc4z/rI30SkyAls1DmR/xBOP5VCbFg==
X-Gm-Gg: AeBDies9N1XAhDHNUAOxWCK2JPX8333NFOimTWm/xT2Efhv2QKtHcL+XZLqL9Shv79c
 2hhVN2aXkNL2CV9RXCEUVQ/oVkDVl2R67ivrXmDmYg2g3AEg+09DAEWW2o8UN+C9eV+4NFhvkMp
 ewhPla+p7LFA9RsCYDOw5zDR7HMCgMtFQe9arsSaPbRZBCIA6YjOjYyd7GhWFbIUitUqARoAzKy
 gOVqiUgyQFwpvedp0zRpNiteF/FZ6pmVrhAKROPoTxiRAkjAsSRkbHGrqU41FFYFxhiTJOHlVG5
 krRXfIQ8XRFSDapJphEB4MCGMvRo7MCrhTtP4UEt5y3//czLihQ10wxZnCUgQ390TMA=
X-Received: by 2002:a05:690e:190c:b0:652:55ec:6a1a with SMTP id
 956f58d0204a3-65255ec7219mr1653661d50.60.1776174882695; Tue, 14 Apr 2026
 06:54:42 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 14:54:31 +0100
X-Gm-Features: AQROBzCv4KASqj-xG-okU_0Y7MVzocNNyCGEVXastnK9Fj_s3untKh9PozmA1H4
Message-ID: <CAFEAcA-iQx2ePtCYBdfVeXqMSAT4Dx+Ys8jX7EjsapGbyMUFng@mail.gmail.com>
Subject: Save the date: KVM Forum 2026, Vancouver, Canada, November 12-13
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

####################
KVM Forum 2026
November 12-13, 2026
Vancouver, Canada
####################

On behalf of the program committee for the KVM Forum, I am pleased to announce
KVM Forum 2026, November 12-13 2026 in Vancouver, Canada.
The call for papers will follow, but we want to give you the opportunity
to pre-plan.

https://kvm-forum.qemu.org/ and https://kvm-forum.qemu.org/location/
already provide some initial information, more will come soon.

-- Peter Maydell

