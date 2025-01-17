Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1775C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYono-0003JK-Ea; Fri, 17 Jan 2025 11:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYong-0003Fr-L2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:02:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYonc-0001E2-K7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737129737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jW/wo7233xWUQsW5xLgPaXn5rLpefJHSy+gczKkEcU=;
 b=etBbz13x1gcisuvNYfH1Se0fW/T7uRgPyDOvhkgEW7ZnG7su2DZDWk2Q/FIuTQi7ARgzIX
 XcA75x8WaOKc65O/7lImW6h4L0vhK+3SKbwzxWpkKVJ5g+/XSeBt6vqz4oRAgtj/WV3hHa
 mHfWuHcaASY9feGSliQnWmedKIj7Q4c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-RjPeKkhIP_6k6kxQwSjqGA-1; Fri, 17 Jan 2025 11:02:14 -0500
X-MC-Unique: RjPeKkhIP_6k6kxQwSjqGA-1
X-Mimecast-MFC-AGG-ID: RjPeKkhIP_6k6kxQwSjqGA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so210097666b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737129733; x=1737734533;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jW/wo7233xWUQsW5xLgPaXn5rLpefJHSy+gczKkEcU=;
 b=H90AQycOVUjlEtSVsyahh2hI8Bl2TLNkGxuveuxGQeksNasz4ZY8WTR3qM3Dyx4Mi8
 HoCQmqvO4hYWsU0Grjtzg8W3WcdFkC2sy/yBwYbFudOi3EMRc6VVv/Y+2ESYd+6H5XES
 aLrYm9SyvdzGOvCxuwOtqY0ViC+Y3lHs6EQcbgUl68HW378t/iftWmjtgq19b4xrvY2r
 XfVqQvgTFR4lnDBVSbUz/FqYGNvpq1e9FR+kvGxx1pMLM3rcRbi2MfhVWOx4tTdwbNfZ
 Cvkg20q3kvSNwUpMReaXQ3arO+AJAQkfqRxNBAJHZXskyP/7erdzURSqH38Io20hrRt/
 r4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Z0OqmLZTi/43huM3Au4nRJNBo3vwYD2MTCJcyh/KrRiJAa24Di2yzXV3q2MrsxU2RfwDQp79cBeA@nongnu.org
X-Gm-Message-State: AOJu0YzlHtN2AgExyqJKmvZK9gKb5zlO+LAM04/UvU6uSps0sS7xvmZG
 XchHhkr+bWRR1NWaQiMynWpHvuIOX2EPgdyUF94ueuaF0hCW+5o4Odsp0CV72VrUCIeJHW/osyt
 s5cIep4N0kijO6NSle6+Hcr4KRZ2o2fGzf2qfGEWyfNHVvmMQKp9spD/hND5ryeD0uJKTYukm7M
 5XT93ETqatsdE5EFJ4Es8UafcLfd4=
X-Gm-Gg: ASbGncuN5e2H7wWAEE0WNEGc1qOyJGIRsZLfH5Ey4wStlCi2Mmoabws30zXO7gGW2PA
 XFenwCh941jXuEMtKsByezHNUX1mjH82JRK9x
X-Google-Smtp-Source: AGHT+IHQTabPhGSQY5EGAqp6+1cRnE89BlcjBtmetz0riZk5auXhBKCskNp+7wj7xMw2a5dzlrJpGNERdrpm45DabIA=
X-Received: by 2002:a17:906:6a12:b0:aa6:a8da:7ba3 with SMTP id
 a640c23a62f3a-ab38b163e98mr358298566b.27.1737129733218; 
 Fri, 17 Jan 2025 08:02:13 -0800 (PST)
X-Received: by 2002:a17:906:6a12:b0:aa6:a8da:7ba3 with SMTP id
 a640c23a62f3a-ab38b163e98mt329902466b.27.1737129731258; Fri, 17 Jan 2025
 08:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20250110104335.267518-1-anisinha@redhat.com>
In-Reply-To: <20250110104335.267518-1-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 17 Jan 2025 21:32:00 +0530
X-Gm-Features: AbW1kvYAzei6mDI1NeLPfLMnAgc86MPypoYAY9tV925vJo6CHHn9gj__IK3_mhg
Message-ID: <CAK3XEhMSUC=axO2nBP3SC2KxGOnwfU8=MDi_m=GoYwUWusMfbg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
Cc: farosas@suse.de, armbru@redhat.com, kraxel@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, philmd@linaro.org, berrange@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jan 10, 2025 at 4:16=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> This patchset enables DMA interface support for writing fw-cfg files in
> libqtest. The first patch is just a code refactoring so that fw-cfg
> directory parsing can be part of a separate helper function.
> The second patch is the actual patch that introduces two new apis for
> writing and reading fw-cfg files using DMA interface. The apis are
> tested by writing a new basic qtest for vmcoreinfo device in patch 3.
>
> $ MALLOC_PERTURB_=3D255  QTEST_QEMU_BINARY=3D./qemu-system-x86_64  /works=
pace/qemu-ani/build/tests/qtest/vmcoreinfo-test
> TAP version 13
> # random seed: R02S33ea0ae4568aae69a6191a97e6ea37fc
> 1..1
> # Start of x86_64 tests
> # Start of vmcoreinfo tests
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-267380.=
sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-267380.qmp,id=
=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -dev=
ice vmcoreinfo -accel qtest
> ok 1 /x86_64/vmcoreinfo/basic-write
> # End of vmcoreinfo tests
> # End of x86_64 tests

CI pipeline seems green when run on this patch series:
https://gitlab.com/anisinha/qemu/-/pipelines/1629670893
(one failure seems unrelated)

>
> cc: kraxel@redhat.com
> cc: farosas@suse.de
> cc: lvivier@redhat.com
> cc: pbonzini@redhat.com
> cc: armbru@redhat.com
> cc: philmd@linaro.org
> cc: berrange@redhat.com
> cc: qemu-devel@nongnu.org
> cc: farosas@suse.de
>
> changelog:
> v3: first working version of the patch.
> v4: refactoring without any new changes put into a new patch.
> v5: a new qtest added to exercize the two new write and read apis.
>
> all along, other review feedbacks has been taken into account.
>
> Ani Sinha (3):
>   libqos/fw_cfg: refactor file directory iteraton to make it more
>     reusable
>   tests/qtest/libqos: add DMA support for writing and reading fw_cfg
>     files
>   tests/qtest/vmcoreinfo: add a unit test to exercize basic vmcoreinfo
>     function
>
>  MAINTAINERS                   |   2 +
>  tests/qtest/libqos/fw_cfg.c   | 204 ++++++++++++++++++++++++++++++----
>  tests/qtest/libqos/fw_cfg.h   |   6 +-
>  tests/qtest/meson.build       |   1 +
>  tests/qtest/vmcoreinfo-test.c |  90 +++++++++++++++
>  5 files changed, 280 insertions(+), 23 deletions(-)
>  create mode 100644 tests/qtest/vmcoreinfo-test.c
>
> --
> 2.45.2
>


