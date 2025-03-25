Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD702C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 09:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx0nP-0004X8-Dz; Tue, 25 Mar 2025 05:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tx0nK-0004Vp-CT
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tx0nH-0007zZ-GH
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742895717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAW46X5yGKzXIH3YllCLDdXsaHtJudmyTQGY+YT4nm8=;
 b=aZeYR62mQIAKIb0sWXAhSQokh3oHX/Nb0BE+0cMI1QyIbAERhdX3AF33ef9KLGgZowlq17
 Cq3leVNI2O9ssNnGHOLVyFmNtWNlXKfKjouS8uKLo57WDmgdwbQGRzLEKEMoz5mFvzgRfr
 gqJo4FuWqy4mffgIj1ssm5NHAuE9PKk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Ot9luC9jPUGbZ5AlPDEuZg-1; Tue,
 25 Mar 2025 05:41:54 -0400
X-MC-Unique: Ot9luC9jPUGbZ5AlPDEuZg-1
X-Mimecast-MFC-AGG-ID: Ot9luC9jPUGbZ5AlPDEuZg_1742895711
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 746B5196B344; Tue, 25 Mar 2025 09:41:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DE71801756; Tue, 25 Mar 2025 09:41:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B687321E66C5; Tue, 25 Mar 2025 10:41:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Lukas Straub <lukasstraub2@web.de>,  Fabiano
 Rosas <farosas@suse.de>,  Eduardo Habkost <eduardo@habkost.net>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  qemu-trivial@nongnu.org,  Jason Wang
 <jasowang@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Peter Maydell
 <peter.maydell@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,  Yanan
 Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  qemu-block@nongnu.org,  Zhenwei Pi
 <pizhenwei@bytedance.com>,  Mads Ynddal <mads@ynddal.dk>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/4] docs, qapi: generate undocumented return sections
In-Reply-To: <20250322010857.309490-3-jsnow@redhat.com> (John Snow's message
 of "Fri, 21 Mar 2025 21:08:55 -0400")
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-3-jsnow@redhat.com>
Date: Tue, 25 Mar 2025 10:41:44 +0100
Message-ID: <87cye5mopz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> This patch changes the qapidoc transmogrifier to generate Return value
> documentation for any command that has a return value but hasn't
> explicitly documented that return value.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 949d9e8bff7..8c382a049af 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -815,6 +815,17 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
>                                 % feature.name)
>          self.features[feature.name].connect(feature)
>  
> +    def ensure_returns(self, info: QAPISourceInfo) -> None:
> +        if not any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
> +
> +            # Stub "Returns" section for undocumented returns value.
> +            # Insert stub after the last non-PLAIN section.

Can you explain why that's where it should go?

Should we tighten section order some more?

> +            for sect in reversed(self.all_sections):
> +                if sect.kind != QAPIDoc.Kind.PLAIN:
> +                    stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
> +                    idx = self.all_sections.index(sect) + 1
> +                    self.all_sections.insert(idx, stub)
> +
>      def check_expr(self, expr: QAPIExpression) -> None:
>          if 'command' in expr:
>              if self.returns and 'returns' not in expr:
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index cbe3b5aa91e..3abddea3525 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
>              if self.arg_type and self.arg_type.is_implicit():
>                  self.arg_type.connect_doc(doc)
>  
> +            if self.ret_type and self.info:
> +                doc.ensure_returns(self.info)
> +
>      def visit(self, visitor: QAPISchemaVisitor) -> None:
>          super().visit(visitor)
>          visitor.visit_command(


