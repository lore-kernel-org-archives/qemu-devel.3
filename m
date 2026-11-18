Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36050606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=Q6PrM4YD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTkHw-00007F-Vj; Wed, 18 Nov 2026 13:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTkHv-000071-EW
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:21:43 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTkHt-0002dM-HY
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795026090; bh=aS/QlrGBwEDJIZdt0AOqcIoTSjlOQCIPjQl8xDUfg/I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Q6PrM4YDpAWfYRbryrIETl/bm53vFiZzBNqxTlLGa7qJzdOcTgG8ga0LYDBDf/4lz
 F5Io3DkcxDdrgl58QH614cZeh5ZGLx3PoXr4u2tt3F+Y5VCkOZc2CrTQHfi8a3JReq
 JIrEO7OFzu+GQ3NGpindqJW/ktEDn4RhXTHo2TyM=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 29591200B6
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 19:21:29 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1900F21E6A04; Wed, 18 Nov 2026 19:21:36 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: python/qemu/ too picky with QMP responses?
In-Reply-To: <87bj7mioch.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 18 Nov 2026 08:35:26 +0100")
References: <87bj7mioch.fsf@pond.sub.org>
Date: Wed, 18 Nov 2026 19:21:36 +0100
Message-ID: <87v75udmq7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@pond.sub.org> writes:

> Marc-Andr=C3=A9 and I broke python/qemu/utils/qom_common.py in commit
> 0eee31cf1085 (qapi/qom: add qapi-type to qom-list, qom-list-properties,
> qom-list-get):

[...]

> The first assertion checks we got the members we actually require.
>
> The second assertion checks we got no members we don't know.
>
> The commit I quoted added member @qapi-type without updating the second
> assertion.
>
> Adding it to the set of members we know would be easy enough.  But is it
> appropriate?  docs/devel/qapi-code-gen.rst section "Compatibility
> considerations":
>
>     Clients are expected to ignore [members] they don't know.
>
> Shouldn't we do that here?
>
> Any objections to me hunting down and deleting such assertions?

Just sent:

    Subject: [PATCH] python/qemu: Don't choke on unknown members in QMP rep=
lies
    Date: Wed, 18 Nov 2026 19:20:05 +0100
    Message-ID: <20261118182005.1066151-1-armbru@redhat.com>

