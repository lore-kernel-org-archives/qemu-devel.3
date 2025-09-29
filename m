Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37283CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GGz-0003kt-1O; Mon, 29 Sep 2025 11:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GGm-0003cm-Ix
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GGi-0002QO-3G
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVBwHdyMoSuqADJCUP/Sjz/GPAPj0aKz0ieGI8fQacY=;
 b=DruOA8K5nvwGIfb1jbR3GuSeo9/kf8/gHuz1xEoycIu6sywgJ1dT7LOauJ56BtZE9BvbVB
 H2MRhYh+rkN28pQ0pAmRh1kOuF8tzxkMYn1JToWeWnNJ1clUUwEnuW79NJLn5G25qRpT8v
 leLeZ3DTChq1d1t0iEru67XTxQ6/EiU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-f8fReCDcPWqemvRzRCSUiQ-1; Mon, 29 Sep 2025 11:58:24 -0400
X-MC-Unique: f8fReCDcPWqemvRzRCSUiQ-1
X-Mimecast-MFC-AGG-ID: f8fReCDcPWqemvRzRCSUiQ_1759161504
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-85a0492b5feso1502473285a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161504; x=1759766304;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVBwHdyMoSuqADJCUP/Sjz/GPAPj0aKz0ieGI8fQacY=;
 b=fT1PEao+hgPdA21hxKUOrqc6JUSCaPOs87Aip0maTZmDHPIror+cbmz3wptgNYHPzV
 A+GikBwscUVOVl4ARaZkV5Pegh785Mx2MIYvd1psHlfI2KMe24skZ3AHiiG330UrBd5q
 ac5OYUm8rqbzT9f7V4a6Y3Que6Y+VlU+JzBKv0h9VDG9Gl6N2h9lz8u4t/ORhiUc9yXg
 zGZ8oFrKBkbJ4OIznUTVDFXqLqRkP3E21bO6WjzUbC82z+76qMQXHhowlUUAopXc0RDm
 lEHrH+D7JPiB0G8ghgbfo5GHa+Off57wpzWf36C205dpVxhz8o8gCTEJPK6FRPWZGkac
 Awbg==
X-Gm-Message-State: AOJu0YwVN1jSMnHuhdKTwJTW1FnGBJqmndNx4KMTHUKyI9MtC6cRUcuu
 H9DBmn2q9qbcVBmOlmMVjIbwO0iPX2FgEHxl/2QNTrZj9uEe5E3u42bijA6J/wNHIEQwZ7yHxIs
 75PhCI4dyKtiwXnYFw8IFfyCmLmFG+LXA38jiAK49f1yWN4okNa5WGU6v
X-Gm-Gg: ASbGnctK9/qNKej1UTUDxE9RHqTGbDBayDMoRYTmZPIo/ldkp3R/Ma0MN8AI0IMXiko
 cYzNGltRcEx9+hdu3uuNLWCBY/uBFhXlmHrWP4nREnOyxOf4g7mpBv0tseaYbaspCFtLd8B7bxe
 R8yvXrbw/JoFLOnP4vowJEJA+Z6RkDltfPsjBp+Jpi9AgNtCwIOQSyUFio77TeM9BEcpKfq1+0x
 HrPVi6srFJngTjSshBIvP32OMxBzIm9v303pGGkCXMM8asl2Uq2BSRvVgFMCx5si62d/gxtI18J
 jckXX527OFSGViZ4cILU2dYONQzBEljg
X-Received: by 2002:a05:6214:2a8d:b0:78f:1312:2d94 with SMTP id
 6a1803df08f44-7fc4066ec7dmr255365266d6.56.1759161503642; 
 Mon, 29 Sep 2025 08:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8X87U/CO2zsunwAypdrtx1xbVRVTh/ZFoJjAalFB3fZQJXTfWx9GAJOv/hHNG5jVThk2cHg==
X-Received: by 2002:a05:6214:2a8d:b0:78f:1312:2d94 with SMTP id
 6a1803df08f44-7fc4066ec7dmr255365036d6.56.1759161503210; 
 Mon, 29 Sep 2025 08:58:23 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80135b54636sm78407866d6.6.2025.09.29.08.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:58:22 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:58:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <aNqsnaBkQe8i_MLK@x1.local>
References: <20250801170212.54409-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801170212.54409-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 01, 2025 at 06:02:10PM +0100, Daniel P. Berrangé wrote:
> This is a followup to previously merged patches that claimed to
> workaround the gnutls bug impacting migration, but in fact were
> essentially non-functional. Juraj Marcin pointed this out, and
> this new patch tweaks the workaround to make it actually do
> something useful.
> 
> Daniel P. Berrangé (2):
>   migration: simplify error reporting after channel read
>   migration: fix workaround for gnutls thread safety
> 
>  crypto/tlssession.c   | 16 ----------------
>  migration/qemu-file.c | 22 +++++++++++++++++-----
>  2 files changed, 17 insertions(+), 21 deletions(-)

Dan, is there a planned repost on this one?

Thanks!

-- 
Peter Xu


