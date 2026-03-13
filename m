Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFD105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13Yg-0004qO-V3; Fri, 13 Mar 2026 10:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1w13YU-0004o7-3G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1w13YR-0003uu-GO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773412313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTwvEzJBWCB7RbCDEKlCHonjnrwir4x2Pvfboo8omj4=;
 b=C6qXTOi5crxcAGlo+7PzWPUyh8hPI/dAKsSvOXWOiXrXoFuCgrPEFjkynkYO9w4LFHvhip
 424/8sCfq0wcJUfdE4ANZizmLCRKik20KQ6uxCKp1qahmKbYIL+YBBSGS73gnZTd9HVpEn
 A5wrHYueSBvk8fkoln0aH1in9qz9y6Q=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-jjolIk3yOBizQDEH-BHx-Q-1; Fri, 13 Mar 2026 10:31:51 -0400
X-MC-Unique: jjolIk3yOBizQDEH-BHx-Q-1
X-Mimecast-MFC-AGG-ID: jjolIk3yOBizQDEH-BHx-Q_1773412311
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64afec091f9so2391895d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412311; cv=none;
 d=google.com; s=arc-20240605;
 b=UB+8HyENW+suaq0mkfcAk2azEyOa/JvrGfTHvgk0pSQkXcdpLIb1+60pv3/iFi3GK4
 fggBukRKX+uTHt4rS3huFfim9Dl4kdTMAW9W1pJVNfeBOUK7wIbyqmP6tO6huNO/VAZ+
 3rz6dICyj5m4ENrQVY/zu6N5HkJlOgrVavUzQrQNZSYk3ai9w700mCem3Dg4V78abFyx
 Qp4iC1dVSdVbi6KwPRAcrFwsKxm9xqVAe/ReHNNDeLcUNFaNVxL2JRlJedx11La3CGmc
 PD7qPdp1LAkEsn1lGsMC7HFE7km7VaQyY5+nILl3bnJbvpMYYxJQ+Rv+2dX9qyCsHczv
 wdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xTwvEzJBWCB7RbCDEKlCHonjnrwir4x2Pvfboo8omj4=;
 fh=1LT8hILiVlGprV41dahezZSR+8v9iALPPerxck3xJUs=;
 b=Mt0ro3IczNGXA8HEsgmPattqapYyRJBxhXFzFjskE+jW77w+rNyaarwGEEo+P3UGyb
 ljWX+/bTK+JL6keM8/ldBMTxGswaS20QH1cS0ePqJ/F3jBLZHsqwgBUX5eDqhA8x3JQp
 +AgBce4kzhSzxzBUEPz0Tv4DzluZ3PEQFEZSBy7bCucYOCy4xy07Tekvv3SoxBn25dLx
 pEoNheDUPGnFXodmyHKL5/T9jyZyrsVCwUGs+E8GFCECTCx6dYu9Em05WrnvRC0H0jfQ
 +wOiEh6F3fLCl88wT2a6IItZGpIw+u/sR+fQCLUnpgJQkIEDxihUDg5DG/j9cfxihFSe
 mupA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773412311; x=1774017111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTwvEzJBWCB7RbCDEKlCHonjnrwir4x2Pvfboo8omj4=;
 b=LptU0A+9cRTsxHnLkr+6MaQUeJ0SCplxCZarsl/S0S2jYp/z2QufCNI6VGVxtOQczj
 +Pf2KeajrSQsETPnDESgWw9FPCoNI8PMkS2LnPZHfF1ObBCqxcdvURf2HrLsPU4ReCm5
 jIztIgkz4wjXD+ZHuCc0hA27MHhj1XqTxvk81llODSF1W44gTLUwKAKzfUIPWluXT3aY
 LKHS+SBjUNmBW4Bjai683iEJMIJxjDQeByGdY2ezbsw/4hCazSXzqq753unmbV5/Mlhn
 zy79tq4/kDj6FyDw+S7F4DsswuIw5LRo9TBmaeXzfZyw4kBX4nHsZgmivnS5xgETvzsU
 +6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412311; x=1774017111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTwvEzJBWCB7RbCDEKlCHonjnrwir4x2Pvfboo8omj4=;
 b=D3W9God4G2nXOVQuk0ifw8b95esWFFiKB/4CX0RlBY3gay1tpaLTBHNfhfKlOXZgWX
 ZrfVnU5DG8MnQ6OLbzuQhb+DKbJlZKLsmRf4ZHC5VNvzZZ47xe/pgnmM4Fkt++5Unpl0
 YjkvhlVkjcBdiy39Wd3fGUG4nxAXZyh05dFty+PGuA8TXRbq8Iv7/fTqbzg5IXlOeqel
 8DNlKLoGfhlNyEtMt0wGj3/RNhJG4nn36Jt8VXlFSdkhLnMWEyvgi7snCrE/U9MExXaK
 RFjJpd79WpoZYzz4w5h/1nKMDPQIE4hnGLKQB6TkuRSDJFQfT3NOLm4VV1u6Kqkhrn2k
 9ZBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRYgpljwhkF9YO89jNiQnFOuKyXvCPVcIK0PDqUVkDenqc31jGnDZMLhvrjOyJs5r9neYOOCdbcPIk@nongnu.org
