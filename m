Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E0FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WxF-0000PW-8S; Wed, 23 Apr 2025 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Wx3-0000Jj-4n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Wwx-0002Dt-9E
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745402603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yt4XnIaSVHhI+eFxGyBtC4Upz0I4jy4j58fjXpXHyw=;
 b=bTkz6zmFbo+ZEr0OHSAbUyd8cnxSKpXH2fos8USvBVjlxegO5qu3MdC/LbMwrsxGhbDHGS
 RMy9I6AJHHYTfSR4BR07gtWvHEQ+4X2kWpRqzQIls0X3bbFvbHeBskR82qE/sUE+GbAtbe
 fntPn5LDANNIrTjuOIlL3g+0yuRylyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-4x84djnmNHGEEHGa-OChhQ-1; Wed, 23 Apr 2025 06:03:22 -0400
X-MC-Unique: 4x84djnmNHGEEHGa-OChhQ-1
X-Mimecast-MFC-AGG-ID: 4x84djnmNHGEEHGa-OChhQ_1745402601
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so35455245e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402601; x=1746007401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yt4XnIaSVHhI+eFxGyBtC4Upz0I4jy4j58fjXpXHyw=;
 b=QfhtemIM9sbtaym8zI8BCm/UTKLbUQUI7KPQ4HwO/Zc8Te8HMWXqYdjwmY4Ty0jzWh
 ezz0eF3iLpNH446k/NLC3tajdcgyh55CPHGODPdiZ2PYHh6uSHuWFe4zDnatr0ix4XTM
 viWRqgs941JjqNg/XjVJ9yvuhoz/GON0+PzKDXbzPuI+AWjPgG2QDYA4Fx4J+W+sALSi
 /Hi+3hjIlWB6wJ0+TEAgI0loN+Tg0Az2/BYMP4a5k8JQkullopo7a7syiG7edBYFGAeU
 qB+XzTQNHCr591JpUjBjehZHkNR6Gsh5tLVxEI5FqPiPicAyh6tM32wsN8tx8ucbBfbE
 wz2g==
X-Gm-Message-State: AOJu0YwKadSwRgGSWPUDWJib939RYyiXRuQCV1KfcdPLEetloXJ6WKQd
 5ev5bxUSqbrTjcmvnoRT2m/6V3Q5Ww6Qx8sgEifZ7v4LwDLHP/0Pzuznf/iDYuCAcTrg6N+DhQZ
 Jn+O4RriA4u9NP+UrL09x7MDjM4DxY5ZOaxGmHxEX+hqRhWk7C0WQ
X-Gm-Gg: ASbGncs00ngsIXvsZGCm/O0ViTiaxjWb3KoqgHQygiWqdY391s7eNwVHh8XfsAegHbC
 wcvL49GCiPYLSdDEVT15LoysbUPcL4GzDErY7685kjugleBKRyBIikHCJQsjIe9DM+Etk6bEtvM
 u/qOvk2J3HQapZf1bwc6pfhIVYw+7/5WQ9wpFKY0NgG4M1w9SV8jLzT0wUAziXxOH2w+ht0WKLl
 lWocUvAZXwi8wVnPOu5lP7yyy7AsiRv/YIJhI62nLabH4LLlPjd8RY/I/gUZ8AOGScpDTN/rAfb
 DDlHdw==
X-Received: by 2002:a05:600c:1911:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-4406ac3a9f3mr154837485e9.29.1745402600811; 
 Wed, 23 Apr 2025 03:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8euMN/wVa9owSsB3+PoiIBM0iqkyb41jQRDW+a5zyolKau8WB9dkkB/xH4h/C7Y2IW+UCeg==
X-Received: by 2002:a05:600c:1911:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-4406ac3a9f3mr154836995e9.29.1745402600397; 
 Wed, 23 Apr 2025 03:03:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4c8fsm17856740f8f.89.2025.04.23.03.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 03:03:19 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:03:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>
Subject: Re: [PATCH v5 3/3] vhost-user: return failure if backend crash when
 live migration
Message-ID: <20250423060235-mutt-send-email-mst@kernel.org>
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
 <20250416024729.3289157-1-haoqian.he@smartx.com>
 <20250416024729.3289157-4-haoqian.he@smartx.com>
 <998122CC-C357-4499-831D-DC739E42A520@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998122CC-C357-4499-831D-DC739E42A520@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 23, 2025 at 02:45:42PM +0800, Haoqian He wrote:
> ...
> Gently ping. Looking forward to the review of these patches.

it's tagged for the next pull, but pls do not quote all
of patch just to add 1 line.
Thanks!


