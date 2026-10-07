Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B76CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXqi-0002Zy-En; Wed, 07 Oct 2026 16:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEXqg-0002Zh-C9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:02:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEXqe-0001AU-GL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:02:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso39744145e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791403363; x=1792008163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8m8biAnsrsXE49Eg9RW+lARk9bHriS69duzfQr9yXfs=;
 b=AFJjgOjasq5mo8lzkLjrKutZXlbF0o1ybedR8pfyANPBUxTvFRvXoA1h9MdMnF77V+
 WXyz1nLaLomBstFnCvgXxDpldZ/ExElf1b1XA84pS7WCRVnu81p7DUhSy2PK41IwSAIw
 zxmMK+Pfw4vD25zrBzBDvg1ayFj2h5VwGGbO+capctM5NBLWk25R6Pbm/w/Vq9GNOKIv
 hqodNW6NiIlR82YMOxtJU072Xz2YWacQESmCsPlH4Rua5jqRPz3MY0qA2tHii+Gy1HEl
 lBrl7zDMtlUVC15KLTXa05hYNKn9md+LJEjz6S5tMfGjn0spYK1opQ4yAreZRWqALBgG
 ExRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403363; x=1792008163;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8m8biAnsrsXE49Eg9RW+lARk9bHriS69duzfQr9yXfs=;
 b=yaWySzXVaojPvA2XG+hXkayWpgTdQSy+YTi/6/yJPcAlS+q7KYKbAwKPq93AADi0Wa
 DSmqKR5BASQVWvrc+Ugal6udkZaJEqJcMOIQnGy/FXRCNNG1Nn5X9pIqsdSqcEpoEGFp
 RahjWuFn7KCL1zqBze/sdb0W7c2Wnq5rjj8yqumnnhZcX3aG6Aj8VrDRS4t4wltJJBqW
 AUCTW+I9mQfM5wEJWVgOtw+OTh5Rkd2F+o6AXGZYCJYMV8X1g/mTLVWn/pXvCXF0y5Jp
 2OtdOgzAhrq+7e/JYoMZiCcgdQSQ27hNQUJbBtbj2QiR3HzMNvWRDl/LtwXZ+EGoOqDL
 nxcQ==
X-Gm-Message-State: AFuF++mvvatG+ucbNQqE4jfecs9BKSP0xXn/oVs9WuHy4IcNtWwRWn/D
 Xpyhi75KH49gGciINJbBAM9LVrzOlpoRWsgUunflJuve4CnRU0/NmMUUFXTgeQ==
X-Gm-Gg: AYBFou2ERNuuSs0uSs13KJZ0du9+LPAMIUzRtZsTZd7BBqRnL/M0QRSz2au45rNGkB2
 wqBewQZ76ktx0+doeiwqU2xjqCIY3ZtV/oTHNINKcbNQ3Z3w9rrE4AtdVYg9tSOEct2iUaYHT3L
 uHAovabdCUuH/5G4kqh6ZBgE53iNn8tIquocwC9/w0VVbrw17nTR1oGaV1J8pVakTTcuE6+ikXq
 NSGCB/XPhVsREOGYtI9h4IucJoMbQ+WBmvIEEyYk9an22k7omqjbujeHD3wlQJ4hWAaJz9etCsc
 oMhv05U/rroMAzKRAcvjUWrpN2JDPpFG3FcNL3xiBunxMZG5hwBEXf6QmkqhlHxtSKfQeb1N0Bz
 DsFk9pWrelPA89iXosk65qABFdh8GD5R6ObLW3jpecTXS2Q/lbTos+RLE7sQLjtyOI9U3a2yHl+
 fkw0m/XTWQQB7zKVTxT9QQXzOhfwxx4pP/XyVrKbWLl40u+sZAbguqQpH9CiD889+iCMhWqjf5e
 UlPU0pU8OlUGl4I13H5n9DfZdhVwFaOxLTxokLrr9fo6PEymFDfIhNZjF+Ov7OMPS1exx4=
X-Received: by 2002:a05:600c:c0dc:b0:4a0:2375:dc1a with SMTP id
 5b1f17b1804b1-4a18043bc32mr42892395e9.21.1791403362859; 
 Wed, 07 Oct 2026 13:02:42 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae009c631109991f49ce.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:9c63:1109:991f:49ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843cb261sm15691555e9.3.2026.10.07.13.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:02:42 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:02:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
CC: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_16/23=5D_tests/qtest=3A_Check_s?=
 =?US-ASCII?Q?390x_boot_device_support_in_pxe-test=2Ec?=
In-Reply-To: <20260930152420.1956230-17-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
 <20260930152420.1956230-17-farman@linux.ibm.com>
Message-ID: <B8BD07F5-B1AE-47A6-AD08-0B5E0151AFF6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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



