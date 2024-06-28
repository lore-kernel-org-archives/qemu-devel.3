Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6SO-0006MV-Ap; Fri, 28 Jun 2024 03:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN6SL-0006KQ-EC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN6SJ-0001CN-Fx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719561337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8BaWiFms4CMQQaurt/sMUGSvJD+aqIwzIjuNyZWpRg=;
 b=h49RNqZKmYx1EDhRLKr81MxEkT1X3OxN78OxH86I0UHiqrlBF1E5U06f3PcerL1b8NspGI
 7cS+3EM8ApaGHtAnumwdrQEy2T8o6SMTKumdg4diqwpHTYjyxmn1+Oor0vdY17L24FyZoU
 fOtOcx81xQ99KmAZMwGkHkcrKjJI2yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-95IjlzC8OKCiDgXx9K39WA-1; Fri,
 28 Jun 2024 03:54:55 -0400
X-MC-Unique: 95IjlzC8OKCiDgXx9K39WA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F362F1944D36; Fri, 28 Jun 2024 07:54:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBEBC19560A3; Fri, 28 Jun 2024 07:54:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A589621E668B; Fri, 28 Jun 2024 09:54:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Ani Sinha
 <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Igor Mammedov <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v2 07/21] docs/qapidoc: fix nested parsing under
 untagged sections
In-Reply-To: <20240626222128.406106-8-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 18:21:13 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-8-jsnow@redhat.com>
Date: Fri, 28 Jun 2024 09:54:48 +0200
Message-ID: <87r0chzelz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

> Sphinx does not like sections without titles, because it wants to
> convert every section into a reference. When there is no title, it
> struggles to do this and transforms the tree inproperly.
>
> Depending on the rST used, this may result in an assertion error deep in
> the docutils HTMLWriter.
>
> (Observed when using ".. admonition:: Notes" under such a section - When
> this is transformed with its own <title> element, Sphinx is fooled into
> believing this title belongs to the section and incorrect mutates the
> docutils tree, leading to errors during rendering time.)
>
> When parsing an untagged section (free paragraphs), skip making a hollow
> section and instead append the parse results to the prior section.
>
> Many Bothans died to bring us this information.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Generated HTML changes, but the diff is hard to review due to id
attribute changes all over the place.

Generated qemu-ga-ref.7 also changes:

    diff -rup old/qemu-ga-ref.7 new/qemu-ga-ref.7
    --- old/qemu-ga-ref.7	2024-06-27 10:42:21.466096276 +0200
    +++ new/qemu-ga-ref.7	2024-06-27 10:45:36.502414099 +0200
    @@ -397,6 +397,7 @@ shutdown request, with no guarantee of s
     .B \fBmode\fP: \fBstring\fP (optional)
     \(dqhalt\(dq, \(dqpowerdown\(dq (default), or \(dqreboot\(dq
     .UNINDENT
    +.sp
     This command does NOT return a response on success.  Success
     condition is indicated by the VM exiting with a zero exit status or,
     when running with \-\-no\-shutdown, by issuing the query\-status QMP
    @@ -1348,6 +1349,7 @@ the new password entry string, base64 en
     .B \fBcrypted\fP: \fBboolean\fP
     true if password is already crypt()d, false if raw
     .UNINDENT
    +.sp
     If the \fBcrypted\fP flag is true, it is the caller\(aqs responsibilit=
y to
     ensure the correct crypt() encryption scheme is used.  This command
     does not attempt to interpret or report on the encryption scheme.

We add vertical space.  Visible when viewed with man.  Looks like an
improvement to me.

Here's the first of these two spots in HTML:

    -<section id=3D"qapidoc-31">
    -<h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><cod=
e class=3D"docutils literal notranslate"><span class=3D"pre">guest-shutdown=
</span></code> (Command)</a><a class=3D"headerlink" href=3D"#qapidoc-31" ti=
tle=3D"Permalink to this heading">=EF=83=81</a></h3>
    +<section id=3D"qapidoc-30">
    +<h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><cod=
e class=3D"docutils literal notranslate"><span class=3D"pre">guest-shutdown=
</span></code> (Command)</a><a class=3D"headerlink" href=3D"#qapidoc-30" ti=
tle=3D"Permalink to this heading">=EF=83=81</a></h3>
     <p>Initiate guest-activated shutdown.  Note: this is an asynchronous
     shutdown request, with no guarantee of successful shutdown.</p>
     <section id=3D"qapidoc-28">
    @@ -502,22 +502,20 @@ shutdown request, with no guarantee of s
     </dd>
     </dl>
     </section>
    -<section id=3D"qapidoc-29">
     <p>This command does NOT return a response on success.  Success
     condition is indicated by the VM exiting with a zero exit status or,
     when running with =E2=80=93no-shutdown, by issuing the query-status QMP
     command to confirm the VM status is =E2=80=9Cshutdown=E2=80=9D.</p>
    -</section>
    -<section id=3D"qapidoc-30">
    -<h4>Since<a class=3D"headerlink" href=3D"#qapidoc-30" title=3D"Permali=
nk to this heading">=EF=83=81</a></h4>
    +<section id=3D"qapidoc-29">
    +<h4>Since<a class=3D"headerlink" href=3D"#qapidoc-29" title=3D"Permali=
nk to this heading">=EF=83=81</a></h4>
     <p>0.15.0</p>
     </section>
     </section>

The id changes muddy the waters.  With them manually removed:

     <section id=3D"qapidoc-31">
     <h3><a class=3D"toc-backref" href=3D"#id13" role=3D"doc-backlink"><cod=
e class=3D"docutils literal notranslate"><span class=3D"pre">guest-shutdown=
</span></code> (Command)</a><a class=3D"headerlink" href=3D"#qapidoc-31" ti=
tle=3D"Permalink to this heading">=EF=83=81</a></h3>
     <p>Initiate guest-activated shutdown.  Note: this is an asynchronous
     shutdown request, with no guarantee of successful shutdown.</p>
     <section id=3D"qapidoc-28">
    @@ -502,22 +502,20 @@ shutdown request, with no guarantee of s
     </dd>
     </dl>
     </section>
    -<section id=3D"qapidoc-29">
     <p>This command does NOT return a response on success.  Success
     condition is indicated by the VM exiting with a zero exit status or,
     when running with =E2=80=93no-shutdown, by issuing the query-status QMP
     command to confirm the VM status is =E2=80=9Cshutdown=E2=80=9D.</p>
    -</section>
     <section id=3D"qapidoc-30">
     <h4>Since<a class=3D"headerlink" href=3D"#qapidoc-30" title=3D"Permali=
nk to this heading">=EF=83=81</a></h4>
     <p>0.15.0</p>
     </section>
     </section>

Makes no visual difference in my browser.

Do these differences match your expectations?


