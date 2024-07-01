Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B4DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONNC-00028H-9I; Mon, 01 Jul 2024 16:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONN9-00027R-KZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONN6-0007Nf-HD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719864691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1Bmzf18tqA72WYbutfrlaRNAV4g4BhMr+FLGFrkLyg=;
 b=Q94d4rK2nlNPozJ5Ba4gwaCKBQw1EDJ2gk1s9A10eRmh+mJ4XCoSsjhMqq1ECLus40rTwT
 XGMDDPoKsIln1SQZVywyNqSoYYuuS2aC613QGwHkm0cfWxCLZ8FmLQXfnRqUMX520xz373
 dbHxIROyM5vhO4q65SeG/iXaRraZgi8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-gwfrjqF4Naqr08OA7_ZgZA-1; Mon, 01 Jul 2024 16:11:28 -0400
X-MC-Unique: gwfrjqF4Naqr08OA7_ZgZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso13504695e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719864685; x=1720469485;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H1Bmzf18tqA72WYbutfrlaRNAV4g4BhMr+FLGFrkLyg=;
 b=Fc5Z+sF/jBl2lvOM+c/SemZuaMXn4nQhNNuBKYb/D3PsIFD1RcBB2YpjuhFuxq8uUp
 YxUxBDWzJBqVlwPeWcV0K0mZLxl/8lOfIsd/l987LKewKB5h7Gm4MIywXEkS12R05S6F
 oOxMEyH7ZXZ+Dg4zzpcCdI1Qzh2iF6pVJKuxTE/StYAsoSh9xIQhRY/LiZTyIok2tR/v
 17imQl6TwK++i2sy4KMrdAnfnHgxzk0Vmprul2zcYpYN7oEeOs5pig0bYVyLtzUxioPg
 GXkDh/lBJXYnvMDxLzLfDSj2Js+M0tsebqEB5ix+zLotFnXIknSeuG84XLNMVlOqdXXz
 LaYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBapWXwPvc7QhB+dx7eE5KcdjAF+kqf/Asqm6P96gbKSN3ltPL6G2bb6QS21KcGHZQenLdJ3wlRrZyl/GTk0St1hQdgs8=
X-Gm-Message-State: AOJu0YxO5fo5VdN43UG5VFhMghURIzKiStkXNyHZfz4YwB8lIMjMoCqm
 Le5kYvP/D+pBkn3QEc6MmFDENWnQLz80SP+2aCe3Pc0EZ9U7ADQBT0Q+hc7yD5hB6tlqDPYkoHn
 4arR+XWV6b0QecCsXIJAH5OSU9MnRaV1LnDkWXSXAownstChxE0u0
X-Received: by 2002:a05:600c:364c:b0:425:678b:901d with SMTP id
 5b1f17b1804b1-4257a010da5mr42271625e9.21.1719864685324; 
 Mon, 01 Jul 2024 13:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUgUuvV6FrRFQEwsr6edMpyTZpJKfLGPRFv9EXYQyPfllVDFeiAt+fAMNjxQMOPtUjXb7+1A==
X-Received: by 2002:a05:600c:364c:b0:425:678b:901d with SMTP id
 5b1f17b1804b1-4257a010da5mr42271465e9.21.1719864684666; 
 Mon, 01 Jul 2024 13:11:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b063485sm163616315e9.21.2024.07.01.13.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:11:24 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:11:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 00/15] Fix check-qtest-ppc64 sanitizer errors
Message-ID: <20240701161033-mutt-send-email-mst@kernel.org>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 10:37:43PM +0900, Akihiko Odaki wrote:
> Based-on: <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com>
> ("[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'")
> 
> I saw various sanitizer errors when running check-qtest-ppc64. While
> I could just turn off sanitizers, I decided to tackle them this time.
> 
> Unfortunately, GLib does not free test data in some cases so some
> sanitizer errors remain. All sanitizer errors will be gone with this
> patch series combined with the following change for GLib:
> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

who's merging all this?

> ---
> Changes in v2:
> - Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
>   (Philippe Mathieu-Daudé)
> - Converted IRQs into GPIO lines and removed one qemu_irq usage.
>   (Peter Maydell)
> - s/suppresses/fixes/ (Michael S. Tsirkin)
> - Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
>   (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
> - Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com
> 
> ---
> Akihiko Odaki (15):
>       cpu: Free cpu_ases
>       hw/ide: Convert macio ide_irq into GPIO line
>       hw/ide: Remove internal DMA qemu_irq
>       hw/isa/vt82c686: Define a GPIO line between vt82c686 and i8259
>       spapr: Free stdout path
>       ppc/vof: Fix unaligned FDT property access
>       hw/virtio: Free vqs after vhost_dev_cleanup()
>       migration: Free removed SaveStateEntry
>       memory: Do not create circular reference with subregion
>       tests/qtest: Use qtest_add_data_func_full()
>       tests/qtest: Free unused QMP response
>       tests/qtest: Free old machine variable name
>       tests/qtest: Delete previous boot file
>       tests/qtest: Free paths
>       tests/qtest: Free GThread
> 
>  include/hw/ppc/mac_dbdma.h           |  5 +++--
>  hw/core/cpu-common.c                 |  1 +
>  hw/ide/macio.c                       | 18 +++++++++++++-----
>  hw/isa/vt82c686.c                    |  7 ++++---
>  hw/misc/macio/mac_dbdma.c            | 10 +++++-----
>  hw/ppc/spapr_vof.c                   |  2 +-
>  hw/ppc/vof.c                         |  2 +-
>  hw/virtio/vhost-user-base.c          |  2 ++
>  migration/savevm.c                   |  2 ++
>  system/memory.c                      | 11 +++++++++--
>  tests/qtest/device-introspect-test.c |  7 +++----
>  tests/qtest/libqtest.c               |  3 +++
>  tests/qtest/migration-test.c         | 18 +++++++++++-------
>  tests/qtest/qos-test.c               | 16 ++++++++++++----
>  tests/qtest/vhost-user-test.c        |  6 +++---
>  15 files changed, 73 insertions(+), 37 deletions(-)
> ---
> base-commit: af799a2337c3e39994411f90631905d809a41da4
> change-id: 20240625-san-097afaf4f1c2
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


