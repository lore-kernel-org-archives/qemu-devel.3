Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5043CCFA1E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6WB-0002J4-0l; Sun, 09 Nov 2025 09:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W8-0002Hc-Qq
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W7-0001pS-9W
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/OeTxwvv54dni1NCLrJFSq1zlzTGsf0EcWk/x9CQJt8=;
 b=VN8DUxXgpjQZ1HqX9cE5UooAjjeqY+cG+lLKcGMMyaaEho56PVqz7N8drpVrTguVB6A5IB
 0eSod1sSmu3T4O6o5g6WQZnev5IrJTP95b0NekFnFDSM5bvTIZ3hdIRyzS0TVrnRqE5iBG
 tQvJ/ddUoe2SmAgYC2yKlHvkpXW7ON0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-L20qVr6PMDuBdNFFyfBJnQ-1; Sun, 09 Nov 2025 09:35:41 -0500
X-MC-Unique: L20qVr6PMDuBdNFFyfBJnQ-1
X-Mimecast-MFC-AGG-ID: L20qVr6PMDuBdNFFyfBJnQ_1762698940
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4777b03b90fso1446705e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698940; x=1763303740; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/OeTxwvv54dni1NCLrJFSq1zlzTGsf0EcWk/x9CQJt8=;
 b=CNCX1zDLwK36xsUrc3Tz6Q6JL8lWyNJZuHDrOf87yeMb0b0RdWL/tUjulmY3UGG3fs
 WIiCNbGA6OpkKGdDavDn9OtxxcJ+kZFb9iB6JIzzwMFhMZ40pKKtfMoh+p8KTYM9XEsC
 JcejttzPfUolLeVyxLXSS0Ejfeh5aYpJzYtonSSvN1vGmC4CAlv9p1q+D0BzwIYdtVcH
 PI5DoHDkKfbVvX/pIQ/DTDikSA8gNi3NBcYnQuGUk3wriVF4HNCHUrb5VrKlnF/0FG6F
 heKlC2qk+6M2hR7C35v3F53PmUeJseUxP71o8ahqHW7sytRxJVniKd8SSE9XiHeqPak2
 FU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698940; x=1763303740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OeTxwvv54dni1NCLrJFSq1zlzTGsf0EcWk/x9CQJt8=;
 b=lItbMefxE8LdShei/eYK80OyhTtaIYqWAmPg/DYbOC3T6jNLOizE0lHrMfnEdM6Oaw
 D/5i2MOIsMjIQ0lW8/b9zePSvzf4GpkZrh7IXB/JDdYJDbswWiiRfT2acSD1VvMVHH4w
 QR/dAg5exZRowcQF0XcRCh/MZ23V3VfaxeDcKuUF4U6Ckci9+ULjKj2aYvF/TR57x+ay
 eLYk/oTQkOqwvoDLzdtzbQvMDn2DnaTdwN1vFKfVg3aL/MLdm5YVtW/BsY6j5RvFdpwg
 Ly87tQFG4+mk6uU2m7Gl4GFI7Kzl++V2XBucBBF5oliNi/D4OpUeqjMkShiOSBTGCd+i
 sSmw==
X-Gm-Message-State: AOJu0YxrmKt40t0V4zp9rBqTlD8plCllEw5/LyI7zRzTU4hWdygcX0Bl
 Gi5mtFAmQUrLQOikbek+ZMigM/DD9ZntmUC1nfpP2EokLya54t9j7g+11vdC0QLtk/l/rsPCxix
 YDM70fGTY7QNcc1X6gKeE/boYdCBp+VI6709CSBzd3s6GoR5KABsTEeTj4scKsZblZGB6rbxVf0
 kjAnsMUUD0LBnett1YXm1OuJhlHV+ybdSRkg==
X-Gm-Gg: ASbGncv1Nv9+HYAeijOkFgEAOhlHdXikFbpXgYcJ1Z4j+cCGSCuk3hpI/iEFEvIQga7
 AnIuxp2/podq2yzlYT5sd5PBuHx84hFYaug/h9DQtoGLwFfWwEa0IZqS5JFrbmQchDGIv2T4BTn
 mM9PswQxgXCLWSXqHoTMaBST+D7yZhy+yljqwL/q9DdvOO02qv6R0riKTDURPlY3cPdRVbhGVXk
 jTsFcx/zq/0YttPvc4bQiL7dsp9An7gbHtpsI5A3Q23a9emxlosDCM6V2d+Uh9uh5ql9hNB16ZF
 2BghawQ7cvsQU5+nzr/IrEQ4LdSZJJ0XB6mu0M4U6B5WSYzJjMosLU96UQQcySyefrw=
X-Received: by 2002:a05:600c:3b1f:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-4777329c723mr45271015e9.40.1762698939808; 
 Sun, 09 Nov 2025 06:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkuNGllf4/CT5cAuxcdY8M4gjWAC0Cof73QCIxwvY9xRnGWpVxzq9nZKAh3waEjNSoXnyd3A==
X-Received: by 2002:a05:600c:3b1f:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-4777329c723mr45270775e9.40.1762698939295; 
 Sun, 09 Nov 2025 06:35:39 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47764152a13sm86982255e9.13.2025.11.09.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:38 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 13/14] q35: increase default tseg size
Message-ID: <fa4136387928749d5a1b4fa3606ae0ce6dce75aa.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

With virtual machines becoming larger (more CPUs, more memory) the
memory needed by the SMM code in OVMF to manage page tables and vcpu
state grows too.

Default SMM memory (aka TSEG) size is 16 MB, and this often is not
enough.  Bump it to 64 MB for new machine types.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251106105640.1642109-1-kraxel@redhat.com>
---
 hw/i386/pc.c      | 4 +++-
 hw/pci-host/q35.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4d6bcbb846..f8b919cb6c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_1[] = {};
+GlobalProperty pc_compat_10_1[] = {
+    { "mch", "extended-tseg-mbytes", "16" },
+};
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
 GlobalProperty pc_compat_10_0[] = {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1951ae440c..a708758d36 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -663,7 +663,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
 static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
-                       16),
+                       64),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
 };
 
-- 
MST


