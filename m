Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C34C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8SO-0004Gt-Dc; Wed, 29 Jan 2025 08:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1td8SL-0004FQ-NF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1td8SJ-0000qR-02
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158608;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6SQBZFxCTJfSsQVAi6w5SVKTbFFsNls5oBzle9PYfY=;
 b=PFZrTIDigJyjoW5CKVUcjTOPAUkBvvBVaKiVcxYRI5RG7Cdz7DzZCG+IcjRT/eLUoUZ5RX
 OAlCBvuz19vOgfhASR0EB7CeKnExHT79vNLggCEI1JtmiAbhrbXvAqbg3wr5HaKygGmuAp
 CqGHAU6XKhVyzSocPLJGi2gB4RYMjiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-e_ocXGGKM2e1_vx2j0djeA-1; Wed,
 29 Jan 2025 08:50:05 -0500
X-MC-Unique: e_ocXGGKM2e1_vx2j0djeA-1
X-Mimecast-MFC-AGG-ID: e_ocXGGKM2e1_vx2j0djeA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF5D1801F19; Wed, 29 Jan 2025 13:50:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25030180035E; Wed, 29 Jan 2025 13:49:58 +0000 (UTC)
Date: Wed, 29 Jan 2025 13:49:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/5] tests/functional: Add a decorator for skipping
 long running tests
Message-ID: <Z5oyA4SagNN5NHy7@redhat.com>
References: <20250128152839.184599-1-thuth@redhat.com>
 <20250128152839.184599-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128152839.184599-2-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 28, 2025 at 04:28:35PM +0100, Thomas Huth wrote:
> Some tests have a very long runtime and might run into timeout issues
> e.g. when QEMU has been compiled with --enable-debug. Add a decorator
> for marking them more easily. Rename the corresponding environment
> variable to be more in sync with the other QEMU_TEST_ALLOW_* switches
> that we already have, and add a paragraph about it in the documentation.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/devel/testing/functional.rst                |  8 ++++++++
>  tests/functional/qemu_test/__init__.py           |  2 +-
>  tests/functional/qemu_test/decorators.py         | 14 ++++++++++++++
>  tests/functional/test_aarch64_sbsaref_alpine.py  |  5 ++---
>  tests/functional/test_aarch64_sbsaref_freebsd.py |  9 +++------
>  tests/functional/test_arm_quanta_gsj.py          |  6 +++---
>  6 files changed, 31 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


