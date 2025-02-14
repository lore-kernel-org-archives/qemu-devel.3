Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDC1C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiuSg-0007UW-Jo; Fri, 14 Feb 2025 07:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiuSE-0007PF-KH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:06:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiuSC-0000ZI-KT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739534755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rm5yAEVzy05Py8mIn8gLZSOBf08s6b6FX0Pfld4hszA=;
 b=BcZBlFekU51Lkasimpap263+zBxradtc+d7tdJE8M+Kk1+rfslmnrits1v1pAh4NEmoWvI
 UIzEjgXOHhgs+CLjeTrQzebagi//yWxePlIEbUIKgPl9X186VTCFfiVliBicP7Aa3NYTYn
 86nc9F17Igt+kmzJxydcYB7zBD0x8H8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-srSWIzxDM7OtDtqpdoVK1Q-1; Fri,
 14 Feb 2025 07:05:50 -0500
X-MC-Unique: srSWIzxDM7OtDtqpdoVK1Q-1
X-Mimecast-MFC-AGG-ID: srSWIzxDM7OtDtqpdoVK1Q_1739534748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D18A719560B5; Fri, 14 Feb 2025 12:05:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F9461800359; Fri, 14 Feb 2025 12:05:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92FBC21E6A28; Fri, 14 Feb 2025 13:05:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:26 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
Date: Fri, 14 Feb 2025 13:05:43 +0100
Message-ID: <87wmds4tpk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

I started to eyeball old and new generated output side by side.

New table of contents shows one level, old two.  No objection; the
navigation thingie on the left is more useful anyway.

The new generator elides unreferenced types.  Generally good, but two
observations:

* QapiErrorClass is unreferenced, but its members are mentioned in
  Errors sections.  QapiErrorClass serves as better than nothing error
  code documentation, but it's gone in the new doc.  So this is a minor
  regression.  We can figure out what to do about it later.

* Section "QMP errors" is empty in the new doc, because its entire
  contents is elided.  I guess we should elide the section as well, but
  it's fine to leave that for later.

Old doc shows a definition's since information like any other section.
New doc has it in the heading box.  Looks prettier and uses much less
space.  Not sure the heading box is the best place, but it'll do for
now, we can always move it around later.

The new doc's headings use "Struct" or "Union" where the old one uses
just "Object".  Let's keep "Object", please.

In the new doc, some member references are no longer rendered as such,
e.g. @on-source-error and @on-target-error in BackupCommon's note.
Another small regression.

Union branches are busted in the new generator's output.  I know they
used to work, so I'm not worried about it.

The new doc shows the return type, the old doc doesn't.  Showing it is
definitely an improvement, but we need to adjust the doc text to avoid
silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".

The new doc shows Arguments / Members, Returns, and Errors in two-column
format.  Looks nice.  But for some reason, the two columns don't align
horizontally for Errors like they do for the others.  Certainly not a
blocker of anything, but we should try to fix it at some point.

The new doc doesn't show non-definition conditionals, as mentioned in
the cover letter.  It shows definition conditionals twice.  Once should
suffice.

There's probably more, but this is it for now.


