Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A82AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFM-0005VG-Fn; Thu, 12 Dec 2024 20:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFL-0005V7-Km
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFJ-0008Ko-IF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k3CpRjQ1GJybm/62BEt6jxfIDBxWmGB8jmyyWQfuEuA=;
 b=fPzi9aTPGMbRJVzzMWPF27WS8q4b9wxMUfT3MsjhC+m6Ea1exDV3Ahmk8TEyb7Opcw2IUX
 woxQVZrurq+at/z7hr8A8p7+4x/gAP1qRJEmfwOk6u9HKzXCO0EGNuNM5e0PsurKsQXvCz
 FmXc9OrYP6q+5iuqGWsvVkPu4l3nZnc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-nj9dfImiOTa3erY7LufNIw-1; Thu,
 12 Dec 2024 20:13:27 -0500
X-MC-Unique: nj9dfImiOTa3erY7LufNIw-1
X-Mimecast-MFC-AGG-ID: nj9dfImiOTa3erY7LufNIw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99D3E19560BA; Fri, 13 Dec 2024 01:13:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E7691956089; Fri, 13 Dec 2024 01:13:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 00/35] Add qapi-domain Sphinx extension
Date: Thu, 12 Dec 2024 20:12:29 -0500
Message-ID: <20241213011307.2942030-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This series is still a work in progress, but I am sending it to the list=0D
to serve as a pre-requisite for another series that we need to review=0D
next instead. Please just ignore this one for now!=0D
=0D
Thanks!=0D
=0D
Harmonie Snow (1):=0D
  docs/qapi-domain: add CSS styling=0D
=0D
John Snow (34):=0D
  do-not-merge=0D
  pylint touchups=0D
  docs/sphinx: create QAPI domain extension stub=0D
  docs/sphinx: add compat.py module and nested_parse helper=0D
  docs/qapi-domain: add qapi:module directive=0D
  docs/qapi-domain: add QAPI domain object registry=0D
  docs/qapi-domain: add QAPI index=0D
  docs/qapi-domain: add resolve_any_xref()=0D
  docs/qapi-domain: add QAPI xref roles=0D
  docs/qapi-domain: add compatibility node classes=0D
  docs/qapi-domain: add qapi:command directive=0D
  docs/qapi-domain: add :since: directive option=0D
  docs/qapi-domain: add "Arguments:" field lists=0D
  docs/qapi-domain: add "Features:" field lists=0D
  docs/qapi-domain: add "Errors:" field lists=0D
  docs/qapi-domain: add "Returns:" field lists=0D
  docs/qapi-domain: add returns-nodesc=0D
  docs/qapi-domain: add qapi:enum directive=0D
  docs/qapi-domain: add qapi:alternate directive=0D
  docs/qapi-domain: add qapi:event directive=0D
  docs/qapi-domain: add qapi:struct directive=0D
  docs/qapi-domain: add qapi:union and qapi:branch directives=0D
  docs/qapi-domain: add :deprecated: directive option=0D
  docs/qapi-domain: add :unstable: directive option=0D
  docs/qapi-domain: add :ifcond: directive option=0D
  docs/qapi-domain: add warnings for malformed field lists=0D
  docs/qapi-domain: add type cross-refs to field lists=0D
  docs/qapi-domain: warn when QAPI domain xrefs fail to resolve=0D
  docs/qapi-domain: implement error context reporting fix=0D
  docs/qapi-domain: collapsible branches=0D
  WIP: 3.x - XREF=0D
  WIP: 3.x ParserFix=0D
  WIP: 3.x ObjectDesc compat=0D
  WIP: 3.x css theming for missing xref=0D
=0D
 docs/conf.py                           |   19 +-=0D
 docs/sphinx-static/theme_overrides.css |  108 ++-=0D
 docs/sphinx/collapse.py                |  200 ++++=0D
 docs/sphinx/compat.py                  |  198 ++++=0D
 docs/sphinx/qapi-domain.py             | 1156 ++++++++++++++++++++++++=0D
 scripts/qapi-lint.sh                   |   55 ++=0D
 scripts/qapi/pylintrc                  |    1 +=0D
 7 files changed, 1734 insertions(+), 3 deletions(-)=0D
 create mode 100644 docs/sphinx/collapse.py=0D
 create mode 100644 docs/sphinx/compat.py=0D
 create mode 100644 docs/sphinx/qapi-domain.py=0D
 create mode 100755 scripts/qapi-lint.sh=0D
=0D
-- =0D
2.47.0=0D
=0D


