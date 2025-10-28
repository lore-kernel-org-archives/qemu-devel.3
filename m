Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916FBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjTc-0002IY-22; Tue, 28 Oct 2025 09:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDjTV-0002Ht-Ge
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDjTM-0001QO-MS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761657042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2uBjHvjp+rxM+YNv1+CIZ7OuVYSXpYXKg37sphaSyo=;
 b=WTOT9fMiEO9Bg4l5KAKNBMJ4BtJO0tz+cYqa8XQQKD0B2RiQhNmhes3HR5+U/DqHvBIhZo
 aMuTZP+wBrv7YCUcVCjFevhluKqVchBUlXo9xDEQD9lwT7HvTaKRIspET7eW52gYXBxHaN
 Xvtu06qq+aFtEIWN/k/Roozve6mZw58=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-8E00jibVMuuuh-NvQPb1Sg-1; Tue, 28 Oct 2025 09:10:40 -0400
X-MC-Unique: 8E00jibVMuuuh-NvQPb1Sg-1
X-Mimecast-MFC-AGG-ID: 8E00jibVMuuuh-NvQPb1Sg_1761657039
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42992cb2ee8so2060070f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761657039; x=1762261839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2uBjHvjp+rxM+YNv1+CIZ7OuVYSXpYXKg37sphaSyo=;
 b=k6ux4v0u97QPfKGk638OhDf0LWuG7+5hIRmz9ZmvYGHsT1LIit1lGaQlfV8vCaqWnk
 5kUSun+jpE8dmq6zOOwFvyfUjA6oijjFUwNEIwHCVF0EunZk1uDmDRMtkr+G1wKf1Tzi
 7JHiS/Uke91P3WcOCjibrdBwiQ7jjbNBMrq9ec4oJVwVObpICY2ykQJA917TzjlYlJVU
 bedW52j8mUnuMn5kKBCEcbYE6EgTKJnFXCMIdgz0j3bC21bOLqBSqSdzEnUU6BNE7JNK
 JLBwRiLpgFHO2hjvgvNDyTQXQhtxKyCgaCCRqUtHoR7cVBG1I1W9+1lIcHwREuwqYcAu
 /ePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMMZ5t8LSTfOmUatKKEQ9FDuhredAbMBdx/B4JyUNDRs/UZtJb3/7e7Lr4FDmTcd9jRNpK5rm6aV/q@nongnu.org
X-Gm-Message-State: AOJu0Yzwu79S18od0svUnVvwreiUv9t8dUR04KCBFydRgU2de2mpgpm4
 5UOYL/vZ3td51WvQJq+ehKdd1TFvqXWpdnVCue1VjAwwzbObXMIP91BZki2wHaFvDhnGrMyaVLK
 Hk4vCEQxiQ2uYkoSI/EO0CrSkJeGxo26NoNXtuvKvs6RzsONqfZc6wJ1m+j9SBRJJRlCEuMBb2A
 sAWRT7WXJrQ48V7HSp97IsmI1QTTjHEdw=
X-Gm-Gg: ASbGncv00NulZ4l2g1SnGVCf/LxpWPlh0wPfjjXgf+rQsomLD2SZ8hBv3T3i25d737X
 Kv9YlKr31o9/fZ6iMgm0DXxQICc6cVwZJe8N+rW8WZT00nL7m0Dw+cu4cv7tccAPun05kqiEWzz
 RA8jQT/ONgoneIXsZ+MxIz7QuDowzl4FMqUTdF08cnnrybWCVOaYJRiB2/Vu61W7bHh9EURG2/Z
 To5oeEV22wCgQn8QfoYoXO0x2tRX6lpeI2Kxn193X36IWpQEr/YjyW1gd/P
X-Received: by 2002:a05:6000:2508:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-429a7e4eb62mr2920472f8f.10.1761657039322; 
 Tue, 28 Oct 2025 06:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxUNVc6iqLHWou2f5q4canDtbA5jUMypNlSTbs1Kj5pwUD7jEJAHf7fV8eq0gCFSkSDt2fx9Nht8NJz0CKBqQ=
X-Received: by 2002:a05:6000:2508:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-429a7e4eb62mr2920445f8f.10.1761657038909; Tue, 28 Oct 2025
 06:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org> <aQCiCi5wsBA4Jq5V@redhat.com>
In-Reply-To: <aQCiCi5wsBA4Jq5V@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 14:10:26 +0100
X-Gm-Features: AWmQ_bnFoQG0qtujnAgkNlbEHLmRPgPpBQiIaz3U6A9g31ihF3LRSclttjYt-j0
Message-ID: <CABgObfbHcMBmpJNaSBUMTAWm=_+9M3aeBXHgZOiNyNDfzpCm1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, eduardo@habkost.net, philmd@linaro.org
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

On Tue, Oct 28, 2025 at 11:59=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> On Tue, Oct 28, 2025 at 11:33:31AM +0100, Markus Armbruster wrote:
> > Aside: "format for humans" may well be more widely applicable, if we
> > care.
>
> The scope of the DEV.FN hack is worse than that - with PCI addresses,
> while most of the time we just pass DEV, the QAPI also accepts it in
> DEV.FN format for the 'addr' property and libvirt relies on that.

That's fine, it's "just" a QAPI alternate type. A bit weird, but it
works and is used by other QAPI side.

The getter (printing) side is where the mess is.

Paolo


