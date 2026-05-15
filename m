Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F436CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNneD-0002WG-L0; Fri, 15 May 2026 04:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNneC-0002SQ-51
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:11:52 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNne9-0003sK-7i
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:11:51 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65c5361142fso11569943d50.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832708; cv=none;
 d=google.com; s=arc-20240605;
 b=bQucT+i6ixHUX0ihtQfXqMRB9vNiBLkjEXhwOJN6y81VzJ3uN2ZHROzlkQeqJe5TFA
 DoxChlmOnfhXrCPXhAeRv1MKxjJkOxkxHcTS9GLIEBnLOmLUfEMYfAkpHyQKTObQGpme
 tsOoFWvbfdPG4XXx8kddjLZSaXgD2GzEge82f8Qb61GZjOKBmfuUHig89kYcerizjopV
 gYizcxYgCM9jrBhVZEpCZikZTqL878+qcBObK4zz/M20M9T6Jsg4ma08k9xa2pefI8CC
 qFKocajhmtcXUQY8rq3QTXUGnp5BmBkWc4sABgQ38BjMEahX+zgs5a7sLD2C6F8Xmgs2
 KhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZDR/TctYAg7dyCpCTZzxSFUFUkHrHKvXimU1RucBfc4=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=QIpPCx3XvC9hKMfJ78huVpf3QoeX9JkdBy1tWDsWWB7X09JyqUp4Zx1VzQJ0HMrs/W
 VpgaBuD7jcKhauBla6K7QP6xSMJMvAX6IYsaQCCBQoQAzo+NLtYUSwQibqYzJMZoG/rb
 jZXKYPcLEkOjwGMa56xi25BqUMGzGUOmycRyhADfu9zcfLGA8U2A01gRFnageePg6fvj
 TngHp0xN/lmwqCrSowM5HvQBeDGwuJPweZs1Bi3pLKYgQSgtOyQl1kawTtAPeWRV4e3d
 qbAZWBevCY+wVflf8R8koZuuQu7FHrkqIyAIomC3cLikZs1xrDL8MsNIu9Jbu4B/6It0
 oX1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832708; x=1779437508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDR/TctYAg7dyCpCTZzxSFUFUkHrHKvXimU1RucBfc4=;
 b=yKJUVe5buHJ6qj7hNfeLAg7qW0ES0MgltTSJG2KOUgKzX/y156ivJJtlbtktFKZwAm
 AVZ3C2SmAYnB+Z0ODUvUpDYrsVIn5+4ZUet/2Wc/su+iLwXvDokQQzQ5lSQzqH7yR68V
 MRP68A06V4mfh/vs/iDdsz5Om5a7itj4kRf6vIvUkfVYmIv2e1RH3a+oZYTqCPzowRPx
 QMFbmznuBx5wpEXk0Qt5OB9yzZ8xkNQupb27Tbp5G2GvessWmNs3lQRxrHYeSt1OaE5b
 iIZiAJ8pV9Pjv3I60vwby6jQ6w+/yFwd9fARzOj2ItyTcge0p6hoMje/Ux4+A2x9l49U
 66PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832708; x=1779437508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZDR/TctYAg7dyCpCTZzxSFUFUkHrHKvXimU1RucBfc4=;
 b=gQu61U417zWNpMzy0yNX6O+iv7CX5UEtL+IVCXAvKeRbuoA5bMQuIhfmLPKy0oajjS
 4wvIwVFzrxFpaGMSbjCXKHN4B/q0jljGGsHob++E4tQNh6CWdSuV8Fo0DuPhv7xVvaFc
 MA0yZ6N/4t+NbBs/9MLLPDWajZcnx9ZyKngJqoAPjUL7RY4al6Gn9BeQiaNT0nblR3AN
 +Bi5OI5/OhgkcVQw4426FD/0jRaTiaVT5wnO69iQpQpqS5FhJX2P2kZ2XlmlAVSnJ6Jb
 uNCyApU6zwTCG1odknIw4hkNGo8ySezHih/Q/wd7NEm52oD9O4L7o15lLIMBJHRR5wjx
 2G6g==
X-Gm-Message-State: AOJu0YxX9u41jeQUsLh8oO3NZACPE/uUpBGCcFfhOY6jeeFkBZ1fb7wS
 zs6qTrh+UPr+xnZ/ijbG5RFOsJs5rnHe5gGpyUwLRnkd4d/+xRw0g0qKosheIbocutuBxSTA9ZF
 bKrkyNz9y/1+ndJkcOL+VBCTKIVIvbH7v8H7fFetYmg==
X-Gm-Gg: Acq92OFcgSRJn4jWkn+X+O+PkCRYRVdGQscbWd4+8rusp6xT3+2DX5x1Kt4u5ERiyw1
 7oYRitgX9MzT/cPuSQR1XGednhV4l/H/2gg0+yGGqmGxCFIUkFnJowRqQOZDEPMd1+3vo/Hl5D8
 34wfHD3S4mLNNztxyjMUSx0VeXfU9lkIl3ztAIGt/YLnaN0C08KVCcnHtHNX6erreAcLbebH1xL
 sgKv+zmZQuPTllwjgkb8upF1PuVfypymuJrs4Ec71rS2g+pE8fl5jTQ4Q5RMQQKBx7rSCaV0n0k
 V7rQeCX1FjD5UQI8mHCqcTJKjXNmr9kZtAT3nj9SN70DuJ6MY79Y37+321rCo4bZ/hU=
X-Received: by 2002:a05:690e:4409:10b0:650:18fc:f557 with SMTP id
 956f58d0204a3-65e2285bec6mr2437951d50.56.1778832707833; Fri, 15 May 2026
 01:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-9-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-9-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:11:36 +0100
X-Gm-Features: AVHnY4In3s5nVTtvcAWbR1qVW2DMDAag6GjZGnCWkp1a5--5BW6TB4a8zQLv4bw
Message-ID: <CAFEAcA8mESUEDOOizjppQtODoF9fj4p6JXe6zAnTiyEMFhJpbQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/15] hw/misc: Add dummy ZYNQ DDR controller
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> A dummy DDR controller for ZYNQ has been added. While all registers are p=
resent,
> not all are functional. Read and write access is validated, and the user =
mode
> can be set. This provides a basic DDR controller initialization, preventi=
ng
> system hangs due to endless polling or similar issues.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---

Please address the code review comments from v5:

https://patchew.org/QEMU/20251204093502.50582-1-corvin.koehne@gmail.com/202=
51204093502.50582-9-corvin.koehne@gmail.com/

thanks
-- PMM

