Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D2ECD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0fi-00069n-2F; Fri, 29 May 2026 13:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com>)
 id 1wT0fe-000691-Af; Fri, 29 May 2026 13:06:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com>)
 id 1wT0fc-0005xS-Fw; Fri, 29 May 2026 13:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=OeTNPJ9dz1ZMwlYLlec4HJGEJb8H/2hwVEpssfkaEII=; b=JwIWn
 JuhRQOWOypE9+DHoirfgiST0Jgt9kk6/IGob16J2UEn5FkkpM+DeB5J4kosrsImZW/OI/mRFf2xVu
 pCoA3OV0343Go7uvL5RG1WWSMdhV5DdgvN1J3UZt8U5ps0FbP1HjMRQ9FKADuOjKkPYqWqOf0TS32
 ITchuXOOVou8eDvT2Bl78VU7XvNd7FV15/b6uCyfkX9gVSMHbORJljG4b8yqYjThAkQuSTE8MiwGC
 pg5mawv7N0h94FalWsi7wntFAvmyu1jO9lNuDQJ9DSKhnXd6cSjGe53nULY0xXsxM66VWXuDiHXdT
 RG4wgFXYUOAfF585nfmRFhR818fct9tiJ+XwL4CEzCLAU/T8AwUsctK+DWmPw6trX5DKEurpcCa9f
 98ti2GZDWbr5cwGvj0rMHAdA0GWcnUSyyxENDF9sZTX2Uc/yGJi+uJIN6qRLVt9MZhANM6ZyXThwX
 N8bV74Dj6Gfo84PyTLtzqyqlRWyBcVIYY4U+VrFAv2Hm585orJj3N08aaAzrdqu5TtU9joXfx/YVZ
 7toUu4zc6qljgXlpgwb7c6c04se0ooOOjQyhd5L5FRw2CnawV/zBn8f9R/EfgBNX61hzdmRSBJJOC
 F8dkBkfyckJYlRnwdKMoA1D442BNtVOwcAk6eRD8bjR3hRbrOlJoG00NUgbGkY=;
Message-ID: <cover.1780072238.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 29 May 2026 18:30:38 +0200
Subject: [PATCH 0/3] 9pfs: fix illegal names with Twstat rename
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This series fixes a guest-triggerable assertion fault (DoS) caused by
sending an illegal new name with the legacy Twstat rename handler.

 - Patch 1: This is the core fix that prevents the DoS vulnerability.

 - Patch 2: Additionally rejects "." and ".." as new names with Twstat
   rename operations (not being a vulnerability though).

 - Patch 3: Consolidates the name validation logic spread multiple
   times over multiple request handlers.

Christian Schoenebeck (3):
  hw/9pfs: fix abort due to illegal name with Twstat rename
  hw/9pfs: reject . and .. in Twstat rename
  hw/9pfs: consolidate name validation with check_name()

 hw/9pfs/9p.c | 97 +++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

-- 
2.47.3

