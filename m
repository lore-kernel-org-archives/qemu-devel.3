Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F113710ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w682J-0006OX-03; Fri, 27 Mar 2026 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w682H-0006Li-AR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:41 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w682F-0007XO-Ti
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:41 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64eee7b83cfso1819335d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621179; cv=none;
 d=google.com; s=arc-20240605;
 b=EScKQghdundT7jPC+DmRNTMyTzpvbrcrp6nD/28AGaMEef8cE3m5KbJzo0ipLWZDWR
 mUSvchOE2dkEAiwqBtvvze7itMZThRyV/DXfJfJphUkF6BtdgnqxaEr/3jH7uNDn9BWp
 kH3QhhzptQlliTOO7X97T1qQ7XxBidqq6KVVOS4vVvtltrEKZkmPE2ZFYEOiUP448xqC
 T8cICGsswsYe2vsvPew5idfwa6bhblIXmBws8LWmFtnBD+KEE7jw7FEtDf+P9xPqOkN1
 gIWAEHiy68/vY6I+W94vRlmfqYxFqo7HWKhaVq2qX9W/C+JsYRwsNmucwB3fQvSnHUnz
 oyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
 fh=lBIAmcL+3C5nwkRJm/d4ArwkQeUNo9SSsWdIXkdRb5I=;
 b=LkmwySpZit5omvp0u+pL78AMTdjQq+q6qRqwbwvcJwsNw6pmRYPDuf46wJApBIU1cr
 91uRIUC23LywgjwHMF8SYJnG+3bXzw9wpKfRa127k09HvDRfRcWeTwzYWSJu6yVMM+8X
 zHet7gcwmkWJ1qCFpEIrc2pq5/9LHf6SPSfolAr5gLSfFn/Nui6PHLJDS9W0ihBN2r+r
 n0UETf8seseNfWhY5m4Jx0TBnrR/2e5mdJZ4/ydxc2o4ffBl0r/PM9iSO5+HiJRtZ3Oz
 p37AyEMV4U2XFCnubRKezID1kIgg4Kp2IMWBtF7XpJPS2tYh269Ue0be5x285xtXyczA
 e0Wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621179; x=1775225979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
 b=VpwC0uw8ccsZOBXAIxvdIluRMfu+0DWREvGZjJF/l78LTCAfTruVmCXE+mcJZ0JB05
 I5l7fmOKgnWZHUxApC7OmumEpYGk4GpuBSkJ1kPPpCb/mlulQEO9IcMapl9fq+nDHSRb
 aoAICPAFWVZSPQtW1lts5NGO6U2g8etRlO4KkXTx/LePL5t0AHGQLfEEFt9TirmXiyXU
 wphHl2aY1cRFTZlC8BNUt7ooUsU/4YsPN0eiKq0fFR+MOA0+FF2m3tHzxyYDe4c8sbGC
 2GHMIsFeBL5SLH9jurIzIsI9Ri4Wc4q83HZHBUCU0H7RTw/hq2rdjE6/3c4M1PawS13X
 W1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621179; x=1775225979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
 b=D+cLwyOO8tprglNjyduzthQLkhUDEDy73qBhsSdhmf5MuCthW0XMurToHj/mffFkaU
 UB56S/qpEgYNX/XyaJtNtIgRD2dqxSdCPYRRd7UaNqXBIz9nHFpPHwN4035pOwuXIdwi
 h3C72tZWRM6psFfBa7cO+O4qg1X2PINB1dWkC9VbSiqcHNvQwelzwTi16faNWV0FX0u1
 jgugI/5gm8dS7ybSQlt0q+L63UKPBpqk2STjlJJcPS3Q9AqNcBq34XDHBo9mgi3KywaU
 2gL/RVcOCsAb/l/wPQpiQoeHYa2u/CW1cF9lBwbCNSP5BiTA4KzTa6ZTz4ZpKf4pVtuQ
 K/iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZM0Tm4a5IDEe5I1TV2BfzhnzlzBaiGODgIHTAa61MhVbeYpUv/UYU/904BLJoAOI8OdbUBym63EYG@nongnu.org
X-Gm-Message-State: AOJu0YyMIV3/gUDccIJ+JjnfrMLIvmapvOvNorQgWef/k4w4a/4AlpDT
 dsuV8sKB6DnDIhhGylVDnQtUWLDnkBSqZHObcuw/PBniggo0byEUzAdo9ksM0op7w/zdCUkHFp4
 9IA/3DW07xdN7vLaf4W/0KrO2DoTlhiqIrlXSH4tJnw==
X-Gm-Gg: ATEYQzxg+2eFcC0Nl1mx33C+hk10ZIIn6xyhXVfNMZULv+4nUp7qvWZElhUfQdZe3Yn
 IpYh0t2qceOqc6Y8/G0USiJJj46JC11mA+KZHMuutbjxiGBGuBWIkzIyrrs1IgWk2WgwydzNw1N
 fuJ/jyErTEXIaz0bhiGishuvKAaeqlD4M5h4iBQl/2HdVbGkqEtRhZ7mHBDncVY0TyboKM3K4+g
 iBHbEx45xInWdy7iwHQiZlTc20pJS3Hz5zy3ZdANUYQ2Iav77fLHtEO8UrZSC0BSdm5dn5ugOKp
 wOi2HcY6gYg8GC/1bkBjXhR29WPzkRIkWh18X8qleu4eOlbxCkPAymHPwsZwgRuDM0Y=
X-Received: by 2002:a05:690e:4801:b0:64c:ec53:4dc2 with SMTP id
 956f58d0204a3-64ff71f7ddfmr2032330d50.18.1774621178891; Fri, 27 Mar 2026
 07:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-13-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-13-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:19:27 +0000
X-Gm-Features: AQROBzD-AGG4_FuWYl8Jf7kw8AaMpvSWoCSg9QpVLJsnXjr7qEvYKJTIbdMJZ1U
Message-ID: <CAFEAcA-+d1pcSRBnLV75AFUFkadfxXsN5156bh8hjW_Re8vD9g@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] util: Remove unused dirent.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This one is OK to drop, because the rewrite of path.c in
> commit f3a8bdc1d5b26 removed the uses of the dirent.h functions.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

