Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539FACE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKujD-0004zy-S6; Mon, 17 Nov 2025 03:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKujA-0004wS-Ih
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuj8-0005Zc-SB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763368604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Snd5dpE1c/1fq4z3opAqdonNA4kWh1wLIwKMHTA2U/0=;
 b=FIHeLnMYoQuRGko8EnDo9IgSH5tWhAMh2gtU5SRM2yyFARnfGS8s/p69gneFFIy6Okz0T7
 01T5qhzza/LYtrd7OIuKkVu5cSVxUmr1WeRidF1NMtiddmr88lOdAtUVSAa45Dm/YW8FxU
 AVIs4QndTqUBnc25ByULRjXEhLBaTpk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-KpDaSDHHPXWNbFdTSUmBGA-1; Mon, 17 Nov 2025 03:36:43 -0500
X-MC-Unique: KpDaSDHHPXWNbFdTSUmBGA-1
X-Mimecast-MFC-AGG-ID: KpDaSDHHPXWNbFdTSUmBGA_1763368602
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so2080950f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763368601; x=1763973401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Snd5dpE1c/1fq4z3opAqdonNA4kWh1wLIwKMHTA2U/0=;
 b=Y5iRBBEI6FWDGY8/NapcfEEobdBelshIPSanP7N5Hwd0fEgvWjRp20yOqdmmd0pZXr
 xH1X9ONCuUSQYuR9BJg24oNQQvOlaMHB4sfEHhezHjzAiaa+uKPIPdwo9eopouxGpTCL
 egfgOunKAQyWGBjW74LqzEfRkHtSg3bJ97Ej/cNRDplMILYn7braUA12jdkX/uDUn4KW
 HmOOUsE9d//O91L8HTVNmWazKMHDc4WlaWHq0TdIlq9JyTmF2Sa6mB7M1qUaRPcHPjND
 K89wFnRLoeODYPmL1x0vdRGnXv4bn3pN4+hgiDBhYUkw8YZH2O4kl1I1Po/bVOLauduf
 pfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763368601; x=1763973401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Snd5dpE1c/1fq4z3opAqdonNA4kWh1wLIwKMHTA2U/0=;
 b=gDGIgaDPsUWrfElGpmqTEwYcMfqGUqAvtUpURmKSkBMajntiFJasYXF6D6vh1fDwyP
 gKoN0ebyom6opWZImBTBTO8Mdhj85XUY6UV9G9/Vx4rH17ZDpN3hkDDSdnGPoAby3FZc
 qQPZa2xrt08MCuFWAqAAhRwZPgsU/ymA8Sx8ZyUbZ5jJ46GTp2knZlE9uRmO+Ut6IBMe
 iiAg7o5ASorHh1ontRjHs74qNFRduhyjMGlyfFjnVB1ljMH18Bwx45pLDuQ8L7pVWLP9
 8nbKOMGtH/LWZabrSBkPjY2TlNbIWgc3W5sMyr8++YYKGtwRu1u48708NifydXUpuNGs
 pxVA==
X-Gm-Message-State: AOJu0YxjhAGtYmXNIZmHFX9T6Mkrnf2AQXVdXqY5ZC0ztF8XIig4ytok
 vfbiWtJxSnX5YZPp6fywLeSOEgtit5MIzhGbKlXBJPYI5RsbQhf15p3g6L7MXIOz4hSARVRWCV6
 GrDzTGge0x0wWcrC7oVZ1LDWO+ETcKPxd/jPB+gsKTQqIwpNHk78rP2K6jsGL32vn9IdFU6Vwyd
 wmfqSV2jwXxjuYkIaP0NGPeNULGvQT8B0=
