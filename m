Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9713C0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpN8-0004Qr-6u; Tue, 11 Feb 2025 07:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thpN5-0004Ps-Kh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thpN3-0007RZ-4n
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739276885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eIgIbGsbGweqcbH3ykwx3MSydi/ybpdwPRW6m+E88Y=;
 b=CRwr9Zp+NJV2takYdhlF6eJZ8KNq0DqQkjIt6pKIUOI+qfmZxHuU1VwuoEvGU0ZRefEfdu
 K2nAubKutZe5K+XQhdkRTEZzQIprM+UQYqBOEai4SHFYUP0W1O90bl0rvYeLrGzioU2m8y
 WN61hch4ydduPoBITu8IHt0JuFPYsHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-u2jPUXS5NC2dm9eqc7DcWA-1; Tue, 11 Feb 2025 07:28:03 -0500
X-MC-Unique: u2jPUXS5NC2dm9eqc7DcWA-1
X-Mimecast-MFC-AGG-ID: u2jPUXS5NC2dm9eqc7DcWA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4392fc6bceaso17083035e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 04:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739276882; x=1739881682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8eIgIbGsbGweqcbH3ykwx3MSydi/ybpdwPRW6m+E88Y=;
 b=LO/38lQS79jl8M8TG4o3pVseQ8QLCT9J8gMT0rxhxWoa9rG5soAI2zRZE9J3afPqyJ
 Xua3gY9dwNoRMGx3qHncIupJ+6QdPv4cQiRaWJjHeN+YQN1ebPs66Hik0b5+WcG6COUg
 9cakzpEpk8oFItd9sdjFWx1FeHYv4xxmCDFyAsI1ofplTCg0p71abfIV8DlyEaBIYa/9
 /m2IjVno3e1P26Hk+oHMV5NC6NORcebFd27Z4vGSCyw6zPqHAfG0BMrzOWLlSk+D25sN
 V1fvBnwliy4JDi7J/TEdj6H8oWEIDTw3x+oRrtuiS/4Uq/Hy48bCmE6gWlZO25cGXLEW
 bgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq/cUmXXsIECSaOHR+zi/YMY0XULD1m3SHdktbKsDi43mgeeDKGUFbED+C2l4ppsAVzY7TCfNzIkvS@nongnu.org
X-Gm-Message-State: AOJu0YxBgFD0g6ShHAofz3Xt5abdsIF4XP2k3CZP6hioy6b3zG1GpbZp
 OKyyzIs6VkkxUMYX0xAKa/aKWhTc+BNawi//poc8DZI0526KgNfIX+DsBT0zLWkhp5Skk/8McSe
 Iv4p6cZtrzRhYbjhw10d5dftKMd8IaY9KM9Bj4QqCSfLKyr89TiG0YmABfMVW6tM1GGFTt5j6a4
 5fE5AP1APhW3ofM7XuuIwTcWxmi6I=
X-Gm-Gg: ASbGncs+ytt25huvBo+5HIlxwURnmw3kNXldVNcb3A70YFF1GvZd8zWOAB0CMYDKnJP
 /Bng4J4RCpdRg6SzGHqhf2vY+gwSbkIUsAFyz6GotjDEk/w8zDBKc5sDiPpsm
X-Received: by 2002:a05:6000:18a7:b0:38d:d70d:ada5 with SMTP id
 ffacd0b85a97d-38dd70db0ebmr8784999f8f.26.1739276882344; 
 Tue, 11 Feb 2025 04:28:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgIGxQMHvurR8V89j/3+xbfJzCth5rPQ0OvwfpJO5SQqTCMBdJf9wkmZd0WsOZsG8Qf+WeM2FYFqfretIti+c=
X-Received: by 2002:a05:6000:18a7:b0:38d:d70d:ada5 with SMTP id
 ffacd0b85a97d-38dd70db0ebmr8784976f8f.26.1739276881976; Tue, 11 Feb 2025
 04:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com> <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
 <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
 <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026E0CE5AFBEA4E713F73F595FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Feb 2025 13:27:50 +0100
