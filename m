Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6388C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQVY-0002By-7s; Tue, 30 Jun 2026 00:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weQVW-0002Bk-KA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weQVV-0000XA-6c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782795335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IUY/PFGSNjQIwxJ34hz7sL526p+vLYRkkBsOvmGx4tE=;
 b=ecxDa2dGstlVJe9Kox9O36jdiQi7BXm55udCxthU6trzJhM7jPxK1gRGiBZONpH0Svv15I
 mRrP9dWtVTvOvVjl1wXKYEHCb1XXTVLY6vuvEtiM++vnjcWYzj4ZS6tT/+gFVly6Z5qPei
 Z0ElOXfMtU2FCmDYl3Yz50Hlh1veDsA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-SkgbIHUDN_-pa5XmguXK_g-1; Tue,
 30 Jun 2026 00:55:33 -0400
X-MC-Unique: SkgbIHUDN_-pa5XmguXK_g-1
X-Mimecast-MFC-AGG-ID: SkgbIHUDN_-pa5XmguXK_g_1782795332
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3510D1955F45; Tue, 30 Jun 2026 04:55:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9C7D1956042; Tue, 30 Jun 2026 04:55:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D8C021E6920; Tue, 30 Jun 2026 06:55:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Christian S. Lima" <christianslima@proton.me>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] disas: converts malloc to g_malloc0
In-Reply-To: <20260630005249.143976-1-christianslima@proton.me> (Christian
 S. Lima's message of "Tue, 30 Jun 2026 00:52:56 +0000")
References: <20260630005249.143976-1-christianslima@proton.me>
Date: Tue, 30 Jun 2026 06:55:29 +0200
Message-ID: <87qzlor5j2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Following the qemu coding style change malloc to g_malloc, the
> advantages are that g_malloc will exit if some failure occur and
> initialize all memory with zeros.

Any particular reason to initialize, or is it "just in case"?

> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>  disas/m68k.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disas/m68k.c b/disas/m68k.c
> index 800b4145ac..e629f3c365 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -1887,8 +1887,8 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *info)
>  
>        /* Then create a sorted table of pointers
>  	 that point into the unsorted table.  */
> -      opc_pointer[0] = malloc (sizeof (struct m68k_opcode *)
> -                               * m68k_numopcodes);
> +      opc_pointer[0] = g_malloc0 (sizeof (struct m68k_opcode)
> +                                  * m68k_numopcodes);
>        opcodes[0] = opc_pointer[0];
>  
>        for (i = 1; i < 16; i++)

g_new0(struct m68k_opcode, m68k_numopcodes) would be more obviously
safe, because it checks the multiplication for for overflow.


