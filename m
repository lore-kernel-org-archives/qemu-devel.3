Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DBC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6o75-0001sH-Oc; Wed, 16 Sep 2026 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6o6u-0001qg-Ey
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6o6s-0003MY-DI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789559247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IH86kDKELqjP/5qSQBmMZ+BZCl1owB/Bg4798F1FsW4=;
 b=jLmtxqz3iNjpohuloYi3D3w/EKgC3xtxdzbpZTsIY9/SxJlZ6gsdtAHwThz5MpbXijlK5T
 KvlZoUCnLpovAog2pPB2V4CWM+dHHNaKBUkLFeReh2Z249TmOWGvVIfgueOFlhXMplj9d1
 wXSoatIzhuex02tOgQLQMYxNBZ2+XfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-DNM0OeyPPB6o8hwDPA1TkA-1; Wed,
 16 Sep 2026 07:47:24 -0400
X-MC-Unique: DNM0OeyPPB6o8hwDPA1TkA-1
X-Mimecast-MFC-AGG-ID: DNM0OeyPPB6o8hwDPA1TkA_1789559241
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F072197765D; Wed, 16 Sep 2026 11:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B58418; Wed, 16 Sep 2026 11:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E05A221E6A04; Wed, 16 Sep 2026 13:47:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Jason Wang
 <jasowangio@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9?=
 <berrange@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 6/9] qapi: split intro sections for events
In-Reply-To: <20260911203002.305316-7-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 16:29:59 -0400")
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-7-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 13:47:13 +0200
Message-ID: <87mrtha05a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> Review notes: Only one event; as in the command splitting patch, the
> details section is not physically relocated; I will change this if
> requested - but as we are not finished review, I prefer to keep it
> this way to ensure mechanical ease of separating "changes" from
> "motion" as is customary in our lands.
>
> (Hint: relocating "Since:" and "Details" sections is a colossal amount
> of purely mechanical motion, so I recommend we simply deal with it all
> at once when we are done agreeing on the splits.)

Future patches.  We need to keep the conversion patches focused on just
the conversion, or else they become unreviewable.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine-s390x.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index dcbad9b4039..670a1f9d926 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -57,8 +57,7 @@
>  
>  ##
>  # @CPU_POLARIZATION_CHANGE:
> -#
> -# Emitted when the guest asks to change the polarization.
> +#     Emitted when the guest asks to change the polarization.
>  #
>  # The guest can tell the host (via the PTF instruction) whether the
>  # CPUs should be provisioned using horizontal or vertical

"Intro" conversion is pretty much the same for commands and events.  I'd
squash this into the previous patch, and call it "for commands and
events".  Up to you.


