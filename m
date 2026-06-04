Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CF9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Bh-0007GY-II; Thu, 04 Jun 2026 09:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8BC-0007EZ-BX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8B8-0002Wy-VS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780579928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=62EAMSkFdaLzZr8TxdRmkp/azwCR1AtZrnccAN1JTAM=;
 b=NP0WUkVJZWwz+kiRe7nX8AzSlA1ZYBZ45kSte0IMQni8/PsAun6H7rQC7n2bK7XdcqloYY
 vvS5WLmVnxvpxnsIBtwfOYMcSNigNIguz9P1GOWrQiJMEj3MYuyPtDUQ70+lcrFGRPvDw4
 fTAfXVWyD1LNFMgU47qrJ9GS/7oS8aY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-iQCQL75-OjCZ8uM8eh5zkA-1; Thu, 04 Jun 2026 09:32:06 -0400
X-MC-Unique: iQCQL75-OjCZ8uM8eh5zkA-1
X-Mimecast-MFC-AGG-ID: iQCQL75-OjCZ8uM8eh5zkA_1780579926
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c554284973so876990137.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780579925; x=1781184725; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=62EAMSkFdaLzZr8TxdRmkp/azwCR1AtZrnccAN1JTAM=;
 b=ErdSHdcEYvm/nuO4GK1HnqdrbovNFaiehJtBIQ8FuZfLk4G1hXwoWR6e4M6I+HhHDn
 Cjf0U2OAqmusfXGIJokk8qmszNwynl9WS3iEcjVdmEH0gSN8zihx0i0UnZCbUxnaweAK
 poBKfztRk9hrLE6bFxUOJOGZqou+oKpbLnFiw483bElXwONXBa9uzGeKchOmKyFxulum
 w3JJiPVchHxL4ymq7hMZEMNIueLBwBJ7NE0VzcTktw+L+xQCn3ZPGwpyuEo0hVCZ3kWu
 Hpp3DN3jjryxIb4PuZ7OTV7JkDEXLfIr6erlOa+jR3t4Jdw/Bp5hzvs250Cs9O0z6thd
 cQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579925; x=1781184725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62EAMSkFdaLzZr8TxdRmkp/azwCR1AtZrnccAN1JTAM=;
 b=bGPdhoMMItVNzTBvTA4/EYAmSx79VtPRT6TIB2LhrZVqA/CVibypxBk6HjBty6ST+N
 bPiVYrm2ElpVyHbeBhln3e9DOn2RMrYpCjNIKxJrin1kU5XyJCBzoebKwp6C0473jy+7
 BzDGI1VcgYoY8lHPRRn1DVZnomeDoF15qbeCNv572BK49xwOAiYGtfdC24zRILdyiYYh
 tTTV+hrJgqKCSEzdx8O/3cWlVQOUrTjZBSylIuvU2dqOtw6SLUyzDF1iAZvjDy8RjwFd
 f1+OWYBzfzkHQPMMFhu0KJjMhVzoldvMJHRiRiQF0ST8iPrfSEPyFKIbhFXbnVj8Au45
 qoeQ==
X-Gm-Message-State: AOJu0YyIfuOYgINAyE8iYxiBJwmiEewcEsrAkhR0mavW3j2I4C7ZAe8Z
 Evwczv1KCB51B4EGZDwN8w1GSnq1PanvMK7natdKb79HT3zsXE2lySlwBdKmHOiQ0zBKWgYjlJb
 r3ILKGwyTgiYormUksl+isepfcUCTvD5u9lZkLs1h8Qq4/5ua1T17gpKd
