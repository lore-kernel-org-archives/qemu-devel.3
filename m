Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB88C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodA0-00036C-PN; Tue, 28 Jul 2026 04:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wod9z-00035z-2p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wod9x-00008l-MU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGZz0otzs0BgIe44j+6lgYT6QlKiY3QCEg2BCNEU3p4=;
 b=dx9ZOPokGAfJgtmge/fAYIEEE57MW0kGUYn6f0UxJBJuD0C4Ch3DrR5zYHPe+x+b13vp9r
 FfPnc4FGKUW0EaCFXQtT2ZgRcavUgg4C/kzjrcOeAgrQ3948GXsPliflvm6vL/gMfqLHgM
 jflZ+bpaambh4yrRc0pyr2TLDE4rZQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-F1K29lDKOdyt2MROeki5yw-1; Tue, 28 Jul 2026 04:27:31 -0400
X-MC-Unique: F1K29lDKOdyt2MROeki5yw-1
X-Mimecast-MFC-AGG-ID: F1K29lDKOdyt2MROeki5yw_1785227250
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954a93c565so17632435e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785227250; x=1785832050; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UGZz0otzs0BgIe44j+6lgYT6QlKiY3QCEg2BCNEU3p4=;
 b=ojkBV8A5GnIZLd3oBbqZbWeB0GWW3thAiUJR5aopDGmcPk4kKtZSMdiwsYpnt3xrS4
 ncY7KLG9xf/YVCJ/5DObBVbhHxC7V9+xRQ7njFMw3ugguUtWRkC3Y/uZ6mL/Ov0LgAqW
 VS8fspgN5UmXXizqj3gLmwjPVpp2KaO81ZR5Rgp+H8zGMY6/FZrqLRf7U0bZW6xxJFrE
 9J/DoA1DLP4NaUB8muj+j0OYO73Ab/bZZ6p/VrqV8WY5MOCyy5Wun9mThBZzC5YJHwh7
 08km+68I6f3tQ7SgVy9+FFBgaTE4j7OMIfQ19/pS+HrCZg1nCApsJL7K6g+o/0gDAlrD
 9IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785227250; x=1785832050;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UGZz0otzs0BgIe44j+6lgYT6QlKiY3QCEg2BCNEU3p4=;
 b=LIRf+OWX80b9CLKZoWRnXOHl6PxSUHJLFmA8HsrzG4EvAzG60rIq3ICHJksvjtZmo7
 iuCcHIQqbKAzJwryq8gscIiKqS4/buaiRiLQU5nYMWIZezDVK1Fc8ARpjK/ZNv8WQwXY
 v1j7WZNjTLQkoVl7EPNI5CDxAFr/Srn5AKtbghmWLP8BA7Gmd4kxAlZd5TbwNXs45YYX
 14mNpvOlDk86QrXW8MD9xpjJx2cpcOQvNUmFado5lp52qZ5PKIsO5ySoORHJRnatPyAw
 JQtPCNxw59V9zDMWdZ0ImNbfE8LWmjF8ZyWD9N7UBeTSybw7q0aXq/uTkS8czFJ81TAr
 m9AA==
X-Gm-Message-State: AOJu0YyTS6p7jMfrvM0zZlRZeRXCE9lesvClAuBzoPE6E0oMlTwwrEDG
 kCvnKZVf60GRq+3CeqX+oU3qJhB4svhXp1/MP6Syh+sXv+PSzhvfaT4f9gj2LqhW4ZzpERm3+Jn
 Okjr8bW6S40xe3B760HVoeTBy8cYV1vgPHoKNnDE7jYsFGVZMID8b1sUd
X-Gm-Gg: AR+sD11RJv09Nf8IWMKypv9JTicVt1kLjO9NBCeSTPwltLByy6LWX+0w5vVzbA0Hzig
 gyjTR9RmrU2hbipdTnnQW/SGOxbFeiD/L1gbJ6IAYafs8jsaSFiHB/MU1cXaRQh3GVX72WBv7Hw
 3SZo2Il4UJ7H8aTsqVAUt3N8FW9Xm5JW+xuUM4Y6uzvkxV5KPOQFP9bXP6aBDQqsPozUmZ6u/IS
 9uAExl3VKWrjhulsum6bfdB+hXML9kHVDzg8G5+IBvg1yw2SysaGALrjrQOz+zRiScfiEILzcAt
 C99tuobfZy9h6y15xcpoNir+vjm84IZek0vZvfOG5iRVDG6EuKGuwylm2SgmdjgKObzT9MVWmbe
 b8zKLieU756q+CJGaDnfHW/Zu/GGkUs7kI3fNu7fnY4I=
X-Received: by 2002:a05:600d:844e:20b0:495:5375:2510 with SMTP id
 5b1f17b1804b1-496c6568a37mr9587545e9.24.1785227249772; 
 Tue, 28 Jul 2026 01:27:29 -0700 (PDT)
X-Received: by 2002:a05:600d:844e:20b0:495:5375:2510 with SMTP id
 5b1f17b1804b1-496c6568a37mr9587215e9.24.1785227249197; 
 Tue, 28 Jul 2026 01:27:29 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it.
 [82.192.137.139]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c338fsm60041965e9.8.2026.07.28.01.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 01:27:28 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:27:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] vhost: do not crash on ring map failure
Message-ID: <amhn4yvmMmAFZOy3@sgarzare-redhat>
References: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 09:07:47AM -0400, Michael S. Tsirkin wrote:
>When vhost_commit() rebuilds the memory region table after a flatview
>change, it revalidates cached host virtual addresses for active vring
>parts. If a mapping is stale, QEMU abort().
>
>This is not a security problem - only the priviledged guest
>can control make it invalid - but not nice e.g. for driver debugging.
>
>Let's call virtio_error() instead, marking the device as broken.
>
>Fixes: 0ca1fd2d68 ("vhost: Simplify ring verification checks")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3783
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Dr. David Alan Gilbert <dave@treblig.org>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> hw/virtio/vhost.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


