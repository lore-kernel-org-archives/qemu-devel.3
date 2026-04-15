Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FAF43858
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD2lV-0005bT-NV; Wed, 15 Apr 2026 12:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD2lT-0005bL-S2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD2lR-0007lt-Ol
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776269212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNt8DywzSG6NXMCxLnoVXz9U9et6dd53fI480k9R6xw=;
 b=PtP36GkOJwsPVqdwKF0NsMx88d5LyZGeolk3d4fP7sGnakDK6u4LOoacs8y0SLqtKn4vh1
 AFpHZfKrIFG/QZ9jNjTbzIQrC71uRaa+iEN8eq5zllOIoAiaLYxOrNMJbfGypFP68x8U7i
 ophL7AdQc7q3gFvVzT7l/G5qFkIaosg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-0jlfcbPqP5enwh0O6wIiFw-1; Wed, 15 Apr 2026 12:06:50 -0400
X-MC-Unique: 0jlfcbPqP5enwh0O6wIiFw-1
X-Mimecast-MFC-AGG-ID: 0jlfcbPqP5enwh0O6wIiFw_1776269210
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-953bde1773cso9006869241.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776269210; x=1776874010; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TNt8DywzSG6NXMCxLnoVXz9U9et6dd53fI480k9R6xw=;
 b=UrHfcZcBKIyeaQaoOI0OZkuO0pwamPrmvwdw60SVhu+GFCmbhL7e2nEZhgy2QvE0RZ
 N1b1yb3xGHjEajbvirbhWQlvWiKE9zTm6Y7uimzZUaJauMZxwJITv2Mojk0WefrhhLRl
 qDy3ePUFCqEdi7UfoviaaGunVbc4YiB9gIkygujC1bjfjPXvsUys+lHj5R+948X+STw2
 t+w6ytyswQ181/XZYyInPErz26iMsj0X98cMWdwTzkmKDHO/NC0To1OYHIU9Hngj8Rud
 9SICnnfnqFzzm3hNKm1NKwkUd+AHapVYJf4RUCIBupxeHA3zu7l05Sr8aNAJOaq5ntqj
 RJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269210; x=1776874010;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNt8DywzSG6NXMCxLnoVXz9U9et6dd53fI480k9R6xw=;
 b=rbHDHqOKd7jl0D2DLR7ULJsxsrbaELlTc3q5n4PqhSZdYmczNDCmKZd9ykJMGGui55
 6tvmMnNt6D/z6xAKM7LsVmxc/GhISjVzmuSrDZTle4v6gTMzCVrdZO0d00HFr8bgtfkM
 6oDi41ZpkBogIvv8yKhd8dMGND+d/bfCqFDkbPYJ4xyLYs3udhzUDcXWiAAQhBpLKX5p
 yKEOlED64nsa0uUMuHgdraBwey9UURBJf7symsERkU1qnRx1yHshdbFTXUkK6eWbyeC0
 Vxu/rHO1t2gjhLpKDKIoRGBYFXF2eoZvegvxVRmpRfUa/BLy4q4OUn7Yg0laaeal6uoX
 KAuw==
X-Gm-Message-State: AOJu0Yx6g+CwcCE+RWDAl75ZZ8emFhBezqUJnyteKQyVCtJ7aXjrz0Iu
 QQ2OO5sM2MQ8/dsGvp9Sx3Du+/DPpcv6V3BcsrXHSNbRdPqTBmTe0g53CVobMJt3zQqMi4e0i25
 8GcLFdJo4Qb0zzlx8tJnAbLo13+jVlzdnlrvb7bxZq4Ub1UoPcWF0yBsY
X-Gm-Gg: AeBDietXa/FVXlOQacqS2AmzUKqv6RUMw838SzNf7dGk2zQYaeE2/w/CHkGE5ftSzVf
 xVDgPcXoZuZSzBdBu1jTw3FXl0141ExZKpE0wsSrmJywLsQXt1RHtmqPtvA36aDGNBSYDuWCfyv
 q0OWdT8sHZhh6+PZNjqw/AjcyugTOlvW9oNKqCvmV2xl5sQoaV4kUieSAKVOAgMGl9bZ+3wGSIv
 ofO6c5ma6HMx+vrGxUh1eaCcuNdeZ9U/1kJNXQwEGnS4S8hUzhwcVeh6jmIZQIHk0NZTqghN04X
 B0qCGFD8XyWmm6rIztyLwNwuFaISXcqk+WdMzJgIBg2t0d/0XRLPTWYIqsEG3sICMZVCnhPiwXk
 yvmGygpugdotZvWzw1g7NCha3E4u5j3Rh8z2YsH0d/TEXNvbse8OYhpv1fA==
X-Received: by 2002:a05:6102:6045:b0:611:82b:a590 with SMTP id
 ada2fe7eead31-611082c1568mr4448814137.25.1776269210077; 
 Wed, 15 Apr 2026 09:06:50 -0700 (PDT)
X-Received: by 2002:a05:6102:6045:b0:611:82b:a590 with SMTP id
 ada2fe7eead31-611082c1568mr4448752137.25.1776269209489; 
 Wed, 15 Apr 2026 09:06:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c954368sm15822716d6.11.2026.04.15.09.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:06:48 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:06:46 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 00/14] migration/vfio: Fix a few issues on API misuse or
 statistic reports
Message-ID: <ad-3lkcoMy5mgtYi@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <8c51c77e-b496-4e99-a35c-364d224d1b3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c51c77e-b496-4e99-a35c-364d224d1b3c@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 13, 2026 at 06:09:15PM +0200, Cédric Le Goater wrote:
> I tested the series by performing a migration of a RHEL9 VM with a vGPU
> (NVIDIA L4-2B) and an MLX5 VF, from a RHEL9 host (vGPU mdev) to a RHEL10
> host (vGPU VF), with the vGPU under load.
> 
> The expected downtime was fluctuating around 2600 ms. Bandwidth was
> around 950 Mbps. Setting downtime to 3000ms made the migration
> converge quickly.
> 
> Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks, Cédric.  I'll make bold to add this to patch 13 when repost.

-- 
Peter Xu