X-Gm-Gg: ASbGncsmaJmx+tPCcvXz3BisBsznvb8D1CTbWMkRIaRjRSuWwAbkcx6gjRW9mJ4TwQm
 tJd1Q6aJHTjJEzfpdPZB5Goh8ivQ3V8KlJQaTX1pHiO3bKZmykHV7kH7GLTePDWbAU+8IImxRXp
 tOyfy1SJhNZz4V4VgPFxd6zz5KW766k7k1I2+RhgltIxAwojMmR34Zr6RenEhizmrfQxd6iw7FK
 lVgAdvkyhVBfvhHwUhYEgHAbrDVdHIv1J44vAcSyDkvyEWlQwH5qXZXL0+V
X-Received: by 2002:a05:6000:2f85:b0:42b:30f9:79b6 with SMTP id
 ffacd0b85a97d-42b5938a9a1mr11165549f8f.58.1763368601524; 
 Mon, 17 Nov 2025 00:36:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjV3uHWjABRuwu7nZ6NEzQ/NPivrgsyqz/npqBHCRENysdFAEq8JY8mCrT9uX68IVAThPJ1IJu4fWC9fUF1iI=
X-Received: by 2002:a05:6000:2f85:b0:42b:30f9:79b6 with SMTP id
 ffacd0b85a97d-42b5938a9a1mr11165522f8f.58.1763368601051; Mon, 17 Nov 2025
 00:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20251117074239.190424-1-pbonzini@redhat.com>
 <CAJ+F1C+B1amkaS0ZVJZFp42g1e9shdhnmjQYx8CDuv3vQ+Jzwg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+B1amkaS0ZVJZFp42g1e9shdhnmjQYx8CDuv3vQ+Jzwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Nov 2025 09:36:26 +0100
X-Gm-Features: AWmQ_bncGOB71UIM0goHWRuJ162_nbYEVhvXJWM6uSkwjWkrWi_XMoQziET-hKY
Message-ID: <CABgObfaoTEaOO78+s+ZhqUT62=iS=sVUOFiahwAYkL1EuuW6_A@mail.gmail.com>
Subject: Re: [PATCH 0/8] rust: add preludes to all crates
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Nov 17, 2025 at 9:03=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Nov 17, 2025 at 11:43=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >
> > This series adds a prelude module to all crates, so that
> > it becomes possible to import from each crate with either
> > of the following
> >
> >    use XYZ::prelude::*;
> >    use XYZ::{self, prelude::*};
> >
> > The latter is used for items that have a "too common"
> > name to be put in the prelude: util::Error, util::Result,
> > migration::Infallible.
>
> In my experience, "preludes" are not so ubiquitous (except the std
> library). The use of wildcard imports is not encouraged, and may
> result in conflicts.

Yes, I agree with this.  On the other hand, we already have lists of
imports that are two-three lines long and I'm afraid that people would
prefer to just import migration::* for example.  While we can block
them with -Dclippy::wildcard_imports, the problem is real.

So I was a bit undecided and went looking for examples of crates that
do have a prelude. I first noticed that bevy has a similar system,
with each of its crates providing a prelude.  IMO QEMU is a similar
case to bevy, where most of the code will use structs from the QEMU
crates more than std, so it makes sense to have them. Futures and
Tokio also have a prelude, and they also fit the idea of crates that
provide a programming environment.

Preludes let you import libraries with a level of detail similar to C
includes.  For simple library crates that offer two-three types it's
not necessary to have one, but as the complexity and number of crates
increase, they provide more clarity.

Another thing to notice is that the QOM bindings work a lot with
extension traits implemented on all types.  There should be no need
for users to know the difference between DeviceState, DeviceMethods
and DeviceClassMethods. Preludes help with that.

> Also, it's often subjective what you put there or not.

Right - for now I just defined what should *never* be in a prelude:
the rule was simply "do not include anything that can conflict with
std".  This should not be that bad, otherwise we'd have similar
problems with C includes as mentioned above.

Another thing that should not be in the preludes without extremely
good reasons is enum variants; Ok/Err and Some/None are the only
exceptions in the standard library prelude, and they should probably
remain the only ones.

Paolo