X-Gm-Gg: Acq92OHbaiD+2MWX3x4WEKcGLkICHvDlOt2C3I5yYwPze9+IpzwCOJUYd38QZzeMe7D
 fplr2lLf1DBh5aYHQy2rqlNGli+iynCkrx0ttrrw+xiwDNM02pX1yBklZyGMat2w7ImyHj/rzA2
 FobhI0b7he3dGeCJfR2TdyKG7tVkZr5QSFO0NkSGrV5KbLGk5bE5coZC2Nhn8q7sKjaN9VMoSiF
 PQWmrngOPGji/qeLphJs335mQPHUgj5oEQn4xXdk939HmREkQo2/MfMD9bzT37mkNdGsDwdE5At
 2bPdzQztuHEC8prvnPdI9A5vqx0eRJlErNEpFzTEk6N1oYZZ9o7ZDDg58HX1OYM1EbYQJtwTR+W
 jkfjtIPzqtkklCo+M6biY7HPr5g==
X-Received: by 2002:a05:6102:290b:b0:632:a084:c0f7 with SMTP id
 ada2fe7eead31-6ec444ce8f3mr4585643137.17.1780579925509; 
 Thu, 04 Jun 2026 06:32:05 -0700 (PDT)
X-Received: by 2002:a05:6102:290b:b0:632:a084:c0f7 with SMTP id
 ada2fe7eead31-6ec444ce8f3mr4585586137.17.1780579925047; 
 Thu, 04 Jun 2026 06:32:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00ac5esm594260285a.6.2026.06.04.06.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:32:04 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:32:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] system/physmem: Assert migration invariants
Message-ID: <aiF-U4gTz1n4IMBr@x1.local>
References: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 02:26:13PM +0900, Akihiko Odaki wrote:
> The migration stream assumes that the set of migratable RAMBlocks does
> not change while migration is running. Assert that RAMBlocks are not
> made migratable or non-migratable during migration, and that migratable
> RAMBlocks are not freed during migration.
> 
> Non-migratable RAMBlocks may still be allocated or freed during
> migration; for example, QMP object-add of memory-backend-ram creates a
> non-migratable RAMBlock without exposing it to the guest.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  system/physmem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf8757361..42a39141645e 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -39,6 +39,7 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/boards.h"
> +#include "migration/misc.h"
>  #include "system/xen.h"
>  #include "system/kvm.h"
>  #include "system/tcg.h"
> @@ -1911,11 +1912,13 @@ bool qemu_ram_is_migratable(const RAMBlock *rb)
>  
>  void qemu_ram_set_migratable(RAMBlock *rb)
>  {
> +    assert(!migration_is_running());
>      rb->flags |= RAM_MIGRATABLE;
>  }
>  
>  void qemu_ram_unset_migratable(RAMBlock *rb)
>  {
> +    assert(!migration_is_running());
>      rb->flags &= ~RAM_MIGRATABLE;
>  }
>  
> @@ -2599,6 +2602,8 @@ void qemu_ram_free(RAMBlock *block)
>          return;
>      }
>  
> +    assert(!migration_is_running() || !qemu_ram_is_migratable(block));
> +

The intention makes sense, however these asserts are slightly risky to me
on a few things..

Firstly, migration_is_running() covers a wide range, the tricky part is
when CANCELLING and FAILING: when QEMU shutdowns with qemu_cleanup(), it
only kicks the migration out with migration_cancel(), it won't wait for
migration to finish completely.  I didn't verify the possibility, but IIUC
it means during QEMU tearing down we may have ramblock freed while
migration_is_running() returns true.

Above will also include possibility of changing migration migratable. In
this specific case, it's about marking ramblock to be unmigratable during
tearing down with a call to vmstate_unregister_ram().

The other thing is, strictly speaking the migration ABI is not ramblock
pointers, but a combination of ramblock ID+page_size+addr+... info, per
ram_save_setup().  I don't know if there's legal user (I'm having some form
of ROMs in mind..) that may silently replace a ramblock pointer but kept
everything else intact..

Thanks,

>      if (block->host) {
>          ram_block_notify_remove(block->host, block->used_length,
>                                  block->max_length);
> 
> ---
> base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
> change-id: 20260602-migration-15128dbe4036
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

-- 
Peter Xu


