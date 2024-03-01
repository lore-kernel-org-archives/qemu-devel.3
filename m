Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07243C54E49
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvtz-0004zA-Dm; Fri, 01 Mar 2024 00:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfvtr-0004yE-T7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfvtq-0000DK-AN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709272657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xDThWh+nhhC0KTBykXU3Q9xLIzciMah8Nn9TNjTXWaY=;
 b=cEOyFYrUYeuPBBK9FXlU1R1qyOlIp0ZFW6PwsXmB8Raz7c0Lt5v/Rv85sJSONPlzh80N1l
 YbF3KG2HC3gjS7dM7WD68DpLArUevPM38RqJMusXlnMCoNkNxFHOdSJ2blTf13Jod/jteB
 4jbx6fwHH6prBsud6PVpmcxxgZSCJy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-llnnHHieNCSCYCJ9QyCQOA-1; Fri,
 01 Mar 2024 00:57:34 -0500
X-MC-Unique: llnnHHieNCSCYCJ9QyCQOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B79B52825BB3;
 Fri,  1 Mar 2024 05:57:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 926FD4D903;
 Fri,  1 Mar 2024 05:57:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 848AB21E6743; Fri,  1 Mar 2024 06:57:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH V2] migration: massage cpr-reboot documentation
In-Reply-To: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 29 Feb 2024 06:54:22 -0800")
References: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
Date: Fri, 01 Mar 2024 06:57:32 +0100
Message-ID: <87edcusddf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
> cpr-reboot references, capitalize COLO and VFIO, and tweak the
> wording.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c6bfe2e..c86113b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -636,28 +636,30 @@
>  #
>  # @normal: the original form of migration. (since 8.2)
>  #
> -# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
> -#     After quitting qemu, the user resumes by running qemu -incoming.
> +# @cpr-reboot: The migrate command stops the VM and saves state to
> +#     the URI.  After quitting qemu, the user resumes by running
> +#     qemu -incoming.
>  #
> -#     This mode allows the user to quit qemu, and restart an updated version
> -#     of qemu.  The user may even update and reboot the OS before restarting,
> -#     as long as the URI persists across a reboot.
> +#     This mode allows the user to quit qemu, optionally update and

Upper case "QEMU", please.  More of the same below.

> +#     reboot the OS, and restart qemu.  If the user reboots, the URI
> +#     must persist across the reboot, such as by using a file.
>  #
> -#     Unlike normal mode, the use of certain local storage options does not
> -#     block the migration, but the user must not modify guest block devices
> -#     between the quit and restart.
> +#     Unlike normal mode, the use of certain local storage options
> +#     does not block the migration, but the user must not modify the
> +#     contents of guest block devices between the quit and restart.
>  #
> -#     This mode supports vfio devices provided the user first puts the guest
> -#     in the suspended runstate, such as by issuing guest-suspend-ram to the
> -#     qemu guest agent.
> +#     This mode supports VFIO devices provided the user first puts
> +#     the guest in the suspended runstate, such as by issuing
> +#     guest-suspend-ram to the qemu guest agent.
>  #
> -#     Best performance is achieved when the memory backend is shared and the
> -#     @x-ignore-shared migration capability is set, but this is not required.
> -#     Further, if the user reboots before restarting such a configuration, the
> -#     shared backend must be be non-volatile across reboot, such as by backing
> -#     it with a dax device.
> +#     Best performance is achieved when the memory backend is shared
> +#     and the @x-ignore-shared migration capability is set, but this
> +#     is not required.  Further, if the user reboots before restarting
> +#     such a configuration, the shared memory must persist across the
> +#     reboot, such as by backing it with a dax device.
>  #
> -#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
> +#     @cpr-reboot may not be used with postcopy, background-snapshot,
> +#     or COLO.
>  #
>  #     (since 8.2)
>  ##

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


