Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12876C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylx8-0002LV-Az; Tue, 25 Aug 2026 03:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx4-0002Ii-A4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:52:10 -0400
Received: from nx234.node02.secure-mailgate.com ([192.162.87.234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx2-0000QR-3I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:52:10 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wylww-00EH8X-M3; Tue, 25 Aug 2026 09:52:04 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787644320;
 bh=B+CbepHtY4PBLxaldXnJJqk8tt0k0BsXukfdnTj55ZU=;
 h=From:To:Cc:Subject:Date:From;
 b=TohE/lgySRrEkntbsG8eEQeUSTA51ak8qc2YkLmPgmaHzjkFp6zgsLJ4nC8sAMH0f
 BFu90dfu886Gc4iJunH3b/wtfmwezlOGpgQFVm9/kyD4vCWSBY+rzBGLajkoWGVESt
 HD+TzN56yWKLW27CdLwOehsewTatjujOwnVD5uFQ=
Received: from Zeuss.fritz.box (p57b2f393.dip0.t-ipconnect.de [87.178.243.147])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id BB77E28014F;
 Tue, 25 Aug 2026 09:51:59 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Quante <christian@quante.one>
Subject: [PATCH v2 0/2] hw/input/ps2: answer unknown mouse commands with a
 resend
Date: Tue, 25 Aug 2026 09:51:25 +0200
Message-ID: <20260825075127.34876-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <178764432032.4155522.41300067474019760@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXx0fQz8e/hao4MHYn0XPPQMosf8usnxVyt
 DyCuMmh6vyu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4blXQ8YH/VQTwPFu+aG+74YS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMxqKIdDR6RVaf4xWSq5/wwdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9exdvhLPuiw2USEENU6UB8GnZ/gfHrn7QVmGVHZvj/CQeAzNbFDwG/GCY70jyw
 jDnWVUDR+c6ihbT+Pmkgu8dKTnmZuN/XgpugWxfxnwJ/qtmELPnFuzvKMLz+iUfCtfJQrpttlz3e
 aTvSxT28zqN6ApSDP9fLIJcrwFeou+Cx+zcdijFnYDwIvvgDwGlGNltqz//gVodr2Bbrpa11KQ1X
 60pfttRUJPEpY+dD8D1vIveD1kaqoOX9s49As8Lf9rIL5hu6PBBmQVXJOgy40oaNgxLGDo2IfSff
 yLpMY4GiERnEqbM7eXcjjx1NgqwoSQEiRQv+PVjjwa+Z5RFCOMQRxM2W6biFbzhekDa7/BtMWlcI
 SpJ6e8JC6wP/8HYDL6PjHkjTFe1Lh/zCABWv0LLHYZi/RQSVvjLZ9073r2ThsSxXvtcBnutXV2hR
 cyZeMt5qC3RC37WOfcNnA2gZY0tsDJ5OpGajzK+y6qnu2TRmCgWkeniwaIPiNK/dtWTwcPdjzQ6Y
 C7Heg3Xf7O1TOd4AR3bnyxZNhM1OcgqdW/wVtHH2Jl8eCsKWVs21EHNFpLijA2gxsviFSs9bxMoz
 pjYw21kW8Cuvmx7abSv/c61XxKrS24UQEiEcX0sIf20P9Z24W5FAMBlV4QRE+Zyl9in1H/aAwarQ
 pYDOYx/6JtUO0Mqlhs6pmFPCFjhhN7CA6xKgoHAnJs1I5c9E1S43mq3kM3Qwxv7D9C3QH5nA6BrC
 GpdIe+N1TqSjWPuDI4o4oSgbUYstBS2wVr+z782L/itpmtBVV8AcwDEGcp3bMIDG5wlpy6uLmsAa
 TUOwBUuWxQ==
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

djE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MjMwNzE1MjkuMTYz
ODktMS1jaHJpc3RpYW5AcXVhbnRlLm9uZS8NCg0KUGF0Y2ggMSBpcyB0aGUgZml4IGZyb20gdjEg
d2l0aCBpdHMgY29tbWl0IG1lc3NhZ2UgY29ycmVjdGVkLiBQYXRjaCAyIGlzDQphIGNvbW1lbnQt
b25seSBmb2xsb3ctdXAgQWtpaGlrbyBzdWdnZXN0ZWQsIGtlcHQgc2VwYXJhdGUgc28gcGF0Y2gg
MQ0Kc3RheXMgYSBwdXJlIGZpeCBmb3Igc3RhYmxlLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBj
b21taXQgbWVzc2FnZTogdGhlIHByb2JlIGRvZXMgbm90IGVuZCBpbiB0aGUgc2FtZSBlcnJvciBl
aXRoZXIgd2F5Lg0KICBXaXRob3V0IGEgcmVwbHkgbGlicHMyIHJldHVybnMgLUVJTywgd2l0aCB0
aGUgcmVzZW5kIC1FUFJPVE8gKEFraWhpa28NCiAgT2Rha2kpDQotIGNvbW1pdCBtZXNzYWdlOiBj
aXRlIDA2YjM2MTFmYzJhMyBpbnN0ZWFkIG9mIGNhbGxpbmcgdGhlIGtleWJvYXJkDQogIGJlaGF2
aW91ciB0d2VudHkgeWVhcnMgb2xkLCBpdCBpcyBmcm9tIDIwMTYgKEFraWhpa28gT2Rha2kpDQot
IGNvbW1pdCBtZXNzYWdlOiBuYW1lIGJvdGggdW5rbm93biBjb21tYW5kcyBMaW51eCBydW5zIGlu
dG8sIDB4RUMgZnJvbQ0KICB0aGUgQUxQUyBwcm9iZSBhbmQgMHhFMSBmcm9tIHRoZSBUcmFja1Bv
aW50IHByb2JlLCBhdCBhIDIwMCBtcyByZXBseQ0KICB0aW1lb3V0IGVhY2gNCi0gc2hvcnRlbiB0
aGUgbmV3IGNvbW1lbnQuIEl0cyBsYXN0IHNlbnRlbmNlIGlzIGdvbmUgYXMgc3VnZ2VzdGVkDQog
IChBa2loaWtvIE9kYWtpKSwgYW5kIHRoZSBzZW50ZW5jZSBiZWZvcmUgaXQgd2VudCBhcyB3ZWxs
OiBpdCBkZXNjcmliZWQNCiAgdGhlIHNpbGVuY2UgdGhpcyBwYXRjaCByZW1vdmVzLCB3aGljaCBi
ZWxvbmdzIGluIHRoaXMgbWVzc2FnZSByYXRoZXINCiAgdGhhbiBuZXh0IHRvIHRoZSBjb2RlIHRo
YXQgbm8gbG9uZ2VyIHByb2R1Y2VzIGl0DQotIG5ldyBwYXRjaCAyOiBnaXZlIHRoZSBrZXlib2Fy
ZCBwYXRoIHRoZSBzYW1lIGNvbW1lbnQgKEFraWhpa28gT2Rha2kpDQotIENjOiBxZW11LXN0YWJs
ZUBub25nbnUub3JnIChBa2loaWtvIE9kYWtpKQ0KLSBNYXJjLUFuZHLDqSBMdXJlYXUncyBSZXZp
ZXdlZC1ieSBjYXJyaWVkIG92ZXI6IHRoZSBjb2RlIG9mIHBhdGNoIDEgaXMNCiAgdW5jaGFuZ2Vk
IGFwYXJ0IGZyb20gdGhlIHNob3J0ZW5lZCBjb21tZW50DQoNCkNocmlzdGlhbiBRdWFudGUgKDIp
Og0KICBody9pbnB1dC9wczI6IGFuc3dlciB1bmtub3duIG1vdXNlIGNvbW1hbmRzIHdpdGggYSBy
ZXNlbmQNCiAgaHcvaW5wdXQvcHMyOiBzYXkgd2h5IHVua25vd24ga2V5Ym9hcmQgY29tbWFuZHMg
ZHJhdyBhIHJlc2VuZA0KDQogaHcvaW5wdXQvcHMyLmMgfCAxMCArKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KDQpiYXNlLWNvbW1pdDogZWVhOGZlNjFiOGJl
OGYzMDE2ZTUyMmU2YWYyNDkyNGEwMjY2Y2E5NQ0KLS0gDQoyLjUzLjANCg0K

