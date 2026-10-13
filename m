Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2E8CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGa6b-0004gJ-3F; Tue, 13 Oct 2026 06:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGa6R-0004br-Sq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:51:29 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGa6Q-0005x7-5u
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:51:27 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso17908687b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888684; cv=none;
 d=google.com; s=arc-20260327;
 b=c5AbGy1MwyamJcgtn5dwuwpXYao4kWeyRnyPkRNhok4gTYXGcMGZnhVIFvEN5vly5H
 vjc45i40jB/ng9D+AWXy3S2Ckh6v4Hfmb+ofsBNGs8zB4TlKQgpSX4biMdMdDzxR3wlJ
 npvJzjLLi21n2ZSaj/UVYvT7PoHls9ZokXOzu62i6M7hdeEVhCPGoz0M7y46ilaWA8jX
 oHd6vVF3rWHAEvG4+1JqcjeKjrBz2RzqjW6W8sRsecOVGkPF8Vf5yPVEPNvC7or6BDAw
 KY3qmb5NwVZKJBSL0M6RomZuXGixaZCa55etx/G0gS764Y6b3RL/tM3aLTgSEYKFWhxA
 /Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LoKCVYnEg+V3D99jGOttC+5BQDWr1A0Npmf+EGdswzE=;
 fh=BgOJ6HVQhbPHwfEMXfuLHnNpykoGC5oQCU4MWWAPAlE=;
 b=FPCcWEUVrMCHOqpzBjq6E6g0QP+ETAnQoy+ap8aEZF0/HeziUlXnsvVBrz0ERic5If
 D7diMKA6kG1nbb5PtwE3Hyh+zt8+OVklUyekLZvlYf2deT7Bi/WCS4ACV+J5XG2ULxQJ
 pOZviuZhMZld/LHKbxtSh19TczpHD1pmwqqKHtjxaqfIBO9qEq3DzgTUiE99ZRrK5Q5u
 6WU169aROATXN7VxhONWoHyyDSWKXFP4d9aw5jzoMoU79xSM0F5DBatRy7XB6qGrdIrD
 YNkUJQrzbbeUsEvLVwoCwSaFXuJYXr6vnFIO2H9iJKnJu/Da3Bl/yDueo/LWPhBxG0JD
 iWYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791888684; x=1792493484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LoKCVYnEg+V3D99jGOttC+5BQDWr1A0Npmf+EGdswzE=;
 b=LJJybHQ8TljQyJTuqzC4wVKMW4dErdnSzIKDL3WJ6ZMFmBCQeCQEHUQSUJEltYBOFS
 tmOpUktsZdW+uzGkP+qdVhR4brw2FBDbggwe/8AgViJw5vWx5Cxde9107BUTKgFMKjUT
 QRbyRw6d68CH7XmeGymRJVGhn8aRlSCIEpw7hxOucH9NbfC9RPPUS1zrCitiP+7RG9lS
 TlytZHJhZVSG13/oi52wPeNc0KVdPSXrOca4mur2AWbrn0N6yX2XRxEH9WhDg330cNNp
 wL6jkRg5WVtz0uerIETowVY8xPdcsYDsoc+RGjbUZpvequ34hWtTgCTcFQBCyeYiLdYK
 iHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888684; x=1792493484;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LoKCVYnEg+V3D99jGOttC+5BQDWr1A0Npmf+EGdswzE=;
 b=lnCQiHZth/D/rsKKJrXRyHLJOoDTYqTt/3LnmuRPxPW3dyQF1P0q0MrAN8tfSWYWKr
 LDd5C1cEQighWkrtC8p3VcEiWAvztBifADaBCoglhmTPDUcC8llBFvUwyXx0sFSnJBoy
 UFjA8P2LtEIqxQZngHL/n4UYBJc22YyYZvfJRvtH6nUV0NcFiobY9uG9nZc9jPJSv1rF
 LZOm+vZHx3hOxqrog/Uo8Fsi6r1itjDVwjJcg2TLgVvX/FXqY97uNPTL0gNztzdI2Oso
 OzLf5qlsWgaiCNLz1/sDkEpFuLehvWxbcMmqCkypyT7+LDwB75usmsvkzHuYGPTrNJf+
 PE0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgDOq5+nv9h3vD67cbb4bwXRjHavc18fZB6L0TsZDSWzqeQbHPKUfF3ZZ4viOWsGBTOVxzEB40glbq@nongnu.org
