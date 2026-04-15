Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6FFA0C22
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCrXt-0006pr-KG; Wed, 15 Apr 2026 00:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>)
 id 1wCqun-0002WP-Q5; Tue, 14 Apr 2026 23:27:46 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>)
 id 1wCqul-0002kP-Pl; Tue, 14 Apr 2026 23:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776223659; x=1776482859;
 bh=YQNJxHgdQ/LGXAaVbMh2x40P8QP6CYv2MhOBUo0dpVY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ix/BHRBAOg5F9M3yIXeFdKFalAmQFxoctzIG6TpI3MQ9YPGBu5O/ZiyVM8d6xaRt4
 2zPXWokh7xVkE7nxh1vSpdmwWKZBKVjkgNMAV32Bpc3tVIOfNYYx99bqJ7srGD0fBs
 KmM7wibnBcf3mVXNKF5aiOWGu2QGyqMIr0jHD4K+rhsAo8smWPMZGYOJuqNVF6gCkE
 73OnDdsY3W363BO1xy3QkxARdiOCaZvtDnGoRZDx6kQRD3L1TOnIZUeN/xoF+TcUSy
 XXqfXXgMSeryPQNHrX9/ITHdfeFxExaJU5EhwwdhUqSVbm7fI4HY03n92cQ5FmmDLn
 WmVKihtmToREA==
Date: Wed, 15 Apr 2026 03:27:34 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Feifan Qian <bea1e@proton.me>
Cc: Bernhard Beschow <shentey@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: [PATCH] hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
Message-ID: <0NssTF_XyAbzwx4DB1ecmeaWsoqoRMwGSrf6SCVUaBsAR3aN_FinUY8ucoU3PrTya2Jdf09HrEMWR9mwdFI0HW_ZF6SBe6gi6aIgrVpZd3g=@proton.me>
In-Reply-To: <ad4b1u-MEfso3miW@redhat.com>
References: <rxuL-6ZdTjc0-X6Ez2rU4TPEObWUUb4HjRf6X2__bLs3i-9N2d5NX3HbQK2Zyrh5V2c1szltCX91cL-s-WHxX1XoBDSyx5_m6FCvmBmblIY=@proton.me>
 <ad4b1u-MEfso3miW@redhat.com>
Feedback-ID: 93226294:user:proton
X-Pm-Message-ID: 970a6343a6c3b7b60d6196dbff8ae24393009f25
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_xKSgLQP1ojGygnmeTHMx8nQ99lie8qZSbQ0eAnKTyg"
Received-SPF: pass client-ip=185.70.43.25; envelope-from=bea1e@proton.me;
 helo=mail-4325.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Apr 2026 00:08:06 -0400
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

--b1=_xKSgLQP1ojGygnmeTHMx8nQ99lie8qZSbQ0eAnKTyg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The TX Frame Control Block (FCB) is prepended to a TX frame when
BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
fields that process_tx_fcb() uses to locate L3/L4 headers within
the frame buffer:

  l3_header_offset =3D FCB byte 3 (0..255)
  l4_header_offset =3D FCB byte 2 (0..255)

These offsets are applied without any bounds check. When the
UDP-no-CTU branch is taken, the function writes zero to
l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
write target is:

  tx_buffer + 8 + 255 + 255 + 6/7 =3D tx_buffer + 525

A malicious guest can therefore corrupt up to 509 bytes of heap
memory beyond a minimally-sized (16 B) TX frame.

Fix: reject the frame and log a guest error when the minimum
required buffer length

  8 (FCB) + l3_header_offset + l4_header_offset + 8

exceeds tx_buffer_len. Move the l3_header and l4_header pointer
declarations past the new guard so that out-of-bounds pointers
are never materialised.

