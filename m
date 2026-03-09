Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1971AEF371E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQi-0003PN-Ld; Mon, 09 Mar 2026 04:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQg-0003IM-MO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQf-0001V9-BH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bt47/giixM9dIYibE5I6L07F1d4t8Tb1EF6lyqgAIUY=;
 b=L5GpbHX5kBbsJ1HiaHcvsSKE+tl2S3yR8MiIJZa9o9EQj+XGWg7NW4h4m0JJd+iHJkeSW/
 Av147GJ4UCRd3E2iuJd8QQHprkmnvj7K4IfiqMzZ7kjYoKvwqGQLDiYNjDM2NqG7asjONL
 vo1C1pfa9kNPFcynhSu6dO1eJb2xwEY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-O1e_Uv13OsmQabB1KWjDdw-1; Mon, 09 Mar 2026 04:57:31 -0400
X-MC-Unique: O1e_Uv13OsmQabB1KWjDdw-1
X-Mimecast-MFC-AGG-ID: O1e_Uv13OsmQabB1KWjDdw_1773046650
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8297d2c1e64so1493304b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046650; cv=none;
 d=google.com; s=arc-20240605;
 b=OFOQcwg1AMqNKMVbYOnNvjch+qp/Paq0m1c9IIhd64jTouQxjuCX9GJmoia/VACNCp
 ulMHvp00nwHs6aFSfpFclwShevux4btyfosgL9o0k2Od982bYJ/H0H/KDWsc7MDzSOhP
 WgT/nyov+DLshWT2AOOijZeAeHMbO2jp+qzIXXLVMy2hD/UiHEq3B0Z9KGQrq56BfFs1
 b6JKpW+BMeoqoBPTKe7QJ4zdpWBjli/XjEhB52kkSZQZJ+mymTuyyW3/KwwgWwlejufK
 NvVfZKid2aCPbuuWbSDpGYaPx53GuiPVLfohsfbvc+kJKBHsaLW/D1UXl3IqraOHpBUw
 XQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bt47/giixM9dIYibE5I6L07F1d4t8Tb1EF6lyqgAIUY=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=IXlXDw3F1juFZu1aTAjLWnFtYAGFsHKcvUdryXrBErxwz6l9l5ENaSK5BqVJj7wj13
 kyx/2TxJdDXa7oYt6BOOCtM7gwrKt/SNhbXDNhGxJV5QMh3Fi/PA3BXelxr+2HjYVt+v
 wrfHNV9JeBzd7HvpvR60LwtQjGwOd8AjnHohT6KiIB0CVzS1ZlvT7/gRBv/HPPFTO/nR
 bZlZ+VWT3ZYwQtRC6Jk7f1MK+kCxzQNdynCuDWgec7YV1DjDZCyaTlfj1+mPE8a8P1Dd
 M2KrDEvDbFhu91730hve1/Xdvf4z60u3fAyv6IFJhVKNx35EP/51pvBuC00g1nizNmMH
 flPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046650; x=1773651450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt47/giixM9dIYibE5I6L07F1d4t8Tb1EF6lyqgAIUY=;
 b=pa40CsL+keFrazWXhj7/DFOxyzEiczThTImfkSpuhJRkiE9m+7wbi7y6aP39Ms7krL
 TS3QpmRe0lxfLfUfMSGjMp7oOWMh51OltflfIs4hioZ4xSLI2brfDoDRkGRgzfEkCsqx
 zlaOF1ppQRTJpczm/JlTxM4Nsdh7lBJrOAwIUfhYLsZ+i/b4tRGxeyVGlTn5JMjFaL2S
 DEgMl3h3rajKHahHt51lHNh5pXQCDM3IEBDWKK75p9muYonguEkdFbIRhUynIjSn16Kr
 shofY+Gz+2wvlytEr6O2xEGnFnOtngIdyzPVNdi63z6QYNDGGPQ/VPMIbf3zsxTNkrtv
 5tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046650; x=1773651450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt47/giixM9dIYibE5I6L07F1d4t8Tb1EF6lyqgAIUY=;
 b=GoYJFDuMcYL0VCY/jFsFZqvI4vfCFZPZ2ErlsHQD1pMKyOmnWRA2igz/A8ovr4yWga
 mP9wWGEc6rsK5pI3SifJpGhqiTsgeWg80FJ+yXAEGEy3OQjFHmjzouf8hzomhWrEAmO+
 cK30FhoJxE8uXFjOb8TTwrIusFyyWJkN1xl73CpW5cY0j0V1NqmeK8XkgGJ3OshX+t2Z
 lFvuD6ZKAgP9mDAVTMLppFB/Y206olUqiH1LW1G2b6xODYP6mCgZEDbAslukvo45jhpl
 BBj0s85kl+AZsRZuvJS8Qy6377JdhZ6Xm2TWf8AEM46YoVE2G++xH5EW2UhWy0NpbAdH
 ocDQ==
X-Gm-Message-State: AOJu0YyC/PUArt0CqegpN/L/hucHUx8poFYzLzm7oVTS8yFRM3lAmpi3
 Hre4pK9GkAzQXOZqrgO1n9AIicRTcpdmDnq1WTuOp77MWdxXS5LlbL06MxFoKVLCfBVA6vqVKTG
 e9GFcy1jx162REUKDthH11IpDqMe8voj5BwOLRp8MxUfj+0Y/n6wCvCikH21S0yO6DVv+GE+HHP
 YB5U8qAOgaTaYmFPj2unXnz2r+zEn8Tyo=
X-Gm-Gg: ATEYQzy/q1adQ5CPgRjxVmEtwSfQvEpHZ6hqMkpK/qyfIa7e/ddXcd3m84si4LXvBxP
 7r6TV2tlXYNP/Zp4YpeSZ9OLcez+nuMNgw2DTeIT2ufcqM2Z69Ufn3fmuRhS62U6IQrBKp3pHzW
 M2NyebggcTPXKo/A/T8LIzkTrRnu5i13Eq3qaA15QHXBhKHXlftzt0GIrnUWvrUiefoJHW5xBug
 IHL+YaC
X-Received: by 2002:a05:6a00:1ac7:b0:7f7:2f82:9904 with SMTP id
 d2e1a72fcca58-829a2d6e627mr8925836b3a.5.1773046650399; 
 Mon, 09 Mar 2026 01:57:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ac7:b0:7f7:2f82:9904 with SMTP id
 d2e1a72fcca58-829a2d6e627mr8925818b3a.5.1773046650037; Mon, 09 Mar 2026
 01:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-7-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:57:16 +0800
X-Gm-Features: AaiRm52yjkWes1J5Vv6Ej5Ld22eH83EDEd7E9-3IFQALsaWQPevYdiZ_aZ0wflE
Message-ID: <CACGkMEvbub-mn5CyYMrHPR07CA0bQxQOb4-yOZmGk7d6d6m=9A@mail.gmail.com>
Subject: Re: [PATCH 6/7] vhost: add in_order feature to shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Some vdpa devices benefit from the in order feature.  Add support to SVQ
> so QEMU can migrate these.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


