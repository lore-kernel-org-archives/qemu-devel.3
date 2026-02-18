Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED8E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vseDp-00030M-QR; Wed, 18 Feb 2026 04:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vseDi-0002yF-Oj
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vseDe-0003KG-AT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771408288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvLHTE0Km+ekZ4JGLj1aVouDCqT4KXqOziuQ00aW+0U=;
 b=HNnePph4G/gasE8RMR1pD4fM4I2Za2vxAuIq754ReHy6W8W11bfV3uULFnJ5L/WEyH2ONj
 UUBOGwIYp1d6/iQnQ1q8JKFN4v937pOALi7E/Y/b54CaC/Abcg83yhpOOBB7AFj9lnZM0Y
 tZzZR2Xch42eSW5tPGejiNk2Pbt9y0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-vXyr5woENA--mLFW_AmeQw-1; Wed, 18 Feb 2026 04:51:26 -0500
X-MC-Unique: vXyr5woENA--mLFW_AmeQw-1
X-Mimecast-MFC-AGG-ID: vXyr5woENA--mLFW_AmeQw_1771408284
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435ab907109so3436296f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771408284; x=1772013084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvLHTE0Km+ekZ4JGLj1aVouDCqT4KXqOziuQ00aW+0U=;
 b=hdu3IEVb17O/CdNqymubK8QU/dDAYSO2YRp2EBwn358iVmgpi6dYAEWYXUHT0PAf8t
 v0Qpus0kmHcp+g5e2NXF2dZXhdQii3gcNFZ3tIHzF3D+ujuLLzniNguAH32dUNvLvmpc
 EX+iK5qzRUM3QSY8CjrK6gJoAVBByNm88A/02334GxiYS791aqvFVO/zNUoDH3hD6rqY
 K+AquFF+neEoS8kvEL4NHGo6mPxVFYeCNCrWWZ+0SInK9xckn8mwj9rlBqwOc6t3oVdI
 5L6XII0mTE042aDNUKTxruY35pHVb0MJTwaFoLbenvHRBojnN1RTm4s2MB6JfLVW+iRn
 Yk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771408284; x=1772013084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvLHTE0Km+ekZ4JGLj1aVouDCqT4KXqOziuQ00aW+0U=;
 b=XxMXCBWGLphzUJcRKnFZQZMEMkD+S3alqMrGl9zro1gWiThJY9yI0PK0AVKUX77BzM
 fWkDL7jqbb5XVzjuL36RJCQtPlAdqpSea0lPmTV4UbFSYWO6SQ2Peu/9kykhwz6wrb6H
 YU6PhxhhgZ4JMamAs/krHXJ/vJzcN/bD1rKfYGRoGCh2vFypSTxtBIUqLhEK+t/ETBYR
 deThnn6gYV5/ES5Uk9falo3D3OrES42ueSaU58D40GfyLyxN+Cqr+WaKa8yy0/EYswyF
 GEXa9TKg4GhMnHSod5+kq2/tfcZx4XRR2e49gaIHNzxo/+YdVJtEe03W5a4raEmI85JV
 lfCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzAh+ygHvDr9lA2WzJH44b3yAx85AjDRlbBfB2EW7JMmioXUcJF/9dQVkNbORY69YPJElU8gnLlAVR@nongnu.org
X-Gm-Message-State: AOJu0Yyjd4VVjSp7xN84ywz3Tj5eRVm1TH/4sUYf05iDn4lfjhu3h3aw
 +ZCgZW+MNXHb1kH37Q94saxTGhZzYZa/ic7cjLkUu7DifcQtY0wFMybUfTIlQRyRYKz7T1ox+H+
 KpUsbNJQ8V9AVzLcI0If3IHSo3D1JzA0ukLSSQD5bdHehHnFGXRUXYHR+
