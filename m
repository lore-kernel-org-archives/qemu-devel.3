Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C32DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfBV-000495-Eh; Mon, 08 Sep 2025 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvfBR-0003pr-SN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvfBE-00023s-I5
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350634;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmdJw7DJzbHKceWnT8jSOgeEr8734kgoB2kUWuUz0EE=;
 b=bJnjlJQ0Kj/nHYeoAdfC/3+6Ew08O5AaCm+uqaObtRX1ECk8wX55LjD/GWLde3s47j43j6
 NbtztNCAhe7sJtqnjbaw6h9adXu41Qik+7ys5PNeCyGDQK5Y+uPgA0HWCO5gkHi+tBywrQ
 Vb/BBwMvGAajgk01YdctJyTNPLzSoCg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-FnXb58IbPRSrqB0dbfLoMQ-1; Mon,
 08 Sep 2025 12:57:11 -0400
X-MC-Unique: FnXb58IbPRSrqB0dbfLoMQ-1
X-Mimecast-MFC-AGG-ID: FnXb58IbPRSrqB0dbfLoMQ_1757350630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58B92195609F; Mon,  8 Sep 2025 16:57:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37F3A1800452; Mon,  8 Sep 2025 16:57:07 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:57:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, "Denis V . Lunev" <den@virtuozzo.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 1/1] dump: enhance win_dump_available to report properly
Message-ID: <aL8K4I91w4dRZrCC@redhat.com>
References: <20250831161022.452426-1-nikolai.barybin@virtuozzo.com>
 <20250831161022.452426-2-nikolai.barybin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250831161022.452426-2-nikolai.barybin@virtuozzo.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Sun, Aug 31, 2025 at 07:10:22PM +0300, Nikolai Barybin wrote:
> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
> 
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
> 
> To perform this I suggest to split dump_init() into dump_preinit() and
> dump_init_complete() to avoid exausting copypaste in
> win_dump_available().
> 
> Also dump_state_prepare() and dump_cleanup() were modified to avoid
> unsafe close on fd == 0. Thus, it is initialized to -1.
> 
> For further reference one may review this libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
> 
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> ---
>  dump/dump.c     | 138 ++++++++++++++++++++++++++++--------------------
>  dump/win_dump.c |  23 ++++++--
>  dump/win_dump.h |   2 +-
>  3 files changed, 101 insertions(+), 62 deletions(-)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index 15bbcc0c61..ce8b43f819 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -103,7 +103,10 @@ static int dump_cleanup(DumpState *s)
>  
>      guest_phys_blocks_free(&s->guest_phys_blocks);
>      memory_mapping_list_free(&s->list);
> -    close(s->fd);
> +    if (s->fd != -1) {
> +        close(s->fd);
> +    }
> +    s->fd = -1;
>      g_free(s->guest_note);
>      g_clear_pointer(&s->string_table_buf, g_array_unref);
>      s->guest_note = NULL;
> @@ -1708,8 +1711,8 @@ static DumpState dump_state_global = { .status = DUMP_STATUS_NONE };
>  
>  static void dump_state_prepare(DumpState *s)
>  {
> -    /* zero the struct, setting status to active */
> -    *s = (DumpState) { .status = DUMP_STATUS_ACTIVE };
> +    /* zero the struct, setting status to active and fd to -1 */
> +    *s = (DumpState) { .fd = -1, .status = DUMP_STATUS_ACTIVE };
>  }
>


Can you do this as a separate patch, as this is a pre-existing bug that
ought to be cherry-picked to be fixed in stable too.

If this is split, then you can add

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

to both patches.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


