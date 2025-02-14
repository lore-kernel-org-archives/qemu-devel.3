Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077DAC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2Jz-0003yH-NQ; Fri, 14 Feb 2025 15:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2Jy-0003xk-HI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2Jv-0001kt-My
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739564993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LzSHb2x/9f2qW53Eiict+VmmIHHo5p8WxF8q8pZJvks=;
 b=FYP7CIKzp90AL10DtkMmZGO8g/wkJ0lX0fFd5l4P+5fLwn/C4w+0aEX2zF1XW2xdwElDHU
 ux2cPKOA/gBqjkPUsEDK9/4VpGXX4JRDZMaVAl0alPekLQBdaeUoRBiZQBwEWfrJtDUZ4N
 TRDO+l84V9j3NCoXu5KfdfDzdiF+ZZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-fkXnZ_VhM9qg69lfidfhzg-1; Fri,
 14 Feb 2025 15:29:52 -0500
X-MC-Unique: fkXnZ_VhM9qg69lfidfhzg-1
X-Mimecast-MFC-AGG-ID: fkXnZ_VhM9qg69lfidfhzg_1739564991
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53EA11800360
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:29:51 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A487C1800358; Fri, 14 Feb 2025 20:29:47 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 00/11] 
Date: Fri, 14 Feb 2025 21:29:33 +0100
Message-ID: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Hi again,

This patch series intent is to introduce a generator that produces a Go
module for Go applications to interact over QMP with QEMU.

Previous version (10 Jan 2025)
    https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg01530.html

The generated code was mostly tested using existing examples in the QAPI
documentation, 192 instances that might have multiple QMP messages each.

You can find the the tests and the generated code in my personal repo,
main branch:

    https://gitlab.com/victortoso/qapi-go

If you want to see the generated code from QEMU's master but per patch:

    https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v4-by-patch

If you rather see the diff between v9.1.0, v9.2.0 and latest:

    https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v4-by-tags


#################
# Changes in v4 #
#################

1. Daniel wrote a demo on top of v3 and proposed changes that would
   result in more interesting module to build on top:
   https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg03052.html
   
   I've implemented all the suggestions that are relevant for this
   introductory series, they are:

  a. New struct type Message, that shall be used for a 1st level
     unmarshalling of the JSON message.
  b. Removal of Marshal/Unmarshal code in both Events and Comands,
     together with utility code that is not relevant anymore.
  c. Declaration of 3 new interfaces:
    i.   Events
    ii.  Commands
    iii. CommandsAsync

2. I've moved the code to a new folder: scripts/qapi/golang. This
   allowed me to move templates out of golang.py, keeping go related
   code self-contained in the new directory.

3. As mentioned in (2), created protocol.go and utils.go that are 100%
   hand generated Go code. Message mentioned in (1a) is under
   protocol.go

4. Defined license using SPDX-License-Identifier.
  a. Every Go source code written by hand is 100% MIT-0
  b. Every Go source code generated is dual licensed as MIT-0 and
     GPL-2.0-or-later
  c. The binary code is expected to be MIT-0 only but not really
     relevant for this series.

  If you want more information, please check the thread:
  https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg01621.html

5. I've renamed the generated files.
  a. Any type related file is now prefixed with "gen_type_"
  b. Any interface related file is prefixed as "gen_iface_"

6. Relevant changes were made to the doc but it is not complete. I plan
   that follow-up proposals would add to the documentation.

7. Improvements to the generator were made to.

8. Also worth to mention that resulting generated code does not have any
   diff with gofmt and goimport tools, as requested in the past.

################
# Expectations #
################

As is, this still is a PoC that works. I'd like to have the generated
code included in QEMU's gitlab [0] in order to write library and tools
on top. Initial version should be considered alpha. Moving to
beta/stable would require functional libraries and tools, but this work
needs to be merged before one commit to that.

[0] https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07024.html


##################
# Follow-up work #
##################

When this is merged we would need to:
 1. Create gitlab's repo
 2. Add unit test and CI to new repos
 3. Have first alpha relase/tag
 4. Start working on top :)


Thanks for the time looking at this. I appreciate it.

Victor Toso (11):
  qapi: golang: first level unmarshalling type
  qapi: golang: Generate enum type
  qapi: golang: Generate alternate types
  qapi: golang: Generate struct types
  qapi: golang: structs: Address nullable members
  qapi: golang: Generate union type
  qapi: golang: Generate event type
  qapi: golang: Generate Event interface
  qapi: golang: Generate command type
  qapi: golang: Generate Command sync/async interfaces
  docs: add notes on Golang code generator

 docs/devel/index-build.rst          |    1 +
 docs/devel/qapi-golang-code-gen.rst |  420 ++++++++
 scripts/qapi/golang/__init__.py     |    0
 scripts/qapi/golang/golang.py       | 1444 +++++++++++++++++++++++++++
 scripts/qapi/golang/protocol.go     |   48 +
 scripts/qapi/golang/utils.go        |   38 +
 scripts/qapi/main.py                |    2 +
 7 files changed, 1953 insertions(+)
 create mode 100644 docs/devel/qapi-golang-code-gen.rst
 create mode 100644 scripts/qapi/golang/__init__.py
 create mode 100644 scripts/qapi/golang/golang.py
 create mode 100644 scripts/qapi/golang/protocol.go
 create mode 100644 scripts/qapi/golang/utils.go

-- 
2.48.1


