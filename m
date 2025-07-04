Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A951BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdgL-0004Jl-30; Fri, 04 Jul 2025 06:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uXdgE-0004Dq-A2
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uXdgC-0001KO-6u
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751625003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2h2rAV017uEKqWEIGcSEbzOinhT5LzoN/6/oyd9KrLw=;
 b=AqYlanxkwlailJJWu9V5yQVTFyYJ7ALXCo05MloNpAsrp8KExfHMTBTKf1VRCBVGNBNAkh
 FtcjWzeQbZ+5LhyIUbmv8QrsCikIxgQORXa9D2NKvooPznO2jxHcZNDX5nqLwWnscEgnoN
 t2p4aMSCOLEpUxZCmW5PLrjGuTmRuDs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-h4jQEPOlPUenrTmjRirKlA-1; Fri, 04 Jul 2025 06:30:02 -0400
X-MC-Unique: h4jQEPOlPUenrTmjRirKlA-1
X-Mimecast-MFC-AGG-ID: h4jQEPOlPUenrTmjRirKlA_1751625001
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae0d798398bso61924466b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751625001; x=1752229801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h2rAV017uEKqWEIGcSEbzOinhT5LzoN/6/oyd9KrLw=;
 b=C+NwLEKoFq7yhOQUiMHkEqpBHW5nFtsW0wqu/tY2phqOvP9+YwSjf69agiZm/d4zoQ
 8KJS3kBPpm/XnE9M+e0xVnJrode7FDY5IA0ofeaGkBE97AQ/vO4elnCTyLwPOXUSx52+
 Wk3rCc4ClrOakSP1dSXmJCUpVmJ8HTi/FB7XqbXMQkaf3N6S7egoc4L6t5BC0i/Ws3KX
 A+cw6n3Cgcc7SAKH+mVr/aHnXx9q13vAWI3n4k0HFqma/lZwRPjigDf0TQY2wIWAVXFU
 jt7NSTc7Zb1M2oejR/FwHnsynJ9gQawvM7vTlFSBZPf9vB7/8VsaXsWnY6tGcKrPkWfH
 eTHA==
X-Gm-Message-State: AOJu0Yx5b+xWMq4Wbexuw5N8jqsEBmgAMIpgCXTchoFvBFL3itumYD18
 0lI2ETAjHNRi4yRcpf+t+hbpt5lhupRQLvgaN+tC2kQ91o6+9E5S+tivhdMrpf/6dGeMHHYWZOh
 KbA4Mp3vEkolUKshKPT9YrWTS/xYhio4GxgXXvialbJ+y62LD/ODVKaeqdHpQ46Y/V+3n6wQDoY
 8s9N8uS2b7yuxARY39OxIKjagbHLFdmBw=
X-Gm-Gg: ASbGncvWbtFLBAjDRXEVHvVJH1hECiw0LpRbwWzMwFEHjycyLQAfZUFg8A5pUd40SSK
 xVycvpV7rzJZ40xGvDuxr5stEDl0Z8X4DexPMqYql5QKT3aV8VqD7abjAv7W1FJhPz/fxunqb4b
 q0qDXl
X-Received: by 2002:a17:907:3f96:b0:ae3:b9c3:ddd7 with SMTP id
 a640c23a62f3a-ae3fbdc86a3mr165202466b.45.1751625000905; 
 Fri, 04 Jul 2025 03:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHta5ypLs4t4rs0EItZBL3DFgjfStplR4KXTFdWjgzcSFc+RLOxWKHv1bFE15eBglV1UvKrJIAjHDXArDkwi4I=
X-Received: by 2002:a17:907:3f96:b0:ae3:b9c3:ddd7 with SMTP id
 a640c23a62f3a-ae3fbdc86a3mr165201466b.45.1751625000431; Fri, 04 Jul 2025
 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 18:29:22 +0800
X-Gm-Features: Ac12FXzw-KdP2Whb5x0-nZw-6voxt9smofl__PW8D92R908sM7z5SYzq706oUQA
Message-ID: <CAPpAL=wLSfYSBed4ZOPJBHv+O7B9HkGUsA78WbhG_seDFYmhSw@mail.gmail.com>
Subject: Re: [PATCH 0/4] vhost: drop backend_features
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, mst@redhat.com, qemu-block@nongnu.org, 
 fam@euphon.net, pbonzini@redhat.com, jasowang@redhat.com, hreitz@redhat.com, 
 kwolf@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I tested this series of patches with virtio-net regression tests which
were triggered because the virtio-net code was changed. Everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 3, 2025 at 8:55=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.
>
> Vladimir Sementsov-Ogievskiy (4):
>   vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>   vhost-user: stop use backend_features
>   vhost_net: stop use backend_features
>   hw/vhost: finally drop vhost_dev.backend_features field
>
>  hw/block/vhost-user-blk.c         |  1 -
>  hw/net/vhost_net.c                | 14 ++++++--------
>  hw/scsi/vhost-scsi.c              |  1 -
>  hw/scsi/vhost-user-scsi.c         |  1 -
>  hw/virtio/vdpa-dev.c              |  1 -
>  hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
>  hw/virtio/vhost.c                 | 15 ++++++---------
>  hw/virtio/virtio-qmp.c            |  2 --
>  include/hw/virtio/vhost-backend.h |  2 ++
>  include/hw/virtio/vhost.h         |  7 -------
>  10 files changed, 30 insertions(+), 39 deletions(-)
>
> --
> 2.48.1
>
>


