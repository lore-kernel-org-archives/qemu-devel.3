Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3E3CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 09:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIOHm-0003WX-19; Mon, 10 Nov 2025 04:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOCi-000127-En
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOCe-0001l2-Nf
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762766925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=ZhGyIQvhehsbEDz9Mi9Y6Te6otIrr/8wRSr8Ps4KFoM=;
 b=bgsTjbSOODRcopGe9ZbPRcrjYT++Xcp5ZyON5SlThce7cMjUxApkGSCg2JdnjGZvb+86Yi
 yAsYoSEDPwZ4XHmZE4JCpbxlhBTj4m53K8WJ3oT6v9E8VvRIRB5YIMXJRgr09XUxgKKTgW
 ZoW/Y7VAJogyFuFMQ6gV4HZCdTxYqE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-1Pk4AOi5OuSoNG3lehvZwQ-1; Mon,
 10 Nov 2025 04:28:43 -0500
X-MC-Unique: 1Pk4AOi5OuSoNG3lehvZwQ-1
X-Mimecast-MFC-AGG-ID: 1Pk4AOi5OuSoNG3lehvZwQ_1762766923
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE6A0180130B; Mon, 10 Nov 2025 09:28:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C42919560B2; Mon, 10 Nov 2025 09:28:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1881221E6A27; Mon, 10 Nov 2025 10:28:38 +0100 (CET)
Resent-To: kripper@imatronix.cl, users@lists.libvirt.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 10 Nov 2025 10:28:38 +0100
Resent-Message-ID: <87346mp77d.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Christopher Pereira <kripper@imatronix.cl>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, users@lists.libvirt.org
Subject: Re: Compact backing chain (sparsify + compress)
In-Reply-To: <aea951a3-6e83-4ec1-b287-4d7dba14b674@imatronix.cl> (Christopher
 Pereira's message of "Sun, 9 Nov 2025 23:31:16 -0300")
References: <aea951a3-6e83-4ec1-b287-4d7dba14b674@imatronix.cl>
Date: Mon, 10 Nov 2025 07:07:54 +0100
Message-ID: <87wm3y2zet.fsf@pond.sub.org>
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

Adding cc:s.

Christopher Pereira <kripper@imatronix.cl> writes:

> Hi,
>
> I would like to revisit this old thread from 2016 with a special use case=
 that I believe should be a standard `virsh` command:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03571.html
>
> **Summary:**
>
> Given this QEMU backing chain:
> `base <- snap1 <- snap2 <- snap3 (active)`
>
> We want to merge `base <- snap1 <- snap2` into a new snapshot `collapsed-=
base` that is:
> 1. Sparsified (`virt-sparsify`)
> 2. Compressed
>
> The resulting backing chain would be:
> `collapsed-base <- snap3 (active)`
>
> **Motivation:**
>
> - We perform daily backup snapshots and never modify existing files (too =
dangerous). We only rebase.
> - We collapse older chains into a new `collapsed-base` snapshot to limit =
chain size and avoid performance degradation.
>
> We have been doing this successfully for over 10 years using:
>
> - `qemu-img convert`
> - `virt-sparsify`
> - `virsh save`
> - `qemu-img rebase`
> - `virsh resume`
>
> **Problems:**
>
> - There is a small downtime due to `virsh save`/`resume`.
> - In recent QEMU versions, `virsh` adds a `backingStore` tag to the XML e=
ven when using the `--no-metadata` option. This causes inconsistencies afte=
r `qemu-img rebase`.
>
> We didn=E2=80=99t use QMP because it didn=E2=80=99t support sparsify + co=
mpression in the past.
>
> **Questions:**
>
> - Is there now a better way to achieve this?
> - Could this feature be implemented or supported directly in `virsh`?
>
> In my opinion, this would be the ideal backup solution: we could travel i=
n time, sync immutable snapshots to a remote backup server, and maintain pe=
rformance.


