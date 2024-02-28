Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177ECC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 06:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfDSD-0007FU-Ul; Wed, 28 Feb 2024 01:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfDSB-0007Eb-Lh
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfDS9-0008Oq-3E
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709101804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtJcM8MeiQuDt8oTen0T+D/ITXNS5s2KD/Y3kyt7mo0=;
 b=TBNDVJDqwiTx5/NgfZcAocIRmn9mi5Ui9O2vCQwPEVRvQy2AoISspAvSu9Sc2aGQkjjAIx
 xZBuIgMEM84Erz9sLNaoOL2SjTTONGxXvFji5t4qOD3zXKc7rD1p0Ykq2TGBqx2wInmQyo
 WTU+pg9RFmgknyhbOheCDS3yxsr3+wA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-dA63K2UUMD2ZLXRxMCZ57g-1; Wed, 28 Feb 2024 01:30:00 -0500
X-MC-Unique: dA63K2UUMD2ZLXRxMCZ57g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7644785CE43;
 Wed, 28 Feb 2024 06:30:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5252DC185C3;
 Wed, 28 Feb 2024 06:30:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 257AC21E66F4; Wed, 28 Feb 2024 07:29:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  thuth@redhat.com,
 lvivier@redhat.com,  qemu-arm@nongnu.org,  alex.bennee@linaro.org,
 pbonzini@redhat.com,  anton.kochkov@proton.me,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH 0/6] Add ivshmem-flat device
In-Reply-To: <20240222222218.2261956-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 22 Feb 2024 22:22:12 +0000")
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
Date: Wed, 28 Feb 2024 07:29:59 +0100
Message-ID: <87wmqp3xug.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

[...]

> This patchset introduces a new device, ivshmem-flat, which is similar to the
> current ivshmem device but does not require a PCI bus. It implements the ivshmem
> status and control registers as MMRs and the shared memory as a directly
> accessible memory region in the VM memory layout. It's meant to be used on
> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
> memory-constrained resource targets.
>
> The patchset includes a QTest for the ivshmem-flat device, however, it's also
> possible to experiment with it in two ways:
>
> (a) using two Cortex-M VMs running Zephyr; or
> (b) using one aarch64 VM running Linux with the ivshmem PCI device and another
>     arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>
> Please note that for running the ivshmem-flat QTests the following patch, which
> is not committed to the tree yet, must be applied:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html

What problem are you trying to solve with ivshmem?

Shared memory is not a solution to any communication problem, it's
merely a building block for building such solutions: you invariably have
to layer some protocol on top.  What do you intend to put on top of
ivshmem?

[...]


