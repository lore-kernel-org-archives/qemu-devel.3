Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4210C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyx7Q-00054y-4Z; Tue, 25 Aug 2026 15:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wyx7J-00054b-6J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:47:29 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wyx7H-0002TX-8C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:47:28 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 251D4240027
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1787687237;
 bh=SFpIIqo1sYz+OcxZIbBPIW3jsGXSRzydeB8Cbc8gD2c=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=ZimCHIceEmOx7knHllMMkY9GQhrr/fDilGeNbDu/REF5/Bri1TCPzVYH9yjje1Dpm
 p5v6YTpuG+frVoeuUANswR17zX13cdqvOK8Md8kDlkZueCMaN6PfDWgiL7vF4AhUGp
 J4tKCOQlmqVc1Nerl97CnXqDKMgddUxI78iOHp8YMnyQg8+g8+uA2h95SK96kciwdv
 +PIr5YpoNMjjzEksKG9Ddra5es+ws/QZdPmPd3AM/y6MvFZ+ukdJOQgl+kaL+wRkU+
 hlTQ6RRqMVzAK7/BWkntI+TDcLNsFsdZFvEU6q3wrYmPhAvsDuneVZa4nfFgqiefcG
 vZkR5AVwKRsNg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hTywf1tjbz9rxD;
 Tue, 25 Aug 2026 21:47:14 +0200 (CEST)
Date: Tue, 25 Aug 2026 19:47:16 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@mailo.com>, "Daniel P. =?UTF-8?B?QmVy?=
 =?UTF-8?B?cmFuZ8Op?=" <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 11/49] python, tests: switch usernet queries from HMP
 to QMP
Message-ID: <20260825214713.43c68662@tpx1>
In-Reply-To: <20260825-qemu-no-hmp-v4-11-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-11-af60857c2fbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Tue, 25 Aug 2026 23:09:18 +0400
schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:

> Replace human-monitor-command "info usernet" calls with the structured
> x-query-usernet QMP command in get_usernet_hostfwd_port() and the VM
> test runner boot path.
>=20
> Since x-query-usernet returns a list of UsernetInfo entries, callers
> now iterate over the result and extract the port from each entry's
> "info" field. Also switch get_info_usernet_hostfwd_port() from
> split('\r\n') to splitlines(), since QMP strings use \n rather than
> the HMP monitor's \r\n line endings.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  python/qemu/utils/__init__.py       |  5 +++--
>  tests/functional/qemu_test/utils.py |  8 ++++++--
>  tests/vm/basevm.py                  | 13 ++++++++-----
>  3 files changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

