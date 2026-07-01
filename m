Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B20C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes8B-0005sR-98; Wed, 01 Jul 2026 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes84-0005s0-2l
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:25:16 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes82-0007tl-48
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:25:15 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664ee752958so603858d50.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782901512; cv=none;
 d=google.com; s=arc-20260327;
 b=dyg7Jeg9uihbNjHhRZrgvT6X0Utmk+P0Dd+bWJjc8WDFxdqZJQgSQqzIIwgWcbqzZu
 47eTn4LTtnrw0trVbN794Nc28pgu/Zvr0dNPaLiVJ/+6UnoOqdEWc6/gS6eZicmsYFaZ
 NjET2PMVOLilvgfgnqv/wgFwAAHtiKLDolYhlBuWDu0mAheXi7s4tyY3FLxPcgDCvAI0
 fct1Y1LiUnpG+jHR/qzl6gxJvIKRJo0ikH3Fdevdb2DeKX/fcGVXLt6mwxMcLEDsTdG4
 qGHvf+WoC3sVN//G2+3SNN9pxDmGIBV+VVhIKskmNxyi/LQyyYPwYLQ8whrhyFcJk4N8
 Xl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xQLo0hDIXulcD756hs4Oy93bwjo27YDw5J1dssXn4vc=;
 fh=QuZ9/BSZ6wXz9VHMgGKA6llgU+UYbsb3suA74w1Y7Dk=;
 b=GMTfMNZ61+Cb56bZXV/HuV3SnWQhsdX2YtNqzwgeE7A8NLRxXhU77zL3mAvQx9c2/4
 n0LA2EWTxWSw5VofeKXVuo2063FtoKr53262oS9P8FF/0aP9I1CWlmvMBp03ztw3NL+I
 fawpTbWgDHeGNndr1G0Df9XPnxJBcnb7PDZ3rFfvvtpCf1sSdU6iCCZaZUwyatVfdjE5
 HO/A2Poc4z9UOjJYngARdnNLwvzG6+gSMrdXS6E8wxLLTBRjOZ5qQ+QwWbiCSJ/AI0Ke
 2D3NWA1xGNUgxkNOiKyploM+Mm0nWxEd33j/l+4GMiXUyLbRFXffjXa5SX9oTY75TcHH
 9ZQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782901512; x=1783506312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQLo0hDIXulcD756hs4Oy93bwjo27YDw5J1dssXn4vc=;
 b=mFOWpexko/mmf+dNF0wmni1onGf2XXzkM/cb5YzthvFsYMY5K92bOtHsdcnPr3jtSh
 P0iA8IMvFfiPY7aKlApXCBFypi7JUme3rkkNtWYiq4I52qThfPoiOAf+Yx+pPfFUjO1t
 soisR4/wKqTNt42i/timXlhJ5QXXXuUD2ekVZ+PjaKw3CL6F/EmeklQkKKPHRnz/Yubt
 7czZ7QQsYKySM1KXYb55FfJ4KIgrjYCSPSIoB2GwN8+6fmvg05Y5LaqwlmwdmpdE0D/T
 BNwHBglyPTWMhiFP63V13Ifx6EiVth1b5m5gBaIzkhHT2EnIqKE115sFpzgLKing1bs5
 V3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901512; x=1783506312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xQLo0hDIXulcD756hs4Oy93bwjo27YDw5J1dssXn4vc=;
 b=LLl+DIhA7wNaB8UvtrbhBCnbgZbrvUlQWbCp3wFFBM2Qk1d/lhT4JSSyLLNnDdIqt8
 miEvNJu4TqJFslk1YIDmZk80rrv4KZvANqbmNCmRko2328oyAYpaObXMO5PwNZJsdDeS
 jNxvUpPZ3Po6aHTbNSjKOQ8IkQkyPEIAuIlS+0LXWs3zZQ6xyAl8XziCj9GUP1jtDW5Z
 6+bZ3uQhrZmv21qYZimsuqn7azrfTmzhooJrfJi3ypWLIrRJt+/wQ1bI2iSg1DWTQSgE
 /X7jeC5IXYEFqXMardxxH27/Jg9fkXbFbHZVlLXD0pUANQaEfoKBvE9hP4Toh2srcGPh
 lK6Q==
