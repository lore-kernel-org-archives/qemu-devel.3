Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B92BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hx0-0000PW-JN; Fri, 25 Apr 2025 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u8Hwt-0000Oi-O6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u8Hwq-0002t7-Oh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745583265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Gq+XRXKG0mSGSHDo06D3pNseANK9eEXWD/mD4CBFKI=;
 b=dgpbtn9D+X2oqiiw2eXYP+8hRHDQ/b2+XLHqYn+oJc0oqgEnwv9fkTtSzAfNcsyof+vSqI
 7S6bE4M2Uq1P6S2kLPMpC0zs4vtPvn+HgyS2SZ/inggWJpEn/xwfRLS10FslxAF2VWH7Vo
 wqOp9jiu9ayuih3SqxJw5yTPcPuQPI0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-4jDYWUxiOGSp7Aspn42aoQ-1; Fri, 25 Apr 2025 08:14:22 -0400
X-MC-Unique: 4jDYWUxiOGSp7Aspn42aoQ-1
X-Mimecast-MFC-AGG-ID: 4jDYWUxiOGSp7Aspn42aoQ_1745583259
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso13474965e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745583259; x=1746188059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Gq+XRXKG0mSGSHDo06D3pNseANK9eEXWD/mD4CBFKI=;
 b=Q1+Tx7jIY8B+8KZPWUKoAEBwgfTtAaT3ooXZhgVVEmOrWA8s/q8PSLW+g+GiZT0jJh
 qNDJNfX6HM/nuKxu9LOS+YP8X7Nx9LC2uUZoyXRkYbWgY4Epnl3F226ZS7f0TMr2BH4R
 PMGImm9AWkyy4giqY1n45Z3OcLsQ04R7yDkModcBY7ADO/vhHanYKV56PQZfo7LSaFsM
 dh4XwXVsJVU0wAPmCpnDW0g66qjFyuJqAEMOlJGC2ECXZdvEEIITfBxCkPdGGYuvoB9Q
 lqzkyFT2m15IoMvucvMeXneT4+BokbdhS16h8p2zt0vXavTjFV/9kWOrr6l2BSWAOwCZ
 TuYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDwxZtz9SjnjXCsRq2/pCV5C+9Wz+kDAxHUTzqaVfyeN0kEJPxVF3fpscE9ctz5WXFxxn6YNFdp1+K@nongnu.org
X-Gm-Message-State: AOJu0YxcpCPZicazWIH9imFt7NIvUJGvHUjgGT7OEsYvY/nqJfsikb2K
 iCHT/368cRHApOqqZkRZ+7Ka2Lvvp2Pj70yqtx5+MQyAKwlHg0/+u9+QqXSN8lRke8qe7VqDeKA
 L1eNhMENAZ7XkNK/MeEvm+W1MPUrovhSL+Pubq/PcHGz6iJsFKQZj
X-Gm-Gg: ASbGncsejoV/9lV6nkejsYQgbZR3If4nXUTZ2q9pqwUSEm71pEdj1Ybs9Yrc48iiZMt
 s2M6GHwLXoyEexTGQlwqPC6xyZxV7oBv+sd4djrhkQjDiNX1nWqOkFM2JgghPMnVnJBX9oPtkBd
 AHQuYr9TwTvG0asI0WCv75QIYN0hcZPiyFSPRAyaiyU19RURkg7vZGMfbaz/rcGzHQbvu+XiIGO
 A26icFnvOGZLfXvygcLt6BSNFpVmvJ2l5XS0o9/jF44WMKVoz5E06h7E5Y0S2P78hprLZa/Ix99
 E5zG5w==
X-Received: by 2002:a05:600c:a363:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-440a66aaf09mr15616515e9.25.1745583258619; 
 Fri, 25 Apr 2025 05:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGamraqT4BG1auF/LLUJGTgUgTrFwoU6UGMxf4wb6GidhWh/G0Ba+LP34id+zAihqefGC4vaA==
X-Received: by 2002:a05:600c:a363:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-440a66aaf09mr15616105e9.25.1745583258220; 
 Fri, 25 Apr 2025 05:14:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b9c4sm57950075e9.3.2025.04.25.05.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 05:14:17 -0700 (PDT)
Date: Fri, 25 Apr 2025 08:14:13 -0400
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
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v6 0/4] virtio: Convert feature properties to OnOffAuto
Message-ID: <20250425081234-mutt-send-email-mst@kernel.org>
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

On Thu, Mar 06, 2025 at 03:16:26PM +0900, Akihiko Odaki wrote:
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


Marcus, Paolo, Daniel, Eduardo, any feedback on the QOM bits?

> ---
> Changes in v6:
> - Rebased.
> - Link to v5: https://lore.kernel.org/qemu-devel/20250208-virtio-v5-0-4376cb218c0f@daynix.com
> 
> Changes in v5:
> - Covered QAPI more than just qdev.
> - Expanded the description of patch
>   "qapi: Accept bool for OnOffAuto and OnOffSplit".
> - Rebased.
> - Link to v4: https://lore.kernel.org/r/20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com
> 
> Changes in v4:
> - Added patch "qapi: Do not consume a value if failed".
> - Link to v3: https://lore.kernel.org/r/20250104-virtio-v3-0-63ef70e9ddf3@daynix.com
> 
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com
> 
> Changes in v2:
> - Expanded the message of patch "qdev-properties: Accept bool for
>   OnOffAuto".
> - Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com
> 
> ---
> Akihiko Odaki (4):
>       qapi: Do not consume a value if failed
>       qapi: Accept bool for OnOffAuto and OnOffSplit
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       virtio: Convert feature properties to OnOffAuto
> 
>  include/hw/qdev-properties.h |  18 ++++++++
>  include/hw/virtio/virtio.h   |  38 +++++++++-------
>  hw/core/machine.c            |   1 +
>  hw/core/qdev-properties.c    |  83 +++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-bus.c       |  14 +++++-
>  hw/virtio/virtio.c           |   4 +-
>  qapi/qobject-input-visitor.c | 103 +++++++++++++++++++++++++++++--------------
>  scripts/qapi/visit.py        |  24 ++++++++++
>  8 files changed, 229 insertions(+), 56 deletions(-)
> ---
> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
> change-id: 20241013-virtio-164ea3f295c3
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


