Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D05CFD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09KO-0002uV-Eo; Tue, 10 Mar 2026 22:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1w09KG-0002il-MQ; Tue, 10 Mar 2026 22:29:33 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1w09KD-00040W-O2; Tue, 10 Mar 2026 22:29:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0C16D26411;
 Wed, 11 Mar 2026 03:29:22 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLUzEZB9Mgst; Wed, 11 Mar 2026 03:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1773196161; bh=rpmQHq0DyUoGsbW/woN+HnxWW1k8JOfLbxnKoSPDeds=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
 b=Ig6HU4mDiemA4L43oCYayFojIyDDWpQxE8307f4Oesb/FX6h6HTEfG7Ga5l9BFyct
 OVbTPKC4aMAHov2tnc36WDPm3bnOrcgoQUbU1m1YAgQhgmrOn9qQ3q5VeFBf3BCc1l
 vFQ+zkT5L2FuyKwVKtCBjPhsZRkLUeKUQCKGLLR/7Is399UkJzU47X53TMscj+HdKP
 CYAsWSzw8lR/TK0Db0LT96pFdlWYheWgBCZXvjuj+x1spKY0UUVKhU04OIWVK6c95n
 mVM2QjYfP/JWgj3yWTQvKfveyMs7NPQoh4SI0T/PQInB7NtDQZgQXEEwu5SiR1c9bn
 1Fv+vPtWthPgA==
Message-ID: <e7fbf3677b84a53d44769b1711a69a1c52332c19.camel@rail5.org>
Subject: Re: [PULL 1/2] target/loongarch: Preserve PTE permission bits in LDPTE
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>, 
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Date: Wed, 11 Mar 2026 10:29:13 +0800
In-Reply-To: <55df9b3d-702b-445b-972a-6671a1b9270e@tls.msk.ru>
References: <20260310114442.1025328-1-gaosong@loongson.cn>
 <20260310114442.1025328-2-gaosong@loongson.cn>
 <55df9b3d-702b-445b-972a-6671a1b9270e@tls.msk.ru>
Autocrypt: addr=andrew@rail5.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=178.21.23.139; envelope-from=andrew@rail5.org;
 helo=layka.disroot.org
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  andrew@rail5.org
X-ACL-Warn: ,  "Andrew S. Rightenburg" <andrew@rail5.org>
From:  "Andrew S. Rightenburg" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-03-10 at 19:04 +0300, Michael Tokarev wrote:
>=20
> As far as I can see, 56599a705f2 is past 10.2.0 release, so is not
> present in any released version of qemu.  This commit also hasn't
> been back-ported to any stable series.
>=20
> So I'm not picking up this one, despite it is marked as for qemu-stable.
> Please let me know if I should pick it up regardless.
>=20
> Thanks,
>=20
> /mjt

Hi Michael,

The commit in question changed how the masking is applied, but the bug itse=
lf
existed before it. I've reproduced the issue in 10.0.7 and 10.2.0. I believ=
e the
patch is still relevant for stable

Sorry if the 'Fixes:' tag was misdirected. This is my first contribution an=
d I'm
unfamiliar with the workflow. I used 'git blame' to find the line, but that=
 line
was just a refactor, not the origin of the bug. If it would help I'd be hap=
py to
try to re-base the patch on the current release version instead of the curr=
ent
state of master

Thanks again

--=20
Regards,
Andrew S. Rightenburg

