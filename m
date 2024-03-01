Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E843CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxJs-0000UI-Ih; Fri, 01 Mar 2024 02:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfxJr-0000U6-8U
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfxJp-0007Ig-Hb
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TW/sQL+L44TcAv3nLFpHgTszTJWKgob58p1RrAnjHIY=;
 b=TtQukgHRIVlI/uNXDde2q2NaMUW83Y1UITaqv/yxGDif4or/SyTNA1fPwb46EJGIvfQEhF
 shHWXb1rbxAruFe4sdP8OTy405tjcoF77fVf1UrFwyruNdAm2jgwLB8wehlUyVH8gYYYSB
 GTi1otiQAOlz0g13wkixuBdsmBZpBCY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-wQKMFSxbNVuqa8noTXQMJQ-1; Fri,
 01 Mar 2024 02:28:31 -0500
X-MC-Unique: wQKMFSxbNVuqa8noTXQMJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 996B53C0FC80;
 Fri,  1 Mar 2024 07:28:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 747481121312;
 Fri,  1 Mar 2024 07:28:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66DD021E6743; Fri,  1 Mar 2024 08:28:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <20240301022829.3390548-3-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Fri, 1 Mar 2024 02:28:24 +0000")
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com>
Date: Fri, 01 Mar 2024 08:28:29 +0100
Message-ID: <871q8uqule.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> 1. Add zero_pages field in MultiFDPacket_t.
> 2. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> 5. Adds zero page counters and updates multifd send/receive tracing
> format to track the newly added counters.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8da05dba47..846d0411d5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -671,10 +671,15 @@
>  #
>  # @legacy: Perform zero page checking in main migration thread.
>  #
> +# @multifd: Perform zero page checking in multifd sender thread.
> +#     This option only takes effect if migration capability multifd
> +#     is set.  Otherwise, it will have the same effect as legacy.

Suggest

   # @multifd: Perform zero page checking in multifd sender thread if
   #     multifd migration is enabled, else in the main migration
   #     thread as for @legacy.

Thoughts?

> +#
>  # Since: 9.0
> +#
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'none', 'legacy' ] }
> +  'data': [ 'none', 'legacy', 'multifd' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


