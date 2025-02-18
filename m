Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C3AC021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTwR-00073F-13; Tue, 18 Feb 2025 15:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkTwP-00072k-CD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:11:37 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkTwN-0002uz-Pv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909493; bh=VuMr9nHQ6DS0Qlja1BtkaDckoizJdxsPWlTJdUOr7t8=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=AfOOB16O5ayjPXTPZaMAe+U24rffcOWM9CJCpIK3IF/Dx91Y1TEwyQJ/0nhdgGqwu
 qn+FkKZ5JS5D3IUOZziFSwKah4ETAAGVWYzwSXo0pIR8tdUz0hPpJz3WIZX8hc3/Vj
 o0UcgvNSMeWflfg/xq0MO6e78VpLwHOXpc/zHjpDACdP/SHkirtC41KWHMn9CL7IhC
 UG0ki/t6UFrDW7lJYabBZ3QxHBHZwj++WhqQl2hU8B6lGDJqdPR873gfIWx0jOU8oP
 J68ofs1Rqpg1MDOqkLQ/TtSvLztdJNWprE3+g8L9UvxemOByo2czbGcWudTaanE/EK
 d0eU8R54prwYA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id D41F33F20D3C;
 Tue, 18 Feb 2025 12:11:33 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id h91KEQ-AJmN4; Tue, 18 Feb 2025 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909492; bh=VuMr9nHQ6DS0Qlja1BtkaDckoizJdxsPWlTJdUOr7t8=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=QnSCIPVwY9lY5fdkCBgnMg7xGRLipLfskVa9eQxXFGd8gDelRurprPDaKbrMO1WzP
 P6PnBrVuKG3vXaix4YTBvthfpLkpA5F/eFRsvLFU5faY7kUxdIU2O4sFC5rtZnH1BM
 3KaxWAkeEy0fQgKcMIvcpUppzTeSlwCnzMBuixBLLCipRyZgPllBlwLDBLbJLOfT3m
 EVIjQvUcZcRUsw1nNQ7kpkF+c5PtVR6Zp328e7K74CPw6UinMosCR4Xfg8nzBIjKFj
 EvhVQe3UGl4sVFuyHFc1NnSGHwOG+fbTDf+yvLpxD5UN6ohfoZ5aYqXeUdkmeUa2MC
 dedXJLDtRS8PA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 98E0B3F20C61;
 Tue, 18 Feb 2025 12:11:32 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 86FAC1E60096; Tue, 18 Feb 2025 12:11:32 -0800 (PST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] target/rx: Load reset vector from memory after
 first run
In-Reply-To: <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-5-keithp@keithp.com>
 <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
Date: Tue, 18 Feb 2025 12:11:32 -0800
Message-ID: <87seobypvv.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Feb 2025 10:24:05 -0800

> By delaying the load of the reset vector to the reset_exit phase,
> you can always load from rom.

I'm not sure how -- the ROM image is discarded when it gets loaded into
read-only memory. If loaded to read-write memory, I bet it would
stay around.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAme06XQACgkQ2yIaaQAA
ABE46xAAnKURkbX6xGPzzYGKtwgmly1BgiCDBZ7Q/JPkZzvCFB1Bk0nIn8C6kKUY
6ucgYEJ75V6PhVz+RLyVf9atczUSLkTNTjQsD0LlU7uqo27WacVXYFzrPca9nT1q
7HOUddo0iXCM5orVwlvW+l3IYUVcNQyKmkI+qLlF60EtD7LFyXOnEy22LFUHThD1
iElJ73tGtUn26SVV+iucNId1K3l2JFHnzN4mAZKkn8Gg/jK9k8E/FklfaHzYL6bI
llR3krUhkLIcufSkPki2FR7uE6+XqOxsdoscYvgY/IFjlWr4KemZnGts969KjIWI
qU3OZj+ylIjb5wkhKvfu921WLDH54bhfKmD1c//lWeeqkq12nIC3aw9w9hgQ75Tv
17Xz6LMK39K89qRfhESVTYKA+q7n5bI1apiPp9ZogvE1suEU16eJVx6xGwuj6TFo
zYPYe6YZfwV+Q9gaq5JAtZuuKZQyiV/j5ncbuy15a7+Ar1NgaPvu02rEL5ys+BLx
ccOp5d4y3oGh4rw7HvWl0eDTnIfHBIoBcdbEQb1EmC5euK+9Df2sUwR04B27cp6w
dCEn3YxYqV2ZpD8RQxBLbZI3u7S4YugOlEDPeN5aIXBmaDNEeuMiKRNB+Za2ibpX
9+R13apYTKzGrPIK5QTJxP/ofoW73ZgL74l8RohtL+nrMJBhhCo=
=JC4z
-----END PGP SIGNATURE-----
--=-=-=--

