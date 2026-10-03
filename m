Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7313CA5FE3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 04:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCrDA-0004na-Ri; Sat, 03 Oct 2026 00:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xCrD6-0004nC-K4
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 00:18:56 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xCrD5-0000Fk-31
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 00:18:56 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-6756a6320f6so83409d50.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 21:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791001133; cv=none;
 d=google.com; s=arc-20260327;
 b=bd0LRyFON5fSmwiaRQKebVKWgewIp0LH7UniuKqTuFbQVX2nVJh4aTdy7XAN0CK4j3
 cXK+s9S3oTYoi+sWpEMyCjFW+5rfXmagL83jKUbnbbAXDW98AgHCKHwH3brc87B1fRmT
 E7djmqeQH7+SYKyY8vN2ZLVjH52tQcLyGvRF5YpzzKIBjrn3Zuf6aUoZqzoRIeZYtbCa
 8y++nWWpL2CsOnI53fmEwb2rPRGpaARrgrBwmZ+cHkOUAK4crEE9yApoZQOjz0J0nk5T
 293mNYw+dfUzJ2gPnQxW1EiQUyaiUkbDpSEPcFMyJGpA4loWA2OmWuzJygGAUMpggnzp
 FFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3W98YOUyb323d6w7Sew5w2q9CviWlMY/DBh/jjeDhSY=;
 fh=d3ax1QLmwbOoR+ZvUfg9iB9BOGtU2rhN6zDh1879CPA=;
 b=DqlZhBY1nuZ6IT7YxI9zlnnRfjMnZFzNmYyQHfFML9uJ2QBdXNba0cPw693Pw1Xn+A
 PHMUK5I58vaGbFmc4b7y1soyY27sN6T/k47xXajXL4C5KvE/fmybnoMA3gYWMBGHb50a
 sll0EYIs0+9uvTrpS4VZmwIj9vYW/2HlNTzUJ3wjh3WBmmigZnpMoDPG5hwQ+r5Hcoxw
 eM0isil8ZWIY5lkhRcbb5guJDq82J65bQMuwCMtfrcH7cYyEpDAL8xl39toF65FbyAwS
 MPV46SeiFH5Zvn1QH0zawLdC83L2jt7kFh9VgN0ek1wDh9HJ9AdXt1YFd2B/3PIGteV7
 +RRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791001133; x=1791605933; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3W98YOUyb323d6w7Sew5w2q9CviWlMY/DBh/jjeDhSY=;
 b=fYeLiO5h+9/iB2AmRWZHU0WpThVz+oY8OaCXnEd7zqbzApxjgPSXFALf5sKyOTbfSQ
 qlZ4Prkss2zcQwZyYmrQglzXxQ34tw5RdcNg7sQ9SqqZnhc9yXJCdU8N15xF7m2hmoVJ
 Mm5c0eN0O3+g0MinXlIWvy05E5G6SDUAyCwy6o32tVGo/qHeiPymKB6jwKT77zfJz52/
 MHEyAdsgCZUvmJpjSVumTgvotVXRn4wz52C9+0/ZLOMybZcIJzi5ioO+9RFSLjfJu/hN
 mzcPdNpG31PuB8OFOrN5sGiQ78YmAiRy8DJHVL9EXJsBKHgIXvrRLoxU1FVC0O6rbvVY
 IlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791001133; x=1791605933;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3W98YOUyb323d6w7Sew5w2q9CviWlMY/DBh/jjeDhSY=;
 b=yfuWQte794y23WZFbsxhTRQ9kCT6Ankswx6/da/Eryod+COTFAdgF2rFbPE86JSEGW
 IuD8AtG//C+iP5usVH+iQyv2/ERKcj84+p9ERgPzFC6sJ3u9lFxmPRJJRRCPBJdss7Rw
 4pYjd95LwssXyTyid/N3Y7facRnImeclOYjza2+1EjghZgHviYIaPdHk9hfmDVlzxQ69
 ZuagdJ+DchB1hDr0erqZQky4haMRk3Rd5zbpEfyaSiPzM2DeaKqwMQ2lkn0i8b3vc5sn
 UBUGsK7z2Uf0f1ipJc7g+PcsmPaVij2Jm1QPDqLdSsF+mndPWui75aI4mm+yppL4d+lW
 Pt0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByz1SQ9zfl3/u1OqCPfKrBqPl4kZ+exGusXV9XVQOpKZcmtvpDsqVoqzkmU0uyNcBReE9Wz7ibWoGcA@nongnu.org
