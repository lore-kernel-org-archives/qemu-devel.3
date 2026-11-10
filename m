Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916E606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NUmqRBcb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQohc-0002PL-RH; Tue, 10 Nov 2026 11:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xQohU-0002Ni-M9
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xQohT-0005Ae-6b
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794328078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4LNkH695sO/PbFBgk+k4zS/+USkU8eaJmrQgBjimSLA=;
 b=NUmqRBcbHpCOZq0ka/vrl4B3T1/1tcdMoigBRpjA3OAIfw9zgM7G0kgZLGcatFTMyfh32n
 EWMafWjqb7mMrigFopXHr2VnwAIKDmpUAAR9PVb2EzZuqKEsnuu3oMxF0iMIa2LHsu9xoi
 cDGESn1KHH915m6OVqERSDwFZnggwjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-MCb9t0ECNpuLVptFELJuFA-1; Tue,
 10 Nov 2026 11:27:55 -0500
X-MC-Unique: MCb9t0ECNpuLVptFELJuFA-1
X-Mimecast-MFC-AGG-ID: MCb9t0ECNpuLVptFELJuFA_1794328074
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBF38180025A; Tue, 10 Nov 2026 16:27:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FB281961755; Tue, 10 Nov 2026 16:27:53 +0000 (UTC)
Date: Tue, 10 Nov 2026 09:27:51 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 berrange@redhat.com
Subject: Re: [PATCH for-11.2 v3 0/6] Fix some low-severity NBD CVEs
Message-ID: <20261110162751.GA548308@shajnocz.csb>
References: <20261110153121.1516536-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110153121.1516536-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 09:30:00AM -0600, Eric Blake wrote:
> Since v2 (https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01673.htm\
> l):
> - Tweak the documentation in patch 1 again [Stefan, Dan]
> - Improve unit tests, and pass pylint iotest 297 (new patch 2, also patch 4, 6)
> - Retain assertion at safer point for first bug (patch 3)
> - Second CVE addressed as well (patch 5, 6)
> 
> Eric Blake (6):
>   docs: Mention security considerations for NBD
>   iotests: Refactor python NBD server setup
>   nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
>   iotests: Add new nbd-robustness test
>   nbd/server: Reject rather than assert on non-compliant
>     NBD_OPT_SET_META_CONTEXT
>   iotests: Add another nbd-robustness test
> 
>  docs/system/security.rst                    |  23 +++
>  nbd/server.c                                |  10 +-
>  tests/qemu-iotests/iotests.py               |  30 +++
>  tests/qemu-iotests/tests/nbd-multiconn      |  44 +----
>  tests/qemu-iotests/tests/nbd-robustness     | 205 ++++++++++++++++++++
>  tests/qemu-iotests/tests/nbd-robustness.out |   5 +
>  6 files changed, 279 insertions(+), 38 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/nbd-robustness
>  create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out
> 
> -- 
> 2.56.0
> 
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


