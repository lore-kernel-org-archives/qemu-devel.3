Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2E4C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiF3g-0004Vf-Bn; Wed, 12 Feb 2025 10:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiF3W-0004Uz-QG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiF3V-0000j1-BA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739375620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOwYlbB6GAMJVGetCGIuzXmx5aCcD47e9WYNvS5uy3E=;
 b=O2OtbL7qPPwC8YLIB/O8Q46QX7rZED6rXOFgdkMr6sD+ADtc3Mrq1Ny2OxKOs/6FbpMPzk
 7opeGNCmr93/RyCPW8oKdJL9byHGwJvywJB5mgWqV38EsE5FqG5BjiI+hMvV+7snAef087
 GyaQuMtr+qLg5AF1qjM/XzmWaQYHazQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-PipdoQg0MiqS3xMpscvIrQ-1; Wed, 12 Feb 2025 10:53:38 -0500
X-MC-Unique: PipdoQg0MiqS3xMpscvIrQ-1
X-Mimecast-MFC-AGG-ID: PipdoQg0MiqS3xMpscvIrQ
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-21f7671a821so87961675ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375618; x=1739980418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOwYlbB6GAMJVGetCGIuzXmx5aCcD47e9WYNvS5uy3E=;
 b=Dx94yJxd7uz2pvrhhwOiFrxV9z/jpUSjFGXY7uQ+hX+dVfCVytfof79jZ3ZI13NfBt
 riyxODCaxSDhhpMQJe8uA0+ewHF4caHQ/iAvppkoHsu2FBLSf+tclsRN4jx2MuV1aKPJ
 JSoEv+UV1QV4LcSPI7PIuriD+cPbsCpz4Q83h4ZpBb8CYDk5SxLXgh8YlLBdMoomjQza
 5aj2LSejGijYI7dXO9S7nnYKXuumyUOv9KUpQ0L6gZyrsySMTkyoWMimPdzLEWJe1x51
 wtXGt4Tnk+YnpbkKzy/Zew0FqisLz5Wpcwd4lEo9QeESuTkrDSBLP78MK4RM91vHdj5O
 PhPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYOE2fRARpLScOAbTCtDf77CDD7DXueE0o35dQKgTc5+9zgeU8sG/d7ElYjguqHlc4Gs4ggtcU2pj@nongnu.org
X-Gm-Message-State: AOJu0Yw9hjLCYRXG7DZFGASzoMJgdEzB0B+DjTg5V+u+EN/eGEsX+uhL
 r4/Wh2xpVe37kuz8NIrooPhrHXQ8Z421kWfCxWH5v+2Najdvf1z5yy5r4ztpsQg5FnzVR8OmWnb
 ovmncRmx7f1OPPw4aqEgD3M1lU3wo6Tvuzz/MUytYrMRDoHYJA6YCo44ZY6tgYXWc9m19zRGt5U
 JZt9Bx1PZtB+c0/EsFkxN4ejnLSmM=
X-Gm-Gg: ASbGncs9Wxep6lpatkUyY9gC1YMEod7AMlfmX13rlKM8dKh1AFceN1efD//fcQMVsfK
 Wo/S4mhHREPbkdiKmLYtggtQdCLspiZ5r9d/dUFwhZPU6z4BWQUniFmfagaZw
X-Received: by 2002:a17:902:f541:b0:220:c94f:eb5f with SMTP id
 d9443c01a7336-220c94feddamr11166865ad.6.1739375617842; 
 Wed, 12 Feb 2025 07:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVlmuDZUWGIoJJIfYBqRz2Bebyzhh9j9jj+eRQBD9IYg2rP5I+EL7Ibxsmh7gSGJQuduccoRGmdMcIYmHOP1g=
X-Received: by 2002:a17:902:f541:b0:220:c94f:eb5f with SMTP id
 d9443c01a7336-220c94feddamr11166665ad.6.1739375617594; Wed, 12 Feb 2025
 07:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20250211162010.1478402-1-kshk@linux.ibm.com>
 <CAJaqyWd60RFTugxxu8NNYxHKTX3vEGZ-Za2Z=BLwVPYde8EgwA@mail.gmail.com>
 <8a5e0e25-4fda-45d9-9315-9649e8560f38@linux.ibm.com>
In-Reply-To: <8a5e0e25-4fda-45d9-9315-9649e8560f38@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 12 Feb 2025 16:53:00 +0100
X-Gm-Features: AWEUYZlTHLQawhk-Tx0x0UTX0pNgFjt3F4GX3R1yzwACeemC6jKdwdajPiTPRJk
Message-ID: <CAJaqyWeG9TC9sr6_j_9KK+ksJviUJKOr9vHzw_BzmBxCLaYepA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 12, 2025 at 4:37=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> On 2/12/2025 09:06, Eugenio Perez Martin wrote:
> >> -        i =3D cpu_to_le16(svq->desc_next[i]);
> >> +        i =3D le16_to_cpu(svq->desc_next[i]);
> >
> > Both svq->desc_next and "i" are in QEMU. We can skip the conversion
> > and assign directly.
>
> Are you saying that desc_next[] should be in "CPU" and not LE format?
>
> The original code contained statements (below) that led me to think that
> desc_next[] was designed to be LE...
>
> vhost_svq_last_desc_of_chain()
>          i =3D le16_to_cpu(svq->desc_next[i]);
>
> vhost_svq_start()
>          svq->desc_next[i] =3D cpu_to_le16(i + 1);
>

Yes, I did a mess with the endianness back then :(. But we can remove
both conversions, and add the conversion at
vhost_svq_vring_write_descs instead.


