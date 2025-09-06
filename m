Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D3CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumgN-0008Nu-9w; Sat, 06 Sep 2025 02:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uumgI-0008LP-0S
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uumgA-0007QI-Iq
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757141135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=IoAYCVqkE9bqduLigPIs9PkM86oBA0XXDTmHFT72CbQ=;
 b=OyBPxu2jOusDZfsRWUwIJ2n6YufHZlFrHCh2U+iz9tkW9CT0Cej1t2eN0Kv0Khw36An/j9
 TxgaQ2NDrpzk3v/acDWVmD/HDw2BtVchyW/Y/JS7ttR4DEZXI6edjrZlrwt+HituXJcTU9
 juHPcf8av1xQrtns9okDx4mQdd9l7cE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-evG0WL0RNNqdQDFUg0LCpQ-1; Sat, 06 Sep 2025 02:45:33 -0400
X-MC-Unique: evG0WL0RNNqdQDFUg0LCpQ-1
X-Mimecast-MFC-AGG-ID: evG0WL0RNNqdQDFUg0LCpQ_1757141132
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b85c93afdso10229865e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757141131; x=1757745931;
 h=content-transfer-encoding:cc:autocrypt:subject:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IoAYCVqkE9bqduLigPIs9PkM86oBA0XXDTmHFT72CbQ=;
 b=PGS/5pEXF2kUHPUwyIVuKCDCf8KQpwgsbY5YGXyburJvmXFMCraLMYXQLvgguFGlc4
 Q5wMHfSGaSOGiVZvHg+nsNTLpGOiKf6mGcOk4+/F+KB3b+FvjD6xP+/HNfoSYRmnkgGg
 Ce+aK7X4KTeS8YmRwaANSAF5aXyE1RBPG7tx6NwUqxCFD4ik88o1APAT5Xo9KOQUg3rE
 ZpfvK5zixcQ4NKtJi+EEAwhmQJ2mhy3jJZb/o3t0xh5P8N57JMRUQxQnuLNkp+cE0FwO
 Y6ZCjYRuysvXy0Ol8HiuzejCxsxt4Ol6BSpWNhBdIMTgMsoZYKDoXcmOpW/gnSWRRhTo
 OX+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUG+GVmu4g7QLEn844LJwtOZVD/uRSX0twgbZcu7YSfDq2B7sp+/qsMU1JNYO44NVI11FcHeoNgeI/@nongnu.org
X-Gm-Message-State: AOJu0Yz+j6nm0QPiYD3e0L0+SfZaq/aiZgnr0jPZwo0K/3hOxseU6CUF
 7eVvF7Ag6uz/PaQmmHGbb90l1/g38F61q57Mq9Pp+wiep7CiLi1n5TVPHrd0k1XenHNopN0wxMn
 AJblW/9WUgJYa8khgYyc2VbpvQq8+oXOGd/r8DfnXKr53yQFiZxfOF4UuQTC7WcF6
X-Gm-Gg: ASbGncs2ugFJfv2sEMz1xyC3sNpqnp0mZSuSDWkX1/wVKRaZd6Tq8lL3b0g/zV+AqWv
 HBrYlQd5rs/BtMVC83HTGfTyKV6WA6EoBkADyKN2ZOdJogZDCE4cbT5rqcHrE1c+w+5GJACudoe
 8YvGkuqKmWI1Uge2aVA2xJiZnsPKkmViGDRh8yyUThEWxn0DZBpOfia1l043AXaEfJwCdwDzVA5
 +rmotV0MfpYO/Qjh9HmC+ZDX7b5u8+Y2bGk2+xxiNgb11u5x0PzCdnb9QwmaPt36iCVfyWbUtwb
 bPNMs3MJJgajYkBaNQKauLDG+aOxu06wmZ0vEOEzkSVfUrof30C1NcU4WxbQAp4vVZgEbrGXJLS
 uBYu6x0w38X7ufbSE8iKUPKNtK7zLtetl+CWDH4eI5a0=
X-Received: by 2002:a5d:4a52:0:b0:3e6:f41d:251b with SMTP id
 ffacd0b85a97d-3e6f41d274amr295579f8f.20.1757141131077; 
 Fri, 05 Sep 2025 23:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBfJty5vtEaDVELpTN7Lk40T8h4ye+xK3rhEMCO3HJeVUigOUpkNOnq0cpDAa9RWF450v3mg==
X-Received: by 2002:a5d:4a52:0:b0:3e6:f41d:251b with SMTP id
 ffacd0b85a97d-3e6f41d274amr295568f8f.20.1757141130607; 
 Fri, 05 Sep 2025 23:45:30 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3cf3458a67fsm6757292f8f.62.2025.09.05.23.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:45:30 -0700 (PDT)
Message-ID: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
Date: Sat, 6 Sep 2025 08:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
To: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>
Subject: Rust high-level pre/post migration callbacks
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

based on the low-level sketch in Zhao and my presentation,
I would like to propose this more high-level implementation
of pre/post migration callbacks.

Instead of dealing with pre/post callbacks, devices implement a
snapshot/restore mechanism; this way, C code sees a simplified
picture and does not have to deal with Rust concepts such as
Mutex<>.

Using it is very easy, you can just declare your state like:

     regs: Migratable<Mutex<MyDeviceRegisters>>

If a pure snapshot is possible, implementing the new trait
is also simple:

impl_vmstate_struct!(MyDeviceRegisters, ...);

impl ToMigrationState for MyDeviceRegisters {
     type Migrated = Self;
     fn to_migration_state(&self) ->
         Result<Box<Self>, ...> {
         Ok(Box::new(self.clone()))
     }

