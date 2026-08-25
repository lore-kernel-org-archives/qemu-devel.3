Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8FFC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylxC-0002UB-6a; Tue, 25 Aug 2026 03:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx8-0002P0-Tc; Tue, 25 Aug 2026 03:52:15 -0400
Received: from nx209.node01.secure-mailgate.com ([89.22.108.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx7-0000WD-5B; Tue, 25 Aug 2026 03:52:14 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wylx1-00BrP4-Nm; Tue, 25 Aug 2026 09:52:08 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787644324;
 bh=CF9r+wFrr+LtECcusIwyFhC7OMpJcvsqeVVhK3QmwnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Za00UjI17UwZca98eND4s643j+Qxac7DUGjlw5yI4yPIMb2MIi9UzqxwSLAju4qUp
 3XPXoUGTGF4wWuJCxRS+LG7LsH3osBcSJMBnC9rNS1WTlSVk9QHJNJs0yi1zgS3OII
 95maQOedit3USxGudlLRspSlXWp8IiWtNTe0kCJM=
Received: from Zeuss.fritz.box (p57b2f393.dip0.t-ipconnect.de [87.178.243.147])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id D9418280D5C;
 Tue, 25 Aug 2026 09:52:03 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Quante <christian@quante.one>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] hw/input/ps2: answer unknown mouse commands with a
 resend
Date: Tue, 25 Aug 2026 09:51:26 +0200
Message-ID: <20260825075127.34876-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825075127.34876-1-christian@quante.one>
References: <20260825075127.34876-1-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <178764432471.4156384.15725179118189851441@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00163121848371)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUfROZglzMSOikXZVRc1++9ge6U8Krfy8vM
 YLiCHlpWvCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4YZf73IxHzYo6YbzW2tE9daS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMxqKIdDR6RVaf4xWSq5/wwdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+tq5AZ/VgY4/1MSalZaSE0Xlm9JxWHJPpadBM2/K6k0
 SmWb8DAM0yQHR/Kl/6PX9fCJJxjBpnL/tp7zCBBsONo2NV1wECsBO24nb+iXicfKnEjazesecXSq
 6E2O7be1y+aIcmpMVDzl83xTpNRpuXIWL2ttn2AKlI+BxW8Po6WH9YBjB+EFOclydL7eY59y/HTJ
 x1f8cSYcea87gxom5sSE5rdGhli52NelL26sLk0S7K3CpUXntKYdS6GKHvS9DymURsPX4P4OgrgK
 HAE+1ZD1fpgWuHFXDmLfQJkx7T4kqlzgoIDCOODCq76SSOO0S/3N5CHnpSyE7dI7NJAP8tHfG8qf
 iz5tzU9rDp4qhHs+yMGnlF7jEvlEc+6yXX6xwZNwkEbPPAyn+woPLe92lgqiTiFi6mSOpIVGC3jf
 hv2ohVrMb+vHd1/lDy6xTjfhpI6L+w/5R7nlEk3DxhpDnExnN1cs5ld/stLFN+97Tk2glwWGuyHH
 wLsOT0kPLKh1MXItz6QUpE/ldRTo/osaMFFScPZCk999cx2+go1g8+0qSU8lBysIgCGqonuzqB2w
 MqeT35ix5VehBc2cUR742vO7WzYhZyYQWsHmRvTqQYLF/f3+DdUiGiQvTDAKHEF+HgCeNnm0aqdW
 3FI/XIVznGCn/pgoSvohRE11DD8eKil/fhIraTTvPshdokoIabrOxY7koUCAzDlPs1HzvHNk51fV
 8at/mpOirO4Aj7K7pCc7ItScD5zigXzsp6Nnsau6H4R0yovSvmZoRFgdut2xcbwiszlVwj1n2JAv
 HUSGQgae9yL5VN/hOLZMLz9q8jgaxDUUIO4oAyvVarsDg28/KZaDNp2ZPxInuFzPz5WylMiMWg==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.209; envelope-from=christian@quante.one;
 helo=nx209.node01.secure-mailgate.com
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

