Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50DEEB3632
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9by-0004FT-Eu; Mon, 02 Mar 2026 15:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9bw-0004F5-Vw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9bv-0007hv-Kj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772482282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QK9KyhdHad7WbY7kfB/rBs+iTIxoTzOJsG44R2ndptQ=;
 b=Zfya9KxF5T6wIqpHOL2dYdzjWzC06D7jCXVOdCn9cqCg3s3hafnmCq05tkGQ2cEESuT1WB
 EgIpag0kLGVZqmm2HgeWT1XW/COFAujBcYKliQ6QxB3u1hB22UVZOPTCkrV4rpdadTTOWR
 WWOFWN0I3UVWudwkqLKFUaeWva0BMRE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-hMoZkkCINLCNf0ID2F7LCQ-1; Mon, 02 Mar 2026 15:11:20 -0500
X-MC-Unique: hMoZkkCINLCNf0ID2F7LCQ-1
X-Mimecast-MFC-AGG-ID: hMoZkkCINLCNf0ID2F7LCQ_1772482280
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a0258c5e5so14010866d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772482280; x=1773087080; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QK9KyhdHad7WbY7kfB/rBs+iTIxoTzOJsG44R2ndptQ=;
 b=Dp5MY4whERtGjFipLRpdp9Uy5EN4unIPyltE7cR0dmPga/ecTbDvw0rDCjXTGWRf23
 jzEEGjSMa09URKfQoXQZ0ubEGET2sHL4XdC5ZQuOxWMSwMakTIa5p4aogbdbBkmyUMKw
 83wXCTPdyOzYavre2DSurY6Yh9jH8E+TJcSRtgy7S/Bdn9+ClluYidlTTpIOE8FF8AJk
 z2SX9qfY63G5zYF4B/COAZOf9aHmO795UhaCw6x+uU0Qin1d/yV2iVIO68rabZ8Qls8O
 FDyM3hLR5l1iGAaJeR7tGGdMIWMtglTP0y/NNqoj2yK/qkOkgqE1Ey8d7TAe5FK742vs
 rAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772482280; x=1773087080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QK9KyhdHad7WbY7kfB/rBs+iTIxoTzOJsG44R2ndptQ=;
 b=oXad6BFsfFcm+kFKfxSfZ8bZoQC7cFpZiejXJNzF16I/VrR64jRwBg8FjBvCbt7yVX
 dobm5RYpWGt1hYVpX8Ofgf0znjY6n5qheNl0hg0XpVLTjefCYM/P326iQEFqzhZItQjc
 XsksYbi7Vzub+NCZb9O3FjPjBpPB6rQgNanZzRBHhTMURFKgHCyCDDrDn9qqEo6Ekz4I
 00EBghPnCbI4zKBRK1BudN3uthyMH4ueUnsFuo2ulnX8lGjqLfNvtuc47+aLSF/jvr/R
 BUUiEX1OHTdr/fKRNGhBIWrrozk0Wm4hshB/nUX73c/ENQ8LExP+jtdbQWo+0AN4l0dw
 VePQ==
X-Gm-Message-State: AOJu0YwOsBTFdjMw6Cqo/WmowyaJBoE62ozgGx5AEWPjfC4Y7PybgNMj
 Z9K1Q/jJAURo2yTo0Mi1p38Ix+RwU541NBOY9nT42tuOT7LPVRSmH7l/v1MxzFulIvUFB/Scz6C
 3s4pVYuA+MCGLgwD6wWvaAPiqaQwvoj69c69ajaVLGMI0/nTnCsM0ekEF
X-Gm-Gg: ATEYQzwBTcm9Eu/Mr7UKkbDBodZWEy9Y7JWJvbsRmTwxft+APzokXW7KYQWciUBUpZM
 E8q6A4v2SBG/yVNhw4askIrR3EnAoSxQtq/Zj60Q9jLIX+ACInCCDSLnG/zfWWPPJtq3inQb1Js
 QNDrgvvunY+2eh5Ppey52h7z8W/3/FXiIT36UMGdxeajAbUgVwYm/1gsRnk6IlTQ/MywscgMc1K
 6rr5Fq2AhhapxVEcWGHkIg14WMa6J8cBE7neaQDb8OU2gEhIRuT5ZKB88q0LFQI7AOKAM/TQGUx
 5plE8TXQUUpseLxVe8jAjP+8ua5Arl/3GpqV0b73yBkvJfrRjiv/10HrzlwVJow39Sxi6KjmXN0
 rsrkh4HWR9x1ENukPFShChJjBfglSGTaFl3R9nK+d4O6qbS8w99SoRdnt7+zCjws/jmiVqEaC6G
 ZsfelPOA==
X-Received: by 2002:a05:6214:5017:b0:899:fa45:7c67 with SMTP id
 6a1803df08f44-899fa458064mr72298536d6.57.1772482280053; 
 Mon, 02 Mar 2026 12:11:20 -0800 (PST)
X-Received: by 2002:a05:6214:5017:b0:899:fa45:7c67 with SMTP id
 6a1803df08f44-899fa458064mr72298056d6.57.1772482279501; 
 Mon, 02 Mar 2026 12:11:19 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899fc95502dsm27447836d6.25.2026.03.02.12.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:11:18 -0800 (PST)
Date: Mon, 2 Mar 2026 15:11:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 21/21] colo: Reuse the return path from migration on
 primary and secondary side
Message-ID: <aaXu5bVoQX9OkXKk@x1.local>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-21-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302-colo_unit_test_multifd-v11-21-d653fb3b1d80@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 12:45:36PM +0100, Lukas Straub wrote:
> Use the return-path capability with colo and reuse the opened return path
> file on both primary and secondary side.
> 
> This fixes a crash in colo where migration_cancel() races with colo closing
> s->rp_state.from_dst_file.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Yeah, I think this looks more consistent, thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


