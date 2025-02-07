Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC34EC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPQb-00083x-3F; Fri, 07 Feb 2025 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPQZ-00083X-Kv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPQW-00036m-CN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738938830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uphoigl3bjNyqRzPkzx6eKYk5Zf/z+1ZhL3XeyGLxc=;
 b=EGrrj3yjd4+l9AWpcEslLG+C/gk+IQKjOGeKS01fBwPJAdOZc9xIugZBBObTetxR1D50Ri
 KdcdFCGkPGk6t/nYOEwr04YR5e7ip/KJcmooaisyfpoxudy8pKbDPFJU4+BIxl0WBJjduT
 KwQUCvKlDrzyBk8nrDFJeoTSGW41iHY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-LG27P_h3PECLvD_cP0AeaA-1; Fri,
 07 Feb 2025 09:33:41 -0500
X-MC-Unique: LG27P_h3PECLvD_cP0AeaA-1
X-Mimecast-MFC-AGG-ID: LG27P_h3PECLvD_cP0AeaA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A752F1801A20; Fri,  7 Feb 2025 14:33:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67EA11800878; Fri,  7 Feb 2025 14:33:37 +0000 (UTC)
Date: Fri, 7 Feb 2025 14:33:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 1/8] crypto: Allow gracefully ending the TLS session
Message-ID: <Z6YZvuCyinrX--NN@redhat.com>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207142758.6936-2-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 07, 2025 at 11:27:51AM -0300, Fabiano Rosas wrote:
> QEMU's TLS session code provides no way to call gnutls_bye() to
> terminate a TLS session. Callers of qcrypto_tls_session_read() can
> choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
> gracefulTermination argument.
> 
> The QIOChannelTLS ignores the premature termination error whenever
> shutdown() has already been issued. This is not enough anymore for the
> migration code due to changes [1] in the synchronization between
> migration source and destination.
> 
> Add support for calling gnutls_bye() in the tlssession layer so users
> of QIOChannelTLS can clearly identify the end of a TLS session.
> 
> 1- 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")

Would be slightly clearer as "[1] 1d457daf86 ...."

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  crypto/tlssession.c         | 41 +++++++++++++++++++++++++++++++++++++
>  include/crypto/tlssession.h | 22 ++++++++++++++++++++
>  2 files changed, 63 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


