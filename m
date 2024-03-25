Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F5BC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roglK-0000iF-J7; Mon, 25 Mar 2024 05:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roglJ-0000i1-B9
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roglH-0006CP-IG
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711359416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xAyrOfFJqsIa+nou85agsoQOUp6k6g5Dk7m9dw8z7v8=;
 b=FZkSFG5hAUTO0F5dxG/wv8zjHiG7evrR+Tb0UgcVVzdYeWvNJx7+hS6im+KTgvRpPjbsCl
 ZjqJlKfF5NKlvvq/YhzIIeJRO+X/xD7hcoVTR/ElH1vv2Lklqkj2y9C6aLk9KbIONnRrAP
 8TOorRhpq8h/MIW6inN4xse11mLs+Cw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-9cRqTjm0PyGtVbJ0Qd4LXA-1; Mon, 25 Mar 2024 05:36:54 -0400
X-MC-Unique: 9cRqTjm0PyGtVbJ0Qd4LXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD6478007A7;
 Mon, 25 Mar 2024 09:36:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E04131C060D1;
 Mon, 25 Mar 2024 09:36:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC80721E668C; Mon, 25 Mar 2024 10:36:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Let's close member documentation gaps
Date: Mon, 25 Mar 2024 10:36:47 +0100
Message-ID: <87il1aodow.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

If you're cc'ed, I have a bit of doc work for you.  Search for your
name to find it.

The QAPI generator forces you to document your stuff.  Except for
commands, events, enum and object types listed in pragma
documentation-exceptions, the generator silently defaults missing
documentation to "Not documented".  Right now, we're using this loophole
some 500 times.

Most of the offenders are enumeration values.  Their meaning is perhaps
easier to guess than the meaning of command arguments, member data, and
object type members.  Ignoring enumerations leaves 62 offenders.  Let's
examine them.

=3D qapi/block-core.json

* DummyBlockCoreForceArrays

  Not actually part of the external interface, ignore.

* Qcow2OverlapCheckFlags

  If the user needs to know what the flags do, then the flags need to be
  documented.  Else, they should not be part of the stable interface.

  Vladimir, if the former, please fix.  If the latter, please mark them
  unstable.

* ThrottleGroupProperties

  The unstable properties you're not supposed to use are undocumented.
  Tolerable, I guess.

* XDbgBlockGraph

  Only user is x-debug-query-block-graph, which is for debugging.
  Tolerable, I guess.

* blockdev-reopen

  The documentation refers to the argument ("the given set of options"),
  but since it lacks a formal @option: section, the generator concludes
  it doesn't, and supplies its "Not documented" description.
  Embarrassing.  Kevin or Hanna, please fix.

=3D qapi/machine-target.json

* query-cpu-model-baseline
* query-cpu-model-comparison

  The documentation refers to the arguments ("two CPU models"), but
  since it lacks formal @modela: and @modelb: sections, the generator
  concludes it doesn't, and supplies its "Not documented" description.
  Embarrassing.  David, please fix.

* query-cpu-model-expansion

  Likewise, only the references to the arguments are even more vague.
  David, please fix.

=3D qapi/machine.json

* DummyForceArrays

  Not actually part of the external interface, ignore.

=3D qapi/net.json

* String

  Lack of the @str: section produces an embarrassing "Not documented" in
  the generated documentation.  I can post a patch to make it less
  embarrassing.  I doubt we can make it actually good, as generic
  wrapper types like this one have meaning only in the context they are
  used.  Therefore, their meaning can be usefully explained only at
  their uses, not their definition.

=3D qapi/pci.json

* PciMemoryRegion

  Michael or Marcel, please document @address.

=3D qapi/rocker.json

* query-rocker
* query-rocker-ports

  Jiri, please document the argument.

=3D qapi/run-state.json

* GuestPanicInformationHyperV

  Paolo, please document the members.

* watchdog-set-action

  Paolo, please document the argument, or ask me to do it for you.

=3D qapi/stats.json

* StatsFilter

  Paolo, please document @providers.

* StatsValue

  Paolo, please document @boolean.

* query-stats-schemas

  Paolo, please document the argument.

=3D qapi/transaction.json

* AbortWrapper
* BlockDirtyBitmapAddWrapper
* BlockDirtyBitmapMergeWrapper
* BlockDirtyBitmapWrapper
* BlockdevBackupWrapper
* BlockdevSnapshotInternalWrapper
* BlockdevSnapshotSyncWrapper
* BlockdevSnapshotWrapper
* DriveBackupWrapper

  Kevin or Hana, please document the member.

  Similar wrapper types elsewhere simply steal from the wrapped type's
  description.  Trouble is the ones wrapped here lack a description.

=3D qapi/ui.json

* InputMultiTouchEvent

  Marc-Andr=C3=A9, please document @type.

=3D qapi/virtio.json

* DummyVirtioForceArrays

  Not actually part of the external interface, ignore.


