Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C991C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7XVW-0006Vy-8w; Thu, 16 May 2024 05:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7XVU-0006VP-Gy
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7XVR-0005VE-Uk
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715852071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y525LrRc+tFFStpWDHX+On+cvRqDvxTyESsCDX5Zzmw=;
 b=O61iAf75TVIQOGPTpwMrZf7Zg7A75Nu2syBv0rHgWmoFku9Uyt7L5aH6MFSQuRY0FY7iCQ
 JbeqLuFHBnTKeyyh5tpb9nEgATZWoazqTgaugZCyPMs8JUV5Es5T6EZphordKpdOeVdZ5M
 D3fd/QZsyirWI66JpknVpXv6tkAY2Ew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-_bDK6MS7M4y8SHorqM9FHw-1; Thu, 16 May 2024 05:34:28 -0400
X-MC-Unique: _bDK6MS7M4y8SHorqM9FHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E92780028D;
 Thu, 16 May 2024 09:34:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50AB07412;
 Thu, 16 May 2024 09:34:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 460A121E66E5; Thu, 16 May 2024 11:34:26 +0200 (CEST)
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
Subject: Re: [PATCH 08/20] qapi/parser: differentiate intro and outro
 paragraphs
In-Reply-To: <20240514215740.940155-9-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:27 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-9-jsnow@redhat.com>
Date: Thu, 16 May 2024 11:34:26 +0200
Message-ID: <87a5kqnlr1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Add a semantic tag to paragraphs that appear *before* tagged
> sections/members/features and those that appear after. This will control
> how they are inlined when doc sections are merged and flattened.

This future use is not obvious to me now.  I guess the effective way to
help me see it is actual patches, which will come in due time.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index cf4cbca1c1f..b1794f71e12 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -503,6 +503,10 @@ def get_doc(self) -> 'QAPIDoc':
>              self.accept(False)
>              line = self.get_doc_line()
>              no_more_args = False
> +            # Paragraphs before members/features/tagged are "intro" paragraphs.
> +            # Any appearing subsequently are "outro" paragraphs.
> +            # This is only semantic metadata for the doc generator.

Not sure about the last sentence.  Isn't it true for almost everything
around here?

Also, long line.  

> +            intro = True
>  
>              while line is not None:
>                  # Blank lines
> @@ -532,6 +536,7 @@ def get_doc(self) -> 'QAPIDoc':
>                          raise QAPIParseError(
>                              self, 'feature descriptions expected')
>                      no_more_args = True
> +                    intro = False

After feature descriptions.

>                  elif match := self._match_at_name_colon(line):
>                      # description
>                      if no_more_args:
> @@ -547,6 +552,7 @@ def get_doc(self) -> 'QAPIDoc':
>                              doc.append_line(text)
>                          line = self.get_doc_indented(doc)
>                      no_more_args = True
> +                    intro = False

Or after member descriptions.

>                  elif match := re.match(
>                          r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
>                          line):
> @@ -557,13 +563,14 @@ def get_doc(self) -> 'QAPIDoc':
>                          doc.append_line(text)
>                      line = self.get_doc_indented(doc)
>                      no_more_args = True
> +                    intro = False

Or after the first tagged section.

Okay, it does what it says on the tin.

>                  elif line.startswith('='):
>                      raise QAPIParseError(
>                          self,
>                          "unexpected '=' markup in definition documentation")
>                  else:
>                      # tag-less paragraph
> -                    doc.ensure_untagged_section(self.info)
> +                    doc.ensure_untagged_section(self.info, intro)
>                      doc.append_line(line)
>                      line = self.get_doc_paragraph(doc)
>          else:
> @@ -617,7 +624,7 @@ def __init__(
>              self,
>              info: QAPISourceInfo,
>              tag: Optional[str] = None,
> -            kind: str = 'paragraph',
> +            kind: str = 'intro-paragraph',

The question "why is this optional?" crossed my mind when reviewing the
previous patch.  I left it unasked, because I felt challenging the
overlap between @kind and @tag was more useful.  However, the new
default value 'intro-paragraph' feels more arbitrary to me than the old
one 'paragraph', and that makes the question pop right back into my
mind.

Unless I'm mistaken, all calls but one @tag and @kind.  Making that one
pass it too feels simpler to me.

Moot if we fuse @tag and @kind, of course.

>          ):
>              # section source info, i.e. where it begins
>              self.info = info
> @@ -625,7 +632,7 @@ def __init__(
>              self.tag = tag
>              # section text without tag
>              self.text = ''
> -            # section type - {paragraph, feature, member, tagged}
> +            # section type - {<intro|outro>-paragraph, feature, member, tagged}

Long line.

>              self.kind = kind
>  
>          def append_line(self, line: str) -> None:
> @@ -666,7 +673,11 @@ def end(self) -> None:
>                  raise QAPISemError(
>                      section.info, "text required after '%s:'" % section.tag)
>  
> -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> +    def ensure_untagged_section(
> +        self,
> +        info: QAPISourceInfo,
> +        intro: bool = True,

Two callers, one passes @info, one doesn't.  Passing it always might be
simpler.

> +    ) -> None:
>          if self.all_sections and not self.all_sections[-1].tag:
>              section = self.all_sections[-1]
>              # Section is empty so far; update info to start *here*.
> @@ -677,7 +688,8 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>                  self.all_sections[-1].text += '\n'
>              return
>          # start new section
> -        section = self.Section(info)
> +        kind = ("intro" if intro else "outro") + "-paragraph"
> +        section = self.Section(info, kind=kind)
>          self.sections.append(section)
>          self.all_sections.append(section)


