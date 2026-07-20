Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E88C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrBZ-0007pp-Mq; Mon, 20 Jul 2026 12:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBW-0007ix-87
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:42 -0400
Received: from mail-244106.protonmail.ch ([109.224.244.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBS-0004Qs-SS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784566175; x=1784825375;
 bh=nOhBGwX8D/p/CBcHAGvA8Yz3V/aWJpx5+ztQ6UX0H4U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=trlJq9aN3xA+VMM94rq7amPwjZ863E+zrrWggx9DaEGRyrZzDRYYjexRFBFMcRxOd
 55eLKXoDI8QCf2eb6yWYrSFFKuFCviPwCh+1v5IC8wwaVA/vdpV0kjzxVhmzTife11
 y6StQNlJyIWRVM3wzafZEVKiWS/UT5Cvq8C8jyKAe43wPF7keJqO8eF1hr89JtIwZj
 n78wQLv4d923fgL6dopsOqkt0/px/6ba2q/i8TINgSZTSd+QZWvAEHX2dkVWlH2Bi/
 JJfnvlrINYdZ65cIq1XWXe+bnnbBO01chVVHwCHrG/8YlgmczDKCKa88T3gfKp/BBy
 aXaY/YANZwKzQ==
X-Pm-Submission-Id: 4h3mhF3lJTz1DFh1
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH v4 2/2] hw/misc/applesmc: populate Apple SMC key table
Date: Mon, 20 Jul 2026 09:49:30 -0700
Message-ID: <20260720164930.68383-3-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260720164930.68383-1-matthew@pq.io>
References: <20260719152343.69536-1-matthew@pq.io>
 <20260720164930.68383-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=109.224.244.106; envelope-from=matthew@pq.io;
 helo=mail-244106.protonmail.ch
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

With APPLESMC_GET_KEY_BY_INDEX_CMD now functional (previous
patch), the modern macOS AppleSMC kext walks the device's key
table at boot to discover what's available. The current key
set (REV/OSK0/OSK1/NATJ/MSSP/MSSD) is sparse enough that
several macOS subsystems retry-poll keys they expect to find,
contributing to the same kSMCSpuriousData traffic the previous
patch addresses.

This patch fills the key table out to a complete iMac20,1
profile (94 additional keys plus the canonical #KEY count).
Sensor values match a real iMac20,1 idle probe published at:

  https://linux-hardware.org/?probe=999fc708a4&log=sensors

Categories:

  * 28 temperature sensors in sp78 format with idle readings
    from the probe: CPU 40 C (TC0P) / 45 C (TC0F) / 51 C
    (TCXc), GPU 36 C (TG0P) / 42 C (TG0F/TG1F/TGDD), HDD
    41 C (TH0P/TH1C/TH1F), LCD 28-29 C (TL0V/TL1V), memory
    34-36 C (TM0V/TM0P), ambient 24 C (TA0V), PSU 33 C
    (Tp00/Tp2F), generic sensors 33 C (Ts*S, TS0V), VRM
    50 C (TVMD/TVmS/TVSL/TVSR; not in the probe, conservative
    estimate). Battery sensors (TB0T/TB1T/TB2T) are
    present-with-zero because iMacs have no battery; macOS's
    "absent vs broken" distinction relies on the key being
    registered even with a zero reading.

  * 4 fan keys (FNum/F0Ac/F0Mn/F0Mx) describing iMac20,1's
    single chassis fan: 1 fan, current 1200 RPM (= F0Mn,
    matching the probe-reported idle), min 1200, max 3600.
    fpe2 encoding (raw = RPM * 4, big-endian).

  * 12 power-rail keys (PC0R/PCPC/PCPG/PCPT/PfCP/PfCT/PfGT/
    PfHT/PfM0/PfST/PSTR/PHDC) for telemetry; present-with-
    zero satisfies macOS without claiming a specific value.

  * 6 DIMM keys (DM0P/DM0S/DM1P/DM1S/MD1R/MD1W); same
    rationale.

  * 11 SMC-internal bookkeeping keys (CLKH/DICT/RPlt/SBFL/
    VRTC/WKTP plus 5 lower-case Apple-private bookkeeping
    keys cePn/cmDU/maNN/mxT1/zEPD); same rationale.

  * 13 motion-sensor / wireless keys (MSAc/MSAf/MSAg/MSAi/
    MSGA/MSHP/MSPA/MTLV/QCLV/QENA/WIr0/WIw0/WIz0). Present-
    with-zero is the correct desktop-class answer.

  * 3 write targets that must also be readable: HE0N (iGPU
    power; AGPM driver writes 1 on start), MSDW, NTOK.

  * 2 power-management gates required by AGPM and the
    watchdog probe: HE2N (dGPU power enable), WDTC.

  * 8 platform-identity / probe keys (MPRO/MPRD/LGPB/BSLN/
    EPCI/BEMB/$Adr/RGEN/DPLM/MSSW/OSWD): VirtualSMC-style
    identity plus the early boot-time SMC probe keys.

  * 2 GPU temperature sensors (TGDD/TG0P) and #KEY (the
    Apple-canonical total-keys count, computed by walking
    the data_def list at realize time).

  * 1 VirtualSMC-compatible $Num key (some drivers prefer it
    over #KEY).

After this patch, with the protocol fix from the previous
patch in place, a Sequoia 15.7.5 guest boots without the SMC
retry storm:

   Metric           | Before   | After
   -----------------|---------:|------:
   SMC errors / 5s  |   9,225  |     2
   kernel_task CPU  |    70 %  |  ~2 %
   WindowServer CPU |   509 %  |  ~6 %

Legacy macOS guests (10.11-10.13) that do not iterate the
key space see no behavioural change beyond the corrected
MSSD value (now 0x03 as on real iMac20,1 hardware) and the
fact that READ on a previously-unknown key returns zeros
instead of NOEXIST.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/misc/applesmc.c | 167 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 2b5ef3c6e0..d2f292f10e 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -493,12 +493,179 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
 
     QLIST_INIT(&s->data_def);
 
+    /* System identification */
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
     applesmc_add_key(s, "NATJ", 1, "\0");
     applesmc_add_key(s, "MSSP", 1, "\0");
     applesmc_add_key(s, "MSSD", 1, "\x03");
+
+    /*
+     * GPU power-management keys. Without HE2N the AGPM driver reads
+     * NOEXIST, errors out (0x82) and hangs the system on dynamic
+     * wallpaper changes. The driver itself sets the value to 1 on
+     * start, so the boot default of 0 is correct.
+     */
+    applesmc_add_key(s, "HE2N", 1, "\x00");  /* dGPU power enable */
+
+    /*
+     * Watchdog timer control. Queried by macOS during early boot; an
+     * unanswered query produces a cluster of SMCWDT errors per boot.
+     */
+    applesmc_add_key(s, "WDTC", 1, "\x00");
+
+    /*
+     * GPU temperature sensors. SP78 format: 16-bit big-endian with the
+     * top 8 bits encoding integer degrees C and the bottom 8 bits the
+     * fraction. Returning zeroed sensors caused macOS to flag these as
+     * broken and retry-poll. Values approximate a warm idle iMac20,1.
+     */
+    applesmc_add_key(s, "TGDD", 2, "\x2A\x00");  /* GPU diode: 42 C */
+    applesmc_add_key(s, "TG0P", 2, "\x24\x00");  /* GPU proximity: 36 C */
+
+    /*
+     * Fan control (iMac20,1 has one chassis fan). fpe2 format: raw
+     * value is RPM << 2, big-endian. Idle ~1500 RPM, range 1200-3600.
+     */
+    applesmc_add_key(s, "FNum", 1, "\x01");
+    applesmc_add_key(s, "F0Ac", 2, "\x12\xC0");  /* current: 1200 RPM idle */
+    applesmc_add_key(s, "F0Mn", 2, "\x12\xC0");  /* min:     1200 RPM */
+    applesmc_add_key(s, "F0Mx", 2, "\x38\x40");  /* max:     3600 RPM */
+
+    /* Platform-identity keys also provided by VirtualSMC. */
+    applesmc_add_key(s, "MPRO", 1, "\x01");  /* model property */
+    applesmc_add_key(s, "MPRD", 1, "\x00");  /* model product */
+    applesmc_add_key(s, "LGPB", 1, "\x00");  /* lid/GPU power */
+
+    /* CPU/power keys consumed by X86PlatformPlugin. */
+    applesmc_add_key(s, "BSLN", 1, "\x00");  /* baseline */
+    applesmc_add_key(s, "EPCI", 4, "\x00\x00\x00\x00"); /* EPC info */
+    applesmc_add_key(s, "BEMB", 1, "\x01");  /* board embedded */
+
+    /* Keys read by the boot-time SMC probe. */
+    applesmc_add_key(s, "OSWD", 2, "\x00\x00");  /* OS watchdog timer */
+    applesmc_add_key(s, "MSSW", 1, "\x00");  /* macOS software state */
+    applesmc_add_key(s, "RGEN", 1, "\x02");  /* SMC generation */
+    applesmc_add_key(s, "DPLM", 4, "\x00\x00\x00\x00"); /* display power */
+    applesmc_add_key(s, "$Adr", 4, "\x00\x00\x03\x00"); /* SMC base addr */
+
+    /*
+     * Temperature sensors covering the rails the macOS AppleSMC client
+     * polls on an iMac20,1-class host. Values are realistic idle
+     * readings in SP78 (big-endian) format; zeros trigger retry storms
+     * on broken-sensor paths.
+     */
+    applesmc_add_key(s, "TC0F", 2, "\x2D\x00");  /* CPU PECI filt: 45 C */
+    applesmc_add_key(s, "TC0P", 2, "\x28\x00");  /* CPU proximity: 40 C */
+    applesmc_add_key(s, "TCXc", 2, "\x33\x00");  /* CPU core max: 51 C */
+    applesmc_add_key(s, "TG0F", 2, "\x2A\x00");  /* GPU 0 filt: 42 C */
+    applesmc_add_key(s, "TG1F", 2, "\x2A\x00");  /* GPU 1 filt: 42 C */
+    applesmc_add_key(s, "TH0P", 2, "\x29\x00");  /* HDD proximity: 41 C */
+    applesmc_add_key(s, "TH1A", 2, "\x1A\x00");  /* HDD 1 ambient: 26 C */
+    applesmc_add_key(s, "TH1C", 2, "\x29\x00");  /* HDD 1 core: 41 C */
+    applesmc_add_key(s, "TH1F", 2, "\x29\x00");  /* HDD 1 filt: 41 C */
+    applesmc_add_key(s, "TL0V", 2, "\x1D\x00");  /* LCD 0: 29 C */
+    applesmc_add_key(s, "TL1V", 2, "\x1C\x00");  /* LCD 1: 28 C */
+    applesmc_add_key(s, "TM0P", 2, "\x24\x00");  /* memory prox: 36 C */
+    applesmc_add_key(s, "TM0V", 2, "\x22\x00");  /* memory VRM: 34 C */
+    applesmc_add_key(s, "Tp00", 2, "\x21\x00");  /* PSU: 33 C */
+    applesmc_add_key(s, "Tp2F", 2, "\x21\x00");  /* PSU 2: 33 C */
+    applesmc_add_key(s, "Ts0S", 2, "\x21\x00");  /* sensor 0: 33 C */
+    applesmc_add_key(s, "TS0V", 2, "\x21\x00");  /* sensor 0 V: 33 C */
+    applesmc_add_key(s, "Ts1S", 2, "\x21\x00");  /* sensor 1: 33 C */
+    applesmc_add_key(s, "Ts2S", 2, "\x21\x00");  /* sensor 2: 33 C */
+    applesmc_add_key(s, "TB0T", 2, "\x00\x00");  /* no battery */
+    applesmc_add_key(s, "TB1T", 2, "\x00\x00");  /* no battery */
+    applesmc_add_key(s, "TB2T", 2, "\x00\x00");  /* no battery */
+    applesmc_add_key(s, "TA0V", 2, "\x18\x00");  /* ambient 0: 24 C */
+    applesmc_add_key(s, "TVMD", 2, "\x32\x00");  /* VRM diode: 50 C */
+    applesmc_add_key(s, "TVmS", 2, "\x32\x00");  /* VRM sense: 50 C */
+    applesmc_add_key(s, "TVSL", 2, "\x32\x00");  /* VRM sense L: 50 C */
+    applesmc_add_key(s, "TVSR", 2, "\x32\x00");  /* VRM sense R: 50 C */
+
+    /* Power and platform rails (12 keys). */
+    applesmc_add_key(s, "PC0R", 2, "\x00\x00");  /* CPU 0 rail */
+    applesmc_add_key(s, "PCPC", 2, "\x00\x00");  /* CPU package core */
+    applesmc_add_key(s, "PCPG", 2, "\x00\x00");  /* CPU package GPU */
+    applesmc_add_key(s, "PCPT", 2, "\x00\x00");  /* CPU package total */
+    applesmc_add_key(s, "PfCP", 2, "\x00\x00");  /* platform CPU power */
+    applesmc_add_key(s, "PfCT", 2, "\x00\x00");  /* platform CPU temp */
+    applesmc_add_key(s, "PfGT", 2, "\x00\x00");  /* platform GPU temp */
+    applesmc_add_key(s, "PfHT", 2, "\x00\x00");  /* platform HDD temp */
+    applesmc_add_key(s, "PfM0", 2, "\x00\x00");  /* platform memory 0 */
+    applesmc_add_key(s, "PfST", 2, "\x00\x00");  /* platform system temp */
+    applesmc_add_key(s, "PSTR", 2, "\x00\x00");  /* power supply temp rail */
+    applesmc_add_key(s, "PHDC", 2, "\x00\x00");  /* platform HDC */
+
+    /* Memory / DIMM counters (6 keys). */
+    applesmc_add_key(s, "DM0P", 2, "\x00\x00");  /* DIMM 0 proximity */
+    applesmc_add_key(s, "DM0S", 2, "\x00\x00");  /* DIMM 0 sensor */
+    applesmc_add_key(s, "DM1P", 2, "\x00\x00");  /* DIMM 1 proximity */
+    applesmc_add_key(s, "DM1S", 2, "\x00\x00");  /* DIMM 1 sensor */
+    applesmc_add_key(s, "MD1R", 2, "\x00\x00");  /* memory DIMM 1 read */
+    applesmc_add_key(s, "MD1W", 2, "\x00\x00");  /* memory DIMM 1 write */
+
+    /* SMC internal bookkeeping (11 keys). */
+    applesmc_add_key(s, "CLKH", 1, "\x00");  /* clock halt */
+    applesmc_add_key(s, "DICT", 1, "\x00");  /* dictionary */
+    applesmc_add_key(s, "RPlt", 2, "\x00\x00");  /* platform revision */
+    applesmc_add_key(s, "SBFL", 1, "\x00");  /* secure boot flags */
+    applesmc_add_key(s, "VRTC", 2, "\x00\x00");  /* virtual RTC */
+    applesmc_add_key(s, "WKTP", 2, "\x00\x00");  /* wake type */
+    applesmc_add_key(s, "zEPD", 1, "\x00");  /* endpoint descriptor */
+    applesmc_add_key(s, "cePn", 1, "\x00");  /* CE panel */
+    applesmc_add_key(s, "cmDU", 1, "\x00");  /* cm display unit */
+    applesmc_add_key(s, "maNN", 1, "\x00");  /* manufacturer NN */
+    applesmc_add_key(s, "mxT1", 2, "\x00\x00");  /* max temp 1 */
+
+    /* Miscellaneous sensor/motion keys (13 keys). */
+    applesmc_add_key(s, "MSAc", 1, "\x00");  /* motion sensor active */
+    applesmc_add_key(s, "MSAf", 1, "\x00");  /* motion sensor filter */
+    applesmc_add_key(s, "MSAg", 1, "\x00");  /* motion sensor gain */
+    applesmc_add_key(s, "MSAi", 1, "\x00");  /* motion sensor interval */
+    applesmc_add_key(s, "MSGA", 1, "\x00");  /* MSG A */
+    applesmc_add_key(s, "MSHP", 1, "\x00");  /* MS HP */
+    applesmc_add_key(s, "MSPA", 1, "\x00");  /* MS PA */
+    applesmc_add_key(s, "MTLV", 1, "\x00");  /* MT level */
+    applesmc_add_key(s, "QCLV", 1, "\x00");  /* Q clevel */
+    applesmc_add_key(s, "QENA", 1, "\x00");  /* Q enable */
+    applesmc_add_key(s, "WIr0", 2, "\x00\x00");  /* WiFi rate 0 */
+    applesmc_add_key(s, "WIw0", 2, "\x00\x00");  /* WiFi write 0 */
+    applesmc_add_key(s, "WIz0", 2, "\x00\x00");  /* WiFi zone 0 */
+
+    /* Write targets that must also be readable. */
+    applesmc_add_key(s, "HE0N", 1, "\x00");  /* iGPU power; driver sets 1 */
+    applesmc_add_key(s, "MSDW", 1, "\x00");  /* MSD write */
+    applesmc_add_key(s, "NTOK", 1, "\x00");  /* notification token */
+
+    /*
+     * VirtualSMC-compatible total-keys key. Kept for compatibility with
+     * drivers that look for $Num; the canonical Apple #KEY below is what
+     * macOS actually iterates against.
+     */
+    applesmc_add_key(s, "$Num", 4, "\x00\x00\x00\x5e");
+
+    /*
+     * #KEY - Apple SMC convention for "total key count". macOS reads it
+     * at boot and iterates 0..count-1 via APPLESMC_GET_KEY_BY_INDEX_CMD.
+     * Without this key, macOS iterates unbounded and every out-of-range
+     * request floods the kernel log with kSMCSpuriousData errors
+     * (measured ~1800/sec on macOS 15). Count is computed by walking the
+     * list. The buffer is function-static so the pointer stays valid
+     * for the device's lifetime.
+     */
+    {
+        int count = 1;  /* include #KEY itself */
+        struct AppleSMCData *def;
+        static char numkey_buf[4];
+
+        QLIST_FOREACH(def, &s->data_def, node) {
+            count++;
+        }
+        stl_be_p(numkey_buf, count);
+        applesmc_add_key(s, "#KEY", 4, numkey_buf);
+    }
 }
 
 static void applesmc_unrealize(DeviceState *dev)
-- 
2.50.1 (Apple Git-155)


