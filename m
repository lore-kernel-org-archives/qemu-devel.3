Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9312606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EsHEU88Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZ5w-0003Jf-5Z; Thu, 12 Nov 2026 13:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRZ5t-0003JJ-IF
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:00:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRZ5r-0004FE-EH
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794506414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaSqCAIkPNlHKhCsNIyAEUbD9vb6x66UxkEgVu4rFKE=;
 b=EsHEU88QJ/kYkTreQg9kEGAA6jMuxSra8eLW91dmiHPtuoCSivNkDaKFhErPXLvizAlXdJ
 rkpts5IofYo7P91jJiJbnzkwFRXW5LXkfG1iQDT/EgFbzTDPDlujVzUHsfTiYnw8g4Saw5
 BwzDFTCfrkQI7gfxEAc+Ko8bEcTEX0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Fvr6wNdUPV6ylGMOCZLDFg-1; Thu,
 12 Nov 2026 13:00:12 -0500
X-MC-Unique: Fvr6wNdUPV6ylGMOCZLDFg-1
X-Mimecast-MFC-AGG-ID: Fvr6wNdUPV6ylGMOCZLDFg_1794506411
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB33D18004DA; Thu, 12 Nov 2026 18:00:10 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26BF41956087; Thu, 12 Nov 2026 18:00:09 +0000 (UTC)
Date: Thu, 12 Nov 2026 18:00:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] crypto: robustness fixes to handling of SM3 hash
Message-ID: <avX-p7BYUovjL7PB@redhat.com>
References: <20261102122343.3348956-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102122343.3348956-1-berrange@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping: i'd like to get this fix into 11.2

On Mon, Nov 02, 2026 at 12:23:39PM +0000, Daniel P. Berrangé wrote:
> Note that patch 4 is best reviewed by applying to git and then using
> 'git show -b' to hide the huge whitespace indentation change.
> 
> Changed in v2:
> 
>  * Use array range initializer for setting default value
>  * Drop redundant countermeasures now we can gurantee a
>    correct default initializer value
>  * Drop SM3 conditions in tests
>  * Refactor tests to register one test per algorithm
> 
> Daniel P. Berrangé (4):
>   crypto: set default initializer hmac/hash arrays to -1
>   crypto: unconditionally report SM3 hash length
>   tests/unit: drop conditionals for SM3
>   tests/unit: register one test per hash/hmac algorithm
> 
>  crypto/hash-glib.c            |   3 +-
>  crypto/hash.c                 |   4 +-
>  crypto/hmac-glib.c            |   4 +-
>  tests/unit/test-crypto-hash.c | 325 +++++++++++++++-------------------
>  tests/unit/test-crypto-hmac.c | 272 +++++++++++++---------------
>  5 files changed, 275 insertions(+), 333 deletions(-)
> 
> -- 
> 2.56.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


