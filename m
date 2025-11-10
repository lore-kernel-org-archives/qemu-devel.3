Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10196CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIOys-0003zO-0l; Mon, 10 Nov 2025 05:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOq1-0007yf-Uu
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOpx-00075K-CQ
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762769364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzIZFScxOkKRWl6UBEV7RUJRh5Q/TM6LWq77fcmTvcI=;
 b=H2/GUmGwKlRqXAss0fgQStnIkGbT6Vec01ehYE3R0rjUOm9j106nleBoSboIppCmQ2NFs2
 2uObEI5k8kaIPyWCf3tTL5WVHhM0gk2cv7/6Y2ilURCMvC+1wBBIgsw44j48EKuhdmJ9X0
 kOOA8HWIZcsHvgomTR6sFB9GX9trgv8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-juGQq_o4OoSblzNHxIvBxA-1; Mon,
 10 Nov 2025 05:09:18 -0500
X-MC-Unique: juGQq_o4OoSblzNHxIvBxA-1
X-Mimecast-MFC-AGG-ID: juGQq_o4OoSblzNHxIvBxA_1762769357
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63246180047F; Mon, 10 Nov 2025 10:09:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D86A719560BA; Mon, 10 Nov 2025 10:09:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27C2421E6A27; Mon, 10 Nov 2025 11:09:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  kwolf@redhat.com,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
In-Reply-To: <20251107145327.539481-3-chigot@adacore.com> (=?utf-8?Q?=22Cl?=
 =?utf-8?Q?=C3=A9ment?= Chigot"'s
 message of "Fri, 7 Nov 2025 15:53:24 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-3-chigot@adacore.com>
Date: Mon, 10 Nov 2025 11:09:14 +0100
Message-ID: <874ir2nqr9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

> This allows to handle the default FAT size in a single place and make the
> following part taking care only about size parameters. It will be later
> moved away in a specific function.
>
> The selection of floppy size was a bit unusual:
>  - fat-type undefined: a FAT 12 2880 Kib disk (default)
>  - fat-type=3D16: a FAT 16 2880 Kib disk
>  - fat-type=3D12: a FAT 12 1440 Kib disk
>
> Now, that fat-type undefined means fat-type=3D12, it's no longer possible
> to make that size distinction. Therefore, it's being changed for the
> following:
>  - fat-type=3D12: a FAT 12 1440 Kib disk (default)
>  - fat-type=3D16: a FAT 16 2880 Kib dis
>
> This has been choosen for two reasons: keep fat-type=3D12 the default and
> creates a more usual size for it: 1440 Kib.
>
> The possibility to create a FAT 12 2880 Kib floppy will be added back
> later, through the fat-size parameter.
>
> Side note to mention that s->sectors_per_cluster assignments are
> removed because they are overidden a few line further.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

Is this a user-visible change?


