Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00C3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 02:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkUc-0001yR-Uh; Thu, 15 May 2025 22:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkUb-0001yG-UR
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkUa-0005lm-DX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747361286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/QCEWXo21fjBp1rZos98KJbzaZ6vykSmvS6GGLSCH+E=;
 b=dFSMoWcyvVCRddquT3PwVbFAv/VkrdqNEhk3d6gnAXmwleMk1Y9gAkHM1CGh6JrInfXZfl
 DCjMFfsq9uPgCgKv9tPCq2aUWXPrgQNL/XfOGK860Hu+lEl1eOllooqYlkGukj7Tc2SRz2
 99cjlsbPM+nd+HszYgA9Pmpc9+xxDSg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-DHocdTXhPZCASXdLd_v5zA-1; Thu, 15 May 2025 22:08:05 -0400
X-MC-Unique: DHocdTXhPZCASXdLd_v5zA-1
X-Mimecast-MFC-AGG-ID: DHocdTXhPZCASXdLd_v5zA_1747361284
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30c1a269a12so2582182a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 19:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747361284; x=1747966084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QCEWXo21fjBp1rZos98KJbzaZ6vykSmvS6GGLSCH+E=;
 b=qTjZjW58LFyOCw/KxF1C1PXwM/C//8RMVT+OoMcnbj/PB9WROIDEen656wioAa33Yn
 Ft9W3/sT3+vUnfgnefeifPaGm4KQmjMfGKYlb8kKeVXs88aXbHOtn3JPhYAMPmBzs+SD
 v6AMeoeAyaWWebbkiP9MsEP7okSX/Fe0sYtmxauPhngSwyKhuUvZsqFm0S231R1+knig
 ELy/FMYkOm9GSoDaU73HT7tx4joKQ5QgFFQIFadmTZhxJQDw7NKNgjTM20wCm7Ys5FdX
 DYm4gmeio1kfq/nx29Htd9c90kgnKQyvKyI+LCIDQJNw/xYkDG8drZv5b5KifuSTLFuA
 HSGQ==
X-Gm-Message-State: AOJu0YzgTB0r/eupFgxm+z/PuY0mH3OX3jDIdQgCHlWXBLP6pWMPaLFI
 sOgIoT7IaoHyxHhHukr6pWs8Edvk+qKG/4eu55lUjlRMyVRFXXpGVAvKS1P3fas3VvrvnJVvdIv
 qA9dKhJtmOjMjW5uIz8v4u/Dt0vFl9slolL2BNwF7/JAkNbHxt3RhshVtjpEV0KRcZ+Rs8OyUs1
 5zt7c2+yy4yX5vrsG6a4d1TSVCIcEoj7g=
X-Gm-Gg: ASbGncsIi2VVhYfcPD4utsIQqG2awfewn9DLx8Mh6Yl+0oC6raoBut/j4LHkWS3JJum
 hsV5d0Xkw4c2CzsiSqObjfBAsAgDR856/kTDVly21B6rAhLh0uM8+AsnswN57T47i8ZAi/w==
X-Received: by 2002:a17:90a:c88e:b0:30e:823f:ef27 with SMTP id
 98e67ed59e1d1-30e823ff07cmr1400080a91.33.1747361284027; 
 Thu, 15 May 2025 19:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe5rrttrpcBHqW/YX8Gcx+6eEQc0XsO6rmWZ7JUa2ana0rAfD9bvR6TgIL69AN2Ip70palSyU7nZMAAvmuQ3o=
X-Received: by 2002:a17:90a:c88e:b0:30e:823f:ef27 with SMTP id
 98e67ed59e1d1-30e823ff07cmr1400036a91.33.1747361283635; Thu, 15 May 2025
 19:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-7-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-7-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 10:07:51 +0800
X-Gm-Features: AX0GCFvHIY_DBRVhVB0hS8j3B9SvKSPDYtNF1sLAivGgOf0MWSQ5hdxmCF7lfD8
Message-ID: <CACGkMEvpRCF5=y+LPaYXqETaNq67aPdJbjyhBjJFaPiBrgJRDw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> As we are moving to keep the mapping through all the vdpa device life
> instead of resetting it at VirtIO reset, we need to move all its
> dependencies to the initialization too.  In particular devices with
> x-svq=3Don need a valid iova_tree from the beginning.
>
> Simplify the code also consolidating the two creation points: the first
> data vq in case of SVQ active and CVQ start in case only CVQ uses it.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


