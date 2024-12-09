Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6E2E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKk2t-0007UR-Kd; Mon, 09 Dec 2024 15:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKk2k-0007Ty-Hh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKk2i-0008Ms-4O
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733774861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwSlCBp6FduhCp76jIhl8oDXE40puLzF0cV9wQrpqRI=;
 b=FUc2nJlqTx2zKeCnDaM7FtWp2GSeBPr89TESbYWB44yXEDwQYXNJBQDBMXgbqUeGqcEagD
 AsmgIu8A2AYSiM8Zmk5OgFOFGUeaxvtveNKN7ownhLGBoOnRnZfnOM8VyrFApjuS0zsWhY
 oRaE8zkTwOApDecuaH/dfaB6bokr2iY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-uvKwq06RNp683UxJJmvNcA-1; Mon, 09 Dec 2024 15:07:38 -0500
X-MC-Unique: uvKwq06RNp683UxJJmvNcA-1
X-Mimecast-MFC-AGG-ID: uvKwq06RNp683UxJJmvNcA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d895f91a7dso84679316d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774858; x=1734379658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwSlCBp6FduhCp76jIhl8oDXE40puLzF0cV9wQrpqRI=;
 b=d74lTVSKcdplUT94DPt11CjT5y/rcPr6alqdnk8sW4Gx66gpSlq3sR+49YQ2kHaUBK
 KRTXtLDqXloRQS9tO8TR0MU0DLWLdBwlopqC82TXZjmOqAvSuz0OupA/cg347x53jTWY
 Fz5k+5b7AErxqDR9YaQ8xoiysH+I9LoRxJOzLdUNNHljtJ9qgKeFDsg5Q/kJSyhP36Qa
 RR7ENuIZsYiGtv73mwH0rqXXGRGQHeQGDceWUVwpNI301VroiZb6CYr3xbspDLWaMWoU
 z4/PsjXL76v2Q35UzhDELLcUbAjlAVANi3VJwNhXWJX+P4p49lD3uEyZAqWk5nCXEsQn
 ibSg==
X-Gm-Message-State: AOJu0YzUFjCjfS0JKjYra3WiBcXeiqS+fOYv8dzY6qIqkZuyYJjOW0Kr
 d/uKHEx+PUJIgXBheHvqOKVa2PJE4jZFopziBXu4ZXDqMdqpDaiJIFAA8Zu8vvv51DY0KHI+0DK
 xBvKdEiZp/DSQVYItZG4yw7KeXmeq6qAOUG7qCNHsJ5x0VS7ooq4lrWpXzUA+
X-Gm-Gg: ASbGncuWcHq/dfWB/wuqI77hmxFDasB8RxLetCmfQpqs4+gTqRtfSdjrjcn2kF2XkSN
 7zZbpKfInWTorxmiyssVLPPrI83DLRoV8QTPsNYbknSRtMBCHRnMMi4rrHsErWL5pOIh//woPmJ
 JL9+9zrtrs0VTm14aCoaC4i6CjGK1rpGqU8NEZuEh2o84ROce6KjmDqn+efmadH9OqWaa3IFguz
 KStRLo3ag9xh+F0PBrsSXV/X71hsecvRIOJ7hIaUezgrGAOhWXwWBMk8QBCxJt4xydGMIRMkYru
 olaSJ8zUGmnUF+Q=
X-Received: by 2002:ad4:5f87:0:b0:6d8:9abb:3c28 with SMTP id
 6a1803df08f44-6d91e3d6cd8mr32942676d6.29.1733774857811; 
 Mon, 09 Dec 2024 12:07:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb4ruQlHIZt3On5VzUg+o6HUDrI0tiKuhpAvALly5NZ/j0GvoBItELekgQwLSKxCsK0I52RA==
