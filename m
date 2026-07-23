Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB1C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxs4-0003GH-He; Thu, 23 Jul 2026 14:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wmxs0-0003Du-DZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:10:08 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wmxrx-0000mT-DW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:10:08 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id B13A42020282; Fri, 24 Jul 2026 03:09:57 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] qemu-options: document keep-alive-count/idle/interval
 for -netdev stream
Date: Fri, 24 Jul 2026 03:09:59 +0900
Message-ID: <20260723180959.4381-1-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ldb4o5jl.fsf@pond.sub.org>
References: <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com>
 <87y0gx8sld.fsf@pond.sub.org>
 <20260720053333.2316643-1-Mitsuru.Kariya@oss.nttdata.com>
 <87ldb4o5jl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=kariyam@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is about rejecting the inet options that -netdev dgram currently
accepts and silently ignores.  (The subject is still the stream-docs
patch this came up under.)

> We should not accept options and then silently ignore them.  Can we
> reject them instead?

Agreed.  I prototyped two ways to reject them and confirmed both work
as intended.  Of the two I lean towards B (reject in the schema); I
would like your opinion, mainly on the ABI change and on how far to
take it.

Background: -netdev dgram only ever uses the host and port of its
addresses.  It applies none of the other optional InetSocketAddress
members (numeric, to, ipv4, ipv6, keep-alive and friends, mptcp, and
now user-timeout) -- they are currently accepted and silently ignored.
(This is inet-specific; the unix abstract/tight members and the vsock
type are a separate matter, see the open point at the end.)

With either approach, valid configurations keep working as before;
only settings that used to be accepted but silently ignored (say
remote.keep-alive=on) now error out.  The approaches differ in how and
where the rejection happens, and in the schema reported by
query-qmp-schema.

Approach A -- reject in a dedicated check function
  Keep NetdevDgramOptions on SocketAddress and check in
  net_init_dgram() whether the unusable InetSocketAddress members are
  present on the 'inet' variant, erroring out with e.g.
  "'remote.keep-alive' is not supported by dgram".
  + No QMP schema/ABI change; the change stays within net/dgram.c.
  - The check has to be extended whenever a new InetSocketAddress
    member is added (user-timeout already needed one).  Forgetting to
    do so silently reintroduces exactly the bug we are fixing.
  - query-qmp-schema keeps advertising the members for dgram even
    though they are rejected at run time, so introspection disagrees
    with reality.
  - The members stay in dgram's schema although they do nothing there.
    The friendly "... is not supported by dgram" message only exists to
    paper over that; for an option that is not part of dgram (and not
    in its documentation), a plain "unexpected" would be the honest
    result.

Approach B -- reject in the schema
  Change dgram's 'inet' variant to InetSocketAddressBase (host/port
  only) instead of InetSocketAddress.
  + The schema tells the truth: dgram's inet address is just host and
    port, and query-qmp-schema reflects that.
  + An unsupported option is then rejected like any other unknown
    parameter ("Parameter 'remote.keep-alive' is unexpected"),
    identically for CLI and QMP -- the natural result for something
    that is not part of dgram.
  + Any future InetSocketAddress member is handled automatically, with
    no per-option code.
  - It is a QMP schema/ABI change (though it only removes members that
    never had any effect).
  - It needs a new union type: SocketAddress and InetSocketAddress are
    shared with stream, chardev, migration, etc., so they cannot be
    narrowed just for dgram.  Hence a parallel SocketAddressDgram whose
    'inet' variant is InetSocketAddressBase.

So I would go with B: it makes the schema and introspection honest and
needs no per-option maintenance.  A avoids the ABI change and stays
within net/dgram.c, but it keeps advertising options it then rejects
and has to be kept in sync by hand.

One open point for B is how far to take it.  dgram also does not support
the vsock type (rejected in net_init_dgram() today) and ignores the unix
abstract/tight members.  My current prototype only narrows the inet
variant, so in that minimal form B still has the same
introspection-vs-reality mismatch as A for vsock and for the unix
abstract/tight members.  Making the schema fully honest would
additionally need a dgram variant of UnixSocketAddress and a
dgram-specific type enum (without vsock).

So: does B sound like the right direction to you?  If so, how far should
the "only what dgram supports" cleanup go -- just the inet options, or
also a UnixSocketAddress base type and a vsock-less enum?  Or would you
rather keep it minimal with A, to avoid touching the ABI?

Thanks,
Mitsuru

