Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F5FC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp7ld-0005MM-L2; Wed, 29 Jul 2026 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wp7lc-0005MC-50
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wp7lZ-0000iJ-6c
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785344903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtMDQQ8P7jogKX/DaFK3dwhlAQg67ExL8fqTonoWsbI=;
 b=J5nFhuMfEQtmBWxwTDRBNKxQn816ng16NE/u2HF6nb/HVvrzpvKjzHoo7fxOB4LDdewHtJ
 lvZez6Kjn7bnNP1HUPU7dLYUvY6kao1Pn1mlzuSQgIym2majpuzK0UVw88WLtI3RmceUAV
 rQZB5u30ZEZbs4r3ZDu6CqnPpG2nyXM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-8rMSr6E-NACLFTO9phenOg-1; Wed, 29 Jul 2026 13:08:21 -0400
X-MC-Unique: 8rMSr6E-NACLFTO9phenOg-1
X-Mimecast-MFC-AGG-ID: 8rMSr6E-NACLFTO9phenOg_1785344901
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e3d575d6eso2144616b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344901; cv=none;
 d=google.com; s=arc-20260327;
 b=i4gm3T/lktzh5tCS2mpJho6rV2L2Bg9B1oVe+X0tIJvSy/Ur6uROIPlwCzkYscMHUj
 0j5aKGkL0lCqlm3MtYt6wrf0y4LSzu4hDz3Yii6EemNTMrFkz7C1Yj+1ZiqkCDjpGKD8
 xUQZvgLqQ6lrW3zM3piMJOhYW8o/3i845BX12B8u8QVliX4IJ4xB4v2yz5pkcrIk120K
 GmBYvUV5yrxZ76JMdrSB82PlHun88z+uNY1scARETajQ1Tui1N9M977+H7tY5+oqv17P
 R8iMRxxRqHI0vV8IBx8eskHTMaYVUhOW7yoVLFsnj2Y0gk7q6KHiaDjSOUkThRypezxH
 30Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EtMDQQ8P7jogKX/DaFK3dwhlAQg67ExL8fqTonoWsbI=;
 fh=Mv1A6n6KFlrSGcPfMYLj5w1nMwlf7S1yGBCIO/Xo1CM=;
 b=oJIcR3WCQppFuQaDHDN71392pwCnqnuJwC5cMlGDZXllvE3Rqv1XWTqSYQQSy/bU1h
 UbZ4kXhIbdf1thrcb12n0qjgKJFGAZdUexcm+vJcMz70ovIp3+OzYpuIweBu0VyzQGMy
 z6Ehft62HAZH3CFjeKe4Qte8QlfFdom31rFWMXo5pe+YYip6b+QiNDZ9Z1k7llJlotwH
 tipm7u3kZOGlZqBzS6YYeYqTDvILa4vmx4TMQYdOiwbLZJHhwISLlvwAt/0Am0OuFdXU
 jmXefpQGnk8GoguljXWmMZcY82BxGUX9t1CghBtfgW6YLZEUp5vlGX3NfPjkSUrUbcBT
 3kPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785344901; x=1785949701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EtMDQQ8P7jogKX/DaFK3dwhlAQg67ExL8fqTonoWsbI=;
 b=hay1L5hYEYqTegEkAASussoqy1YgcCgBcZ66moXPBZFiR60fmWovcHSJczWZhpGPoH
 MS1/oaZhN2uuvnjI5MJgnCtwc+Yzsxduz+eKPb/wm22nthnRNB5B/B76uRbcGEvqezkh
 +T3/2MA1f+sAt3lU6DWdg4Kc/3zD/kGOPBSzd83olsiU2hXEK5TQnBpBU1rNUshjPxd4
 8C/DkJUTO/qLOZtZRKoJaKdGhvEuoC9dsJpfYfBkEjgXQS/DFkGirQMvuL1aSb5Joa56
 GaBtn69fWhm4XdZKSYTWF+4+K73dcQz20kvJD6VpqFMSrXMfAvvomrLF7/aXg5hEPUGh
 iOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785344901; x=1785949701;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EtMDQQ8P7jogKX/DaFK3dwhlAQg67ExL8fqTonoWsbI=;
 b=g2zccKd3Fwu8LG3PjLH/ANbkoxmx5n1Luo6jmrvrqzZMb9W0gnoafvoltXZWVYLm7L
 VQ/UnwhqnqAw4nZbN8Z+urYJ5hCFrZWqqUmA/vqYfZz7TB7TK59h8US6oZIFViHWJb46
 +oxHVhP/ZLPlvuu9lvF/EbOlri8rTIJ1+5wKxhWoymYHvKv5a85y3bfvReAj41DyU+DI
 d530XFPURneUMUD04INmU+VuGs2IVfJMGNi9U6Pqw+7ITijRMiWetlow0vsQSMKIfSnZ
 +gYgSku+7LIyfFih1bRcFsL5jFR5bMb9y705JkxaPlRQDelI2OWzaTtALRiiNWRmnveu
 ytEQ==
