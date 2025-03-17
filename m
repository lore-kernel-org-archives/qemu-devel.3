Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C573C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuE0k-0000Dj-Q0; Mon, 17 Mar 2025 13:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE0W-00008W-Mn
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE0M-0007Qn-1C
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742231513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJ5KwP2rq5reBWn2oKzQI1E5LVg3nqPs62+wCJ/k+Wk=;
 b=HF5orlUdCNBlgEaGCfoZ6sC8WHzy52xH9W1C4VYM5QteOpkcLs/phufRMUZqj5Pq6Xm9pC
 j8e7dqnXCXlSNAQmpD4C9QTqn3mpqkXrMQoDaNlH7JSBfC2e2QKDenoWu4JKX9bPj86FT1
 6kyCfW2+x1NeFFIDU14IAIRlVgml4QA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-5gvZcbaANouhd4ShapKC_g-1; Mon, 17 Mar 2025 13:11:48 -0400
X-MC-Unique: 5gvZcbaANouhd4ShapKC_g-1
X-Mimecast-MFC-AGG-ID: 5gvZcbaANouhd4ShapKC_g_1742231508
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39143311936so2055825f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742231507; x=1742836307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ5KwP2rq5reBWn2oKzQI1E5LVg3nqPs62+wCJ/k+Wk=;
 b=AGcEmZj5yefXNUXgtqH8dp6x4o442YrUcP+53l/r9ojSMiesgG2TSy/A89K7tt2pDy
 SBpo0KQwjDWMzFWcVKvXZCibaCW/QISTlxMYjB7ldkxPWhF7BKtD/vGDUu/l7kHIw/xL
 oodsjgorky9gpOD+eQe20vxiUmtNCc1ylrec4PIuYBPYXV6oMXsUGqO91aJw/LYH47Qi
 THUMCsTykEnU7Fks2UIvJmwIXptyPTF4pQLtvlDrmcvl8ccXHZnu4qWhbf6qybmHK5bY
 ZHNTDI2MFRxW5tnkbFMOfyn18v+lZYyWFsxpRj0Xt2IAa80j4cT0QbwZwH9bVlhPH5WM
 9big==
X-Gm-Message-State: AOJu0YyC8X9ckj1dCb+x21DPKZqt7x6s4zVvVeChcoyzBHWMne67i0JP
 6mv4xgKOfqljQ0Ev/Ptiky15wH9H2pnBnE2bvkt0FhkmYggJhja9C73LsU+nGaFndVz7zLRl8BB
 OeVgAkw0VUVqHCsTkaErUX38zCZTKrssC2ZVHup/1kF4k/NAhstQgKYLnb1QZkm4GAWcnbkgodU
 YD62tnV5OS0fpf4TSevr+F1x9iG9Q=
X-Gm-Gg: ASbGncsmtWR3Ig6UF5/Pk/yynJPwGeqbFu0EWrscfhudStsXW3dVg7LCRJ6iKjGO8t+
 lQlAEii8HE6GhoT3GmU7zfQ6WwWJtT8aIHE3tz66jYsIgwvEE6GaaZUG1272P2fgBNBep7F3hHQ
 ==
X-Received: by 2002:a5d:47cf:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-3971d1362e8mr17276890f8f.2.1742231507534; 
 Mon, 17 Mar 2025 10:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF18T8n3V0mU46HcWT9TLWYYJxwFSg5FJBWOAYXo2neK/M8dovqjlfB0yasi9oQjAyn/ruvxw0NhrmKYs6mJwU=
X-Received: by 2002:a5d:47cf:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-3971d1362e8mr17276863f8f.2.1742231507145; Mon, 17 Mar 2025
 10:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-15-zhao1.liu@intel.com>
In-Reply-To: <20250317151236.536673-15-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Mar 2025 18:11:35 +0100
X-Gm-Features: AQ5f1Jq85ZXs2GvZoIC6fNVX4tAVSm9ymSWNtgkmH1yFGsXyEh9uX_hKLBJMehg
Message-ID: <CABgObfaHDrKPx7jRLtOn9CdjC8A1zjpAwBDuuY7WGY9bwYzckw@mail.gmail.com>
Subject: Re: [PATCH 14/17] rust/vmstate: Add unit test for vmstate_of macro
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks very much for the tests!

