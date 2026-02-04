Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E73E9D3E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndss-0006vm-B9; Wed, 04 Feb 2026 09:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vndsq-0006vJ-4Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vndsm-0004zo-Ql
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770215368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DLsabz/jJd/iMkBPw8Pb+fBIipdyLNk+ngj6Og6K2o=;
 b=FFPxaZF4hJxfV9c5Vm5cLUEk+7m/RO/yTPRh/5uuVt3JR0oOv9Pq9EkTnrhV4a3/lQ8Z3D
 4Z2JAW8TO4MWLC/V1twnSXDom4Mvq8BRMosTmEAigdS/Rcsu1HT0AJeS/3SOwKmCbK+xHN
 k3jX8P8OP4p66YJqjQAgNhBPfDQTd6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-BsLQZPbvM0u55vxS0cvpmg-1; Wed,
 04 Feb 2026 09:29:24 -0500
X-MC-Unique: BsLQZPbvM0u55vxS0cvpmg-1
X-Mimecast-MFC-AGG-ID: BsLQZPbvM0u55vxS0cvpmg_1770215363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A0341956095; Wed,  4 Feb 2026 14:29:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFFBD180035A; Wed,  4 Feb 2026 14:29:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C21E21E692D; Wed, 04 Feb 2026 15:29:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Maor Gottlieb
 <maorg@nvidia.com>
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
In-Reply-To: <af10c110-d2ec-4b92-b33e-7f259c3d7646@nvidia.com> (Avihai Horon's
 message of "Wed, 4 Feb 2026 15:39:21 +0200")
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <87jywswslz.fsf@pond.sub.org> <87ecn0wsif.fsf@pond.sub.org>
 <af10c110-d2ec-4b92-b33e-7f259c3d7646@nvidia.com>
Date: Wed, 04 Feb 2026 15:29:20 +0100
Message-ID: <87bji4vayn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 2/4/2026 3:24 PM, Markus Armbruster wrote:

[...]

>> Except for the subject line: "vfio/migration: Send VFIO_MIGRATION event
>> before PRE_COPY_P2P transition" become misleading in v2.
>
> Can you explain why misleading?
>
> Prior to this patch VFIO_MIGRATION event was sent only after PRE_COPY_P2P transition.
> Now with this patch VFIO_MIGRATION event is sent also before PRE_COPY_P2P transition.

Nevermind, I got confused :)


