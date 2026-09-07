Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0D7C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3akF-0001CP-Ja; Mon, 07 Sep 2026 10:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3akE-00018J-L7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3akD-0001Nv-6V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBMybTZ4ox6HFgLo5RUz5DBAN+6x73VpUWHbMoJecQs=;
 b=SP6O6mMG+fdWBYR7vct/GOmyb+deWqnK4hjcsMMwJtXBgk19ngEbkihwyUKJg5R5yNtKsK
 Mno9uw2HdXDA4btDwP10pzT5+rJuvPupEHPxyacqL2sUPnKAym27x8DzH2ZQF5KygpIiCK
 PpAv7shvd1RIgKOr+m7zc0SCtj8yXvw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-dUBeAohSO_e8Ooxzff9CwA-1; Mon, 07 Sep 2026 10:54:47 -0400
X-MC-Unique: dUBeAohSO_e8Ooxzff9CwA-1
X-Mimecast-MFC-AGG-ID: dUBeAohSO_e8Ooxzff9CwA_1788792886
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484362cb000so2488366f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792886; x=1789397686; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dBMybTZ4ox6HFgLo5RUz5DBAN+6x73VpUWHbMoJecQs=;
 b=loVkDuNL2iMh9t0/MKQy2yOkZmzpHOLf211dQ7jPXjZYndqksunkGMDdAzJb7iqVkS
 CUWbcWNkryRVRROjhIfRdKhZLYifZK4Fz6SWSF/DQgQP8xA8g6gzsmzOSvY+AFy4MYNk
 XM6e9QEHxnyLJEFn0LmQ4iVCMA+UJk68BIpgCEQYJfQ0j/ULTviQMACJOLL54j7b36qc
 P931xC9YlAP0k1SD1Opsjtepwc1//5UXvJAdsNZobF/7oirEhqY1l3EezIxImaZlRXte
 CgA5nicdeB3mvHtCYJDm+FT/ckstplHkvVPrbdr45GqI2J0T2spp2u/Gd1YjfO+QDiQX
 E8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792886; x=1789397686;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dBMybTZ4ox6HFgLo5RUz5DBAN+6x73VpUWHbMoJecQs=;
 b=r/PBzniLFu1/ySCM/nqhr8d1xIah12hcYDy3FAV+XhJBCnq+Aa9EABYNzTbJssffqh
 6ZvcFKH+5j+woY3JFJa7+X/Lo6KI+U8J4LvMdpuo4aSWNIWk9F+pyQ0QbmE8wepUE87J
 EIKVVRyE1Zit74/NkR0QzsqZQ4RfeE/z5nSB4ogZJbO7U8tHEOSCCAum/uSmypuBBFlT
 /OMJp9z4RDLx10aT6dHq6LFWYvtH0NzCSrgZmnErUUfeZmviS/dWM9RmjGaBMQVGSehA
 Q20UwdgIvmltbIL0nLI9avz5ZRMB/hfAJQCMWzBSh4kndN4BTwzRhjXbNRXcLnkwxPiy
 9+bQ==
X-Gm-Message-State: AFuF++m3xC3oyE9qWmkvBvm0o175h1JSXEiwKj+I6mG+H//iLy1EYC2R
 GG+1vpPCxmG6ZcWeHOv4ogAhFw+8PSjA/Py+4Fw2U0uXVxGC7qS+o9ynamu95RvcMP8zUWHw4je
 nF9Fge60MT8dbTqOK3yg9eldu5CY0PgGrJGhmYbLxO+txoTpWj3YPQ3yv
X-Gm-Gg: AYBFou0dcml0jRqcdDEbCtFvTXEjP3dOpJWar2hCQTIGEfWG5Wcla3Y2h2Rraa1pHCp
 t/Dx8OKsvCBfouDxhcy1ItWQcGfRuze+/zoN3rrQ2U0huJDlrVysniG2fWR8oJiFV0OuqhZmF0d
 tckrFjCTnrOYRzAvnxnlYzRBx3HkokgM8NfLbQJ02YsLMyXkmpfSJZrSz49ZKVGNpccoh4l3tw2
 iQSlvFSDEmHaWmGt/epHKKk3BH4FsdWOA0WeRRVFKD9HyCoCcgxJH+HxFTm+Nd2ZKCfJjt2RLzF
 pP99D8W9kqQO8Zpp8RRnvmgVY1vkrJcWc0uGjm8RYEJqMUN2sX+egEjkeZ9x7/ph5b98ADoIRsh
 V926kXxgzYcDmQ9Mz4bc3zIfQutYhxE+ZFqS82tX8lMxYLg==
X-Received: by 2002:a05:6000:455c:b0:485:8df2:6460 with SMTP id
 ffacd0b85a97d-4858df26482mr15293612f8f.20.1788792886049; 
 Mon, 07 Sep 2026 07:54:46 -0700 (PDT)
X-Received: by 2002:a05:6000:455c:b0:485:8df2:6460 with SMTP id
 ffacd0b85a97d-4858df26482mr15293565f8f.20.1788792885526; 
 Mon, 07 Sep 2026 07:54:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm27897346f8f.3.2026.09.07.07.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:54:44 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:54:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 03/10] vhost-vsock: don't reset connections during CPR
Message-ID: <ap7D9vq2PQLTWPZg@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-4-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-4-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 20, 2026 at 02:39:48PM +0300, Andrey Drobyshev wrote:
>Migration target with a vhost-vsock device in the .post_load() hook issues
>VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
>the guest tearing down all its vsock connections.  That reset exists
>because after a normal migration the cid may change.
>
>However it's not true for CPR-style migration.  In this case cid remains
>the same, and we want the connections to persist.  Thus, let's customize
>the .post_load() hook to skip the common transport reset part in this case.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


