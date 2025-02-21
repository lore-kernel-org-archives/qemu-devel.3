Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB6C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlN09-0003Ih-8v; Fri, 21 Feb 2025 01:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tlN06-0003IJ-Vl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tlN05-0006Ks-7G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740121143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELslCehLnAbnAKSYS5bWMePMx4/BMnIf4Kj9Pk8DjzA=;
 b=VuYlmQRmS3HC0T4sDNme/8EsYawacDzRrPIi2OrU/h65A0xFUP77cAN++HPzcVvbFLL8pE
 goB151bbVvX+48PTFQleeEBl0ziGI1KA+1WOif7M9wGjyCRK5aw45JPQxPWflxMhB4owHm
 IO3PCYWQtRQnPO5wM0tMZAA0gWjOwiQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-AYMYkocoNBixd3lUcXXRJg-1; Fri, 21 Feb 2025 01:57:41 -0500
X-MC-Unique: AYMYkocoNBixd3lUcXXRJg-1
X-Mimecast-MFC-AGG-ID: AYMYkocoNBixd3lUcXXRJg_1740121061
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2bcf138c13dso1582447fac.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 22:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740121061; x=1740725861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELslCehLnAbnAKSYS5bWMePMx4/BMnIf4Kj9Pk8DjzA=;
 b=BPayp3OknzbgYfCwnTXsCn9/xHysLLpibG8wyWimKZmuEdVBB32u7Y8Y0gQc2qhUL0
 1hu76Vz3ZDQnrdVstHbBdPVZ5os+yRW7aDKJW/2c++qJMKKxN3Fht/at9Si/kBavA1mH
 ARfTChDyBsHkDwAvPpcw4VqRY9cW46UWRqdsrpyp2r7Ey7+tiUmvgdHFtcvq240ybvfT
 OJwgrsgDGavaWgJ7FAGgZ9A5ugeQtTPHZ5pR20jDYdaH+sOLtra37GFLqFj+TNH6BqAx
 4KDRxqMR0kSINf6F5sHepobueTqtVr/lyq1DmKCcAa4cHD+GvSNAKq1W//EH/BLyhp2I
 Bm3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5iGPJ7vS5GbbTmztxO0J4tffRUKE9nMbqcT20+hnjduQInhQbAgM9B2j/p7eVdf7vobJnSbYR5qOV@nongnu.org
X-Gm-Message-State: AOJu0YxaNl/W5+Q61C2zEEHpqRv16wGgGqOLNxa2TT4e1aQfkCYwSofJ
 RNSDEaHmn9WaLBbBA7AsHx5nZhmjUvr0h01bBWh6Xp6SusV/qLCmYO03SEIh1rPtZvf4+U3y0q5
 J68RpbfymTZpxGFIzcOmUWwn4Tz6kcR4dhQN5DLcxwCNN9/deHc2MFPJxxzZrJHxmlysJ0vxJrs
 Xqzcvbn2AqCB2fXrHXnM6YDFk+Qdw=
X-Gm-Gg: ASbGnctalT/lWZ29TVfahLXNGm3c+bL5cHNHEXaiijQCsG+jzk0Bu6NM8l8LDmW808d
 ReD7iOuUzDGrs7LRHAE+/3d2I6YJMbh1VgvksvEi7L7VJmlUWdghikedG+6gP0yv9utMdYP3xXA
 ==
X-Received: by 2002:a05:6871:d104:b0:297:28ec:9b26 with SMTP id
 586e51a60fabf-2bd50fa5424mr1612972fac.33.1740121060954; 
 Thu, 20 Feb 2025 22:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzP8V4QIorETSanxvNwjTueJNXdFh48QKspWPgCR0w3qiUaPnOMtdsrgtHrwMZ66f+mj2rlqI9kYflCsDoC9M=
X-Received: by 2002:a05:6871:d104:b0:297:28ec:9b26 with SMTP id
 586e51a60fabf-2bd50fa5424mr1612966fac.33.1740121060684; Thu, 20 Feb 2025
 22:57:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <0797f637-e57a-4295-a04b-f33256e9f54f@redhat.com>
