Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF05C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WyD-00022l-RE; Wed, 23 Apr 2025 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7WyA-00021o-BO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Wy8-0002MX-Fe
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745402679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfJ8ee1JcGaW26GYypXXmBRYQFwhYmKpVjA9hXGr90A=;
 b=gfqEg3n8z+5PVoWUJA5A/Us1nuZfaJZO7GushP9UEpKg29dgvv8eLaISy3tQc06VmJO6uh
 pp80oURY6uf5YkM+3qYrLUX6c/XPUpSodYruQtKpJfX1H5BrwjxC4Fveth1oLUS5WkpXli
 3rdQGkN5Fg/MeT9NQnEEmRmYy4XN6vY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-6JL4EWxWMj2hoERQCYO8ZA-1; Wed, 23 Apr 2025 06:04:38 -0400
X-MC-Unique: 6JL4EWxWMj2hoERQCYO8ZA-1
X-Mimecast-MFC-AGG-ID: 6JL4EWxWMj2hoERQCYO8ZA_1745402677
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so33573035e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402677; x=1746007477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfJ8ee1JcGaW26GYypXXmBRYQFwhYmKpVjA9hXGr90A=;
 b=oj5Vf2Gg7K17+/w5wu0KcI6ZXN6mAb/lP8eesWHx+j5P3Ku6f+yWMi/FBA/+p3NHem
 bzgsTdbCBG9TvdnAaJawxZHgavYOrOqxRX2uCtMptlsaD/98fkhX+/1TdKYIbyyLPl6D
 ppLcei85Io2JXxYfJ3cyStXKimC+hfrxUQnIbhorpY5lSr7trAeOZwNWYabH6J2T8XhO
 q5kY6Cj7PZHvr1kRpGYJPCSWsNgPzQfIoLJHtRTfUaeLII4YdqJZzNNZpa9OYUms0zBe
 MN4Bu4Y+A3Z98daWjQIlzgSd4CpAFGxe3l65LY6bVSAilOxJnvmfSqfh+5ZF1OMSDpFB
 gunA==
X-Gm-Message-State: AOJu0Yw+C8Me6TRCdQRGMJiCO87HTrVZsDbF3BWcbO7Bzi97bcSIp9cv
 mGbJr11LGyIrefZs9SeQtzzW4OVLXzQrBiGXusY/yqjjszdLZb06PfwMT2wovEY0O+1biDLxZuv
 fojvc+TTV/fF+uFKeSUBj8JzS8NGPUAEvH6hxW67Cc0ykb3UEwWyv
X-Gm-Gg: ASbGncv96eas44ok6X2ke+wPyKFeMnRwIQsN3CZJ9cI3CIGolHrE172p9ScUyyxEKX4
 8aVB97B2Wbcka2IRaCJJnFtdHaXQdZyhftXR09y2H6DObZ/HnYYtWEpmeywvH0Kwht8s0wIFLkN
 pojbt3ICb3T9o95tM3zhCtFRucgNcW84mbCbHu+/YQFm67yZw5CnpBoxchofCYLU1cLoZ55iyiT
 vbes6j7TQ8zCxgC2QHqiS2lWQnylqFJZWbFElZUo9FIQE6BSngghG3L3Sb0lfSjAFmcL6ma28Ep
 K5zSvQ==
X-Received: by 2002:a05:600c:4ecc:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-4406ac0aec8mr135507025e9.22.1745402677001; 
 Wed, 23 Apr 2025 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIFXjqe3M7fS9Zn7zaRr2MREQb058bSeQBbesrewGJ1D94yTO2P2NnnEVqH/uN+77wlnvJkg==
X-Received: by 2002:a05:600c:4ecc:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-4406ac0aec8mr135506745e9.22.1745402676670; 
 Wed, 23 Apr 2025 03:04:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092dbe7e1sm19787025e9.33.2025.04.23.03.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 03:04:36 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:04:32 -0400
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
Message-ID: <20250423060336-mutt-send-email-mst@kernel.org>
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
 <20250416024729.3289157-1-haoqian.he@smartx.com>
 <20250416024729.3289157-4-haoqian.he@smartx.com>
 <998122CC-C357-4499-831D-DC739E42A520@smartx.com>
 <20250423060235-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423060235-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On Wed, Apr 23, 2025 at 06:03:20AM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 23, 2025 at 02:45:42PM +0800, Haoqian He wrote:
> > ...
> > Gently ping. Looking forward to the review of these patches.
> 
> it's tagged for the next pull, but pls do not quote all
> of patch just to add 1 line.
> Thanks!

Also pls do not send v5 as a reply to v4,
as otherwise it looks like a part of
a discussion.


