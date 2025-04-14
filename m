Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D04C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HBF-0006hN-IU; Mon, 14 Apr 2025 06:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4HBD-0006gQ-Ic
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4HBB-0005zM-Iu
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744627000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tsKmT5D1KLwyINXO4ebpXEJSISBrNAjWfHn1keC8Xnc=;
 b=VJSaLCKW8pidYm58vE1GS03G8qHjwjUBI6Y6AtBuCD+V6Jx7q/WuEemfF3T9CxVZ9s7BAt
 q7IXfBLs/RhCOIh44IQdeMnYPY16m0EMaoTcCdip2G/wnSNXX8qgt7C1jVymqtofT8TkS3
 z3vNtGdvmRLQvQX/qMGtDqLfBV9Tz1I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-dKZBwNGtNoi58fM8vRFuQg-1; Mon,
 14 Apr 2025 06:36:36 -0400
X-MC-Unique: dKZBwNGtNoi58fM8vRFuQg-1
X-Mimecast-MFC-AGG-ID: dKZBwNGtNoi58fM8vRFuQg_1744626995
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C780418001E2; Mon, 14 Apr 2025 10:36:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDCD91828AAA; Mon, 14 Apr 2025 10:36:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2891F21E66C3; Mon, 14 Apr 2025 12:36:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Cc: qemu-devel@nongnu.org,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  John Snow <jsnow@redhat.com>,  Xie Changlong
 <xiechanglong.d@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Wen Congyang <wencongyang2@huawei.com>
Subject: Re: [PATCH v4] blockdev-backup: Add error handling option for
 copy-before-write jobs
In-Reply-To: <20250414090025.828660-1-Raman.Dzehtsiar@gmail.com> (Raman
 Dzehtsiar's message of "Mon, 14 Apr 2025 11:00:25 +0200")
References: <20250414090025.828660-1-Raman.Dzehtsiar@gmail.com>
Date: Mon, 14 Apr 2025 12:36:31 +0200
Message-ID: <878qo3yqq8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Raman Dzehtsiar <raman.dzehtsiar@gmail.com> writes:

> This patch extends the blockdev-backup QMP command to allow users to specify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the user.
>
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>   the on-source-error policy. This preserves snapshot integrity at the
>   expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>   but invalidates the snapshot and aborts related jobs. This prioritizes
>   guest operation over backup consistency.
>
> This enhancement provides more flexibility for backup operations in different
> environments where requirements for guest availability versus backup
> consistency may vary.
>
> The default behavior remains unchanged to maintain backward compatibility.
>
> Signed-off-by: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


