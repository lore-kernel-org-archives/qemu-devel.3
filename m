Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECECD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyti-0005EE-SH; Thu, 07 May 2026 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKyti-0005Du-AT
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:36:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKytg-0001yx-B8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:36:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1AAC6AA5E;
 Thu,  7 May 2026 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778160970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2wnQ9NnBS/ivyZIbNR1h/QvQ9VsCN0U61Rm8dFd1Zc=;
 b=OcDFm6tYNFx7/cFiK8g85Fk8ccVXdIpPSkvUWl/uiCBKjtEonS4kuP0L/EAVujavCwVr1a
 yPOQbAc/Qx913gVJ3O09eNGNccX9FoIogydL526e3fJSjZ7LIadFy1dRPM+pi2nzkdYBZ1
 dDleEKxkYzyEtOdgsCCITofuZpLEUiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778160970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2wnQ9NnBS/ivyZIbNR1h/QvQ9VsCN0U61Rm8dFd1Zc=;
 b=gdxbkClFjkqR9h7WmyjV6wWI1mr2HRBsJUeBNfI/agTF0o81AenY8b2gR0pEucAP0jx1wE
 qBX0EbQYw2gr8tCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778160970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2wnQ9NnBS/ivyZIbNR1h/QvQ9VsCN0U61Rm8dFd1Zc=;
 b=OcDFm6tYNFx7/cFiK8g85Fk8ccVXdIpPSkvUWl/uiCBKjtEonS4kuP0L/EAVujavCwVr1a
 yPOQbAc/Qx913gVJ3O09eNGNccX9FoIogydL526e3fJSjZ7LIadFy1dRPM+pi2nzkdYBZ1
 dDleEKxkYzyEtOdgsCCITofuZpLEUiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778160970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2wnQ9NnBS/ivyZIbNR1h/QvQ9VsCN0U61Rm8dFd1Zc=;
 b=gdxbkClFjkqR9h7WmyjV6wWI1mr2HRBsJUeBNfI/agTF0o81AenY8b2gR0pEucAP0jx1wE
 qBX0EbQYw2gr8tCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 604CC593A7;
 Thu,  7 May 2026 13:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rU2NDEqV/GnsfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 May 2026 13:36:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Xu
 <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] migration: Remove VMS_MULTIPLY_ELEMENTS and
 VMSTATE_VARRAY_MULTIPLY()
