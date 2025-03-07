Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B82C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWlP-0002NH-L3; Fri, 07 Mar 2025 07:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWlG-0002HP-UD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWlF-0004i2-1T
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741350303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/L4usOXrbv2HZEzOo0o5gx0tWZclu1+BbkPGTgaWr4=;
 b=HPnA8GsouvPz3gZFWGep35rQ9lMYm7jvL7xA9P3cYDPyC95gztJSzkMPnU/IQhma1CpYMy
 bchWGPsTG4TJjyVMmjZZAS4YhFMXvZhqblJRRYGHwWFmA9dwsKHcInZ97BrBBGBR8sy2gs
 uxXjcP9ogzClXl9k92V3CxKL80Vch6A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-o2TvIJgnN9Ker-EcMa-GKw-1; Fri,
 07 Mar 2025 07:24:59 -0500
X-MC-Unique: o2TvIJgnN9Ker-EcMa-GKw-1
X-Mimecast-MFC-AGG-ID: o2TvIJgnN9Ker-EcMa-GKw_1741350298
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1595C195608B; Fri,  7 Mar 2025 12:24:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F061955DCE; Fri,  7 Mar 2025 12:24:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38B3621E675E; Fri, 07 Mar 2025 13:24:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 49/57] docs/qapidoc: add visit_member() method
In-Reply-To: <20250305034610.960147-50-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:58 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-50-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:24:54 +0100
Message-ID: <871pv9jaeh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> This method is used for generating the "members" of a wide variety of
> things, including structs, unions, enums, alternates, etc. The field
> name it uses to do so is dependent on the type of entity the "member"
> belongs to.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 6458790fe55..ed0269af27d 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -78,6 +78,16 @@
>  
>  
>  class Transmogrifier:
> +    # Field names used for different entity types:
> +    field_types = {
> +        "enum": "value",
> +        "struct": "memb",
> +        "union": "memb",
> +        "event": "memb",
> +        "command": "arg",
> +        "alternate": "choice",
> +    }
> +
>      def __init__(self) -> None:
>          self._curr_ent: Optional[QAPISchemaDefinition] = None
>          self._result = StringList()
> @@ -88,6 +98,10 @@ def entity(self) -> QAPISchemaDefinition:
>          assert self._curr_ent is not None
>          return self._curr_ent
>  
> +    @property
> +    def member_field_type(self) -> str:
> +        return self.field_types[self.entity.meta]
> +
>      # General-purpose rST generation functions
>  
>      def get_indent(self) -> str:
> @@ -202,6 +216,19 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>          self.add_lines(section.text, section.info)
>          self.ensure_blank_line()
>  
> +    def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> +        # TODO: ifcond for members

Similar issues elsewhere are marked FIXME.

Worth mentioning in the commit message?


> +        # TODO?: features for members (documented at entity-level,
> +        # but sometimes defined per-member. Should we add such
> +        # information to member descriptions when we can?)

I guess the '?' in 'TODO?' is there because you're not sure there's
anything to be done about member features.  But you phrased the TODO as
a question.  That makes the uncertainty obvious enough, doesn't it?
Suggest to delete the '?' so a grep for 'TODO:' isn't deceived.  Best to
grep just for 'TODO', of course.

> +        assert section.text and section.member
> +        self.generate_field(
> +            self.member_field_type,
> +            section.member,
> +            section.text,
> +            section.info,
> +        )
> +
>      def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
>          # FIXME - ifcond for features is not handled at all yet!
>          # Proposal: decorate the right-hand column with some graphical


