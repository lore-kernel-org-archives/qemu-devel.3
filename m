Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E7D2124E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1M81-0007jX-Rh; Thu, 17 Oct 2024 04:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1M7x-0007ig-B8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1M7v-0000q3-D8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729154698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEdlJvZDyVcDVgRuu8w1WnFhudPKC+CHeDABO6ByltY=;
 b=I3rG9x3CxDrI6AKBajgsJ+G8Tx+QE9ZOTBd8Yu26IYAK1nbVWIsumelj0G233Cs7Bf3KKr
 RiHvY2TZhLXmFT4L7y5yV50XV332S6CERkTNhkWRs3/bTak2silrdQtUu/KTqSYtj8YGg1
 0mMFekkwb2fiGm4t/OuBzLqcMqt5CUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3dUcTyEMObyl9KIQWM4vgA-1; Thu, 17 Oct 2024 04:44:56 -0400
X-MC-Unique: 3dUcTyEMObyl9KIQWM4vgA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d609ef9f7so339794f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 01:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729154695; x=1729759495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEdlJvZDyVcDVgRuu8w1WnFhudPKC+CHeDABO6ByltY=;
 b=RIFg+EMa1TExohVJmtxIYikKI+xTNIQMVZGgJ9I0jbEHHDUZG22+x7h2cXesEzU5/Q
 K0rQ8tWQ6ao70tcpJEg1lKoyKqILVtRUcP/6dKQN74j+BEaLS9WZPk6OZ5FHvoa9Bq3t
 wBmoPfGYWZZQb1Os6sjKbW4SffibpaBZ4SFdj2CBytTcNSwTjfc5gwZzWSTn4cw2HuDg
 2xbhsuej0Vj0VcWE4RciDrjC9Xa40RpPQaIWnMan2+24015TIJKPHDoiLV+oB/XYzs37
 ADT6WGceQnYXAq3Tiijv/Jqu+1r8jQuowuiKU4BaVqK0e3bPwNeXiydmt9WK5wB6XWap
 d2Zg==
X-Gm-Message-State: AOJu0YwBg+40Eb/yLRVMfU1OsuQf3U25xZ7Bhug5C41QcnFQKy/s6mzw
 4fYSRmuUF/FFtLOUmS/Ch78iaOqNqCeV2YhYRW9BPclhd5Q6QEtT+Q6TcFisi3z6jhtH6Rmk7bX
 H5cM+6F1j/uE7PLd5CE30Rs82alcvAcWf3a8Zxh7c3Rv2P1ITV7M4BXuXoHJcraf6opS/ibzlCJ
 7TRRXMff64JQOhhtdMDUvzs4UJFfR3pVBasc0cwlIR
X-Received: by 2002:a05:6000:4598:b0:37d:4e74:67c with SMTP id
 ffacd0b85a97d-37d5529ade4mr14329840f8f.39.1729154694837; 
 Thu, 17 Oct 2024 01:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC1JS/+Kpm5UzGADvdFGQuij9/ebBShtrY8jmanPjgfQ6LczeSkTpJcBt7Bjq0fWsHR7tVVIU05kXxfPS7OzY=
X-Received: by 2002:a05:6000:4598:b0:37d:4e74:67c with SMTP id
 ffacd0b85a97d-37d5529ade4mr14329831f8f.39.1729154694475; Thu, 17 Oct 2024
 01:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-11-pbonzini@redhat.com>
 <SY0P300MB10266B5144972CDF92AF065795472@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10266B5144972CDF92AF065795472@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Oct 2024 10:44:41 +0200
Message-ID: <CABgObfaX+KhYx3Wo8jGG_hLh_c6t=nYEPZt3FXKQMyOqivVDgA@mail.gmail.com>
Subject: Re: [PATCH 10/16] rust: introduce alternative implementation of
 offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 17, 2024 at 7:35=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> > offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemena=
tion
> > that was found on the Rust forums, and whose author agreed to license a=
s
> > MIT for use in QEMU.
> >
> > The alternative allows only one level of field access, but apart
> > from this can be used just by replacing core::mem::offset_of! with
> > qemu_api::offset_of!.
>
> How about a macro like this (which essentially comes from memoffset
> crate [1])? It has the same use as core::mem::offset_of! (except the
> same single-level limitation) and does not need wrapping structures with
> with_offsets!.

Unfortunately offset_from is not available in const context, and
offset_of! is needed to fill in the Property and VMStateDescription
arrays.

That said, I noticed now that declare_properties! does not declare the
resulting array as const, so that would be possible. But if
declare_properties could use a non-mut static, that would be better.

Paolo

> macro_rules! offset_of {
>     ($parent:ty, $field:tt) =3D> {{
>         let uninit =3D std::mem::MaybeUninit::<$parent>::uninit();
>         let base =3D uninit.as_ptr();
>         // SAFETY:
>         //
>         // MaybeUninit<$parent> has the same size and alignment as $paren=
t, so
>         // projection to $field is in bound.
>         //
>         // addr_of! does not create intermediate references to the uninit=
ialized
>         // memory, thus no UB is involved.
>         let field =3D unsafe { std::ptr::addr_of!((*base).$field) };
>         // SAFETY:
>         //
>         // Both base and field point to the MaybeUninit<$parent> and are =
casted
>         // to u8 for calculating their distance.
>         unsafe { field.cast::<u8>().offset_from(base.cast::<u8>()) as usi=
ze }
>     }};
> }
>
> [1] https://docs.rs/memoffset/latest/memoffset/
>
> --
> Best Regards
> Junjie Mao
>


