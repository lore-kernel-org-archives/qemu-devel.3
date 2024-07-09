Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB2C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRE4K-0004kU-9Y; Tue, 09 Jul 2024 12:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRE4G-0004jI-2W
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRE4E-0005uE-Dj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720543907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGW9fd1eBASCRWqSOirHjPcCU8llVEz8mzR6xpxjOCE=;
 b=NnKUIhzpF7/fej5rpEiut8H0xmiJJC/SE0Obarfa1O0XRSx19+PKUu9tHaF9yrp6PM110T
 MK367siFSWcI04OTJi/oZ2RAWBgZMytHYbBGBZVCA4hoiR2S+IXVlLnktiVzpWe+5RGX4C
 ah8xABIQvs2TG2CWAt7A+Qu8wtArfFw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-XQtyjvq9P6KIpjxA5_fRZg-1; Tue, 09 Jul 2024 12:51:45 -0400
X-MC-Unique: XQtyjvq9P6KIpjxA5_fRZg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3679aa0ee0aso3618212f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 09:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720543903; x=1721148703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGW9fd1eBASCRWqSOirHjPcCU8llVEz8mzR6xpxjOCE=;
 b=EFY5A+zV93c2HW+YXoTDjEvbDL1cXygAPznSjvoyj3sgsH9XnPF0Z4fGx/vzi9xKAx
 snnF7D+cE0YRa6u8ZLAiJ/B0Ch2zX09FQYV3nWJuE12fA0WJLHMCs/JXlc5T6tTPf7bT
 zukSbpNI0d5wi5vbjBNSgduJQp1CMd9w28bcYRvZP+V78WL09H+QS6QJZq4wVEhpUQce
 zyLKyTp6EDFs/zaD4JF2+OtqeEd2WJLFPx0O/ZlxifXVRFdeODcWYDmBN1yaafeDYVGV
 l0VO+MBprIH1sE9CBTpq+hRGzcD0oslrkWxw6BqGX0vBBFFcGe064fH0ccZrmQa8AMGr
 YspQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXroi5AZeuRYk5XZNKZ17eG1Ax6l/zdyPjk42BflQ2YiLmZuxnlrWy1iGZ5C2siZsHstOvZeyHM0F1HFNI8q3FdQ/EDM=
X-Gm-Message-State: AOJu0Yzsd/mZLz2N84QTStOBKZA/yp07ZuUYkM3ZqnelHFi2YxKoMqo3
 iNNPsP4xnPOrADcKMX+qN5ed/rP+xT6WL6zLUBwOk7qBl8mCB6UsZKkDtm3/m00CmHByoiesQVL
 s9eq9Fttu1J0pFp+rKoNcKGC72v1BO95y0K2rog9c+0vBzyqnCezwUDwsL7r9QrelxnoVePIoN6
 xpUgKf5PEhW2OAYvd9kj9PMbjvszw=
X-Received: by 2002:adf:ff86:0:b0:360:708c:788e with SMTP id
 ffacd0b85a97d-367cea67e9emr2180648f8f.17.1720543903657; 
 Tue, 09 Jul 2024 09:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2gKXBzejhL2xwNdmuTjFpMl0MDhpEMTN4IQfgkMKtwPbn4t6JAnuImfnRDREQV3fdw5FJeqFu4tpRpLGWlFM=
X-Received: by 2002:adf:ff86:0:b0:360:708c:788e with SMTP id
 ffacd0b85a97d-367cea67e9emr2180631f8f.17.1720543903247; Tue, 09 Jul 2024
 09:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
 <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
 <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
 <CABgObfb3mmxZy_cEeUTbuGCN-3Nqs8x8dkGy7Ehyowd9LNbktg@mail.gmail.com>
 <Zo0qh51MPlmfFVUP@redhat.com>
In-Reply-To: <Zo0qh51MPlmfFVUP@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Jul 2024 18:51:31 +0200
Message-ID: <CABgObfa+daKTnJ9ATCqFUHD=ZJK-KM+VDpMA6R_YPrvsGYx00g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Tue, Jul 9, 2024 at 2:18=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> My thought is that the initial merge focuses only on the build system
> integration. So that's basically patches 1 + 2 in this series.
>
> Patch 3, the high level APIs is where I see most of the work and
> collaboration being needed, but that doesn't need to be rushed into
> the first merge. We would have a "rust" subsystem + maintainer who
> would presumably have a staging tree, etc in the normal way we work
> and collaborate

It's complicated. A "perfect" build system integration would include
integration with Kconfig, but it's not simple work and it may not be
Manos's preference for what to work on (or maybe it is), and it's also
not a blocker for further work on patches 3-4.

On the other hand, patches 3 and 4 are _almost_ ready except for
requiring a very new Rust - we know how to tackle that, but again it
may take some time and it's completely separate work from better build
system integration.

In other words, improving build system integration is harder until
merge, but merge is blocked by independent work on lowering the
minimum supported Rust version. This is why I liked the idea of having
either a development tree to allow a merge into early 9.2.

On the other hand, given the exceptional scope (completely new code
that can be disabled at will) and circumstances, even a very early
merge into 9.1 (disabled by default) might be better to provide
developers with the easiest base for experimenting. The requirements
for merging, here, would basically amount to a good roadmap and some
established good habits.

An merge into early 9.2 would be a bit harder for experimenting, while
merging it now would sacrifice CI integration in the initial stages of
the work but make cooperation easier.

However, it's difficult to say what's best without knowing Manos's
rationale for preferring not to have a development tree yet.

Paolo


