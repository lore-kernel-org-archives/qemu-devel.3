Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1719E83858
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKyo-00084e-EV; Tue, 17 Feb 2026 08:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1vsKym-00084G-Ma
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1vsKyl-0006vS-8q
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771334342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBDk1tiECWXbU21ZlKvbb36zS6eV0L7z2+UK4hLJhpI=;
 b=gjqNe/TLU1XNLUhkod7lemsXJXcI0ldXB8DjwP1bc98Gex52AypdzaLBIHta55u4gFt2St
 LJ5rQoKJ05e3Aix5BCmkXqWTcS8fn1/eApOMzOthrOgbHecR53ufEMqK/fQyoSAH07adSB
 A/E+oR7Y/PoqJP6HK1Nz+t4NCkdPVTU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-YmR_XUG0OMi5B04uj997UA-1; Tue, 17 Feb 2026 08:19:01 -0500
X-MC-Unique: YmR_XUG0OMi5B04uj997UA-1
X-Mimecast-MFC-AGG-ID: YmR_XUG0OMi5B04uj997UA_1771334341
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506a1999e44so319677461cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 05:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334340; cv=none;
 d=google.com; s=arc-20240605;
 b=Oj4VKFcqxQHSxWFPkIOoarCd8BBLgz5zWu/cjgNvhWf2gA7Y2ARWgzkSZJyyYcDpce
 AMEUhj3t2RRbpwfxw4NUbwAT+lcEDe1A6BFuMXbcxxG7wrHYPnbpTnhYKK5u5f6jKeri
 kSCW3+hGVohAV6zFFmoot4VUlCN7ppnWX1Sgk/cbCjr9kswkBcSsFFIHw7fjnvnTPADm
 g9weVKb26KBYGGTAjMxtS0S+KCcTgQyewL+sMyFZLokZROECm4XERzEM53EzmxSXEa+6
 BVWU+ePv4cMqFuvbwy4522V2jNp/UdJMfb+eeTlFDz1uQJlfQ/m6FobhT86CwMQwGU+D
 dsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:dkim-signature;
 bh=hBDk1tiECWXbU21ZlKvbb36zS6eV0L7z2+UK4hLJhpI=;
 fh=93DYLXL9ggaYV0LQL31J1vlar1h6yrp91FKcWoNLmyc=;
 b=XHF305vFGohqEdsIOmclli+A/QE6ctlQ/L/3uwaOj3x2vlgR63ZK397+wYRNODGQGb
 TnPKvkHqY/pF+7pZeI2ITmJb0COb9alDYPO+RMixnRftmEKqevPBljRBU7UlHMuRwdxF
 uvQf72E/2temh+XjWrI7AIME/8xViFR3tATVMd/luSzxeWYpTMeOuezzQeicuJHF5fUs
 iAWSIGctVjWVx/EKY3nFsNdpETEOlD0eA1IgTLqkLT4bMEg4zz5xWfO16KOAXbfMNTvI
 H+lUiH+faMXAxnKExE+3WeYpIlGW2rfeSPVqHi/o0+RFzowQ6uPLegXlIy9nsPJNYgkV
 ZL+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771334340; x=1771939140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBDk1tiECWXbU21ZlKvbb36zS6eV0L7z2+UK4hLJhpI=;
 b=LAE8y9zoY2TUSkE9KeDVHGY6j7mSaEavW/YgWc6bG9JK/Tw4X6RLTN3av6d9m3pa7K
 lgABixczoH5UQdjoTv3s1doqMhNjRPQXW96B9ahEbrfj7kQTqPtVFF3KhpZor/o4D/3i
 3iduKiAXoPa01T4LaDJXzpHfkOTXGjkrdMG2uDf5ZVji4Y8SFj7S50bACkEoBwPrdXBT
 xVGPSr1DsX9ienaR6Gv3FYy2u+OAZAXaREwUNwiKXRhaTkesUVBbyKc+RXW/7VvRIpUw
 NZIB/Pi587U2OuPQ1LBmXz5UHZ5g0at/ebnvU/+6i7EVqVTlaBPYIrFajV6NKULGjNus
 s8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771334340; x=1771939140;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBDk1tiECWXbU21ZlKvbb36zS6eV0L7z2+UK4hLJhpI=;
 b=VCUItrAna2rfw7Jj8Xp23igsPEyJw1jE7uiDDwaQ8FviJvvoIcKjAopzEAvea5vg2A
 vZOYf/I2l8MgLyF7vovKMwz5nDa3cfxBEli/RmDAD/CmFLDa4y3pjMmo4rbayefDCO0N
 UrkCEH3GpY0QQZK5MNx/+ZgPhz1MP2GgUdzdKB0RwGRSJLHNRuwOUkefi6VA3Pea9/sw
 nG6za+urPudGwSTINpmOniqTCprWzZK+0Mr55wMo0olop/3LIYVSMr4cAPOQiJb7ww+1
 eDmEVuphnIaraLsgE4VM5ghpXIV7A/l4oGJ4LmU2nDaoGNm9rT6v8xMu9nCA0gbrTQko
 p13Q==
