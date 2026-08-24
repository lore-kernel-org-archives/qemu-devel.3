Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyP2M-0003Jg-Bc; Mon, 24 Aug 2026 03:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP2K-0003J5-DA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP2I-0001v4-PX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787556242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=FEcRtZYhAS8OkqDEIRzJhwujdOXmMSZACdppFhJjhFI=;
 b=BRIdPaqEnSOZGhI1u46921yzy6NJmBrUS7xdmukaYx6p7G0bjxaAtyHFWvFIINWIDmnWFy
 xYtH8HhH61wUl76nIkkqpReTjAn52KYaPlE4Hq+RHIOdWgnlfv9my+lhryo1wZ4ZKwrlo3
 R6tRx4nqr9kH+8lwD5QY8b4lCUGsw0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-Xeq9gCfqNlmfFWXwYur2gg-1; Mon,
 24 Aug 2026 03:23:58 -0400
X-MC-Unique: Xeq9gCfqNlmfFWXwYur2gg-1
X-Mimecast-MFC-AGG-ID: Xeq9gCfqNlmfFWXwYur2gg_1787556237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81FA01945CB8; Mon, 24 Aug 2026 07:23:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C2481955F09; Mon, 24 Aug 2026 07:23:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC00921E6920; Mon, 24 Aug 2026 09:23:54 +0200 (CEST)
Resent-To: jasowangio@gmail.com, zhangckid@gmail.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 24 Aug 2026 09:23:54 +0200
Resent-Message-ID: <87ik50ugl1.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V12 03/15] iothread: track users with holder name
In-Reply-To: <20260814174830.1691540-4-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 15 Aug 2026 01:48:17 +0800")
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-4-zhangckid@gmail.com>
Date: Mon, 24 Aug 2026 08:41:39 +0200
Message-ID: <87a4qcvx3w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Introduce iothread_ref_and_get_aio_context() with a holder argument
> and its counterpart iothread_unref_and_put_aio_context().
>
> Previously, users of an IOThread AioContext did not explicitly record
> their identity, making it difficult to debug which devices or
> subsystems were pinning an IOThread.
>
> Registering a holder takes an IOThread object reference so that the
> IOThread and its AioContext stay alive until the matching put
> operation. Document the ownership and BQL requirements.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

Does this add tracking, or just the tracking infrastructure?

If the latter, the subject is misleading.


