Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4139C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBREW-0008Tb-Jn; Tue, 29 Sep 2026 02:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBRET-0008TI-M0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBRES-00072q-AG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790662947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rEQZ3DV8fHD35xRg4RzDLEEbJv/bo0qtwCb3+QQzKyw=;
 b=ZYf41yfVcDLXMXjjC6JoEx+FD95rZf6ldkSqCX69DTuS6Qo1nCXlbGQP7jmSKXq/ymstGv
 WQZl/JQzXBaAnEkEJ4zYaum/MgxD+3+Kz3TQx43Fdph59jUQD2b0GNIHv5HA2qNV2PYNh1
 ZjdnoNDxj9Uwt/RhG9x8RcJTU/f6tTU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584--bpn7pgPMWGEDL0vmWdRMg-1; Tue,
 29 Sep 2026 02:22:24 -0400
X-MC-Unique: -bpn7pgPMWGEDL0vmWdRMg-1
X-Mimecast-MFC-AGG-ID: -bpn7pgPMWGEDL0vmWdRMg_1790662942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBAB195423D; Tue, 29 Sep 2026 06:22:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 210C430000E4; Tue, 29 Sep 2026 06:22:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86F4F21E6A04; Tue, 29 Sep 2026 08:22:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Jason Wang <jasowangio@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter
 Xu <peterx@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Kevin
 Wolf <kwolf@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
Subject: Re: [PATCH v3 06/10] qapi: convert/split intros for commands
In-Reply-To: <20260928192557.509157-7-jsnow@redhat.com> (John Snow's message
 of "Mon, 28 Sep 2026 15:25:53 -0400")
References: <20260928192557.509157-1-jsnow@redhat.com>
 <20260928192557.509157-7-jsnow@redhat.com>
Date: Tue, 29 Sep 2026 08:22:18 +0200
Message-ID: <87a4p037c5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

> Convert or split apart the existing intro for any remaining commands
> in the QAPI schema into introduction and details sections. The
> introduction is indented, remaining plaintext/details paragraphs
> are not.
>
> For commands that have automatically generated documentation inserted
> at parse time, these new split points serve as the new insertion
> point. This affects the rendered documentation for `netdev_add` in
> particular, whose arguments descriptions are pushed upwards.

Missing: query-stats arguments and query-gic-capabilities "Return:" move
up.

>
> Minor rephrasings are applied for `query-qmp-schema` to help
> the split flow better in rendered documentation.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Happy to adjust commit messages without a respin.