Cc: qemu-stable@nongnu.org
Signed-off-by: Feifan Qian <bea1e@proton.me>
---
 hw/net/fsl_etsec/rings.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 22660c32b8..e60303f52c 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -176,15 +176,30 @@ static void tx_padding_and_crc(eTSEC *etsec, uint32_t=
 min_frame_len)
 static void process_tx_fcb(eTSEC *etsec)
 {
     uint8_t flags =3D (uint8_t)(*etsec->tx_buffer);
-    /* L3 header offset from start of frame */
+    /* L3 header offset from start of frame (FCB byte 3) */
     uint8_t l3_header_offset =3D (uint8_t)*(etsec->tx_buffer + 3);
-    /* L4 header offset from start of L3 header */
+    /* L4 header offset from start of L3 header (FCB byte 2) */
     uint8_t l4_header_offset =3D (uint8_t)*(etsec->tx_buffer + 2);
+    uint8_t *l3_header;
+    uint8_t *l4_header;
+    int csum =3D 0;
+
+    /*
+     * Validate FCB header offsets before pointer arithmetic. The highest
+     * byte accessed is l4_header[7], at offset
+     *   8 (FCB size) + l3_header_offset + l4_header_offset + 7
+     * from tx_buffer. Drop the frame if this exceeds the buffer length.
+     */
+    if (etsec->tx_buffer_len < 8u + l3_header_offset + l4_header_offset + =
8u) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "eTSEC: FCB offsets exceed frame length, dropping\n"=
);
+        return;
+    }
+
     /* L3 header */
-    uint8_t *l3_header =3D etsec->tx_buffer + 8 + l3_header_offset;
+    l3_header =3D etsec->tx_buffer + 8 + l3_header_offset;
     /* L4 header */
