Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F529C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8Dy-0005ri-QO; Fri, 27 Jun 2025 08:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV8Dw-0005rL-GP
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV8Dr-0001XQ-6X
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751027423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gKKkc6z345jmH26p5rMRiYRworieKPgNQxfolOC5M6o=;
 b=CO1J5xQgDO6LADlFoYbdd60u8PFxSYjIPwp9Uux5fGQf8r3rEOo2mtQq1NtmkdSECc/voG
 7LRvgnnyLoSvV8bi2QhSrzohRlc4nDcZSlEEveEAfuM8GBo/GDI6OEoYmYB2W3kQY/dSph
 IJ6QdGc4qdOfS5eQYk8+hy1maF/78wg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308--LDZ0dzmOH6IXxerUueOPg-1; Fri,
 27 Jun 2025 08:30:19 -0400
X-MC-Unique: -LDZ0dzmOH6IXxerUueOPg-1
X-Mimecast-MFC-AGG-ID: -LDZ0dzmOH6IXxerUueOPg_1751027416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BCB518089B7; Fri, 27 Jun 2025 12:30:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04EE0180045B; Fri, 27 Jun 2025 12:30:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 576D021E6A27; Fri, 27 Jun 2025 14:30:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Peter Maydell <peter.maydell@linaro.org>,
 Jiri Pirko <jiri@resnulli.us>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-trivial@nongnu.org,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Laurent Vivier <laurent@vivier.eu>,  Peter Xu
 <peterx@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Fabiano Rosas <farosas@suse.de>,  Yanan Wang
 <wangyanan55@huawei.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Michael Roth <michael.roth@amd.com>,  Zhenwei Pi
 <pizhenwei@bytedance.com>,  Lukas Straub <lukasstraub2@web.de>,  Hanna
 Reitz <hreitz@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,  qemu-block@nongnu.org,  Mads Ynddal
 <mads@ynddal.dk>
Subject: Re: [PATCH v5 2/4] docs, qapi: generate undocumented return sections
In-Reply-To: <20250626195337.2158250-3-jsnow@redhat.com> (John Snow's message
 of "Thu, 26 Jun 2025 15:53:35 -0400")
References: <20250626195337.2158250-1-jsnow@redhat.com>
 <20250626195337.2158250-3-jsnow@redhat.com>
Date: Fri, 27 Jun 2025 14:30:08 +0200
Message-ID: <877c0xl63z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> This patch changes the qapidoc parser to generate stub Return value
> documentation for any command that has a return value but does not have
> a "Returns:" doc section.
>
> The stubs include just the type name, which will be rendered with a
> cross-reference link in the HTML output.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Might want to briefly explain placement of the auto-generated return
value documentation.

The cover letter claims you implemented the placement I suggested:

1. If we have arguments, return goes right after them.

2. Else if we have errors, return goes right before them.

3. Else if we have features, return goes right before them.

4. Else return goes right after the intro (might require a few more TODO
   hacks to terminate the intro).

This patch adds auto-generated return value documentation where we have
none.

The next patch replaces handwritten by auto-generated return value
documentation where these are at least as good.  Moves the return value
docs in some cases.

Let's check placement.  Skip to the end for a summary of findings.

First the additions (this patch):

* x-debug-query-block-graph

  Title, intro, features, return

  1. doesn't apply, 2. doesn't apply, 3. applies: return should go right
  before features.  It's afterwards.  Unexpected.

* query-tpm

  Title, intro, return, example

  4. applies.  Good.

* query-dirty-rate

  Title, intro, arguments, return, examples

  1. applies.  Good.

* query-vcpu-dirty-limit

  Title, intro, return, example

  4. applies.  Good.

* query-vm-generation-id

  Title, intro, return

  4. applies.  Good.

* query-memory-size-summary

  Title, intro, example, return

  4. applies.  Why is return after example here, and before example
  elsewhere?

  Turns out elsewhere we have Since: between intro and .. qmp-example::
  terminating the intro.  Slighly unusual, Since: more often the last in
  the comment block).

  Except for query-memory-size-summary, which does have Since: at the
  very and, and uses the TODO hack instead to terminate the intro.

  So, the placement algorithm works as intended here.  We just need to
  terminate the intro here as well.

* query-memory-devices

  Title, intro, return, example

  4. applies.  Good.

* query-acpi-ospm-status

  Title, intro, return, example

  4. applies.  Good.

* query-stats-schemas

  Title, intro, arguments, return, note

  1. applies.  Good.

Check placement of moved returns (next patch):

* x-debug-block-dirty-bitmap-sha256

  Title, intro, arguments, features, errors, return

  1. applies: return should go right after arguments.  Its at the end.
  Unexpected.

* query-xen-replication-status

  Title, intro, example, return

  Return after example instead of before.  This is just like
  query-memory-size-summary: placement algorithm works as intended,
  intro needs a terminator.

* query-colo-status

  Title, intro, example, return

  Likewise.

* query-machines

  Title, intro, arguments, return, features, example

  1. applies.  Okay.

* query-balloon

  Title, intro, errors, return, example

  2. applies: return should go right before errors.  It's afterwards.
  Unexpected.

* query-hv-balloon-status-report

  Title, intro, errors, return, example

  Likewise.

* query-yank

  Title, intro, example, return

  Another one just like query-memory-size-summary: placement algorithm
  works as intended, intro needs a terminator.

* query-sev-capabilities

  Title, intro, errors, return, example

  Like query-ballon.

* x-query-virtio-queue-element

  Title, intro, arguments, return, features, example

  1. applies.  Good.


Summary of findings:

1. If we have arguments, return goes right after them.

   Works as intended, except for x-debug-block-dirty-bitmap-sha256.
   Odd.

2. Else if we have errors, return goes right before them.

   You seem to place it afterwards instead.

3. Else if we have features, return goes right before them.

   You seem to place it afterwards instead.

4. Else return goes right after the intro (might require a few more TODO
   hacks to terminate the intro).

   Yes, we need several of them.


