Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF3CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 04:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20OU-0006Ef-SV; Fri, 26 Sep 2025 00:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v20OS-0006EF-Dd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v20OJ-0001RH-4m
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758862132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1MvyDWQGXlJS9Ycm9tC9PpbnVI0Qh3rhecS0NAX+nes=;
 b=V4RJyv4VHW0+FUZq5RUVV7PfOuGh/NxcuiiVTkyOoX1JSuZ9RnlgcrV84XEu0DwnCn7BP4
 54rkRjYvzyxO7MXuYDxJvWdgizJm1z+fixRhKPYzKSZyvP3MGnoxtTnYXlbnb6qFII7qfI
 WSaktKA7mrMW44QLxj+xEjN4VTg7QO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-oWSBxTZbNqCTo_T3xO4WnQ-1; Fri,
 26 Sep 2025 00:48:48 -0400
X-MC-Unique: oWSBxTZbNqCTo_T3xO4WnQ-1
X-Mimecast-MFC-AGG-ID: oWSBxTZbNqCTo_T3xO4WnQ_1758862128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7A0018004D8; Fri, 26 Sep 2025 04:48:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6329C1800579; Fri, 26 Sep 2025 04:48:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 600D921E6A27; Fri, 26 Sep 2025 06:48:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,  clg@redhat.com,
 eric.auger@redhat.com,  steven.sistare@oracle.com
Subject: Re: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
In-Reply-To: <20250926022540.1884023-1-zhenzhong.duan@intel.com> (Zhenzhong
 Duan's message of "Thu, 25 Sep 2025 22:25:40 -0400")
References: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
Date: Fri, 26 Sep 2025 06:48:44 +0200
Message-ID: <87v7l5stsj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Zhenzhong Duan <zhenzhong.duan@intel.com> writes:

> After CPR transfer, source QEMU close kvm fd and free kvm_state,
> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
> pointer reference.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  accel/kvm/kvm-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9060599cd7..a3e2d11763 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3479,7 +3479,7 @@ int kvm_device_access(int fd, int group, uint64_t attr,
>  
>  bool kvm_has_sync_mmu(void)
>  {
> -    return kvm_state->sync_mmu;
> +    return kvm_state && kvm_state->sync_mmu;
>  }
>  
>  int kvm_has_vcpu_events(void)

This dereference could signify there's a general assumption *kvm_state
is valid, i.e. there might be more dereferences hiding in the code.

Have you checked?

Is freeing @kvm_state after CPR transfer useful?


