Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A15BD148B7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkU7-0008Sn-47; Thu, 08 Jan 2026 02:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdkU4-0008Rx-KW
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdkU2-0002TB-UI
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZEJzH8zNqEN24XyrDDD3UnIg1V04dCfarWSE/HPOqY=;
 b=XqOE7vwl7GKF1SZID21VRJMcmvD/lO80tZv4dMGRF+iaM4DeRqfX+371AUKR2KzmDjwCAd
 oFjSso2sHqFvDD8AGWNaW8gQNO9C5+XNd1ft0aKV8x/rj6EcXD2hMfpxpddZdqPshjmhqR
 09NJm/CzRA8HWWtLQ22w6kmNQCgpJb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-KkEvVxS-OHaLUAbxqNyq0Q-1; Thu,
 08 Jan 2026 02:31:00 -0500
X-MC-Unique: KkEvVxS-OHaLUAbxqNyq0Q-1
X-Mimecast-MFC-AGG-ID: KkEvVxS-OHaLUAbxqNyq0Q_1767857459
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE49180034F; Thu,  8 Jan 2026 07:30:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4746180066A; Thu,  8 Jan 2026 07:30:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A85521E66CC; Thu, 08 Jan 2026 08:30:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v2 1/7] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
In-Reply-To: <20251229231546.50604-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 30 Dec 2025 00:15:39
 +0100")
References: <20251229231546.50604-1-philmd@linaro.org>
 <20251229231546.50604-2-philmd@linaro.org>
Date: Thu, 08 Jan 2026 08:30:55 +0100
Message-ID: <87v7hcd0i8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> cpu_get_phys_page_debug() takes a vaddr type since commit
> 00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
> hook").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  monitor/hmp-cmds-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index e9820611466..2976f986d35 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>=20=20
>  void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>  {
> -    target_ulong addr =3D qdict_get_int(qdict, "addr");
> +    vaddr addr =3D qdict_get_int(qdict, "addr");
>      CPUState *cs =3D mon_get_cpu(mon);
>      hwaddr gpa;

       if (!cs) {
           monitor_printf(mon, "No cpu\n");
           return;
       }

       gpa  =3D cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
       if (gpa =3D=3D -1) {
           monitor_printf(mon, "Unmapped\n");
       } else {
           monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
                          gpa + (addr & ~TARGET_PAGE_MASK));

Pardon my ignorant question: is HWADDR_PRIx appropriate for vaddr?

       }
   }