In-Reply-To: <20260507070228.48877-1-philmd@linaro.org>
References: <20260507070228.48877-1-philmd@linaro.org>
Date: Thu, 07 May 2026 10:36:00 -0300
Message-ID: <87mrybxry7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Commit c1eb3ac3468 ("target/sparc: Replace
> VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY") removed the
> last use of the VMSTATE_VARRAY_MULTIPLY() macro. We can now
> remove it as unnecessary, along with the VMS_MULTIPLY_ELEMENTS
> flag and the associated tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/migration/vmstate.h        | 22 ++----------
>  migration/vmstate.c                |  4 ---
>  rust/bindings/migration-sys/lib.rs |  8 -----
>  rust/migration/src/vmstate.rs      |  3 +-
>  rust/tests/tests/vmstate_tests.rs  | 55 ------------------------------
>  5 files changed, 4 insertions(+), 88 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 28e3640e60c..0a8a2e85a63 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -105,7 +105,7 @@ enum VMStateFlags {
>      VMS_ARRAY_OF_POINTER =3D 0x040,
>=20=20
>      /* The field is an array of variable size. The uint16_t at opaque
> -     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * + VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
> @@ -126,14 +126,14 @@ enum VMStateFlags {
>      VMS_MULTIPLY         =3D 0x200,
>=20=20
>      /* The field is an array of variable size. The uint8_t at opaque +
> -     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
>      VMS_VARRAY_UINT8     =3D 0x400,
>=20=20
>      /* The field is an array of variable size. The uint32_t at opaque
> -     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * + VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
> @@ -150,12 +150,6 @@ enum VMStateFlags {
>       * cause the individual entries to be allocated. */
>      VMS_ALLOC            =3D 0x2000,
>=20=20
> -    /* Multiply the number of entries given by the integer at opaque +
> -     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
> -     * to determine the number of entries in the array. Only valid in
> -     * combination with one of VMS_VARRAY*. */
> -    VMS_MULTIPLY_ELEMENTS =3D 0x4000,
> -
>      /* A structure field that is like VMS_STRUCT, but uses
>       * VMStateField.struct_version_id to tell which version of the
>       * structure we are referencing to use. */
> @@ -446,16 +440,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     =3D vmstate_offset_2darray(_state, _field, _type, _n1, _=
n2),  \
>  }
>=20=20
> -#define VMSTATE_VARRAY_MULTIPLY(_field, _state, _field_num, _multiply, _=
info, _type) { \
> -    .name       =3D (stringify(_field)),                               \
> -    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t),\
> -    .num        =3D (_multiply),                                       \
> -    .info       =3D &(_info),                                          \
> -    .size       =3D sizeof(_type),                                     \
> -    .flags      =3D VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
> -    .offset     =3D vmstate_offset_varray(_state, _field, _type),      \
> -}
> -
>  #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info,=
 _type) { \
>      .name       =3D (stringify(_field)),                               \
>      .version_id =3D (_version),                                        \
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 2f13b48a37f..6fa7523f04d 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -100,10 +100,6 @@ static int vmstate_n_elems(void *opaque, const VMSta=
teField *field)
>          n_elems =3D *(uint8_t *)(opaque + field->num_offset);
>      }
>=20=20
> -    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
> -        n_elems *=3D field->num;
> -    }
> -
>      trace_vmstate_n_elems(field->name, n_elems);
>      return n_elems;
>  }
> diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration=
-sys/lib.rs
> index 7ee30a3f7d5..9581481e421 100644
> --- a/rust/bindings/migration-sys/lib.rs
> +++ b/rust/bindings/migration-sys/lib.rs
> @@ -114,12 +114,4 @@ pub const fn with_varray_flag(mut self, flag: VMStat=
eFlags) -> Self {
>          assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) !=3D 0);
>          self.with_varray_flag_unchecked(flag)
>      }
> -
> -    #[must_use]
> -    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
> -        assert!(num <=3D 0x7FFF_FFFFu32);
> -        self.flags =3D VMStateFlags(self.flags.0 | VMStateFlags::VMS_MUL=
TIPLY_ELEMENTS.0);
> -        self.num =3D num as i32;
> -        self
> -    }
>  }
> diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
> index f34a36f6809..63d78b4f275 100644
> --- a/rust/migration/src/vmstate.rs
> +++ b/rust/migration/src/vmstate.rs
> @@ -159,8 +159,7 @@ macro_rules! vmstate_of {
>              )$(.with_varray_flag($crate::call_func_with_field!(
>                      $crate::vmstate::vmstate_varray_flag,
>                      $struct_name,
> -                    $($num).+))
> -               $(.with_varray_multiply($factor))?)?
> +                    $($num).+)))?
>          }
>      };
>  }
> diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate=
_tests.rs
> index 87176a80990..c2c12cfab52 100644
> --- a/rust/tests/tests/vmstate_tests.rs
> +++ b/rust/tests/tests/vmstate_tests.rs
> @@ -118,34 +118,6 @@ fn test_vmstate_varray_uint16_unsafe() {
>      assert!(foo_fields[2].field_exists.is_none());
>  }
>=20=20
> -#[test]
> -fn test_vmstate_varray_multiply() {
> -    let foo_fields: &[VMStateField] =3D
> -        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) =
};
> -
> -    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
> -    // VMSTATE_VARRAY_MULTIPLY)
> -    assert_eq!(
> -        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(=
),
> -        b"arr_mul\0"
> -    );
> -    assert_eq!(foo_fields[3].offset, 6);
> -    assert_eq!(foo_fields[3].num_offset, 12);
> -    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
> -    assert_eq!(foo_fields[3].version_id, 0);
> -    assert_eq!(foo_fields[3].size, 1);
> -    assert_eq!(foo_fields[3].num, 16);
> -    assert_eq!(
> -        foo_fields[3].flags.0,
> -        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_E=
LEMENTS.0
> -    );
> -    assert!(foo_fields[3].vmsd.is_null());
> -    assert!(foo_fields[3].field_exists.is_none());
> -
> -    // The last VMStateField in VMSTATE_FOOA.
> -    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
> -}
> -
>  // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D Test VMSTATE_FOOB =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  // Test the use cases of the vmstate macro, corresponding to the followi=
ng C
>  // macro variants:
> @@ -256,33 +228,6 @@ fn test_vmstate_struct_varray_uint8() {
>      assert!(foo_fields[2].field_exists.is_none());
>  }
>=20=20
> -#[test]
> -fn test_vmstate_struct_varray_uint32_multiply() {
> -    let foo_fields: &[VMStateField] =3D
> -        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) =
};
> -
> -    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
> -    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
> -    assert_eq!(
> -        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(=
),
> -        b"arr_a_mul\0"
> -    );
> -    assert_eq!(foo_fields[3].offset, 64);
> -    assert_eq!(foo_fields[3].num_offset, 124);
> -    assert!(foo_fields[3].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT=
8 doesn't set info field.
> -    assert_eq!(foo_fields[3].version_id, 2);
> -    assert_eq!(foo_fields[3].size, 20);
> -    assert_eq!(foo_fields[3].num, 32);
> -    assert_eq!(
> -        foo_fields[3].flags.0,
> -        VMStateFlags::VMS_STRUCT.0
> -            | VMStateFlags::VMS_VARRAY_UINT32.0
> -            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
> -    );
> -    assert_eq!(foo_fields[3].vmsd, VMSTATE_FOOA.as_ref());
> -    assert!(foo_fields[3].field_exists.is_none());
> -}
> -
>  #[test]
>  fn test_vmstate_macro_array() {
>      let foo_fields: &[VMStateField] =3D

Reviewed-by: Fabiano Rosas <farosas@suse.de>

