Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA3C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8slN-00036D-Ss; Tue, 22 Sep 2026 01:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x8slL-000362-U9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x8slJ-0003dW-2j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790053786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lySgQTIwlN8yYS4Yr7rj9AXvFidDh1HZ1sZdHYKoR0=;
 b=JTV/V+SyP92pNSa0RHFY4T47Y/rEpsuvQV3gwA5AP4fDJ8+N0eI5SkyQvxXPwaMV1cxFco
 DGI96VF0n2qgP62gfETIsdTCxyd1DebyFgU43ZXqgNt/IPEtlk/2w2XuOZQrDnDeOcTMqT
 2F7TfRrTo871RewL6PpPNqut6s5SdQY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-mo_Ppq1zNyWIsqqwiQiCTA-1; Tue,
 22 Sep 2026 01:09:44 -0400
X-MC-Unique: mo_Ppq1zNyWIsqqwiQiCTA-1
X-Mimecast-MFC-AGG-ID: mo_Ppq1zNyWIsqqwiQiCTA_1790053783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73591180063A; Tue, 22 Sep 2026 05:09:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4C30418; Tue, 22 Sep 2026 05:09:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42A4821E6A04; Tue, 22 Sep 2026 07:09:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  pbonzini@redhat.com
Subject: Re: [PATCH] kvm: turn fprintf into error_report
In-Reply-To: <20260921164442.1137615-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 21 Sep 2026 19:44:42 +0300")
References: <20260921164442.1137615-1-vsementsov@yandex-team.ru>
Date: Tue, 22 Sep 2026 07:09:40 +0200
Message-ID: <87a4p998iz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Quick drive-by comments...

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Main benefit: ability to print timestamps.

Possible additional benefits:

* Ability to print guest name

* Print program name

* "This is an error" is obvious even at a glance

Benefits not applicable here (I believe):

* Print location if we have one

* Automatic redirection to the human monitor when appropriate

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  accel/kvm/kvm-all.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 33 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 83cbd120a84..d271699db87 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -300,7 +300,7 @@ static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
       KVMSlot *slot = kvm_get_free_slot(kml);

       if (slot) {
>          return slot;
>      }
>  
> -    fprintf(stderr, "%s: no free slot available\n", __func__);
> +    error_report("%s: no free slot available", __func__);
>      abort();
>  }
>  

Bah, too much ceremony for me.  I'd do

       KVMSlot *slot = kvm_get_free_slot(kml);

       assert(slot);
       return slot;

The "print something to help developers fix the programming error;
abort()" pattern leads to having __func__ in error messages, which is
normally an anti-pattern, because error messages are for users.

But all that is outside the scope of your patch, and the maintainers may
have other ideas anyway.

[...]


