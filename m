Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B80BC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xhS-0003NM-2a; Mon, 31 Aug 2026 04:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x0xhQ-0003N8-SL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x0xhO-0005fF-Hi
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788166139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOicHCV+fOb9d1FZqwOmOxEpsVt9+H4B33oaEk9ynmo=;
 b=KG66rBUxmWZpRrpe/w8VmbM8v0ZcvWPb6ai+IE3TatxPQLZu6i9OieTzboEHMqQJqpNHeV
 fRluMCtKi2kagxSFMo1SmDL3l7aa+kn+Vg3mgusKSsiqbe1szkFzTiGV5CXIyulDAyDHj+
 hMbZmlYc2c4UGQNm8PyRMKKGGQRxSbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-WuvNheTfOzScVa_TTd-Hnw-1; Mon,
 31 Aug 2026 04:48:56 -0400
X-MC-Unique: WuvNheTfOzScVa_TTd-Hnw-1
X-Mimecast-MFC-AGG-ID: WuvNheTfOzScVa_TTd-Hnw_1788166134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F67B19772C2; Mon, 31 Aug 2026 08:48:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BC613000223; Mon, 31 Aug 2026 08:48:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 160F621E682E; Mon, 31 Aug 2026 10:48:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@mailo.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  "Denis V. Lunev" <den@openvz.org>,  "Jason J.
 Herne" <jjherne@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/50] Make HMP optional (and later standalone)
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 28 Aug 2026 16:03:57 +0400")
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
Date: Mon, 31 Aug 2026 10:48:48 +0200
Message-ID: <87zey2n09b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series makes HMP compile-time optional via --disable-hmp. The
> resulting binary speaks only QMP - reducing the attack surface, binary
> size and enforcing a separation between machine-readable interface and
> interactive debugging console.
>
> QMP offers almost all the functionality HMP could provide, so a separate
> standalone "HMP-like" console could be implemented on top of it. The
> rough list of missing commands (+complexity estimation) after this
> series:
>
> Debugging / introspection:
> - info registers (medium) - plus $reg expression handling
> - x/xp read memory (medium)
> - gpa2hpa/gpa2hva/gva2gpa address translation (medium)
> - info lapic (high) - deep x86 APIC state, lots of registers
> - info mem (high) - virtual memory mappings, different per arch
> - info tlb (high) - virt-to-phys mappings, also per arch
> - info mtree (high) - memory region tree, multiple view modes
> - info skeys (medium) - s390x storage keys
> - info cmma (medium) - s390x CMMA values
> - info qdm (easy) - could probably be folded into QOM introspection
> - info qtree (medium) - same, maybe QOM introspection is enough
> - info snapshots (medium)
> - info usbhost (medium)
> - info via (medium) -- VIA south bridge state

Some of these could perhaps use a query command returning
HumanReadableText.  Fine when a proper, machine-readable QMP query is
not worthwhile.

> Simple actions / settings:
> - gdbserver (trivial)
> - boot_set (easy)
> - mce (easy) - x86 MCE injection
> - sum (easy) - memory checksum
> - sync-profile (easy) - enable/disable/reset
> - info sync-profile (medium)
> - one-insn-per-tb (easy) - could be a QOM property on the accelerator
> - pcie_aer_inject_error (easy)
> - migration_mode (medium?)
> - i/o ioport read/write (easy)
> - hostfwd-add/hostfwd-remove (medium) - slirp port forwarding
> - log/logfile (medium)
> - trace-file (medium)
>
> Also, to let clients do disassembly on their side, it'd be useful to
> have something like "query-disassemble-info" that gives the client what
> architecture and endianness is used etc.
>
> In the meantime, being able to build without HMP is valuable and helps
> identifying the missing pieces. The series does so by steps:
>
> - preparatory cleanups and bug fixes
> - add commands without QMP equivalent and needed for tests
> - convert most iotests and qtests from HMP to QMP
> - guard HMP-only code paths
> - make HMP source files conditional in the build system

I wish I had had the time to review this.  Fortunately, you got review
from others.  I don't want to slow you down now.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


