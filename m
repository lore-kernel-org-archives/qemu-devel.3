Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF113C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPdyL-0003wd-Jv; Fri, 05 Jul 2024 04:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPdyH-0003w7-2n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPdyF-0001Lb-6P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720166825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEjEC6sehvIfHBNgCNtui0wa2SdRTKj0Lhc14yxDfXc=;
 b=Jh7Qwx9nAdW0oeS1dgkc67Ez7u6TrSm3NOVVYce1dAOrkFN+so1f3HhPZ3pODoUbijx+XY
 WWT06iUh2FFlz2bmFCPEjUUiG3SkOiWiAXwMGy1Kx+XYRqb3Pu9bIiUnBwW3ubp58zUzc0
 k+Vb6RJspsq+CuBZ+ml9xgBYcmlGUNo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-w8f3dtKIPOupRYB1FmgPJw-1; Fri, 05 Jul 2024 04:07:01 -0400
X-MC-Unique: w8f3dtKIPOupRYB1FmgPJw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36793373454so979304f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720166821; x=1720771621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEjEC6sehvIfHBNgCNtui0wa2SdRTKj0Lhc14yxDfXc=;
 b=UytCyQCsCTSA78dopYca8/dsVBjNd+38ZvSpfK/FC7yFu8ai9Rv5RQJPXYez520vTl
 CViDuuVQAZzWto15Ah6WvDwrBXXa9zsX7OzWO15XS0Ks0tHuB+esKXMytRq0a6OedWFY
 nlYXgq+kDywhdpJJMAd75YE2iPmBlD6+zjQxDcT8U8h3GqN0rGhuS2CLJsORAlo/2vWW
 3+7SHVOvqKtcCuh+uEbZ0oO1dfF5Z9zUIHGR1mc+WgKuvwXXot1FVATbxc0m88H1fIXn
 C5cQLnByhufpRN4D6dPVLxw95bRid73IdcAOjrQo3ClWGB9ZUEjC242mgSrVHp6xJxI9
 smqA==
X-Gm-Message-State: AOJu0YyOaYmwQrJ9zSm8eu9zyPPZBqDbLfzeD5Uqanf0yMEXndAPbXvu
 /ikPsNFcwTmUlqRuIo9EU5/9D9psHR5ldWuvDNGrEMsVVF5v/x9YsHBSAspI4lZrZmGpGbCve1Z
 cUTuMpip3RrWHR9owMZtFT0Nrxi/ItJ/sf9Szp6jFLJnNMpTtLh9Ba+L3XyLRB2S2FVa3ax2flG
 xpuu++DA0n8YU4tUCeCPfVtBizPWo=
X-Received: by 2002:a05:6000:154a:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-3679dd673e5mr3462477f8f.56.1720166820717; 
 Fri, 05 Jul 2024 01:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzZX1H4XxdBt8vDRikxVfvbfvzXIaWtrSt/w/urTNd2lcb69BUqdpuqMg2bZux63gRZRHez6uxCo/M18ksQaE=
X-Received: by 2002:a05:6000:154a:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-3679dd673e5mr3462450f8f.56.1720166820302; Fri, 05 Jul 2024
 01:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <0d85e013-1c38-4781-8fd6-5e837327f33f@linaro.org>
In-Reply-To: <0d85e013-1c38-4781-8fd6-5e837327f33f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jul 2024 10:06:47 +0200
Message-ID: <CABgObfZVWt4GkH_qAbWqoF7=xXP_mPopRqUbRFxii8Tki5YuBw@mail.gmail.com>
Subject: Re: [PATCH 00/14] rust: example of bindings code for Rust in QEMU
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 4, 2024 at 9:26=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> > Patches 9-10 deal with how to define new subclasses in Rust.  They are
> > a lot less polished and less ready.  There is probably a lot of polish
> > that could be applied to make the code look nicer, but I guess there is
> > always time to make the code look nicer until the details are sorted ou=
t.
> >
> > The things that I considered here are:
> >
> > - splitting configuration from runtime state
> > - automatic generation of instance_init and instance_finalize
> > - generation of C vtables from safe code that is written in Rust
> > - generation of qdev property tables
>
> Shouldn't we focus more on how we want to write a QOM device in Rust
> instead, by making abstraction of existing C implementation first?
> Once we have satisfying idea, we could evaluate how it maps to existing
> implementation, and which compromise should be made for efficiency.
> It seems that the current approach is to stick to existing model, and
> derive Rust bindings from this.

