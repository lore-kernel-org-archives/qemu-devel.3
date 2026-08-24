Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E08C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySmG-0005uZ-48; Mon, 24 Aug 2026 07:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wySmD-0005tj-Q6; Mon, 24 Aug 2026 07:23:41 -0400
Received: from nx234.node02.secure-mailgate.com ([192.162.87.234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wySmB-00080e-Lj; Mon, 24 Aug 2026 07:23:41 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wySm6-004UhD-OF; Mon, 24 Aug 2026 13:23:36 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787570614;
 bh=95O+MS2mG4VmmMsRxcpjW1CCErrRVp9iKcHJjPBKxEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RxCD37ALtlCAQ1/tJyYU/GJNgjj1kSiWCKzSFy6Q0nd4666n5pyBcABSoesAAfcSN
 gAodC1hQhAxHeUBSd46886TcR/l8gCupHxaMI9vrpD1FUCirnklc7Lu5KQqGB639St
 ImhTG1bV3iqSHMIZmnnpfSLeqwgMse/O9XhMFlYY=
Received: from Zeuss.fritz.box (p549f1b6c.dip0.t-ipconnect.de [84.159.27.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 6D9A2281323;
 Mon, 24 Aug 2026 13:23:33 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] tests/qtest/fdc-test: give each test case its own
 instance
Date: Mon, 24 Aug 2026 13:23:06 +0200
Message-ID: <20260824112307.223856-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJ+F1CJNFWBzHHxteGW8nzow7yQz0WEJ9Jq9nnb=nnZkY4hf-A@mail.gmail.com>
References: <20260822104329.42121-1-christian@quante.one>
 <CAJ+F1CJNFWBzHHxteGW8nzow7yQz0WEJ9Jq9nnb=nnZkY4hf-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <178757061418.4135057.13766380425315822508@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.14)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXMNsNkcozNjzwJFa8uNG+2uQZJSvMB8I0a
 gorB89fSwiu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aguOUJwr0BcdLCao/0UosPS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEG9vh2CZ3C
 vkagHub+zVCHrxrAiQ9LrFKjKskiGXdOYifNjAo/oI1KsSlinhiZwSTM7upkSXAQr6kxkmkxKd7E
 gmVz1j4MRe+OdlYkVJrlZi4DrT70dovxC24/X+dx3iVqNQWouD+StPihut1YERjFuTVdcBArATtu
 J2/ol4nHypyOKHLLhan4BgfOZg7NxmLMiHJqTFQ85fN8U6TUablyFoaktSV23yW2kRkZ1STTlvyS
 SkkodsE9A7aabI2png6COg8+9WnNZNKNZzh6/juqNoUDdQl9V0c9d/YobD16vuKxFGQ4vCG4s2WF
 lEEMBFdTnwVttTGbPZQ2vuj3VtqaSXKuj5D68qQa6wYb++9LglDqooJ1hYjbe8tDWxDEQAiIICLg
 Ry4R+LevT3ukK0wQjuidX4Ts4xdG+C13IyWeZaJ+vj6Z1e6VqJ/2hzezzPbPgyXE5+nszCmLNvCS
 4m1IrRV61EK0+NGD4x6kJQuHL57ef5IEQmC8tcPrfRiWeGz1YKXsVcvkJZ8hZzhZojNMISvwmZcM
 MlDgby7Lu32tU74PRIdT81G2W7kutZwCjGbJZbaJCmrSVkQ4zD+ZkqLGRxEVniihuDwEGDcmr6e3
 OPSvnKrWgldgJy7s2QKVxGAzZwioGcQ4txdQiO8GuW1C/yX+AkDv2zmC+7G58et2GLi6TmeKjn+K
 eDKPUy7BAouK1nuz7DJn3RYUe7VLMer8Z+owA6IEbrog8oFAuhnQq8d+pvlHhV6a5QjptwQBGybQ
 Gy70brFKPK7Urm8/XJkD35M1dmrjZxfr7ETxVwwKRk7kF/k9vY0fLf2KMqe9ckL0CzCvRwvqVEAQ
 MkdN/mM3fNGdTGoXks8YYGGtsjkoNd47pONjRQfJmLwGcyC+DSc7VlT05MySSHpwn19ANdUMRw==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.234; envelope-from=christian@quante.one;
 helo=nx234.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCnRoYW5rcyBmb3IgdGVzdGluZyBpdC4NCg0KPiBTZXJpZXMgbGd0
bSwgaG93ZXZlciBpdCB0YWtlcyB+MTBzIG1vcmUgbm93Lg0KDQpJIGNhbid0IHJlcHJvZHVjZSB0
aGF0IGhlcmU6IGZkYy10ZXN0IGdvZXMgZnJvbSAwLjhzIHRvIDIuNnMsIHNvDQorMS44cy4gV2l0
aCBhbiAtLWVuYWJsZS1hc2FuIGJ1aWxkIGl0IGlzIDMuNHMsIHN0aWxsIG5vd2hlcmUgbmVhcg0K
KzEwcy4gVGhlIHNlcmllcyB0YWtlcyB0aGUgdGVzdCBmcm9tIDIgUUVNVSBpbnN0YW5jZXMgdG8g
MTYsIGF0IGFib3V0DQoxMjhtcyBlYWNoLg0KDQpXaGF0IGFyZSB5b3UgbWVhc3VyaW5nLCBhbmQg
b24gd2hhdCBraW5kIG9mIGJ1aWxkIC0tIGZkYy10ZXN0IG9uIGl0cw0Kb3duPw0KDQpDaHJpc3Rp
YW4NCg==

