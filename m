Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EDEC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Py-0000Ac-7C; Fri, 14 Jun 2024 05:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sI3Pw-00009h-4t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sI3Pu-0000vv-IH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdesrs1l0Lk7EZsEEX2Iewh3bNF/VYM3fBJSW3lR6ik=;
 b=h6fSrwVG2DW7/zoJx5IXx2jhVnIxsLLFhaH18Xno/MzzL6arl5QQzMGQyCY91DjFiPvyRX
 JM4voAsXJmF5Z+ZbIKtGs+6Ds9Ql/i6N3WhSS5XU5guSCdhQdEx7QiM08DsLgw+scwa7WV
 /QNp7JbONk1sA8NEpcKe69NJRXlba1M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-wD5nlUt6MEuiE-O2K8JYHg-1; Fri,
 14 Jun 2024 05:40:13 -0400
X-MC-Unique: wD5nlUt6MEuiE-O2K8JYHg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F611195608C; Fri, 14 Jun 2024 09:40:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F8C1956056; Fri, 14 Jun 2024 09:40:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 764F621E6682; Fri, 14 Jun 2024 11:40:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 11/20] qapi/schema: add doc_visible property to
 QAPISchemaDefinition
In-Reply-To: <20240514215740.940155-12-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:30 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-12-jsnow@redhat.com>
Date: Fri, 14 Jun 2024 11:40:06 +0200
Message-ID: <878qz750cp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> The intent here is to mark only certain definitions as visible in the
> end-user docs.
>
> All commands and events are inherently visible. Everything else is
> visible only if it is a member (or a branch member) of a type that is
> visible, or if it is named as a return type for a command.
>
> Notably, this excludes arg_type for commands and events, and any
> base_types specified for structures/unions. Those objects may still be
> marked visible if they are named as members from a visible type.

Why?  I figure the answer is "because the transmogrifier inlines the
things excluded".  Correct?

> This does not necessarily match the data revealed by introspection: in
> this case, we want anything that we are cross-referencing in generated
> documentation to be available to target.

I don't get the part after the colon.

> Some internal and built-in types may be marked visible with this
> approach, but if they do not have a documentation block, they'll be
> skipped by the generator anyway. This includes array types and built-in
> primitives which do not get their own documentation objects.
>
> This information is not yet used by qapidoc, which continues to render
> documentation exactly as it has. This information will be used by the
> new qapidoc (the "transmogrifier"), to be introduced later. The new
> generator verifies that all of the objects that should be rendered *are*
> by failing if any cross-references are missing, verifying everything is
> in place.

So... we decide "doc should be visible" here, and then the
transmogrifier decides again, and we check the two decisions match?

> Signed-off-by: John Snow <jsnow@redhat.com>


