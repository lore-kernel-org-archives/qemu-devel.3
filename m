Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1BCCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wND5P-0000st-Pu; Wed, 13 May 2026 13:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wND5O-0000sG-Gn
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wND5F-0001hc-T8
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778692159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wdt/wv3M1J/fJX+xUFfrvpFl5mUrdYEgBVZwMgGw/wM=;
 b=FzzWRTYcGFtHyI6YrHTQw/KhPZqmlTkEseFAZ4+U9ye1qcvUZ0bSPhk6ZGzdRlypu5AEtf
 BZ34Xwj3WJjvYkjJw9dAeEKikUShUw8AH5wWpwIwa5UhA1tMQJx/EAYHuCLNroPi8NaI51
 HIliDnvDw5gWyhz8ilvsaLuGTvXhspg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9Wq-P_B_OZKo7p5lEhARzw-1; Wed, 13 May 2026 13:09:18 -0400
X-MC-Unique: 9Wq-P_B_OZKo7p5lEhARzw-1
X-Mimecast-MFC-AGG-ID: 9Wq-P_B_OZKo7p5lEhARzw_1778692157
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5156c85538cso40695681cf.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778692157; x=1779296957; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wdt/wv3M1J/fJX+xUFfrvpFl5mUrdYEgBVZwMgGw/wM=;
 b=UP43sSfU4uAncy7mHCiZI5XBsB/RwhyQavuSssg0KyrUMAsvWJEqsaxOqWHhowmqm4
 c29vDsBv4sg2V8HbcnBIdE+6mdlukBW84Kxl7MkIRkc3A3PbvfNBUl06hQ2R4FIe2DA/
 9uBEE0cCND6s4LadUzF2pwQ9ya9yv/of7/MTHQYsvi6ZjADpfZpD0KxMj1A7rHEb12Yk
 DGAPU323LylIo3/3bZe8EnKQF5tSctgfrV/zQroIt6l9UmANOSxQ608V2amub8keifU8
 akH0jtOv9qJwokCy09yJ39s68FBpYUYgHcVqlYepvapZ0sLidK1807334AOljwZJpU0b
 vRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692157; x=1779296957;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wdt/wv3M1J/fJX+xUFfrvpFl5mUrdYEgBVZwMgGw/wM=;
 b=mGLUKNzhAvfLKnoGOAd6zVnvNBBWZ7OokVb2CYQ7yheXenVkem6h7PVrLdWxWCCirk
 QT4pKGR+X/KlheVhnbNMTSiDUAeBLDEeVmNDJ2WQu+0nfsTbW+uvEzqRPx5ocUCnSHsv
 qpeJt8VGYdIWJhIavDjbcZeYftTZl6a9674TDSefvf7ii3/vdk6I7sq0JKFL+si2s+m3
 PJZFxePpJFiqSuwDiub0gLsNvGDNXpY4pMinPpzYijP754kuGkO9iScwp/cXC/L9mNB6
 6kXK0GS9UDuruyhdQZBcQGpBSA/bvzJxBvCfDBaPBMB4CBhKWycHaFBwdOVvshtLlmyo
 TSNw==
X-Gm-Message-State: AOJu0YxbRa4V0gPu+0O2meJzEKQPtQlgYD7BRuX7uGDZyWRH5bqa+gqo
 I7/3RFCQttWUfmge0AnPeEZJwzmDlzmVQ1d3YpmABD/Fu7MMt+hDpl9r5aWLoklGrqcQaN2LQp2
 ZKzzqKGzA9pV+eBFb4Ky2rLJCdmhJtl1n8vGcXWLfSgMY5jmarmkDphvO
