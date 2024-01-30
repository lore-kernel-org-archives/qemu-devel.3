Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C058CC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlWG-0005zy-7M; Tue, 30 Jan 2024 05:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUlVL-0005Iw-9A
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUlVI-00010z-Ig
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706611086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2/EcyCNiI+jflk+8iL8wj0SgifDbWGcWN7zqkoRF7gQ=;
 b=JiOAGYgy0zoPqCf3OKvnQHDWNXO3AkJbTa0PqqpraQPdU+EDOdU/nWV2dUSrfE6PLtSfXA
 5Pil7ftqOsfxjI4mxEK0YWAh0Q4gvm8vZc7Jp8BRWtCdE42MoNE/1NpC/ty+OaRxXxVEw/
 Qd3B16KLVEIxRuqHhZnoFOsff4KkKJw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-tipCjgIGPCyb9nAPWyI_WQ-1; Tue,
 30 Jan 2024 05:38:02 -0500
X-MC-Unique: tipCjgIGPCyb9nAPWyI_WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DB4D38143A9;
 Tue, 30 Jan 2024 10:38:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2AF107BD;
 Tue, 30 Jan 2024 10:38:01 +0000 (UTC)
Date: Tue, 30 Jan 2024 10:37:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com, akihiko.odaki@daynix.com
Subject: Re: [PATCH v8 1/5] ebpf: Added eBPF map update through mmap.
Message-ID: <ZbjRhyNtjajkYQ8i@redhat.com>
References: <20240125130656.425607-1-andrew@daynix.com>
 <20240125130656.425607-2-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125130656.425607-2-andrew@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 25, 2024 at 03:06:50PM +0200, Andrew Melnychenko wrote:
> Changed eBPF map updates through mmaped array.
> Mmaped arrays provide direct access to map data.
> It should omit using bpf_map_update_elem() call,
> which may require capabilities that are not present.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf_rss.c | 120 ++++++++++++++++++++++++++++++++++++++----------
>  ebpf/ebpf_rss.h |   8 +++-
>  2 files changed, 101 insertions(+), 27 deletions(-)
> 
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index cee658c158..c6e10265a7 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -7,8 +7,7 @@
>   *  Andrew Melnychenko <andrew@daynix.com>
>   *  Yuri Benditovich <yuri.benditovich@daynix.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2.  See
> - * the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later


> diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> index bf3f2572c7..404cf53613 100644
> --- a/ebpf/ebpf_rss.h
> +++ b/ebpf/ebpf_rss.h
> @@ -7,8 +7,7 @@
>   *  Andrew Melnychenko <andrew@daynix.com>
>   *  Yuri Benditovich <yuri.benditovich@daynix.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2.  See
> - * the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #ifndef QEMU_EBPF_RSS_H

Thee are changing the file license. This *must* be done as a
standalone commit and show agreement from all contributors
who could hold copyright over the code. Fortunately I only
see one other contributor to these file, and the scope of
their change isn't copyrightable IMHO.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


