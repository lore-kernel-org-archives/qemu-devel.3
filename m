Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7494CC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzI0-0005bC-2H; Wed, 17 Jul 2024 03:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTzHy-0005a9-94
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTzHw-0001PH-UX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721202084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOKx27yvxmhX1SnNBwUgApQ94sTW60ZLmy3JDlkIRbQ=;
 b=Ktf34U3xHCEHIkuMXXzFyz/jHX+qo98b+AF37/hVwpb0lofFds25UzzsK5ljolOOeFZNsr
 VLRtP1T7ePduEMB2X0hrNQmuLdYUdqPQhdf1QuTm13REm4lgRKfSYXy6VgiJdER0klwFnC
 /PX4YW2taJN7P+5fEGp3IB/pPS8TFx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-UlKgJ5IYNSm3qP5JBXuXdQ-1; Wed, 17 Jul 2024 03:41:22 -0400
X-MC-Unique: UlKgJ5IYNSm3qP5JBXuXdQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3679ed08797so4177100f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 00:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721202081; x=1721806881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOKx27yvxmhX1SnNBwUgApQ94sTW60ZLmy3JDlkIRbQ=;
 b=XNj6fK7+9GgDK/4ofwnnqcz/JQ1muuN0yRLgoGSTCJLgvJvv7nGufGGGGHXYrEN4j8
 5KsWkzHLNXxn3KcBy+6pphJo4F0f/nt47NW9E7pfWhtLcBUJ/3zVX45zI3D/Qs86wZ9B
 u9UhHpnRjtGqlHzC435lOVHtD8ysE4bkRusYcYrZAuBZgNWGDKuplWWehYF8+0Z9gKHp
 gHUU4V+R/WO8JYDCtWDd2MqEvVcTaeNUcfxe/Iq16hfPOb5gifHwpo7z9LKQ4SMbWyoU
 nkvhtl9QdisLK6oTwgN91nam0P85ho59ou/8DmNz5CSvVMVd7OqlmuY8LdG6AdYA6bb2
 YWRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2zrdDl0JaH6YIdyGB/YdSW+bohUKDZy33lIifPYQSEjMsmL0YMU8jqMb7jKMSNIQeXsRM1DtAaZ5eyGZx+EKyjPNWnJI=
X-Gm-Message-State: AOJu0YwywfgPlZSPsV/u5H9LuIOh6hOcZ4plsHM7UTZJvYe8NG59bpeH
 oJMSzkBG6jJAee5e5B4Io3b0p/JKIuLLxgHDbZiZ0H/TLFP9sMOSR3ji25wRvzr1T8kf/fBcG3b
 K5SiWPYy+H3VSvRpLdxs2qv43qiA9JzoEt8Mp8D9mgjNUgiYw5H0NpONVsMWpytCll7EtJzraOs
 P0f/h13oknROQKinLf2zooskB7bE4=
X-Received: by 2002:a05:6000:4020:b0:367:9792:8bd4 with SMTP id
 ffacd0b85a97d-368316fac1bmr690049f8f.43.1721202081650; 
 Wed, 17 Jul 2024 00:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbF5OYUwEr/YqRLWQwPqdNezEkvc17vfnAMVbLMiPWvxCYG/JJmhTz7+3CcTHLtRx+r/KDqRLDt9s9R7tIMzA=
X-Received: by 2002:a05:6000:4020:b0:367:9792:8bd4 with SMTP id
 ffacd0b85a97d-368316fac1bmr690033f8f.43.1721202081291; Wed, 17 Jul 2024
 00:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
 <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
 <9a58a934-75c2-4f9d-89a6-3c38e9fae747@redhat.com>
In-Reply-To: <9a58a934-75c2-4f9d-89a6-3c38e9fae747@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Jul 2024 09:41:08 +0200
Message-ID: <CABgObfaU73yy6xOLgyvorjt77V=mG6ucALtXfih=B4Y_K2bXbw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 9:32=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> > There is the pycotap dependency to produce TAP from pytest, but that's
> > probably something small enough to be vendored.
>
> The next version is only depending on pycotap now. I'm installing it in t=
he
> venv there that we also install when running the old avocado tests. Not s=
ure
> whether that's the best solution, though. Would it be OK to have it in
> python/wheels/ instead?

Yes, and you can probably move it to the same group as meson; it's
ridiculously small (5k) and it is indeed used _with_ meson. Then you
don't need any change in "configure".

Paolo