     fn restore_migrated_state_mut(&mut self, source: &Self,
         _version_id: u8) -> Result<(), migration::InvalidError> {
         *self = source;
         Ok(())
     }
}

I'm really bad at writing Rust code with the correct syntax
from the get-go, but I'll try anyway.

new traits:

/// Enables QEMU migration support for types that may be wrapped in
/// synchronization primitives (like `Mutex`) that the C migration
/// code cannot directly handle. The trait provides methods to
/// extract essential state for migration and restore it after
/// migration completes.
///
/// On top of extracting data from synchronization wrappers during save
/// and restoring it during load, it's also possible to convert
/// runtime representations to migration-safe formats.
trait ToMigrationState {
     type Migrated: Default + VMState;
     fn to_migration_state(&self) ->
         Result<Box<Self::Migrated>, migration::InvalidError>;
     fn restore_migrated_state_mut(&mut self, source: &Self::Migrated,
         version_id: u8) -> Result<(), migration::InvalidError>;
}

/// Extension trait for types that support migration state restoration
/// through interior mutability.
///
/// This trait extends `ToMigrationState` for types that can restore
/// their state without requiring mutable access.  While user structs
/// will generally use `ToMigrationState`, the device will have multiple
/// references and therefore the device struct has to employ an interior
/// mutability wrapper like `Mutex`, `RefCell`, or `BqlRefCell`.  In
/// turn, wrappers implementing this trait can be used within `Migratable<T>`,
/// which makes no assumptions on how to achieve mutable access to the
/// run-time state.
trait ToMigrationStateShared: ToMigrationState {
     fn restore_migrated_state(&self, source: &Self::Migrated) ->
         Result<(), migration::InvalidError>;
}


with implementations for wrapper types like:

impl<T> ToMigrationState for Mutex<T: ToMigrationState> {
     type Migrated = T::Migrated;
     fn to_migration_state(&self) ->
         Result<Box<Self::Migrated>, migration::InvalidError> {
         self.lock().to_migration_state()
     }
     ...
}

impl<T> ToMigrationStateShared for Mutex<T: ToMigrationState> {
     fn restore_migrated_state(&self, source: &Self::Migrated,
         version_id: u8) -> Result<(), migration::InvalidError>{
         self.lock().restore_migrated_state_mut(source, version_id)
     }
}

impl<T> ToMigrationState for BqlRefCell<T: ToMigrationState> {
     type Migrated = T::Migrated;
     fn to_migration_state(&self) ->
         Result<Box<Self::Migrated>, migration::InvalidError> {
         self.borrow().to_migration_state()
     }
     ...
}

impl<T> ToMigrationStateShared for BqlRefCell<T: ToMigrationState> {
     fn restore_migrated_state(&self, source: &Self::Migrated,
         version_id: u8) ->Result<(), migration::InvalidError> {
         self.borrow_mut().restore_migrated_state_mut(source, version_id)
     }
}

new struct maps the above trait to the C-style callbacks:

/// A wrapper that bridges Rust types with QEMU's C-based migration system.
///
/// `Migratable<T>` enables QEMU migration support for Rust types that implement
/// `ToMigrationState`, as long as they are wrapped with an interior mutability
/// like `Mutex` or `BqlRefCell`.  It provides translation functionality as well
/// as access to synchronization primitives that the C code cannot directly handle.
///
/// This wrapper acts as a transparent proxy during normal operation
/// (via `Deref`/`DerefMut`), while handling state extraction and restoration
/// around migration.
pub struct<T: ToMigrationStateShared> Migratable {
     runtime_state: T,
     // C vmstate does not support NULL pointers, so no Option<Box<>>
     // Actually a BqlCell<*mut T::Migrated>, but keeping it simple
     // for now.
     migration_state: *mut T::Migrated
};

unsafe impl<T> Send for Migratable<T: Send> {}
unsafe impl<T> Sync for Migratable<T: Sync> {}

// just return runtime_state
impl<T> Deref for Migratable<T: ToMigrationStateShared> {
     type Migrated = T;
     ...
}
impl<T> DerefMut for Migratable<T: ToMigrationStateShared> {
     ...
}

impl Migratable {
     fn pre_save(...) -> ... {
         self.migration_state = Box::into_raw(self.0.to_migration_state()?);
     }

     fn post_save(...) -> ... {
         drop(Box::from_raw(self.migration_state.replace(ptr::null_mut()));
     }

     fn pre_load(...) -> ... {
         self.migration_state = Box::into_raw(Box::default());
     }

     fn post_load(...) -> ... {
         let state = Box::from_raw(self.migration_state.replace(ptr::null_mut());
         self.0.restore_migrated_state(state, version_id)
     }
}

unsafe impl VMState for Migratable<T: ToMigrationStateShared> {
     const BASE: bindings::VMStateField = {
         static VMSD: &$crate::bindings::VMStateDescription =
             VMStateDescriptionBuilder::<Self>::new()
                 .version_id(T::VMSD.version_id)
                 .minimum_version_id(T::VMSD.minimum_version_id)
                 .priority(T::VMSD.priority)
                 .pre_load(Self::pre_load)
                 .post_load(Self::post_load)
                 .pre_save(Self::pre_save)
                 .post_save(Self::post_save)
                 .fields(vmstate_fields! {
                     vmstate_of!(Migratable<T>, migration_state)
                 }
                 .build();

         bindings::VMStateField {
             vmsd: addr_of!(*VMSD),
             size: size_of::<Migratable<T>>(),
             flags: bindings::VMStateFlags::VMS_STRUCT,
             ..common::Zeroable::ZERO
         }
     };
}

This is just a sketch but should give the idea.

Paolo


