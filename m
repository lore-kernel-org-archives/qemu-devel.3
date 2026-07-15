Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EDBC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1j4-0004PI-HA; Wed, 15 Jul 2026 11:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1j1-0004K4-Qi
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1iz-0003IT-Ik
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784130040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGRMikqkyUrIVvjIEf8aCOVQAwRWrVddfC5lJKXAm0k=;
 b=UHRkNM46r+EValEpFsejRhY5KK3kJYoYR+0hTeeZS7D4tjHx074VM/h0xPSMJ4JqJOeqnW
 /pF1qoHNxmh2Dqwu8gKyPM/RE/lT7gQN5CidW5oPH+aMP0Jzw09Esxwg7M1xcbXXlw3Stt
 56BjqZbWnbgTLQy8enntKXWC3wJuvgw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-pFLy-7XeOnWOXFbD68l8Gw-1; Wed,
 15 Jul 2026 11:40:37 -0400
X-MC-Unique: pFLy-7XeOnWOXFbD68l8Gw-1
X-Mimecast-MFC-AGG-ID: pFLy-7XeOnWOXFbD68l8Gw_1784130036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F2DA18005AB; Wed, 15 Jul 2026 15:40:35 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.221])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B554C1800576; Wed, 15 Jul 2026 15:40:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/2] gitlab: introduce files mapping GitLab accounts to
 real names
Date: Wed, 15 Jul 2026 16:40:28 +0100
Message-ID: <20260715154029.1216464-2-berrange@redhat.com>
In-Reply-To: <20260715154029.1216464-1-berrange@redhat.com>
References: <20260715154029.1216464-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

It is desirable to be able to discover the GitLab account handle
assocaited with a real name in the MAINTAINERS file.

Rather that duplicating the same account handle multiple times,
inline with the MAINTAINERS file entries, this introduces mapping
files:

  * .gitlab-map-auto - data automatically queried from GitLab
    using the 'glab' tool and REST API
  * .gitlab-map-manual - manual overrides/augmentation for
    cases where the MAINTAINERS real name does not match the
    GitLab account real name

The former would need refreshing when we add new MAINTAINERS
entries, if the person had to be added as a GitLab account
member. For this purpose scripts/gitlab-map-update can be
used, assuming the user has the 'glab' client tool present
and configured with an access token.

To audit how many maintainers have GitLab handles present/missing
scripts/gitlab-map-check can run a report.

  $ ./scripts/gitlab-map-check
  Missing GitLab handle for maintainer 'Akihiko Odaki'
  Missing GitLab handle for maintainer 'Albert Esteve'
  ....
  Missing GitLab handle for maintainer 'Zhenzhong Duan'
  Missing GitLab handle for maintainer 'Zhuoying Cai'
  GitLab handles missing: 158 / present: 68

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-map-auto          | 93 +++++++++++++++++++++++++++++++++++++++
 .gitlab-map-manual        | 18 ++++++++
 scripts/gitlab-map-check  | 51 +++++++++++++++++++++
 scripts/gitlab-map-update | 45 +++++++++++++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 .gitlab-map-auto
 create mode 100644 .gitlab-map-manual
 create mode 100755 scripts/gitlab-map-check
 create mode 100755 scripts/gitlab-map-update

