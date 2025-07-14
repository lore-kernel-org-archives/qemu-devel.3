Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKM-0007mM-TS; Mon, 14 Jul 2025 19:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIR-00036v-Kk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIP-0005pm-3f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxYpO+9d8NYemWvnw8rBAwgNT88syJ5YYAjBvVO7KoE=;
 b=B/SG3HbYtRKOyw6BPSBisFbeN3MCzQB2D/zb0d24cyvfG3Bqzt/t03XaYab+bogFf35D5x
 awjCPLE+1Ar+zFQynMgky4JrOQN82PBKmkp09cfqnrYKAXOU4zfxJ0NEEfdZyBP3MRvDzs
 +LwQkR54BuJsh/t5iGISw6e1c9WcYcU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-l-BLSmhrOiGI1OZoFstRPw-1; Mon, 14 Jul 2025 19:09:15 -0400
X-MC-Unique: l-BLSmhrOiGI1OZoFstRPw-1
X-Mimecast-MFC-AGG-ID: l-BLSmhrOiGI1OZoFstRPw_1752534554
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561dbbcc7eso4646985e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534553; x=1753139353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxYpO+9d8NYemWvnw8rBAwgNT88syJ5YYAjBvVO7KoE=;
 b=vUBibsRkK++KDJ9uLyobNO4ojn5teZnqIqoCqzXCrAwhORGX61vynYkgrsskgP3G5F
 U51ktgiXlyCv+1urGFkbABvujrPQjF0e9iwH35JcwAMb9D1U9miD+fG6ko1ow7YJqJkj
 mNbOz8BVzv102DwUBD5Ih397dKVST7uKNAB3xZvlvHAH+ysyHWq+EImEnLMZ5vY7Zved
 gpURI8ZUCrV0QFPk7+iJQg2NJcoCNcLJBtw1qLlL/GVnlljVNjllZmtT1Z1CiO14uPWj
 ru4njWEQE+bCkgKlRKX3VUS6C2/7VRsXREOcsdzWopUZ2NocbYj++1CeyAkyetHrYeWi
 PeEA==
X-Gm-Message-State: AOJu0YztNWUjly64B2nE9nb8dCHpHnK/6p9pVPZj+FM+mCbQqB3tAnR1
 jjN9Kq4f1GsafWjqMnbTRTKJgXP6Q6apDQTODYtinEzBbjd3QrA24S/TlNd83eI657iwvzcAoxE
 ZpHAd4ZcNPJvd8rxfQq0HB2n23ahv6rIcZuJGSKIkg+6Ys29+Oin+KITbS7XgRS3qKVsyM0w1Ju
 jrmzt++vc4/YUlNk+PK8wYufScsAsmlb8mKQ==
X-Gm-Gg: ASbGncvWWhSKwm9eu25NwyGA7vbWgLr4xQivb9kuelWXKUURqVvCnH+6GM3Q/cUSSEA
 9bwu0glhdJcuRM6mEePlFO5WB1TDt9kqddj3HR4RVCQ3A+Aqld0Qs3LOxyIKaMWXe8c7o6lzWGJ
 iy00TBMhLRT1b81+jejghPiL0oHT85ugwQTAeAmMlcTLchOqgW5zzZ2c40mJZoOSlIDFeLbP/Gu
 RYuWOc2mdXaruYYcuH3rVQ4d9xRZQA3qrDZ0TO6aLhxgVvnN4HAuk82sSRmoAtiffNAih7mC6m1
 m/AXGGphtGgl8DaEjQEF9Fy0vgr+OFFl
X-Received: by 2002:a05:600c:6748:b0:456:11cb:b9c7 with SMTP id
 5b1f17b1804b1-45611cbbb91mr61929445e9.25.1752534553473; 
 Mon, 14 Jul 2025 16:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlsxKttcUxs4SQflWwpEy8Exp5FM5PqGA/NTSZxu9E3zh9nU+jZxrXQXYHQh5snj/BuwSzrQ==
X-Received: by 2002:a05:600c:6748:b0:456:11cb:b9c7 with SMTP id
 5b1f17b1804b1-45611cbbb91mr61929295e9.25.1752534553056; 
 Mon, 14 Jul 2025 16:09:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b600a39281sm5851601f8f.73.2025.07.14.16.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:12 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 68/97] tests/qtest/bios-tables-test: Update ARM DSDT reference
 blobs
Message-ID: <4e9b11c0057a0b8494f53eb56d9503f80f1c8b92.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

    Changes relate to the introduction of pieces related to
    acpi-index static support along with root ports with no hotplug.