In-Reply-To: <0797f637-e57a-4295-a04b-f33256e9f54f@redhat.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Fri, 21 Feb 2025 14:57:27 +0800
X-Gm-Features: AWEUYZlL7sxHJ8-kI8zJIrohS6LGnqDdMb7-RJJEfgdio4haAfXwfi-KxK7EGwE
Message-ID: <CAGYh1E_kpQC4cyxF1n3iavLyGO9xw9KPe=ePoXiF=P8u3DpMsw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v4_00=2F33=5D_Multifd_=F0=9F=94=80_device_state_trans?=
 =?UTF-8?Q?fer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Let me share my performance report after applying the patches for the
information:

1. live mlx VF migration

outgoing migration:
+------------------+---------------+---------------+----------------+
| VF(s) number     | 1             | 2             | 4              |
+------------------+---------------+---------------+----------------+
| Memory bandwidth | 733.693 MiB/s | 556.565 MiB/s | 475.310 MiB/s  |
| Total downtime   | 227ms         | 358ms         | 460ms          |
+------------------+---------------+---------------+----------------+

incoming migration:
+------------------+---------------+---------------+----------------+
| VF(s) number     | 1             | 2             | 4              |
+------------------+---------------+---------------+----------------+
| Memory bandwidth | 738.758 MiB/s | 566.175 MiB/s | 458.936 MiB/s  |
| Total downtime   | 220ms         | 342ms         | 459ms          |
+------------------+---------------+---------------+----------------+


2. live mlx VF multifd migration

outgoing migration:
+------------------+---------------+----------------+
| VF(s) number     | 1             | 1              |
+------------------+---------------+----------------+
| Channel          | 4             | 6              |
| Memory bandwidth | 786.942 MiB/s | 848.362 MiB/s  |
| Total downtime   | 142ms         | 188ms          |
+------------------+---------------+----------------+

+------------------+----------------+---------------+----------------+
| VF(s) number     | 2              | 2             | 2              |
+------------------+----------------+---------------+----------------+
| Channel          | 4              | 6             | 8              |
| Memory bandwidth |  774.315 MiB/s | 831.938 MiB/s | 769.799 MiB/s  |
| Total downtime   | 160ms          | 178ms         | 156ms          |
+------------------+----------------+---------------+----------------+

+------------------+----------------+---------------+----------------+
| VF(s) number     | 4              | 4             | 4              |
+------------------+----------------+---------------+----------------+
| Channel          | 6              | 8             | 16             |
| Memory bandwidth |  715.210 MiB/s | 742.962 MiB/s | 747.188 MiB/s  |
| Total downtime   | 180ms          | 219ms         | 190ms          |
+------------------+----------------+---------------+----------------+

incoming migration:
+------------------+---------------+----------------+
| VF(s) number     | 1             | 1              |
+------------------+---------------+----------------+
| Channel          | 4             | 6              |
| Memory bandwidth | 807.958 MiB/s | 859.525 MiB/s  |
| Total downtime   | 150ms         | 177ms          |
+------------------+---------------+----------------+

+------------------+---------------+---------------+----------------+
| VF(s) number     | 2             | 2             | 2              |
+------------------+---------------+---------------+----------------+
| Channel          | 4             | 6             | 8              |
| Memory bandwidth | 768.104 MiB/s | 825.462 MiB/s | 791.582 MiB/s  |
| Total downtime   | 170ms         | 185ms         | 175ms          |
+------------------+---------------+---------------+----------------+

+------------------+---------------+---------------+----------------+
| VF(s) number     | 4             | 4             | 4              |
+------------------+---------------+---------------+----------------+
| Channel          | 6             | 8             | 16             |
| Memory bandwidth | 706.921 MiB/s | 750.706 MiB/s | 746.295 MiB/s  |
| Total downtime   | 174ms         | 193ms         | 191ms          |
+------------------+---------------+---------------+----------------+

Best Regards,
Yanghang Liu


On Mon, Feb 3, 2025 at 10:20=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello Maciej,
>
> > This patch set is targeting QEMU 10.0.
> >
> > What's not yet present is documentation update under docs/devel/migrati=
on
> > but I didn't want to delay posting the code any longer.
> > Such doc can still be merged later when the design is 100% finalized.
> The changes are quite complex, the design is not trivial, the benefits ar=
e
> not huge as far as we know. I'd rather have the doc update first please.
>
> Thanks,
>
> C.
>
>
>


