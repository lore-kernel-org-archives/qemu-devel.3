Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3131AC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEu4-00053n-P5; Mon, 29 Jun 2026 12:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weEu1-00053C-Jt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:32:09 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weEtz-0006i8-9D
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:32:08 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d910cc75so1276866d50.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 09:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782750726; cv=none;
 d=google.com; s=arc-20260327;
 b=gmbXMO0Rb/ar4Mv0tMCyuiuQvIrYUbxJVuFurfs5db5Zw3kpcONezfrwrWtD9TlK/N
 sca4JkpXeiI4a7RFcssJFf5RY1XVB/B2erGPHOUEN7s10iLAt+M7lb27fmTj3G4pnhNr
 x6v0KMReNPDfrKKsoqOEWSmXcAGdtsycnqqGtSYUKqfgGche/A3HaSJpdSJ4jXpW/Btw
 UBP7hGIEtTlXnyX5lMWmFPVSCU/oKCsM0MvMuH1XxkcehrHNenlSyN/YmCtmW4UfNy1N
 KHShXHL26RJ25CzFOU1cP8PjQDDcZqcFSP/5emJWHplKr07CRs3cEL2iDqciAB4CAjjU
 WEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CsxDffXUeCaOjHzm8qnVo2oQrYVXE7D/t2J1E+A92N8=;
 fh=Mwuq573iCp9M7/4LHhrrdtS1U7mxXVvI4mYPg/mZOH8=;
 b=Gz/r4EcIym4hNjnnnr/F17/bU/JyBtGEmpBs+y/8ZPa8hXN/nVYLP8dBe/irVXNaVi
 GhX82M5lxIX1WxHhRo+TQHZ0dFQKX0ujlRnq+S4FXgFfgNyqmUGXhUj6diUv5eYvtrfw
 hoOU0nndd2ouzdaOhOyu+OML35iKK0QdZh1YMF3uGPECPxtX1HeSnE4qfWWIXE5NXbSe
 Y4f2kh2rsp5UhE1u4k67jdLwZ9puN70VMGUDNDuFUy6RMswIhuL0Ddtf4b2aKtON+vjl
 qmOpJ0aSE326hcdlcOrFHqWV4DdYDEmZFOARl7ea0JciYNFOHJcf+Md/w2Jz4T7U7FeT
 TbWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782750726; x=1783355526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CsxDffXUeCaOjHzm8qnVo2oQrYVXE7D/t2J1E+A92N8=;
 b=k/5rEyXM3zkQVwjvMy2NqN2vS7QMinBFmgtOfUqZiaXNF4z845CgR2Z5Z/InNO25aQ
 0M7k5Fl+WbW/hbI5xCMOm7h7idywDbMgZdQAGOtCux5/M97YX+OJ73WQRRE8wY94x+ee
 wUjskvxU1xjJrnOPRKcgUKnXuD4unmUPuL2omVe1zLs/nCh1X7nFsZz8vJN3uwC/e+hG
 CgCZk2+JP3VWoiPhmgnHP51azcnIbd1AKMie8rJ2iAnuj5GQ29hLZoLby86APlFpsNR+
 APMUzxrixANept4taOl/Ad2NFXVrx2Fg+ghKg9ZN/63myUwnOWl7lkybrjn+bAa9lYEn
 tDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782750726; x=1783355526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsxDffXUeCaOjHzm8qnVo2oQrYVXE7D/t2J1E+A92N8=;
 b=iwU+lYq4p6Qq45PazKLwqkOEI0IK4tbEuqiErC5z2WX5vd2Pk6Chp035UvcPFxcXZj
 37570DXkhacRLcJU6gy09LvIMpmz8tiDOx6ELAYBDo/n4mqOVO7TzLsj1VKFx1L9DXR8
 X3ufeSEyZRTs0QW6Hu+epQPx907eJ6FldZgp0dLFWm5zj8N1RXe9SvZs5+4e1VP++1fX
 akd9CPVQNSk1+4plD0couAW6CP2vYqoOcPIQpNg605flbEZR9UapJ2FT/gF+fQWQn0Sc
 gjajqrD3PqOGb5Rgtdf07kr7QQ/EGmwaLwtsc6F+DA+9qMKt+SkX2pGup5FwngXeFUxb
 F5Tg==
