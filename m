Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43463C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEFk-0001Tk-3X; Mon, 14 Jul 2025 04:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a0f003c192dcfc477734+7995+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1ubE7S-0001Ce-3g
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:01:02 -0400
Received: from [2001:8b0:10b:1236:d4b0:a112:9c86:6a4b]
 (helo=casper.infradead.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a0f003c192dcfc477734+7995+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1ubE7P-0001Zy-C4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=mzzs7nVr1u4yX/QmCcHFo4EFPfPV2MmPe9xdYmk/yTQ=; b=DnHf0pgqB4RixxI/ow+z0In8PV
 drtcAA+thrgmUunHgjiyyejquRmoGjx2FOwZ45n8Y0SSca5t/WRZt298WuRZTOYOT09//qPiKhH8H
 HSnBM9Kjzk7gDMmAsSWF3DtjAitF9XD+uFO3TrLZRxqfWOcVRbW/9ipqdNGnL1UEQXAL7faXwweFH
 R8srzrgPLgayTGr1KEvemDg91BT4tvlj2/6aVrmsB204QZioDpvq1SbdRsPuzvP0OFXzffV5RalSM
 kMZmQjULZG9Xe6PYiHgGuXdJazoUK0gd6kmr81QUGAtoRSm0/bEZmYk3fd4JyjtCiqxY30T+m+jg4
 GEBzPq+g==;
Received: from [2001:bb6:9553:3800:d40b:2334:19cb:4c95]
 (helo=pool-ipv6-pd.agg7.cky.chf-qkr.eir.ie)
 by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1ubE7F-00000006OZR-0gB6; Mon, 14 Jul 2025 08:00:49 +0000
Message-ID: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
Subject: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt Flag
 in QI wait
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Le Tan <tamlokveer@gmail.com>, kib <kib@freebsd.org>, jhb@freebsd.org
Cc: Yi Liu <yi.l.liu@intel.com>, =?ISO-8859-1?Q?Cl=E9ment?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>,  qemu-devel@nongnu.org
Date: Mon, 14 Jul 2025 09:00:47 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-X4N/RjCf27lJWBaP9t7j"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Host-Lookup-Failed: Reverse DNS lookup failed for
 2001:8b0:10b:1236:d4b0:a112:9c86:6a4b (failed)
Received-SPF: none client-ip=2001:8b0:10b:1236:d4b0:a112:9c86:6a4b;
 envelope-from=BATV+a0f003c192dcfc477734+7995+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


--=-X4N/RjCf27lJWBaP9t7j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

FreeBSD does both, and this appears to be perfectly valid. The VT-d
spec even talks about the ordering (the status write should be done
first, unsurprisingly).

We certainly shouldn't assert() and abort QEMU if the guest asks for
both.

Fixes: ed7b8fbcfb88 ("intel-iommu: add supports for queued invalidation int=
erface")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3028
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
v2:
 =E2=80=A2 Only generate the interrupt once.
 =E2=80=A2 Spaces around bitwise OR.

This stops QEMU crashing, but I still can't get FreeBSD to boot and use
CPUs with APIC ID > 255 using *either* Intel or AMD IOMMU with
interrupt remapping, or the native 15-bit APIC ID enlightenment.
cf. https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D288122


 hw/i386/intel_iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 69d72ad35c..851c4656c5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2822,6 +2822,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s,=
 VTDInvDesc *inv_desc)
 {
     uint64_t mask[4] =3D {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSV=
D_HI,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+    bool ret =3D true;
=20
     if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
                                      __func__, "wait")) {
@@ -2833,8 +2834,6 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s,=
 VTDInvDesc *inv_desc)
         uint32_t status_data =3D (uint32_t)(inv_desc->lo >>
                                VTD_INV_DESC_WAIT_DATA_SHIFT);
=20
-        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
-
         /* FIXME: need to be masked with HAW? */
         dma_addr_t status_addr =3D inv_desc->hi;
         trace_vtd_inv_desc_wait_sw(status_addr, status_data);
@@ -2843,18 +2842,22 @@ static bool vtd_process_wait_desc(IntelIOMMUState *=
s, VTDInvDesc *inv_desc)
                              &status_data, sizeof(status_data),
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo)=
;
-            return false;
+            ret =3D false;
         }
-    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
+    }
+
+    if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
         /* Interrupt flag */
         vtd_generate_completion_event(s);
-    } else {
+    }
+
+    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
         error_report_once("%s: invalid wait desc: hi=3D%"PRIx64", lo=3D%"P=
RIx64
                           " (unknown type)", __func__, inv_desc->hi,
                           inv_desc->lo);
         return false;
     }
-    return true;
+    return ret;
 }
=20
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
--=20
2.43.0



--=-X4N/RjCf27lJWBaP9t7j
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcxNDA4MDA0
N1owLwYJKoZIhvcNAQkEMSIEIL0QLHxDa0P4H256bclPC5aYfHaefC1vdS6cJOLS6BS8MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAyFqlcJ/sqqYi
T3l9cYS1VLjAyQV85/a8S14YGQrxYKhjnYYyA6n+6AZ2REuaxqqzGcCyfdXhKYYP7ClM0u152u3c
frJNVN4UQWrLeR1nRKSP+PUjoYKoPPbIrxm3ONlvBfflZSTsD321YURNR+coJYZBKUVBQGSqbjuj
OF6BtCIXOFD6BBHCQCYixvcyM2dPRhPI4zt91hCXGq66EaBP9GZ5K9qc/AroxtUTnTDSwYMfOvmo
now2JRjOXCZZuxILF4w6jI2MJaz0/RAatvGZzDBkxH9vR/ZFnNHMaOnaUHSCDCZ0nG66eNjSh9Dv
KZRf4vaGEh9L0bELOGKyiDC45URpVswOu1ob0k+KiZ5wBKIo8UW/akHvQSMxoGHNM4o7tQuQTHVc
WXgGVlOMN77TX4dqbB/+1+NXOGgSS+hmJmX+ucdXODzdxgGXXDupAR/gDCg0788/1Cd/yPK9f9uk
7WeqDfmI9NtMfQoDQrhL32H73IODl8OoPiH17PdC8OefFR/Vy4aPedcDjjt6BqIO5JdzVhi/3ovx
lweFYhXfcVCDZBHIFax0Ez9cDc80I45RvmroeL4aG0ZvOG1kbefa0cPIjC6LFZtEJvNwnVP2yfGY
1EEemoLKtViBkh1qLoEXfMfJnehAyhTdf0pCWzXeqPsHmUs1ClzJsuagoM/7Y58AAAAAAAA=


--=-X4N/RjCf27lJWBaP9t7j--

