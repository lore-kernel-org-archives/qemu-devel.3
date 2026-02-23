Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53291E98DF9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 07:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQpm-0001TX-KN; Mon, 23 Feb 2026 02:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuQpi-0001TC-OG
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuQph-0003ud-97
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771833500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ly4w5S41/HTGOi9TcEzh+zdTZ3EnizDatVSymlll210=;
 b=Uo7kD0CwEwlUPXC7beToGFtM5DHUH62tvsM/KSYNsMFyRkU0CAk9KfyGHau3qpiPBIRu0u
 5XczmrLeeNXsHOLUUTd/3nS1sKWJLmPJxt8eAVJVEQZN0NmhiYLWUnZ/hAHwzwCBt6HHXv
 idY1HSXYvZj01TBtv6IbyJfB7sw6/MM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-GV5IYtSmN56Eqj766t0qcA-1; Mon, 23 Feb 2026 02:58:18 -0500
X-MC-Unique: GV5IYtSmN56Eqj766t0qcA-1
X-Mimecast-MFC-AGG-ID: GV5IYtSmN56Eqj766t0qcA_1771833497
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837f288194so33868545e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 23:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771833497; x=1772438297; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly4w5S41/HTGOi9TcEzh+zdTZ3EnizDatVSymlll210=;
 b=UlSoxaysJiHYsk/r5PnLNQv8xuFHhsKzPjeiUUc9qdNQCZMjS/VUpgUYSnsHl5lKzU
 +ObKpEUhya8l1favXVqPbi/5RrVT/1Izb0v6sL6OAyU4brNfrYZUT8MZen7e5CPyp4Su
 qdgv6adhfiuU3SNIgsdOd8NFss/Fbhkw2mXTAdcurXenfnHNS90eZLKd6RVaCem2t1tc
 kjW/ZwGLRqjsr7ls/ZyNjnGzDYLY2aByKP1/QNL5K3fNjFR3w/ZgsZVY2wwMOcFUB1Eb
 JK5IpworjmNg+4nyVjzJSXTcA1g/S7B6dYywKo570dgml2v9+DzWEPWm0X+RIOL/TVgG
 na2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771833497; x=1772438297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ly4w5S41/HTGOi9TcEzh+zdTZ3EnizDatVSymlll210=;
 b=gcBWfVDsxI8ZL7v6XP+uwMU/PGuNFNPFWtjdNiHfCEU9ufIsRX3o4c+PjUjUSaJh3m
 6qeF8pG+S4vTDDSAH74JsB80roq/ez5btevqCZW/4FAmTkBbFYtdIRLhro9KUS5nDcAS
 E0Z1wlK8nflOt1s5mpJo1q9jZlQBClxVXNp7UrOcETAtppjM+NYKa9Ra8Dl32Ua4UwII
 VnwtLoZUGPB9gGJcgtS/WxxNoh3TYVwFLDQunhecKfq8P6kAU4qn+g2UnxnPCRyk8xuK
 9mrjTBL3NhNbT01kWAiDZG2pt16aS2IZg9DPdKY+NMSl8TEL7MwSVc6IGMfPheG7Wye/
 Oo1g==
X-Gm-Message-State: AOJu0YyjYkY7hwPmLpuUBP4Vio36K8cOrE3pzq/LOs/laScq8fYYwDIB
 BOZ/EzJWUYGY2B04ltHZc2XAy0/IgeSd5tKbcq7LZJVP1YMP5V4fx6+QJdH1Q7n6Fu4degA85Ja
 u8rRLSsrbYbntcb69sZhbcRsgaKq3r10iaj0Nn00vIZ+qaEE3kqSqnQMI
X-Gm-Gg: AZuq6aKiXTDxeo4K2O0LMy91x0byc6FOUwrgRyB1o9E+2Hi/GC6E7ZXLp24EX9B5gLx
 SrL9AsWOTQ5OgtT2ViYhFT+fOxegw8Oi8j77Jx5kmDPjk4Hl0BRDvDZADYOcX4afX6hHOo8Yf8/
 SE1J5UIMFlhw8WEH4Mfr+wIgZvlqx0YQu3ArrX9j5OJSLGv3SkR0uKee9PhnSxv811IEgAcQLb6
 PhukPQ0B+jrC2MH/n0oY+3OiCVuMbiFckk2Br5qFvCm0G/Uy0eewzdSxuupI94WXoP48hqpc0uS
 H/Zah1pGwJBOQ6bm3EYNAu0GsToxo2Njogl+beUHMEuRZFA2QLbs/z9/+P7YN1y2og75nJh96rd
 j+G+OX0z8bTAgxJreauY7hkeLIvFMOMc8Y06bwLTXlDxXTg==
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483a95eb550mr111810085e9.3.1771833496734; 
 Sun, 22 Feb 2026 23:58:16 -0800 (PST)
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483a95eb550mr111809845e9.3.1771833496310; 
 Sun, 22 Feb 2026 23:58:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3db3369sm117218165e9.0.2026.02.22.23.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 23:58:15 -0800 (PST)
Date: Mon, 23 Feb 2026 02:58:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PULL 33/33] vhost: fix vhost_inflight_buffer_pre_load
Message-ID: <20260223025742-mutt-send-email-mst@kernel.org>
References: <cover.1771770471.git.mst@redhat.com>
 <72f663f575ab5e0f31320d7c9f25cc1f086313bd.1771770471.git.mst@redhat.com>
 <be650a77-3dbb-4c21-9af6-6b183ee92178@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be650a77-3dbb-4c21-9af6-6b183ee92178@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

On Mon, Feb 23, 2026 at 12:16:46AM +0300, Michael Tokarev wrote:
> On 22.02.2026 17:29, Michael S. Tsirkin wrote:
> > From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > 
> > While I was rebasing my series about inflight migration, I missed a
> > small issue in vhost_inflight_buffer_preload:
> > 
> > * fix wrong return type in function
> > * fix error check
> > 
> > Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > Fixes: tag pls?
> 
> Is this intentional? :)
> 
> /mjt

Ouch (


