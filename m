Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26100D59F5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kar-0008SZ-W3; Wed, 06 Nov 2024 13:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8kap-0008Ry-D0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8kan-0002HX-AL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730917039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ORgoLF8DWAt8xYGodiEPtR0gXshyg2JjHPypSuGXlg=;
 b=KG66lTwRqYHllADbtP/OyGPt8Sawh1JDuFC4hASimrWQH2iE7TYOB2O5icDBSXWM1++CmU
 KzlV56/NYMxgH1LNQhhj9b3/V1W5jAFglXqdmY0aqasHfKe9xJuHEKqaByEnbrAkbIYKWB
 zVjWxY4cZvXsR/tavc1wbzI9CufTnAA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-eWXpq9fZOv2U5MQDRz6Onw-1; Wed, 06 Nov 2024 13:17:18 -0500
X-MC-Unique: eWXpq9fZOv2U5MQDRz6Onw-1
X-Mimecast-MFC-AGG-ID: eWXpq9fZOv2U5MQDRz6Onw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so22437f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730917037; x=1731521837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ORgoLF8DWAt8xYGodiEPtR0gXshyg2JjHPypSuGXlg=;
 b=uFTUsnapBpn9tK4BwAcH1kQYBlDDQc5L1uCnakAI1GcD3Wva0uARwo2Nzch1CrsArq
 v6OlxUUT0LrSTlaZahEp1ECy3kWu92Woc/itMOziAeCoedKACFmCSh8uw9mBV6N/6D2C
 RgqhYyClp+WrU7+iDedOCgnoFeEHHDMTdVgwl44iFTEf9qu/Iq5rYELtG/VwY0f3JvQq
 mFj2GBh6/A6LEEEPZNb6BFXeEXizPLu2gidkUohUF9Fs3OmdUdoneNt/V9B7tZZYWrBe
 42x/i6OItkV7qa7Y2LJN/In4B7NLKdzr6ujM5aY+6nWQnt7nyhBGSTH3YtN9+bTL17ZZ
 D1CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS0ZyMdG6IPULUT1ybZy9WfaxOKcwP279fpCZKTYAN7dd4vyB1R5MsR8S1KFHb1xP0tTp6iPjU+jlg@nongnu.org
X-Gm-Message-State: AOJu0YxBoDW4hpCZVIzqfmfzspBcucn8wnE99NKMid5WhP1ZoGVMfYgA
 oBrXc+P1eDB5rJpu/ycR15jB+ZOZoXTUCsECGqRsoV7dKSSsr9ohU8yKCQu+sJ1Q0Szj9U4rkIC
 FkL2feOt68kJO4lat8TqQqORleiRoqbXdorWPSCMv1EgzLm6QMF0E
X-Received: by 2002:a05:6000:186f:b0:37d:4e74:689 with SMTP id
 ffacd0b85a97d-381c7ab293amr16853492f8f.47.1730917036931; 
 Wed, 06 Nov 2024 10:17:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb5E4/KT4maHUJy1KoiW6NtprjxY/9ZAh88vYMPc1pPt4MH7mSCw6aY2N6zyri1Oi7YIJS6g==
X-Received: by 2002:a05:6000:186f:b0:37d:4e74:689 with SMTP id
 ffacd0b85a97d-381c7ab293amr16853483f8f.47.1730917036591; 
 Wed, 06 Nov 2024 10:17:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad6fsm19724115f8f.98.2024.11.06.10.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:17:15 -0800 (PST)
Date: Wed, 6 Nov 2024 13:17:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, sgarzare@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 0/3] vhost-user-blk: live resize additional APIs
Message-ID: <20241106131649-mutt-send-email-mst@kernel.org>
References: <20241106111837.115820-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106111837.115820-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Nov 06, 2024 at 02:18:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> v7: update QAPI version 9.1 -> 9.2



Not like this. ypur patches are merged, pls post a fix patch on top.
Thanks!

> Vladimir Sementsov-Ogievskiy (3):
>   qdev-monitor: add option to report GenericError from find_device_state
>   vhost-user-blk: split vhost_user_blk_sync_config()
>   qapi: introduce device-sync-config
> 
>  hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>  hw/virtio/virtio-pci.c    |  9 +++++++
>  include/hw/qdev-core.h    |  6 +++++
>  qapi/qdev.json            | 24 ++++++++++++++++++
>  system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 108 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1


