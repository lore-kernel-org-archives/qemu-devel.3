Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDADDEF3718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQX-0002f8-Sk; Mon, 09 Mar 2026 04:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzWQU-0002K1-9Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzWQS-0001TQ-Gi
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TD6El9/u7kHf17unMAVoG6ZYcpEx5M5fGzScVbfhWUs=;
 b=DoiuyKXVl6kynl0hU1dHXoB+IhO6WJa2T/u85Ld6avg9IvJHIKsAtoWsIClkGZ62m3ZFXV
 +EguhK3q/xGv5ECKm3isYyd2PdQxZkC89SUk+r8KIB34GPXeI/isMapLcrK3gUozdm1ssf
 k8rG9MGMhSNFbjEPU28fIMeRAUBVbhY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-pY4QhfKSMfGNvqMh7IJcCQ-1; Mon,
 09 Mar 2026 04:57:16 -0400
X-MC-Unique: pY4QhfKSMfGNvqMh7IJcCQ-1
X-Mimecast-MFC-AGG-ID: pY4QhfKSMfGNvqMh7IJcCQ_1773046635
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B61321956059; Mon,  9 Mar 2026 08:57:14 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D2F61955D71; Mon,  9 Mar 2026 08:57:10 +0000 (UTC)
Date: Mon, 9 Mar 2026 09:57:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, xeor@yandex-team.ru,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
Message-ID: <aa6LZAsy_hw85KkC@redhat.com>
References: <20260212212738.141780-1-kwolf@redhat.com>
 <84a16fad-59e8-47a2-b66e-72cb64a04aa1@tls.msk.ru>
 <c97c32ad-4df5-45ee-a4e2-2a2e3e4edb46@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97c32ad-4df5-45ee-a4e2-2a2e3e4edb46@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Am 08.03.2026 um 09:34 hat Michael Tokarev geschrieben:
> On 08.03.2026 11:31, Michael Tokarev wrote:
> 
> > This looks like a qemu-stable material (10.0.x, 10.1.x, 10.2.x).
> It is already Cc'd qemu-stable, N/M.

Oops, seems I forgot the Cc: tag in the commit message. Sorry! I'll try
to remember doing that again next time.

Kevin


