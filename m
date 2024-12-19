Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0E7E7718C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJKS-0006ze-0I; Thu, 19 Dec 2024 11:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tOJK1-0005DR-Dc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:24:23 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tOJJy-0004VA-Hd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=IrTYc0/v3oSnaeSD2wGrkOKscpl/BVEg44VXVYIZ4O4=; b=r/sq/2LGje+i6iFR6Ht041ztTs
 KjPphlhJ7xkgsgGKY9Zn6cFTz4vqjS26r48vvvn3a9M8Y0zbwZOYkjOUjrNl1kTSatmkWZ3lWlmJW
 gMQHUppunZPIxEI0re1Oc2+oaK1UrxNgV3Yo+6k8GSGdNcXn7tjTYfqfJFGlVCcbwSOP8osoqJceP
 MD0g4dVD6L+ZME9Qpyy7U8Duv8DlcohwgW9qKSHQL7L50xbsmr/02vaDVxWIWxe2HDopt67FFULjg
 X8MIX6WaubYCSs/u7jhLBoAHDive8le/TKqXYi2kNGUNb3+LQveO6pybSb+F2mmZPMzaCK/5qOsyj
 71bmw6rw==;
Received: from [54.239.6.190] (helo=u09cd745991455d.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tOJJr-00000004J2o-2T4h; Thu, 19 Dec 2024 16:24:13 +0000
Message-ID: <e592f9127f2d9919e6ccb76a0afb38c5d725d8ec.camel@infradead.org>
Subject: [PATCH] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 19 Dec 2024 17:24:11 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-TjZKeDohxAaN/k9CIzRt"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--=-TjZKeDohxAaN/k9CIzRt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The system GSIs are not designed for sharing. One device might assert a
shared interrupt with qemu_set_irq() and another might deassert it, and
the level from the first device is lost.

This could be solved by using a multiplexer which functions as an OR
gate, much like the PCI code already implements for pci_set_irq() for
muxing the INTx lines.

Alternatively, it could be solved by having a 'resample' callback which
is invoked when the interrupt is acked at the interrupt controller, and
causes the devices to re-trigger the interrupt if it should still be
pending. This is the model that VFIO in Linux uses, with a 'resampler'
eventfd that actually unmasks the interrupt on the hardware device and
thus triggers a new interrupt from it if needed. QEMU currently doesn't
use that VFIO interface correctly, and just bashes on the resampler for
every MMIO access to the device "just in case".

This does neither of those. The Xen event channel GSI support *already*
has hooks into the PC gsi_handler() code, for routing GSIs to PIRQs. So
we can implement the logical OR of the external input (from PCI INTx,
serial etc.) with the Xen event channel GSI by allowing that existing
hook to modify the 'level' being asserted.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2731
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 48 +++++++++++++++++++++++++++++++---------
 hw/i386/kvm/xen_evtchn.h |  2 +-
 hw/i386/x86-common.c     | 32 ++++++++++++++++++---------
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 07bd0c9ab8..62b906e4ef 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -140,6 +140,8 @@ struct XenEvtchnState {
=20
     uint64_t callback_param;
     bool evtchn_in_kernel;
+    bool setting_callback_gsi;
+    int extern_gsi_level;
     uint32_t callback_gsi;
=20
     QEMUBH *gsi_bh;
@@ -431,7 +433,16 @@ void xen_evtchn_set_callback_level(int level)
     }
=20
     if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
-        qemu_set_irq(s->callback_gsis[s->callback_gsi], level);
+        /*
+         * Ugly, but since we hold the BQL we can set this flag so that
+         * xen_evtchn_set_gsi() can tell the difference between this code
+         * setting the GSI, and an external device (PCI INTx) doing so.
+         */
+        s->setting_callback_gsi =3D true;
+        /* Do not deassert the line if an external device is asserting it.=
 */
+        qemu_set_irq(s->callback_gsis[s->callback_gsi],
+                     level || s->extern_gsi_level);
+        s->setting_callback_gsi =3D false;
         if (level) {
             /* Ensure the vCPU polls for deassertion */
             kvm_xen_set_callback_asserted();
@@ -1596,7 +1607,7 @@ static int allocate_pirq(XenEvtchnState *s, int type,=
 int gsi)
     return pirq;
 }
=20
-bool xen_evtchn_set_gsi(int gsi, int level)
+bool xen_evtchn_set_gsi(int gsi, int *level)
 {
     XenEvtchnState *s =3D xen_evtchn_singleton;
     int pirq;
@@ -1608,16 +1619,33 @@ bool xen_evtchn_set_gsi(int gsi, int level)
     }
=20
     /*
-     * Check that that it *isn't* the event channel GSI, and thus
-     * that we are not recursing and it's safe to take s->port_lock.
-     *
-     * Locking aside, it's perfectly sane to bail out early for that
-     * special case, as it would make no sense for the event channel
-     * GSI to be routed back to event channels, when the delivery
-     * method is to raise the GSI... that recursion wouldn't *just*
-     * be a locking issue.
+     * For the callback_gsi we need to implement a logical OR of the event
+     * channel GSI and the external input (e.g. from PCI INTx), because
+     * QEMU itself doesn't support shared level interrupts via demux or
+     * resamplers.
      */
     if (gsi && gsi =3D=3D s->callback_gsi) {
+        /* Remember the external state of the GSI pin (e.g. from PCI INTx)=
 */
+        if (!s->setting_callback_gsi) {
+            s->extern_gsi_level =3D *level;
+
+            /*
+             * Don't allow the external device to deassert the line if the
+             * eveht channel GSI should still be asserted.
+             */
+            if (!s->extern_gsi_level) {
+                struct vcpu_info *vi =3D kvm_xen_get_vcpu_info_hva(0);
+                if (vi && vi->evtchn_upcall_pending) {
+                    *level =3D 1;
+                }
+            }
+        }
+
+        /*
+         * The event channel GSI cannot be routed to PIRQ, as that would m=
ake
+         * no sense. It could also deadlock on s->port_lock, if we proceed=
.
+         * So bail out now.
+         */
         return false;
     }
=20
diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index b740acfc0d..0521ebc092 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -23,7 +23,7 @@ void xen_evtchn_set_callback_level(int level);
=20
 int xen_evtchn_set_port(uint16_t port);
=20
-bool xen_evtchn_set_gsi(int gsi, int level);
+bool xen_evtchn_set_gsi(int gsi, int *level);
 void xen_evtchn_snoop_msi(PCIDevice *dev, bool is_msix, unsigned int vecto=
r,
                           uint64_t addr, uint32_t data, bool is_masked);
 void xen_evtchn_remove_pci_device(PCIDevice *dev);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 3f78182692..e061580f67 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -450,8 +450,27 @@ static long get_file_size(FILE *f)
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
+    bool bypass_ioapic =3D false;
=20
     trace_x86_gsi_interrupt(n, level);
+
+#ifdef CONFIG_XEN_EMU
+        /*
+         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
+         * routing actually works properly under Xen). And then to
+         * *either* the PIRQ handling or the I/OAPIC depending on
+         * whether the former wants it.
+         *
+         * Additionally, this hook allows the Xen event channel GSI to
+         * work around QEMU's lack of support for shared level interrupts,
+         * by keeping track of the externally driven state of the pin and
+         * implementing a logical OR with the state of the evtchn GSI.
+         */
+    if (xen_mode =3D=3D XEN_EMULATE) {
+        bypass_ioapic =3D xen_evtchn_set_gsi(n, &level);
+    }
+#endif
+
     switch (n) {
     case 0 ... ISA_NUM_IRQS - 1:
         if (s->i8259_irq[n]) {
@@ -460,18 +479,9 @@ void gsi_handler(void *opaque, int n, int level)
         }
         /* fall through */
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
-#ifdef CONFIG_XEN_EMU
-        /*
-         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
-         * routing actually works properly under Xen). And then to
-         * *either* the PIRQ handling or the I/OAPIC depending on
-         * whether the former wants it.
-         */
-        if (xen_mode =3D=3D XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
-            break;
+        if (!bypass_ioapic) {
+            qemu_set_irq(s->ioapic_irq[n], level);
         }
-#endif
-        qemu_set_irq(s->ioapic_irq[n], level);
         break;
     case IO_APIC_SECONDARY_IRQBASE
         ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
--=20
2.47.0



--=-TjZKeDohxAaN/k9CIzRt
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjE5MTYyNDExWjAvBgkqhkiG9w0BCQQxIgQgjYviOVFC
vaDSUMfv2ld4htQkwnp1ym5Tb5/FOqnZo5swgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBVzV9eDtmoHdMvnHB6RwytQb6wjmiNFyBy
qPIliiXWbDUKhs5gYS0gnLvq1QqLyDln45jkTX7dnQFmDQkN/IPLa8RzrPJRh037+uVQMbNxpzhA
DvmX+CPrGr+CFp6L+ANDTyuj2PRUmzcrBWb804C7+nMGxhCsSASmb9Fx7Duf8FLGfIxtnP+3jXWG
uONmskPND/Y/ux8LCtn3e7/ITMjy2JRGq/D0H00S/2z1CkDo1I2apGN1DlF00KLiKa5ictdbM9Vo
XCgH5ySpcmeOWoZwoK5l3B7tev4ZT9HqaZePyqE4wg/jhBVSlXPfnattQg4WoxicySkFiUh73Vuy
pZ7/QBH7d1Q/R2HwyP3Yfo0ZkI1FayelWMf8qsr9HG93rS6a03j5HAkjflhkqJGWeB7bMi87UPl9
xIG/0aTzqOxHy+E3+ms3IQ14smN3pOZlo8zRfPCCTtY7bgjOZhdGue0epLXk3AR360xJB5l3gwIW
17byF8qFiB7ovh3mDBDo1KGuS2Fc7C3j3ZqKmsomXKHXoK7y+UODnJPvec/03ZBRBhk9WxQaTESm
5h+HAjMSCEnALfseXr6/cosOdE4Rm8+CJ2quagqnk8S1Ov6+A8gXHvbapn6Wu0DD4X56tvkVSqYK
3f1Uyhpkja1e4j45+wWWx2Udb1qRvOweuv3dWnTouwAAAAAAAA==


--=-TjZKeDohxAaN/k9CIzRt--