X-Gm-Message-State: AFq9FYION49cE4YDYaPb9Quy8mxPaEi9Qi44AWvs98EZujpGKEcXS5Ww
 xs7x7BWeoZj2Z2vSzYoVeuFVXgiXmM+aeH/h5Jes2hlpaNtFuVKQt/J5RY4rPduyksKVO9szQ2w
 BGG6+d5WFJm5gdhV4LHCrRudhDDKn/wo=
X-Gm-Gg: AYBFou1DrJBPIGoHnZWv490NnvSY8VFvwbPWgSk+FVIoCKmpFy3XFFqiFRM1WTVj81h
 SLqiwWOBnlIkHauDO2dmpjtZ+IO7t1jVKH6vPnMx1TCCsKWkg+ZnZWd+5Av0rbL+H/GqyfjSrlr
 eywLI7tO0QMjNYwB2scFbf4hWlcqw7HPj1wblz3Gj1swplsjIYOw/ueQ2mQHD75AFsQOFfB9E94
 fakGMCu2YTdgWGkHm36rlWkP7XCRFBpwhsdVAt1h+UMcJA0/j3shCfB7LQVVz1tljZQHrdJ2AKJ
 9LY2Giyo0+i2RKxHKaX7aAflDIwuSKK7Qwgm1MMu31B4btP5y2IdqsJ4RkG0Q6FOwO1eM3BZ1Pk
 9Lv2V874y9CboPHg=
X-Received: by 2002:a53:d013:0:b0:672:f1e7:d232 with SMTP id
 956f58d0204a3-677abfbacc1mr1969669d50.26.1791001133003; Fri, 02 Oct 2026
 21:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
 <4c1c01709d9e903fbe93fbce5b901ff959a5a01f.camel@alistair23.me>
 <CAFEAcA8VtORuoLj4p62vj2dGtsawWmaUWUw4dW6vtxn3g5aG8w@mail.gmail.com>
In-Reply-To: <CAFEAcA8VtORuoLj4p62vj2dGtsawWmaUWUw4dW6vtxn3g5aG8w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 3 Oct 2026 12:18:41 +0800
X-Gm-Features: AclHuK9fRmzkwl3tr3x7fPrJSzPM8IlRKHqIrhQdg5PMVRM-6440Pt_AzDRAjL0
Message-ID: <CAEUhbmUN2ifCOnEkrj=AYXzwuyC2R2+cpGzGu4Vdgggn+ZdvCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair <alistair@alistair23.me>, Bin Meng <bin.meng@processmission.com>, 
 QEMU <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On Tue, Aug 25, 2026 at 5:27=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 25 Aug 2026 at 05:20, Alistair <alistair@alistair23.me> wrote:
> >
> > On Sat, 2026-06-27 at 23:42 +0800, Bin Meng wrote:
> > > Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> > > in terms of ZynqMP PM firmware providers for clocks, resets, power
> > > domains and pin control. QEMU does not model those runtime firmware
> > > providers, so using such a DTB with -kernel currently requires users
> > > to edit the DTB before Linux can probe the boot-critical devices.
>
> > > +    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff000000",
> > > pss_ref_clk);
> > > +    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff010000",
> > > pss_ref_clk);
> > > +    zcu102_fdt_fixup_clocks(fdt, "/axi/mmc@ff170000", pss_ref_clk);
> > > +    zcu102_fdt_fixup_clocks(fdt, "/axi/spi@ff0f0000", pss_ref_clk);
> >
> > I don't think this is something QEMU should be doing. Modifying the DTB
> > on the fly just seems very brittle and prone to breakage and confusion.
>
> It is something we do already in some limited cases on other boards where
> we don't model all the hardware, for example in imx8mm_evk_modify_dtb()
> we nop out some nodes and make some other minor tweaks. I'm not a
> huge fan of having to do that but it's a pragmatic thing where we
> don't have models of the hardware the kernel is expecting.
> This patch does seem to make slightly more extensive edits than that,
> though.
>

This is the minimal dtb patch that could make direct Linux kernel
booting succeed with a working UART. The SD and QSPI parts were added
for testing other QEMU models (hw/sd/sd.c and hw/block/m25p80.c) too
and I think that's useful.

Current ZCU102 documentation does not explain how to make Linux kernel
boot on QEMU thus we need a solution. Modeling the complete firmware
boot is definitely a way that could avoid modifying the dtb, but that
involves massive work and at this point I don't want to proceed with
that way.

Regards,
Bin