X-Gm-Message-State: AOJu0Yz+wYSOCRUiZGDnAOebbG0Y27ifZFfTHGKOP/0oOFiktRxNGKLg
 EBLYMLxbhk0zx198yJPcYMOc9hMtQflgTxTQLNzettsChnA+Nwa9L9PiTxu/O3rzoGDbyYay3P0
 /hP7jkz0GsTtajbTpkoO3CFdtsnsNDdBQ19PX+U9dzO3AebUZkOXtw+sU6ppfAcog3VftZ/+MmI
 +7Y8APenOgPgeNGKFJu3fss+RSztkG2nI=
X-Gm-Gg: AZuq6aIn4ksRdXicNMVq7e7umsz9ranKtWFAkpi5DuChufayxpprX+Dpa+ZQDdp8Quu
 3C0XP8E/+EISMNgkl1ul/TXWs8RLC2w9Dw563jwqacPPD8jTPiulu0LGP0hQjfB30pDGODVB+Aa
 iNDb8uKZJ4gDgft/ScXMQzSAaLg53Duk7rIlKt0poHjLkt/apQCkRdgsKlpAMiKsfyip3GVnM+x
 S+CO44=
X-Received: by 2002:ac8:7d14:0:b0:502:f07e:8565 with SMTP id
 d75a77b69052e-506a83287c5mr148958471cf.41.1771334340768; 
 Tue, 17 Feb 2026 05:19:00 -0800 (PST)
X-Received: by 2002:ac8:7d14:0:b0:502:f07e:8565 with SMTP id
 d75a77b69052e-506a83287c5mr148958241cf.41.1771334340420; Tue, 17 Feb 2026
 05:19:00 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 05:18:59 -0800
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 05:18:59 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
 <87seazn3ep.fsf@pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87seazn3ep.fsf@pond.sub.org>
Date: Tue, 17 Feb 2026 05:18:59 -0800
X-Gm-Features: AaiRm53o8TfP6M6URD9Lv4bTTDXoMMSlkl3CPXzZg7tkcNEb_YwEogXVvXUz6wg
Message-ID: <CABJz62MVB1ThuQ95Y0LVSdJ25mSBrct8FyS7GFhm4PXz_yKqjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 17, 2026 at 10:08:14AM +0100, Markus Armbruster wrote:
> > +# @uefi-vars: Information specific to firmware builds that expect the
> > +#             "uefi-vars" device to be used to provide access to the
> > +#             UEFI variable store.  If the mapping contains this
> > +#             member, the firmware descriptor should advertise the
> > +#             @uefi interface from @FirmwareOSInterface as well as
> > +#             the @host-uefi-vars feature from @FirmwareFeature.
> > +#             Since 11.0
> > +#
>
> (Since 11.0) and indent like this, please:

Done, but note that the documentation for existing members
FirmwareDevice::igvm and FirmwareMappingFlash::mode doesn't follow
this convention.

-- 
Andrea Bolognani / Red Hat / Virtualization


