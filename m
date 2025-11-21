Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF2CFA46A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 02:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMGWh-0000Pw-SH; Thu, 20 Nov 2025 21:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMGWg-0000PN-4r; Thu, 20 Nov 2025 21:05:30 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMGWe-0006oW-3L; Thu, 20 Nov 2025 21:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Pm4UnpdimlqsbJ4K376o2cJfR1Zky2oPXK2MjIcdLJY=; b=MA2Q9aKaMU1Z17SE
 Jy1K/s9Q2Ui7G0xXYte5iIj7lkeCCWTJlcqzv2legK6cK609mCL7Ok7MYB1Lz09b8y/q2DsX+rTkF
 dHQXIKiI19wjB8DeTNjb+SbaH1zrFUPh1PXNw3GBoZuS9yY8BFPdgr5tJ1U3ixF7i/Tw2tOaxN9si
 FqQmU2Y42S7qsAHDLSwELMBJ2q6MmsOkXA0fdPwwIMASdNHyaT+h0dhMD8C/EGSPU1GHxbITV4cc/
 H3fbq4sEwhBgq4DlXvgpywHAmKtRp6LN3o9vEhODJxZPAg3ASOTdQk06a6GlBHAfIR0sW0jAF8CcS
 ZsEY1K7sjBBktQyQPg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vMGWK-00000005dm0-1euI;
 Fri, 21 Nov 2025 02:05:08 +0000
Date: Fri, 21 Nov 2025 02:05:08 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com,
 alistair.francis@wdc.com, stefanb@linux.vnet.ibm.com,
 kwolf@redhat.com, hreitz@redhat.com, sw@weilnetz.de,
 qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, sgarzare@redhat.com, pbonzini@redhat.com,
 fam@euphon.net, philmd@linaro.org, alex@shazbot.org, clg@redhat.com,
 peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 05/14] hw/scsi: Use error_setg_file_open() for a better
 error message
Message-ID: <aR_I1POkMYcdb1LJ@gallifrey>
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251120191339.756429-6-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 02:04:59 up 25 days,  1:41,  2 users,  load average: 0.04, 0.04, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> The error message changes from
> 
>     vhost-scsi: open vhost char device failed: REASON
> 
> to
> 
>     Could not open '/dev/vhost-scsi': REASON
> 
> I think the exact file name is more useful to know than the file's
> purpose.
> 
> We could put back the "vhost-scsi: " prefix with error_prepend().  Not
> worth the bother.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hw/scsi/vhost-scsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index cdf405b0f8..239138c931 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -245,8 +245,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>      } else {
>          vhostfd = open("/dev/vhost-scsi", O_RDWR);
>          if (vhostfd < 0) {
> -            error_setg(errp, "vhost-scsi: open vhost char device failed: %s",
> -                       strerror(errno));
> +            error_setg_file_open(errp, errno, "/dev/vhost-scsi");
>              return;
>          }
>      }
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

