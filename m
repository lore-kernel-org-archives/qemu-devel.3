Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2608E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjZY-00022o-92; Tue, 14 Jan 2025 11:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tXjZT-0001yv-FY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tXjZM-00043z-ME
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736871303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA3KM01mV4/ItjrFH1ZGAv4l9SHuh0Ckd8svHOXhRjU=;
 b=USJWO2E+IkoApriANpNLG0ClznX/C2lpbYDj676pGfiA8N/JdJrFQ/Yzn+9UbG1pkWfmmx
 UngEgjS7JdFsKmBQd/kY3lIV2gZBJWG06rU7d8f+YYCtx08ngSn26/cTEt/zEVr+0XtRcC
 ns6sd5KOtRDsoFbFkuIL5dunk4ASbjM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-GtL1285gNP-Qa9OzgqhRug-1; Tue, 14 Jan 2025 11:15:01 -0500
X-MC-Unique: GtL1285gNP-Qa9OzgqhRug-1
X-Mimecast-MFC-AGG-ID: GtL1285gNP-Qa9OzgqhRug
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso2507706f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736871300; x=1737476100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cA3KM01mV4/ItjrFH1ZGAv4l9SHuh0Ckd8svHOXhRjU=;
 b=Ouj1Kh1RclkcmNTPJ8TaUh5ML32lIiRtUiEe6moIrjY9vpN6pA5DeFwdWdKP6cSVqf
 orFmYTynWwBZoJ3rvzj5DMLarFqIdUZAzJLuskiJgdDcvwZxyzmhtRMLzbAf5lXrZIOp
 3lolqykzVsJBqmOlwUVdfgZul2contOvixI0v3Y/PPJ81mwHvu9dVu6UHTCbdu7RRm5E
 ukuGqIws2D347Gm03djzykCusWckWIgfAUxvmERm2af5n+/SPpQbB8sm/bM4LZF3rsWz
 hfN9omLcJrCYAuGT6nfFVBljzhnsmWDJAuQuyENWxlGsUqk0/fJJIg34V4+xPXKs1nOy
 wPsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQgdCXO/EY+YVVGAVyp99VX2D2Zdw4odYjeNtSBU2edGEqzONx147mPgKj5CidlHsZKl+/loeqqL1F@nongnu.org
X-Gm-Message-State: AOJu0YzIvqKluD2CRwvxg3QpI0/U8Qut9Ir8jN9GoURxpOV1yybYBUIE
 /m/cEwfxxmaGJehOrn5mv59yf3BLlzcZOICNsLnQuVXPcgGEDQyqJUnljiKV08nkFoNN97AeVDB
 c5g+fFTH8Ci/SOLzAIcASg244Qx0tcpp1lCfbwyhbCg2XiugJycTw9O5Zug13QvAulUHIzTkeeO
 P1XAlOIEmyX+kNw6ogVTe2+QB4yqo=
X-Gm-Gg: ASbGncv/tNzoHgN3yujB31En40u7D8fBMG4WYdML4/aZ2a9ZdnFpmuXCQHHIB+pizFm
 plMeIQn+WmJdwvMRWiYhrTLgPIAowrqsYoVigx3Q=
X-Received: by 2002:a05:6000:2a3:b0:385:e30a:e0f7 with SMTP id
 ffacd0b85a97d-38a87309cedmr23008659f8f.22.1736871300128; 
 Tue, 14 Jan 2025 08:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGHfkrhPYs6NBCl/5zS+wIacAY/vpY0H6zjAxcUfNYXTaNmU2DDVyHRojx3O8iF+WBwhqitv9OzzAKsAf2JAM=
X-Received: by 2002:a05:6000:2a3:b0:385:e30a:e0f7 with SMTP id
 ffacd0b85a97d-38a87309cedmr23008638f8f.22.1736871299806; Tue, 14 Jan 2025
 08:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com> <Z4aEkLhcGVbXX82O@intel.com>
In-Reply-To: <Z4aEkLhcGVbXX82O@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Jan 2025 17:14:48 +0100
X-Gm-Features: AbW1kvYrjkMhZTsrV2uu6E97nb6WSrdFOfbkSjnsfQJxc8U4ExANOaCu5sCllUk
Message-ID: <CABgObfYRAYPBidb+cUPCrtdAEXGZiSG2hf5CvJskXmTpR1ftpQ@mail.gmail.com>
Subject: Re: [RFC 07/13] rust: add bindings for timer
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

On Tue, Jan 14, 2025 at 4:18=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> ...Now I have a draft for timer binding:
>
> * timer binding:
>
> impl QEMUTimer {
>     pub fn new() -> Self {
>         Zeroable::ZERO
>     }

Maybe Default too (not sure if you even need new())?

>     pub fn timer_init_full<'a, 'b: 'a, T, F>(

It's better to use longer names like 'timer and 'opaque. But it's also
always possible to pass a longer lifetime, so 'opaque: 'timer is
strictly speaking not needed: you can just use &'timer T which in turn
means that lifetime elision applies. That said, I think I like the
idea of using 'timer and 'opaque lifetimes here, for clarity.

>         &'a mut self,
>         timer_list_group: Option<&mut QEMUTimerListGroup>,

I think QEMUTimerListGroup can (should) be shared because it's thread safe.

>         clk_type: QEMUClockType,
>         scale: u32,
>         attributes: u32,
>         _f: &F,

Better: "_f: &'static F", or even "_f: F" if it works.

>         opaque: &'b T,
>     ) where
>         F: for<'c> FnCall<(&'c T,)> + 'b,

'b ('opaque) is not needed here because the opaque is passed _into_
the function (thus its lifetime is 'c). 'timer would make sense, but
in fact the function itself is always 'static (see FnCall declaration)
so it is unnecessary to add a lifetime to FnCall.

> fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
>     timer_cell.borrow_mut().callback()
> }
>
> impl HPETTimer {
>     ...
>
>     fn init_timer_with_state(&mut self) {
>         let index =3D self.index;
>         let cb =3D |cell: &BqlRefCell<HPETTimer>| {
>             timer_handler(cell);
>         };

Why is the anonymous function needed?  Can you just pass "timer_handler"?

> Is this timer binding as you expected? Hope I am on the right track. :-)

If the only correction is to the function declaration, that's as good
as it can be for Rust! ;)

Thanks,

Paolo


