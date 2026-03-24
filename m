Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249FAE9A779
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51CU-0003Ob-0O; Tue, 24 Mar 2026 08:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w51CP-0003Nm-Pr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w51CO-00031u-CF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774356570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuIpKLCqv40NguKHz99EojGHLMY8g18ZVqpR35UynP0=;
 b=cqM/scyvdriNXrfWbiYAcMJ3kSx3ezlJXLp0jP7vNLV6LgcSPj1D4/9giNc/TQFAeb6PLE
 vOX3AfrF6DRYxwFJ2/OaokgWbCXRENA7jL9s5BZRBS/OCZJwJb+yboe8PsPgcOgreKQGvB
 PM9Qm/lGFrMKtECH4dR5d9TPB4IrWxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-rQXyI2h6Nsa30pmaqgSu8A-1; Tue,
 24 Mar 2026 08:49:27 -0400
X-MC-Unique: rQXyI2h6Nsa30pmaqgSu8A-1
X-Mimecast-MFC-AGG-ID: rQXyI2h6Nsa30pmaqgSu8A_1774356565
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7834F18002C9; Tue, 24 Mar 2026 12:49:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F375230001BB; Tue, 24 Mar 2026 12:49:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9834221E6937; Tue, 24 Mar 2026 13:49:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH-for-11.1 v6 1/6] target/sparc/monitor: Dump all
 registers as 32-bit
In-Reply-To: <20260320091019.59902-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 20 Mar 2026 10:10:13
 +0100")
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-2-philmd@linaro.org>
Date: Tue, 24 Mar 2026 13:49:22 +0100
Message-ID: <87tsu5s88d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> All these SPARC64 registers are 32-bit since their introduction
> in commit 3475187dd81 ("sparc64 merge"), see target/sparc/cpu.h:
>
>   511 #if defined(TARGET_SPARC64)
>   ...
>   515     uint32_t asi;
>   516     uint32_t pstate;
>   ...
>   519     uint32_t cansave, canrestore, otherwin, wstate, cleanwin;
>
> Set MonitorDef::type to MD_I32 to dump them as 32-bit.

What are they dumped as before this patch?

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/sparc/monitor.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index a60671a60a4..e9300ded4ad 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>=20=20
>  const MonitorDef monitor_defs[] =3D {
>  #ifdef TARGET_SPARC64
> -    { "asi", offsetof(CPUSPARCState, asi) },
> -    { "pstate", offsetof(CPUSPARCState, pstate) },
> -    { "cansave", offsetof(CPUSPARCState, cansave) },
> -    { "canrestore", offsetof(CPUSPARCState, canrestore) },
> -    { "otherwin", offsetof(CPUSPARCState, otherwin) },
> -    { "wstate", offsetof(CPUSPARCState, wstate) },
> -    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
> +    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
> +    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
> +    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
> +    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
> +    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
> +    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
> +    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
>  #endif
>      { NULL },
>  };


