Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3EDC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 11:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ILN-0000ng-D0; Mon, 14 Apr 2025 07:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4ILK-0000my-NS
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4ILI-0007Hw-M1
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744631471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ysVkVJg5vD7S3rg3tU4kW4xTISitIYpVrRk4lsTStc=;
 b=JLHvvIrSRVIA0nbUG6iXxKujtJXZ+A7gZKMSbbYEjjgot/mHuTibkw1RGOcsqRtMYNJdQ1
 hdjBJl0WJ1NrNHf5AZSdLuA0x5jd5Hour4NbJMeUzL8XlFZkCLH/6XUjFH53kGIkPet2H4
 krqIgJ4SvmjbR9Y4ITBMQa1NQedundE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-PJDCPc39Pza-yEpMVW_WRg-1; Mon,
 14 Apr 2025 07:51:08 -0400
X-MC-Unique: PJDCPc39Pza-yEpMVW_WRg-1
X-Mimecast-MFC-AGG-ID: PJDCPc39Pza-yEpMVW_WRg_1744631467
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F980180899B; Mon, 14 Apr 2025 11:51:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACEB9180B487; Mon, 14 Apr 2025 11:51:05 +0000 (UTC)
Date: Mon, 14 Apr 2025 12:51:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 03/15] tests/functional: Convert reverse_debugging
 tests to the functional framework
Message-ID: <Z_z2pm_mcB1SnB_I@redhat.com>
References: <20250414113031.151105-1-thuth@redhat.com>
 <20250414113031.151105-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414113031.151105-4-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 14, 2025 at 01:30:17PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These tests are using the gdb-related library functions from the
> Avocado framework which we don't have in the functional framework
> yet. So for the time being, keep those imports and skip the test
> if the Avocado framework is not installed on the host.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  tests/functional/meson.build                  |   4 +
>  .../reverse_debugging.py                      | 114 +++---------------
>  .../functional/test_aarch64_reverse_debug.py  |  38 ++++++
>  tests/functional/test_ppc64_reverse_debug.py  |  41 +++++++
>  tests/functional/test_x86_64_reverse_debug.py |  36 ++++++
>  6 files changed, 139 insertions(+), 96 deletions(-)
>  rename tests/{avocado => functional}/reverse_debugging.py (66%)
>  create mode 100755 tests/functional/test_aarch64_reverse_debug.py
>  create mode 100755 tests/functional/test_ppc64_reverse_debug.py
>  create mode 100755 tests/functional/test_x86_64_reverse_debug.py

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