I think I tried to do a little bit of that. For example, the split of
configuration from runtime state is done to isolate the interior
mutability, and the automatic generation of instance_init and
instance_finalize relies on Rust traits like Default and Drop; the
realize implementation returns a qemu::Result<()>; and so on.

But there are many steps towards converting the PL011 device to Rust:

- declarative definitions of bitfields and registers (done)
- using RefCell for mutable state
- using wrappers for class and property definition
- defining and using wrappers for Chardev/CharBackend
- defining and using wrappers for MemoryRegion callbacks
- defining and using wrappers for SysBusDevice functionality
- defining and using wrappers for VMState functionality

At each step we need to design "how we want to do that in Rust" and
all the things you mention above. This prototype covers the second and
third steps, and it's already big enough! :)

I expect that code like this one would be merged together with the
corresponding changes to PL011: the glue code is added to the qemu/
crate and used in the hw/core/pl011/ directory. This way, both authors
and reviewers will have a clue of what becomes more readable/idiomatic
in the resulting code.

> I agree this glue can be a source of technical debt, but on the other
> side, it should be easy to refactor it, if we decided first what the
> "clean and idiomatic" Rust API should look like.

That's true, especially if we want to add more macro magic on top. We
can decide later where to draw the line between complexity of glue
code and cleanliness of Rust code, and also move the line as we see
fit.

On the other hand, if we believe that _this_ code is already too much,
that's also a data point. Again: I don't think it is, but I want us to
make an informed decision.

> A compromise where you have to manually translate some structs, or copy
> memory to traverse languages borders at some point, could be worth the
> safety and expressiveness.

Yep, Error is an example of this. It's not the common case, so it's
totally fine to convert to and from C Error* (which also includes
copying the inner error string, from a String to malloc-ed char*) to
keep the APIs nicer.

> > We should have an idea of what this glue code looks like, in order to m=
ake
> > an informed choice.  If we think we're not comfortable with reviewing i=
t,
> > well, we should be ready to say so and stick with C until we are.
>
> While it is important that this glue code is maintainable and looks
> great, I don't think it should be the main reason to accept usage of a
> new language.

Not the main reason, but an important factor in judging if we are
*able* to accept usage of a new language. Maybe it's just a formal
step, but it feels safer to have _some_ code to show and to read, even
if it's just a prototype that barely compiles.

> We could have a specific trait with functions to handle various kind of
> events. And the glue code could be responsible to translate this to
> callbacks for the C side (and calling Rust code accordingly, eventually
> serializing this on a single thread to avoid any race issues).

That's a possibility, yes. Something like (totally random):

impl CharBackend {
    pub fn start<T: CharBackendCallbacks>(&mut self, obj: &T) {
        qemu_chr_fe_set_handlers(self.0,
                             Some(obj::can_receive),
Some(obj::receive, obj::event),
                             Some(obj::be_change), obj as *const _ as
*const c_void,
                             ptr::null(), true);
    }
    pub fn stop(&mut self) {
        qemu_chr_fe_set_handlers(self.0, None, None,
                             None, ptr::null(), ptr::null(), true);
    }
}

but I left for later because I focused just on the lowest levels code
where you could have "one" design. For example, for memory regions
some devices are going to have more than one, so there could be
reasons to do callbacks in different ways. By the way, all of this
passing of Rust references as opaque pointers needs, at least in
theory, to be annotated for pinning. Do we have to make sure that
pinning is handled correctly, or can we just assume that QOM objects
are pinned? I am not sure I am ready to answer the question...

Paolo


