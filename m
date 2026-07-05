Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwJ-0005Kx-9g; Sun, 05 Jul 2026 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwH-0005Gk-3V
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwE-0001Lg-SF
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AFaImrZTdS330B1dghG/ZI1aly2aYdlzdVTbq7XpGDQ=;
 b=LIAZUkOJ6JScwQqxI78khFp1xFFbLsBz7wFfrwIEsSOGTooGBzqRCJnvUconTCyCwMVNvH
 Y5GV1KhjEL+ukIRBtRPPHPTmbQU8miMSk4346PNXo/GaYfG8Rwe0BDOzpF4nBxv0NtXh1o
 vO4Pr4om32FSsKxV0fSmpWunH5jHCKU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-jJt0hgn1OwefQTv7HIAVug-1; Sun, 05 Jul 2026 10:35:16 -0400
X-MC-Unique: jJt0hgn1OwefQTv7HIAVug-1
X-Mimecast-MFC-AGG-ID: jJt0hgn1OwefQTv7HIAVug_1783262116
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47407691804so1596124f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262115; x=1783866915; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AFaImrZTdS330B1dghG/ZI1aly2aYdlzdVTbq7XpGDQ=;
 b=H9ah0CXGOOG4AiipeaRB6LhCG42AnriIwMWh/a6hGlpPQXdURJLVJ3wEbRZgTp1HBw
 ML8pM2TE3N7pfTM0yflTCsjRcAcB453Epo3y1Gmyygfnh1QWNyWBq4LAFsO6ltXaRLfS
 sMCZVcgRi0hyJGYlzBVDx8tc7JgYOS9QXYxd0SORaOJGEITlB46rbwYiEBWqFuNUi4Wl
 vZo8zmFTMJi1tKbU6yRFup+yMzNG0zI6H77RilV2kWASz2coiKUpBL7nBqQusU1heoEr
 5MUfYbumg5E9prt8rd56fjq2xdV7Z6jp6GET8OszbGov7X1Ey4PkoXvnFZFoDwRf3TIm
 f77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262115; x=1783866915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFaImrZTdS330B1dghG/ZI1aly2aYdlzdVTbq7XpGDQ=;
 b=N2BQeJSvNCzA7QWperU2RdFb5mbWnk7+81GE+pKrFTCJ4AFVrjgn5FtUruBBGpO5Ad
 b0TSfMW2/RVRVyIWNdczNjfS1EPB3n+DPYvil79VdlEHZSB9qcRQR60NI/US2rhHPC3J
 SRg6teEZfIucpAjEIQ/2bJU/sLeJlPDwWsprvXVl5CuMrqbeeGQXLaEEe5C4pqp68c67
 +6hy97qhOg4t+5QgDoZnDzrCpZMoIKvkcGvUIq8vrCoxpd/ZdA2WBK43Sm42fZmoPfHT
 DDlwe3U6oCUnBVtzDDpT++oSNFG8vASYCOw+QsaOAoX6EDtgFrAibS83Ndz4j3SEt8lP
 HTng==
X-Gm-Message-State: AOJu0YyhO1owfiLM39fNuQlk2+0Rsrbc1JxYedSMcfiMXjD0z1mi78jG
 IAXrGEzQruJfFVi+v6jtLvCwu3JF/8zeiSc5d539GfajqlZlv99Lu1nLvC8S9olU8JI/y1adu+y
 WWGbquQ/EmDexd0grOlNP4Sinbf1ArFPaC/6agZ8d0b02zXJOolVctAtrsLxOdRmDAKyrLw8BmA
 1d8Zw9a7hfd2wgjJZHHbRSaBrJLiTgs7EUyg==
X-Gm-Gg: AfdE7cncIE73cMSGlTfJwjGCi2bqWGjMNxJSPPhAwnYyyFvSW6J4bGTKE1TV85HZ9i2
 U7i0tIWZ/OEX8FDGVjSTnBVldp01qmoTPOzqYlzOppwBqTrtGXAoUdp9duQnNI6l/KXYmGlqbzH
 8AVh6UH/Megdj+GOR1t0jPTdqSWedGaPs8E9P0KOSmN9gaB6vYGuNMj0f7R0gNl/Orr6x/uvSUG
 EzajwLzaAY/UuzjU2RzxgQoJa2AZYFazjTZpiu9qzT01h5gsFBEJnMgt4Xjj10jNZ9LP60yg0w9
 GBVER5EoHA928hvgA+tu3npAS4RppjFbVMZ4ctbUSOaMnxbiVZunpOYJkW+u8q146BoGnEsBmzD
 ULsRTarF+7qOrcj7BWL2Mdul3wokA1dLm
X-Received: by 2002:a05:6000:2209:b0:46e:8226:96a8 with SMTP id
 ffacd0b85a97d-47aa9b74f8cmr8013075f8f.17.1783262115461; 
 Sun, 05 Jul 2026 07:35:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2209:b0:46e:8226:96a8 with SMTP id
 ffacd0b85a97d-47aa9b74f8cmr8013031f8f.17.1783262114842; 
 Sun, 05 Jul 2026 07:35:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm15976570f8f.14.2026.07.05.07.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:14 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/44] tests/acpi: generate expected blobs for sp-mem SRAT test
Message-ID: <f46bd7b21ed3ae92e6c1820d7987807af67150fa.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Populate the expected ACPI blobs for the sp-mem test and clear the
allowed-diff list.

SRAT memory-affinity entries for the device_memory window (q35,
-m 128M,maxmem=1G, sp0 on node 1 and sp1 on node 2, each 128M):

  Proximity Domain : 1  Base : 0x100000000  Length : 0x08000000  (Enabled)
  Proximity Domain : 2  Base : 0x108000000  Length : 0x08000000  (Enabled)
  Proximity Domain : 2  Base : 0x110000000  Length : 0x128000000 (Hot Pluggable)

Each sp-mem device gets an ENABLED entry at its own proximity domain;
the remaining device_memory window is covered by a HOTPLUGGABLE
placeholder at the highest proximity domain.

(DSDT.spmem differs from the base only by the memory-hotplug AML
enabled by -m,maxmem.)

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-9-FangSheng.Huang@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/x86/q35/DSDT.spmem          | Bin 0 -> 9910 bytes
 tests/data/acpi/x86/q35/SRAT.spmem          | Bin 0 -> 384 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 188003fa90..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/DSDT.spmem",
-"tests/data/acpi/x86/q35/SRAT.spmem",
diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7e6f850e7a25aaa3cb7abc0ff2aeab4ca7fdb716 100644
GIT binary patch
literal 9910
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
QStg1MH&$xKGb$_OuW}xhhyVZp

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..9ecd266eda68d035f72f170cb1346b97da623c28 100644
GIT binary patch
literal 384
zcmWFzatvu;WME+AbMklg2v%^42yj+VP*7lGU|;~TK{N=%fdDF>Q3Eam1za!&iavxo
y0jT^3c9=qB^AYOs1L~_oxB|-JfVlu6!@$6(!2}cLAX1$GR2|#~W|#>K3=9Att_cAE

literal 0
HcmV?d00001

-- 
MST


