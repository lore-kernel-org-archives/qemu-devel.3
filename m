Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B35CFA464
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 00:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMFGI-0004GD-JY; Thu, 20 Nov 2025 19:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMFF6-0003x9-DU; Thu, 20 Nov 2025 19:43:17 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMFF4-0000uD-EU; Thu, 20 Nov 2025 19:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=2lQMqxTn4BDPqEuJHUsXNxZ6n7/HofNAtadPoRD5+7A=; b=Qf7O3sUMLMEvDppF
 qQS46KXVaYPyHAaU1CV6kQ3Zac1Bsl979tFpEKhucfRVImUbbRbQAkvH/J6e1RkwbIJ9ER9wzz6QN
 RH8AcCtZaVM3MsUhggZi8wPrN5NFCfg0uNr7O160etRomxsSa0Jh4M+pvJIiG63p3ncXU94kqOzWr
 jXgZWgi/P/gswYRUiVLOtFw1NDiXKw1dgi42YCoknL0Gp2dYCm6LqmlqsV+qycQ6UsUfNDqp1LmBX
 pkhtExl893Wi0Ca9f3caRkQI/N2V6wf2WvNWVwxV9VtNbVMCeGGp26Nsw/jhOgF1sZTbaeYLH0Stz
 GqEA+p/C4lktH6mnRg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vMFEi-00000005d8M-37pF;
 Fri, 21 Nov 2025 00:42:52 +0000
Date: Fri, 21 Nov 2025 00:42:52 +0000
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
Subject: Re: [PATCH 02/14] hw/usb: Use error_setg_file_open() for a better
 error message
Message-ID: <aR-1jGX4Ck0f69zG@gallifrey>
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251120191339.756429-3-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:41:22 up 25 days, 17 min,  2 users,  load average: 0.01, 0.02,
 0.00
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
>     open FILENAME failed
> 
> to
> 
>     Could not open 'FILENAME': REASON
> 
> where REASON is the value of strerror(errno).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/usb/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 8dd2ce415e..47d42ca3c1 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -262,7 +262,7 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
>          int fd = qemu_open_old(dev->pcap_filename,
>                                 O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
>          if (fd < 0) {
> -            error_setg(errp, "open %s failed", dev->pcap_filename);
> +            error_setg_file_open(errp, errno, dev->pcap_filename);

Wouldn't it be easier to flip it to use qemu_open() ?

Dave

>              usb_qdev_unrealize(qdev);
>              return;
>          }
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