X-Gm-Gg: AZuq6aJNcKBwVE4D0i+JnlvhMK52cvxmyhq9v5bABE3JMF5l53nYRFKofbT9heFccUA
 6HOCpQT6EX+LjB1YPF28g7bb+3sPyzxdW9pRPuGm/AJtSwbVcQsQfhOmwN2Kgq1dSOcxqD8yrqu
 YO60m2zrvHSe1TfW5d22pQqCRtWAuk0YTCFUPkPh2sEq+s/3rFzEWwg1CXsrDRULKEYYWBor+d1
 yHxP1+8nymQsW75fPDcj0lnEpqGp9AmNAUEu8+XzRCRU4sld9Y6+5GyXJV0ceYLpCw+RHsPlOYk
 s7TDTQ6htoUOqHnt2HEmvCMPJJUw1DGoRR5SgbFOafBZQNdLZ9/m2Zvnm2UEuAXggMbfLpBjTMq
 5rJYo/A==
X-Received: by 2002:a05:6000:1a85:b0:435:975d:33b0 with SMTP id
 ffacd0b85a97d-43958e4c9c3mr2229484f8f.35.1771408283692; 
 Wed, 18 Feb 2026 01:51:23 -0800 (PST)
X-Received: by 2002:a05:6000:1a85:b0:435:975d:33b0 with SMTP id
 ffacd0b85a97d-43958e4c9c3mr2229448f8f.35.1771408283247; 
 Wed, 18 Feb 2026 01:51:23 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5b07fsm40094243f8f.2.2026.02.18.01.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 01:51:22 -0800 (PST)
Date: Wed, 18 Feb 2026 10:51:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zide Chen
 <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <20260218105120.5e55ad07@imammedo>
In-Reply-To: <aYy1R-JQjZ-Y38Am@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 11 Feb 2026 16:58:47 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Feb 11, 2026 at 03:30:06PM +0800, Zhao Liu wrote:
> > On Tue, Feb 10, 2026 at 09:56:08AM +0000, Daniel P. Berrang=C3=A9 wrote=
: =20
> > > Date: Tue, 10 Feb 2026 09:56:08 +0000
> > > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > > Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
> > >  properties accept flags
> > >=20
> > > On Tue, Feb 10, 2026 at 11:23:41AM +0800, Zhao Liu wrote: =20
> > > > Update qdev property interfaces (qdev_property_add_static() and
> > > > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> > > > This enables marking qdev properties with flags such as DEPRECATED =
or
> > > > INTERNAL.
> > > >=20
> > > > To facilitate this at the definition level, extend the boolean and
> > > > uint8_t property macros (as the examples) to accept variable argume=
nts
> > > > (VA_ARGS). This allows callers to optionally specify flags in the
> > > > property definition.
> > > >=20
> > > > Example:
> > > >=20
> > > > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER=
_DEF,
> > > >                   .flags =3D OBJECT_PROPERTY_DEPRECATED), =20
> > >=20
> > > In other places where we track deprecation in QEMU, we have not used
> > > a boolean flag. Instead we have used a "const char *deprecation_note"
> > > internally, which lets us provide a user facing message, to be printed
> > > out in the warn_report, informing them what to do instead (either the
> > > feature is entirely removed, or there is a better alternative). IMHO
> > > we should be following the same pattern for properties, as it is much
> > > more user friendly than just printing a totally generic message
> > > "XXXX is deprecated, stop using it"  =20
> >=20
> > Yes, rich deprecation hint is better. I think this still depends on
> > USER_SET - distinguish internal/external or not :-(.
> >=20
> > Since when we mark a property as deprecated, its code remains in the
> > code tree, and internal calls should not trigger warnings. Deprecation
> > hints are intended to reminder external users. =20
>=20
> This depends on where you put the deprecation check. IIUC, all the user
> facing codepaths for setting properties end up calling through
> object_set_properties_from_qdict, but internal codepaths don't use that.

I might be totally wrong, but occasionally I've considered using
object_set_properties_from_qdict() internally as much more compact form
compared to 'object_new()/set_this_property and set that one too' noodle.

>=20
> That method can check & emit the deprecation warnings, without us needing
> any explicit tracking of "user set" - the use context is derived from the
> codepath
>=20
>=20
> With regards,
> Daniel


