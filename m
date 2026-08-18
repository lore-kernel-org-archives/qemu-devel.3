Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9376C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPEg-0003Xm-JE; Tue, 18 Aug 2026 15:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwPEf-0003XQ-76
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwPEd-0004sJ-Jc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787080350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5vo9xrmKpGBQwHUEOBbi0HnDAyWxEZBR+dgMKDw8MU=;
 b=WgWAbfUCGPsuFr/xgft1D3+VwpTrUnCkCpC3ZxXxYU/ekPVKFXK4PZuKG1Lxpep6mJ/Uz4
 DDf+HufNbcquqdcXY7+GtOS8tXIo1jGJ9UZ0eS6V3ksnV3iwmhtaBQqRfPp0UgO1EPS8s4
 OLHVIlZgwykgyPxyyhrNqOe86PcBqoI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-eBb9nFQuNBGQhizI9bBtsA-1; Tue, 18 Aug 2026 15:12:28 -0400
X-MC-Unique: eBb9nFQuNBGQhizI9bBtsA-1
X-Mimecast-MFC-AGG-ID: eBb9nFQuNBGQhizI9bBtsA_1787080348
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so1218371cf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787080348; x=1787685148; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r5vo9xrmKpGBQwHUEOBbi0HnDAyWxEZBR+dgMKDw8MU=;
 b=kUNEQI96ZSSuqBswsLlp1BF8a6+3yrxRS4niIwhrSurNJcYduTbkTvvZkdO52+Tfkn
 z06rh2PTzu3Kc38QCVWDBvxtrOMQ1aK0UU5/PiPO/Zn2ssugy6fWfy7txOT1ksSFxJ7g
 D4btXreTBgshMe1GBXR2wzVKhBa4xa90VIJlVyowA4l13dvZ0h+3C18HhfLyHfTciTaz
 WRNYWeR3O2DHA2hWxWJkBFwEDbVX+hmvRiLdxF2ZZvxNDyF5ZI20a8PxSrlR+ppHnw/L
 c3dSpXS/iSLEgEw9hI9szOvGkNm8woPX4hYgXebIAipwMMyiJly2C3sLGT7NeMgeXPQ3
 UFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080348; x=1787685148;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5vo9xrmKpGBQwHUEOBbi0HnDAyWxEZBR+dgMKDw8MU=;
 b=slQnCSOBsAjfCZ2OhWK8lUNJIMgyZph2qNR5zaaHk8eSj+qnvKpzgFZI0HakQzQF5F
 gKOlJUnvQF9nVCeP+mUoUz1H2xW8nhANWgRKhpKAPWkSt3LlMo7Xo00ie4r6kWk540QZ
 doM1TJKevYloGrsVkysdOXTVl8+yPYPnuYG0a/3Kslm50t0HLhbWOgI7gqlGviawU4KG
 ztNvfF42FQyBc75GLD1vGaOLx3AAQ96Pf0vsauP6a063/3b2CxpddfFjCbYTK75FzrgX
 VG47HYHBKJ/IDWgVI2bZUqwEPbA+qobSUkLk7SbaDz/SWBp5em0m8BvOMwwHvuOL8Yf8
 1LKg==
X-Gm-Message-State: AOJu0YxSJPibuEX160JMQDvYvwyAB5ajgULSO8OGOu5tAR8N/19jxMK+
 qVtQeskm9oCdjE/cH5i/JNgT4d5jYySF1GoWLFGwRBlxKEFVcmBrhxoG1a897Pp3oGFEaTIr0Ek
 4+Lw8sNLXj+tbhhsFYg7dFkLW2aNOag90H6bna3oohT1efv+hTWbShl7X
X-Gm-Gg: AR+sD13M2xDycSH0IHPcyujfYQihEoCsFUQjvYBjC+Lf/yBNdwl4KGSZ+JoL87saV9H
 j3ikP37YuReYGRZ2OelkBrMBRBcL+3SghfgfiNO3TzzoyJ9Uq1WKPajkP/z4Ml7jkx+mWWp48aH
 AbvOUnXmgsy62Zl2AxQ9DFH3brSpIsGvThHW4g+k5RHDIjG77vs1/OIC2gD9lK38gKwN9aXvNSY
 d/CNYNt6VBZ7qKsz2nEL/vWDnRirJ5rGYU7M9huo3a6IwIDX7Q8GL32r8n2K7Xz4sIe0uiIpvOm
 s/QeiNhmEdUWVJNqH8Gfd8FlZAUfqSPiNg9w5jqr/gHeid+dGo3Abm/D0pbSWXrzsG5Z
X-Received: by 2002:a05:622a:581b:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-52dd32553a9mr3148131cf.25.1787080348182; 
 Tue, 18 Aug 2026 12:12:28 -0700 (PDT)
X-Received: by 2002:a05:622a:581b:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-52dd32553a9mr3147141cf.25.1787080347582; 
 Tue, 18 Aug 2026 12:12:27 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c45934adbsm38949436d6.31.2026.08.18.12.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:12:26 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:12:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/8] migration: Remove extra type-checking from
 vmstate macros
Message-ID: <aoSul4i5M4LiqXAt@x1.local>
References: <20260818182441.404790-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818182441.404790-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 18, 2026 at 03:24:33PM -0300, Fabiano Rosas wrote:
> Changes in v2:
> 
> - Removed more unused vmstate macros
> - Fixed the type check macro
> - Renamed the new structure to something more explicit
> - Added a new flag to indicate an empty vmstate
> - Added the overflow and overallocation checks
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2769617319
> Also tested:
> - migration-test --full --thorough
> - x86_64 compat run forward and backwards for previous 3 QEMU releases
> - s390x compat run forward and backwards for previous 2 QEMU releases
> - ppc64 compat run forward and backwards for previous QEMU release
> - migration-test smoke ASAN/UBSAN run
> 
> v1:
> https://lore.kernel.org/r/20260729225227.1170574-1-farosas@suse.de
> 
> Hi, this is basically what I ranted about in:
> https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> 
> I'm replacing the per-integer-size type checks with a single "int that
> fits in 32bit" check. This allows several lines of duplicated code to
> be removed.
> 
> I haven't changed the macro names in the device code yet. If this
> series gets positive feedback then I'll send per-subsystem patches
> doing that.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> Also tested:
> - migration-test --full --thorough
> - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> - s390x compat run forwards and backwards for previous 2 QEMU releases
> - ppc64 compat run forwards and backwards for previous QEMU release
> - migration-test smoke ASAN/UBSAN run
> 
> Fabiano Rosas (8):
>   migration: Remove unused vmstate macros
>   migration: Introduce VMStateStructMember
>   migration: Remove redundant flags
>   migration: Remove duplicate vmstate macros
>   migration: Add VMS_NO_STATE flag
>   migration: Check more vmstate flags
>   migration: Harden vmstate_handle_alloc
>   migration: Harden vmstate_size
> 
>  hw/pci/msix.c                      |   6 +-
>  hw/scsi/scsi-bus.c                 |   6 +-
>  include/migration/vmstate.h        | 388 +++++++++++++----------------
>  migration/savevm.c                 |  29 ++-
>  migration/vmstate.c                | 103 +++++---
>  rust/bindings/migration-sys/lib.rs |  17 +-
>  rust/migration/src/vmstate.rs      |  32 ++-
>  rust/tests/tests/vmstate_tests.rs  |  32 +--
>  8 files changed, 331 insertions(+), 282 deletions(-)

For anything that is non-Rust:

Acked-by: Peter Xu <peterx@redhat.com>

One typo I'll comment inline, can be touched up when you queue.

-- 
Peter Xu


