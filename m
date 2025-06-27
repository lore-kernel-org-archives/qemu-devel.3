Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E79AC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5n2-0002oQ-4w; Fri, 27 Jun 2025 05:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV5mw-0002nt-Rf
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV5mu-0006tt-9H
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gN8BioK9SEwGoTkkgmI1Ch/QmS8rGF3rCf9NA+2Or0=;
 b=RDO38i58k1hbMDe2WQNTPS3PgnA084Byc/njo6O6FCFWibizq+DQrjdy7H0uo/eSCDll3B
 +owwFBMssB5Vt6seQzmfUl5qfb7+YAfEEUrmFfG2tPAhNFKAJtA+zU12o5DLv6myB9iwRP
 KeL9K6AcIDq5Ngh4LYukeB/i36f2Gig=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-nvxo-9ocOD68d4Kzzf8_QQ-1; Fri,
 27 Jun 2025 05:54:23 -0400
X-MC-Unique: nvxo-9ocOD68d4Kzzf8_QQ-1
X-Mimecast-MFC-AGG-ID: nvxo-9ocOD68d4Kzzf8_QQ_1751018061
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFBC5180120C; Fri, 27 Jun 2025 09:54:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A85E41944CE7; Fri, 27 Jun 2025 09:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F7D821E6A27; Fri, 27 Jun 2025 11:54:17 +0200 (CEST)
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
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 2/5] docs/sphinx: parse @references in freeform text
In-Reply-To: <20250618165353.1980365-3-jsnow@redhat.com> (John Snow's message
 of "Wed, 18 Jun 2025 12:53:50 -0400")
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-3-jsnow@redhat.com>
Date: Fri, 27 Jun 2025 11:54:17 +0200
Message-ID: <87y0tdmrw6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Oversight in the new qapidoc transmogrifier: @references in freeform
> documentation blocks were not being transformed to literals. This fixes
> that, and the next patch ensures that we're testing for this O:-)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 5374dee8fad..adc14ade456 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -218,6 +218,11 @@ def generate_field(
>          typ = self.format_type(member)
>          self.add_field(kind, member.name, body, info, typ)
>  
> +    @staticmethod
> +    def reformat_arobase(text: str) -> str:

What's an "arobase"?  Inquiring mind wants to know!

> +        """ reformats @var to ``var`` """
> +        return re.sub(r"@([\w-]+)", r"``\1``", text)
> +
>      # Transmogrification helpers
>  
>      def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> @@ -361,8 +366,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>  
>          # Add sections in source order:
>          for i, section in enumerate(sections):
> -            # @var is translated to ``var``:
> -            section.text = re.sub(r"@([\w-]+)", r"``\1``", section.text)
> +            section.text = self.reformat_arobase(section.text)
>  
>              if section.kind == QAPIDoc.Kind.PLAIN:
>                  self.visit_paragraph(section)
> @@ -405,7 +409,7 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
>  
>          assert len(doc.all_sections) == 1, doc.all_sections
>          body = doc.all_sections[0]
> -        text = body.text
> +        text = self.reformat_arobase(body.text)
>          info = doc.info
>  
>          if re.match(r"=+ ", text):


