Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8E6C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6oP-0005hC-D8; Mon, 03 Jun 2024 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sE6oN-0005gJ-AF
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sE6oL-0005Gy-Ja
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717417752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEp1b7+yXvj4sMU+gABKlSkGj8k2gCBF8kxLkzopYec=;
 b=i/M5sWiB44mnUiJdRVcIn5Oh+HOL+zQKQq4OnZpu+GsM+m4jTdNyOqpk3/t3U5slZrD54s
 w3nuAYqqCyg0CxAz5b/wYGvkyKdLaVMVmuxl9pbrC8EYr+xuE0kG+22AX3YaO546aBA1nQ
 aC03i5Qdonb7DdJoMRuu/Ot7Yw/hetY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-WZDoDWsxO2KG0_JIpu-jhQ-1; Mon,
 03 Jun 2024 08:29:07 -0400
X-MC-Unique: WZDoDWsxO2KG0_JIpu-jhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB2323806707;
 Mon,  3 Jun 2024 12:29:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30BA4C15C03;
 Mon,  3 Jun 2024 12:29:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, pbonzini@redhat.com,
 npiggin@gmail.com, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH 0/2] ppc: spapr: Nested kvm guest migration fixes
In-Reply-To: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 03 Jun 2024 14:29:04 +0200
Message-ID: <877cf6mcq7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 03 2024, Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> The series fixes the issues exposed by the kvm-unit-tests[1]
> sprs-migration test.
>
> The sprs DEXCR and HASKKEYR are not registered with one-reg IDs
> without which the Qemu is not setting them to their 'previous'
> value during guest migreation at destination.
>
> The two patches in the series take care of this. Also, the PPC
> kvm header changes are selectively picked for the required
> definitions posted here at [2].
>
> References:
> [1]: https://github.com/kvm-unit-tests/kvm-unit-tests
> [2]: https://lore.kernel.org/kvm/171741323521.6631.11242552089199677395.stgit@linux.ibm.com
>
> ---
>
> Shivaprasad G Bhat (2):
>       target/ppc/cpu_init: Synchronize DEXCR with KVM for migration
>       target/ppc/cpu_init: Synchronize HASHKEYR with KVM for migration
>
>
>  linux-headers/asm-powerpc/kvm.h | 2 ++

Please split out any changes under linux-headers/ into a separate patch;
those files need to be changed via a full header update against a
released kernel version. If the changes are not yet upstream in the
Linux kernel, please put in a clearly marked placeholder patch in the
meanwhile.


>  target/ppc/cpu_init.c           | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> --
> Signature


