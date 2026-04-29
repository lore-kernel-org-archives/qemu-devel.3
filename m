Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B09CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAxB-0000Fw-RK; Wed, 29 Apr 2026 15:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIAx9-0000Fm-So
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIAx7-0006zq-5c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777492327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EX8Mk8Xb07d4QDNqwvgMK6inJDSAJISA/uctRaCi0Fg=;
 b=XHCalY19N5OpMs8+d7hhz8yONMzDtdnstNScqskgWl3iqJH1wnk9E1xHChP4gZyXcVWscb
 FR0juUTto7kYa9OV9p4lANqbknFZ83iia76gD2rUezAaO23j45RyPExlnIK4Py7b1ZHGVJ
 C9WU+y639fLV7TU5zTm59I6ZJAKeBVw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-PMDX6bG6OKeEz8L9dWLb3g-1; Wed, 29 Apr 2026 15:52:05 -0400
X-MC-Unique: PMDX6bG6OKeEz8L9dWLb3g-1
X-Mimecast-MFC-AGG-ID: PMDX6bG6OKeEz8L9dWLb3g_1777492325
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50faf1ecd1dso3756771cf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777492325; x=1778097125; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EX8Mk8Xb07d4QDNqwvgMK6inJDSAJISA/uctRaCi0Fg=;
 b=OoA+t2ezvgLWRDW33mTYjSRUQByAxVX0B8bA7CbPxO5vQi2s4OgYXy34neAwxPZK3c
 zgNB0W6x2XACpbzTV2WqNvpB6O7kW4ew3d0SZTzvUM/cK4pDQrx8JPTy0Ak+b63Bo32F
 9udEwAqQauqpEQcEk37mm/kXiIhcoOWdLUOu6fEUaX0fNfwGklwSCp77j+5pMKF4K2nz
 HD9NUxJEleOZEjMOqIjkBQzaIzqcseqFeJ/aFE9BMx32PmlK7tvI9bTzejecrCSB38pm
 xeYVUs4ERYiNKGyqqU50ebNU0ALTfzIH2oO+yB5Knf2+vEVTWYPu8S/oGyfbMPgn2R+I
 nthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777492325; x=1778097125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EX8Mk8Xb07d4QDNqwvgMK6inJDSAJISA/uctRaCi0Fg=;
 b=bIjvRf+17GcSLPqeqsk/PkJ/4yHezYGVz3JtKkOcXAye1G78lZugmaY0uT6zXM/OYI
 GWdtOiepE8IdaTwu8t2KkGk54nOjIYp6Se9YMZc4T4I45cB8jWGvEupcdYhnXGswjINh
 Vlh62KjLx3k5OwRaoSpgo5aQCCe7aCPOkmVO2LNOdazy2xrAWL2HEG13jVE9wjaqLyiN
 wLG6onzZLtootnipNe3d3oJyguZxtK6I9r+de/6vcdF7W6MEQoCqV7snds3/gNKlZxa2
 OH/6867BziGIjqaGexUggAof3s21kAgwy7gfEc7zZWJqyjiKIoiZWURuLwUb9KPrxOuj
 zq7g==
X-Gm-Message-State: AOJu0YykbpsNJqtspYztUh8QrB4mztrU8Y2P8GKAVxKHbVNyVgc6bn/o
 /tmVmagf7pVvGExik+GFcWsgO94/7GQJl/ZuSgaI88hO8KSXRQdwIE3naEGdYBQRpU8+Sk1RBWB
 nCjBfgTfjwxo1Ql7BR7BKkrFwqxlpwW66gru9MjvktesDdMsd4YyzH0uqSizU5ErRzABLVYllx4
 uJjHkaSigQ/zpl0gxJTMR0IdEx6nFzcB15zo8l4Q==
X-Gm-Gg: AeBDies/RSuclC5OL5StiHxVjFR3EkAucPzAVGGgHQRYDk5mv182oH0vHSagxSZXgbz
 3f0RdQNjAgZWwzUVZxGTN5hT7Okibyt4Fnl46Cazgpeg6Pj4t4ulURvrGD2UkWlycFgcoS/NlEM
 A2D0wUkfpBSvf/OIEnkz98RrHy9fMoQfMSaUdJbAN5uxBd8xf7RAnNCUddDB56YFPoRRLQMIUIb
 ASL3a7BVxLVWvf+jDEXGZN4W72Qx8nhVDl3BpX35nry7G43dLVqMhABnAWxkQLUvC0lmF5ulk0Z
 wtGaZ0dXLUPHAaJLHwe3LQjZ+ciul+96pZHWOGPyWC+PS+bzNCXGKeOfnJ5gQ8txxfyopxxmPB8
 WViOwFRAcEXB9N84z2fPCoQ4mcyqzOLMncziESy02tDA7Sv7vi9Qaz5J+dw==
X-Received: by 2002:a05:622a:145:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-5100e125f80mr129464371cf.18.1777492324892; 
 Wed, 29 Apr 2026 12:52:04 -0700 (PDT)
X-Received: by 2002:a05:622a:145:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-5100e125f80mr129463671cf.18.1777492324205; 
 Wed, 29 Apr 2026 12:52:04 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101accd24asm29361421cf.9.2026.04.29.12.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 12:52:03 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:52:02 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 00/16] migration/vfio: Fix a few issues on API misuse
 or statistic reports
Message-ID: <afJhYjlg8CcKW6Dj@x1.local>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 21, 2026 at 04:20:54PM -0400, Peter Xu wrote:
> Peter Xu (16):
>   qemu-iotests: Add query-migrate test for dirty-bitmap
>   migration: Fix low possibility downtime violation
>   migration/qapi: Rename MigrationStats to MigrationRAMStats
>   vfio/migration: Cache stop size in VFIOMigration
>   migration/treewide: Merge @state_pending_{exact|estimate} APIs
>   migration: Use the new save_query_pending() API directly
>   migration: Introduce stopcopy_bytes in save_query_pending()
>   vfio/migration: Fix incorrect reporting for VFIO pending data
>   migration: Move iteration counter out of RAM
>   migration: Introduce a helper to return switchover bw estimate
>   migration: Calculate expected downtime on demand
>   migration: Fix calculation of expected_downtime to take VFIO info
>   migration: Remember total dirty bytes in mig_stats
>   migration/qapi: Introduce system-wise "remaining" reports
>   migration/qapi: Update unit for avail-switchover-bandwidth
>   vfio/migration: Add tracepoints for precopy/stopcopy query ioctls

I queued patch 2-16, with slight amendments per reviewers on some patches.

-- 
Peter Xu


