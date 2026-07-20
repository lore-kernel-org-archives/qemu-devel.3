Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C30C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqlW-00010e-MP; Mon, 20 Jul 2026 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlqlV-000104-3U
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:22:49 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlqlT-0000yb-Bl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:22:48 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81e6f0b4610so108276337b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784564565; cv=none;
 d=google.com; s=arc-20260327;
 b=VcfbHqFBFzCDqPVF9ufKi1Wb3XawvAftVZe5Cjh/y9/XKO9qRhqplZcuZyYVb8UrOU
 MNZbcVX/EEDmEJ5zYLK4ISmWP1+owfMVN3mOhB1q9bqj6UmFXi0RX3qE7O2Exxv5CLxH
 3hL4abxWRGff1/6qQmgUGzF1G+jlqOQozqpVHya2LtMlTvrRvtU/CQFJnou9ePajnqFq
 ic3dyd939w4q8J8vkHxCtaoRL1+c3ROvGI8h29cmQAcvFpqTW7IR+oZhlNaBZL3vyJce
 I+gWcTBTUyiCblWymU3MMLanpmCZTQKy8vZuzH9/N5/7xAnZBNc+TQTAkDHiCEOgBC2S
 rdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t2yB26j6BS7DuZSM7AsfsgUg7fMejF06V9OSY+aHvf8=;
 fh=Mwuq573iCp9M7/4LHhrrdtS1U7mxXVvI4mYPg/mZOH8=;
 b=eIa8ZoNuVn6dlZkqWxT1wLKo60Cy8Qmqk0I+h17EefxX1Ts9RAm4j2/AJSe0tZ7tGS
 FO2rERpyocikUSDVX22bE0I+k9VpyJJyu+C10gGxi0z8pay1yfJlZBUonmzfgONALNix
 waiFFyM76iB6sc26LqehcQM+IkCyJzpBC6WiUnTxmkzWUxRtSIjhu9McL9hgVUkMoNot
 mp0fHYNsQ/SV0NYq/A/ygUoOPHxmojKx0MKg1fTzHRrFCUZCbkccy1k2L7TvrGzrrW23
 sSrN/Tfj/lqAKfEdpUjti2JmHU4oXYTKmKXfS6I5MDQhEuVydFA4vQ03CYnBlT/UzHa8
 6OPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784564565; x=1785169365; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t2yB26j6BS7DuZSM7AsfsgUg7fMejF06V9OSY+aHvf8=;
 b=urMwwTgDWFHbo8S9feYpB7FM1FJMHa+PwZhJT80rWu/ddxEn+QR1QJpwBFwahgiZyV
 u7dMRVrj6OPT8zcBDkrZo3uSJ5QngbeVkj9sxOL/pp8p/TXLMjL7454V7eosJcuTfvnV
 oq5vwa5ideZN2K/MZZsdhWoeqUw9K1taRO3v89SeJjN0esVCNJnk/KFQWIjmCiEuCGMU
 t7RliZO4LY5Skc0Uq2qx9QMc8UKG+cY48ZYd62nWM2Ck9DhPi1UCbmT7b6T7Mx5OTIbl
 flCZJ5gUlXvWiSiUZEs5gmvUEct/w1tJYghaEblKTyuBdjj/xOBnmBMOzctIpkoXF9Rd
 sF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784564565; x=1785169365;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t2yB26j6BS7DuZSM7AsfsgUg7fMejF06V9OSY+aHvf8=;
 b=pnGvcipsC8mheg7Whj+D3wum0nxNL722uCRzwc8CTpqcJO39i+aVxuWIxhIDAgRL8r
 RE0cb0vO9utBOTwvGCzjiQm9GW5Ri9RDwSSoeSP5rMWh65WNaXIPjLZQXdBsjn9zpzHE
 WFnZj9zlAYYLTeXlk3ZcL10TkkUt0X0yymaKkb7AQGovwCneXeD653rTF/KA7nCjWxxM
 ZBNfL1CL8f1fBOQ87S2bd7uxElpCBPJmnfGM9fGapuuHuvCiGkMtLnlK3MpVJqGNIPRH
 O5kFIbC4DIDs9+UPR1WzwIZTHaczzBKYLRUCdcZKOx9lZ4YwRrtnVBkwMHNcwmOrfTu6
 /BJw==
