Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1q8-0002t3-9r; Thu, 11 Jul 2024 18:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1q5-0002lw-Ur
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:00:34 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1q2-00082o-Pw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:00:33 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e03a17a50a9so1496854276.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720735225; x=1721340025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUPHXtowZc0FpSF15QDG0VZLmeqH9bGLsPti2hLO22U=;
 b=Hdtr3iF7QuYODU5OL1YhYu8JLKLl7VTFn90qGQmTleiHjbkNyHOdFPG11Rrcpoybiq
 fZPI9HfNO/ZFWAegHKM43i+QbxCGiwsTtzZLpF5BUI1jHKA+jZ4XKKRBoVwbCJyhoVQe
 wLQ7wkIFW6QGCDdYct+vls3resYaU6XcACcDdb45dr2WXbIh1fEO0l0g/E943qvgzXYh
 pj32fbzEhcTnHxZPNNOCOpl9aJdThEvgECFscnGjMmXv24nzHnIw8w+J6Ga5eb0B9jeo
 n+da9dDLq6N4boH6ByQNdmqb3UNIhEzqGKY5laGzLjugbMsCiUjrtzfZtFg1okZx0TNP
 q9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735225; x=1721340025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUPHXtowZc0FpSF15QDG0VZLmeqH9bGLsPti2hLO22U=;
 b=b03SSaJcp9KGs/S5d851mj2VN3RrkLvJMUmZww1hPfiHwIcCU5FOC2u4jNe2JygRoX
 6XXF030NTsVoTBvwLcf2z0TsL25ItocG9dMjBqog6YOC+Uhz4/S4KyaK02smHJj+DWEv
 NYTBMh9PAtLc6/uyn7GIu4WeJjcFSxUNSbiFXb5oPMRGrWEDCs/iPRx/OYZOwU7m7NAi
 wAJHSLRovSMO7Giqafr2XHqg602drS0gAysMyQVhn5n5l5A6DMARyESWrB8lImHDRkUb
 yOv7x+MunDgoBfeO4neSgWCzKiGK5RCiu2piO14zTH1xa7ryLTOok+r/Mn4EFaU5lM/a
 63vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyU8qDzi5LVq6OHPCRq7HqjMIcRAFiBrqIRiXR6bFgjMmeL5I0L5+eLB9ran9Oi0Y9WbiQMk6p+bw7X8GITE+4jeYrEOw=
X-Gm-Message-State: AOJu0Yw47jcTAj5EhRZRvOnuCErj0jReWqnMg4VmBUnzvUIqHGRQFnMR
 YjVbNvHGLXHzWLbMtW5PzcFqTfwpMGfijPAYZBQLoe6PBVsXa/yLHmK/JhRECuJ1zOgopLHOiri
 TPiobi1B5Sf+D0Re9FbXZeSRlE35PKIQwMlWifQ==
X-Google-Smtp-Source: AGHT+IE7VZEc5B4yv1/lh5QMd95nzAc693yhNhTilqWrgnk1gt9UeMLXVLGGOe6UqZgBJ952ogKaM2UKLzg8spfgNYM=
X-Received: by 2002:a05:6902:2cf:b0:dff:2b58:f5d with SMTP id
 3f1490d57ef6-e041b0397ebmr11454578276.4.1720735225092; Thu, 11 Jul 2024
 15:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-9-yichen.wang@bytedance.com>
In-Reply-To: <20240711215244.19237-9-yichen.wang@bytedance.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Thu, 11 Jul 2024 15:00:14 -0700
Message-ID: <CAHObMVZ1rifLMe-6R_Lttu_aOWDPvqv29sa6p_gz_7HROn00Tg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] migration/multifd: Add new migration option for
 multifd DSA offloading.
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 11, 2024 at 2:53=E2=80=AFPM Yichen Wang <yichen.wang@bytedance.=
com> wrote:

> diff --git a/migration/options.c b/migration/options.c
> index 645f55003d..f839493016 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -29,6 +29,7 @@
>  #include "ram.h"
>  #include "options.h"
>  #include "sysemu/kvm.h"
> +#include <cpuid.h>
>
>  /* Maximum migrate downtime set to 2000 seconds */
>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
> @@ -162,6 +163,10 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationStat=
e,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    /* DEFINE_PROP_ARRAY("dsa-accel-path", MigrationState, x, */
> +    /*                    parameters.dsa_accel_path, qdev_prop_string, c=
har *), */
> +    /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
> +    /*                    parameters.dsa_accel_path), */
>
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),

I changed the dsa-accel-path to be a ['str'], i.e. strList* in C.
However, I am having a hard time about how to define the proper
properties here. I don't know what MARCO to use and I can't find good
examples... Need some guidance about how to proceed. Basically I will
need this to pass something like '-global
migration.dsa-accel-path=3D"/dev/dsa/wq0.0"' in cmdline, or
"migrate_set_parameter dsa-accel-path" in QEMU CLI. Don't know how to
pass strList there.

Thanks very much!

