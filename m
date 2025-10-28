Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhE9-00086m-3H; Tue, 28 Oct 2025 06:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhDD-0007W2-Ng
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhD7-0005db-Ni
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761648349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9AwSIhFLohNgUvn+e/21kSE+AGA2DH84ZlkxKHh3Kc=;
 b=CKfM/DvB+r6eV8T9/UorZ/HXgj/j2fbygNgxBpoqsYWPlRJoX296EGmgCLYj6O5JsHm8yg
 vBVf23UUbYiUV0bKcJw/XXnm+d/2dVcQO52n9nk8y4ucy0nwjEK0K5B5r8Cr5L0Rl3wvDs
 8zIssKqBSOCnwgFPvOu26FybZ76wypM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-3uAcy1FVOjO1PjPNKJwrTA-1; Tue, 28 Oct 2025 06:45:48 -0400
X-MC-Unique: 3uAcy1FVOjO1PjPNKJwrTA-1
X-Mimecast-MFC-AGG-ID: 3uAcy1FVOjO1PjPNKJwrTA_1761648347
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429893e2905so6161896f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761648346; x=1762253146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9AwSIhFLohNgUvn+e/21kSE+AGA2DH84ZlkxKHh3Kc=;
 b=NdlKpb+5P5hUrYuwyxrtMemo6QByrD+pzbP4gPojqO6TJtuD6uPS6ZB5b6+bO2eKzl
 D4HFx4Hb00BwaWnsltj+a9TO8m4ECemDpFzw4AUWhoJvmVzp0c52UIYmqgiNH9gYdRc1
 /ienHg3LLlccGd5IO5G7YveQ6uQO8Fkva137AuxSWLiyW1BVsS5t11dvDOlJ0zs/dvM4
 K512YBK381/t+an6ghCB7tcAUknJnJnpVL6OlJXNPEoGaGN1hG0znm4N7wpxi8Wb4cEt
 feV3WPb2wNf3c73hLXLFCgvndUYGczA2Gem97MlH5wHTkLcSCkYNA041IW9y64G+aTRc
 qJnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWceVDbGj2Ddds/bHdcSg9dA1XT1uAyoh4vTlm7UP9P9HpitE/z2SO3SeWCB1HGKyO1LWz+5COp6P+0@nongnu.org
X-Gm-Message-State: AOJu0YwfHqWQZPuayU416yFD7pmqwHsTLvPGyamJ35kazhqdSa7oPu1b
 SSJzgIZglVG0VtVODNqkWXerO85a8QYcooXHv7G4z2/kppxC3fGUypImIm1ZeFyYhwI/AHaQ1B5
 l0MJfo+zxTF4r5JE7GWFMHzCfJchIzniuGIFv8KFa5HVTtW/4c4+MUHmIC2BrEJ1yNyPaGBKIjD
 4ob6LAhvMYmdvgMUuzTaq8c/5gt9jNhKM=
X-Gm-Gg: ASbGncvxuAa+QbQ3RIsLbLOk8ciHZbOyXA5AprMS+CcAXm8ak/q4vspO4JQbL6wVFQX
 TAS9VzR7J+W4f4ZAcl2hkwZjshlnZwFVPKbey4E0QkEU4aiJg36uOPhB+ieKSJ4MuKGNu200sPC
 8SLtj/SFI3SwvuDhuly7oti1qtErMueEJ4I8ex/d0yt9EluvpZkR7Uul3+Aks+ORxyPgjURnDxj
 Eec6iMt9KLfOYR/uEfxMlHv9Y9j8Y5zcAmeBrnqDA1jvJlgGmsD5u4yA5Y7
X-Received: by 2002:a05:6000:65c:b0:429:a894:a2f2 with SMTP id
 ffacd0b85a97d-429a894a4bcmr1608136f8f.34.1761648346494; 
 Tue, 28 Oct 2025 03:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7S7fUOcdF6jM43rZmTG7RF/KZf0qthIbiHRkBB1AXgOxsLsnC7YOezeAo5z/Y4PAlG/DjcK1kIYovWsnRPnc=
