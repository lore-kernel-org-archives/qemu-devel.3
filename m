Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0D8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 09:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVMZ-0002q6-Bf; Thu, 15 May 2025 05:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFVMS-0002gB-0c
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFVMN-0004xa-E3
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747303117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7fuvIfSs0wpeW6VpGUcw4N2K/Lqf6CBCixbfbuBFeWQ=;
 b=YyRxwnj2aDTIv2a2kj5rajiLos2WUH1L4nI46Xo7RIY+FH0M0mbPjlSym0AhphTnZ2Wej1
 84PNEbdipTczmsUiRYQFeUKv8+OP/vcPZyTWpVyefxhHRqoTuxz4xfRsyL+UwnsKuEjBW1
 QO+tcbflXKxa9ttpmT7Mc6g+IaFpP7k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-qOe6w0LgNhuPT-ZFTqLDvA-1; Thu,
 15 May 2025 05:58:34 -0400
X-MC-Unique: qOe6w0LgNhuPT-ZFTqLDvA-1
X-Mimecast-MFC-AGG-ID: qOe6w0LgNhuPT-ZFTqLDvA_1747303113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CE4D19560AA; Thu, 15 May 2025 09:58:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20734195608D; Thu, 15 May 2025 09:58:26 +0000 (UTC)
Date: Thu, 15 May 2025 10:58:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 armbru@redhat.com, christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 08/20] mcd: Implement server connection API
Message-ID: <aCW6vZivY9-Yt8-H@redhat.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-9-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430052741.21145-9-mario.fleischmann@lauterbach.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 30, 2025 at 07:27:29AM +0200, Mario Fleischmann wrote:
> This commit implements the necessary operations required to establish
> a connection with the MCD server:
> 
> * query information about the server
> * connect to "
> * disconnect from "
> 
> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
> ---
>  mcd/mcd_qapi.c         |  13 +++
>  mcd/mcd_qapi.h         |   2 +
>  mcd/mcd_server.c       | 110 +++++++++++++++++++++-
>  mcd/mcd_stub.c         |  98 ++++++++++++++++++++
>  qapi/mcd.json          | 205 +++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/mcd-test.c |  96 +++++++++++++++++++
>  tests/qtest/mcd-util.c |  60 ++++++++++++
>  tests/qtest/mcd-util.h |   9 ++
>  8 files changed, 588 insertions(+), 5 deletions(-)
> 
> diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
> index 9a99866..d2a2926 100644
> --- a/mcd/mcd_qapi.c
> +++ b/mcd/mcd_qapi.c


> +MCDQryServersResult *qmp_mcd_qry_servers(const char *host, bool running,
> +                                         uint32_t start_index,
> +                                         uint32_t num_servers, Error **errp)
> +{
> +    MCDServerInfoList **tailp;
> +    MCDServerInfo *info;
> +    mcd_server_info_st *server_info = NULL;
> +    bool query_num_only = num_servers == 0;
> +    MCDQryServersResult *result = g_malloc0(sizeof(*result));
> +
> +    if (!query_num_only) {
> +        server_info = g_malloc0(num_servers * sizeof(*server_info));

This multiplication is (theoretically) subject to overflow. To eliminate
this risk, this should use

    g_new0(mcd_server_info_st, num_servers)

which will validate overflow & abort if hit.

There are many more instances of this code pattern in the series

$ git diff -r master | grep g_malloc | grep ' \* '
+        .tx = g_malloc(txlist->num_tx * sizeof(mcd_tx_st)),
+        server_info = g_malloc0(num_servers * sizeof(*server_info));
+        system_con_info = g_malloc0(num_systems * sizeof(*system_con_info));
+        device_con_info = g_malloc0(num_devices * sizeof(*device_con_info));
+        core_con_info = g_malloc0(num_cores * sizeof(*core_con_info));
+        memspaces = g_malloc0(num_mem_spaces * sizeof(*memspaces));
+        reg_groups = g_malloc0(num_reg_groups * sizeof(*reg_groups));
+        regs = g_malloc0(num_regs * sizeof(*regs));
+        ctrig_info = g_malloc0(num_ctrigs * sizeof(*ctrig_info));
+        trig_ids = g_malloc0(num_trigs * sizeof(*trig_ids));


QEMU is a bit inconsistent, but we have a slight bias in favour
of using g_new0, even for single struct allocations.

IMHO being in the habit of always using g_new0 instead of g_malloc
makes it less likely for people to inadvertantly introduce the
multiplication overflow code pattern with g_malloc.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


