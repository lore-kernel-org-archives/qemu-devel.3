Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93589E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 22:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vspsb-0005N3-3i; Wed, 18 Feb 2026 17:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vspsY-0005MM-Rs
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:18:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vspsX-0007Nq-CN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:18:42 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43590777e22so190434f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 14:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771453119; cv=none;
 d=google.com; s=arc-20240605;
 b=jhpJUKDF+v4Av63Ke5JHBDzR15TtEHmqlEX6EbU+5m1mvf9o2Du1ymhnxYbPvtwAyh
 xLqI/A9NNrL++QazfhIgvgM5w7tg7tXvvs7RDoszTDfqtBcef5YTHtC0U7My+LkdtRhQ
 w8m8XDQ+8rgV3y29BaNVa7izpclIkQyLTa9D6UnaeTRIIA/VeUAiuUkW2jeHVZakCG/7
 qVlTD9MBYendvm3sWfJ3VR1DBVQTVp4xPONFlDerUpoM+idqjp8IBdKvwFj4OzoeWWhO
 w8BaSCzqxTLSZ3jxHpx207RZUBChumvGpWiRLEoDJPe8dT54ZoXEx3K/eQ8mbKa4T6XZ
 SmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kNLdJY+bDyZs3AuromPUlwhRlMeM8vZOB4FmPTCEEDk=;
 fh=FKOoIp1rxFO8urHSToKRxGpSRx1wX/uu9viThisijkg=;
 b=XeZtrGL6oYsflwXZWfmuNZTa3RHfoaXlSTi25WQ67Bw0Yo+LBDZJdfJ4OiFgc2FbHl
 JapGjzFc3x69RVsvtoXeSF6wlfi3/ha7jQWL60Z2BfHxyYZa95qr3B58t0lT25ryqgch
 4RYuTCMqhsDiMP2GLOYLcZgXOmWw7/40ZMFqYl80w1ExBLZaU1CREH5nKUkX5sjokvv1
 pUhcDt8OVw1nrL35WjmKSY9sa6ah5xzdS+Oc5yiBgYxXYVGDJYM39BuK0q/kXYNJjpY4
 caY9rEBUHhDzS5gIehpm2sQimva+RJQFW+N8LTYtRKE3XLENOI20HqAPfBRKl42fPTeQ
 oA2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771453119; x=1772057919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNLdJY+bDyZs3AuromPUlwhRlMeM8vZOB4FmPTCEEDk=;
 b=w1MSnC+HxhpD8OWnNb0dieSplIg73A65YH/L04PL2EinexvL79DubhMbLWNZsfh9fU
 ifI9kT8+BIhpyvEL9eOzMG/rarT/IR0ZLYqQyU5ZyqbgGEpV4a9RAmXUey2UhW/iRWos
 3qWUx+urI2pBy//dW2ijfKNM53eCIo6yGxX6j4teaKaMTMLIoRDK35+jQq4eRwTqXBp8
 SMs3ReD8hycDM+JBAByThJWKOWYwXoIYu0X94ddW2w+b3pn0urR+WCpOOYTQaJ+aJNDp
 5XfBxSuJkwfiCCOBN6QFAOF+VdYG7c+ONHdZNidFUK2NzifkhpgRj7KDV2i1o2IFsTGc
 fsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771453119; x=1772057919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNLdJY+bDyZs3AuromPUlwhRlMeM8vZOB4FmPTCEEDk=;
 b=ZVmUDKQZs3tdvIee6eoom4nFji9SYIKuiIE0tazv+Bz2EZW3g2P1oZa5IVRd+Qbtua
 /RTnl1wGP2g29dTJCONrXfpePSIPlmIfWMrKr1WcxyRkvdi87gf5+vrsCJ3wGVjmL8MH
 ssmn4IEagFht3onPfU55OUNaXw36fSFumtCvIcLaxOHzY0JBXOYe62pEY+xJk3r0ggUm
 2jdCC3QMuh0CDsdwOiTzuyhu2jqBIvRR84QUNFt6UqYzhu4eD9UXjyEfVLBjc48I68aK
 W3RTN/sVEQt7pth9DG1vc+2ywN0aqFQlpk49I5/AYxky3lEsKKhCYL0alGPRA+CRA80+
 0Cmw==
X-Gm-Message-State: AOJu0Yy7HWmlJ3dlbs90DBj3+j+QtwS5wsDOXIsNn/uK+WU7nYJ9Vq89
 vTV4Vz6v05BMOu40RcIwLkNUcyL3/gGlb1Tff0ItW3+eIVAzH8tqHBwVIm49ayB8ty8TCe9SzYx
 GQksYMvE++L1AVpgiSiQOInJ26RzMlw5959xPZKddNg==
X-Gm-Gg: AZuq6aLWLJsToHKJ/cy1psoickQL2JBTawhTfxI8WSf1EKRewEsRleAMPonpNDYwz2A
 xapmtDH+3GnKJnwuv7Lrqz23f1/ubmYfr/HO+PaxwP9/1yjMbXmGQjeXPC0Oy7vwBEsLZoV9342
 9TqSqVSkMqfjRSieaRhnKl0UlINAv2AaNqBoAAyshVut+5Sod+L2GC27ovjDCpGokyJOXPGVawI
 aOOp3VEFuLBw/zelCMI2RGlhds39KZ0TXrj50l6ruPfGCYzMXoMYAfScRkP8RSaSUMbbTj/KoCm
 w2AmpGtbxwQJMpMGYl+jxle5kiRkIywI7pEKVKAN/9sF6YyOKg==
X-Received: by 2002:a05:6000:4312:b0:436:233c:c7c2 with SMTP id
 ffacd0b85a97d-4379db33f54mr26262939f8f.16.1771453119201; Wed, 18 Feb 2026
 14:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20260218192444.658046-1-jsnow@redhat.com>
 <20260218192444.658046-2-jsnow@redhat.com>
In-Reply-To: <20260218192444.658046-2-jsnow@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 19 Feb 2026 00:18:13 +0200
X-Gm-Features: AaiRm535NhTbxtVoNzWAkZd10x104joM_zkHi6QJ3UwISn6egz6codQUPm4zWQg
Message-ID: <CAAjaMXYmdTmKRXMs83DH6Fw=BDg6_KiHgOTghFG5MLmEt9nGqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: use checked_div to make clippy happy
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Wed, Feb 18, 2026 at 9:25=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
> complaining about not using checked_div instead of manually checking
> divisors. Make clippy happy and use checked_div() instead.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/hw/core/src/qdev.rs | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index 145e20a984f..c4a7312168f 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
>      }
>
>      pub const fn period_from_hz(hz: u64) -> u64 {
> -        if hz =3D=3D 0 {
> -            0
> -        } else {
> -            Self::PERIOD_1SEC / hz
> +        match Self::PERIOD_1SEC.checked_div(hz) {
> +            Some(value) =3D> value,
> +            None =3D> 0,
>          }
>      }
>
>      pub const fn period_to_hz(period: u64) -> u64 {
> -        if period =3D=3D 0 {
> -            0
> -        } else {
> -            Self::PERIOD_1SEC / period
> +        match period.checked_div(Self::PERIOD_1SEC) {
> +            Some(value) =3D> value,
> +            None =3D> 0,
>          }
>      }
>
> --
> 2.53.0
>

