Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B1AF44872
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBCcA-0006KO-2p; Fri, 10 Apr 2026 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBCc8-0006K3-MH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:13:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBCc6-0004F1-Kv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:13:40 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65032e9cf01so1953638d50.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 07:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775830417; cv=none;
 d=google.com; s=arc-20240605;
 b=F6attzqqmpGNmKz2Jq25ipiPbpYBs0hGgEQP1oz0p33FmiaVooNcSA2FkWH73X9daT
 S1Nd8S/lDa/3u40va24Wu2Eg0GHAgI4M5l7wM8LTwR9c3sLHxrmeIrBdPoHrxddy6AbW
 mEL2YfGiiVadtIC5aYpir4mwpVtrxF/b72tWUmEMO7+DStImGnc2orqq929/ciqZH9uu
 9HcPxnOfK4+NWA14SQ6YAmlcW7QAy0Zc8b7sUtwcCr8Kyq7YXX3oIJcGhSRqNTXmeMC8
 RM60xCimNDvXD+MPESSciUYv1TH9FNXVGXqQh/k3hwI8rJlYoNkOi1XqjyoaSzIOhw43
 NbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dcFSwKB/i4h0goNEkkeG2RnmUVWnuiSUwfDCK6YZJxI=;
 fh=6f2ksvrcNK0+UxfJWTqhzPgT+A1saGHsnWpNshlAcaw=;
 b=TJdQa1G4h2EH2ljIiBwb4pzDTocqn11bW0NWU75n+L4f8O9H7qev6B4UoNyepK1Gwp
 NZfKwM+vE1ZHElhcJaIej3dzgIswBK+NjpwGq5htILEJkB88gMtzG/qx90aqed/Rz8SE
 GTpYYclvRBW/6tJ+6TLAOzkXp96bXqAfyBSiq7cAB2wxYZx7ZgNCzlht9mTKSmy4N30z
 //7BS7403ILIXGIpNxufuF2e2bXk+uOcNqqb9/Gg1ZZs/lHLFXYC3Sx6eYcsntP729lo
 XwnnGtliPz1mlaZYA+GbtqPelpdoiqMLEnyFbZmDpFhhqxQYgwxcIm5wgxjjgRox6rN5
 XlQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775830417; x=1776435217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dcFSwKB/i4h0goNEkkeG2RnmUVWnuiSUwfDCK6YZJxI=;
 b=WjpNlCmbo66wUjZU7UV1YquMiY0hs86JeTZXeH7HCXxIf0BTnd9L2JyFC8Y5cU/RDI
 6Xzg6spAZ/2/kX81ilj60Gz36J7eFKYJ4viZYXW3H2u82f17gLl/MJ5cJbeC5G7R7wno
 2BFsMmGm1x0111msQw1FnC0dhc/83cu41t214vHThVKYMyrJEVU608qCcCunep70AqdH
 XFXGtUC6D1A50ljX25wbiv53bL3LKKOOo1AX1OO8Jc/UkWZn7yvyfe5CknaZ2X48SjRa
 7zT/noB6OLXrq4z75KesLGO2Cs/CqHegU1YK9y9HrA1bgt8UIYnojK0TysEkO4QUJTCa
 H3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775830417; x=1776435217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcFSwKB/i4h0goNEkkeG2RnmUVWnuiSUwfDCK6YZJxI=;
 b=BPHEtUwcq1y37jnbOJQWdhZmmgGx1SvxoUMK1Jxe3WKgye+OJI/9/byvPOovfi4S+B
 PWY2ZgeU0i4v/vYFCv0V007cGL54A4xqp8C0m5YnmdBtb3jW8tvujcLq4mB4Ex8In3oF
 rX2vkqKRVEB/EeSispiUAKK293aHLt6aPjBrWYx9Ijc1dEISYCkBrvzDhxXfNOwCDjI9
 vBXzgsuo3R6uyHnjLp/oL7uhLJceBW3n2rNnuR8fxp1Mtfdswh7hyzb/tqmzKKd4SoLW
 Fr5ZlvPpuQHU+bCETdA9Ts4TnKd8x8jc8efbkkSCIAan2EEFkfX66YshsLZlWhC2qMgt
 eqhg==
X-Gm-Message-State: AOJu0YxIE3GmfVm0BzhKJYcLdvTiDhPzXsensBgq8/hC+KtolXnlRY09
 tUp/7s7aI51en6pw6bv7+drb6cujzKcnUKBc/kAzYKoFfprxED1sUHJ8gOEe8ZoUSYUnFN3WUdp
 qP0wZwnaHRevPx24jFYbCRNdxgo70EKQlD7xendNOpQ==
X-Gm-Gg: AeBDieskNB7+xUzAEhVuYmvgRVzdUKfD/195JHA/T93GASG2qRZ4VM7Vir/BahN3Vsy
 XBw9JJgWoCDUloK+yi8uyaa/mcydLy28xFevmqGANg3nHzFgJUNMqj3nqM+dphUnc4D8kdcfZ9e
 CWa8lNIaJJYrxV4QGG04t0EvAXh/F+AM8re2rDdtNeAzjT6mK48RYpdj+Jvr3Y0RasY0gs2eFzO
 Nme5Fqgnsaf43QFlFpok3WfKWvh0jHRg0eI7XflHr1uf8dCQKRcyVgAsr8V1r3usMDIF6FgsiC8
 7O3XcBO44i8xN8PFU9bC5vH3nswMr862t68j+K7wEJ2AI0KGQUkFSfgZJC+CYa29p30=
X-Received: by 2002:a05:690e:4805:b0:650:11b3:3f4e with SMTP id
 956f58d0204a3-65198b79118mr2156872d50.32.1775830416839; Fri, 10 Apr 2026
 07:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260409175234.40792-1-lucaaamaral@gmail.com>
 <CAFEAcA8rF3nuUTd7ARkcGpr-sA1DYJEJc-2E_URQt6nr8u6cGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8rF3nuUTd7ARkcGpr-sA1DYJEJc-2E_URQt6nr8u6cGQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 15:13:25 +0100
X-Gm-Features: AQROBzDDV4jGlHSK8JpeZCg-ImgoIv_V70hqgdKYGugzRrtjquLdfSjIzE6IZEk
Message-ID: <CAFEAcA9587cZ+oOv2t6No6eBJdR9gxow8RFqy-JN=7OH3xk7HA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 9 Apr 2026 at 20:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 9 Apr 2026 at 18:52, Lucas Amaral <lucaaamaral@gmail.com> wrote:
> >
> > Ping.
> >
> > https://patchew.org/QEMU/20260317175744.32469-1-lucaaamaral@gmail.com/
> >
> > Mohamed gave Reviewed-by on v2 (nits addressed in v3/v4). Patches still
> > apply cleanly on current master.
>
> This is on my todo list to look at; I've been prioritizing 11.0
> work while we're in freeze.

None of these patches seem to have reviewed-by tags. Mohamed,
Alex B, would you mind taking a look at them ?

The question that comes to my mind is whether the two places
changed in accel/hvf to look at hvf_get_map_granule() really
are the only two places in the whole of QEMU where we call
qemu_real_host_page_size() and expect it to be also the guest
page size. The general idea of "guest page size might not be
the same as the host page size QEMU itself gets" isn't hvf
specific -- maybe we should have a qemu_guest_page_size()
function ?

thanks
-- PMM

