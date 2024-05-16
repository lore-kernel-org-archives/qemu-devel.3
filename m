Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026EDC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 06:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7URh-00033M-UF; Thu, 16 May 2024 02:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7URf-00032W-T9
 for qemu-devel@nongnu.org; Thu, 16 May 2024 02:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7URe-0002pz-2t
 for qemu-devel@nongnu.org; Thu, 16 May 2024 02:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715840305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cSXr6XEWdFBSlkKWlxv88fxOtbv+pv05NKTRb5GBSQ=;
 b=FKlHwEWeip5lyhZ5pPxRjV6YGWBmjFRBh5uN8IdVbkJsj9H4XE33jhpWdWnJvWqPeLhYUq
 YURE58yCxfJgnoReItIpgsuSj37IjE0Kg4yY8JvELe7CwIL4zouiVrgD/JxWSOYIq5saif
 LR9IGuXH/PoybyzqzzIwPGJtdAGVwI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-7y59AKYaM6203WmU2YoRnA-1; Thu,
 16 May 2024 02:18:13 -0400
X-MC-Unique: 7y59AKYaM6203WmU2YoRnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 966723C025B8;
 Thu, 16 May 2024 06:18:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD4842026D68;
 Thu, 16 May 2024 06:18:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A23C221E66E5; Thu, 16 May 2024 08:18:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal <mads@ynddal.dk>,  Jason Wang
 <jasowang@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  qemu-block@nongnu.org,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 07/20] qapi/parser: add semantic 'kind' parameter to
 QAPIDoc.Section
In-Reply-To: <20240514215740.940155-8-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:26 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-8-jsnow@redhat.com>
Date: Thu, 16 May 2024 08:18:10 +0200
Message-ID: <87wmnunuu5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

> When iterating all_sections, this is helpful to be able to distinguish
> "members" from "features"; the only other way to do so is to
> cross-reference these sections against QAPIDoc.args or QAPIDoc.features,
> but if the desired end goal for QAPIDoc is to remove everything except
> all_sections, we need *something* accessible to distinguish them.
>
> To keep types simple, add this semantic parameter to the base Section
> and not just ArgSection; we can use this to filter out paragraphs and
> tagged sections, too.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 161768b8b96..cf4cbca1c1f 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -613,21 +613,27 @@ class QAPIDoc:
>  
>      class Section:
>          # pylint: disable=too-few-public-methods
> -        def __init__(self, info: QAPISourceInfo,
> -                     tag: Optional[str] = None):
> +        def __init__(
> +            self,
> +            info: QAPISourceInfo,
> +            tag: Optional[str] = None,
> +            kind: str = 'paragraph',
> +        ):
>              # section source info, i.e. where it begins
>              self.info = info
>              # section tag, if any ('Returns', '@name', ...)
>              self.tag = tag
>              # section text without tag
>              self.text = ''
> +            # section type - {paragraph, feature, member, tagged}
> +            self.kind = kind

Hmm.  .kind is almost redundant with .tag.

Untagged section:    .kind is 'paragraph', .tag is None

Member description:  .kind is 'member', .tag matches @NAME

Feature description: .kind is 'feature', .tag matches @NAME

Tagged section:      .kind is 'tagged', .tag matches
                          r'Returns|Errors|Since|Notes?|Examples?|TODO'

.kind can directly be derived from .tag except for member and feature
descriptions.  And you want to tell these two apart in a straightforward
manner in later patches, as you explain in your commit message.

If .kind is 'member' or 'feature', then self must be an ArgSection.
Worth a comment?  An assertion?

Some time back, I considered changing .tag for member and feature
descriptions to suitable strings, like your 'member' and 'feature', and
move the member / feature name into ArgSection.  I didn't, because the
benefit wasn't worth the churn at the time.  Perhaps it's worth it now.
Would it result in simpler code than your solution?

Terminology nit: the section you call 'paragraph' isn't actually a
paragraph: it could be several paragraphs.  Best to call it 'untagged',
as in .ensure_untagged_section().

>  
>          def append_line(self, line: str) -> None:
>              self.text += line + '\n'
>  
>      class ArgSection(Section):
> -        def __init__(self, info: QAPISourceInfo, tag: str):
> -            super().__init__(info, tag)
> +        def __init__(self, info: QAPISourceInfo, tag: str, kind: str):
> +            super().__init__(info, tag, kind)
>              self.member: Optional['QAPISchemaMember'] = None
>  
>          def connect(self, member: 'QAPISchemaMember') -> None:

[...]


