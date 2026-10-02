Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A1CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZoh-00013l-JD; Fri, 02 Oct 2026 05:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCZog-000138-3d
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCZoe-0008V7-CN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtrwlKo2ztpal6IM2+TGn9lxh3NDPHoQCpS37gqA8B8=;
 b=h4PFCXUVyqaz9qCDSxihbK+2qT0CRZBxk+iqdn74JXr2CHB+DuPWM584JP0cH8XOgF2xNs
 El8CaO0ZIxZcrLVKeM4dmW+4iHfFNGuIi/aY2FmAEqXrUVQRshuF8AlqryjqAXjc2tS21J
 5ONIUn0qOGdGJXlY+oBgyMh4Ma6owEU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-4so4EyWIPEmIhas1xqi74A-1; Fri,
 02 Oct 2026 05:44:28 -0400
X-MC-Unique: 4so4EyWIPEmIhas1xqi74A-1
X-Mimecast-MFC-AGG-ID: 4so4EyWIPEmIhas1xqi74A_1790934266
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98634195607F; Fri,  2 Oct 2026 09:44:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25E1F41D; Fri,  2 Oct 2026 09:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA53821E6A04; Fri, 02 Oct 2026 11:44:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Jiri Pirko <jiri@resnulli.us>,  Alex
 Williamson <alex@shazbot.org>,  Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Kostiantyn Kostiuk
 <kkostiuk@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Michael Roth
 <michael.roth@amd.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater
 <clg@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 14/14] qapi/parser: convert single-section properties to
 getter properties
In-Reply-To: <20260928223657.2303684-15-jsnow@redhat.com> (John Snow's message
 of "Mon, 28 Sep 2026 18:36:57 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-15-jsnow@redhat.com>
Date: Fri, 02 Oct 2026 11:44:21 +0200
Message-ID: <87cxts4etm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

> Remove dedicated pointers to single sections, instead preferring a
> functional getter property that returns the same thing dynamically.
>
> This is being done mainly for the benefit of being able to condense
> the _append() function, but I'm not convinced it's worth it. I'm not
> convinced it's not not worth it either, though.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 47 +++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)

Hmm.

> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 1d8f1d39ab1..d4b5b3e5ab6 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -773,12 +773,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          self._args: Dict[str, QAPIDoc.ArgSection] = {}
>          self._features: Dict[str, QAPIDoc.ArgSection] = {}
>  
> -        # a command's "Returns" and "Errors" section
> -        self._returns: Optional[QAPIDoc.Section] = None
> -        self._errors: Optional[QAPIDoc.Section] = None
> -        # "Since" section
> -        self.since: Optional[QAPIDoc.Section] = None
> -
>      @property
>      def has_features(self) -> bool:
>          return bool(self._features)
> @@ -790,21 +784,10 @@ def _append(self, section: 'QAPIDoc.Section') -> None:
>          All other methods/helpers/etc ultimately use this and only
>          this interface for appending a new section.
>          """
> -        if section.kind == QAPIDoc.Kind.RETURNS:
> -            if self._returns:
> -                raise QAPISemError(
> -                    section.info, "duplicated '%s' section" % section.kind)
> -            self._returns = section
> -        elif section.kind == QAPIDoc.Kind.ERRORS:
> -            if self._errors:
> -                raise QAPISemError(
> -                    section.info, "duplicated '%s' section" % section.kind)
> -            self._errors = section
> -        elif section.kind == QAPIDoc.Kind.SINCE:
> -            if self.since:
> -                raise QAPISemError(
> -                    section.info, "duplicated '%s' section" % section.kind)
> -            self.since = section
> +        if str(section.kind) in ('Intro', 'Returns', 'Errors', 'Since'):
> +            if self._sections[section.kind]:
> +                raise QAPISemError(section.info,
> +                                   "duplicated '%s' section" % section.kind)
>          self._sections[section.kind].append(section)
>          self._active_section = section
>  

Likable so far.

> @@ -815,6 +798,28 @@ def __iter__(self) -> Iterator['QAPIDoc.Section']:
>      def __len__(self) -> int:
>          return sum(len(x) for x in self._sections.values())
>  
> +    def _single_section_property(
> +        self,
> +        kind: 'QAPIDoc.Kind'
> +    ) -> Optional['QAPIDoc.Section']:
> +        try:
> +            return self._sections[kind][0]
> +        except IndexError:
> +            pass
> +        return None

Returns the first section of a kind.  Let's name it after what it does:
_first_section().

The try works, but

           return self._sections[kind][0] if self._sections[kind] else None

seems to work as well, and with less ceremony :)

> +
> +    @property
> +    def _returns(self) -> Optional['QAPIDoc.Section']:
> +        return self._single_section_property(QAPIDoc.Kind.RETURNS)
> +
> +    @property
> +    def _errors(self) -> Optional['QAPIDoc.Section']:
> +        return self._single_section_property(QAPIDoc.Kind.ERRORS)
> +
> +    @property
> +    def since(self) -> Optional['QAPIDoc.Section']:
> +        return self._single_section_property(QAPIDoc.Kind.SINCE)
> +
>      def end(self) -> None:
>          for section in self:
>              section.text = section.text.strip('\n')


