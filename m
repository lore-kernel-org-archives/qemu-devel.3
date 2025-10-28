Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D221CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhHF-0003Vr-JF; Tue, 28 Oct 2025 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhH4-0003Nh-Q3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhH1-0006CJ-Mx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761648593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDKu8X/vzeqsKQ1aJgCzOFxraw+oSqhkt9VP9fNBAjw=;
 b=XY3nPPRWV5UAWbjqMoZz71wNxJomFdhSYxhLRIu+0kSpgRWjn4p3Rre/7qsF8YaXwUAFmz
 JAkXoJORJbKlDpR1QdJvkFrs1WQhc9lImfpN6B2hrBxNEbDR/EOjhwDSh4FDOFizvLW8QK
 eoNAoEsJBxhZLm55EMrQIpmPkIyvWNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-7Mv2sDoQOei7IjE7JCZZXw-1; Tue, 28 Oct 2025 06:49:52 -0400
X-MC-Unique: 7Mv2sDoQOei7IjE7JCZZXw-1
X-Mimecast-MFC-AGG-ID: 7Mv2sDoQOei7IjE7JCZZXw_1761648591
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4770e0910a1so13109855e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761648591; x=1762253391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDKu8X/vzeqsKQ1aJgCzOFxraw+oSqhkt9VP9fNBAjw=;
 b=icT+bfLJec8G/A7hZ23DnPWLjDNbp23v7CA5b543FMk3+vIFlQwOplz5iu8U3dUED2
 8cUH/J8lxa0B35U+C17mf3jbBFtR6gjQ7wNO3oBrOep5IpO6C/bwv4kSIGkj0wM6zV9u
 QKiBRy0S98nSiEwKclC80gPTloQLAZsvMy9mx9PYA+v4//FZw1I8P+YA49xiYj+N8Y8h
 ftUHIfZAPVeSY59Pmcpa4hZaHaafhUmEVedFU9evy7zbWr05SAQ+zAVaTNPlRy9rFywY
 EBIy4QYxNGgo/qNHOAhQqDfLp7jOStfbrcgHt+nVeGupl8jTloXrlGGKDEbA130vkoST
 Pe0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9FSTbtXaKG1ygDj1uGgwLgf25ihGSbJ08gaLHp+scfwbckXmKCq4YHfvJjy3bzXR9L+rS2/t2dwPm@nongnu.org
X-Gm-Message-State: AOJu0YyyVXZGFBxI+gEPVdGO46QUqzm8ENqcI5V/7Cpk4Uqg6wzd32mM
 UzOkVxYBvPGY3/XghznKjiGEbIW1gkrjzHjRwPtYKps7koHdDJxwBI939WbTb6aFXFmBDr1iebf
 l2YS7mgUNZdHUyYdxrvt3KTfO38Mrd+xTJ9RJp5BYqE+1Oox6a4aA7Cn6gcvG6xysAk2vyp0tVl
 jygA1/mUjrtzBoWwsf6a7JBuvt/u7ycmY=
X-Gm-Gg: ASbGncsGoIYOEX9ksuccDmyB0wnFqivuPgSVfX+lTgTyAxUckYz6qCln8iAkRtcP5AT
 S/f8c/Fv94fYmtXA0rzqVmNWTthNXnjOiBP5pZjHtZBAATww5j7f+fwqlCMxKwzxcS7CJQG90Dm
 HIGVctIoW9fQrqOzWnobzwLJyXV1QEdAS/G2WgVw23GB7qXSb0Pdwd4axOLACAOKKVqXys6pHMN
 ilvInIaSaIo0faxN4VZzi8Mhreqn010KNY5hEFIaXEi1rEkSFUijPKCIXij
X-Received: by 2002:a05:600c:620a:b0:46e:7247:cbc0 with SMTP id
 5b1f17b1804b1-47717e0aa72mr24971755e9.18.1761648590693; 
 Tue, 28 Oct 2025 03:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWEY3Fi4wag+xBCLIssc77LyvOrOfMbZOrzQ2hllJ1vPTmYHJB401bprx5nGCb9UKLuO1tZi1XrMwR7G5rVoc=
X-Received: by 2002:a05:600c:620a:b0:46e:7247:cbc0 with SMTP id
 5b1f17b1804b1-47717e0aa72mr24971515e9.18.1761648590294; Tue, 28 Oct 2025
 03:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <45032bb11a9006cb7a6e1c30ca6299d40cef614c.1761644606.git.chenmiao@openatom.club>
In-Reply-To: <45032bb11a9006cb7a6e1c30ca6299d40cef614c.1761644606.git.chenmiao@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 11:49:38 +0100
X-Gm-Features: AWmQ_bncIPp5h9_69AGsQpcKIQnL71jq-cW22OH3deNdatCTdOkGumP8EzX_9Mw
Message-ID: <CABgObfbeka+fKixBH8F_Fkprvk8oi+dTss21Vn5kYgm4sY0A8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] rust/hw/core: Provide some interfaces for the
 GPIO device
To: chenmiao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club> =
wrote:
>
> In irq.rs, we added a new get method for the InterruptSource type to dete=
rmine
> whether an InterruptSource is null. This eliminates the need to repeatedl=
y
> call self.cell.get().is_null() for null checks during comparisons.
> Additionally, we exposed the slice_as_ptrmethod to support external usage=
 with
> the &[InterruptSource]type.
>
> In qdev.rs, we implemented the init_gpio_out_namedfunction, which corresp=
onds
> to the C function qdev_init_gpio_out_named. We also refactored the
> init_gpio_outfunction to reuse the init_gpio_out_namedinterface.
>
> Signed-off-by: chenmiao <chenmiao@openatom.club>
> ---
>  rust/hw/core/src/irq.rs  |  6 +++++-
>  rust/hw/core/src/qdev.rs | 12 +++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
> index e0d7784d97..dd5d0cadbc 100644
> --- a/rust/hw/core/src/irq.rs
> +++ b/rust/hw/core/src/irq.rs
> @@ -71,6 +71,10 @@ pub fn pulse(&self) {
>      pub fn raise(&self) {
>          self.set(true);
>      }
> +
> +    pub fn get(&self) -> bool {
> +        !self.cell.get().is_null()
> +    }

This should not be get(), but "is_connected()". Also it should be
implemented for any T, therefore in the "impl<T> InterruptSource<T>"
block below.

>  }
>
>  impl<T> InterruptSource<T>
> @@ -91,7 +95,7 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut bindings=
::IRQState {
>          self.cell.as_ptr()
>      }
>
> -    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindin=
gs::IRQState {
> +    pub const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQ=
State {
>          assert!(!slice.is_empty());
>          slice[0].as_ptr()
>      }

Since you are not using this, you don't need to expose it outside the crate=
.

Paolo


