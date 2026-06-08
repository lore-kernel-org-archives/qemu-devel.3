Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1DFCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWas6-00059j-2L; Mon, 08 Jun 2026 10:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWas4-00059F-5Y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:22:32 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWas1-0004nU-KC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:22:31 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66049669d78so3695466d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928548; cv=none;
 d=google.com; s=arc-20240605;
 b=IRgwhF6lUQMRQt5iIAIHDiHhXaXVg6HBBadk0uTst0/RbopL95Wd/5jw3EGqZ92jG7
 KVjoWfxfqiYsZzrdjhOazkhelwj8JcFfm8a9MfGWQs1HHotjFr++yLWd5GAiRtwS8tqZ
 KPdZirVI/HdnusRpfXovkJFH5HaOol7W2+rQpb8ap9EXt1+o8o8g3KETvy6QJMrbVnuH
 U1Hcgl66y2QncfAXzLIsrg2gDt2GlqkB9U6ojN6vgjGT6GWW2EYGqMNKVTZtrfJc4Jkc
 qYdcpmtPNqEbYksji2ubuonxwGpY/Y6ByohAeiEXEqRBczMeOc5dWAYK/6vd9FAVOrnJ
 UemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0LD1L91MJ8AV5fQIlGrEgixdDbk+DNIoe7oTJTZTCM0=;
 fh=EozbU2Dip7ihBuM+OpDpcROKl5e201y/O7KnKTMuldA=;
 b=kan5KiJD7LF0P/8CxXsvj2ryknXplAC32+NAuok45jQ22hgb+WGshSiehtq79zdazN
 6/7mkIiFTMkyLXRFYFKGX24r/NoA9uubQjY0w56QnyBcE8McCv2nGT7d6UoGphJfpDAy
 9wH5bx4Hr6WGHMvx7iXoax7gKFVZZbzOC5pYJWHtYLLLGoG6jEBbMdKGfQO312Ha8NsP
 xeQS02pQt+l9nQ1SZUCSF/2bSSDfFhq4C9e13dRGfht7PvOqAKkKZqbeQBcWWgae9AOC
 g3TKTcZgwkE+eF9WDAcymmTq52Wuf4y4CgGe7cEL6fo4nSpZH8u/n9RMSZ3h0AsnTdPJ
 iucQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780928548; x=1781533348; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0LD1L91MJ8AV5fQIlGrEgixdDbk+DNIoe7oTJTZTCM0=;
 b=IjvsUPCnPkzBUBBsPwv8TRLP+VPpVmKXajYZS1ImO0OZW2omoymG9ePd/fuuOSHd7m
 rTfbet4NtdICtO8qd5jDOh4wxqdMQzrOWq1bUNVeUxPIWBN8xSDnqpZ5aMZWc0r0HtqM
 RM06U+9nReBWEhFB8ZenzpVYE2M7PXdKc5/aImZbgGe3fkIMxF/tsxMIwgG+nmWNLAz1
 kYKVZgjwTnl6zenA0OIJNqhVzK00JEov8w6PImqzGcbDRgdY3Smj2msM+7CC5JAre7OQ
 rIfW6fRnBJhuRmh7NyZI1sW7SgT8q4edGthXvGq+XmEUSrVQJ8/NBTScu//Mqet4bW1N
 yjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928548; x=1781533348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LD1L91MJ8AV5fQIlGrEgixdDbk+DNIoe7oTJTZTCM0=;
 b=FQlER615dGQmU3IhM9FcP0rTaNBpXymkVwGdHxc/jr3D9di5d7JQNrHdVVjEilBaKk
 S+Z4P2zq4FdqMLXUcxzfOsdXm/QP2VfftH7aOyjFgeCm4MZSNaD7+EEqVMKHMtRok9iI
 4Oc9RKfR+Li/hJNKLKpDEg5kfNmsdeku3ZRLWW4ixmFuQQ+eU0isHTwxcAed6ODwk7Tj
 3fDg+5U3eaqnIup0l4D9azr5kDbegmg18rdwGuEaCH3+fwaj/UN30hqZ9GvN0IJIPbt9
 H417MfUoPGXiq4/uc28TbxqPGBNxL1oGuWm19Vf6n1txHgKk1uYTqUc/lMFTy6VRSz2Q
 U3mg==
