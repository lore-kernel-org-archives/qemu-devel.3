Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78058CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3iSa-0005cw-R7; Tue, 30 Sep 2025 18:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1v3iSU-0005cU-LM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 18:04:30 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1v3iSK-00058e-R6
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 18:04:28 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1v3iS7-000000002U2-0UX8; Tue, 30 Sep 2025 23:04:07 +0100
Date: Tue, 30 Sep 2025 23:04:07 +0100
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Message-ID: <aNxT1w0BbMH6pJ0J@movementarian.org>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 KHOP_HELO_FCRDNS=0.399, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Sep 30, 2025 at 05:26:59PM +0200, Cédric Le Goater wrote:

> > -        }
> > +        ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
> 
> Could we introduce an helper to test 'unmap_all' support in the host
> kernel ? The result would be something like :
> 
>   if (unmap_all) {
>         if (vfio_legacy_has_unmap_all(VFIO_IOMMU_LEGACY(bcontainer))) {
>             flags = VFIO_DMA_UNMAP_FLAG_ALL;
>         } else {
>             /* The unmap ioctl doesn't accept a full 64-bit span. */
>             Int128 llsize = int128_rshift(int128_2_64(), 1);
>             ...
>         }
>   }

For reference/consideration, the previous approach taken in the vfio-user
series:

https://lore.kernel.org/qemu-devel/20250219144858.266455-4-john.levon@nutanix.com/

@@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
+
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+
+    container->unmap_all_supported = (ret != 0);

(I dropped this particular change as part of getting merged.)

regards
john