diff --git a/.gitlab-map-auto b/.gitlab-map-auto
new file mode 100644
index 0000000000..c15c301435
--- /dev/null
+++ b/.gitlab-map-auto
@@ -0,0 +1,93 @@
+# This file is auto-generated by scripts/autolab-map-update
+#
+# This GitLab map associates GitLab account handles
+# with real names, in order to allow mapping from
+# MAINTAINERS entries. The format of entries is
+#
+#    {gitlab-handle}<tab>{real name}
+#
+# Manual overrides must be placed in .gitlab-map-manual
+TaoTang	Tao Tang
+a1xndr	Alexander Bulekov
+adi-g15-ibm	Aditya Gupta
+agraf	Alexander Graf
+alex.williamson	Alex Williamson
+aliang1	Aihua Liang
+alistair23	Alistair Francis
+anisinha	Ani Sinha
+anthony-linaro	Anthony Roberts
+anthonyper	Anthony PERARD
+berrange	Daniel P. Berrangé
+birkelund	Klaus Jensen
+bonzini	Paolo Bonzini
+brian-cain	Brian Cain
+bsdimp	Warner Losh
+cborntra	Christian Borntraeger
+chao23.liu	Chao Liu (Zevorn)
+cleber.gnu	Cleber Rosa
+clegoate	Cédric Le Goater
+cohuck	Cornelia Huck
+cota_	Emilio Cota
+dagrh	Dr. David Alan Gilbert
+danielhb	Daniel Henrique Barboza
+davidhildenbrand	David Hildenbrand
+dgibson	dgibson
+dwmw2	David Woodhouse
+eauger1	Eric Auger
+ebblake	Eric Blake
+edgar.iglesias	Edgar E. Iglesias
+ehabkost	Eduardo Habkost
+eldondev	Eldon
+epilys	Manos Pitsidianakis
+famzheng	Fam Zheng
+farosas	Fabiano Rosas
+gautammenghani	Gautam Menghani
+gkurz	Greg Kurz
+gusbromero	Gustavo Romero
+harshpb	Harsh Prateek Bora
+hdeller	Helge Deller
+hreitz	Hanna Czenczek
+imammedo	Igor Mammedov
+jasowang	Jason Wang
+jmacarthur	Jim MacArthur
+jsnow	John Snow
+juan.quintela	Juan Quintela
+kbastian-qemu	Bastian Koppelmann
+kmwolf	Kevin Wolf
+kostyanf14	Kostiantyn Kostiuk
+kraxel	Gerd Hoffmann
+lbmeng	Bin Meng
+legoater	Cédric Le Goater
+lvivier	Laurent Vivier
+lygstate	Yonggang Luo
+maciejsszmigiero	Maciej S. Szmigiero
+marcandre.lureau	Marc-André Lureau
+marcandre.lureau-rh	Marc-André Lureau
+mauromatteo.cascella	Mauro Matteo Cascella
+mcayland	Mark Cave-Ayland
+mdroth	Michael Roth
+mediouni-m	M. Mediouni
+mjt0k	Michael Tokarev
+mstredhat	MST
+npiggin	npiggin
+p-b-o	Pierrick Bouvier
+pauldzim	Paul Zimmerman
+peterx	Peter Xu
+philmd	Philippe Mathieu-Daudé
+pierrick.bouvier	Pierrick Bouvier
+pipo.sk	Peter Krempa
+pkrempa	Peter Krempa (work)
+pm215	Peter Maydell
+qemu-janitor	Qemu Janitor
+rathc	Chinmay Rath
+rth7680	Richard Henderson
+schoenebeck	Christian Schoenebeck
+sgarzarella	Stefano Garzarella
+sstabellini	Stefano Stabellini
+stefanberger	Stefan Berger
+stefanha	Stefan Hajnoczi
+stsquad	Alex Bennée
+stweil	Stefan Weil
+thuth	Thomas Huth
+vsementsov	Vladimir Sementsov-Ogievskiy
+xcancerberox	Joaquin de Andres
diff --git a/.gitlab-map-manual b/.gitlab-map-manual
new file mode 100644
index 0000000000..1551e2f55d
--- /dev/null
+++ b/.gitlab-map-manual
@@ -0,0 +1,18 @@
+# This GitLab map associates GitLab account handles
+# with real names, in order to allow mapping from
+# MAINTAINERS entries. The format of entries is
+#
+#    {gitlab-handle}<tab>{real name}
+#
+# This file is manually written, to augment the
+# auto-generated data in .gitlab-map-auto. This
+# needed where a GitLab account real name does
+# not exactly match the MAINTAINERS file real
+# name.
+#
+berrange	Daniel P. Berrange
+dgibson	David Gibson
+hreitz	Hanna Reitz
+mstredhat	Michael S. Tsirkin
+npiggin	Nicholas Piggin
+mediouni-m	Mohamed Mediouni
diff --git a/scripts/gitlab-map-check b/scripts/gitlab-map-check
new file mode 100755
index 0000000000..ff12e36593
--- /dev/null
+++ b/scripts/gitlab-map-check
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+missing=0
+present=0
+
+grep -E '^(R|M):' MAINTAINERS | \
+sed -E -e 's/^(M|R): //' -e 's/ <.*//' | \
+sort | uniq > names.txt
+while IFS= read -r NAME
+do
+  grep "$NAME" .gitlab-map-{auto,manual} > /dev/null
+  if test $? != 0
+  then
+    echo "Missing GitLab handle for maintainer '$NAME'"
+    missing=$(($missing + 1))
+  else
+    present=$(($present + 1))
+  fi
+done < names.txt
+rm -f names.txt
+
+echo "GitLab handles missing: $missing / present: $present"
+
+# .gitlab-map-manual is to provide alternate real names
+# for cases where name in MANITAINERS does not match
+# the GitLab account real name. As such...
+
+# ...all gitlab handles in .gitlab-map-manual must also exist
+# in .gitlab-map-auto and ....
+for HANDLE in $(grep -v '^#' .gitlab-map-manual | awk '{print $1}')
+do
+    grep -E "^$HANDLE\s" .gitlab-map-auto >/dev/null
+    if test $? != 0
+    then
+	echo "Unexpected GitLab handle '$HANDLE' is not a member"
+    fi
+done
+
+# ...and all realnames in .gitlab-map-manual must also
+# exist in MAINTAINERS
+grep -v '^#' .gitlab-map-manual | \
+awk '{ saved = $1; $1 = ""; print substr($0, 2) }' | \
+while IFS= read -r NAME
+do
+    grep -E "\s$NAME\s" MAINTAINERS >/dev/null
+    if test $? != 0
+    then
+	echo "Unexpected real name '$NAME' is not a maintainer"
+    fi
+done
diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
new file mode 100755
index 0000000000..c134c226aa
--- /dev/null
+++ b/scripts/gitlab-map-update
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+echo "Checking authentication token status"
+glab auth status
+
+if test $? != 0
+then
+  echo "ERROR: not authenticated with gitlab.com"
+  exit 1
+fi
+
+if ! test -f .gitlab-map-auto
+then
+  echo "ERROR: cannot find existing '.gitlab-map-auto file'"
+  echo "ERROR: this must be executed from the root of the"
+  echo "ERROR: git repository checkout"
+  exit 1
+fi
+
+fail=0
+echo "Updating member list from qemu-project"
+glab api --paginate /groups/qemu-project/members | \
+    jq -r -c '.[] | [.username, .name] | @tsv' | \
+    grep -v '^group_3038080_bot' > \
+    .gitlab-map-auto.tmp
+test $? != 0 && fail=1
+
+echo "Updating member list from qemu-project/qemu"
+glab api --paginate /projects/qemu-project%2fqemu/members | \
+    jq -r -c '.[] | [.username, .name] | @tsv' | \
+    grep -v 'Duo Developer' >> \
+    .gitlab-map-auto.tmp
+test $? != 0 && fail=1
+
+if test $fail == 0
+then
+  grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
+  LC_ALL=C sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
+  mv .gitlab-map-auto.new .gitlab-map-auto
+  echo "OK: GitLab member list updated"
+else
+  echo "ERROR: Updating member list failed"
+fi
+rm -f .gitlab-map-auto.tmp
-- 
2.55.0


