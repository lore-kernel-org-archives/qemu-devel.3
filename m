Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFEDC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 01:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkCCA-0003mW-C7; Mon, 17 Feb 2025 20:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkCC8-0003mI-Nb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 20:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkCC7-00065k-AE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 20:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739841278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlUytGWMnvbmK4f4oX+kdzLnB9J92mhbar11srDT/3U=;
 b=Sw4+pVv/sQX8jJ4ASyWaBf7N+lV1No07O15THf7Rg2eBqQ7HEKtr/df/Mhd4XsNs1dM6PE
 z9NNBt1R1QgrGvjzOcBXbb9+vED5k1VLpxNUFY9ccaloiLGeo8bir51WDYYC5PnKad2fyh
 489/C4wkuzOBDhCBp0wGNjm06LyW4HI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-3nmzDNcDMo6qgiA-JYglew-1; Mon, 17 Feb 2025 20:14:36 -0500
X-MC-Unique: 3nmzDNcDMo6qgiA-JYglew-1
X-Mimecast-MFC-AGG-ID: 3nmzDNcDMo6qgiA-JYglew_1739841275
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05afdso9865353a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 17:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739841275; x=1740446075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlUytGWMnvbmK4f4oX+kdzLnB9J92mhbar11srDT/3U=;
 b=mOowM5eySbrsV/cN75Trg2Ggf5pizFRiSvrc82fnRj5uRV80sgoM0VI8lX1ort9eQJ
 1GTg+PvweXvRDDrw2WzR8XWolz0I0gSzBpSg9omaO73zCBIAZ4ywiPfzNS2Kj+QlUORA
 hQm1crOgNStFUq6wtvzqdeU0tZHW/WmNQUC9J6tEqAlkUnU0iWte3sGNOJvHl1h3BQBl
 C+KGAZl+ny/jVg/w8uSg+D9ZhndNyB6WnlDQoAgvOcb3r1nvGQCOoiumXC7JugLNEXb8
 slypnbu3HC1Svdy69LQWTkLUmKjFDYLzHcb+fvpE8BLtw4TNX0r4z2hqMFNbCnkiPb2s
 iBfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/4v+ff54+WmTEMemO/o1Kw4QKmMc3kOZx4cBzNPBJVwWEdP5RFEcJHXbA0ZNlyrusgGobBvHZcKUR@nongnu.org
X-Gm-Message-State: AOJu0YzY/X1ejxtLOtWAfD4uuf6XUz/Q9lmFBbaz5HEsEvuMOlcCAcTa
 Euv0YFn9Jx3HHpj4pA/iCy57pE6xma4d82iX2EPKi7whi7OyKBEVhQrC+cCBXBDR9IocwYDuPsJ
 YO2X5wJ74FS5sCfCGBNuwfkupNVAXexhDzAOfhIG9AIElRQtaV1iddfEudtBrIEAvxuXwk+szC7
 hdJS7qhVhb9zMWUesjtgtGFQnU/KU=
X-Gm-Gg: ASbGncuU4o8AK6ty/Vn3glHS1StqkF1uk9spX/UQG/mmhOT6hjPG29LRxT1C5kS2+BG
 SQ+xbJKjy4SGbQ3Ph0iT3NkP4uWD4trej0gqeJcnA3q2uKP6ZSR+2Cg8xPhxm30A=
X-Received: by 2002:a17:90b:3c0e:b0:2ee:c2df:5d30 with SMTP id
 98e67ed59e1d1-2fc41049570mr15485542a91.26.1739841275255; 
 Mon, 17 Feb 2025 17:14:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiOf2Fw9P6pkf1SuKJcyixE46bVqtkvZGZW0In01nKp516PcRq66GF1f3a8mU71OigpybJ7scu4tyQ9SzBwJc=
X-Received: by 2002:a17:90b:3c0e:b0:2ee:c2df:5d30 with SMTP id
 98e67ed59e1d1-2fc41049570mr15485519a91.26.1739841274953; Mon, 17 Feb 2025
 17:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20250217133746.6801-1-eric.auger@redhat.com>
 <20250217133746.6801-3-eric.auger@redhat.com>
In-Reply-To: <20250217133746.6801-3-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Feb 2025 09:14:23 +0800
X-Gm-Features: AWEUYZlemt7CdyCxs3gTTPsy35o4E62-eO8fjj4mFeDyR3v_ATbsmttI1QkZuZw
Message-ID: <CACGkMEst7Q5Zdu3AahgKaTnCh46b+-8f+wkFx0e3Apc+jSKRGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] hw/i386/intel-iommu: Migrate to 3-phase reset
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, mst@redhat.com, imammedo@redhat.com, 
 peterx@redhat.com, alex.williamson@redhat.com, clg@redhat.com, 
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 17, 2025 at 9:38=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> Currently the IOMMU may be reset before the devices
> it protects. For example this happens with virtio devices
> but also with VFIO devices. In this latter case this
> produces spurious translation faults on host.
>
> Let's use 3-phase reset mechanism and reset the IOMMU on
> exit phase after all DMA capable devices have been reset
> on 'enter' or 'hold' phase.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


