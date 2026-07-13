Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FEAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBM6-0000Mk-Tu; Mon, 13 Jul 2026 03:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBM4-0000MQ-Fk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBM2-0003p5-Fn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783928728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mKVnbI611gExUMjuzjUm1eZVIqPdwDXtnBh9poHdS4c=;
 b=OS6s4xl3cFcNsGf2w5FGUFhmRAGTUlk3zbHPcVR69Z1WNZFXYbbpP4dkqzEZG8SPVhGmEH
 FEAnqWrodniOl/417mu6arLDpvHfDPHo2xvBceZhxMHK3UXylV5bnTSwJfdqL/Mu6n0OxF
 hF1DaOpL4RV6836ABC6Lsd/nE2mZwic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-IZooiFzcPA6IroMRGoyIwg-1; Mon,
 13 Jul 2026 03:45:24 -0400
X-MC-Unique: IZooiFzcPA6IroMRGoyIwg-1
X-Mimecast-MFC-AGG-ID: IZooiFzcPA6IroMRGoyIwg_1783928722
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE9B18002C3; Mon, 13 Jul 2026 07:45:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1509E765; Mon, 13 Jul 2026 07:45:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A638D21E6920; Mon, 13 Jul 2026 09:45:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Sergio Lopez <slp@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Jason Wang <jasowangio@gmail.com>,  Eric Blake
 <eblake@redhat.com>,  devel@lists.libvirt.org (open list:Incompatible
 changes),  xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-ppc@nongnu.org (open list:e500),  qemu-riscv@nongnu.org (open
 list:Microchip PolarFi...)
Subject: Re: [PATCH v18 03/14] net/tap: deprecate "no" as special value for
 script/downscript
In-Reply-To: <20260710191809.721154-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 10 Jul 2026 22:17:52 +0300")
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-4-vsementsov@yandex-team.ru>
Date: Mon, 13 Jul 2026 09:45:17 +0200
Message-ID: <87ech7uycy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> The interface is ambiguous, as "no" is valid file name. So,
> using "no" as a special value to disable script is deprecated.
> Use an empty string ("script=" / "downscript=") instead.
>
> In a future version, "no" will be treated as a plain file name, just
> like any other non-empty value.
>
> Document the deprecation in docs/about/deprecated.rst, qapi/net.json,
> and qemu-options.hx. Update other docs to use empty string instead of
> "no". Add a warning.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/net/tap.c b/net/tap.c
> index fedd48c48d2..1ec9e5ebe6f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -103,6 +103,8 @@ static bool tap_is_explicit_no_script(const char *script_arg)
>      }
>  
>      if (strcmp(script_arg, "no") == 0) {
> +        warn_report("script=no/downscript=no is deprecated; "
> +                    "use script=/downscript= instead");

net_init_tap() could pass the parameter name for a simpler error
message.  Probably not worth the bother.

>          return true;
>      }
>  

In net_init_tap_one():

           qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
                             script ?: "no", downscript ?: "no");

This sets nc->info_str, which is shown by "info network".  Should we
replace "no" by ""?

[...]