X-Gm-Features: AWEUYZnw2WlYL0Tn6-OpomHwNVBisPRu_pyZ_14pGooKQ8dl74qI3G4xTJ80Kr0
Message-ID: <CABgObfaYNZ1JZddOhdGfMhPAVK+trX08B_wBS5MbvrUNdCGebA@mail.gmail.com>
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 11, 2025 at 12:34=E2=80=AFPM Junjie Mao <junjie.mao@hotmail.com=
> wrote:
> Essentially we want a naming convention that (1) avoids any potential
> name conflicts, and (2) applies consistently to (ideally) all APIs. For
> goal (1), we need something at API call sites that can resolve the
> potential ambiguity.

I now agree that (1) is more important than (2). Adding a function like

    fn realize(&self, bus: *mut BusState) {
        // TODO: return an Error
        assert!(bql_locked());
        unsafe {
            bindings::qdev_realize(self.as_mut_ptr(),
                bus, addr_of_mut!(bindings::error_fatal));
        }
    }

to DeviceMethods is enough to cause an error:

error[E0034]: multiple applicable items in scope
   --> hw/char/pl011/src/device.rs:714:9
    |
714 |     dev.realize();
    |         ^^^^^^^ multiple `realize` found

> So instead of dev.realize(), we may write:
>
>   a) dev.sysbus_realize()
>   b) SysBusDeviceMethods::realize(&dev); dev.realize() is still ok if
>      there is no ambiguity
>   c) dev.as_ref::<SysBusDevice>().realize()
>
>   (any more options?)
>
> None looks perfect, unfortunately. Option (a) introduces inconsistent
> naming conventions as mentioned earlier; (b) cannot prevent confusions
> when a device has both a "reset()" method and "dev.reset()" calls; (c)
> deviates from how wrappers are auto-delegated to child classes today and
> is the longest to write.

There is one more, which is a variant of (c): use Deref to delegate to
the superclass, and traits for interfaces only. Then the default would
always be the closest to the class you're defining, and you could
override it with SysBusDevice::realize(&dev).

It requires more glue code, but creating it could be delegated to
#[derive(Object)].

I think we can use (a) as proposed by Zhao and yourself, and document
this convention

(1) whenever a name is unique in the hierarchy, do not add the prefix

(2) whenever a name is not unique in the hierarchy, always add the
prefix to the classes that are lower in the hierarchy; for the top
class, decide on a case by case basis.

For example, you'd have

DeviceMethods::cold_reset()
PciDeviceMethods::pci_device_reset()
PciBridgeMethods::pci_bridge_reset()

PciDeviceMethods adds the prefix because the three methods have
different functionality. Subclasses of PciBridgeMethods may need to
call either pci_device_reset() or pci_bridge_reset().

And also, because there is a similar name in DeviceMethods,
PciDeviceMethods::reset() would be confusing.

(As an aside, pci_device_reset() probably should be implemented at the
Resettable level, e.g. RESET_TYPE_BUS, but that's a different story).

Or perhaps pci_bridge_reset() becomes PciBridgeCap::reset(), which is
not a trait. That's okay too, and it's not a problem for the naming of
pci_device_reset().

but:

DeviceMethods::realize()
SysbusDeviceMethods::sysbus_realize()
PciDeviceMethods::pci_realize()

Here, DeviceMethods does not add the prefix because generally the
lower classes only add casts and compile-time typing but not
functionality. The basic realize() functionality is the same for all
devices.

What about confusion with the realize function on the struct? It's
unlikely to be an issue because it has a different signature than
DeviceMethods::realize(), which takes a BusState too. But if I'm wrong
and there _is_ confusion, renaming DeviceMethods::realize() is easy.

> Just found the lint: https://rust-lang.github.io/rust-clippy/master/index=
.html#same_name_method

Almost: "It lints if a struct has two methods with the same name: one
from a trait, another not from a trait." - it doesn't check two
traits. Also I think in this case it doesn't fire because the trait is
implemented for &PL011State, not PL011State.

Paolo