X-Gm-Message-State: AOJu0YwNURnR/6nIp0C12oWYjfWe37xrfSdJltAdEU2Sy6NBu7cgy282
 JV/0E8dc+XHVeNIt2vLZFUG1cOEZfnMz/Roq2UinoQoAMBvbVhN/jrCv2YGCWFpvpNET4dOztEO
 /yqoppwyG+ct+HcPkXnNUqLd17pXniIBt55hGcMtRS9wpupWuPRpp
X-Gm-Gg: Acq92OFodbys9Qnb6J0i3yZWMOLmArI1oR2bXnl2vOMrYMg+xYkqK34UB19Rqoz8Z7X
 sR1pDjvvBDf1X0M0vwkvHgJulDFftaiXv2E5p9WD+VG/zPdqO7kmuzD8Jwqs7QU0DAxmOwCqrmO
 vOLZpD8Nv6/ufBBfGR/uytatah3iSNrE0rL4YvUNXu+wVnTwt1BIiEMg1YTBLBAsUNmpOFGdrLm
 0k7UxweUT46H/g4z9TPMwpee1pViUMtvm6raWdxUUG98SHjbJrPM7yvCluxPnfatVRoB69IDLHn
 YYRKh1IOmK9daWKOFgJFdlczNmhFQRLt8Bf5S+ExW3Pc8QBOr1Ci/HUwmSV6/Nlm1xBeCxNyrSW
 HEA==
X-Received: by 2002:a05:690e:43d9:b0:651:e0cd:5874 with SMTP id
 956f58d0204a3-661070742d3mr8848797d50.47.1780928548093; Mon, 08 Jun 2026
 07:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260604134422.359214-1-kraxel@redhat.com>
 <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
In-Reply-To: <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 15:22:16 +0100
X-Gm-Features: AVVi8CfqBAaSLFcbd-dLmivMNI-geepTiFnkVXviaUAOB_plxIv9X04tY2Oz-Y0
Message-ID: <CAFEAcA9YDnU5wfsDz-Yfw9E8aQVGWfLvPaPMLFhaQ1AeUcz+rg@mail.gmail.com>
Subject: Re: [PATCH] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 8 Jun 2026 at 15:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 4 Jun 2026 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  docs/system/linuxboot.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>
> Thanks for this patch; I've tried to expand it to make it
> more comprehensible to people (like me ;-)) who aren't
> very familiar with UEFI, but I may have made some errors in
> the process.
>
> > diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> > index f7573ab80aa2..72af18ce1b5e 100644
> > --- a/docs/system/linuxboot.rst
> > +++ b/docs/system/linuxboot.rst
> > @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
> >  give the kernel command line arguments. The ``-initrd`` option can be
> >  used to provide an INITRD image.
> >
> > +The ``-shim`` option specifies the shim.efi binary.
>
> ``...`` around shim.efi (here and below).
>
> >  This is needed
>
> "when you are booting UEFI firmware and using the ``-kernel`` option to
> tell UEFI to boot a specific kernel image, and the UEFI firmware you
> are booting has UEFI secure boot enabled."
>
> (Or is it when the kernel has UEFI secure boot enabled? Or both?)
>
> > +when using direct kernel boot with UEFI secure boot enabled.
>
> I think we could add here:
>
> "When this option is specified, the guest UEFI firmware will
> first load and run the shim binary, and then the shim binary will
> run

Oops, tail end of this sentence got lost in the editing process:

...will run the guest kernel.


-- PMM