X-Gm-Message-State: AOJu0YyeYzPm4d8H6SjzfQPydxDNnGEwVzYN+EFtxdk32P1pbJAvZeWV
 o2wAnCLT8gTwE+Osx1YVlSBAN0NdyAUebO+sQCTshOSzMG8A7vKRDJva9kfOieapTF0xlPw9VUF
 HGU6s0ZH8RlLV4Iv70N/ll4U8LiNBqsJQ/68dyp0Oq+da35kXD3uMVJH0xBw5veRWNuQnveCT9I
 fkjlY9gu74h3XSDdqAi5CCSbKMhlIg3Es=
X-Gm-Gg: AR+sD12+F8cj7mk3QxBtuXSZfBMcA1Yoh0X7dDtT7vp3tPy3mWQDTxXFnFwa5tgyrVV
 oUHJqKfNu/9Fftd0OWhkJOSRNm0O2VkQboRFPCrsJoqKfHxRykNp2LGu6AS5HHcR7qK2iMAC1XG
 Ljj+bxDNOQKrq6VlPkudY0W3OH4uBsqLM8ZOEjrzs1jpRhgdITQUe0MiwCVkyWBtn+RgaI7PqY+
 MlLL5DO49haf11/31PyGTlm+FiSpNzwM6pJ1RoCI39UO4EwIRAc/+LnG4FeLAy9q4Zd4f0Ybh6i
 DQ==
X-Received: by 2002:a05:6a00:390a:b0:847:7f38:27c2 with SMTP id
 d2e1a72fcca58-84e933215d7mr8040837b3a.50.1785344900659; 
 Wed, 29 Jul 2026 10:08:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:390a:b0:847:7f38:27c2 with SMTP id
 d2e1a72fcca58-84e933215d7mr8040802b3a.50.1785344900193; Wed, 29 Jul 2026
 10:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260729150420.632747-2-rohit.kuma1313@gmail.com>
In-Reply-To: <20260729150420.632747-2-rohit.kuma1313@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 21:08:08 +0400
X-Gm-Features: AUfX_mzrrt7lp1BHm7aFXgjv_rOhLV7CiUMPXfcje9DDNQfeZr4p98Hf0FUIwzc
Message-ID: <CAMxuvazXhyzMUS+NC=62izXb8VgPSSD1mpa23QU3XAW61uYkng@mail.gmail.com>
Subject: Re: [PATCH] meson: do not emit modules with no enabled sources
To: Rohitashv Kumar <rohit.kuma1313@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rohitashv Kumar <roohiit@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 29, 2026 at 7:09=E2=80=AFPM Rohitashv Kumar
<rohit.kuma1313@gmail.com> wrote:
>
> From: Rohitashv Kumar <roohiit@amazon.de>
>
> With modular builds, the system/block module loop adds the common
> boilerplate (modulecommon) to every registered module and emits a
> shared_module unconditionally.  A module whose device sources are all
> disabled by the configuration then still produces a shared object
> containing nothing but the boilerplate: an empty stub that provides no
> devices and only complicates packaging.
>
> This happens when a module is registered under a broader condition than
> the one gating its sources, e.g. hw-display-virtio-gpu-pci (registered on
> CONFIG_VIRTIO_PCI, sources need CONFIG_VIRTIO_GPU) in a build without
> virtio-gpu, or hw-s390x-virtio-gpu-ccw (registered unconditionally,
> source needs CONFIG_VIRTIO_CCW) in a build without an s390x target.
>
> The target_modules loop already skips modules whose applied source set is
> empty; make the system/block loop consistent and do the same.
>
> Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 49a5baf5..557edd71 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3903,6 +3903,9 @@ foreach d, list : modules
>      if enable_modules
>        module_ss.add(modulecommon)
>        module_ss =3D module_ss.apply(config_all_devices, strict: false)
> +      if module_ss.sources() =3D=3D []
> +        continue
> +      endif
>        sl =3D static_library(d + '-' + m, [genh, module_ss.sources()],
>                            dependencies: module_ss.dependencies(), pic: t=
rue)
>        if d =3D=3D 'block'
> --
> 2.47.3
>


