Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2326AC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaqe-0003Wt-Tp; Sun, 16 Aug 2026 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wvaqd-0003WW-DD
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 09:24:23 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wvaqc-0007bP-2J
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 09:24:23 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80cebd41372so37813977b3.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 06:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786886660; cv=none;
 d=google.com; s=arc-20260327;
 b=k4HlL3Hdz3kx4n8bos1c+OxElrdnATzWD5QDvEaElMVWBrkAkxDr85ZY3A0MXBHXgx
 WzmZrvd2Y1hxFtd0/V74N/vSH1rhHLnSzfIPJVarVFoJONpwujwouK9n4ZwIq1+1SxcS
 djG2CriWc504k3KzVR734tD2WXkIjTLtFxcqk2M+hk0/aXGFvx4uBkzcfmAe/uOQYeqV
 2geusyn5Umr1qjJwF9lwZItDcIQ66Y/NrgBb0rd1utTpJPLAqZX/ywxdwON4wdvXRKsS
 QA9yacWKrV8NBnieyVJGw72k7sC/8xgAVfW/qRko3/rkFuXlCl8f2CkX7A61fVEsRDDz
 4UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ox3VbeM1u2jQWUSElzMGWlBfzXD9lmGGaDI680VJIjc=;
 fh=DLsCS/inX+RkvRQxwYBFfNhxsDndjb9n6uWalY9lDOY=;
 b=TH4RPDr5aGJLCRqA/Gks9Tez3/R3cJjqQ4+/KY20rnhrQoCZdaaFCPX3KpMslnjaMf
 qBvlKR/S7m0AZFZHUmLOnI6jUMwLonbj+cYQgKONoRYROxFdGS8fITkdqN30ACp1U9uR
 nJvUQsjqUN67wc/ZotqHsGIHIYR8bTRNjwRWz6B+//f0RB3Lzhl54naLaoHL7T2xYefI
 xO+HSJo3fxyuq1BrJm/M3XPSi9kUqh+cIhIYO+nkcp8NlFxWPTVyeLYxoJ2/OGGy/KzH
 0gp2fz9wJnkNk3uV/gCFimbnoR9Sknz6YH+6XiRBDoqiYGW6asvrEo3yjUOTvMoYPgXn
 +p5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786886660; x=1787491460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ox3VbeM1u2jQWUSElzMGWlBfzXD9lmGGaDI680VJIjc=;
 b=RAYncfja3BL52updb0VawJZQWl2Y98oagvs1KDUnsQMC1JvIfyZhnwsxMLcF9AgAZX
 alt3SvshVDDbkn5hCIXAURtom8j5HdMGLXOG+/BeQdT9LNOnwZF+FexzYAzPN50IzfHf
 AZQv0FmA+mBhBk+R/hNNmcLlgtzBaaYIn4Hsg0FW1OuBLKtSCvWWwDEYTniSDI9zEfCc
 ToFeB6RpBeW6p4aMjhn82fFvdQzrDTm3gFaSS05IPQi7kSlNUpwZNRK8FJh/+y/hoBy2
 TVybxElXriB+r8nrkidYbCKDtHNjj5MsSm2XGPov+GjKS4uoFjIcDF8PvAmgaLgJig/q
 fVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786886660; x=1787491460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ox3VbeM1u2jQWUSElzMGWlBfzXD9lmGGaDI680VJIjc=;
 b=F5KpiwpIRFgVWgwjLF5dYRBxdVUH6ccqxIuQFpBcQWs03fbYvIL53CtmPOada2+EuA
 qzk67XzymvnowOcE3ABy317KkZfTKzmqjtvKIne4qrajBZeDHaCLg4UcAN/c5CnjkJga
 +LnxZWM5egp0CubhHd2PzYjwfoUAeXzqwanK+CN1+2ip9C7Z+PsnvQzSLJN7jJngqcHe
 cdzMHq/iLR+UlF42+2O0G+F3EBdvz9XYsRM1GNaKwpCeM35ym9LV0j7oS03AypY7Dq9/
 +QK4RM2bKfmp5vxq2tHmc8HrpGgwl7QbKFVpMO/0SaP8UiYb0jyLyzl2V5j/vqsbFFhS
 8aKA==
X-Gm-Message-State: AOJu0YyHGKQP1OoLBkDwvo4XPbgYsWxb5/w5Db5EFNtIh4OsMb8Tcaq5
 Cmwy3TN33iteqmmibRkjRh0pCX3/CTPj97eKuHc5QCb7jQc0P6Du2O5Isc7hcakYOFOYEsjYQnA
 1cihizDvYbxna68oVM+u3dvjAmHUpNhY=
X-Gm-Gg: AR+sD128Fez7DzBFyiNyilbXrdIligX1kL+fFl3qeTytJY/KLD4C/9LynAtvZwY1xEi
 MC5mBGO2WChKKRKlc4vwzYiRcv6TUv45cU157jMUkYalsJQjRFIalYafjHiw0Hkh8q/0f3KURve
 r96NUA/7bnwYtu27J3gBg5746c0gVo9ePOHX44I5hls4PBtX50Bv8f009l9kGjSclnzEojlRCSw
 V601+IgNSTzNM0Smz8QwVcqLn0I6MjX9JgQp45PlCujQ9jPMC7IxEwsBoVYS/0CqqU9X3NVQvZx
 x0BDt3KQoHcd2QQqlxKt+WiGre/5aYNKruLpnpk6RlyQM/SnWihe
X-Received: by 2002:a05:690c:5884:b0:81f:650c:98cd with SMTP id
 00721157ae682-837120f2d58mr46179157b3.28.1786886660422; Sun, 16 Aug 2026
 06:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-5-flamboyant.h.01@gmail.com>
In-Reply-To: <20260808182956.290561-5-flamboyant.h.01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2026 21:24:09 +0800
X-Gm-Features: AcwNN1VJBr11-OJJFw6NRDtSX3pBflzN42xlDlFlE_7igUV43bSMp2TcFGlBZSI
Message-ID: <CAEUhbmX96k20FrD38Az9B4_8w=s8G1vss0qk65aNRFqHFwc0Lw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] hw/riscv/k230: Route SSI interrupts to the PLIC
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Kangjie,

On Sun, Aug 9, 2026 at 2:31=E2=80=AFAM Kangjie Huang <flamboyant.h.01@gmail=
.com> wrote:
>
> Connect the nine interrupt outputs of each K230 DWC SSI controller to the
> documented PLIC source range.
>
> The TXU, DONE, and AXIE lines are wired to preserve the physical K230
> interrupt topology, but remain inactive until their transfer engines are
> modelled. Extend qtests to cover TXE routing for all instances, RXU routi=
ng,
> and instance isolation.
>
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  hw/riscv/k230.c                 | 36 ++++++++++++++++++++
>  include/hw/riscv/k230.h         |  3 ++
>  tests/qtest/k230-dwc-ssi-test.c | 59 ++++++++++++++++++++++++++++-----
>  3 files changed, 90 insertions(+), 8 deletions(-)
>

Please squash this patch into patch 3. Normally the instantiation of
peripherals is done in one single commit.

Regards,
Bin