X-Gm-Message-State: AFq9FYIrJqeXqma03rR8XIgGbze4GdiEjtoXSucRZJJR5tz3zT4RBwFA
 IIOZfusiVL6p2erxMYtkUXVjcIxuDAR13NuY6+pE2ZOB3Y8xVoT05UWwG81hTpiQ5oj3FnLJjZW
 xSx7CiiSfYkWitw5oovmAS2c4+4W/LIPwPgX+QKU2Rg==
X-Gm-Gg: AYBFou3bgQEeIkbRSgdy/Za8VpGegoMcgetQKbguE6dJdjbeSb10A4pGZS5a41dcyTN
 E9+OedezRmx1sE9m/yVWFS/wYJXpy0m5Su9ZBtsQLD3O8xuzEG3L1a0Tws+yA+AU4KTIzebH98M
 zB8IBHUm10sDbriCZXljzlDt0ZSEWoF67HbaWu7DAZxMgS28rRjNgS01fY9dD2tkQM6ZNOOQe8B
 ETBO4GMZQFQdq0thjQuh8S+X6PWxPvZoc3Hh5pwuQ2kg5hy9cSpSlMk2xLm4FzcmKcjWCf5gcKn
 Jfch2GUSOa5XX3ySc2YOqkMJS8LE9rI1TUHTFAdi3MyiQSpnnj0LhTGKmZ8+4mmy95dSIU8nGIL
 r9TsUEvfypqm4BrVsuY3+7a1MLJ6XOKnBVTTAt7TF3OeXQBEeMw==
X-Received: by 2002:a05:690c:498f:b0:8b0:a08f:2ab8 with SMTP id
 00721157ae682-8b0a08f2c5bmr19711707b3.42.1791888684260; Tue, 13 Oct 2026
 03:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <de4fe97a-83ff-4f56-b3ba-f506d03e252e@oss.qualcomm.com>
In-Reply-To: <de4fe97a-83ff-4f56-b3ba-f506d03e252e@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 11:51:12 +0100
X-Gm-Features: AclHuK-eT80DED0SjkgUtG6LtVdQJhH9P220XEHp2tNUToRv4ppzESw8WFEvenY
Message-ID: <CAFEAcA8w9yQCr4gH+iOwX5V7A3BcHQTS33OgD-recLR3MDG8dw@mail.gmail.com>
Subject: Re: [PATCH 00/86] hw/intc/arm_gicv5: Implement virtualization support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 13 Oct 2026 at 11:30, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Peter,
>
> On 13/10/26 10:38, Peter Maydell wrote:
> > This patchset adds virtualization support to our GICv5 model, and lets
> > the "virt" board use -machine gic-version=3Dx-5,virtualization=3Don.
> >
> > Virtualization in the GICv5 is more complicated than it is in GICv3.
> > This is because in GICv3 virtualization is mostly delegated to software=
,
> > and only the CPU interface has hardware virtualization support. In
> > GICv5 the hardware does a lot more of the work, so virtualization
> > support is needed in both the CPU interface and the IRS.
> >
> > I've structured this patchset as:
> >   * initial preparatory and bug-fixing patches
> >   * add virt support to the cpu interface
> >   * add virt support to the IRS
> >   * remove the check in virt that stops the user enabling virt
> >
> > The first 11 patches have been on this list already; I've copied
> > across Reviewed-by tags for those patches which got them.
> >
> > The current spec for the GICv5 is at
> > https://support.arm.com/documentation/aes0070/00eac0/
>
> Now A.a: https://support.arm.com/documentation/111701/latest

Whoops. I should have checked more carefully the google search
result I got back :-) (We do get the URL right in the comments in
the code -- we updated it when A.a came out.)

> > The kernel support for using GICv5 virtualization is not yet in
> > mainline, but it has landed in the kvmarm/next tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
> > Similarly kvmtool support to run the inner guest is still work
> > in progress, but the tree at
> > https://gitlab.arm.com/linux-arm/kvmtool-sb.git gicv5_wip
> > will work with the kvmarm/next tree.
> >
> > This series can pass the kernel's vgic_v5 selftest, and boot an
> > inner guest to userspace with kvmtool.
>
> Could we have a functional test similar to
> tests/functional/aarch64/test_kvm.py?

kvm-unit-tests currently has no support for GICv5.
We should be able to have some kind of functional test eventually,
but it will need to wait until the kernel patches at least have
hit mainline.

thanks
-- PMM

