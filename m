Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622ADC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3d4r-00087Z-Im; Mon, 07 Sep 2026 13:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3d4q-00087K-2l
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3d4n-0001gS-9W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788801850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NACbHspVAYH+/16JEoMayIHE8yOLevguoDRHbaDl3Xo=;
 b=bBJAvXlkNQOTJ4FXBXg44Fj1uInMBL1FpyEIMMZGRnCHTqYz8f0ywu6XgK8p4BF6kloPLO
 QnCGJmBQYIlE67rQAWdush/gok9FDg4DDncIq1XmtBMgmWEjMqZF214ZHYRU0KAtbJPANM
 DWII7m/xnEe8YDh7+LndctpINeX12ng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-3nFTCgGFOn2ur3UZvMOgRg-1; Mon, 07 Sep 2026 13:24:09 -0400
X-MC-Unique: 3nFTCgGFOn2ur3UZvMOgRg-1
X-Mimecast-MFC-AGG-ID: 3nFTCgGFOn2ur3UZvMOgRg_1788801847
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so1832406f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 10:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788801847; cv=none;
 d=google.com; s=arc-20260327;
 b=iCppGQbKRWT8C/jq9Lic+SbloriKgbZFrQWAp6j1hU/Q25eOiKSu6lHdoQIUX+DRFL
 uQhzs5yDVUO6X+KdEBpxZ9V2T8bnxZpCEqg7u4hzNLxQsKL8+qxt4z5tFrNJvb6d3Q5G
 Uu+0mbjE8i5BkNeeDKb0UMoI9ekXEMfQvFiVis24P8VgLY05enzMko9MhA7bpv5byh3Q
 VMkhXzoW1KPr5ik1ZxcpdGJYNbULk0OnkMHRLQ8ES/TcwinqC8qoUIz6Qgni2lX+2Ab5
 aFRp4P2Qbbhg1gTaASLEAiGN+B3DE7laiod5Wm3yDbEh34CX9hrCcQ6m5UUhqSRGYlWE
 JP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NACbHspVAYH+/16JEoMayIHE8yOLevguoDRHbaDl3Xo=;
 fh=V9+71croMFy7g4qkDc9jmUXy3V+s2UVp5dMTtywG71c=;
 b=so5m84CZ1nVunspSborszxTS6oQWyNe+opsUVXhUlHemdXOFtECm7nN0zES58io+7W
 nfW14+JLq+lJFCTktiitJztpZ7q1ABZ49WS0AN3oXZHTUqIcbx02/Ptk6GoM4F8xHIn1
 /9htMAcwFmmOW/ICQ5qZvhPibllftdMVZ0dPAPyOduTMB6CbG8lxJY9zSTUuphtg/NwJ
 T/jMoIrHDMwxMiMhoShNBo4G9LYkQJFn+owRbKkEKIcYkd0M5pVPgiuGfTcW7IcyF8CP
 sdFlRSwx2aOWoDFqKPR4fQBkoYj09RpPEzRlVKTp722GhP/zpAZCmXwVerLoonyM9M86
 +huA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788801847; x=1789406647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NACbHspVAYH+/16JEoMayIHE8yOLevguoDRHbaDl3Xo=;
 b=Gh045fPulvWEjlG8GTdPc1/CfbmArAp7FG5ggLi+UQc261GBP7DbLwrJdT5nR59P4d
 IStv/EiPoAAXryW+tR6sLK4E9TyY7afVxCgcRH6yc9IsLMOMNen/ZHSMfwHHBoVm5KJ0
 wejqHQYKmZoCpb3Wr1ltQGZPNA4gTntFpXvna6aH5r3EFcmWBYYAAt9/SOBnBBgsQ2T+
 Nw6qPUwUFQq6TdUbsFEeKlZq70gjqNJajJRm8xJjuQVhekI9RUO9U5pCapaiqora9fpg
 djG3ZSZJ4elqpPCXNYI2Kz8QTNDKml1/cHSHlU1n2+3raCDPIBUfpLLq51OK/6jS1fgb
 Xx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788801847; x=1789406647;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NACbHspVAYH+/16JEoMayIHE8yOLevguoDRHbaDl3Xo=;
 b=oZJ2QSLXLph2bJvBdTWHTwFYJD33K9+6n0u0/FsK7hU4CpujEoF715IGLOJofzOE/J
 tpjUEXO1e0LY4VCf/aj8doveoIPjN0XxRrn/N7p6G1AqBlKHvkUeSFN3DYEoDG16Unfx
 jmPW7JMBlKXCVv7j7RFuYifGCt8PKCpVnwl5TXLQTlnwliZkoZiyhgRDqNvaENRApmqV
 f/AKOAhRVoe24pUqmJ6FgMzQp4gEXvLwMWIpPbnd1SnHBpnixshO5Zj4bSZGOOekL4tg
 unU/z7rf33Q3Q/7hsqsIu3SvyD7IJRG7TNM5l0pUomfCQmza1fO84wsQPrYEWrOtMrBF
 tH2Q==
