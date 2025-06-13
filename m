Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1E7C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 09:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ0Ll-0002kh-9C; Fri, 13 Jun 2025 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uQ0Lj-0002k8-Ms
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uQ0Lh-0002PZ-Fu
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749805519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HZ/pxyFuLzrddWOkc+HkqrDC3VLR6rdYJt+PZIWdD8=;
 b=PPUWu56ZCKtImBbOYYw95Vp4Z60K1Gizli4EyukyBIvLaJVfy8OLPNqG8JUpuio+AYn/+7
 +LIQDIsm4LozCXtHINmUbtKRsIGOGFVrv1fM3FcoWi3D4GZ6lq5CCP73N4sJ494HDD+CUU
 AsRuLFqxF64jjUmO+itvTsH6VvXhIS4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-j10OhrEdN_SYoBzvlftmJw-1; Fri,
 13 Jun 2025 05:05:15 -0400
X-MC-Unique: j10OhrEdN_SYoBzvlftmJw-1
X-Mimecast-MFC-AGG-ID: j10OhrEdN_SYoBzvlftmJw_1749805515
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0D818089B5; Fri, 13 Jun 2025 09:05:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6825B1956050; Fri, 13 Jun 2025 09:05:12 +0000 (UTC)
Date: Fri, 13 Jun 2025 10:05:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [PATCH v2] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Message-ID: <aEvpxGwmxXrUBVRn@redhat.com>
References: <20250613085110.111204-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613085110.111204-1-lizhijian@fujitsu.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Jun 13, 2025 at 04:51:10PM +0800, Li Zhijian wrote:
> This leak was detected by the valgrind.
> 
> The crs_range_merge() function unconditionally allocated a GPtrArray
> 'even when range->len was zero, causing an early return without freeing
> the allocated array. This resulted in a memory leak when an empty range
> was processed.
> 
> Instead of moving the allocation after the check (as previously attempted),
> use g_autoptr for automatic cleanup. This ensures the array is freed even
> on early returns, and also removes the need for the explicit free at the
> end of the function.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


