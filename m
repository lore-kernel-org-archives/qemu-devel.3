Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADFC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYeQ-0001Tq-0o; Wed, 10 Jul 2024 10:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRYeN-0001TD-PU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRYeK-0002KV-A4
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720623025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTQF8I4AjNdwfmLU5346+ZduhvobbqbeU232uWe4qhI=;
 b=HbLcqZMDSQV8YLyVsDLquoq9HjrtLu5ZgJOhc1BUh+5I6aUrFr7EkCBJK0SOmBKw3QOlbo
 RxBeht8VDERYRnDEWQwcaTHSAKU5lm4MLqkxva2HT09qAMtOhhkAMBrXKRlgJdzlcvZfcO
 hIPzMvuxkYkoflOl5bhNNSRrxTyAWgs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-2INTPuGVMSGYD9ins0HQtg-1; Wed, 10 Jul 2024 10:50:24 -0400
X-MC-Unique: 2INTPuGVMSGYD9ins0HQtg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367a531a2f0so3208841f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720623023; x=1721227823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTQF8I4AjNdwfmLU5346+ZduhvobbqbeU232uWe4qhI=;
 b=A2lw69SMDDpYiOgV/mlrwa/k8SNFWOJsGA5Kjwv3W1899qJkHkwbyvS60z1w6bt1SV
 RK4TTrllz6lDgfM/9mgtcKAc2Bdf3NkurSG+FFeFRuX/ES8+ybvMO0yazZ9Pxo5OwoLt
 qjm9izyxzUcaoht5VTIMXdYcWXl/Cq1Lbey3AtJfpTJF/UF7j4lItbQs3q2UVr3J5utG
 14ZVPmehRCDWtpL0bOEQXSJYiqZDOm4FrcBrkFrHn59Pza0x/EZU41GoCHCsfqptcK0t
 Ds/UNQ0tBxhgFF7lqI+a4BNM17AsDRig3v89dEQAAuLYEaJhvRMJy8drjHTHat1kJDmz
 YsTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYq1iKJrpIvXQUfzNZ85BnLpBLw3mIBUmqFi8ztmKEQVNbSKSas90lIm6SCfpiOX3B7Mq2FSjEAsWQIljxZDRKlLf122M=
X-Gm-Message-State: AOJu0Yyvd1veHa0gKqUv8ua1/nZ4cQZzlyI4WsgYVbDVJb9CJKO6esUq
 sbXcwmtEzoC4Z3u7xOaEIHsCKAZysomL4/tgyez5DsYzJoKHc4TXdYu3j53k5QzExEo2jx4E8Yw
 EI3Q9TV0KyQ3PAsVA7ABr/20dcVDN4bcbpo7cKLxhvrnsiVLUsJ6PSkk1KU/09OtbpmvebWi1Rq
 euKrCNxJbka8CL/hzacSWJTRFZllk=
X-Received: by 2002:a05:6000:1e4c:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-367ceaca9bamr4342896f8f.52.1720623023635; 
 Wed, 10 Jul 2024 07:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA7dhrfCHESpeuqU8vrDtqzZSfWk02h8GCNzT/pIM6eKobXBH3wqmkKYuGjzAepCCI4DtdALIFOBnDxDx0pdc=
X-Received: by 2002:a05:6000:1e4c:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-367ceaca9bamr4342872f8f.52.1720623023322; Wed, 10 Jul 2024
 07:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
 <Zo6iuEfo7o+7SIoY@intel.com>
In-Reply-To: <Zo6iuEfo7o+7SIoY@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jul 2024 16:50:10 +0200
Message-ID: <CABgObfZGLd5Uj9CV-8v=QdGFjN53ZUKhqXjobzpk7tJjYYZj1A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 rowan.hart@intel.com, Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 4:48=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> On Tue, Jul 09, 2024 at 02:28:38PM +0200, Paolo Bonzini wrote:
> >
> > Here are the stopping points that I found over the last couple weeks:
> >
> > 1.56.0: 2021 edition
> > 1.59.0: const CStr::from_bytes_with_nul_unchecked (needed by cstr
> > crate, see below)
> > 1.64.0: std::ffi::c_char
> > 1.65.0: Generic Associated Types
> > 1.74.0: Clippy can be configured in Cargo.toml
> > 1.77.0: C string literals, offset_of!
> >
> > I think 1.59.0 is pretty much the lower bound. Not having offset_of!
> > will be a bit painful, but it can be worked around (and pretty much
> > has to be, because 1.77.0 is really new).
> >
>
> An additional question: does our minimum rust version requirement
> indicate that users with this rust version can compile other
> dependencies that satisfy QEMU requirements, such as bindgen?

Yes (though in the case of bindgen, like cargo and rustc, we'll use it
from the distro; Debian bookworm has 0.60.1 so that's what we'll have
to stick with).

Paolo


