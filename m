Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B0DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 11:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCFm6-0007Xf-A7; Fri, 24 Oct 2025 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCFlx-0007Wd-97
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCFls-0002EM-GS
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761304546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O3ZKRHnJqmFYanSwlrlrOpC8RL1X+H/82RQv2u2herE=;
 b=JvSaRd1JQQXqUfBco57JflGbqCPZX0vvdSUc7UNk1zIgSmSdSISo7sbVDQz36fqZwrXP0p
 m20xZuc9vK521beABkd0H5tcl60zWW2I8fib0yBKRd313NmFNBxLRMC439ynz0DQRxv8qH
 aVt9/I68BkiWnqlgb1dV7qBcXXdjLqA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Hz2N3ZyENdaS6JGgdlBFHA-1; Fri,
 24 Oct 2025 07:15:44 -0400
X-MC-Unique: Hz2N3ZyENdaS6JGgdlBFHA-1
X-Mimecast-MFC-AGG-ID: Hz2N3ZyENdaS6JGgdlBFHA_1761304543
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7811E1800669; Fri, 24 Oct 2025 11:15:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EED3230002D7; Fri, 24 Oct 2025 11:15:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1679D21E6A27; Fri, 24 Oct 2025 13:15:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <20251024092821.82220-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Fri, 24 Oct 2025 17:28:21 +0800")
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
Date: Fri, 24 Oct 2025 13:15:40 +0200
Message-ID: <87o6pw1rfn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 1 -
>  target/i386/sev.c       | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 66b0dddfd4..6f311e37ef 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>          error_setg(&kvm_nv_migration_blocker,
>                     "Live migration disabled because KVM nested virt is enabled");
>          if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
> -            error_free(kvm_nv_migration_blocker);
>              return;
>          }
>  
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 1057b8ab2c..fd2dada013 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>      ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
> -        error_free(sev_mig_blocker);
>          exit(1);
>      }
>  }

Does this fix use-after-free bugs?


