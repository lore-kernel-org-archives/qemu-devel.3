Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4020C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 08:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPzRv-0007cV-Ji; Fri, 13 Jun 2025 04:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPzRs-0007cF-Su
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPzRq-0001Lm-JS
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749802052;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G9briCDX0R/bqzbuIANMqcu9nnb/rVU98rO9V/l60Yg=;
 b=aWkuY+pYRUzr/aAxVWVak9QpOS7ACL5dk4GmNXwEIAa9PMZrjl8jizefbKu/ffFYaVoDVZ
 5QhBOIKbWVxrZZbkPWsDivovJL70vd5StWo1e8BYk9qZuUBrUWGLYbvlSuWwB2BFwLEW22
 xDsVtvnN5pDujUrSocOLtn/W42mZQ9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-pPS3JGRyO7K4FS-9fLwPoQ-1; Fri,
 13 Jun 2025 04:07:28 -0400
X-MC-Unique: pPS3JGRyO7K4FS-9fLwPoQ-1
X-Mimecast-MFC-AGG-ID: pPS3JGRyO7K4FS-9fLwPoQ_1749802048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7BB71800287; Fri, 13 Jun 2025 08:07:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC3461956050; Fri, 13 Jun 2025 08:07:25 +0000 (UTC)
Date: Fri, 13 Jun 2025 09:07:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [PATCH] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Message-ID: <aEvcOWsugIZjCKzo@redhat.com>
References: <20250613044002.106396-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613044002.106396-1-lizhijian@fujitsu.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jun 13, 2025 at 12:40:02PM +0800, Li Zhijian via wrote:
> This leak was detected by the valgrind.
> 
> The crs_range_merge() function unconditionally allocated a GPtrArray
> 'even when range->len was zero, causing an early return without freeing
> the allocated array. This resulted in a memory leak when an empty range
> was processed.
> 
> Fix this by moving the GPtrArray allocation after the empty range check,
> ensuring memory is only allocated when actually needed.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  hw/acpi/aml-build.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f8f93a9f66c8..cf1999880119 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -160,7 +160,7 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>   */
>  static void crs_range_merge(GPtrArray *range)
>  {
> -    GPtrArray *tmp = g_ptr_array_new_with_free_func(crs_range_free);
> +    GPtrArray *tmp;

IMHO it would be better to change this to

  g_autoptr(GPtrArray) tmp = g_ptr....


and remove the existing manual g_ptr_array_free call. This guarantees
it will always be released in every code path.

>      CrsRangeEntry *entry;
>      uint64_t range_base, range_limit;
>      int i;
> @@ -169,6 +169,7 @@ static void crs_range_merge(GPtrArray *range)
>          return;
>      }
>  
> +    tmp = g_ptr_array_new_with_free_func(crs_range_free);
>      g_ptr_array_sort(range, crs_range_compare);
>  
>      entry = g_ptr_array_index(range, 0);
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


