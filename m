Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegDO-0007uA-40; Tue, 30 Jun 2026 17:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wegDM-0007tW-0j
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 17:41:56 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wegDI-0007Ch-Dn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 17:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1782855707; x=1783114907;
 bh=AqwNOxf7jDusFnS+r7xaI3RqIc876/LzyZNvvZuJhzs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Bb+Jf0lWYYS+juwlYeq7jRckyvDz7hhHRcoE8KWKFFt4drTBa1LCWNMu+wKcWX1qh
 mziowfgy29ssi++vuEbhsT25GAqvk5+7Zym1GJxstOaJwgaJ+ZNXVsbf5vLeQnlUJ2
 jd3S0dQBSmBXMg3elYYzO6lXLvZkMBdaQ8ui2Z0twqWoEgYCkCgN1L9XaQDYeX249u
 V1YCWUANNMrxpkViJjLngtj8l5swCnEE4HWAW/Tz82yQfMcaphHucmObBtDlLHRqHq
 LKD7zJKdPhfhKmrqGAl5VbvBr4YvXripFmDj8szVRu8tN58qkLL+OIRx8oeKykfUXz
 w/KsPzdEH8blg==
Date: Tue, 30 Jun 2026 21:41:42 +0000
To: Markus Armbruster <armbru@redhat.com>
From: Christian <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] disas: converts malloc to g_malloc0
Message-ID: <VLQ3cW-y90jLFN8RYLC7eWH7G4nyYcDC97wYVCeRXhRSqVvvwakdP2nfSIvmuDvs-oW2dTr7D_vqDh6VCfepW6uAae4WOmQqrnpLJCytYI4=@proton.me>
In-Reply-To: <87zf0cplir.fsf@pond.sub.org>
References: <20260630005249.143976-1-christianslima@proton.me>
 <87qzlor5j2.fsf@pond.sub.org>
 <ivgABRYgjCAvFEp6oiNyDgt4s4XO8EYr1VBiYPbuEzRH4UFDlpqPw4AgUlgFBb2AAKdw2EybEjNzoz8S4QPaJE2cUQjs48fm4BM97KPZ_IQ=@proton.me>
 <87zf0cplir.fsf@pond.sub.org>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: ba4d9ed753d6b73959947a9d2b5588a9170dc72d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=christianslima@proton.me; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> g_new0(T, N) allocates an array T[N].  The macro's return value is a T
> *.  So, g_new0(struct m68k_opcode *, m68k_numopcodes) returns struct
> m68k_opcode **, which fails type checking.  Good, because it's indeed
> wrong: you want an array of T, not an array of T *.
>=20
> Details at <https://docs.gtk.org/glib/func.new0.html>.
>=20
> Questions?

Thanks for your explanation, now I understand what's wrong. I'll submit a v=
2 later. :) 

