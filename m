Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6F5C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpN8U-0007ES-J8; Tue, 04 Mar 2025 02:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpN8I-0007Dd-6z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpN89-0002sd-TI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741074955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=8CWTsPqljJm6gVB2n7S8DeFHLPQjLhwynnjcEkHpvQM=;
 b=H4C5hqq7sC1PWIQ6hyd/og/uI/6Ronn2nEO5kKe/xSHnfv/hMPJhc/Iw/3dT09fVaV6Dzl
 aNpyfjR1UL4mjLkn3p5KcLZ8mMUL3rRQyXYUAaQHYbvYDDDAI31DLyl2zTlARJtQr0vWwq
 cB5vFOnMmqgyALnDXYEbtUeFafiCcXQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-sE3yetEuPaugv2iI9hga_w-1; Tue,
 04 Mar 2025 02:55:42 -0500
X-MC-Unique: sE3yetEuPaugv2iI9hga_w-1
X-Mimecast-MFC-AGG-ID: sE3yetEuPaugv2iI9hga_w_1741074941
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7813E1800879; Tue,  4 Mar 2025 07:55:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3CB81956048; Tue,  4 Mar 2025 07:55:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DBE021E66C2; Tue, 04 Mar 2025 08:55:37 +0100 (CET)
Resent-To: stefanha@gmail.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:55:37 +0100
Resent-Message-ID: <87tt89w7pi.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 3/6] python: add qapi static analysis tests
In-Reply-To: <CAJSP0QWWm7dcUNE0uYfUiNr98jpngDUQ0eGxNn3Vf2iQoC0d_Q@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 3 Mar 2025 10:25:16 +0800")
References: <20250226102842.3721046-1-armbru@redhat.com>
 <20250226102842.3721046-4-armbru@redhat.com>
 <CAJSP0QWWm7dcUNE0uYfUiNr98jpngDUQ0eGxNn3Vf2iQoC0d_Q@mail.gmail.com>
Date: Tue, 04 Mar 2025 07:09:48 +0100
Message-ID: <87jz95z5qr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> Hi John,
> Please take a look at this CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/9284725716#L150
>
> If you cannot reproduce it locally there is a chance that other pull
> requests on the staging branch caused the errors. If that's the case,
> please wait for the next update to qemu.git/master and rebase your
> patch.

I'm having difficulties running CI locally, but I think I see what's
wrong.  I'll submit v2 without this patch, and submit a fixed version of
the patch with my next pyll request.

Thanks!


