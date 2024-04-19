Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD33C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg17-0007Mi-Ac; Fri, 19 Apr 2024 00:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg15-0007Lv-NY
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg13-00049M-QD
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hHv50p2eP8cgQe12OJpLLZ7Gh71se+BPfE/yPrXUvw4=;
 b=CPXC4KwtIGsZpO1X2MPV3BFMWevmsB/idsEFPiaS6/Gma9DduTz4XZm89FYtmLsNS9HIFf
 YlP1h1wgHHC8kE4VvV1kRPzlTLddsBVKgrfNgignvHZCHcSFgdO2nTvg33pqrB9YoIkIll
 xp5LN7I14rrPLwjCnq9WNuo6Io9u/J8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-TRXNGWcGNU-NIbsuYru8Hg-1; Fri,
 19 Apr 2024 00:38:21 -0400
X-MC-Unique: TRXNGWcGNU-NIbsuYru8Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5FAF29AA38E;
 Fri, 19 Apr 2024 04:38:21 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D43A14011FF7;
 Fri, 19 Apr 2024 04:38:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/27] Add qapi-domain Sphinx extension
Date: Fri, 19 Apr 2024 00:37:48 -0400
Message-ID: <20240419043820.178731-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

This series adds a new qapi-domain extension for Sphinx, which adds a=0D
series of custom directives for documenting QAPI definitions.=0D
=0D
GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476=0D
=0D
(Link to a demo HTML page at the end of this cover letter, but I want=0D
you to read the cover letter first to explain what you're seeing.)=0D
=0D
This adds a new QAPI Index page, cross-references for QMP commands,=0D
events, and data types, and improves the aesthetics of the QAPI/QMP=0D
documentation.=0D
=0D
This series adds only the new ReST syntax, *not* the autogenerator. The=0D
ReST syntax used in this series is, in general, not intended for anyone=0D
to actually write by hand. This mimics how Sphinx's own autodoc=0D
extension generates Python domain directives, which are then re-parsed=0D
to produce the final result.=0D
=0D
I have prototyped such a generator, but it isn't ready for inclusion=0D
yet. (Rest assured: error context reporting is preserved down to the=0D
line, even in generated ReST. There is no loss in usability for this=0D
approach. It will likely either supplant qapidoc.py or heavily alter=0D
it.) The generator requires only extremely minor changes to=0D
scripts/qapi/parser.py to preserve nested indentation and provide more=0D
accurate line information. It is less invasive than you may=0D
fear. Relying on a secondary ReST parse phase eliminates much of the=0D
complexity of qapidoc.py. Sleep soundly.=0D
=0D
The purpose of sending this series in its current form is largely to=0D
solicit feedback on general aesthetics, layout, and features. Sphinx is=0D
a wily beast, and feedback at this stage will dictate how and where=0D
certain features are implemented.=0D
=0D
A goal for this syntax (and the generator) is to fully in-line all=0D
command/event/object members, inherited or local, boxed or not, branched=0D
or not. This should provide a boon to using these docs as a reference,=0D
because users will not have to grep around the page looking for various=0D
types, branches, or inherited members. Any arguments types will be=0D
hyperlinked to their definition, further aiding usability. Commands can=0D
be hotlinked from anywhere else in the manual, and will provide a=0D
complete reference directly on the first screenful of information.=0D
=0D
(Okay, maybe two screenfuls for commands with a ton of=0D
arguments... There's only so much I can do!)=0D
=0D
This RFC series includes a "sandbox" .rst document that showcases the=0D
features of this domain by writing QAPI directives by hand; this=0D
document will be removed from the series before final inclusion. It's=0D
here to serve as a convenient test-bed for y'all to give feedback.=0D
=0D
All that said, here's the sandbox document fully rendered:=0D
https://jsnow.gitlab.io/qemu/qapi/index.html=0D
=0D
And here's the new QAPI index page created by that sandbox document:=0D
https://jsnow.gitlab.io/qemu/qapi-index.html=0D
=0D
Known issues / points of interest:=0D
=0D
- The formatting upsets checkpatch. The default line length for the=0D
  "black" formatting tool is a little long. I'll fix it next spin.=0D
=0D
- I did my best to preserve cross-version compatibility, but some=0D
  problems have crept in here and there. This series may require=0D
  Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu build fails=
=0D
  on Gitlab CI currently. The next version will text against more Sphinx=0D
  versions more rigorously. Sphinx version 5.3.0 and above should work=0D
  perfectly.=0D
=0D
- There's a bug in Sphinx itself that may manifest in your testing,=0D
  concerning reported error locations. There's a patch in this series=0D
  that fixes it, but it's later in the series. If you run into the bug=0D
  while testing with this series, try applying that patch first.=0D
=0D
- QAPI 'namespaces' aren't yet handled. i.e., there's nothing to=0D
  distinguish entities between QMP, QGA and QSD yet. That feature will=0D
  be added to a future version of this patchset (Likely when the=0D
  generator is ready for inclusion: without it, references will clash=0D
  and the index will gripe about duplicated entries.)=0D
=0D
- Per-member features and ifcond are not yet accounted for; though=0D
  definition-scoped features and ifconds are. Please feel free to=0D
  suggest how you'd like to see those represented.=0D
=0D
- Inlining all members means there is some ambiguity on what to do with=0D
  doc block sections on inlined entities; features and members have an=0D
  obvious home - body, since, and misc sections are not as obvious on=0D
  how to handle. This will feature more prominently in the generator=0D
  series.=0D
=0D
- Some features could be implemented in either the QAPI domain syntax=0D
  *or* the generator, or some combination of both. Depending on=0D
  aesthetic feedback, this may influence where those features should be=0D
  implemented.=0D
=0D
- The formatting and aesthetics of branches are a little up in the air,=0D
  see the qapi:union patch for more details.=0D
=0D
- It's late, maybe other things. Happy Friday!=0D
=0D
Hope you like it!=0D
=0D
--js=0D
=0D
Harmonie Snow (1):=0D
  docs/qapi-domain: add CSS styling=0D
=0D
John Snow (26):=0D
  docs/sphinx: create QAPI domain extension stub=0D
  docs/qapi-domain: add qapi:module directive=0D
  docs/qapi-module: add QAPI domain object registry=0D
  docs/qapi-domain: add QAPI index=0D
  docs/qapi-domain: add resolve_any_xref()=0D
  docs/qapi-domain: add QAPI xref roles=0D
  docs/qapi-domain: add qapi:command directive=0D
  docs/qapi-domain: add :since: directive option=0D
  docs/qapi-domain: add "Arguments:" field lists=0D
  docs/qapi-domain: add "Features:" field lists=0D
  docs/qapi-domain: add "Errors:" field lists=0D
  docs/qapi-domain: add "Returns:" field lists=0D
  docs/qapi-domain: add qapi:enum directive=0D
  docs/qapi-domain: add qapi:alternate directive=0D
  docs/qapi-domain: add qapi:event directive=0D
  docs/qapi-domain: add qapi:struct directive=0D
  docs/qapi-domain: add qapi:union and qapi:branch directives=0D
  docs/qapi-domain: add :deprecated: directive option=0D
  docs/qapi-domain: add :unstable: directive option=0D
  docs/qapi-domain: add :ifcond: directive option=0D
  docs/qapi-domain: RFC patch - add malformed field list entries=0D
  docs/qapi-domain: add warnings for malformed field lists=0D
  docs/qapi-domain: RFC patch - delete malformed field lists=0D
  docs/qapi-domain: add type cross-refs to field lists=0D
  docs/qapi-domain: implement error context reporting fix=0D
  docs/qapi-domain: RFC patch - Add one last sample command=0D
=0D
 docs/conf.py                           |   15 +-=0D
 docs/index.rst                         |    1 +=0D
 docs/qapi/index.rst                    |  364 ++++++++=0D
 docs/sphinx-static/theme_overrides.css |   92 +-=0D
 docs/sphinx/qapi-domain.py             | 1061 ++++++++++++++++++++++++=0D
 5 files changed, 1530 insertions(+), 3 deletions(-)=0D
 create mode 100644 docs/qapi/index.rst=0D
 create mode 100644 docs/sphinx/qapi-domain.py=0D
=0D
-- =0D
2.44.0=0D
=0D