-    uint8_t *l4_header =3D l3_header + l4_header_offset;
-    int csum =3D 0;
+    l4_header =3D l3_header + l4_header_offset;

     /* if packet is IP4 and IP checksum is requested */
     if (flags & FCB_TX_IP && flags & FCB_TX_CIP) {
--
2.43.0

--b1=_xKSgLQP1ojGygnmeTHMx8nQ99lie8qZSbQ0eAnKTyg
Content-Type: text/x-patch; name=0001-hw-net-fsl_etsec-validate-FCB-offsets-in-process_tx_.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-hw-net-fsl_etsec-validate-FCB-offsets-in-process_tx_.patch

RnJvbSBjYTY1N2Q0ZWZhZjRkN2EwNjQ0ZGM2OTZhNDVjMDllOWY2ZmY5MTY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWlmYW4gUWlhbiA8YmVhMWVAcHJvdG9uLm1lPgpEYXRlOiBX
ZWQsIDE1IEFwciAyMDI2IDExOjA4OjQ2ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzNdIGh3L25l
dC9mc2xfZXRzZWM6IHZhbGlkYXRlIEZDQiBvZmZzZXRzIGluCiBwcm9jZXNzX3R4X2ZjYigpCgpU
aGUgVFggRnJhbWUgQ29udHJvbCBCbG9jayAoRkNCKSBpcyBwcmVwZW5kZWQgdG8gYSBUWCBmcmFt
ZSB3aGVuCkJEX1RYX1RPRVVOIGlzIHNldC4gSXQgY29udGFpbnMgdHdvIGd1ZXN0LWNvbnRyb2xs
ZWQgdTggb2Zmc2V0CmZpZWxkcyB0aGF0IHByb2Nlc3NfdHhfZmNiKCkgdXNlcyB0byBsb2NhdGUg
TDMvTDQgaGVhZGVycyB3aXRoaW4KdGhlIGZyYW1lIGJ1ZmZlcjoKCiAgbDNfaGVhZGVyX29mZnNl
dCA9IEZDQiBieXRlIDMgKDAuLjI1NSkKICBsNF9oZWFkZXJfb2Zmc2V0ID0gRkNCIGJ5dGUgMiAo
MC4uMjU1KQoKVGhlc2Ugb2Zmc2V0cyBhcmUgYXBwbGllZCB3aXRob3V0IGFueSBib3VuZHMgY2hl
Y2suIFdoZW4gdGhlClVEUC1uby1DVFUgYnJhbmNoIGlzIHRha2VuLCB0aGUgZnVuY3Rpb24gd3Jp
dGVzIHplcm8gdG8KbDRfaGVhZGVyWzZdIGFuZCBsNF9oZWFkZXJbN10uIFdpdGggYm90aCBvZmZz
ZXRzIHNldCB0byAweEZGIHRoZQp3cml0ZSB0YXJnZXQgaXM6CgogIHR4X2J1ZmZlciArIDggKyAy
NTUgKyAyNTUgKyA2LzcgPSB0eF9idWZmZXIgKyA1MjUKCkEgbWFsaWNpb3VzIGd1ZXN0IGNhbiB0
aGVyZWZvcmUgY29ycnVwdCB1cCB0byA1MDkgYnl0ZXMgb2YgaGVhcAptZW1vcnkgYmV5b25kIGEg
bWluaW1hbGx5LXNpemVkICgxNiBCKSBUWCBmcmFtZS4KCkZpeDogcmVqZWN0IHRoZSBmcmFtZSBh
bmQgbG9nIGEgZ3Vlc3QgZXJyb3Igd2hlbiB0aGUgbWluaW11bQpyZXF1aXJlZCBidWZmZXIgbGVu
Z3RoCgogIDggKEZDQikgKyBsM19oZWFkZXJfb2Zmc2V0ICsgbDRfaGVhZGVyX29mZnNldCArIDgK
CmV4Y2VlZHMgdHhfYnVmZmVyX2xlbi4gTW92ZSB0aGUgbDNfaGVhZGVyIGFuZCBsNF9oZWFkZXIg
cG9pbnRlcgpkZWNsYXJhdGlvbnMgcGFzdCB0aGUgbmV3IGd1YXJkIHNvIHRoYXQgb3V0LW9mLWJv
dW5kcyBwb2ludGVycwphcmUgbmV2ZXIgbWF0ZXJpYWxpc2VkLgoKQ2M6IHFlbXUtc3RhYmxlQG5v
bmdudS5vcmcKU2lnbmVkLW9mZi1ieTogRmVpZmFuIFFpYW4gPGJlYTFlQHByb3Rvbi5tZT4KLS0t
CiBody9uZXQvZnNsX2V0c2VjL3JpbmdzLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9ody9uZXQvZnNsX2V0c2VjL3JpbmdzLmMgYi9ody9uZXQvZnNsX2V0c2VjL3Jpbmdz
LmMKaW5kZXggMjI2NjBjMzJiOC4uZTYwMzAzZjUyYyAxMDA2NDQKLS0tIGEvaHcvbmV0L2ZzbF9l
dHNlYy9yaW5ncy5jCisrKyBiL2h3L25ldC9mc2xfZXRzZWMvcmluZ3MuYwpAQCAtMTc2LDE1ICsx
NzYsMzAgQEAgc3RhdGljIHZvaWQgdHhfcGFkZGluZ19hbmRfY3JjKGVUU0VDICpldHNlYywgdWlu
dDMyX3QgbWluX2ZyYW1lX2xlbikKIHN0YXRpYyB2b2lkIHByb2Nlc3NfdHhfZmNiKGVUU0VDICpl
dHNlYykKIHsKICAgICB1aW50OF90IGZsYWdzID0gKHVpbnQ4X3QpKCpldHNlYy0+dHhfYnVmZmVy
KTsKLSAgICAvKiBMMyBoZWFkZXIgb2Zmc2V0IGZyb20gc3RhcnQgb2YgZnJhbWUgKi8KKyAgICAv
KiBMMyBoZWFkZXIgb2Zmc2V0IGZyb20gc3RhcnQgb2YgZnJhbWUgKEZDQiBieXRlIDMpICovCiAg
ICAgdWludDhfdCBsM19oZWFkZXJfb2Zmc2V0ID0gKHVpbnQ4X3QpKihldHNlYy0+dHhfYnVmZmVy
ICsgMyk7Ci0gICAgLyogTDQgaGVhZGVyIG9mZnNldCBmcm9tIHN0YXJ0IG9mIEwzIGhlYWRlciAq
LworICAgIC8qIEw0IGhlYWRlciBvZmZzZXQgZnJvbSBzdGFydCBvZiBMMyBoZWFkZXIgKEZDQiBi
eXRlIDIpICovCiAgICAgdWludDhfdCBsNF9oZWFkZXJfb2Zmc2V0ID0gKHVpbnQ4X3QpKihldHNl
Yy0+dHhfYnVmZmVyICsgMik7CisgICAgdWludDhfdCAqbDNfaGVhZGVyOworICAgIHVpbnQ4X3Qg
Kmw0X2hlYWRlcjsKKyAgICBpbnQgY3N1bSA9IDA7CisKKyAgICAvKgorICAgICAqIFZhbGlkYXRl
IEZDQiBoZWFkZXIgb2Zmc2V0cyBiZWZvcmUgcG9pbnRlciBhcml0aG1ldGljLiBUaGUgaGlnaGVz
dAorICAgICAqIGJ5dGUgYWNjZXNzZWQgaXMgbDRfaGVhZGVyWzddLCBhdCBvZmZzZXQKKyAgICAg
KiAgIDggKEZDQiBzaXplKSArIGwzX2hlYWRlcl9vZmZzZXQgKyBsNF9oZWFkZXJfb2Zmc2V0ICsg
NworICAgICAqIGZyb20gdHhfYnVmZmVyLiBEcm9wIHRoZSBmcmFtZSBpZiB0aGlzIGV4Y2VlZHMg
dGhlIGJ1ZmZlciBsZW5ndGguCisgICAgICovCisgICAgaWYgKGV0c2VjLT50eF9idWZmZXJfbGVu
IDwgOHUgKyBsM19oZWFkZXJfb2Zmc2V0ICsgbDRfaGVhZGVyX29mZnNldCArIDh1KSB7CisgICAg
ICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAorICAgICAgICAgICAgICAgICAgICAg
ICJlVFNFQzogRkNCIG9mZnNldHMgZXhjZWVkIGZyYW1lIGxlbmd0aCwgZHJvcHBpbmdcbiIpOwor
ICAgICAgICByZXR1cm47CisgICAgfQorCiAgICAgLyogTDMgaGVhZGVyICovCi0gICAgdWludDhf
dCAqbDNfaGVhZGVyID0gZXRzZWMtPnR4X2J1ZmZlciArIDggKyBsM19oZWFkZXJfb2Zmc2V0Owor
ICAgIGwzX2hlYWRlciA9IGV0c2VjLT50eF9idWZmZXIgKyA4ICsgbDNfaGVhZGVyX29mZnNldDsK
ICAgICAvKiBMNCBoZWFkZXIgKi8KLSAgICB1aW50OF90ICpsNF9oZWFkZXIgPSBsM19oZWFkZXIg
KyBsNF9oZWFkZXJfb2Zmc2V0OwotICAgIGludCBjc3VtID0gMDsKKyAgICBsNF9oZWFkZXIgPSBs
M19oZWFkZXIgKyBsNF9oZWFkZXJfb2Zmc2V0OwogCiAgICAgLyogaWYgcGFja2V0IGlzIElQNCBh
bmQgSVAgY2hlY2tzdW0gaXMgcmVxdWVzdGVkICovCiAgICAgaWYgKGZsYWdzICYgRkNCX1RYX0lQ
ICYmIGZsYWdzICYgRkNCX1RYX0NJUCkgewotLSAKMi40My4wCgo=

--b1=_xKSgLQP1ojGygnmeTHMx8nQ99lie8qZSbQ0eAnKTyg--