+
+    Scope (\_SB.PCI0)
+    {
+        Method (EDSM, 5, Serialized)
+        {
+            If ((Arg2 == Zero))
+            {
+                Local0 = Buffer (One)
+                    {
+                         0x00                                             // .
+                    }
+                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    Return (Local0)
+                }
+
+                If ((Arg1 < 0x02))
+                {
+                    Return (Local0)
+                }
+
+                Local0 [Zero] = 0x81
+                Return (Local0)
+            }
+
+            If ((Arg2 == 0x07))
+            {
+                Local0 = Package (0x02)
+                    {
+                        Zero,
+                        ""
+                    }
+                Local1 = DerefOf (Arg4 [Zero])
+                Local0 [Zero] = Local1
+                Return (Local0)
+            }
+        }
+
+        Device (S00)
+        {
+            Name (_ADR, Zero)  // _ADR: Address
+        }
+
+        Device (S08)
+        {
+            Name (_ADR, 0x00010000)  // _ADR: Address
+        }
+
+        Device (S10)
+        {
+            Name (_ADR, 0x00020000)  // _ADR: Address
+        }
+    }
 }

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-23-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5158 -> 5293 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5244 -> 5379 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6519 -> 6654 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7603 -> 7768 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5360 -> 5495 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5158 -> 5310 bytes
 7 files changed, 6 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 023fbc6059..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index acab6e65febbc210158d4c39be0680bbb90250f5..18d97e8f22979411a528705c0e314acb424bbfa5 100644
GIT binary patch
delta 156
zcmZ3cu~w7ICD<iotq21H)2oeKG9vW?ZX7Xs@xe~<0nVNVBHpa7F2TOM3(O{GF%$?g
zGcqJBkeW0(Lr|DY;DY(dr@^LGz7xe?`AQyk_Fa;&fPHEv7t@l20<Ol61O|pB2@7N<
zXK}F?2(dCT@G>M6G<W1MFeDZvLL{S`xPuK0;yL0SU4j^*oA`qbEaExhIUHSrco-NM
F82~q;ELZ>l

delta 19
acmZ3hxlDu0CD<iIO@x7g>C8qh84&<B2?Wsq

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e..2cef095bcc1bb404f8cd9ec77a879ed81c191875 100644
GIT binary patch
delta 156
zcmeyP(X7Sg66_MfEXu&Zv}_|+kx0FO8%K;@e6Uk|fU~E8h&QXNORz8R0<+0k3<ZMB
zj0_12q$W+y5ESMTxL|(rX|QRP??mxezLJNXeU~IGV4s@F#k3@$fUB`1fq`L3!UCDe
zSzPP|Laa;-ybK8i%^f)m42cDa5XtB!?qCChc#e2Smmr4dCjMXpi+GNB4o8<D9tH+R
F1_1j$EA9XQ

delta 19
acmZqH`lG?+66_LEBf`MI)VYzXNCW^oYz1ck

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 4330bc97cba0950191c45ac833533db7a190db81..372ca3d7fb1e2927c7c12f97eec406d597f294ab 100644
GIT binary patch
delta 156
zcmexv^v{^fCD<k8pCkhV6Zb~0T*-O?H;x#+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
z85t55NKKlYAt=lxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YM9F8tQJPZts
F3;>E4EZYD8

delta 19
acmexo{N0GlCD<jTT#|u->Fq|YTuA^&WCm0K

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index 7fdbc03e2bf9fb7d35704779253de36e362f0bf9..c2779882494e16920787b8ab7b4cb3c3b70f224b 100644
GIT binary patch
delta 168
zcmdmNeZz*!CD<h-LXLrf$!jCmN?BzA7p@q+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
z85t55NKKl&K}IZRNx}m5shM0%OA-pW8aomg7?va~keQst#a<x9%EZ9SkWkRvk;A}{
uSda*jjBer%HZX|ih<9`eVu)^%2{y2RaCjIP7#YxH`GXCiN_iL<m>2+L6)WZd

delta 19
acmca%v)P)<CD<iovn&Gx)9sC1D`f#g-Uey_

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 969b4f6560d3ae39f5b7e0064b7122905476fce8..ebbeedc1ed30d811315c350f4cb42f8aa265af73 100644
GIT binary patch
delta 156
zcmeyM`CW_4CD<jTT$F)<>HJ2nXCn0iZX7Xs@xe~<0nVNVBHpa7F2TOM3(O{GF%$?g
zGcqJBkeW0(Lr|DY;DY(dr@^LGz7xe?`AQyk_Fa;&fPHEv7t@l20<Ol61O|pB2@7N<
zXK}F?2(dCT@G>M6G<W1MFeDZvLL{S`xPuK0;yL0SU4j^*oA`qbEaExhIUHSrco-NM
F8359@EocA$

delta 19
acmeya^+A)%CD<k8g9rly)25AF&qM%8i3Z^S

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index acab6e65febbc210158d4c39be0680bbb90250f5..b897d667971500da4732000091a6f0828d05d89e 100644
GIT binary patch
delta 173
zcmZ3cu}_oBCD<iop9lj3Q_n^&8IgJccg`5S_+Y2_0B27F5pPykmtbGs1!j}87zzZL
z85t55NKKlYAt=lxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YMl8!DxJPZts
OU=c&8G!Fv<69WJ)j4yfs

delta 19
acmdm|xlDu0CD<iIO@x7g>C8qh84&<COa$Tp

-- 
MST


