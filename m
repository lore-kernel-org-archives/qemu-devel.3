Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74DC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyR6L-00021H-TI; Mon, 24 Aug 2026 05:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wyR6J-000218-H1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:36:19 -0400
Received: from nx104.node01.secure-mailgate.com ([89.22.108.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wyR6H-0003Cv-Em
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:36:19 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wyR69-005akQ-IG; Mon, 24 Aug 2026 11:36:11 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787564167;
 bh=JYi0OL2xVfEo5im/mUQiXtQ4/NKUJM8uSDe76hOXlJg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pwK4SSztdz+hqLpBT9Qcnj4EQFgPFJ5Tc5hNUqIn97qh9LknNwUHHOlQD1I98zXOm
 +rk0rh8cIL157ahNMJOYYrkTEC2OG9HbM34MB6ZY9+CtmKFrfLbhyqEgUMSDY0UbOg
 qVYJWFpponKHviKLu8vJ5z53D1dEptnfFha9e+ug=
Received: from Zeuss.fritz.box (p549f1b6c.dip0.t-ipconnect.de [84.159.27.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 27675280134;
 Mon, 24 Aug 2026 11:36:07 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
Date: Mon, 24 Aug 2026 11:35:21 +0200
Message-ID: <20260824093528.170323-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJ+F1C+ZvQ4Jmm9UpnJH5=UQQL+SSGB0ecOSDaYCpgOP9wR13A@mail.gmail.com>
References: <20260823071529.16389-1-christian@quante.one>
 <CAJ+F1C+ZvQ4Jmm9UpnJH5=UQQL+SSGB0ecOSDaYCpgOP9wR13A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <178756416767.3771376.12194896670516763456@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.23)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWWIFUY3LBXPf7TEuhOQeo9E7D9jerv8Qhd
 plukN1yGWCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4Y0KqRZ932zQnuv3vP8NI6ES5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9exdvhLPuiw2USEENU6UB8GnZ/gfHrn7QVmGVHZvj/CQeAzNbFDwG/GCY70jyw
 jDnWVUDR+c6ihbT+Pmkgu8dKTnmZuN/XgpugWxfxnwJ/qtmELPnFuzvKMLz+iUfCtfJQrpttlz3e
 aTvSxT28zqN6ApSDP9fLIJcrwFeou+Cx+zcdijFnYDwIvvgDwGlGNltqz//gVodr2Bbrpa11KQ1X
 60pfttRUJPEpY+dD8D1vIveD1kaqoOX9s49As8Lf9rIL5hu6PBBmQVXJOgy40oaNgxLGDo2IfSff
 yLpMY4GiERnEqbM7eXcjjx1NgqwoSQEiRQv+PVjjwa+Z5RFCOMSo3Wzle3zs24yfrwncN9jnrJpR
 1fkgawBqrJAecnrgmFD7qO2Vs1Kyd2C/RbxtxLXHYZi/RQSVvjLZ9073r2ThsSxXvtcBnutXV2hR
 cyZeMt5qC3RC37WOfcNnA2gZY0tsDJ5OpGajzK+y6qnu2TRmCgWkeniwaIPiNK/dtWTwcPdjzQ6Y
 C7Heg3Xf7O1TOd4AR3bnyxZNhM1OcgqdW/wVtHH2Jl8eCsKWVs21EHNFpKiBCy3EfFLopN7vSgte
 XJ3eDY6DKQGnKS7zu0j0a+bKxKrS24UQEiEcX0sIf20P9Z24W5FAMBlV4QRE+Zyl9in1H/aAwarQ
 pYDOYx/6JtUO0Mqlhs6pmFPCFjhhN7CA6xKgoHAnJs1I5c9E1S43mq3kM3Qwxv7D9C3QH5nA6BrC
 GpdIe+N1TqSjWPuDI4o4oSgbUYstBS2wVr+z782L/itpmtBVV8AcwDEGcp3bMIDG5wlpy6uLmsAa
 TUOwBUuWxQ==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.104; envelope-from=christian@quante.one;
 helo=nx104.node01.secure-mailgate.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCnRoYW5rcyBmb3IgbG9va2luZyBhdCBpdC4NCg0KTWFyYy1BbmRy
w6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+IHdyb3RlOg0KPiBtYXliZSBh
ZGQgPw0KPiAgICAgICAgIGNhc2UgQVVYX1JFU0VORDoNCj4gICAgICAgICAgICAgLyogUmVzZW5k
aW5nIHRoZSBsYXN0IHBhY2tldCBpcyBub3QgaW1wbGVtZW50ZWQuICovDQo+ICAgICAgICAgICAg
IGJyZWFrOw0KDQpJJ2QgcmF0aGVyIG5vdCAtLSBhIHNpbGVudCBjYXNlIGlzIGV4YWN0bHkgd2hh
dCB0aGlzIHBhdGNoIHJlbW92ZXMsDQphbmQgMHhGRSBpcyB0aGUgd29yc3QgYnl0ZSB0byBsZWF2
ZSBzaWxlbnQ6IGEgZ3Vlc3Qgb25seSBzZW5kcyBpdA0Kb25jZSBpdCBoYXMgZGVjaWRlZCB0aGUg
cHJldmlvdXMgcmVwbHkgd2FzIGJhZCwgc28gaXQgaXMgYWxyZWFkeSBpbg0KaXRzIGVycm9yIHBh
dGggd2hlbiBpdCBlbmRzIHVwIHdhaXRpbmcgb3V0IHRoZSB0aW1lb3V0LiBUaGUga2V5Ym9hcmQN
CnBhdGggc2V0dGxlZCB0aGUgc2FtZSBxdWVzdGlvbiBpbiAwNmIzNjExZmMyYTMgKCJwczI6IHJl
amVjdCB1bmtub3duDQpjb21tYW5kcywgaW5zdGVhZCBvZiBibGluZGx5IGFjY2VwdGluZyB0aGVt
Iik7IHRoZSBtb3VzZSBwYXRoIHdhcw0Kc2ltcGx5IG5vdCB0b3VjaGVkLiBBbmQgYW5zd2VyaW5n
IDB4RkUgcHJvcGVybHkgbWVhbnMgcmVtZW1iZXJpbmcgdGhlDQpsYXN0IGJ5dGUgc2VudCBhbmQg
bWlncmF0aW5nIGl0LCB3aGljaCBpcyB3aHkgdGhlIDB4RkMgc3RhZ2UgaXMgbGVmdA0Kb3V0IHRv
by4NCg0KSWYgeW91IGFyZSBoYXBweSB3aXRoIHRoZSBwYXRjaCwgd291bGQgeW91IG1pbmQgYWRk
aW5nIHlvdXINClJldmlld2VkLWJ5IGFuZCB0YWtpbmcgaXQgdGhyb3VnaCB5b3VyIHRyZWU/IGh3
L2lucHV0L3BzMi5jIGhhcyBubw0KRjogZW50cnkgaW4gTUFJTlRBSU5FUlMsIGJ1dCB0aGUgcmVj
ZW50IHBzMi5jIGNoYW5nZXMgd2VudCBpbg0KdGhyb3VnaCB5b3UsIHNvIHlvdSBzZWVtZWQgdGhl
IHJpZ2h0IHBlcnNvbiB0byBhc2suDQoNClRoYW5rcywNCkNocmlzdGlhbg0K

