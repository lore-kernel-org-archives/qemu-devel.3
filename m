Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184A3CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uth-0000oo-LY; Wed, 15 Oct 2025 02:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8ute-0000ni-0u
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8utX-0002qS-8e
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760509307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1LXFn9UAXJaSfLDAuyvxlMnRWuwBBhcKMiRok+7Idg=;
 b=JwLQZX8XVwD6RZQxOWXTiSFp5ur6QXDDplML0U14/J+qIb7lOcRJ1IrCcNHUMdXenIxNxv
 I9rGMMLclmJITfX1ck2e3gRfPoMS8sEztqmaMY5uF+Mmd6D+RKiUfi+o+hIAzKfFTqC+WS
 faotljyy51/y0BysuKTlDaZw3NOJvUw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-iRZSPpfLMVSSu2QXTRY7Wg-1; Wed,
 15 Oct 2025 02:21:43 -0400
X-MC-Unique: iRZSPpfLMVSSu2QXTRY7Wg-1
X-Mimecast-MFC-AGG-ID: iRZSPpfLMVSSu2QXTRY7Wg_1760509302
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F259E1954199; Wed, 15 Oct 2025 06:21:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA06219560AD; Wed, 15 Oct 2025 06:21:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BBB821E6A27; Wed, 15 Oct 2025 08:21:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eric Blake <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=83?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/machine: Fix missing @modules in topology ordering
In-Reply-To: <20251013074511.2030073-1-zhao1.liu@intel.com> (Zhao Liu's
 message of "Mon, 13 Oct 2025 15:45:11 +0800")
References: <20251013074511.2030073-1-zhao1.liu@intel.com>
Date: Wed, 15 Oct 2025 08:21:38 +0200
Message-ID: <87jz0wk7m5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:

> The module level is between core and cluster levels. Fix the QAPI
> documentation to add the module level in topology ordering.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Fixes: 8ec0a4634798 ("hw/core/machine: Support modules in -smp")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  qapi/machine.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c78..5e268479e546 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1624,7 +1624,7 @@
>  # containers.
>  #
>  # The ordering from highest/coarsest to lowest/finest is: @drawers,
> -# @books, @sockets, @dies, @clusters, @cores, @threads.
> +# @books, @sockets, @dies, @clusters, @modules, @cores, @threads.
>  #
>  # Different architectures support different subsets of topology
>  # containers.

Acked-by: Markus Armbruster <armbru@redhat.com>

However, there are more mentions of @drawers etc. in comments and
documentation elsewhere.  Quick grep for "drawers" there appended.
Please double-check for missing mentions of modules.


docs/about/deprecated.rst:configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
docs/devel/s390-cpu-topology.rst:    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
docs/system/s390x/cpu-topology.rst:topology containers: drawers, books and sockets. They define a
docs/system/s390x/cpu-topology.rst:If none of the containers attributes (drawers, books, sockets) are
hw/s390x/cpu-topology.c: * (0, 0, 0) up to the last (smp->drawers, smp->books, smp->sockets).
include/hw/boards.h: * @drawers_supported - whether drawers are supported by the machine
include/hw/boards.h: * @drawers: the number of drawers on the machine
tests/functional/s390x/test_topology.py:    the cores, sockets, books and drawers and 2 modifiers attributes,
tests/unit/test-smp-parse.c: *  -drawers/books/sockets/cores/threads
tests/unit/test-smp-parse.c: *  -drawers/books/sockets/dies/clusters/modules/cores/threads
tests/unit/test-smp-parse.c:         *   -smp 8,drawers=1,books=1,sockets=2,dies=1,clusters=1,modules=1,\
tests/unit/test-smp-parse.c:        /* config: -smp 2,drawers=2 */
tests/unit/test-smp-parse.c:        /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
tests/unit/test-smp-parse.c:        /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
tests/unit/test-smp-parse.c:         * config: -smp 200,drawers=3,books=5,sockets=2,cores=4,\
tests/unit/test-smp-parse.c:         * config: -smp 242,drawers=3,books=5,sockets=2,cores=4,\
tests/unit/test-smp-parse.c:         * config: -smp 200,drawers=3,books=5,sockets=2,dies=4,\
tests/unit/test-smp-parse.c:         * config: -smp 2881,drawers=3,books=5,sockets=2,dies=4,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
tests/unit/test-smp-parse.c:         * config: -smp 0,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * Test "drawers=0".
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=0,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=0,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=0,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=0,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
tests/unit/test-smp-parse.c:        /* when drawers parameter is omitted, it will be set as 1 */
tests/unit/test-smp-parse.c:        /* when drawers parameter is specified */
tests/unit/test-smp-parse.c:         * when drawers and books parameters are omitted, they will
tests/unit/test-smp-parse.c:        /* when drawers and books parameters are both specified */
tests/unit/test-smp-parse.c:         * when drawers, books, dies, clusters and modules parameters are
tests/unit/test-smp-parse.c:         * when drawers, books, dies, clusters and modules parameters