X-Gm-Message-State: AFuF++l0GIPkYNgKnOux4WVq6vEN+fv35lmZEF1OjLvoXti2rAxwjPiE
 983CHtwYOMMoOgOivq9pJV5KVAR/U3ipjDq+O40rvP9X8AI9kT8GCzBIgM6H4eGaYdzd/Nn/h1f
 xVJkoOOXswdSMFUXbVpM2nM9PsDPOR7gGBxwnUJIP1aR299P+ZJv8UdIBDenEv+kkxUNF72tSZf
 svk1xinYfD8y2MYb4euL+XQyI36IEWTXk=
X-Gm-Gg: AYBFou0Awc7K0D4Wav7+rzR+USUDSIXwtGPMQIjbZgpXQRKLSsV3UTx54ETh3k9xTnw
 kAAgUoYX/V+6O97XAmptZ6zMKJ23W17vXRp4CZu5vuzoSCxuqIXw/iqM2BFZLzsJjE+57X0Xtul
 UaZGmn4WSdbRt9RKndbrEW3jpITtNw1oBqiVGNDRGPZBaTe6NuDqmrB3U89w2F1ypqd66UVxYhn
 hEGtAfy9YjxlUJiWpT0Y8G1WOyxzehcR9PZVp+Q8H9+0Abtf+VQHS5Lt1tgsw==
X-Received: by 2002:a05:6000:481d:b0:484:36c1:2881 with SMTP id
 ffacd0b85a97d-48586e4a5c8mr52265687f8f.2.1788801847432; 
 Mon, 07 Sep 2026 10:24:07 -0700 (PDT)
X-Received: by 2002:a05:6000:481d:b0:484:36c1:2881 with SMTP id
 ffacd0b85a97d-48586e4a5c8mr52265617f8f.2.1788801847048; Mon, 07 Sep 2026
 10:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260905014629.991586-1-apolivodaa433@gmail.com>
 <CABgObfa4+CzMVN4xj=71cfJL6eMdMWqCoEvQ5RKvPNcR79XO4w@mail.gmail.com>
 <CAGscdFt0cJOaB+5P4YcSEbC7zAw8ZCnnfFQWBki-P+KXVtW-gw@mail.gmail.com>
In-Reply-To: <CAGscdFt0cJOaB+5P4YcSEbC7zAw8ZCnnfFQWBki-P+KXVtW-gw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Sep 2026 19:23:53 +0200
X-Gm-Features: AcwNN1VUh0c6hNrn-iWCmCzMprdLGA_suV0TD_WgqT6dA_n0TLHZZ1kQO1GpHoI
Message-ID: <CABgObfYYsQRAvfoaJcp+y=BKjmg8OV75LetTcXvs122jOq-NhA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: ignore VEX.L when emitting VROUNDSS and
 VROUNDSD
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 6, 2026 at 5:44=E2=80=AFAM Andrey Polivoda <apolivodaa433@gmail=
.com> wrote:
> After running some tests, it looks like the behavior of (V)ROUNDSS,
> (V)ROUNDSD, (V)MOVSS and (V)MOVSD is actually modified by this patch.
> (MOVNTSS and MOVNTSD do not generate different TCG ops with and
> without the patch applied. However, the VEX prefix
> is actually illegal for these two AMD-specific instructions (tested on
> AMD EPYC 7763; material for a different patch, I guess))

Thanks for checking that, I had no idea!

> Also, VSQRTSS and VSQRTSD are actually raising an invalid opcode
> exception when VEX.L is set
> That's because:
> 1. `vex_special` field of VSQRTSS/VSQRTSD opcode entries is set to
> `X86_VEX_REPScalar`
> 2. For entries with `vex_special =3D=3D X86_VEX_REPScalar`,
> `validate_vex()` raises the #UD
>     if `(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) !=3D 0` and `s->vex_l`=
 is set
> Intel Core i3-6100 and AMD EPYC 7763 do not raise #UD when this
> happens. (looks like another patch material)

Yeah, please check if this can be done in a single step. Maybe with a
new vex_special X86_VEX_REPScalar_Unary or X86_VEX_REPScalar_LIG.

Paolo


