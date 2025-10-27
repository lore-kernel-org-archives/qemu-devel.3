Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BE0CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ5I-0004Cq-GA; Mon, 27 Oct 2025 05:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ5B-0004BJ-8W
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ56-0002Y5-Q3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761555595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=iT6d7lQ0PNtMH3mGNmGbjXdoDgBqahKr8Z9wzHucv18=;
 b=EgfJ3ZCVljdzfJI2dfXu6SuU022Rp0qsWapZcpvF3lkPda0rZOH1E3HcjOl8xkQT+m4eOS
 CCauqnDq/UQ94BgzRX1LGOwUTRW7Urn7cKtcj7gZfkb2gISGaFlPrtHeQAstxVvF4TNGxx
 pvUPT3J7MQxNfY0hThZhY0PWdIesmrY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-KECqiIZ4M_GmhH2ltbhW8A-1; Mon,
 27 Oct 2025 04:59:53 -0400
X-MC-Unique: KECqiIZ4M_GmhH2ltbhW8A-1
X-Mimecast-MFC-AGG-ID: KECqiIZ4M_GmhH2ltbhW8A_1761555592
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A273518015FA; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2651F195419F; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 577D721E6A27; Mon, 27 Oct 2025 09:59:48 +0100 (CET)
Resent-To: guobin@linux.alibaba.com, qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 27 Oct 2025 09:59:48 +0100
Resent-Message-ID: <87qzuopvnf.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 berrange@redhat.com
Subject: Re: [PATCH v2] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <20251024205532.19883-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Sat, 25 Oct 2025 04:55:32 +0800")
References: <20251024205532.19883-1-guobin@linux.alibaba.com>
Date: Mon, 27 Oct 2025 06:31:00 +0100
Message-ID: <87y0owrjvv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Function migrate_add_blocker will free the reason and set it to NULL
> if failure is returned.
>
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>


