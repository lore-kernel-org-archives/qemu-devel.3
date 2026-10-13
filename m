Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9050FCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGevd-00018N-0q; Tue, 13 Oct 2026 12:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGevS-00013N-7Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:27 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGevP-0007rE-Ra
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:25 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ac9d666d4eso537307b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907222; cv=none;
 d=google.com; s=arc-20260327;
 b=eLMCciuLI6DDNGI91wXlaQhRXppymPzgppmXwCtxQwRE17s2vWpA5q2INvf7HR07Zo
 7cP/0UyUa3YRtqdZB6EWHNovQgJBGBgl13qXssrSmTw1xMJoJnREiALxD1Ssce/WbNjb
 aXI260N095I19vxABJBWfhmHHYSQo0lHSiGp+KFcYyz3fTC6vu1UL0GMYL27LqyptQ5O
 Qc9VIdSbWDP9PnNjwlYyWWBXmzQEEt+HQ4lG9TKZhujbnloeXtBl5KNzdvytSKNIw4OD
 KQs0oN0bjcuyhrhADd6BOWNxkjf5G9naNP7xNPIFwWxYTgXfhiKH+FZedVRgPrCPt2rf
 5NKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xMzfDdWo0ZbobwvhYL+QfEr7jkf7L5HHwABc9Q/vj60=;
 fh=j917MWWsRG+DvVp5pFOQwh9C74wshAREk9+89aibhUE=;
 b=ARjIAW5hbGnJdK0vlNM2jlCa5c+WT52iuLXY081zbvmOmW3+O8Vw+0PvMGH27kcejR
 923z6R9rV8p/t6nc3UZqSB2L6xk7YDNFinqmtRR+s3r57DhilIFSqXPuP1o0z1blR4eu
 wfnGosXlBcV99F+SMCOIAubqYsABp+X+lwo0VYgBm+RZl0ZUq+L6B80DTp8Zz7GaBQsc
 88ndZPqQ2gqbxQo7oLGz+DJE++AHHUTpHNekKfiW23q7BJHFC0/gR+6QfLDtwmSdItPN
 eNVLq/gHg2tys1vA5n1/Dl9vh+ZBqRUNf64pTzN5t9+8/DWmITmnQl3R2OKkapxToa9h
 o36A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907222; x=1792512022; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xMzfDdWo0ZbobwvhYL+QfEr7jkf7L5HHwABc9Q/vj60=;
 b=XUXAKt6UUUwEX3w++2kZVGJJ0UchFATu2qGExgQM8fwFQYtvPABMRE+fHkZf0rz2pR
 Z1EMLOj2+Z7UD0/yt/Nnc5DtFcqfs6ArtF13qr+TvRi1xz6QbfkraANZhZvEQZo4m4GR
 Hym1NNYAtneNUa88tP7zTz5EdAg3QUPBJTRiqPb9nWCQrpmbhrGziyXh2mqaQfl7gvkr
 o/g0TCZkh7cPFMg4wLHJ/KkbntnF/kVDbao5ehaHc7XZAYet9qIJ/UWd3Tzpoofw7kmN
 4BtqfFtMMstaqRZ56uQBCSkxWok+t+XfiCesymV3fyJgl0NFdYT8P/VP/fYQHiAE94ff
 wLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907222; x=1792512022;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xMzfDdWo0ZbobwvhYL+QfEr7jkf7L5HHwABc9Q/vj60=;
 b=JtjGW1y8nbBAyplWs/IEmIx6zNMPFF3PFAa7+WAJWPBWEWk6tf+/6SnQiqI/WV5IhY
 O2cM/FXHNBsAN+0mOlP+ZGbCgCii2NyJyLm1671HjfONu+awYwyI9/jB9ROz/EYDzGH7
 YBLrEUrkRWJoSM58OIVgc6q/EkfOLwNKZwDxXf/R7yQX+S+4dw4ardet8CWwxvS5BE/3
 hXrv3yTX/HwpWuxPaIAngNIzINTAKZ5jUHreY76juY9hgkAbcrvTRFWq7RaTsZZ4FQ8J
 qizQZ4sEJ8pMEhsR767qfl3vC3szC+MDw4qy74KXUikThPHzZJfqC6y5FB6bvrK7dNLA
 C9Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0+0NMzm3XVxgdrRWk3OD8hAxy7y+9+GCbhkWgrw112ATLVkclMINcaF88vF2Bz1kXSxmEPWsLC3bB@nongnu.org
X-Gm-Message-State: AFq9FYLotgzK0A38BmSNlGFNxW7k/kyabHVZeklLDk5o2+u/95b8pBHp
 Fa+PlwoEXmpfzcZOn/M2ZRIrCg4G2RFvzFTOKjtWe2BtXPD+4oFJl9uoRlTGUvLFVWMnvT1/esS
 KTXXXl+LrMzrRUzVNnj3pvsNhH2+YQ1awokKhKAOPhg==
X-Gm-Gg: AYBFou0n68pVdhgFim17FunzuuDo1BmXwABYe2OURuqSwt5sCR6MkrUJodMFPhGOPbz
 L+t7xPEij19nC8VxBYk/iLAEq/AmObCrPcvBXGYShTKPytalmHP/LX2hiQoASLbUTJGdGMJYyT7
 uCEFp7JyZbnt+tlWP7Kr3jE+MPhrbyEL6E0jdPs0vNE6yhHZqzxR6zPH/GMchBOSssgev+ZUQXn
 Y0c+23MPIAqHSrYX1ZNjKyFX1fYfr55i+beTCbzVNsDFHobhKe8b4F8MhhOZN2lf5ZMcLhh8mjS
 k6RdBsoEkLMPH4kG6XfPnr5s9sl3XhYzDWGBh7/K+A+mGatHKBSIxio4oo7MyZ76Yn/Q6rOlcG/
 UtXlSdNwxEU/wEbk4siJCGvhdCshXKksztnAL5ac=
X-Received: by 2002:a05:690c:288:b0:8b0:9e24:4005 with SMTP id
 00721157ae682-8b09e245129mr22462247b3.48.1791907221988; Tue, 13 Oct 2026
 09:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-12-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-12-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:00:07 +0100
X-Gm-Features: AclHuK_b1CfMObf1rI66LJo21oLhOivp2sgnhibZnkzpTZtnhEkqg-xP9NavG9E
Message-ID: <CAFEAcA9nfB5ajh1L==G2dSD=0vZY4ZyZSr77rt3OUAH_CCLBkg@mail.gmail.com>
Subject: Re: [PATCH 11/22] i8259.c: convert to use DEFINE_TYPES() macro
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

