Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7100EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCVa-0003nQ-Fn; Tue, 07 Jan 2025 11:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVCVZ-0003mz-0S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:32:45 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVCVW-0003nQ-0k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Ny80E6ReHNK2cdCuwnO5fBIUrcRPUIxrNpVijyT9QfM=; b=D/S2IOuB8P3q5fTQvgugzys4ST
 emc6y0Q/FkVZ/m3uz+3ITuXdUIgzn2QsMIM12KlA0hAvMJ7EPIDsg5dIKhNIcmMwNaxohBmTKT6Ea
 C/0RClY94jqF8kSjZl+TVQO28/PeHmPsZtnODT6kaDbCMXyV6+LshH4wnwodgwQWiQ+M+f+tv5pkv
 wALGTlHAXRsFIfodAVDPagJof1jnA8A+McDHGsenfg4KXzZXj2lvKVxtslpisD5zsQOLY3JwrAGb3
 pbh4hQVP9/F9Co22HlgLzfggGe8ZiIFAXhjcyQjjGgcILt9RRhy7wxZ48oqaQ01Y5MmbTnikONQzp
 nuNcRGDg==;
Received: from 54-240-197-232.amazon.com ([54.240.197.232]
 helo=u09cd745991455d.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVCVT-00000008FHI-3gC3; Tue, 07 Jan 2025 16:32:40 +0000
Message-ID: <975f9dab5718b441e6d4463a43845dc22b5ddf8f.camel@infradead.org>
Subject: [PATCH v2] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Tue, 07 Jan 2025 16:32:39 +0000
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-Wu+oOWOpLCesAu+A/rfC"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-Wu+oOWOpLCesAu+A/rfC
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2:
 =E2=80=A2 Fix deassertion of PIRQ GSI.

 hw/i386/kvm/xen_evtchn.c | 50 +++++++++++++++++++++++++++++++---------
 hw/i386/kvm/xen_evtchn.h |  2 +-
 hw/i386/x86-common.c     | 32 ++++++++++++++++---------
 3 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index bd2a3cbee0..93f68790b0 100644
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
@@ -1628,7 +1656,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
         return false;
     }
=20
-    if (level) {
+    if (*level) {
         int port =3D s->pirq[pirq].port;
=20
         s->pirq_gsi_set |=3D (1U << gsi);
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
index a7d46c3105..13badc26a5 100644
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



--=-Wu+oOWOpLCesAu+A/rfC
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwNzE2MzIz
OVowLwYJKoZIhvcNAQkEMSIEIEXyTwj/0Db1vDd9xgq5q7NKzjvsBVvGRdWZ2ExlW0B8MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIA1domaDR6rZGn
7IstU3io8alJ7VM8e1kfkv8M380aejswjlKTo8HwwSC/PBXuLS7G+IZdlWWd8zJl60T2uBCNsfhE
MG/UwrgoJrzns6aJKDIz25pAdTUVvvUJzXsenbetj+lqxzsqQZW1VziqjGSjh3Ws0JgqafAFcZEY
iNu3zQ4Bv/+zRZWUteG9ffxNSosun3eIO/Ehl9Y1JYryjpANO/oHY6CV/Ki6tqOuGipTAUZDb+9B
IYk2IzzqJIAucBncx0OLhgPun1eoMzOJKyyuc8et2IqT5PN6ekpmUB54qMzDYp26Nc6I8aLhbs+d
UOBhOWZDpNv3GYk8Pqn6e8NvlkLmLrwCva/me79Deg9tAUiehn+DhKA8/BZWGSV/qLXG02X4Rt8y
Nx7GNi78JJLMbEQwOtGpJtbNuQtXnw2EDDN0Xc3NjqtqOt/YA2CJ6P97n/BDTI0DEYRjpgBWz4Yt
4MP7i61ZkpeYCta+seyhbTTI8sSjsHeG5ovnKcdJNqTO24HQ7IymvFiKkElxAsKL2P8wzKPoRI4f
TNwJqGDOx34ajPbos1ljSAaho10SDNV+jMBfnkOcqHFDxzorxC6HrsYRLjUbDpRw+MrnTzRYkO5z
Dj0DW3N7PTbkaE/rO0KYMuxrePNyvLljsnamOqhXRtpcEUa829YiKNJEsF37qbMAAAAAAAA=


--=-Wu+oOWOpLCesAu+A/rfC--

