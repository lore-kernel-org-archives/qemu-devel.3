Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC53C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5kY-0000KM-S4; Mon, 17 Feb 2025 13:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk5kW-0000K0-86
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk5kT-0007Vw-Vu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739816500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmTfIjYa8W/pUXR6/zrhtiA4VXAb0ZsGxMxrab5xcWQ=;
 b=DwtMRD2amgHYVFdE1Simt7Q5OhMRmE+HNEyNVzOxPburQB3AxDyOYs5/e7ehM2kgsmZBHR
 zAD+S1tGbCHfEs3lZZil4aGjpJ1OHFXFmHa3K30KWYE8Egu++0iTlAum1FWoFhS+A1jsGh
 JJQIbMSr0O5FdXmHOsqzSlPaoh8MJcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Bx7SSSRDMKGwQfeM_ie4EQ-1; Mon, 17 Feb 2025 13:21:38 -0500
X-MC-Unique: Bx7SSSRDMKGwQfeM_ie4EQ-1
X-Mimecast-MFC-AGG-ID: Bx7SSSRDMKGwQfeM_ie4EQ_1739816497
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so24981685e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739816496; x=1740421296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmTfIjYa8W/pUXR6/zrhtiA4VXAb0ZsGxMxrab5xcWQ=;
 b=Cp/ZXDMNtwEue2PHECtljhPCI9KgIN9vEIPP46EscRol+dSsiLceWlIOtqjd3qEHTD
 S1PTsxe6JDCrpZ7T2jrtD+XA3pkprFbNl6RwcHASs2oUAn618bTH2N9+JnPHmkOJU4Cu
 5gxD8IYxyeIu/QB/92DFp2IxFQjfOyKeqUfiwm4NU9SPHeaPLJYLvA0wOz8MS6dfxiyw
 YCHTBoSod1wkjEKIlU3jwhg1TZM17ddPiMYDAdi8Y16TRVTiilSnbAVqRnEfUMwI+IvX
 Q+VGlMHgfnkQRYM+tNdRC0TNPmoniIJG1hWjxCabPwCoow4GhTroRz9S49QhHI0moraz
 cLmg==
X-Gm-Message-State: AOJu0Yx2oG4DQXTMyoES+ubNjKT/D3aXqwdCDht5PeolxST/CCcrmJJ/
 ElAsgMWw0VwU2f4UHeHS2h/hRpikD0h+tWCZM/c1YQiINfESLYEWaVmZp1dnN+C7OsCDtGjdNfD
 iafsWOEdSMZu/OiRILIegiz3byWqJkCqi3io0Z/JICke1WeRs7TnFAxkGCWLWOGJ6uGG3YI1fdE
 cuMGzPQ9ID4pcvFGNi2rh4ECUMXkFaIthEFYefcw==
X-Gm-Gg: ASbGncuYFBl70CI1gFAXi2L/VcBkIvLBVDdYFFvlledHFn/as1xTN0QEvNSPa6VSmcX
 oQGPItq0oACa8gJvuaJErLuFrxpVTkd8l5jhsDBgZ3dv7qjhLS1cikJVlWstovyCA
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d017 with SMTP id
 5b1f17b1804b1-43988bbd458mr33548265e9.6.1739816496455; 
 Mon, 17 Feb 2025 10:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcOV4q/dZDWDmMClnSsdy6bhqFe68DH8161viXGV/8z4kVHffnKTwJaDr9Z/VxHoSD6FVudfOElqosfzaM+Mo=
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d017 with SMTP id
 5b1f17b1804b1-43988bbd458mr33548125e9.6.1739816496157; Mon, 17 Feb 2025
 10:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20250213160054.3937012-1-pbonzini@redhat.com>
 <20250213160054.3937012-28-pbonzini@redhat.com>
 <a826f77b-1abd-4706-82f1-854cfe9fc54a@tls.msk.ru>
In-Reply-To: <a826f77b-1abd-4706-82f1-854cfe9fc54a@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Feb 2025 19:21:24 +0100
X-Gm-Features: AWEUYZksgUqfBwePMPcxcK0Koscq0djmyRRKC_H5Mdu50gwWuRuIL-wjkKYiuSc
Message-ID: <CABgObfZc2QYFKxf3Lb3hz69BBmCyBSqSnH1H1jT-F=GXT=H3Bw@mail.gmail.com>
Subject: Re: [PULL 27/27] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Sat, Feb 15, 2025 at 6:36=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
> This looks like a qemu-stable material.  Please let me know if it is not.

Yes, that makes sense. Thanks Michael.

Paolo


