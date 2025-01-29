Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F9C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td4vc-0005WX-Bb; Wed, 29 Jan 2025 05:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td4vG-0005TW-QA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:03:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td4vE-0001r3-O1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738145027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+F3okHwWkg0OXxkny/J3TL1cy7Ca6BTuE7DFW3H/2ww=;
 b=XcCQIYUqnUT9YAaNrrlMeoaJscR+HQh6mOj9dM3KywUHfnLfNL1PXMSGUmhQV37vEth74s
 zC0yaQRNW9I0z0TTqnoXxn4c3iHE8McSotT8vHJkC1D1ufYcvGhORxslbKcHVxoNlWHLEv
 /lrFXPpKPhLb47MlbwberQ4yoqEuRJQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-y8yeHUVPMjm0x_K2jt5CtQ-1; Wed, 29 Jan 2025 05:03:44 -0500
X-MC-Unique: y8yeHUVPMjm0x_K2jt5CtQ-1
X-Mimecast-MFC-AGG-ID: y8yeHUVPMjm0x_K2jt5CtQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38c24ac3415so5413514f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738145023; x=1738749823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+F3okHwWkg0OXxkny/J3TL1cy7Ca6BTuE7DFW3H/2ww=;
 b=IQ9rCPwgtho08gWcUekjsgVGoEEaS5WReAMv4pg+WOaNYS6QxIe/WoyFgh2hYVMXBZ
 LELaykehqjn/Jr1SZlHhT8Qc1xu0k7PeEBmX4WlEUHgE2gnEjIY2hugI/FpD447PSjcY
 hTIZublb+zJtvD3tyu3n5SvRDixhRcEUYOWFYVPtALjXVvVYvRAtWjFzU5FCXMGsCtpr
 zH32F+BahFqXwSB/8WzeEAzN6JghgqD005/pACT7x05q8qInOW6HxzxsF0FMxmdyWi/6
 sRwLMLIMd+9xG9G8pdC2RAnpS/zaqsJ/A6Q8L7ljMG1XBtwyDwUKkVH3shMQ1jHxG4df
 3hMQ==
X-Gm-Message-State: AOJu0YyZG/SsECJD/Qdy0BueVO/EPQ4jXjEp7AuXJhvUaeaQRlB7TZMv
 CnnQjrWIBUAzrJyn1ZABR1Gq3lrkn8xXYPh1gBra7afvdclP6GnuGiQhde0KVpydSDE1Lxb8Lst
 JvFvh4hlDP2Qwq4Wo+BbFl9hMV8KAlHzzW4Od7E9Q/0GclW7VFgQfHi15B4PIuXlQQbTvMQOuuH
 9Jw9cUBZN6uNAXoB4M9K9oP8aW+vI=
X-Gm-Gg: ASbGnctXzJxi5F81FnoNzxvqoexUMEwImiNsA2Bdb7SMqGmtAAf86IUzvMJQ9AxCrj3
 Hvc7xTpEVhwJzf8YjMrOMIeJn5FbNK2x0SZbJ3NH+ewlgaMU+lbRattdNI3RH
X-Received: by 2002:a5d:518f:0:b0:38a:4184:152a with SMTP id
 ffacd0b85a97d-38c5196a391mr1580628f8f.28.1738145023387; 
 Wed, 29 Jan 2025 02:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4/btLbqKPxOkC4OmpVsZgHerM5ledUTtQPiDd1fKbdmVAa2xvw+gV7/QajT/tzxzIt9bU8+fMq2lDtIZvVJI=
X-Received: by 2002:a5d:518f:0:b0:38a:4184:152a with SMTP id
 ffacd0b85a97d-38c5196a391mr1580594f8f.28.1738145023064; Wed, 29 Jan 2025
 02:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
 <Z5ZRnYDZdZcgyCsR@intel.com>
