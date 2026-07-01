Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F63C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenJu-0002Oc-3h; Wed, 01 Jul 2026 01:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wenJo-0002Nr-VT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wenJm-0004u3-89
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782883020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peWTpTg7JqFAW0LkxxYWDjYDZtHG8zrUND5SPB98CHc=;
 b=JILnkAIv7FpRW+KvoNkCMIfh4hCr5WY/5Dw6FYMw+znJ1zll8/6dQgTN/7jgIv44CH04dF
 ojS4p8leqCCivzSWlS3K12n4WsdKh2dLdP/vlId8axzwOoosTt39Zr+Ydqkl+g17Zzf0fr
 rM3mVWHywtxEsKaj2QtLLmoI5xjFPkQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-iTcLylwGORm4VX27-UsSdQ-1; Wed,
 01 Jul 2026 01:16:59 -0400
X-MC-Unique: iTcLylwGORm4VX27-UsSdQ-1
X-Mimecast-MFC-AGG-ID: iTcLylwGORm4VX27-UsSdQ_1782883018
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB28184A0B0; Wed,  1 Jul 2026 05:16:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 893891800586; Wed,  1 Jul 2026 05:16:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5D8621E6920; Wed, 01 Jul 2026 07:16:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Christian S. Lima" <christianslima@proton.me>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2] disas: converts malloc to g_new0
In-Reply-To: <20260630223159.68737-1-christianslima@proton.me> (Christian
 S. Lima's message of "Tue, 30 Jun 2026 22:32:04 +0000")
References: <20260630223159.68737-1-christianslima@proton.me>
Date: Wed, 01 Jul 2026 07:16:54 +0200
Message-ID: <87echnwapl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Christian S. Lima" <christianslima@proton.me> writes:

> Following the qemu coding style change from malloc to g_new0, the
> advantages are that g_new0 catch multiplication overflowing size_t,
> allows for better detection of type errors because it returns the type
> itself and initialize memory with zeros to detect if something go wrong.

In general, just-in-case zero-initialization won't detect anything, it
just converts unpredictable bad behavior to predictable bad behavior.

In this case, it does exactly nothing, as we'll see below.

>
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
> Changes in v2:
>     - Change from g_malloc0 to g_new0
> ---
>  disas/m68k.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/disas/m68k.c b/disas/m68k.c
> index 800b4145ac..c3571783b0 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -1887,8 +1887,7 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *info)
>  
>        /* Then create a sorted table of pointers
>  	 that point into the unsorted table.  */
> -      opc_pointer[0] = malloc (sizeof (struct m68k_opcode *)
> -                               * m68k_numopcodes);
> +      opc_pointer[0] = g_new0(const struct m68k_opcode *, m68k_numopcodes);
>        opcodes[0] = opc_pointer[0];
>  
>        for (i = 1; i < 16; i++)
           {
             opc_pointer[i] = opc_pointer[i - 1] + numopcodes[i - 1];
             opcodes[i] = opc_pointer[i];
           }

This obviously overwrites every single bit in opc_pointer[], i.e. the
switch from allocating uninitialized to zero-initialzed memory is a
complete waste.  I'd use g_new().  Up to the maintainer.

Either way,
Reviewed-by: Markus Armbruster <armbru@redhat.com>


