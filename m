Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FF7C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAYZ-0004jH-Pt; Mon, 29 Jun 2026 07:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAYW-0004ir-KS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:53:41 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAYV-0003gu-4c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:53:40 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664b05d408bso2473072d50.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782734018; cv=none;
 d=google.com; s=arc-20260327;
 b=I+RaRBPE4yHuaJWLZL9+wxCY9yeoHYBiAjQTf0E0ODsZ2kTUI/MgTdBkA3bsBHxO6U
 pWPU0P4gpKjYYRVKXK3dojT0fyaj4oCRjPcAxwlJ2xhW7CsBe5sANY8Ak6qCG3cOUMIL
 vAfrLwJrKru1EoKyUradh6VaZzMHWFfGvZzUTeHB1BRlR5sAx8wfUlo1nxzd5oub16pL
 oXy8kvUmg1am/dGPjhuKgoH6SF3nqPmHA0MEc49SKUsY6rkKDc3+BAGB0Ufa8aBIK9ac
 S43Af5u9U1TUd/7Kags+rZHrzznA0um2dKIZlG4NZc4AOP/5RXsfy4VWzgMvmYM0Jwuo
 t15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xOtCIUr5DqcKQLZcdvUkFdIuHd53Vv+n01JflmKWVjI=;
 fh=VqS+tPLsGlswY454e0dYtkegTr3u8RL39VDhCWIP5Lk=;
 b=GLhNiLpMRcA4dTnrFqnm+Hun1OpwPiART93GkIrkiv4Xt/YcVXAVsvgXsxJ5jLXl/0
 fHrV/hhgMNmIJL75PuZJfa5E4U5ZIKsOutRwxCHcAhNteaRT/nfowDpCVKToU5gx1c+E
 9nr7qIzTbnWQBCpuurTHDKo8f6jfv2h1PP7cNfPSzV1naJMUXVPECcJOWHcLcIjf2Blv
 qIAqD1SRW8tpHUm7trPAWqweyAT6wg1f5rwOji7JijNNb+nv0liar1gE5GFwnoa6TRWg
 +opC6/k00WeLI6FwLMJ8SlKFiIDsrtqHa1dAioc5/6nhhRT20bZbq5hOum55nE6n8QJn
 0b+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734018; x=1783338818; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xOtCIUr5DqcKQLZcdvUkFdIuHd53Vv+n01JflmKWVjI=;
 b=CEbyv+XqrJdxuuqQEGBvNFEI98+5FDimab7QoqJByHvZ4kVgBkdKiXYyjFJIkEC/Zr
 q6sN5WHFxUpB+BfcJ6LrZ3/h5fIgRp2y7818rcdmL+AI0VoOcKF9wF4cimyAZ1Nk5F/t
 2hyAkJwazj/d3Gtw0HmY2Oa7X0nvey3VkDv/GQ4azhOrJpQ56WcJpQEnrj0vTe2z96EI
 wwZVTQ8zb4528+oyj2uDnDk9f/uUIMe84isAWPt6IGXnzTxkPu2bbBi7J116fGSLGDvv
 K+sEWPhx8+NgOxamHYbgCgwlAbMrycpGc41bAggYew02d76piLF1i60S3lyJMng4pAvZ
 mPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734018; x=1783338818;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOtCIUr5DqcKQLZcdvUkFdIuHd53Vv+n01JflmKWVjI=;
 b=CSUAyK/OTnXPosLbEDRgI7S2zIz5QqBLbCmOdFwACSLU+JVRGPAA+b+H9LdhrKwwgZ
 0gtUFndIY9UCoV16IaRWvTJKfqlzEMWLlsHnpz+dm7lqeW06pnVMZa6lnBN2FvT2LQsz
 myVVqSbDYh8jO1/00PdZM2tyL3FTTP276a9bkM9Z0cg7yWw6MrTdKzk1grw6Ac41JASn
 olXA0gcCaRmsZuxQwj8kz6tkWUtQTH5eoUZBO85zv41oArTVgvJC85BKgVqD9JIyaU9s
 xy0SgUJQE0jR6Z4PL1/pId/d2hdiNulKqS/GPPs/7hk1bHxefjCi+zC2Jqf5VrexF+jT
 +UDQ==
X-Gm-Message-State: AOJu0YwRxNY+My9tPsj+XVO7ATIh/1KUkYSPDBEa2SmQYWTFJuu6YepE
 ep8D3JoneAKTYRVEl9xUX1NcXYQcTd0nj9uHx2u8mWXDk6zG+QE0TTV1QNT7sulrzKirL9EJ0fI
 jukj9HAje+mHER+nETDcMBHsQdoThMpnXlcZsUP+DLZx8ZUR9WVsKg1c=
X-Gm-Gg: AfdE7cm6BEDP3mDxK0BdABPubWFxlGxcPIlnpetHg4mjURZGaxLtos5ilWxY0YhRSkF
 C8hD+FyNgO2+Hd/MEobEs5mmNNLtnCMINdxs9n2l6oWmdxCQfX/GyiAf4Z7kje70nLKKLiOd/aW
 y2ALT+dDnPUzp1NMCGhBT5smNV/V67XYCOiNrNbXpFIb5ZSzSPelvqiUOLEed0LyZPJVCmwpdXu
 dX82O8RG7PIXDYv83dOmCszsbO1jimci8wDtdK58N7QjX8KPZZ3jq3gueqrURh6uQQxilV/Yr4P
 p1zUwmZpOlofgdflbNmIqfnaVk4DmYcg5EMjC/jbFuBosDm3OU593q7gymSKEYHwl2k=
X-Received: by 2002:a53:4204:0:b0:664:ae6a:eeb with SMTP id
 956f58d0204a3-664ae6a100cmr7237073d50.73.1782734017622; Mon, 29 Jun 2026
 04:53:37 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 12:53:25 +0100
X-Gm-Features: AVVi8Cf0YnSeKjrtozUDW5ulWi5-aVq8MlzvCUEJOf8OwwAT7S00oOBwAK6hQlg
Message-ID: <CAFEAcA9C3tLDOCSMJVP7UoCRkH=BkVkA1HaziS_am6ZNpE2gbg@mail.gmail.com>
Subject: announce: new official git repo for risu
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

(Since there's no specific forum for the 'risu' random instruction
set testing tool and we do risu patch review on qemu-devel, this
seems like the best place to send an email about this.)

The 'risu' tool has a new official upstream git repo at:
   https://gitlab.com/pm215/risu
This replaces the old and no-longer-working
   https://git.linaro.org/people/peter.maydell/risu.git

This actually happened at the tail end of last year, but I never got
round to saying anything about it, since risu only gets a very small
volume of contributions. At least putting out an email should result
in the info about the move getting into web searches and the like.

thanks
-- PMM