X-Gm-Message-State: AOJu0YwI9YZJ564jg2juVLVX6LwVhmlFDFTYeKo+dptz7OPhxTESmmtL
 ZNSsnREnJtPxkbWXPqsZy/O1cDRMjRb+4dNJkrhHwDt9BAC72QLEG8H5x3DwlIY591I3ThlqoeN
 NfUVkB6wOXvvfvu5HdJ2FrGS2kKXfHZ2C+ytHcgg+Ng==
X-Gm-Gg: AR+sD12PQHSt+pQVqZGl5dag4ejM+rK3PKfGqEYlgEZh6x3OwhNP05q/YuEs3qOlVq+
 ym79xkOtM5Y78/SEfcSKU7MopU5gfzYpg2OPaW/gaBuQ9G/teGv2Aj2wu35zib0W2m6LJtH2eGj
 xgIkMcoX+LKwuyi5GRvPoRq8BDT47KkLL9B9+RA8Lnds2brTKO7KSc8JcpFGpg/Y0PHxGrju9Wp
 YzKSOe6bh7/ofv4e72uaW2+HyvEaRbEfFyVjtf+7ZAVIEOa/txnGLYR06sY8dAAuPRAxFvB4/GP
 6BKlec16TMp/qCLTn4rD+dtnwdDDN93iYXLlgz9gI0tCtw==
X-Received: by 2002:a05:690c:9c0e:b0:81d:fd3d:ee55 with SMTP id
 00721157ae682-81ef26f099bmr46446987b3.62.1784564565266; Mon, 20 Jul 2026
 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
 <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
 <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
 <CAFEAcA9t7TjhCSZ1EyBOPStu6vadq3UA9FMgbWOqkqfM0aMDoA@mail.gmail.com>
In-Reply-To: <CAFEAcA9t7TjhCSZ1EyBOPStu6vadq3UA9FMgbWOqkqfM0aMDoA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 17:22:22 +0100
X-Gm-Features: AUfX_my_WRLTve7Zwsb-upeL3zNHc-h6HKY-YI6QVwubTVDQt7i5Oi1822A6-vY
Message-ID: <CAFEAcA9O4naO3WJXYL_qCZAvoGRchEryFnBHMJm-MT0+CjH=aw@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Bin Meng <bmeng.cn@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 29 Jun 2026 at 17:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> I ran into this from a different angle today, and I think
> qemu_receive_packet()'s check is wrong currently, not just
> with this change. Although net_peer_needs_padding() will
> almost always return "true" today, if the network device
> has no peer (e.g. run with -net none or -nodefaults and no
> other network backend connected to it) then we won't pad
> packets we feed in for loopback, and so the bugs which
> commit a01344d9d78 is trying to fix still occur. I'll send
> a patch to make that change once I've tested it a bit.
>
> I'm also looking at a variant of this involving vlan headers:
> https://gitlab.com/qemu-project/qemu/-/work_items/3518
>
> In commit 63b901bfd30 you removed the code from rtl8139.c
> which handled padding out short frames in the device's
> receive path, because we now do the padding at the other end.
> However, in this case the padding code in the device was
> also handling a case where there's an 802.1Q vlan tag: it makes
> the buffer at least MIN_BUF_SIZE + VLAN_HLEN == 64 bytes, with
> the comment "Include some tailroom in case a vlan tag is
> later removed". Then later we use this to avoid the copy
> from the buffer reading off the end, but now the copy can
> read 4 bytes of data off the end of the packet into guest
> memory.
>
> How should we handle this? We could:
>  - reinstate the rtl8139 padding code
>  - make the generic padding code allow enough extra space
>    for the 802.1Q vlan tag (so devices can assume that the
>    frame is at least its minimum size even if there's a
>    vlan tag)
>  - have rtl8139 special case this

Ping? How do you think we should handle the "short packet
with a vlan header" case? I think I lean towards making
the generic code deal with it.

I'm also still very unsure whether our network layer is
intended to distinguish "this is a short packet that we
padded" from "this is a packet that the guest padded".
Is a network driver/card model supposed to be able to
opt in to getting unpadded packets and then identify and
diagnose-as-error incoming short packets if it wants to?
That would mean we need to distinguish "we padded this
because the guest sent a short packet and we don't want
to deal with that in loopback or otherwise" from "we
padded this because it comes from a source that hands
us legitimate short packets that would have been padded
if they'd ever gone through a real network device".

thanks
-- PMM

