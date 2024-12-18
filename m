Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3A6E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrGU-00032z-PE; Wed, 18 Dec 2024 05:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNrGP-00032I-Rf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNrGM-0008K6-MQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734517601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0h9EnY5bBzS8BbonSZZIOt9iNgCdC5WLtCE2yrTu3UQ=;
 b=FMSypXilTGP7hBDt8yIXPyz2eZUaDdOnfolcLu0onf5ewU3t6szRKufc13duoTsQkJ3qMB
 RFGTODfb5DG4hsFCNoLQjE+AVNMF5GGmil4yWHuLMf4nXrdfqT/kAa8dTszYOcuhm0e45y
 KKvEe1rFNmGETJuFldbq/AKUbZjfKTM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-6-Q0rGYgMTu5O6Ejk2abhg-1; Wed, 18 Dec 2024 05:26:38 -0500
X-MC-Unique: 6-Q0rGYgMTu5O6Ejk2abhg-1
X-Mimecast-MFC-AGG-ID: 6-Q0rGYgMTu5O6Ejk2abhg
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3d2d60d3fso3402231a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734517597; x=1735122397;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0h9EnY5bBzS8BbonSZZIOt9iNgCdC5WLtCE2yrTu3UQ=;
 b=s3fL+hOI/aDpfhd7l1UqpVK0f/EInFe95f4M2HFHBZVQtkp5Gd8/iwkx+c7d2v2LsH
 zzpnTCG3j/S9GkIW9R6xbhWhA8DSreL3qnwn0GNqhiDudOvf4wfdEwzBUOsFAMpLJqKb
 9eznHDpuk9fsltHeYB5ob/xHeN3QH8OK4FqNPh+v9SxXaQiFPXJI2c0yJcZud1m2tpER
 i8J6FspNrkAleIKlWwTwtxDOJnzpbalneiMd4htkB2BnRkxXuddJsfwufKpbr+0OcfaK
 k6kfjLzIU689LSofdPUnK9L7ZYF5CMEI3kYulNhh+IasVfy3G2js8Gy7OswwIcx59YoW
 Gu5w==
X-Gm-Message-State: AOJu0Yy1eXvq5TXurRCMTLXOLIZq5DgzyeEQgwUgnqFDlOW6f3E7hr0w
 CgfKMv8CwHHtCSGFnI4b1cy99SGQxgEkOQwwdEAgQSvYu/ZLT18/r28E58ezjwEu58NSeaYlFnd
 aBHvsZXScJ8mESCbYxEqItJHvbTAp/+C9kIELczycjYj5FxBQKguI
X-Gm-Gg: ASbGnctCK0u50cnouC9SUz/HqdElisDn4U8NEATToQA4lO0N+lWKhztPAOR3oAdBe/O
 uNUp0tNIfmBUb66kxLxwRZDbhSJk5zsGlZwvMjvdHP/cgVTOf+Z+W0I8ig30a43yvapSxf7jS+S
 3FWVZD2pX61BcKmtN30l+6YCDqnCLYDFM5Pwc4Sid5+63fyK/QAV80BQKKCOLwdJ1/UhvLNsIhK
 R0hJpuPAp8W0jfwBHGM3PVybVw7iZAgUxmCqB5Q/F/QRNRmEUAsMF+Y7bTi
X-Received: by 2002:a05:6402:50cb:b0:5d1:2652:42ba with SMTP id
 4fb4d7f45d1cf-5d7ee3b405fmr1976084a12.16.1734517597453; 
 Wed, 18 Dec 2024 02:26:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNjlATdD9hV+7LQk16XII8cgUE/kpxFqnB7kAswm5NJNHG6bn6BDPZMJgbMhg+Ar1Kc7Fxew==
X-Received: by 2002:a05:6402:50cb:b0:5d1:2652:42ba with SMTP id
 4fb4d7f45d1cf-5d7ee3b405fmr1976059a12.16.1734517597033; 
 Wed, 18 Dec 2024 02:26:37 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f25adasm5436926a12.54.2024.12.18.02.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:26:36 -0800 (PST)
Message-ID: <d01798d5-1c93-48f7-bb78-d4602a13baac@redhat.com>
Date: Wed, 18 Dec 2024 11:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com> <Z2D2zk2Wdlqc5q2k@intel.com>
 <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
 <Z2JycooziPsfV8vX@intel.com>
 <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/18/24 08:14, Paolo Bonzini wrote:
>     Moving on to another topic, about the gap (or question :-)) where a
>     child class inherits the ClassInitImpl trait from the parent, please see
>     my test case example below: Doing something similar to SysBusDevice and
>     DeviceState using a generic T outside of the QOM library would violate
>     the orphan rule.
> 
> Ugh, you're right. Maybe ClassInitImpl should just be merged into 
> ObjectImpl etc. as a default method implementation. I will check.

Ok, I think we can make it mostly a documentation issue:

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 2b472915707..ee95eda0447 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -451,13 +451,14 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
  /// Each struct will implement this trait with `T` equal to each
  /// superclass.  For example, a device should implement at least
  /// `ClassInitImpl<`[`DeviceClass`](crate::qdev::DeviceClass)`>` and
-/// `ClassInitImpl<`[`ObjectClass`]`>`.
+/// `ClassInitImpl<`[`ObjectClass`]`>`.  Such implementations are
+/// made in one of two ways.
  ///
-/// Fortunately, this is almost never necessary.  Instead, the Rust
-/// implementation of methods will usually come from a trait like
-/// [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl).
-/// `ClassInitImpl` then can be provided by blanket implementations
-/// that operate on all implementors of the `*Impl`* trait.  For example:
+/// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
+/// crate itself.  The Rust implementation of methods will come from a
+/// trait like [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl),
+/// and `ClassInitImpl` is provided by blanket implementations that
+/// operate on all implementors of the `*Impl`* trait.  For example:
  ///
  /// ```ignore
  /// impl<T> ClassInitImpl<DeviceClass> for T
@@ -469,11 +470,37 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
  /// after initializing the `DeviceClass` part of the class struct,
  /// the parent [`ObjectClass`] is initialized as well.
  ///
-/// The only case in which a manual implementation of the trait is needed
-/// is for interfaces (note that there is no Rust example yet for using
-/// interfaces).  In this case, unlike the C case, the Rust class _has_
-/// to define its own class struct `FooClass` to go together with
-/// `ClassInitImpl<FooClass>`.
+/// In some other cases, manual implementation of the trait is needed.
+/// These are the following:
+///
+/// * for classes that implement interfaces, the Rust code _has_
+///   to define its own class struct `FooClass` and implement
+///   `ClassInitImpl<FooClass>`.  `ClassInitImpl<FooClass>`'s
+///   `class_init` method will then forward to multiple other
+///   `class_init`s, for the interfaces as well as the superclass.
+///   (Note that there is no Rust example yet for using
+///   interfaces).
+///
+/// * for classes implemented outside the ``qemu-api`` crate, it's
+///   not possible to add blanket implementations like the above one,
+///   due to orphan rules.  In that case, the easiest solution is to
+///   implement `ClassInitImpl<YourSuperclass>` for each subclass,
+///   and not have a `YourSuperclassImpl` trait at all:
+///
+///   ```ignore
+///   impl ClassInitImpl<YourSuperclass> for YourSubclass {
+///       fn class_init(klass: &mut YourSuperclass) {
+///           klass.some_method = Some(Self::some_method);
+///           <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
+///       }
+///   }
+///   ```
+///
+///   While this method incurs a small amount of code duplication,
+///   it is generally limited to the recursive call on the last line.
+///   This is because classes defined in Rust do not need the same
+///   glue code that is needed when the classes are defined in C code.
+///   You may consider using a macro if you have many subclasses.
  pub trait ClassInitImpl<T> {
      /// Initialize `klass` to point to the virtual method implementations
      /// for `Self`.  On entry, the virtual method pointers are set to


Optionally, something like this can be squashed in this patch, but I
do not think it's worth the savings of... 3 lines of code:

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 41220c99a83..cbd3abb96ec 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -46,11 +46,6 @@ fn index(&self, idx: hwaddr) -> &Self::Output {
      }
  }
  
-impl DeviceId {
-    const ARM: Self = Self(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
-    const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
-}
-
  #[repr(C)]
  #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
  /// PL011 Device Model in QEMU
@@ -112,7 +107,8 @@ unsafe impl ObjectType for PL011State {
  
  impl ClassInitImpl<PL011Class> for PL011State {
      fn class_init(klass: &mut PL011Class) {
-        klass.device_id = DeviceId::ARM;
+        klass.device_id = DeviceId(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
+
          <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
      }
  }
@@ -628,7 +624,8 @@ pub struct PL011Luminary {
  
  impl ClassInitImpl<PL011Class> for PL011Luminary {
      fn class_init(klass: &mut PL011Class) {
-        klass.device_id = DeviceId::LUMINARY;
+        klass.device_id = DeviceId(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
+
          <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
      }
  }


