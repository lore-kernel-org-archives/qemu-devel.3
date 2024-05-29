Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA238C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 11:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCHCf-0005ez-Jy; Wed, 29 May 2024 07:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCHCc-0005ep-Qf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCHCa-00063Q-7u
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716981038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hAnIs1pI1DVkA5WvZgSX+tOpcnxTZQDYZNgLVF8jeJU=;
 b=Qv3dW/vPSdGiv0E+30d8ZpWNHA+j4HnyxNqIpLSa+5mL8em5ZoNKRzrHV/BfR8Y5AboIiJ
 E/yjkzuouFYQtroO+FBFjzAhZw9U1dZTGsFZB6q6LkQdUFgb6/tbXfLdtINFlqQ7jklCzO
 9aVANTG9semMlNwOq1N7mBRK4TouJJs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-Zg2ryUh-P0KCuL_erSBu1A-1; Wed,
 29 May 2024 07:10:33 -0400
X-MC-Unique: Zg2ryUh-P0KCuL_erSBu1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 524613C025B1;
 Wed, 29 May 2024 11:10:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E36B72026D68;
 Wed, 29 May 2024 11:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B837421E668E; Wed, 29 May 2024 13:10:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Shameer Kolothum via <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>,  <farosas@suse.de>,  <yuan1.liu@intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>,  <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>,  <huangchenghai2@huawei.com>
Subject: Re: [PATCH 3/7] migration/multifd: add uadk compression framework
In-Reply-To: <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
 (Shameer Kolothum via's message of "Wed, 29 May 2024 10:44:23 +0100")
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
Date: Wed, 29 May 2024 13:10:30 +0200
Message-ID: <874jagooux.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Please cc: maintainers on patches.  You can use
scripts/get_maintainer.pl to find them.

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Adds the skeleton to support uadk compression method.
> Complete functionality will be added in subsequent patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 854e8609bd..0eaea9b0c3 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -632,12 +632,15 @@
>  #       the deflate compression algorithm and use the Intel In-Memory Analytics
>  #       Accelerator(IAA) accelerated compression and decompression. (Since 9.1)
>  #
> +# @uadk: use UADK library compression method. (Since 9.1)

Two spaces after '.' for consistency, please.

> +#
>  # Since: 5.0
>  ##
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> -            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
> +            { 'name': 'qpl', 'if': 'CONFIG_QPL' },
> +            { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
>  
>  ##
>  # @MigMode:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


