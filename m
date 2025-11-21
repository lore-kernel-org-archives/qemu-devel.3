Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C9FCFA45F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 00:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMEkB-0008D3-LZ; Thu, 20 Nov 2025 19:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMEjb-0007ls-Sj; Thu, 20 Nov 2025 19:10:56 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMEjU-0003WD-AL; Thu, 20 Nov 2025 19:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=4YAcbiarbzQHvhEzZ63n6RkH46R+BEUGak5gqn7DS+0=; b=ilbUYMN0rKRC6nJC
 AjVUwVMVW7944N9SN4N3h+IDCtzr87WMNXUIjULXle6L7f2jIHRXFfSFJOhAvPsDh+Z0MgdXaqFzH
 xtlyavuW6OwPf2BO03CsvX0Ryu0GPXNoJeLboZkxtZVm6GJSOHN/CzhKQQpMqsdK6HpavN34jWfZZ
 Kt1+prB3CLGVGdrqi5ZXeOePqoNkHL74MhrVFb1qWAECOoiXvaAqik3S9zDCGG3ogy18MMD4PBfRk
 VNgLVDGImyGZWGiBa95qzFc+pyTfzMMKtajdwOWnCMLk2vMLrIgLH4H3PxDBorM9KvZw7GDP0Hojb
 9PgYJe97XoKoacFcHw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vMEj7-00000005csx-0Lk8;
 Fri, 21 Nov 2025 00:10:13 +0000
Date: Fri, 21 Nov 2025 00:10:13 +0000
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
Subject: Re: [PATCH 11/14] error: Use error_setg_errno() to improve error
 messages
Message-ID: <aR-t5SzR2AdqlJtq@gallifrey>
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-12-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251120191339.756429-12-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:09:12 up 24 days, 23:45,  2 users,  load average: 0.03, 0.03, 0.00
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
> A few error messages show numeric errno codes.  Use error_setg_errno()
> to show human-readable text instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

...

> diff --git a/migration/rdma.c b/migration/rdma.c
> index 337b415889..ef4885ef5f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2349,8 +2349,7 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
>          error_setg(errp, "RDMA ERROR: poll cm event timeout");
>          return -1;
>      } else if (ret < 0) {
> -        error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
> -                   errno);
> +        error_setg_errno(errp, "RDMA ERROR: failed to poll cm event");

Hasn't that lost the errno ?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

