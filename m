Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7D0C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4crF-0008Il-C5; Thu, 10 Sep 2026 07:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4crE-0008Ic-6d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4crC-0003pa-Rr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789039338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OY7fh5++oMJ8nrGSu3yPFirpAqJUi4kHRznRcnXKd6o=;
 b=KJLnaRzq4i7n+dPR8V1JnFWpLGUgBAhwNviB0g9U0/2KrTGOyNJzclyY9pvn64YRYYtpN7
 RSO67FSyzMwp6UV/cig6BS+gWKN6DVbasdhAEM6nemjsKt9ljNTEE5Iku3Arw7EU3I/JLG
 MgELXg/QVBebOcrggwa2DiywNK3y/Jo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-wV4osH_8NZawsSVfpfFemA-1; Thu,
 10 Sep 2026 07:22:14 -0400
X-MC-Unique: wV4osH_8NZawsSVfpfFemA-1
X-Mimecast-MFC-AGG-ID: wV4osH_8NZawsSVfpfFemA_1789039334
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B74A51954197; Thu, 10 Sep 2026 11:22:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C021418; Thu, 10 Sep 2026 11:22:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 006F421E6A04; Thu, 10 Sep 2026 13:22:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 16/18] migration: Add capabilities into
 MigrationParameters
In-Reply-To: <20260909214509.237309-17-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 9 Sep 2026 18:45:06 -0300")
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-17-farosas@suse.de>
Date: Thu, 10 Sep 2026 13:22:10 +0200
Message-ID: <874ifxe4gt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Add capabilities to MigrationParameters. This structure will hold all
> migration options. Capabilities will go away in the next patch.
>
> From this point on, both QMP and HMP versions of
> migrate-set-parameters and query-migrate-parameters gain the ability
> to work with capabilities.
>
> With MigrationParameters now having members for each capability, the
> migration capabilities commands (query-migrate-capabilities,
> migrate-set-capabilities) will soon be deprecated. Add a set of
> helpers to convert between the old MigrationCapability representation
> and the new representation as members of MigrationParameters.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


