Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2AC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3HS-0004El-Ua; Wed, 29 Jan 2025 03:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1td3HR-0004EG-As
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1td3HP-0003rX-Mx
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738138714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=oqVZtEymuYphrtvOCec4Vy+RZEVjAU6lMKKNoyIYxKU=;
 b=aTvphLHNyAU/ZoF9fSsSmwl4eY+IIax66mBb7AbcGJbsLpJYiVMeC27GaK26nu+xFkkP5g
 ce7bC2sAHR4y+p7GwmQp0b9QZi+3v3eTCmfE1SMSlY1QF4B5MCpZMWgAWHlIT13E7MjrhH
 47LFh+1JiCftUqL2/QJmdT7bnJME0B0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-kuvVwq6SNKaBtPvpdWd5DA-1; Wed,
 29 Jan 2025 03:18:31 -0500
X-MC-Unique: kuvVwq6SNKaBtPvpdWd5DA-1
X-Mimecast-MFC-AGG-ID: kuvVwq6SNKaBtPvpdWd5DA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32247195608B; Wed, 29 Jan 2025 08:18:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.71])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ED1F1956056; Wed, 29 Jan 2025 08:18:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31B3321E6A28; Wed, 29 Jan 2025 09:18:27 +0100 (CET)
Resent-To: marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 philmd@linaro.org, qemu-devel@nongnu.org, steven.sistare@oracle.com,
 farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 29 Jan 2025 09:18:27 +0100
Resent-Message-ID: <87y0yu6njg.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
In-Reply-To: <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Tue, 24 Dec 2024 08:17:00 -0800")
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
Date: Wed, 29 Jan 2025 07:19:11 +0100
Message-ID: <87lduu87mo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Add the cpr-transfer migration mode, which allows the user to transfer
> a guest to a new QEMU instance on the same host with minimal guest pause
> time, by preserving guest RAM in place, albeit with new virtual addresses
> in new QEMU, and by preserving device file descriptors.  Pages that were
> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
> descriptor of the device that locked them remains open.
>
> cpr-transfer preserves memory and devices descriptors by sending them to
> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
> be sent over the normal migration channel, because devices and backends
> are created prior to reading the channel, so this mode sends CPR state
> over a second "cpr" migration channel.  New QEMU reads the cpr channel
> prior to creating devices or backends.  The user specifies the cpr channel
> in the channel arguments on the outgoing side, and in a second -incoming
> command-line parameter on the incoming side.
>
> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
> which allows anonymous memory to be transferred in place to the new process
> by transferring a memory descriptor for each ram block.  Memory-backend
> objects must have the share=on attribute, but memory-backend-epc is not
> supported.
>
> The user starts new QEMU on the same host as old QEMU, with command-line
> arguments to create the same machine, plus the -incoming option for the
> main migration channel, like normal live migration.  In addition, the user
> adds a second -incoming option with channel type "cpr".  The CPR channel
> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>
> To initiate CPR, the user issues a migrate command to old QEMU, adding
> a second migration channel of type "cpr" in the channels argument.
> Old QEMU stops the VM, saves state to the migration channels, and enters
> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
> resumes.
>
> The implementation splits qmp_migrate into start and finish functions.
> Start sends CPR state to new QEMU, which responds by closing the CPR
> channel.  Old QEMU detects the HUP then calls finish, which connects the
> main migration channel.
>
> In summary, the usage is:
>
>   qemu-system-$arch -machine aux-ram-share=on ...
>
>   start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>
>   Issue commands to old QEMU:
>     migrate_set_parameter mode cpr-transfer
>
>     {"execute": "migrate", ...
>         {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