Am 30=2E September 2026 15:24:13 UTC schrieb Eric Farman <farman@linux=2Ei=
bm=2Ecom>:
>From: Zhuoying Cai <zycai@linux=2Eibm=2Ecom>
>
>The pxe test for a net device does not fail gracefully when the
>s390-ccw=2Eimg in use was built without support for booting that device=
=2E
>
>Add a boot_dev_support check that searches for a known string in the
>bios image to confirm boot support=2E If absent, the test is skipped
>gracefully instead of failing=2E
>
>Also re-enable pxe-test in qtests_s390x, which was accidentally
>removed by commit 973d97feca93=2E
>
>Signed-off-by: Zhuoying Cai <zycai@linux=2Eibm=2Ecom>
>Tested-by: Joshua Daley <jdaley@linux=2Eibm=2Ecom>
>Reviewed-by: Matthew Rosato <mjrosato@linux=2Eibm=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/qemu-devel/20260924222949=2E147720-7-zy=
cai@linux=2Eibm=2Ecom
>Signed-off-by: Eric Farman <farman@linux=2Eibm=2Ecom>
>---
> tests/qtest/meson=2Ebuild |  1 +
> tests/qtest/pxe-test=2Ec  | 85 ++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 85 insertions(+), 1 deletion(-)
>
>diff --git a/tests/qtest/meson=2Ebuild b/tests/qtest/meson=2Ebuild
>index 33f58b0e95=2E=2E341f6ad1ba 100644
>--- a/tests/qtest/meson=2Ebuild
>+++ b/tests/qtest/meson=2Ebuild
>@@ -292,6 +292,7 @@ qtests_aarch64 =3D \
>    'migration-test']
>=20
> qtests_s390x =3D \
>+  (slirp=2Efound() ? ['pxe-test'] : []) + \
>   qtests_filter + \
>   ['boot-serial-test',
>    'drive_del-test',
>diff --git a/tests/qtest/pxe-test=2Ec b/tests/qtest/pxe-test=2Ec
>index e85dec5a4e=2E=2E5c6415b936 100644
>--- a/tests/qtest/pxe-test=2Ec
>+++ b/tests/qtest/pxe-test=2Ec
>@@ -26,6 +26,7 @@ typedef struct testdef {
>     const char *machine;    /* Machine type */
>     const char *model;      /* NIC device model */
>     const char *extra;      /* Any additional parameters */
>+    bool (*boot_dev_support)(void); /* optional: boot device support che=
ck */
> } testdef_t;
>=20
> static testdef_t x86_tests[] =3D {
>@@ -58,8 +59,80 @@ static testdef_t ppc64_tests_slow[] =3D {
>     { NULL },
> };
>=20
>+static const char *s390_bios_load(gsize *len)
>+{
>+    static char *cached_contents;
>+    static gsize cached_len;
>+    const char *qemu_bin;
>+    g_autofree char *cmd =3D NULL;
>+    char dir[PATH_MAX];
>+    char *found =3D NULL;
>+    char *path =3D NULL;
>+    FILE *fp;
>+
>+    if (cached_contents) {
>+        g_test_message("Using cached bios contents");
>+        goto out;
>+    }
>+
>+    /* search the qemu binary's data directories for s390-ccw=2Eimg */
>+    qemu_bin =3D qtest_qemu_binary(NULL);
>+    cmd =3D g_strdup_printf("%s -L help", qemu_bin);
>+    fp =3D popen(cmd, "r");
>+
>+    if (!fp) {
>+        g_error("Failed to run '%s'", cmd);
>+    }
>+
>+    while (fgets(dir, sizeof(dir), fp) && !found) {
>+        dir[strcspn(dir, "\n")] =3D '\0';
>+        path =3D g_build_filename(dir, "s390-ccw=2Eimg", NULL);
>+        if (g_file_get_contents(path, &cached_contents, &cached_len, NUL=
L)) {
>+            found =3D path;
>+        } else {
>+            g_free(path);
>+        }
>+    }
>+    pclose(fp);
>+
>+    if (!found) {
>+        g_error("s390-ccw=2Eimg not found");
>+    }
>+
>+    g_test_message("Loaded %s", found);
>+    g_free(found);
>+
>+out:
>+    *len =3D cached_len;
>+    return cached_contents;
>+}
>+
>+static bool s390_bios_has_string(const char *needle)
>+{
>+    const char *contents;
>+    gsize len;
>+    bool found;
>+
>+    contents =3D s390_bios_load(&len);
>+    found =3D memmem(contents, len, needle, strlen(needle)) !=3D NULL;

MinGW-w64 has no `memmem`, so this patch unfortunately breaks the MSYS2 bu=
ild with GCC=2E We might need to provide our own implementation like we do =
with other functions: https://lore=2Ekernel=2Eorg/qemu-devel/20260216102951=
=2E150381-2-kkostiuk@redhat=2Ecom/ =2E

Best regards,
Bernhard

>+
>+    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not f=
ound");
>+    return found;
>+}
>+
>+static bool s390_bios_has_net_ccw(void)
>+{
>+    /*
>+     * Assume that netboot support always includes virtio-net-ccw suppor=
t=2E
>+     * Check only that netboot code exists, rather than probing virtio-n=
et-ccw
>+     * support directly=2E
>+     */
>+    return s390_bios_has_string("Network boot starting=2E=2E=2E");
>+}
>+
> static testdef_t s390x_tests[] =3D {
>-    { "s390-ccw-virtio", "virtio-net-ccw" },
>+    { "s390-ccw-virtio", "virtio-net-ccw",
>+      =2Eboot_dev_support =3D s390_bios_has_net_ccw },
>     { NULL },
> };
>=20
>@@ -90,6 +163,11 @@ static void test_pxe_ipv4(gconstpointer data)
> {
>     const testdef_t *test =3D data;
>=20
>+    if (test->boot_dev_support && !test->boot_dev_support()) {
>+        g_test_skip("The bios does not support booting this device");
>+        return;
>+    }
>+
>     test_pxe_one(test, false);
> }
>=20
>@@ -97,6 +175,11 @@ static void test_pxe_ipv6(gconstpointer data)
> {
>     const testdef_t *test =3D data;
>=20
>+    if (test->boot_dev_support && !test->boot_dev_support()) {
>+        g_test_skip("The bios does not support booting this device");
>+        return;
>+    }
>+
>     test_pxe_one(test, true);
> }
>=20