X-Received: by 2002:a05:6000:65c:b0:429:a894:a2f2 with SMTP id
 ffacd0b85a97d-429a894a4bcmr1608112f8f.34.1761648346024; Tue, 28 Oct 2025
 03:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <db9abfc03f0dbc953ef314ff7f13ff19298efa7d.1761644606.git.chenmiao@openatom.club>
In-Reply-To: <db9abfc03f0dbc953ef314ff7f13ff19298efa7d.1761644606.git.chenmiao@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 11:45:33 +0100
X-Gm-Features: AWmQ_bmV1C0EsdOjjZAfRAJ0z0bOVVGzAvGuJs3TJZRqFsZlaL2dbs-ZLQyc6fU
Message-ID: <CABgObfaBbf9Hq7RRLkhsa5n0-J+boe1T4guEakOEXDHFrc=4AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] rust/hw/core: Add rust bindings/funcs for i2c
 bus
To: chenmiao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club> =
wrote:
> During the implementation process, we found that the current two paradigm=
s in
> Rust =E2=80=94 bindings and impl =E2=80=94 are extremely complex and lack=
 comprehensive
> documentation. There is no clear explanation as to why Bus and Device mod=
els
> need to be implemented using different approaches.

I don't think they need to be implemented using different approaches.
The difference between the two is that:

- the currently implemented devices do not expose any bus, they stay
on a bus. This means the bus is never a child of the device

- the currently implemented buses are all in C code, whereas there are
devices implemented in Rust.

I agree that the Rust-to-C bridge code is complex, but it does have
documentation, much more so than the C versions in fact.  If there are
specific aspects of the documentation that you would like to see
improved, you can help by explaining what problems and sources of
confusion you encountered.

> +/// A safe wrapper around [`bindings::I2CBus`].
> +#[repr(transparent)]
> +#[derive(Debug, common::Wrapper)]
> +pub struct I2CBus(Opaque<bindings::I2CBus>);
> +
> +unsafe impl Send for I2CBus {}
> +unsafe impl Sync for I2CBus {}
> +
> +unsafe impl ObjectType for I2CBus {
> +    type Class =3D BusClass;
> +    const TYPE_NAME: &'static CStr =3D
> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_=
BUS) };
> +}
> +
> +qom_isa!(I2CBus: BusState, Object);
> +
> +// TODO: add virtual methods
> +pub trait I2CBusImpl: DeviceImpl + IsA<I2CBus> {}
> +/// Trait for methods of [`I2CBus`] and its subclasses.
> +pub trait I2CBusMethods: ObjectDeref
> +where
> +    Self::Target: IsA<I2CBus>


There are no virtual methods, and therefore I2CBus does not have
subclasses.  Therefore you don't need these traits and you can
implement the functions directly on I2CBus.

> +{
> +    /// # Safety
> +    ///
> +    /// Initialize an I2C bus
> +    fn init_bus(&self, parent: &DeviceState, name: &str) -> *mut binding=
s::I2CBus {
> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_init_bus(parent.as_mut_ptr(), name.as_ptr=
().cast()) }
> +    }

This should return an Owned<I2CBus>.

> +    /// Sets the I2C bus master.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function is unsafe because:
> +    /// - `bh` must be a valid pointer to a `QEMUBH`.
> +    /// - The caller must ensure that `self` is in a valid state.
> +    /// - The caller must guarantee no data races occur during execution=
.
> +    ///
> +    /// TODO: `bindings:QEMUBH` should be wrapped by Opaque<>.
> +    unsafe fn set_master(&self, bh: *mut bindings::QEMUBH) {
> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_bus_master(self.upcast().as_mut_ptr(), bh=
) }
> +    }

I agree with Zhao, I would leave out this completely. You can add a
TODO ("i2c_bus_master missing until QEMUBH is wrapped").

> +    /// # Safety
> +    ///
> +    /// Release an I2C bus
> +    fn release(&self) {
> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_bus_release(self.upcast().as_mut_ptr()) }
> +    }

Same for this, which is the counterpart of i2c_bus_master. In Rust, in
fact, release() should be done with an RAII guard returned by
set_master.

