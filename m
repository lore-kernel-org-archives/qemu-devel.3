Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDo9-00049q-Ad; Mon, 29 Jun 2026 11:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1weDo8-00049W-Ia
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:22:00 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1weDo6-00077M-Ip
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:22:00 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so6035624eec.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782746517; x=1783351317; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=udH7PkQcK+5KxEpTs2tPS8RE9Pu2GSN4LH/OogvKYBI=;
 b=Stu91VMcyqDEG8/ejtyanT/f9/K89S5KaZoClPwOqKxmOxgl4RWQ+JE3F31P2GM2Jx
 ebeJRhFyeDEOX2OyvYzcqRwW517XemJWa67GPIIf5tEdhOhgB6p+0e84nhUn5M8CqwWu
 HEHjmMzt/+Oqs9yA/Vt8hOIZzkxmLEejfLJIkfjRfxNoafspzQuAZDjc3GP6zzTTLj1B
 nOIi2echfoGTN2TwojpabNnlHwQuisjOkduEi4VoK+L3g2M7ERMYEoonh3EZWEvqFBr0
 SjixiH3zcqPcXfyIxn24rmQydKRo1pFDk+ct92SvIhoT8SPy80kl9rq2pzGWIf5SWN9y
 zKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746517; x=1783351317;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udH7PkQcK+5KxEpTs2tPS8RE9Pu2GSN4LH/OogvKYBI=;
 b=Q7dcYFqKopb9EL2/+9YzMaHFslctEp8TkZurSq+MVdpOFr1Ed/EBZAygFX4crI/Buj
 t9GK669iPtqF4CgbCS8caI4EaJhS3ixeV8Iv3gLFtVKqufiBleL3t1dEbZ1zB+gZOjsW
 mpbrgoVb+7aNGZLQkZ4HrSManofswxFrbWBrqkoTt/5xi+VdKOKUrNgk6ln/8kWgYIzB
 IXBdUWx2KkjjwEGnwkw9cWrBg0e1egmXId80LAiqQpM8qVIYMKmTvRXUy4AQs3MBMIQn
 5NjZcPWdkOPv091KMUtO4GLePoNdAcYmXeJcV31oWxiHtbjMt4RZmQh4o6+H4MytgJoM
 KGfw==
X-Gm-Message-State: AOJu0YxqbtnsDUL/e8vlUWITxgg5BdRTZ0oito6xoPpiS/s+fUioZxpH
 il2UzIMjZoJ911k/y9D+2dhGVhPmKXxY511Y0KxFx0Zl7rm+HL2RByxs
X-Gm-Gg: AfdE7clMfMdMkiZ7th8RlhvcLhHy3DBn0TBqfIG9xrT4te1nXHava3uERKmyLyYQA5m
 7wOPecvzi+OeV5zKnclC8R8v0RWF212zy2uSL89ggZBb1AjG0UxcpgA0pA2WIwl9JawDyIDjIrk
 oXIt3U/FMzNSmUj8aB9eaemvg6bzAwf2EpXGyj7G0pl1gtrUnQl0yVjpNzFo9a6sIEH+IHuwQ5+
 TE5raVEnM33cL2CAjGM807JxYjDIl5HtRhM/Xaei9YzQ3aRJfOgoQqcyXwpviIVywvfpQvnlkKE
 hEAwDZ+lMeSNe3DmXIE/JIoM4KQFcOeuyHkwEHmiCtgUK3MMeuwVHqSpJbhrzomBUXxTuGjhSPJ
 GmZgMfUi+pGU+ac11pVe4C056XC/mGJ4SwdwkZiIfaI57AE3lZZ0ZHZi4jJiArjPXp6yQJQCEWH
 O6llY1S0bdykzho/tmY7ss37urCP8ZM+MQZA9b4YYGWyouiD6jmunvqoOA+dyyh8GD+zU=
X-Received: by 2002:a05:7300:72ce:b0:30e:d109:d65f with SMTP id
 5a478bee46e88-30ed109df3dmr1817710eec.12.1782746516765; 
 Mon, 29 Jun 2026 08:21:56 -0700 (PDT)
Received: from [127.0.0.1] (67-2-23-151.slkc.qwest.net. [67.2.23.151])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c944999adsm41535259eec.24.2026.06.29.08.21.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2026 08:21:56 -0700 (PDT)
From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Date: Mon, 29 Jun 2026 09:21:23 -0600
Subject: [PATCH v5] hw/net: fix e1000e/igb ip_len inflation by Ethernet
 minimum-frame padding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHONQmoC/4XQTW7DIBAF4KtErDMVYDCmq96j6gLM2CY/2DIUp
 Yp89+JUlaws4uUbPX1PmjuJOHuM5P1wJzNmH/0YSpDHA2kHE3oE70omnPKa1ryBgAnSDaZzAj/
 BBUOfBpiMcz70oCVDJTujlRWkENOMnb89+M+vvxy/7QnbtJprY/AxjfPPYz+ztfc/JV5PZQYMl
 OG8Q20FCvrRX42/vLXjlaxTmW8xuYPxgvFGOWqN1NiyZ6zaYmoHqwqGTU2dseVUdc+Y2GI7H82
 iYA3XtqqdlcbZLbYsyy+A3tg5wQEAAA==
