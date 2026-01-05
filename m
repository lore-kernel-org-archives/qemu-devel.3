Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E306C79FBE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqV4-0004bP-RJ; Mon, 05 Jan 2026 14:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqV0-0004Z0-Dt
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqUy-0004E9-RU
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767642255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNtWMqmGGXA4jUDvYktdeZ61y542mMBn9GwntZ99uu0=;
 b=ci5Fx4YrOFdw2hwkPzomEXTbFhhZBj/dQKHzWAfbLapVWtmShfR79Xj9cw+I+osxG4MxbK
 xirVpy9qgvgMy41tnnmD3lVNIYCNk6dpgaEj9JYi/JQmTI2ZhrJCB63LePpmKxruqt67R9
 NT6Pd0BcxBVrH1tmiaaTz4td+lgnYmE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Qofh8xV6NTaqevtJzNF3zg-1; Mon, 05 Jan 2026 14:44:12 -0500
X-MC-Unique: Qofh8xV6NTaqevtJzNF3zg-1
X-Mimecast-MFC-AGG-ID: Qofh8xV6NTaqevtJzNF3zg_1767642251
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0d59f0198so3106365ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767642251; x=1768247051; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CNtWMqmGGXA4jUDvYktdeZ61y542mMBn9GwntZ99uu0=;
 b=G7djgcUpmyTjbUn99nNwehJgrT0T2NXKEmFAIhQfCg7Wbdq6OVre9NRbFZg+zzvFzs
 ZCgcyFlYYgaFjevTpF9WKtVqXyQPqlVkqLlpo431N1dbTlbnfnI8uyIOoaM+QI8YUNiI
 mHDgusn0HA+ypVioNPiL7KAPMK3np3Fh+I9TgPmIH+eM/nmHvX/pal7YYidGpqFumhb6
 bCoWNRIxaqUDW2KhuWhvz7mWufKcN3vCzaBrEZmJn2Z+fkU9H6tSQbobjJPOKkHjcp8x
 EjcRIMBI8aXZkpw8gqGsfNg24Wluhzu8e/atXTg72oPXk6+x4Pa4f4mUtrGDz2epOfii
 4RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642251; x=1768247051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNtWMqmGGXA4jUDvYktdeZ61y542mMBn9GwntZ99uu0=;
 b=ZCjp/tsRKmWUDzq11sdcRlZ7cuPFis98+g1adHaaOUiuUwqAEx7HRQu0lLCwVOgY9Y
 XZNjUW63PE5Xed/P6UchL2xDp1Uqht3vARx9aLbo1vo3EKHtvu7CkbQz5WwMsz+FRtH/
 nDTLgsNvjyqYrAHONhgGFoQKl8f3eXQFeaHWsEn3K7Z+xv9MrFjqzdTBx6gA7yZiQ/bz
 2dA/ys/3B1BL3pEuxHTvfICB/KQvN8DinsxeJcysRUEBRazsqZq/z95FCYVxlEyQE1kP
 smpf8SlREV2wwEufgDTHECS7Bd6lXE61AhvwCc9k0UDVGvIT7ebGpZtqjd21qUp533fi
 Ks3Q==
X-Gm-Message-State: AOJu0YzONSNlyHoXQA/phytkxrnJACXzLUpnstFrmiRX1W+gbrLvTdyL
 DXWcRlAQdcF3KZ5mrpUhgWlj/F3HDcNsObKQNZoLhe4ivD1eorHeDANDZFfUYXOL/fLwLOM9t0/
 8eFJpZxVA72aLUBUGfY+8td/xQkb9HUkpojhBm4WQ6ZCNXnd4wx1lul47BIqeHynX
X-Gm-Gg: AY/fxX6+JLFZl/Wa3SbK6YrVkzmW+MfB83v8YDlkMG++viy9S/PVK8k37yzuN7Vz0zL
 Y2q+JCy0/gswilCMpS+n5XWJ7B/fg6PtAzqKM5eurw6n1ieBuZw7oGdkumNxuI7nrg31pHmR/am
 potxDTV0E50+rhtAnPpfxgA7gEmOpL5iR5pWhBsZ2gcI/fD5K9OFigB5/egZws2bwCwHq5KjFl1
 gzi1m8Ew3T01ZU+mpufw0HtiM3ZwVZ64kqw03LPgEKchicONHfT1OqXSV0H5snd/C3cdcQTTQHG
 Vci0TdY4XcQzaAyZbzgzbT0x19AATrEm1zxxQF9+MEIqXiNd0yKtHev7jjOAjY+3rBcjGBGE6tm
 3Ln4=
X-Received: by 2002:a17:903:298f:b0:2a2:d2e7:1601 with SMTP id
 d9443c01a7336-2a3e2d1a865mr6252145ad.48.1767642251228; 
 Mon, 05 Jan 2026 11:44:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfoLup5VJYW+VfAwAjIgfbmabDQuN7xjGT1RLuN4BdcQhZniD+RXg9F02veGC6BLOsMarH2w==
X-Received: by 2002:a17:903:298f:b0:2a2:d2e7:1601 with SMTP id
 d9443c01a7336-2a3e2d1a865mr6252015ad.48.1767642250715; 
 Mon, 05 Jan 2026 11:44:10 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm489505ad.47.2026.01.05.11.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:44:10 -0800 (PST)
Date: Mon, 5 Jan 2026 14:44:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 16/25] migration/channel: Rename
 migration_channel_connect
Message-ID: <aVwUhflyt0AKA0Pz@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 04:06:33PM -0300, Fabiano Rosas wrote:
> Rename migration_channel_connect to indicate this is the source
> side. Future patches will do similar changes to the incoming side and
> this will avoid inconsistencies in naming.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Maybe it should use a common prefix, like migration_{incoming|outgoing}_*..
Not a big deal.. though.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