> +unsafe impl ObjectType for I2CSlave {
> +    type Class =3D I2CSlaveClass;
> +    const TYPE_NAME: &'static CStr =3D
> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_=
SLAVE) };
> +}
> +
> +qom_isa!(I2CSlave: DeviceState, Object);
> +
> +// TODO: add virtual methods
> +pub trait I2CSlaveImpl: DeviceImpl + IsA<I2CSlave> {
> +    /// Master to slave. Returns non-zero for a NAK, 0 for success.
> +    const SEND: Option<fn(&Self, data: u8) -> Result<bool>> =3D None;

Make it return an "enum I2CResult { Ack, Nack };" instead of a Result.
Likewise other function pointers here do not need a Result<>.

> +    /// Master to slave (asynchronous). Receiving slave must call `i2c_a=
ck()`.
> +    const SEND_ASYNC: Option<fn(&Self, data: u8)> =3D None;

This requires the bottom half machinery. Leave it out.

> +/// Trait for methods of [`I2CSlave`] and its subclasses.
> +pub trait I2CSlaveMethods: ObjectDeref
> +where
> +    Self::Target: IsA<I2CSlave>,
> +{
> +    /// Create an I2C slave device on the heap.
> +    ///
> +    /// # Arguments
> +    /// * `name` - a device type name
> +    /// * `addr` - I2C address of the slave when put on a bus
> +    ///
> +    /// This only initializes the device state structure and allows
> +    /// properties to be set. Type `name` must exist. The device still
> +    /// needs to be realized.
> +    fn init_new(name: &str, addr: u8) -> Owned<I2CSlave> {
> +        assert!(bql::is_locked());
> +        unsafe {
> +            let slave =3D bindings::i2c_slave_new(name.as_ptr().cast(), =
addr);
> +            Owned::from(I2CSlave::from_raw(slave))
> +        }
> +    }
> +
> +    /// Create and realize an I2C slave device on the heap.
> +    ///
> +    /// # Arguments
> +    /// * `bus` - I2C bus to put it on
> +    /// * `name` - I2C slave device type name
> +    /// * `addr` - I2C address of the slave when put on a bus
> +    ///
> +    /// Create the device state structure, initialize it, put it on the
> +    /// specified `bus`, and drop the reference to it (the device is rea=
lized).
> +    fn create_simple(&self, bus: &I2CBus, name: &str, addr: u8) -> Owned=
<I2CSlave> {
> +        assert!(bql::is_locked());
> +        unsafe {
> +            let slave =3D
> +                bindings::i2c_slave_create_simple(bus.as_mut_ptr(), name=
.as_ptr().cast(), addr);
> +            Owned::from(I2CSlave::from_raw(slave))
> +        }
> +    }
> +
> +    /// Set the I2C bus address of a slave device
> +    ///
> +    /// # Arguments
> +    /// * `address` - I2C address of the slave when put on a bus
> +    fn set_address(&self, address: u8) {
> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_slave_set_address(self.upcast().as_mut_pt=
r(), address) }
> +    }

These three are used by boards, which we don't model. We can keep the
code simple by leaving them off (in addition, init_new and
create_simple would be *class* methods, as visible from the fact that
they don't use self at all).

> +    /// Get the I2C bus address of a slave device
> +    fn get_address(&self) -> u8 {
> +        assert!(bql::is_locked());
> +        // SAFETY: the BQL ensures that no one else writes to the I2CSla=
ve structure,
> +        // and the I2CSlave must be initialized to get an IsA<I2CSlave>.
> +        let slave =3D unsafe { *self.upcast().as_ptr() };
> +        slave.address
> +    }
> +}
> +
> +impl<R: ObjectDeref> I2CSlaveMethods for R where R::Target: IsA<I2CSlave=
> {}
> +
> +/// Enum representing I2C events
> +#[repr(i32)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum I2CEvent {
> +    StartRecv =3D 0,
> +    StartSend =3D 1,
> +    StartSendAsync =3D 2,
> +    Finish =3D 3,
> +    Nack =3D 4,
> +}

Make it "=3D bindings::I2C_START_RECV" etc. You can then use
#[derive(common::TryInto)] instead of implementing by hand the From
traits.

Paolo