X-Change-ID: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>, 
 Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782746515; l=5094;
 i=y.sanjeevreddy@gmail.com; s=20260624-gmail; h=from:subject:message-id;
 bh=vUWcGCRvSwmc+K6O9y+S0Gaxc/AakJ9DsiyS+036BXs=;
 b=k0fFa/x4Md4RZ0H+P+v/ygbid5oL3u9mzyUUj6bvhzbkWTip9dqG78OlwELn92d1yr4fiodgR
 bzljnSDfIADC0EwzA0JW3WWa6qtRaa61AYMIWcv6sEK0EbNUcd3shzZ
X-Developer-Key: i=y.sanjeevreddy@gmail.com; a=ed25519;
 pk=3ELbcw0bH36IEv3JvxqzTAgl5rrkOyv/tQHQzhpObAU=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When a guest transmits a short Ethernet frame, iov_size() returns the
padded wire length including any bytes added to reach the Ethernet
minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
then overwrites the IPv4 Total Length field with payload_len +
l3_hdr_len, inflating it by the padding.  The receiver interprets
Ethernet padding as IP payload, producing a malformed packet.

Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum()
so it only recomputes the checksum, and moving the ip_len assignment
into net_tx_pkt_update_ip_checksums() where it is only performed for
TSO (where ip_len must be derived from payload_len since the guest sets
ip_len=0 per Intel 82574 datasheet §7.3.4 for super-packets the host
will segment).

Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
from their IXSM paths, so both are corrected by this single common-
layer change.

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
---
Thank you Akihiko for the review of v4. I agree that avoiding two
similar functions is cleaner. v5 moves the ip_len write into
net_tx_pkt_update_ip_checksums() (the TSO path that already owns it)
and strips it from net_tx_pkt_update_ip_hdr_checksum(), which becomes a
pure checksum recomputation. The net effect is that both e1000e and igb
IXSM paths are corrected automatically without any device-layer change.

Changes in v5:
- Remove the ip_len write from net_tx_pkt_update_ip_hdr_checksum() so
  it only recomputes the checksum.
- Move the ip_len assignment into net_tx_pkt_update_ip_checksums() (the
  TSO path), which already called net_tx_pkt_update_ip_hdr_checksum()
  immediately after. The comment and the ip_len line are restored to
  their upstream positions.
- Remove net_tx_pkt_update_ip_hdr_checksum_only() entirely — no longer
  needed.
- Revert the e1000e IXSM path to its original call of
  net_tx_pkt_update_ip_hdr_checksum(). Because that function no longer
  inflates ip_len, igb (which already calls the same function) is also
  corrected with no additional change.
- Link to v4: https://lore.kernel.org/qemu-devel/20260628-net-tx-pkt-ip-length-padding-v4-1-829b36db5adb@gmail.com

Changes in v4:
- Add net_tx_pkt_update_ip_hdr_checksum_only(); call it from the e1000e
  IXSM path to avoid inflating ip_len.
- Link to v3: https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-ip-length-padding-v3-1-e860dabadd3f@gmail.com

Changes in v3:
- Architectural redesign: three-case fallback logic in
  net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_len() API;
  e1000e pre-sets payload_len from PAYLEN descriptor field.
- Link to v2: https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com

Changes in v2:
- Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()
  to use iov_size() to preserve correct wire frame size.
- Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com

On the relationship to the short-packet receive-path discussion
(Peter Maydell):
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

The linked thread concerns the receive path. This patch addresses only
the transmit path: the IXSM offload path was overwriting a correctly
set guest ip_len with an inflated value that included Ethernet padding.
No changes to padding behaviour or the receive path are made.

To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca2..b134348fe8 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
     uint16_t csum;
     assert(pkt);
 
-    pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
-        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
-
     pkt->l3_hdr.ip.ip_sum = 0;
     csum = net_raw_checksum(pkt->l3_hdr.octets,
         pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
@@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
 
     if (gso_type == VIRTIO_NET_HDR_GSO_TCPV4 ||
         gso_type == VIRTIO_NET_HDR_GSO_UDP) {
-        /* Calculate IP header checksum */
+        /* Set ip_len and calculate IP header checksum */
+        pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
+            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
         net_tx_pkt_update_ip_hdr_checksum(pkt);
 
         /* Calculate IP pseudo header checksum */

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4

Best regards,
--  
Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>


