Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EBBCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8f-0005OA-1f; Wed, 07 Oct 2026 04:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEI57-0001IB-0S
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEI4z-0001C6-BM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791342722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUpuq8kGZVhpW7rdFIIKKgacW+psg4/ICzoFgyy6TBA=;
 b=gHNOSTd89O3TCGeuNlTqUEfd6Sp/vEEaWsnKvxuaVanP1RGMZE5Q4ZbZfYyEy2R1o2qzto
 VgOBy+0ZWazijbcc/HUM5/IIV7KDGjZyadmCbaUpstE8X4qzttZhP0aOqT7sg2ABncZ07J
 EA3Oudxpa/2BfOCwXiOZTJ+xy87gRUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-0_gdHdaPNq6b3JDfHOFTJA-1; Tue,
 06 Oct 2026 16:56:47 -0400
X-MC-Unique: 0_gdHdaPNq6b3JDfHOFTJA-1
X-Mimecast-MFC-AGG-ID: 0_gdHdaPNq6b3JDfHOFTJA_1791320207
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7BC6195E909; Tue,  6 Oct 2026 20:56:46 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B1C03001D31; Tue,  6 Oct 2026 20:56:44 +0000 (UTC)
Date: Tue, 6 Oct 2026 21:56:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 3/7] migration: Fix socket listen backlog
Message-ID: <asVgieiXH1aieDak@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006182046.3767283-4-peterx@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 06, 2026 at 02:20:42PM -0400, Peter Xu wrote:
> QEMU incoming side may have set a wrong listen() backlog.  After the
> support of multifd + postcopy now we have four possibilities on setting the
> backlog, some of them are wrong:
> 
>   Vanilla:            1 (correct)
>   Multifd:            N (wrong, should be N+1)
>   Preempt:            2 (correct)
>   Multifd+Preempt:    N (wrong, should be N+2)
> 
> No real report for this, found by code observation only.  Logically the
> backlog (pending accept requests on destination on the listening sockets)
> needs to be the maximum of possible channels.  Otherwise if the accept
> queue full on destination, source QEMU may hit connection errors.

From a robustness POV, we might also consider retrying connections
if we see a transient failure. Though I'm not sure offhand what
errrno would result on the client when the accept() queue  is full,
hopefully there's something distinct.

This would mitigate a risk of DoS from an unauthorized client
making its own incoming connections concurrently. Such a client
is not necessarily malicious, as there are monitoring tools or
port scanners that randomly open connections to TCP listener
sockets.

> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Fixes: 0705e56496 ("multifd: Use number of channels as listen backlog")
> Fixes: e274188612 ("migration: enable multifd and postcopy together")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/socket.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