X-Received: by 2002:ad4:5f87:0:b0:6d8:9abb:3c28 with SMTP id
 6a1803df08f44-6d91e3d6cd8mr32942316d6.29.1733774857516; 
 Mon, 09 Dec 2024 12:07:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d9004a6264sm25865676d6.87.2024.12.09.12.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:07:36 -0800 (PST)
Date: Mon, 9 Dec 2024 15:07:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
Message-ID: <Z1dOBioqzQmEwW16@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
> Save the memfd for ramblocks in CPR state, along with a name that
> uniquely identifies it.  The block's idstr is not yet set, so it
> cannot be used for this purpose.  Find the saved memfd in new QEMU when
> creating a block.  If the block size is larger in new QEMU, extend the
> block using fallocate, and the extra space will be useable after a guest
> reset.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 0bcb2cc..aa095a3 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -70,6 +70,7 @@
>  
>  #include "qemu/pmem.h"
>  
> +#include "migration/cpr.h"
>  #include "migration/vmstate.h"
>  
>  #include "qemu/range.h"
> @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>      }
>  }
>  
> +static char *cpr_name(RAMBlock *block)
> +{
> +    MemoryRegion *mr = block->mr;
> +    const char *mr_name = memory_region_name(mr);
> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> +
> +    if (id) {
> +        return g_strdup_printf("%s/%s", id, mr_name);
> +    } else {
> +        return g_strdup(mr_name);
> +    }
> +}
> +
>  size_t qemu_ram_pagesize(RAMBlock *rb)
>  {
>      return rb->page_size;
> @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>  {
>      size_t max_length = new_block->max_length;
>      MemoryRegion *mr = new_block->mr;
> -    const char *name = memory_region_name(mr);
> -    int fd;
> +    g_autofree char *name = cpr_name(new_block);
> +    int fd = cpr_find_fd(name, 0);

If to use the proposed patch in the reply of patch 2, here this should be
able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.

> +
> +    if (fd >= 0) {
> +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
> +            error_setg_errno(errp, errno,
> +                             "cannot grow ram block %s fd %d to %ld bytes",
> +                             name, fd, max_length);
> +            goto err;
> +        }

I remember we discussed something similar to this, do we need ftruncate()
at all?  I think not.

This happens when booting QEMU, so I don't think it's relevant yet to what
size used in src, as this is dest.

It starts to get relevant only when cpr migration starts on src, it sents
ramblocks at the beginning, then parse_ramblock() will properly resize any
ramblock to whatever size it should use.

If the resize didn't happen it can only mean that used_length is correctly
matched on both sides.

So I don't see why a special truncate() call is needed yet..

> +        goto have_fd;
> +    }
>  
>      if (qemu_memfd_available()) {
>          fd = qemu_memfd_create(name, max_length + mr->align, 0, 0, 0, errp);
> @@ -2111,7 +2135,9 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>              return true;
>          }
>      }
> +    cpr_save_fd(name, 0, fd);
>  
> +have_fd:
>      new_block->mr->align = QEMU_VMALLOC_ALIGN;
>      new_block->host = file_ram_alloc(new_block, max_length, fd, false, 0, errp);
>  
> @@ -2122,6 +2148,8 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>          return true;
>      }
>  
> +err:
> +    cpr_delete_fd(name, 0);
>      close(fd);
>      return false;
>  }
> @@ -2234,6 +2262,8 @@ static void reclaim_ramblock(RAMBlock *block)
>  
>  void qemu_ram_free(RAMBlock *block)
>  {
> +    g_autofree char *name = NULL;
> +
>      if (!block) {
>          return;
>      }
> @@ -2244,6 +2274,8 @@ void qemu_ram_free(RAMBlock *block)
>      }
>  
>      qemu_mutex_lock_ramlist();
> +    name = cpr_name(block);
> +    cpr_delete_fd(name, 0);
>      QLIST_REMOVE_RCU(block, next);
>      ram_list.mru_block = NULL;
>      /* Write list before version */
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


