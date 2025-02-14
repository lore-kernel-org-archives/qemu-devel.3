Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ECDC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tix51-00020s-LY; Fri, 14 Feb 2025 09:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tix4z-00020Z-3e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tix4w-0002sU-Cn
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739544844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8dtUmpO+l64Vl5bfrV8sH9FtS34C7jLGXYft8zD5pM=;
 b=cXd8w5juRCLBqSrH5ekVcJ6tFHXa2OvJLZqvDXqflPxCj72NR9fZRlXH1VfeI7AF3hrhS3
 5k0vbBO7wmgcU1BkgGnuvg3Vp6HljGyjzLDp1SWuKzpMO55LFo2/AT+4DeIpnadLnmd+CK
 opm7RE6zzhnrEl4MWkyY6wYkYPChRhA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-WVNlj66iM0eZ_x6G_60Ecw-1; Fri, 14 Feb 2025 09:54:03 -0500
X-MC-Unique: WVNlj66iM0eZ_x6G_60Ecw-1
X-Mimecast-MFC-AGG-ID: WVNlj66iM0eZ_x6G_60Ecw_1739544843
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c07bba1575so437119185a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739544843; x=1740149643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8dtUmpO+l64Vl5bfrV8sH9FtS34C7jLGXYft8zD5pM=;
 b=ksH6Ytjfq2FzehbZe2NvafBt+kJSgfzHq9PVwkDecs140RUVOOaMi7Ud40gKk2N1xy
 6Zx6neZiZH5MNy4zm8kbCRT1i3ORNSp3bTWlTnAY6+i9f1cLLFtM3WLwI+tBcznAOLZe
 flQe+eCuGqKvsD1W+GmfT5mERzbIM1DtxaKOkb9MsrdbDKmtH0cE1+pCOMW/APSQLr7x
 1w36lUVbQBtUlZu8PUxAuaP44V0+mbw7PP+2NDYAklTgsfnA7gfFU4I5NvY/kEd2nQak
 VlIgn4U1zsWy+eQBBiin7nY74Mz6ItOLyjm4YWCEilpW4TQWuZCG1LH7zqJFIFXzW/HZ
 RScw==
X-Gm-Message-State: AOJu0Yzss7L8suCf0M82JYxHZvdQwcIoi3DgCA01bmY7ImS4+CV72HH5
 e7oB8lDc/znRxOTwA9d1+dECeLCcNsJ9lhOjumk79t10X7rZX3g5ipW3dKPIpFQomsLVEx2mjn0
 MyWvaOw+Gv+P8+apY3R3oExSEovvIlxjWMoxUuwQ3X0Kayo9FR2xm
X-Gm-Gg: ASbGnct4RK9GGI2Lzx7MPeL5vIe4c91ATRf7WHJZLrm8XiKWJLbO448Y7EqgFeRi2W0
 pkCjte2LYGpNwvgN9uktEmtr/K9zz2qg5BpPIQRPnydc7Up/n45mNq4E0wxjTjJC2JSWyvUkfkG
 ba8opYHU/wYJvJ+Kb8Ba7RsE2NA/pH/XkFiTaRAD6xioOexzqH9ZpGVUe/uMLG2VSsGQZ2wem0m
 gPCjEKIysvnctbns9b5rx0bX0OnAU/o4tveJpUedO/zLKRldBVkzSUAUGo=
X-Received: by 2002:a05:620a:86cc:b0:7c0:7725:6b02 with SMTP id
 af79cd13be357-7c07a11284fmr1172602985a.4.1739544842529; 
 Fri, 14 Feb 2025 06:54:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe05M5KG15zFibULx7B7RjHgXlQVEB9ApD/E4b6L8NrEneLXo95ulLNqmA+BzzaVY0ynfqLw==
X-Received: by 2002:a05:620a:86cc:b0:7c0:7725:6b02 with SMTP id
 af79cd13be357-7c07a11284fmr1172599785a.4.1739544842155; 
 Fri, 14 Feb 2025 06:54:02 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c07c6173ecsm212533285a.59.2025.02.14.06.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:54:01 -0800 (PST)
Date: Fri, 14 Feb 2025 09:53:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 01/45] MAINTAINERS: Add reviewer for CPR
Message-ID: <Z69ZBonqKbEh3ejA@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1739542467-226739-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 14, 2025 at 06:13:43AM -0800, Steve Sistare wrote:
> CPR is integrated with live migration, and has the same maintainers.
> But, add a CPR section to add a reviewer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3848d37..2f9a6da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2951,6 +2951,17 @@ F: include/qemu/co-shared-resource.h
>  T: git https://gitlab.com/jsnow/qemu.git jobs
>  T: git https://gitlab.com/vsementsov/qemu.git block
>  
> +CheckPoint and Restart (CPR)
> +M: Peter Xu <peterx@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>
> +R: Steve Sistare <steven.sistare@oracle.com>
> +S: Supported
> +F: hw/vfio/cpr*
> +F: include/migration/cpr.h
> +F: migration/cpr*
> +F: tests/qtest/migration/cpr*
> +F: docs/devel/migration/CPR.rst

All above files are covered by either migration or vfio.

If the plan is to have CPR being part of existing subsystems, IMHO we could
drop the M: entries here but keep R: only.  Or, make one M: entry for
yourself.

With that, IIUC anyone using get_maintainers.pl will always get the right
people to copy: it goes to VFIO if it's under the 1st entry (hw/vfio/cpr*),
or it goes to migration if it's the rest four entries.  Meanwhile, if any
of above is touched you'll get copied too.

> +
>  Compute Express Link
>  M: Jonathan Cameron <jonathan.cameron@huawei.com>
>  R: Fan Ni <fan.ni@samsung.com>
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


