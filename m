Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5698C8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDYO-0003Ft-QU; Mon, 30 Jun 2025 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWDYM-0003FU-SC
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWDYJ-0004ak-L3
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751286240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vbPTnOJtHranLReIjtDv0x7dfcEl3Z817Ldp5LDBF8I=;
 b=glqHX3PzGwy6ENyNXA4LgVU2vAhQkShPO8RP9frvcrNlIuAfC5CQTBYjlfhm4DhdhiU996
 G2K5ezlJ8AZLxNW6U6eTtd1hnJKPjXuJbzC3i+ZMHyaEpf0G3LnM+7P951ME3BqGyHMIUw
 JbA4QAiBHCKbgeQkIwlPYJfWjokDKSE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-ZOrlGgDBO561AL9CwwlqQQ-1; Mon,
 30 Jun 2025 08:23:57 -0400
X-MC-Unique: ZOrlGgDBO561AL9CwwlqQQ-1
X-Mimecast-MFC-AGG-ID: ZOrlGgDBO561AL9CwwlqQQ_1751286234
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B642180120D; Mon, 30 Jun 2025 12:23:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B6FF30001B1; Mon, 30 Jun 2025 12:23:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D658C21E6A27; Mon, 30 Jun 2025 14:23:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Fan Ni
 <fan.ni@samsung.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-block@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Kashyap Chamarthy
 <kchamart@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Ani
 Sinha <anisinha@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,  Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/5] docs/sphinx: adjust qapidoc to cope with
 same-line error sections
In-Reply-To: <20250618165353.1980365-2-jsnow@redhat.com> (John Snow's message
 of "Wed, 18 Jun 2025 12:53:49 -0400")
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-2-jsnow@redhat.com>
Date: Mon, 30 Jun 2025 14:23:48 +0200
Message-ID: <87cyala04r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Signed-off-by: John Snow <jsnow@redhat.com>

Let's mention the reproducer: "# Errors: some" in doc-good.json with
:transmogrify:.

> ---
>  docs/sphinx/qapidoc.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 8011ac9efaf..5374dee8fad 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -267,10 +267,14 @@ def visit_returns(self, section: QAPIDoc.Section) -> None:
>          self.add_field("return", typ, section.text, section.info)
>  
>      def visit_errors(self, section: QAPIDoc.Section) -> None:
> -        # FIXME: the formatting for errors may be inconsistent and may
> -        # or may not require different newline placement to ensure
> -        # proper rendering as a nested list.
> -        self.add_lines(f":error:\n{section.text}", section.info)
> +        # If the section text does not start with a space, it means text
> +        # began on the same line as the "Error:" string and we should
> +        # not insert a newline in this case.
> +        if section.text[0].isspace():
> +            text = f":error:\n{section.text}"
> +        else:
> +            text = f":error: {section.text}"
> +        self.add_lines(text, section.info)
>  
>      def preamble(self, ent: QAPISchemaDefinition) -> None:
>          """


