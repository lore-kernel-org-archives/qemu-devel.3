Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5127EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wts1O-0004QS-76; Tue, 11 Aug 2026 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wts1E-0004GG-Ab
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:20:13 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wts11-0002uI-Jj
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:20:12 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-82e475fe54eso13006517b3.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 12:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786475998; cv=none;
 d=google.com; s=arc-20260327;
 b=DAtFEpusIT0VD+K7I39yZnMk612RV/TVN6DOGZcvdJrArkkiUzseWdEHAdV3v+bckp
 8UNMHEDTpAdePKEB0qLJoonmhMFfIFhK3Ylk/XWRhgUgt1TTsBzUIld3H1p3XStCMsbh
 Rc9wQ58N/IbUsadYrwFW6WMn7XypAoPbAVqqyyC4frhOp+7HV+AMruVm1pyPuF6JaCYk
 v5E7oRVW6Pflh8Fa5mkbzDydZHBO/+ydgmfLW5Uq3FqVLLnQr22l3nw2cUD1MxwtyDiq
 q44srt/9aqVNNqewiQGDHPLBsOFFmB9VcZ+Y3ANogNnGSgbllus7l6BdXvgn/P7oCL6U
 pS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ck2+EZEV//Hl0+aheEqyH4zRQjE4nqm9JXtuPSBFCEA=;
 fh=xaF6fTkH0sgtp/jxDlNhwWHFix3ixKPjSXk/Wx2Zpjc=;
 b=EVZL3+oG12J7BJ0dQG/X6EdeguYqocOSx1FK5l6f+nSBASlxT0YL+NRaCPFgp/sJyk
 pTIiJDEJd/5m6iQDx0fDc0EdxMvLNzAKF7LfqYtU5AIoB/xxBBZyzdhjfuJA/YLk7rZE
 7rmC2eZbLQ0UtQOeKqXc1J3DOGf4XrFHRHn81PXXuiJA6PSAV/CgHNu3xCTwIBP2WLni
 Lv2iPWMhaGQq9u8XzkKCTDfc+koRT1lLdLg+IDx5nEoG49gygn4YvKcrLZx90IWxAiHs
 pNS91AjtGlGSjVm0xN5iXdmwNBqSAs5Sxyv2IwwVB4Vj9PFl/3KA2CD8SMhyWjW/qiwA
 uj7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786475998; x=1787080798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ck2+EZEV//Hl0+aheEqyH4zRQjE4nqm9JXtuPSBFCEA=;
 b=H8d7vTsOjCnqAKmjrY+yaSxKIY5rgwat96rj6LqkzAVh7TMkBiz2OSHm8qvs/P/S6W
 n6PPapzu7Zf+eX7ScyFHxHakWQVWDrVJZQoR7ROBuZ9tQshB14X14KuYVLmxfmBebWY/
 zPy+iaGCXtFDI9s0bhmRtbcIodxlWGJSNfP9xmsWHONyRCaND9NT2PlM2wZrlSQwq0xb
 U4phu/vVs8DhcyhnObkwcwjOBWr1eQ8BpJy2W0tpOIVujskwiMqLKfs2xENNluJm4PZQ
 HIYNwpAxOy5WmftCPtD71/vKbLffSZ1pPcJKVs4ib8Onz3sAnvNPm2mmh1W/8U6vf8qv
 PeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475998; x=1787080798;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ck2+EZEV//Hl0+aheEqyH4zRQjE4nqm9JXtuPSBFCEA=;
 b=JIDsplHnv9wyuyt1UHmhjr1vkWth/4MOk+ie5ibTE5MtLadtNcdOk9myZe3Rctdst4
 Rb4TEJ7b5Qu5AgwqfSJczTR+Mpl97J/xBdTpZlYl/0lk5wIY1CqRzpBfYj1McAr9o4Mo
 DV3+wA+x2JXmQl51qIiNH100f1fYyz5XrHd8f/tAwGb6PPpvJKeDPh8t8j1nOrvUQqK7
 07Zm94hoDeLCO+5sIlTohXIG+/QWLP7dFuJ8jlrQOJdKE3UsWIoUGlxfuz/HYpIRcQat
 OfXcaNcznqalH728iNo2+B4bwfP5+mpsldChiLgGuxJNWMQ0cq5eJC2Au6yHReoq2KTl
 VF5A==
X-Gm-Message-State: AOJu0Yz2hsx+iCVDCzVdphvxM8Orjl7xzbJezzAjesu9hP7xfsNvD1fW
 PrA5cbfKXW9hpIU19ffsnLxC98U84FHNv6+EIMOG6moAD+D3S4bZm6kaMgNLyUEP0pwUbj0C7W4
 ctlxYSajds9ttSDXPmBsfPB3Ymqd4+S9hxomvfxCfMg==
X-Gm-Gg: AR+sD13Sg+9fa/zKJzQDsNcWh1VcqepV5EtCZyK1HFfnM6miZL7pxC8dpxt/MH8b7vU
 q/xtn89d+pLPOacOYSzoGngbF/mwb41qWN2RpGzv6k4lwKGEtm1nVu2M4cl3u6NGr9Lv0eSRdPe
 z3JOa7EGcgTTfDvzOB/Zw4PUuple7A+wjzIhiqqSfogkt0zvbYhfGQhIyrMGV7pMuBIlhfIG4TU
 jfFJ/bpuYh9f/LH+TRJMBttjRRfwBiARH0YjrIplOpgkaI5ZUM90Thdf/2cdqrLQnzx1Bh34Yi6
 QcsXenCmK7iNhI5C3gTZQWLd1Ac4cPqRvM7OArXMy4ggC1Fg7tw1D5mKnYaV21IxPzr/nB+dLOu
 FD06IZpUFdKzlG1fah28pDxIQjuPpgGF2a4hRtZY=
X-Received: by 2002:a05:690c:60c5:b0:81f:2abd:4c0 with SMTP id
 00721157ae682-8304dd1de8emr18631677b3.4.1786475997993; Tue, 11 Aug 2026
 12:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260811183144.190135-1-stefanha@redhat.com>
In-Reply-To: <20260811183144.190135-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 20:19:45 +0100
X-Gm-Features: AUfX_mzBbOn7Ofe4bDwR2xfSRBhH3XogHrsAJQmouzHP4MErOiZlOuooLEtZ4gI
Message-ID: <CAFEAcA_W85fsif10XV4wKW-KT_t8kRVbUq9vgDPNH=CsQGubaQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.2 machine
 anymore
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Darren Kenny <darren.kenny@oracle.com>, 
 Alexander Bulekov <alxndr@bu.edu>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 11 Aug 2026 at 19:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> As of QEMU v11.1.0, the v5.2.0 machines are not usable anymore.
>
> Use the latest x86 q35 machine instead, otherwise we get:
>
>   $ qemu-system-x86_64 -M pc-q35-5.2
>   qemu-system-x86_64: unsupported machine type: "pc-q35-5.2"
>   Use -machine help to list supported machines
>
> See commit a35f8577a07 ("include/hw: add macros for deprecation
> & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> cope with dev/rc versions in deprecation checks") for explanation
> on automatically removed versioned machines.
>
> This commit message is taken from commit 9eef3854d309 ("tests/qtest: Do
> not use versioned pc-q35-5.0 machine anymore") by Philippe Mathieu-Daud=
=C3=A9
> <philmd@linaro.org>.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qtest/fuzz-virtio-scsi-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

