Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D06C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1lfO-0001gs-34; Mon, 07 Apr 2025 08:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1lfM-0001gS-0B
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1lfH-0000zM-Ve
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744029201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bC8nBTne87FShfgPevYSEiNOFCAwW0SvjNSi9478owE=;
 b=i80iyTCH53TxkOMEyzB1YNjp0TO69PphoMxrFgazHPJvAlA3Xg92qor+aba1g4CxF+WZX9
 DZOiQbmg5I4P+odnDZurrp3/dPhXps6kJJ/cwVaty9LG+dDH4CshE5HcAw0dL9fwUT7D8h
 TkpgxXJ3Ik+iQaL+5xktxy6lNGAlHWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-N_NoGigyOJq1DCVz808ciA-1; Mon,
 07 Apr 2025 08:33:17 -0400
X-MC-Unique: N_NoGigyOJq1DCVz808ciA-1
X-Mimecast-MFC-AGG-ID: N_NoGigyOJq1DCVz808ciA_1744029196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00F101800259; Mon,  7 Apr 2025 12:33:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C00B1828AA4; Mon,  7 Apr 2025 12:33:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7343421E66C5; Mon, 07 Apr 2025 14:33:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <20250310150510.200607-1-mario.fleischmann@lauterbach.com> (Mario
 Fleischmann's message of "Mon, 10 Mar 2025 16:04:54 +0100")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
Date: Mon, 07 Apr 2025 14:33:10 +0200
Message-ID: <87semkw3qx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> This patch series introduces support for the Multi-Core Debug (MCD) API, a
> commonly used debug interface by emulators. The MCD API, defined through a
> header file, consists of 54 functions for implementing debug and trace.
> However, since it is a header-file-only interface, MCD does not specify a
> communication protocol. We get around this limitation by following a remote
> procedure call approach using QMP. The client stub corresponding to this
> implementation can be found at https://gitlab.com/lauterbach/mcdrefsrv
>
> This series is the successor to:
> "[PATCH v5 00/18] first version of mcdstub"
> (https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauterbach.com/)
>
> * Architecture-independent MCD implementation
> * QMP instead of custom TCP protocol

Rationale?  There must be pros and cons.

How much data would you expect to flow in practical usage?  QMP isn't
designed for bulk transfer...

> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>
> * Architecture-independent QTest test suite
>
> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>
> * Architecture-specific tests can be found at the client stub

[...]

>  qapi/mcd.json             | 2366 ++++++++++++++++++++++

This is *massive*.  By non-blank, non-comment lines, it's the second
largest module in qapi/, almost 9% of the entire schema.  It's larger
than the entire QEMU guest agent QAPI schema.  The QAPI generator
generates some 280KiB of C code for it.

[...]


