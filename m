Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA40606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdSIjwgt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2s1-0002ZI-3h; Tue, 20 Oct 2026 01:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2rx-0002YS-FI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2ru-000597-Sq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792475917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXR1EdQME0eJiPWvBtXblLJpeYUV3xk0YQkqvXrOF7s=;
 b=bdSIjwgtpkC/Mqzm/z8JwP+GcgEG/d5PqLMwujYyIqzgcWNaxk2CRwK4d6sUvuJxDq4xaE
 zqP2MiXq5HVPJ4Rx2aIzRxWv1w8BZXbqbbCAe2u4BIMWBdsZ9lRhyOGQkuN+qtQnLPE0f5
 PuIbL0rl4vHHgRHNJLN1SEVQ24SI8+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-OlhO-QO9O_iYFlIRfWkiKg-1; Tue,
 20 Oct 2026 05:58:34 +0000
X-MC-Unique: OlhO-QO9O_iYFlIRfWkiKg-1
X-Mimecast-MFC-AGG-ID: OlhO-QO9O_iYFlIRfWkiKg_1792475913
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9266180264B; Tue, 20 Oct 2026 05:58:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 238261800677; Tue, 20 Oct 2026 05:58:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A35BC21E6A04; Tue, 20 Oct 2026 07:58:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/12] qapi/common: Clarify what IoOperationType is for
In-Reply-To: <20261019182028.45305-2-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 19 Oct 2026 20:20:17 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-2-hreitz@redhat.com>
Date: Tue, 20 Oct 2026 07:58:29 +0200
Message-ID: <8733u0ud4q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> The documentation for this type is a bit sparse right now, and
> specifically does not explain why it is limited to read/write only;
> "I/O operation type" could well imply this should distinguish a much
> broader range of operations like flushes, discards, etc., but it does
> not.
>
> Make a note why that is, which is that these types reflect the block
> device on-error policy settings that we have, which are rerror for read
> and werror for write.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/common.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/common.json b/qapi/common.json
> index 1352e664b23..880eb87a9cb 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -9,7 +9,10 @@
>  
>  ##
>  # @IoOperationType:
> -#     An enumeration of the I/O operation types
> +#     An enumeration of the I/O operation types, limited to the block
> +#     device on-error policy settings we have (rerror and werror).
> +#     For reference, the corresponding error policy values are set in
> +#     `BlockdevOnError`.
>  #
>  # @read: read operation
>  #

I believe I get what you mean only because I read the cover letter
first.

My first attempt

    I/O operation types that may have a block device on-error policy.

is still confusing, because we use "block device" both for frontends and
backends.  I believe "block device on-error policy" refers to the qdev
properties "rerror" and "werror" certain block frontends / device models
have (virtio-blk-device, scsi-hd, scsi-cd, usb-storage).  Possible
clarification:

    These are the properties "rerror" and "werror" certain block device
    models have.

And then maybe

    @read: read operation, corresponding to property "rerror"

    @write: write operation, corresponding to property "werror"


