Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3B5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gtG-0005EX-8K; Tue, 14 Oct 2025 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v8gtC-0005CI-BA
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v8gt9-0007Gp-N4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760455472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqTvXFgRLqO0gcnAKTGgbgM5jP/HgGbcGS3pZwnb52Y=;
 b=DswRqYx+BP+Y9vm0igY1IRlH/6hcyG1zpuwmJql2Vjkg2NnTf6xQNuFAeTGPi1YHwAeGT1
 32ETfyJWa+jxxUMBWij3fn9GSXYZA0pfXPT577wUU2F+mehcB/O+xMMiXaoVMdlqfSZZKP
 z6GjYtX0ln76pJzQmUCSk6yWX069zBk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Mwo2ipc9NQKSUBxRwKqUYg-1; Tue, 14 Oct 2025 11:24:31 -0400
X-MC-Unique: Mwo2ipc9NQKSUBxRwKqUYg-1
X-Mimecast-MFC-AGG-ID: Mwo2ipc9NQKSUBxRwKqUYg_1760455470
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-4272d0bebf0so13004525ab.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760455470; x=1761060270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqTvXFgRLqO0gcnAKTGgbgM5jP/HgGbcGS3pZwnb52Y=;
 b=gHsGstEyrUz4Coi+qxtu1U/D19tMIKG/MEufSG7+GCo7G/r3QAvT42L4RyuwH8hhBQ
 mz8DJi5oIsxHpusuu1gNgdNr944Q/Wp+SSZrYZLroCeJpHS5Nye1rFJMD4dyE1vxTmvj
 jqfcNXwO+aW/IxRk0JMq8LoR5BcaMfq1UAefo8UCldBpLl0JDIzVaTf6esYhqqJ9LeeU
 8guyzpWUi+2Wl/zRsm0I3GyOkgaL+JkQNafhfoFc9k8virU1nYlJSzGCwbMqBLFziO7M
 U/SW8pNcAhJqyi1L/5etFDSCPjmrRRS4lgzJRqdumUNZsJtHDuCTIsNQLIKXWX4x7kaC
 QrSQ==
X-Gm-Message-State: AOJu0Yzag+sIGre/mYrCJEOFOApSinx3AYXwS9rjIrSlE97Zophk4NH4
 BqQVpEmNBKg/2Su4GBN+vNtHTYVEfSGFW4KyWF8wuOjw7WItHYIRiJ2NuoR0fUPdBluM1oXmTC1
 GUMjtRA5hzfgeZWIcNPO3xHkiGQTzjQD6r3xK0FrZ6RPE0N6Z/cyKDnOC
X-Gm-Gg: ASbGncutLm7YeE4z2REQWFn9SERTBF29gkFESlP9KfbxaNTwToVdH1YbydaRcbKtvlw
 zWLegj4XlWvAjqLnTOWkYYKLgTTufQs5gz/2P8/6MB3+RHo1g1ZPCPg7IjD22vfre9P3/cT9L+A
 qwDMPevCG4yG2AZr/dfPQOAos9Z8gg26BhwULnrC/dEH2esp4wcf7UGjH0Q9Gkg7JzihkJTO5Ib
 aQxHElHswh1VuuDOrdO77fhd2cK9yl9SaoWlhwM2PJy3BU04JmyZqTDD0lPcrAkWK9QZIXoxaHq
 dZpCIMbjMm/LQWtlvMj+oILq/otFlOgZhHJBc6OkVBw=
X-Received: by 2002:a05:6e02:12e2:b0:430:a38c:b74e with SMTP id
 e9e14a558f8ab-430a38cd067mr11853355ab.3.1760455470353; 
 Tue, 14 Oct 2025 08:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX1dsQxf8Dqc85ZWyQ6h2vq8ktT2LZp51Qf35pMDfm/aBeLIQYpdKTTdnTfmJZLgyn3KMKzw==
X-Received: by 2002:a05:6e02:12e2:b0:430:a38c:b74e with SMTP id
 e9e14a558f8ab-430a38cd067mr11853175ab.3.1760455469874; 
 Tue, 14 Oct 2025 08:24:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-58f6d0455afsm4829820173.23.2025.10.14.08.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 08:24:29 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:24:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Thanos Makatos <thanos.makatos@nutanix.com>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, qemu-stable@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH 0/2] Fixes for vfio region cache
Message-ID: <20251014092427.2b246db1.alex.williamson@redhat.com>
In-Reply-To: <20251014151227.2298892-1-john.levon@nutanix.com>
References: <20251014151227.2298892-1-john.levon@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 14 Oct 2025 17:12:25 +0200
John Levon <john.levon@nutanix.com> wrote:

> John Levon (2):
>   vfio: rename field to "num_initial_regions"
>   vfio: only check region info cache for initial regions
> 
>  include/hw/vfio/vfio-device.h |  2 +-
>  hw/vfio-user/device.c         |  2 +-
>  hw/vfio/ccw.c                 |  4 ++--
>  hw/vfio/device.c              | 39 ++++++++++++++++++++++-------------
>  hw/vfio/iommufd.c             |  3 ++-
>  hw/vfio/pci.c                 |  4 ++--
>  6 files changed, 33 insertions(+), 21 deletions(-)
> 

Reviewed-by: Alex Williamson <alex@shazbot.org>