On Mon, Mar 17, 2025 at 3:52=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> -pub use crate::bindings::{VMStateDescription, VMStateField};
> -use crate::{
> -    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, z=
eroable::Zeroable,
> -};
> +pub use crate::bindings::{VMStateDescription, VMStateField, VMStateFlags=
};

Does VMStateFlags have to be part of the public API?

> +    assert_eq!(foo_fields[0].info, unsafe {
> +        ::core::ptr::addr_of!(vmstate_info_int8)
> +    });

You can use & instead of addr_of here.

> +    assert_eq!(foo_fields[0].version_id, 0);
> +    assert_eq!(foo_fields[0].size, 1);
> +    assert_eq!(foo_fields[0].num, 0);
> +    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_SINGLE);
> +    assert_eq!(foo_fields[0].vmsd.is_null(), true);
> +    assert_eq!(foo_fields[0].field_exists.is_none(), true);
> +
> +    // 2nd VMStateField ("unused") in VMSTATE_FOOA (corresponding to VMS=
TATE_UNUSED)
> +    assert_eq!(
> +        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(=
),
> +        b"unused\0"
> +    );
> +    assert_eq!(foo_fields[1].offset, 0);
> +    assert_eq!(foo_fields[1].num_offset, 0);
> +    assert_eq!(foo_fields[1].info, unsafe {
> +        ::core::ptr::addr_of!(vmstate_info_unused_buffer)
> +    });
> +    assert_eq!(foo_fields[1].version_id, 0);
> +    assert_eq!(foo_fields[1].size, 8);
> +    assert_eq!(foo_fields[1].num, 0);
> +    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_BUFFER);
> +    assert_eq!(foo_fields[1].vmsd.is_null(), true);
> +    assert_eq!(foo_fields[1].field_exists.is_none(), true);
> +
> +    // 3rd VMStateField ("arr") in VMSTATE_FOOA (corresponding to
> +    // VMSTATE_VARRAY_UINT16_UNSAFE)
> +    assert_eq!(
> +        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(=
),
> +        b"arr\0"
> +    );
> +    assert_eq!(foo_fields[2].offset, 0);
> +    assert_eq!(foo_fields[2].num_offset, 4);
> +    assert_eq!(foo_fields[2].info, unsafe {
> +        ::core::ptr::addr_of!(vmstate_info_uint8)
> +    });
> +    assert_eq!(foo_fields[2].version_id, 0);
> +    assert_eq!(foo_fields[2].size, 1);
> +    assert_eq!(foo_fields[2].num, 0);
> +    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY_UINT16);
> +    assert_eq!(foo_fields[2].vmsd.is_null(), true);
> +    assert_eq!(foo_fields[2].field_exists.is_none(), true);
> +
> +    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
> +    // VMSTATE_VARRAY_MULTIPLY)
> +    assert_eq!(
> +        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(=
),
> +        b"arr_mul\0"
> +    );
> +    assert_eq!(foo_fields[3].offset, 6);
> +    assert_eq!(foo_fields[3].num_offset, 12);
> +    assert_eq!(foo_fields[3].info, unsafe {
> +        ::core::ptr::addr_of!(vmstate_info_int8)
> +    });
> +    assert_eq!(foo_fields[3].version_id, 0);
> +    assert_eq!(foo_fields[3].size, 1);
> +    assert_eq!(foo_fields[3].num, 16);
> +    assert_eq!(
> +        foo_fields[3].flags.0,
> +        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_E=
LEMENTS.0
> +    );
> +    assert_eq!(foo_fields[3].vmsd.is_null(), true);
> +    assert_eq!(foo_fields[3].field_exists.is_none(), true);
> +
> +    // The last VMStateField in VMSTATE_FOOA.
> +    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
> +}
> --
> 2.34.1
>


