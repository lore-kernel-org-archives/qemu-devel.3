Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381AD41C1A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTduL-0008Kv-OX; Thu, 11 Dec 2025 05:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTduJ-0008KA-J3; Thu, 11 Dec 2025 05:28:23 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTduE-0006gs-Jv; Thu, 11 Dec 2025 05:28:23 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD31yS7nDppucNcAQ--.37344S2;
 Thu, 11 Dec 2025 18:28:11 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHH+20nDpp4jILAA--.6467S3;
 Thu, 11 Dec 2025 18:28:05 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 0/1] hw/pci: Add sec-sid property to PCIDevice
Date: Thu, 11 Dec 2025 18:27:28 +0800
Message-Id: <20251211102729.227376-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHH+20nDpp4jILAA--.6467S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWk51DEEVgADsh
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4UZF4xGF1fCryUAr17Awb_yoWrZr1DpF
 W3Aa4jyr4DGFy8Cw4xua18CayjgFZ3A34UGrn5K3W7AFs8ZwnYgFWjkr4jg3yUWr1ru3Wj
 qrWj9ry8Xw1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

this short series adds a small but important hook to PCIDevice: a
system-defined StreamID Security State (SEC_SID) field and QOM property,
intended to be used by the Arm SMMUv3 model.

One point I want to stress up front: I am fully aware that PCI/PCIe
has no architectural notion of Secure vs Non-secure. The PCIe
specification does not define a "security state" for PCIe functions, and
this patch is **not** trying to introduce such a concept or to model a
"Secure PCIe device" in the PCIe sense.

Instead, this change is driven purely by the Arm SMMU architecture.

In SMMUv3, when a device issues a DMA request, the request carries the
device's SEC_SID attribute to the SMMU. The SMMU then uses SEC_SID to
determine how to interpret the security state of that transaction:

  * If SEC_SID=Secure, the SMMU examines additional signals to decide
    whether this particular request is a Secure stream or a Non-secure
    stream.
  * If SEC_SID=Non-secure, the SMMU always treats the request as a
    Non-secure stream, regardless of any other signals.

In other words, SEC_SID=Non-secure restricts a device to Non-secure
streams only, while SEC_SID=Secure allows the SMMU to consider both
possibilities on a per-transaction basis.

The SMMU specification explicitly states that the association between
a device and its SEC_SID is a *system-defined property*. As Arm
experts have clarified during the Secure SMMU review process [1], if a
device is capable of issuing requests with SEC_SID=Secure, the system
typically applies a static marker to that device—this is precisely why
this patch proposes a static SEC_SID property for PCIe devices.

[1] https://lore.kernel.org/qemu-devel/4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org/

From QEMU's point of view, the platform needs a place to store this
attribute for each PCI function. The Secure SMMU series already
plumbs SEC_SID through the SMMUv3 internals. What is missing on the
PCI side is a simple way for the board to attach this system-defined
SEC_SID to a PCI function. This is exactly what this patch provides.

Concretely, the patch adds:

  * a `uint8_t sec_sid` field to `struct PCIDevice`; and
  * a `"sec-sid"` QOM property in `hw/pci/pci.c`.

The semantics are:

  * `sec_sid` is **not** a PCIe architectural attribute and is **not**
    visible to the guest as part of PCIe configuration space.
  * It is a system-defined attribute carried with each DMA request
    from the device to the SMMU, controlling how the SMMU interprets
    the security state of transactions:
      - SEC_SID=0 (Non-secure): all requests are treated as
        Non-secure streams
      - SEC_SID=1 (Secure): the SMMU examines per-transaction signals
        to determine Secure vs Non-secure
  * This is a static property set at device initialization, not a
    per-transaction field modified by software.
  * The default is 0, so existing machines and devices are unchanged
    unless they explicitly set `"sec-sid"`.

The idea is that board code (or test setups) can configure the SEC_SID
for specific devices, thereby controlling whether the SMMU will always
treat their transactions as Non-secure (SEC_SID=0) or whether it will
examine additional signals to distinguish Secure vs Non-secure streams
(SEC_SID=1). The PCIe protocol itself remains untouched: we are not
reinterpreting any PCIe capability or config bit as a security state,
and we are not changing how PCIe transactions are generated or routed.

Looking ahead to Arm RME-DA / TDISP modelling, the expectation is that
Realm vs Non-secure device assignment will be driven by the TDISP/DTI
protocol, in line with Arm’s guidance that DTI-ATS covers Non-secure and
Realm streams and that PCIe StreamIDs must not be used to grant Secure
privileges. In that context, we do not plan to represent Realm or
"Secure PCIe endpoints" via this static field; `"sec-sid"` remains an
Arm SMMU integration hook rather than a PCIe security model.

Feedback is very welcome on whether PCIDevice is the right place to host
this SMMU-oriented, system-defined SEC_SID, and whether the separation
between "PCIe has no security state" and "SMMU needs a security identity
for its clients" is clear enough.

Tao Tang (1):
  hw/pci: Add sec-sid property to PCIDevice

 hw/pci/pci.c                | 7 +++++++
 include/hw/pci/pci_device.h | 3 +++
 2 files changed, 10 insertions(+)

-- 
2.34.1


