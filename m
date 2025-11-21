Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B3FCFA454
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 00:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMEx7-0006JL-U6; Thu, 20 Nov 2025 19:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMEwv-0006EH-6j; Thu, 20 Nov 2025 19:24:29 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMEwt-0006Qy-2t; Thu, 20 Nov 2025 19:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=KXXaKr3PtFYh8nhHwgchIQAJ3u9wYBNIFydgNDU6Wo4=; b=eynA8kSmvhNEEgT9
 y0JKtg7iv1DeFQTCEwqE9seSwcVA1Xi7+YLa4mjuKStD0NXdu5S7jQHRij5Rtl9JTltmG+TsTC9Qx
 lOfNhVdI53+2SguooVed7NpK4gfR+2vbhtKFwSkttQDsraFmllf8Mt/0vctal58hWk1BxvQyIuHeu
 yCB3kkv3ZI/sZzZy5wcSXhbCuEAwhWxv94eXCJZ1AjXbelxxGWUGT0Ws5Eu3/gJ8ZSKS1ivDgyD9k
 L2BibqN6dzoj/ed6KSGgmPDpg4ESeaqhl/QfEgTk1Lxhf5r5xJzPuFDmoYjnS5h7I+ddk+xbmKbfj
 WwRB4DRNuEnYvwwalw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vMEwY-00000005d06-2W0z;
 Fri, 21 Nov 2025 00:24:06 +0000
Date: Fri, 21 Nov 2025 00:24:06 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
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
Subject: Re: [PATCH 03/14] tap-solaris: Use error_setg_file_open() for better
 error messages
Message-ID: <aR-xJgDErvQaN600@gallifrey>
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251120191339.756429-4-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:23:09 up 24 days, 23:59,  2 users,  load average: 0.00, 0.00, 0.00
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
> Error messages change from
> 
>     Can't open /dev/ip (actually /dev/udp)
>     Can't open /dev/tap
>     Can't open /dev/tap (2)
> 
> to
> 
>     Could not open '/dev/udp': REASON
>     Could not open '/dev/tap': REASON
> 
> where REASON is the value of strerror(errno).

I guess the new macro has a __LINE__ so the (2) is redundant.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  net/tap-solaris.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 75397e6c54..faf7922ea8 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -87,13 +87,13 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
>  
>      ip_fd = RETRY_ON_EINTR(open("/dev/udp", O_RDWR, 0));
>      if (ip_fd < 0) {
> -        error_setg(errp, "Can't open /dev/ip (actually /dev/udp)");
> +        error_setg_file_open(errp, errno, "/dev/udp");
>          return -1;
>      }
>  
>      tap_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
>      if (tap_fd < 0) {
> -        error_setg(errp, "Can't open /dev/tap");
> +        error_setg_file_open(errp, errno, "/dev/tap");
>          return -1;
>      }
>  
> @@ -107,7 +107,7 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
>  
>      if_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
>      if (if_fd < 0) {
> -        error_setg(errp, "Can't open /dev/tap (2)");
> +        error_setg_file_open(errp, errno, "/dev/tap");
>          return -1;
>      }
>      if(ioctl(if_fd, I_PUSH, "ip") < 0){
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