X-Gm-Message-State: AOJu0YzouaTa+8Zm89TbPKzjvJ+wfOhj00mMI5X76N2K8Zc0GKDACJrB
 cbmjc556Ac/7DRJK9ILfkBo3z/HU7RQicJnj/6ZcP6h2xTHPr0y+gHfvLmTJqBuDJ9LxvJXBhzV
 0/ZytGPKGTWMmJQOlQ8n2gPUc1pI82xG23nqH2uetgg==
X-Gm-Gg: AfdE7cmW+n6lltKMdiWyV4uPTcEX9W355vcSK8b297gWypnPB6DUDc3Yz33DQZKSFKH
 Pyo7tJ+tsC8IUrE+6JjC234w2vBs0Y0vDO8VUkoBdgvPxHRaG9i7BD/xzfvwCskvWp6VqpmxtXu
 ZdXK4dLGF2ZuIAW8MRLSCyP5lsIjqIZDfSJfg7efOCVfYWbqPlUCnW1TKraOQ33rIPCrEOK3lhG
 HVToJqaYP4gqPD3m2lFAuErEoptgm8QfCZZfaKMMV/ljGyjE1NZftr9Rc+ffmV/TtLwdcxHLvq+
 nICS8s2P+hWYKC6Qk4hcHGAOGDT0O02OOUXRqY0ctmqeTEmI4x/yG7da
X-Received: by 2002:a53:4204:0:b0:664:ae6a:f02 with SMTP id
 956f58d0204a3-664f9a9dd97mr256091d50.76.1782750725876; Mon, 29 Jun 2026
 09:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
 <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
 <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 17:31:53 +0100
X-Gm-Features: AVVi8CfvE3IBWcJ8Z1OJxxXclPvnHOgFFVzmTFfuV2HbV7Yx08Q5cTgz7DRzlPE
Message-ID: <CAFEAcA9t7TjhCSZ1EyBOPStu6vadq3UA9FMgbWOqkqfM0aMDoA@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Bin Meng <bmeng.cn@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 24 Jun 2026 at 09:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 24 Jun 2026 at 07:57, Bin Meng <bmeng.cn@gmail.com> wrote:
> > * qemu_receive_packet() bypasses the send path for device loopback.
> > Its current net_peer_needs_padding(nc) check would become wrong once
> > backends or hub ports set do_not_pad: the receiver there is nc itself,
> > not nc->peer.
>
> Thanks -- I'll check this bit.

I ran into this from a different angle today, and I think
qemu_receive_packet()'s check is wrong currently, not just
with this change. Although net_peer_needs_padding() will
almost always return "true" today, if the network device
has no peer (e.g. run with -net none or -nodefaults and no
other network backend connected to it) then we won't pad
packets we feed in for loopback, and so the bugs which
commit a01344d9d78 is trying to fix still occur. I'll send
a patch to make that change once I've tested it a bit.

I'm also looking at a variant of this involving vlan headers:
https://gitlab.com/qemu-project/qemu/-/work_items/3518

In commit 63b901bfd30 you removed the code from rtl8139.c
which handled padding out short frames in the device's
receive path, because we now do the padding at the other end.
However, in this case the padding code in the device was
also handling a case where there's an 802.1Q vlan tag: it makes
the buffer at least MIN_BUF_SIZE + VLAN_HLEN == 64 bytes, with
the comment "Include some tailroom in case a vlan tag is
later removed". Then later we use this to avoid the copy
from the buffer reading off the end, but now the copy can
read 4 bytes of data off the end of the packet into guest
memory.

How should we handle this? We could:
 - reinstate the rtl8139 padding code
 - make the generic padding code allow enough extra space
   for the 802.1Q vlan tag (so devices can assume that the
   frame is at least its minimum size even if there's a
   vlan tag)
 - have rtl8139 special case this

thanks
-- PMM