X-Gm-Message-State: AOJu0YxW8iLGyEsrlxB2xpBOpaIEuMbLlSMYv/5ytlDWTjPzG7ydIdEV
 oEt/toRp+I5xcIBsv/Ag2fhl+vv4nMMtzE+t6W60P489WPq1eF546i4xDocVGKLuAAXfZ/Ykp9H
 DpcNS4UONjdNHPZbe/l489fLFTngC3coCdru4pk/U0ZDpCcvmqjo9Thr0KEqIGV9o4jTo6Ohovo
 rYBd0o5yZouZaPD6kVBpg40wMamUWqWKY=
X-Gm-Gg: ATEYQzyQFHy6ps7C7D/SyUM4++Ud3z2Yn/AebohGx7oP8COoGnBFbs1z3+ewW5ADKqe
 G/saWQdoTzm9dGZP+inIAWTv5CrRo/rksAhMngGLWOGY0KEyMWq2SglZsApwVyUobCWm+6/Ahhg
 48CKEYdf0i+wi1zOgkH1VaElsiwB/rj/IegJq+2f2Otc2jB1la9gg6etrR8BeIp/nwTHMkoTuNp
 Ta+jVvVxwXiwcb2mwUuRnGfDLVmNPL8UMMlZw==
X-Received: by 2002:a53:e686:0:b0:64d:60f2:8186 with SMTP id
 956f58d0204a3-64e62fb9a7amr2716318d50.40.1773412311137; 
 Fri, 13 Mar 2026 07:31:51 -0700 (PDT)
X-Received: by 2002:a53:e686:0:b0:64d:60f2:8186 with SMTP id
 956f58d0204a3-64e62fb9a7amr2716287d50.40.1773412310669; Fri, 13 Mar 2026
 07:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
In-Reply-To: <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
From: Oliver Steffen <osteffen@redhat.com>
Date: Fri, 13 Mar 2026 15:31:39 +0100
X-Gm-Features: AaiRm53ZdLDBxSqfd-bzrXZ0ZZlydqUIwTqk2ogNbgqI15AVy4Qdu_vAaZjr85k
Message-ID: <CA+bRGFpcmkX=O1+7L5dHFRGh+M3BAd3BfHbQ+TXHYmcea8_pnA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 11:24=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Luigi,
>
> On 3/11/26 6:43 AM, Luigi Leonardi wrote:
> > Add a machine property to pass a debug level to EDK2 firmware via the
> > device tree. The value is set as an "edk2,debug-level" property on all
> > pl011 UART nodes.
> >
> > This is to create a runtime parameter to set the verbosity of the debug
> > log on the serial ports in edk2. Currently, the only way to set the
> > verbosity is a compile-time option.
> >
> > DT is used because the fw_cfg interface is not yet initialized in early
> > boot phases.
> >
> > Corresponding edk2 PR: https://github.com/tianocore/edk2/pull/12277
> >
> > Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > ---
> >   docs/system/arm/virt.rst |  6 ++++++
> >   hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
> >   include/hw/arm/virt.h    |  2 ++
> >   3 files changed, 46 insertions(+)
> >
>
> I am not sure if maintainer want to have bootloader specific options in
> machine code.
>
> Alternatively, it's possible to dump virt dtb, modify it, and pass it.
> $ ./build/qemu-system-aarch64 -M virt,dtb=3Dfile.dtb

I am sure you meant
qemu-system-aarch64 -M virt -machine dumpdtb=3Dfile.dtb

Yes, that works. Thanks for pointing this out.

> $ ... modify dt ...
> $ ./build/qemu-system-aarch64 -M virt,dtb=3Dfile.dtb
>
> It has the advantage to be extensible to any other kind of options you
> want to pass through dtb without needing modification on QEMU itself,
> the downside being that it's less convenient than a command line option.
>
> Regards,
> Pierrick
>

Regards,
  Oliver