X-Gm-Gg: Acq92OFbXJGWldsMHGYXD0nD3O6W96OMINBG/stYDXRgh6vTm8YHaJyCh+j+IFXIAmr
 DLz5WNKN1ZyVho2ajI8smaZS8p6IX01PNedIJKoBPPKPIXTR7vFOJd/9SCwXY5pxdmDW9SfUDbE
 Xny98F2ULWSC1Bh8PY0yKB+iXEe9VNtN/jEjPIDOtvXM2NXtofqBcnIbCA7KhmHo/TbwOGBaZZt
 8WJZ6zCJlobdcMke50h6JM2jR/N+Cn/xJSi8nxduBGD6eKEIJt4HaACBGBVSSj3cFks72j7fIZ2
 To2J6u2dD/KmAHqOxaZk7wfXhVBuXW02KRTQ18X1hvDKYwUrR0Nb3J3f703noZevGkfWyA21jkk
 Ft/Iyy/L+Wk1p4UOhz9PV2W1gBgmy9L+8emMo0I+8AYsxaqY=
X-Received: by 2002:a05:622a:1a97:b0:50e:5f37:a821 with SMTP id
 d75a77b69052e-5162f58ae45mr56023211cf.36.1778692157270; 
 Wed, 13 May 2026 10:09:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1a97:b0:50e:5f37:a821 with SMTP id
 d75a77b69052e-5162f58ae45mr56022661cf.36.1778692156563; 
 Wed, 13 May 2026 10:09:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e677e63sm152947881cf.12.2026.05.13.10.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:09:16 -0700 (PDT)
Date: Wed, 13 May 2026 13:09:15 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH] vfio/migration: Detect and report overflow in migration
 size queries
Message-ID: <agSwO7PjtjovanZl@x1.local>
References: <20260513094522.346314-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513094522.346314-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 13, 2026 at 11:45:22AM +0200, Cédric Le Goater wrote:
> VFIO migration ioctls (VFIO_DEVICE_FEATURE_MIG_DATA_SIZE and
> VFIO_MIG_GET_PRECOPY_INFO) return device-estimated migration sizes as
> uint64_t values. A misbehaving kernel driver could return values that
> are unreasonably large, which would corrupt the size accounting used
> to decide migration convergence.
> 
> This misbehavior occurred a few times when testing migration of a VM
> with an assigned NVIDIA vGPU and an MLX5 VF. In some of the save
> iterations, the reported precopy and stopcopy sizes were unreasonably
> large (close to UINT64_MAX):
> 
>   vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073708667040 precopy dirty size 0
>   vfio_save_iterate   (4fbce62c-8ce2-4cc9-b429-41635bc94f24) precopy initial size 18446744073707618464 precopy dirty size 0
>   vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 18446744073708503040 precopy initial size 18446744073707618464 precopy dirty size 0
>   vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073707618464 precopy dirty size 0
>   vfio_state_pending  (0000:b1:01.0) stopcopy size 18446744073709543408 precopy initial size 0 precopy dirty size 1008
> 
> This had the effect of corrupting migration convergence, as reported
> by the HMP migrate command:
> 
>   (qemu) info migrate
>   Status:                 active
>   Time (ms):              total=21140, setup=86, exp_down=152455434886355
>   Remaining:              16 EiB
>   RAM info:
>     Throughput (Mbps):    967.98
>     Sizes:                pagesize=4 KiB, total=4 GiB
>     Transfers:            transferred=2.29 GiB, remain=4.7 MiB
>       Channels:           precopy=1.91 GiB, multifd=0 B, postcopy=0 B, vfio=387 MiB
>       Page Types:         normal=499427, zero=559708
>     Page Rates (pps):     transfer=0, dirty=1892
>     Others:               dirty_syncs=3
> 
> Add a helper to detect values that exceed INT64_MAX, which is far
> beyond any realistic device state size, and report them with an error
> message. Return -ERANGE from the query functions so callers can abort
> the migration rather than proceeding with corrupted estimates.
> However, the callers don't yet check the return value to actually stop
> the migration.
> 
> Cc: Avihai Horon <avihaih@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


