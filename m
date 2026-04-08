Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584210F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKE-0002pJ-AA; Wed, 08 Apr 2026 15:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wAYI3-0006bN-9V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wAPQ1-0003BD-5p
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775641310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6xDr5YkJHjRTzF0TOd4TGyn/fmTQVl8goMAmI84K4o=;
 b=N9O5428ibNYBPgAVp1CNWiKa31FXewvjiw7V8vqaFkn1u54zzv9JYdQp+8cizTJMB4OxoD
 z5Dd9lOUw15TPe0zEgCT1nZ654dz43IjEehdjz/4wZGk57+dXgWLkEJssmlMCwD/O//XOn
 28xl16mzX3FvVRTz2hWWtaGQYwOlj8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-j-OqGbyMPS-UKLFF7GkSDQ-1; Wed,
 08 Apr 2026 05:41:49 -0400
X-MC-Unique: j-OqGbyMPS-UKLFF7GkSDQ-1
X-Mimecast-MFC-AGG-ID: j-OqGbyMPS-UKLFF7GkSDQ_1775641308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71B991956050; Wed,  8 Apr 2026 09:41:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.231])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BA1F1800351; Wed,  8 Apr 2026 09:41:46 +0000 (UTC)
Date: Wed, 8 Apr 2026 11:41:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "wubo . bob" <wubo.bob@bytedance.com>,
 hongmianquan <hongmianquan@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for 11.0] util: fix missing aio_wait_kick sym in qemu
 guest agent only build
Message-ID: <adYi13SGlff_TwOD@redhat.com>
References: <20260407152207.363647-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407152207.363647-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 07.04.2026 um 17:22 hat Daniel P. Berrangé geschrieben:
> Configure QEMU with
> 
>  --disable-system --disable-user --disable-tools --enable-guest-agent
> 
> and the build with fail with
> 
>   FAILED: [code=1] qga/qemu-ga
>   /usr/bin/ld: libqemuutil.a.p/qapi_qmp-dispatch.c.o: in function `do_qmp_dispatch_bh':
>   /var/home/berrange/src/virt/qemu/build/../qapi/qmp-dispatch.c:140:(.text+0x5c): undefined reference to `aio_wait_kick'
> 
> This aio_kick() usage was recently introduced in qmp-dispatch.c
> without updating the build logic.
> 
> Fixes commit fc1a2ec7da531223b3473185dc2584f8a7c6c659
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Pretty much the same as what I suggested in the pull request thread,
just in a separate line instead of adding it to the previous one and as
a proper patch. Thanks, saves me the work to write a proper commit
messsage!

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


