Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58374C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 10:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR8Ag-0002oI-LY; Tue, 09 Jul 2024 06:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR8Aa-0002mv-OT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR8AX-0007FB-9A
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720521204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tv5MZdpwUOqoKpPfIPBZhu/naPaz+bnMApf2t24nKN4=;
 b=Bw4NdNVuBuj0KRCDAtUPtm9t8cN10wB48JHZ1UXGpyDI3thZq90/TfyKO+z7I9UTbJBcur
 WZW+TURyzBZRKPdkt9vkjRS3fGyoFZ/+404kIuVUNzmvLE8ua0E7Z7MuFZfVJuZpIUcHCq
 /gHkbd98qQ3xWdTlogvAMoYJfWt7XpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-Wu970bR7NIWnOPFBQbiSJQ-1; Tue,
 09 Jul 2024 06:33:21 -0400
X-MC-Unique: Wu970bR7NIWnOPFBQbiSJQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C57C1954B38; Tue,  9 Jul 2024 10:33:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CF1319560AA; Tue,  9 Jul 2024 10:33:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1464A21E6757; Tue,  9 Jul 2024 12:33:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Ani Sinha <anisinha@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 3/8] docs/qapidoc: add QMP highlighting to annotated
 qmp-example blocks
In-Reply-To: <20240703210144.339530-4-jsnow@redhat.com> (John Snow's message
 of "Wed, 3 Jul 2024 17:01:38 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-4-jsnow@redhat.com>
Date: Tue, 09 Jul 2024 12:33:16 +0200
Message-ID: <878qyaj1n7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> For any code literal blocks inside of a qmp-example directive, apply and
> enforce the QMP lexer/highlighter to those blocks.
>
> This way, you won't need to write:
>
> ```
> .. qmp-example::
>    :annotated:
>
>    Blah blah
>
>    .. code-block:: QMP
>
>       -> { "lorem": "ipsum" }
> ```
>
> But instead, simply:
>
> ```
> .. qmp-example::
>    :annotated:
>
>    Blah blah::
>
>      -> { "lorem": "ipsum" }
> ```
>
> Once the directive block is exited, whatever the previous default
> highlight language was will be restored; localizing the forced QMP
> lexing to exclusively this directive.
>
> Note, if the default language is *already* QMP, this directive will not
> generate and restore redundant highlight configuration nodes. We may
> well decide that the default language ought to be QMP for any QAPI
> reference pages, but this way the directive behaves consistently no
> matter where it is used.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Sadly, the previous patch didn't add tests, so this patch's effect
isn't as easy to observe as it could be.

Acked-by: Markus Armbruster <armbru@redhat.com>


