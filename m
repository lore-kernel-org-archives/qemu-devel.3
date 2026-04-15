Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA2BF43848
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD2oG-0006e6-T7; Wed, 15 Apr 2026 12:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD2oB-0006dn-E6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD2o8-0000gN-FY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776269376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulvCOl29WMCp8GlnV/P3ng2BBgM4JCg/gb+bOpJAwEs=;
 b=boYiaHv4PZg88SNDe3gRRHQwDEQ/GG1dZRZhs5q04AaaqaGQYs2xJeY7vTw/ApDcYTuGCD
 kCYvR2F49gUHqKlTUVv6Z6hbq5ia+LQM+5PhIleHI6ERx0/KN7NSRMcatr1khkMhM2M4jd
 +VBnDENJXLy7y0doQmMfvmkYCa0tQjA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-hL30l8tXOeuWrmWV9fDUJw-1; Wed, 15 Apr 2026 12:09:34 -0400
X-MC-Unique: hL30l8tXOeuWrmWV9fDUJw-1
X-Mimecast-MFC-AGG-ID: hL30l8tXOeuWrmWV9fDUJw_1776269374
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca6420fe3so20283646d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776269374; x=1776874174; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ulvCOl29WMCp8GlnV/P3ng2BBgM4JCg/gb+bOpJAwEs=;
 b=LMRcpvbsjDIeKLjM5yDScCg1MOo6yFDPMofvy+4G+CtYcp2imDwmWd5gEL6AX8Ee9l
 HPb0PLX3r/YVLZdN6xdWaTSUUPHrKmqMpeph6OUEkWkTMemMqhe2u9j6MbfV/FOghm70
 Qav88KvRjAr/1q1qR6tezQdZVvzEN6zU/kTYDnguy6aOxHZfSpScUv6QpVRz37Cax8Cb
 b656hZ4wZsShQMtaDLzODBiP1wK40RqRSmQ/BN6mbDiDDZ0TJ0OQ5wdChzmFP0/6gnVz
 yu+Z/PMHOMDgafyzsXe0pAiJ+sLaUifpvTFp5bLhLvwj9mTp3Zte4ViDM+oIJJCegN3g
 gFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269374; x=1776874174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulvCOl29WMCp8GlnV/P3ng2BBgM4JCg/gb+bOpJAwEs=;
 b=VbraBOtF8Nw+0QGfSo120852+B9ytm1cQTgh05I1hZahRdvQxtwHWKMvflPFMfuuPR
 G4zgWKF0CirPNjJQk1MF7VmqGVJqfEa5ZcdIwrAnClYng2ktn1xnNV9pKzA517r6MgTD
 rdUOb1rGGJfSCv39W2jCmARUnyvh5OwS3HN9jL4Ho7jlkciH38Qnx4RE7BGsXvTKLSO7
 Fr2Z2qTA9yVXOdAqLApf5yL+XWYWG+UiIbEZZdEqE9a/iiZtahRboAJ6uXn2BttZHhKH
 y3twKEkroh+ZjVrPwKxC9cBxaCV00cDBN0sAIYWRQUFWZV4iG4OeTZ4d5k2H/bxD/+BC
 2TxA==
X-Gm-Message-State: AOJu0Yy4hpHehj3CEWfACr9ZTWjQ3Hkekf3CWzoZnn9LkyEU9kJqRCBX
 H6ZYUxhdF/+MLNAei3pR5B7SN1Fgh25Cr6xtEGG1ykQg3hRGsk/FErNyCPMrceafaQKS1E3OgRU
 SyReb5Y061uaVmlD3w21r5AQ3O1WD6JyOr+l90XucO3MacOxPiPGxQL0b
X-Gm-Gg: AeBDiev7nD1apxUDurYfjBpCSVwE4mthMBmBD/e+ml/it8lt83v9Hah42VtgUEqFkvV
 rSoMz0YiyMKioTZvAdEGILuG7jbM2a+Vs1LVi8/LgnOoF9l2Yow33eCGk+cfZg+59Ya1DtEsGV/
 lEokCBD+Bv+n9lcHq6WpuYoyVJv2xWChSavjHCdVFrdm8g20MpO364H0Do5KFopgFZrvxeHZW2T
 veHnW1Aa0Is7bX1aGysUsAgHQG2wMfHt7H/Y31skJpIjvFF6T3pTLYQ4U7EsYUoxH0/zWyxq3lv
 qbScvyqlOJqjAzRsW5Qio0D6ouy8RbMmyR5o+3b3RNwPGYWfiIl7VVMqG9PJBO6QVHQrUzUfAb5
 ndBj9QZ0kTRLGdDxqcLsAaen/P9+4cP31q0Yz0rIDRJs6JuSJje5y71u7DA==
X-Received: by 2002:a05:6214:470b:b0:8ac:7627:8a71 with SMTP id
 6a1803df08f44-8ac862f51ecmr315961236d6.49.1776269374316; 
 Wed, 15 Apr 2026 09:09:34 -0700 (PDT)
X-Received: by 2002:a05:6214:470b:b0:8ac:7627:8a71 with SMTP id
 6a1803df08f44-8ac862f51ecmr315960576d6.49.1776269373758; 
 Wed, 15 Apr 2026 09:09:33 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c957d24sm14327926d6.12.2026.04.15.09.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:09:32 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:09:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, devel@lists.libvirt.org
Subject: Re: [PATCH 02/14] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Message-ID: <ad-4O8cIvPAcvX6S@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-3-peterx@redhat.com>
 <4ec35a88-d6b8-4bed-b44e-d76cbf80d3b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ec35a88-d6b8-4bed-b44e-d76cbf80d3b3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Apr 10, 2026 at 01:10:51PM +0200, Michal Prívozník wrote:
> Libvirt does not store/care about struct names really (only temporarily
> when 'flattening' output of query-qmp-schema to see if a command has
> certain argument, for instance). So from libvirt's POV:
> 
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Thanks for double checking!

-- 
Peter Xu


