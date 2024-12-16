Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41ECE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCqi-0001b8-KG; Mon, 16 Dec 2024 10:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNCqg-0001Zs-1l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNCqc-0008Q6-T2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734362245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiaS8qjds9jvHNE+RfGCGl2bmoc3ru421jyqepdQPwk=;
 b=StBtpxbiXKgVheQOJdx7yClJc9CimlOIHqFT6qxEStd9d1vi8iTjRDKeJwOuljdiDLbip8
 A8RdHdfQEhTEOrTCYkmZIPihkK6gdApSxaGQyExUwyPu25nOE4D8FcqsIX2tWrugaFdAi0
 8dT4D3UaeMaqsMXisvpW2CNmy6akSqY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-hc_BSP9eMg2FLOO5-mScqQ-1; Mon, 16 Dec 2024 10:17:24 -0500
X-MC-Unique: hc_BSP9eMg2FLOO5-mScqQ-1
X-Mimecast-MFC-AGG-ID: hc_BSP9eMg2FLOO5-mScqQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso2974629f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362243; x=1734967043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiaS8qjds9jvHNE+RfGCGl2bmoc3ru421jyqepdQPwk=;
 b=SdjG3DAuhBWophUZYI9sPqtY3wOcOKWEtO6Qs8AHPG+KlKigd7/dgBSzPjpFzg0Bb+
 lvbx6xkccEvvU75iG65G8afrE6umFKdaoDsR1osV+lCo6b5qpt2X87vbBFBNkfrYH5/V
 gxWHH5eJ2Yuchy5lYxOHR00iQZYAYis+lJdkMUBs08ZNY44+ZyAcufPtlIEU8z/ger9z
 bg9FhgNNpcby152RBjnoNb44Fjyjxg1X2grcVnkOy38icDdjWG8Z7Pb5w6494eLFVPyN
 5hGtxC8e03/yOHGyP6NAf2HuWE/6XLKzvFUpfWMqZSZ3TciAZnJbAB785pAQwZK7LLEs
 XJIg==
X-Gm-Message-State: AOJu0YwaBbCzhCbO3HaRsLra1LRwwFNdpt6RzYaOi11QbcGviMsayI3y
 6Sw5uEepOS9PIU8NftUsHaLy6QRSGrJCuu2CNI+jTBotDwAm+OI7tiENIlfCH4/d4KWkM9w6hj2
 Pkh524ksokU1uIv1sgD6FcxeMnoHSJYkIEQ99FNYv1bz+ns1sXWK+7Jq2ay6AwltQklEQVn4qhz
 /kieab0PJ0QrAp6haZQg9fwtOrXnM=
X-Gm-Gg: ASbGncvAsBG0i3kEDA+PWv5r/D93JyiYcfd8GsfArx1umGCqaf9KTBK4onEos71ImdX
 qWhTxVxnFzxktGT2uZ7U0bK35xxcGpc03JZPHIQ==
X-Received: by 2002:a5d:47c9:0:b0:385:ef8e:a652 with SMTP id
 ffacd0b85a97d-3888e0bf8f5mr12646551f8f.56.1734362242368; 
 Mon, 16 Dec 2024 07:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC0gW1PBNjHQFQHBXB1TxKcWN7FOE1Kd/yPXQxpsGRVEJhg1cku7551sBy997zTgFt0hPMj3r73xGL2XNQAlk=
X-Received: by 2002:a5d:47c9:0:b0:385:ef8e:a652 with SMTP id
 ffacd0b85a97d-3888e0bf8f5mr12646333f8f.56.1734362240500; Mon, 16 Dec 2024
 07:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-23-pbonzini@redhat.com>
 <Z2Ai0Ipv9RtwQndB@intel.com>
In-Reply-To: <Z2Ai0Ipv9RtwQndB@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Dec 2024 16:17:09 +0100
Message-ID: <CABgObfakOQbvFqWy8kmiJ-O7VgWvhk0yDW2BYG_Qbtdts3vRug@mail.gmail.com>
Subject: Re: [PATCH 22/26] rust: qom: add casting functionality
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Mon, Dec 16, 2024 at 1:35=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> > +/// Macro to mark superclasses of QOM classes.  This enables type-safe
> > +/// up- and downcasting.
> > +///
> > +/// # Safety
> > +///
> > +/// This macro is a thin wrapper around the [`IsA`] trait and performs
> > +/// no checking whatsoever of what is declared.  It is the caller's
> > +/// responsibility to have $struct begin, directly or indirectly, with
> > +/// a field of type `$parent`.
> > +#[macro_export]
> > +macro_rules! qom_isa {
> > +    ($struct:ty : $($parent:ty),* ) =3D> {
>
> This macro is quite good, but it requires specifying all the parents...
> So I am thinking if it is possible to move ParentType to ObjectType, and
> then try to traverse the ParentType in the macro, implementing IsA for
> each ParentType... However, the first difficulty has already stopped me:
> I cannot define ParentType for Object itself.

I am not sure how that could be done, but I've seen people
implementing boolean logic purely with types, like

pub struct True;
pub struct False;
pub trait Boolean {}
impl Boolean for True;
impl Boolean for False;
pub trait Or<T: Boolean>: Boolean {
    type Result: Boolean;
}
impl<T: Boolean> Or<T> for True {
    type Result =3D True;
}
impl<T: Boolean> Or<T> for False {
    type Result =3D T;
}

and I think that can be used to implement recursive IsA, but that is a
bit too magic for this first step. QEMU class hierarchies are
relatively shallow.

> > @@ -94,8 +147,224 @@ pub unsafe trait ObjectType: Sized {
> >      /// The name of the type, which can be passed to `object_new()` to
> >      /// generate an instance of this type.
> >      const TYPE_NAME: &'static CStr;
> > +
> > +    /// Return the receiver as an Object.  This is always safe, even
> > +    /// if this type represents an interface.
>
> This comment is a bit confusing to me... EMM, why mention the interface?
> I understand if something implements ObjectType, then it should be an
> Object, so deref/cast here would be valid. And if it is an interface,
> it would need to implement the corresponding trait.

What I meant is that interfaces do (will) not implement IsA<Object>,
but they are ObjectTypes. So if you have let's say an "&impl
UserCreatable" argument, you could use as_object() to obtain an
&Object.

> This cast idea is nice! In the future, class might also need to implement=
=3D
> similar cast support (e.g., class_init in virtio).

Ok, good!

Paolo