In-Reply-To: <Z5ZRnYDZdZcgyCsR@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 29 Jan 2025 11:03:31 +0100
X-Gm-Features: AWEUYZmeIuW4JSWbg1IrDyCA_2MmWvOct6_kvul0XV2OusmvWiOmiUpKbwig6t0
Message-ID: <CABgObfZ1659K9TrAAa3HYfhr0vf31eveoN-=33rSmpJnLo1RKg@mail.gmail.com>
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Jan 26, 2025 at 3:56=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Paolo,
>
> On Fri, Jan 17, 2025 at 08:39:55PM +0100, Paolo Bonzini wrote:
> > Date: Fri, 17 Jan 2025 20:39:55 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 02/10] rust: qom: add reference counting functionality
> > X-Mailer: git-send-email 2.47.1
> >
> > Add a smart pointer that allows to add and remove references from
> > QOM objects.  It's important to note that while all QOM objects have a
> > reference count, in practice not all of them have their lifetime guarde=
d
> > by it.
>
> About the background, I have a maybe common question...why Rust needs
> extra reference count guarding?

Children properties are removed, and thus their reference is dropped,
before instance_finalize() is called (see object_finalize() in
qom/object.c). This is not valid in Rust, you need to keep the object
alive until the last line of Rust code has run - which is after
Drop::drop() has run.

> Additionally, I felt that the ref count may be a bit confusing. After
> creating Child<> property, the child object's ref count is sometimes 1,
> and other times it's 2:
>
>  * With object_initialize_child(), child's ref count is 1.
>
>  * With object_property_add_child() (usually after a object_new() to
>    create child first):
>
>    - sometimes user will call object_unref(), and then the ref count is 1=
.
>      E.g., x86_cpu_apic_create() in target/i386/cpu-apic.c.
>
>    - sometimes no object_unref(), then ref count is 2.
>      E.g., exynos4210_realize() in hw/arm/exynos4210.c, creats "cortex-a9=
".

In C, having a ref count of 2 is usually a latent memory leak (because
most of the time there's not going to be an object_unref() in the
instance_finalize() method). In this case the leak is latent, because
TYPE_EXYNOS4210_SOC is not hot-unpluggable and thus will never really
go away once realized.

In Rust, this class of leaks simply does not exist with the right API.
ObjectMethods::property_add_child() could either:

- take an Owned<T> and consume it, thus always giving a ref count of 1
on exit. If you want to keep the object you would have to clone it.

- take "&'owner self, &'child T where 'owner: 'child", then you can
pass an embedded object like object_initialize_child().

In the latter case however you *still* need to keep the reference
count elevated until Drop runs. That is, unlike C, Rust code will
always have a ref count of 2 for children. For this reason, instead of
having a "T" in the struct you would have another wrapper---something
like Child<'owner, T>. This wrapper cannot be cloned but it does an
unref when dropped.

My expectation is that property_add_child() will be used exclusivel
for the first case, i.e. it will take an Owned<T>. If you want to
create a child property from an embedded object, something like
object_initialize_child() can be used once pinned-init is used to
rewrite how instance_init is used. It will look something like

pin_init! {
  &this in MyClass {
    ...,
    iomem <- MemoryRegion::init_io(
            this,
            &MY_MR_OPS,
            "memory-region-name",
            0x1000,
    ),
    child_obj <- ChildClass::init().to_child(this, "prop-name")
  }
}

where to_child() wraps an "impl PinInit<T>" and turns it into an "impl
PinInit<Child<'a, T>>". Or something like that. :)

> From this description, I understand your goal is:
>
>  * For embedded child object, its lifetimer is managed by its parent
>    object, through Child<> for the most cases.
>
>  * For non-embedded child - a pointer/reference in parent object, its
>    lifetimer is managed by `Owned<>` (and with Child<>).
>
> Am I right?

Yes, you're right.

I am not sure if you meant Child<> as the QOM concept, or as a Rust
struct. If the latter, you're really really right.

Paolo