cHMyX3dyaXRlX21vdXNlKCkgZW5kcyBpdHMgY29tbWFuZCBzd2l0Y2ggd2l0aCBhIGJhcmUgImRl
ZmF1bHQ6IGJyZWFrOyIsDQpzbyBhbiB1bmtub3duIGNvbW1hbmQgZHJhd3Mgbm8gcmVwbHkgYXQg
YWxsLiBBIHJlYWwgUFMvMiBkZXZpY2UgYW5zd2Vycw0KZXZlcnkgYnl0ZSBpdCBpcyBnaXZlbiAt
LSBBQ0sgKDB4RkEpIHdoZW4gaXQgdW5kZXJzdG9vZCBvbmUsIHJlc2VuZA0KKDB4RkUpIHdoZW4g
aXQgZGlkIG5vdCAtLSBhbmQgYSBndWVzdCB0aGF0IGdldHMgbm90aGluZyBiYWNrIGlzIGxlZnQN
CndhaXRpbmcgb3V0IGl0cyByZXBseSB0aW1lb3V0LiBUaGUga2V5Ym9hcmQgcGF0aCBpbiB0aGUg
c2FtZSBmaWxlIGhhcw0KYW5zd2VyZWQgdW5rbm93biBjb21tYW5kcyB3aXRoIEtCRF9SRVBMWV9S
RVNFTkQgc2luY2UgY29tbWl0DQowNmIzNjExZmMyYTMgKCJwczI6IHJlamVjdCB1bmtub3duIGNv
bW1hbmRzLCBpbnN0ZWFkIG9mIGJsaW5kbHkNCmFjY2VwdGluZyB0aGVtIikuDQoNClR3byBndWVz
dHMgd2VyZSBtZWFzdXJlZCBvbiB0aGlzLg0KDQpPUy8yIHByb2JlcyB0aGUgbW91c2Ugd2l0aCB0
aGUgdmVuZG9yIGNvbW1hbmQgMHhCQiwgd2hpY2ggUUVNVSBkb2VzIG5vdA0KaW1wbGVtZW50LCBh
bmQgdGhlbiBwb2xscyB0aGUgc3RhdHVzIHBvcnQgdW50aWwgaXRzIG93biB0aW1lb3V0IHJ1bnMN
Cm91dC4gT24gYSBXYXJwIDMgZ3Vlc3QgdGhhdCB3YWl0IGNvc3RzIGFib3V0IDI1IG1zIG9mIGV2
ZXJ5IGJvb3QgdW5kZXINClRDRywgYW5kIDIuMSBzIHVuZGVyIEtWTSwgd2hlcmUgZWFjaCBvZiB0
aG9zZSBwb2xscyBsZWF2ZXMgdGhlIGd1ZXN0Lg0KV2l0aCB0aGlzIHBhdGNoIHRoZSB3YWl0IGVu
ZHMgb24gdGhlIGZpcnN0IHJlYWQ6IHRoZSBndWVzdCB0YWtlcyB0aGUNCnNhbWUgZXJyb3IgcGF0
aCBhbiB1bmV4cGVjdGVkIHJlcGx5IHdvdWxkLCBhbmQgZG9lcyBub3QgcmV0cnkuDQoNCkxpbnV4
IHJ1bnMgaW50byB0d28gb2YgdGhlbSB3aGlsZSBwcm9iaW5nIHRoZSBtb3VzZTogdGhlIEFMUFMg
cHJvYmUNCnNlbmRzIDB4RUMgKHJlc2V0IHdyYXAgbW9kZSksIHdoaWNoIHBzMl93cml0ZV9tb3Vz
ZSgpIG9ubHkgYW5zd2Vycw0Kd2hpbGUgdGhlIG1vdXNlIGlzIGluIHdyYXAgbW9kZSwgYW5kIHRo
ZSBUcmFja1BvaW50IHByb2JlIHNlbmRzIDB4RTEuDQpFYWNoIGNvc3RzIGxpYnBzMiBhIDIwMCBt
cyByZXBseSB0aW1lb3V0LiBUaW1pbmcgdGhlIHBzbW91c2UgZGV0ZWN0aW9uDQpmcm9tIGEgbWFy
ayB3cml0dGVuIHRvIC9kZXYva21zZyB0byB0aGUga2VybmVsJ3MgImlucHV0OiIgbGluZSwgdGhy
ZWUNCmJvb3RzIGVhY2ggb2YgYSA2LjE4LjM1IGtlcm5lbCB1bmRlciBUQ0c6IDQyNi43LzQyOC44
LzQ0MS42IG1zIHdpdGhvdXQNCnRoaXMgcGF0Y2gsIDIxLjQvMjEuNi8yMS4yIG1zIHdpdGggaXQu
IFRoZSBtb3VzZSBpcyBkZXRlY3RlZA0KaWRlbnRpY2FsbHkgZWl0aGVyIHdheTsgb25seSB0aGUg
ZXJyb3IgdGhlIHByb2JlIGVuZHMgaW4gY2hhbmdlcywgZnJvbQ0KLUVJTyAobm90aGluZyBjYW1l
IGJhY2sgYXQgYWxsKSB0byAtRVBST1RPIChsaWJwczIgZ2l2ZXMgdXAgYWZ0ZXIgaXRzDQpzZWNv
bmQgYXR0ZW1wdCkuDQoNClRoZSBzcGVjaWZpY2F0aW9uJ3Mgc2Vjb25kIHN0YWdlIC0tIDB4RkMg
KEVycm9yKSB3aGVuIHRoZSBieXRlIGFmdGVyIGENCnJlamVjdGVkIG9uZSBpcyBpbnZhbGlkIGFz
IHdlbGwgLS0gaXMgZGVsaWJlcmF0ZWx5IGxlZnQgb3V0LiBJdCB3b3VsZA0KbmVlZCBzdGF0ZSB0
aGF0IGhhcyB0byBzdXJ2aXZlIG1pZ3JhdGlvbiwgbm8gZ3Vlc3QgaXMga25vd24gdG8gdGVzdCBm
b3INCml0LCBhbmQgdGhlIGtleWJvYXJkIHBhdGggZG9lcyB3aXRob3V0IGl0IGFzIHdlbGwuDQoN
CkNjOiBxZW11LXN0YWJsZUBub25nbnUub3JnDQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gUXVh
bnRlIDxjaHJpc3RpYW5AcXVhbnRlLm9uZT4NClJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCi0tLQ0KIGh3L2lucHV0L3BzMi5jIHwg
NiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9ody9pbnB1dC9wczIuYyBiL2h3L2lucHV0L3BzMi5jDQppbmRleCA1NTE2ZWIyNjJkLi5lODMw
MGQyZDgzIDEwMDY0NA0KLS0tIGEvaHcvaW5wdXQvcHMyLmMNCisrKyBiL2h3L2lucHV0L3BzMi5j
DQpAQCAtNzMsNiArNzMsNyBAQA0KICNkZWZpbmUgQVVYX1NFVF9ERUZBVUxUICAgICAweEY2DQog
I2RlZmluZSBBVVhfUkVTRVQgICAgICAgICAgIDB4RkYgICAgLyogUmVzZXQgYXV4IGRldmljZSAq
Lw0KICNkZWZpbmUgQVVYX0FDSyAgICAgICAgICAgICAweEZBICAgIC8qIENvbW1hbmQgYnl0ZSBB
Q0suICovDQorI2RlZmluZSBBVVhfUkVTRU5EICAgICAgICAgIDB4RkUgICAgLyogQ29tbWFuZCBO
QUNLLCBzZW5kIHRoZSBjbWQgYWdhaW4gKi8NCiANCiAjZGVmaW5lIE1PVVNFX1NUQVRVU19SRU1P
VEUgICAgIDB4NDANCiAjZGVmaW5lIE1PVVNFX1NUQVRVU19FTkFCTEVEICAgIDB4MjANCkBAIC05
NTUsNiArOTU2LDExIEBAIHZvaWQgcHMyX3dyaXRlX21vdXNlKFBTMk1vdXNlU3RhdGUgKnMsIGlu
dCB2YWwpDQogICAgICAgICAgICAgICAgIHMtPm1vdXNlX3R5cGUpOw0KICAgICAgICAgICAgIGJy
ZWFrOw0KICAgICAgICAgZGVmYXVsdDoNCisgICAgICAgICAgICAvKg0KKyAgICAgICAgICAgICAq
IEEgUFMvMiBkZXZpY2UgYW5zd2VycyBldmVyeSBjb21tYW5kIGl0IGlzIGdpdmVuOyBhbiB1bmtu
b3duDQorICAgICAgICAgICAgICogb25lIGRyYXdzIGEgcmVzZW5kLg0KKyAgICAgICAgICAgICAq
Lw0KKyAgICAgICAgICAgIHBzMl9xdWV1ZShwczIsIEFVWF9SRVNFTkQpOw0KICAgICAgICAgICAg
IGJyZWFrOw0KICAgICAgICAgfQ0KICAgICAgICAgYnJlYWs7DQotLSANCjIuNTMuMA0KDQo=