X-Gm-Message-State: AOJu0YwhyoIf2sCsKQF4dloZlL4Dd3aEqmWm1zDSSY6td7HwRVfzTV2W
 /yZmEjNi/OfVAjm2ctEiAL4qhavq58RSh+5IpMd0K1I6cVmKFn8axcAxvj7lOk/SHluoEi8RPLE
 6xXbkxJsfhWD0/p6ZTJHddiZP8uOcmULZ1TnQH3MRSg==
X-Gm-Gg: AfdE7clt7whRGac8fsi224KoAnVZKqxtSF3k+uRNElUSi9Gw5v1qvWzKJa8mNnjRDDB
 YWBNMXMZOka29QMq7Z8Bp84ZR60XkxNH+vdPgIpxcCU9Dsuf/1g2W8mHS4cvfEscC429h7oa6b5
 0dSQDC6jSsmMXzthwWa7bKYHXjhz8AOiUh1Tz9antnMygvVbS8HJVgMsNhtv7JryGbtf7/zbn4w
 JXxvmdO+p8w19eL3W3nhff3JalHG96fMvlQAbVVaMpJTsyxmTVaL9ASmmr5+wav8QIC857R7n5w
 glx5aqHnjqSrmwb6ZHn4cCPjWxltzznXphkRN5vWt88/pzqM3LQ1/HRT
X-Received: by 2002:a05:690e:1915:b0:664:c7dc:64fb with SMTP id
 956f58d0204a3-66521a39e2emr991083d50.29.1782901511951; Wed, 01 Jul 2026
 03:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260630173245.2070268-1-clg@redhat.com>
 <CAFEAcA8G2sti8T=u_Sa5HSSNXAJfJMmbv14PVD0y6yn1wDEaHw@mail.gmail.com>
 <25ee74ac-1ccf-4f91-9ed1-3c9ca42a92ce@redhat.com>
In-Reply-To: <25ee74ac-1ccf-4f91-9ed1-3c9ca42a92ce@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2026 11:25:00 +0100
X-Gm-Features: AVVi8CccGoavJup1zzY5tow22AQySYZjXFjjSjPi7UhlB1Y-BGtxW4ctnFLjKhU
Message-ID: <CAFEAcA_6ZLF=gnM+LB-Ep57ZZi41zuXb8MfYFKn-rrVndFGuLw@mail.gmail.com>
Subject: Re: [PATCH] platform-bus: Align MMIO regions to host page size
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 1 Jul 2026 at 08:34, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 6/30/26 22:03, Peter Maydell wrote:
> > On Tue, 30 Jun 2026 at 18:33, C=C3=A9dric Le Goater <clg@redhat.com> wr=
ote:
> >>
> >> On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
> >> place device regions (such as the 1KB "tpm-ppi" region) at offsets
> >> that are not aligned to the host page size. This causes unnecessary
> >> and noisy VFIO IOMMU warnings when starting VMs configured with
> >> passed-through PCI devices:
> >>
> >>    vfio_listener_valid_section received unaligned region tpm-ppi
> >>      iova=3D0xc005000 offset_within_region=3D0x0
> >>      qemu_real_host_page_size=3D0x10000
> >
> > Why does vfio care about the tpm-ppi region? I thought vfio
> > was only for passthrough devices, not for normal ones.
>
> It's caught by the VFIO listener which doesn't filer per device, it
> covers the entire address space.
>
> This is a benign address mis-alignment warning of the tpm-ppi memory
> region and VFIO simply skips the region.

That sounds like the problem then is that VFIO is warning about
things that are not in any way going to cause an issue. We should
stop it from doing that, not change the rest of the platform
because its warnings are over-broad.

> OK. Let's extend vfio_known_safe_misalignment() instead as done
> by commit 851d6d1a0ff2 ("vfio/common: remove spurious tpm-crb-cmd
> misalignment warning").

That seems like vfio is gradually accumulating a very
specific list of "we know this thing is misaligned" every
time. That is clearly wrong -- any device anywhere on the
board is allowed to have a non-aligned memory region. Those
are totally normal.

I think the vfio code needs to change so that it's only checking
the stuff that's actually vfio related. Drop the "we have a
whitelist" approach, please.

-- PMM

