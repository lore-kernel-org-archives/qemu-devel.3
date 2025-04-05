Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51490C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 07:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0xiV-0004gm-RN; Sat, 05 Apr 2025 03:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0xiT-0004gA-OM
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 03:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0xiR-000777-QO
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743837198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rstgrELxYyElqAoSSHyShtttwFGek3lDaStWFEj2k+o=;
 b=fYWFm50K6czv+MRcndKzSAh8jbBABLGxeoKyj84OcnnneztsdV9DJpHFSyW+26emGiWgd7
 hSsYH8sN1+rpEb41RCDim1XUb4UShMtuu/tSUMak1sjY+UkVW0HAJWgQRMtnGaKdHySILx
 3xG/tPYHxbu61w8B61otZD/U2pOKZVQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-OwERqI3lO4SJvBWUI5Nm3g-1; Sat,
 05 Apr 2025 03:13:12 -0400
X-MC-Unique: OwERqI3lO4SJvBWUI5Nm3g-1
X-Mimecast-MFC-AGG-ID: OwERqI3lO4SJvBWUI5Nm3g_1743837191
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5A31956089; Sat,  5 Apr 2025 07:13:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DC643001D0E; Sat,  5 Apr 2025 07:13:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73AF421E6773; Sat, 05 Apr 2025 09:13:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  eblake@redhat.com,  jsnow@redhat.com,
 devel@lists.libvirt.org,  pkrempa@redhat.com,  michael.roth@amd.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
In-Reply-To: <184192da-6f38-4c7b-926e-ad5a42482a64@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 4 Apr 2025 18:03:13 +0300")
References: <20250401155730.103718-1-vsementsov@yandex-team.ru>
 <8734eosb14.fsf@pond.sub.org>
 <638e4d21-6440-47e7-9ad5-ac44b0c03cb0@yandex-team.ru>
 <87ecy8nhfo.fsf@pond.sub.org>
 <184192da-6f38-4c7b-926e-ad5a42482a64@yandex-team.ru>
Date: Sat, 05 Apr 2025 09:13:04 +0200
Message-ID: <875xjjhyin.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 04.04.25 17:13, Markus Armbruster wrote:

[...]

>> So, auto-finalize=true is silently ignored when another job in the same
>> transaction has auto-finalize=false?
>
> Yes, at least, it looks like so:
>
> static void job_completed_txn_success_locked(Job *job)
> {
>
> [...]
>
>      /* If no jobs need manual finalization, automatically do so */
>      if (job_txn_apply_locked(job, job_needs_finalize_locked) == 0) {
>          job_do_finalize_locked(job);
>      }
> }

Silently ignoring what the user specified is not okay whether the user's
instructions make sense or not.

Fixing this UI bug would break usage that relies on it.  Should we care?

[...]


