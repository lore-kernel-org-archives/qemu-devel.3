Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C79ECAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiwv-0008IE-KN; Thu, 11 Sep 2025 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwiwb-0008Fd-4h
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwiwY-0007FL-ER
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757603437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tiHBaA5NRDAw7N+hIWXPpFMbiJS94iXizo+dBoyeE8=;
 b=O7Bv0hKjfpfhU1UOq8Imo6/zsgalRZSrNt87IsG9RV+/FQxhsHUXDshrEFaceKaOlcUoT6
 quwPlfrorqg4eNNz0ulaG5zokE2Iwohz4zjrUVU3+NAWBkoF6U0x4LD45zi2YTgdVAaRe9
 RYhVKM3ABkhYPKb41S96y4+mMAcxkHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-M4MlAe1yOYaETPalvMtB3Q-1; Thu,
 11 Sep 2025 11:10:33 -0400
X-MC-Unique: M4MlAe1yOYaETPalvMtB3Q-1
X-Mimecast-MFC-AGG-ID: M4MlAe1yOYaETPalvMtB3Q_1757603432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26E111800292; Thu, 11 Sep 2025 15:10:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F30E19560B1; Thu, 11 Sep 2025 15:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5CAD21E6A27; Thu, 11 Sep 2025 17:10:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 5/9] migration: cpr-exec-command parameter
In-Reply-To: <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 14 Aug 2025 10:17:19 -0700")
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
Date: Thu, 11 Sep 2025 17:10:28 +0200
Message-ID: <87qzwddnyz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Create the cpr-exec-command migration parameter, defined as a list of
> strings.  It will be used for cpr-exec migration mode in a subsequent
> patch, and contains forward references to cpr-exec mode in the qapi
> doc.
>
> No functional change, except that cpr-exec-command is shown by the
> 'info migrate' command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json            | 21 ++++++++++++++++++---
>  migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
>  migration/options.c            | 14 ++++++++++++++
>  hmp-commands.hx                |  2 +-
>  4 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21..ea410fd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -924,6 +924,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @cpr-exec-command: Command to start the new QEMU process when @mode
> +#     is @cpr-exec.  The first list element is the program's filename,
> +#     the remainder its arguments. (Since 10.2)

Please add a second space in ". (" for all three copies.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -950,7 +954,8 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io',
> +           'cpr-exec-command'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1105,6 +1110,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @cpr-exec-command: Command to start the new QEMU process when @mode
> +#     is @cpr-exec.  The first list element is the program's filename,
> +#     the remainder its arguments. (Since 10.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1146,7 +1155,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*cpr-exec-command': [ 'str' ]} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1315,6 +1325,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @cpr-exec-command: Command to start the new QEMU process when @mode
> +#     is @cpr-exec.  The first list element is the program's filename,
> +#     the remainder its arguments. (Since 10.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1353,7 +1367,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*cpr-exec-command': [ 'str' ]} }
>  
>  ##
>  # @query-migrate-parameters:

Acked-by: Markus Armbruster <armbru@redhat.com>


[...]


