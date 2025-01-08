Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE34E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVbB3-0008Rb-Cx; Wed, 08 Jan 2025 13:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVbB1-0008R4-JT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVbAz-0007zO-GF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736362387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0W+EX8OAzYP5h1kHBTcwzmHaExVkDf5UvTU+/dFDzSA=;
 b=ZDn48mKufx56byYSQ1RziCRWnHHJ+XpvKvkrsHV31CfsMM5jC5CQrS7nvEOeyNRKMsV84q
 u1+ZxDVA4wUFOZQRVUkO6mqj2Zzt9JJYnPaKRBtxLwjXaJDe6IkkfKn9P9T4I/JNnXXIjM
 TzNfzxGC+FY0hVFhyomiCVwS8wlKOrI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556--IJLXprGNq6rU77WadfAPw-1; Wed, 08 Jan 2025 13:53:06 -0500
X-MC-Unique: -IJLXprGNq6rU77WadfAPw-1
X-Mimecast-MFC-AGG-ID: -IJLXprGNq6rU77WadfAPw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa691c09772so13137566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736362385; x=1736967185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0W+EX8OAzYP5h1kHBTcwzmHaExVkDf5UvTU+/dFDzSA=;
 b=RvyEJjRa79yQ/CTGpFXPI9i3uKh/KKFScx71mS/VSgTCNSm6OUmtFcV/fjZIn/NEJX
 HzrfGS6T7WRBqnB3SKkPOrDodBvPYUn5OJ2IWVQleykRWAoLo6sPYdKcRvcyA5JjbmHL
 qP52ASbafsn1E6d2keGdLNTkqep4X4gRXuglNE9EsLTqy0CXmIW936iTVpwz9XMbSrXt
 opziBrw6Ouz2dU6BmZleJ6EWLd6xEf0bkBWvOiDDffk1igWIyqmQer0Ei6EXRV/bD/R1
 GvwOrqJb7mxjkSNU3ZYBpnarF0iLYohOGU8qB1gojGZYDbV93CuIHSWRuN3I4MKmrwcf
 cCUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo73ra3/RynOzmtUF70ct1FR+DcxYrbjgmW9GZ6jexUrLFRUieIk6g9K85qa1UuZO4g666UNHztBKe@nongnu.org
X-Gm-Message-State: AOJu0YxFu9eOIX2zZqtllqBQti/uDt//yYDD/Iora599Rakp+0vWIv09
 jAFiqHF+/Fu3516/vjFsImFetn+HDJkWNaSQ9S/oHdlZ98crkC5k4eZxC/YYbkWkNmTtYah+vSW
 OFMPV63vHTuH5U7T1LXA1PsrOL9JwTjiUvgxYW1fFpcbfqhjYKUGr
X-Gm-Gg: ASbGncuxV+oejkCdYhSI1FzFBfVSBdjgHB2HwkAiKwmlBqE+mJBUSmnVBZ4NbPgN1Lr
 Ey0tf2hhkE93Ngjz7HJUVIMvDAXNtSOvkScWVYZgEQdpZF4djak5OwpqW7FU9T+5cCDwf102r3i
 S04b5T6DilmHOrDMqB6x3gJ5PPQX97h2wxFrvkz196Zo6uR05la/VmfbWIgTyKu9KY8BU3X+O1m
 WI/LlQUbIFXku3qKN5xTeHrAiVkHor1+4RuN3PVwBpMWKvN9TQ=
X-Received: by 2002:a17:907:1a4b:b0:ab2:b4bc:41ef with SMTP id
 a640c23a62f3a-ab2b4bc50c3mr212496666b.29.1736362385179; 
 Wed, 08 Jan 2025 10:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5YK4cYZ5axzFKK0C987utxG37OE1APcCssi6KidFu1JgP3hogEMRpgNyhrRu2M/201ufmdw==
X-Received: by 2002:a17:907:1a4b:b0:ab2:b4bc:41ef with SMTP id
 a640c23a62f3a-ab2b4bc50c3mr212494266b.29.1736362384801; 
 Wed, 08 Jan 2025 10:53:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f015b3csm2510531566b.161.2025.01.08.10.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:53:03 -0800 (PST)
Date: Wed, 8 Jan 2025 13:53:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio: Convert feature properties to OnOffAuto
Message-ID: <20250108135204-mutt-send-email-mst@kernel.org>
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sat, Jan 04, 2025 at 04:36:04PM +0900, Akihiko Odaki wrote:
> This series was spun off from:
> "[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
> (https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)
> 
> Some features are not always available with vhost. Legacy features are
> not available with vp_vdpa in particular. virtio devices used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
> 
> QEMU already has OnOffAuto type, which includes the "auto" value to let
> it automatically decide the effective value. Convert feature properties
> to OnOffAuto and set them "auto" by default to utilize it. This allows
> QEMU to report an error if they are set "on" and the corresponding
> features are not available.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com
> 
> Changes in v2:
> - Expanded the message of patch "qdev-properties: Accept bool for
>   OnOffAuto".
> - Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com


Markus I think you had feedback on previous versions of this?

> ---
> Akihiko Odaki (3):
>       qdev-properties: Accept bool for OnOffAuto
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       virtio: Convert feature properties to OnOffAuto
> 
>  include/hw/qdev-properties.h | 18 ++++++++++
>  include/hw/virtio/virtio.h   | 38 +++++++++++---------
>  hw/core/machine.c            |  4 ++-
>  hw/core/qdev-properties.c    | 83 ++++++++++++++++++++++++++++++++++++++++++--
>  hw/virtio/virtio-bus.c       | 14 ++++++--
>  hw/virtio/virtio.c           |  4 ++-
>  6 files changed, 138 insertions(+), 23 deletions(-)
> ---
> base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
> change-id: 20241013-virtio-164ea3f295c3
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


