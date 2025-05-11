Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49F9C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1Cu-0003qr-Cj; Sun, 11 May 2025 03:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cm-0003qI-OE
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Ck-0003dQ-PN
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2301ac32320so2688595ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948872; x=1747553672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tehf3Prbg0TksYvm50tY46dn2FMNC2HGfcsLRGzfJ3k=;
 b=F+9ZmCq55Q1s3yUttDAPJZj2oaUcHnvA/nZaZ3skBjbuIOV4zKv38naJ4vn8Bwqy51
 36i3FDSEqjMkChEZk1rb7Xn+TcjSv0xM6HY6TSk3JSt8u+lQgiX1fDnZf+8j8gVQTVEm
 d5FyhU2rmR/9xEcQos1FZnnymZHPal5KKMGAhrHXHMAVFCtYJd3L508bOjZGCQbB/Ujg
 J1Qwrxgu+m/4ibmJDqV1Kl4ZsHQk4Ix7jMQ/YjTWvbmlFvmCaB3ZVUd+yYsoGoXfqH3z
 F2u6SQo5x4BZpolVlqcVCR42DErK445z4P28LpGUyAC3+ibgR98YMXYKifeox1nfX99v
 u9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948872; x=1747553672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tehf3Prbg0TksYvm50tY46dn2FMNC2HGfcsLRGzfJ3k=;
 b=ot4bnyuP/6qaDdItaW+RDK/JSeItx6k+J5TUDUy2RasCiyfXpcDtXFeBjTeAYLyrj9
 yGc5REKeWB1bb7ATyifl8Ld0rSCf0wEWaycKsAC1CL2Tm3a5cYgagaFKMTEEQ28KF7j5
 Ao9WOCHmfmSlBxu4ky+2gpDpBhI/L0oozJ6n9WP8v/0Hn36Aiqz5AER81p2BSh0TMJzH
 bchR9YKWoEfWFATXVI7dCItxwwQgurbaFmzGn0DjR0ygBcMXDlp0cUAsb42jbhjQmmpI
 359Rl0X9YFjaTqVegGOnvy07dRwPWAD5PtAjxZc/a00WcEsKCpCsLB7bSpJIMbyVYpFy
 +sng==
X-Gm-Message-State: AOJu0YzoMsnOZlhS2ef04ElY7rK9pjm/gVRs250WIH4muvoDxz3z8MPH
 e+y0VSamcd1goOg4n+mx2DHun5djGwi9GkuOhCz6fFGh24DiR5pF7M60mcwi
X-Gm-Gg: ASbGnctmEUrMd8kjrMiwDhxVKpQ2BmX3ul0rCcXecTrdJyMNfNKLTqWk1KYaMkFJODH
 vhyNPpxLWxGaohFEOQTeHIBw5580wHPeXpGlkCMv3O5Eptg1N5Eoat/djyx4w2B8l+6JjpUCdhz
 COqQVSopXslbt+fy1hXRGCmH78fcX72ZQYCHsXSC61x4OQ/Ush/9abXQKy3/sAfs8YfL3gXgTeM
 lOiq1P/GNJXEsNyJKWItZv3hFOP8wWF9zHqQ97kiQKWbY7T3QEXkasKlIniIhttTN1NuhipHP+C
 OPHdoh3eDtQSv1axBwKYy1tJJwd3Y9oND0oyDynIcGK8acwDF/vHANpK6B+2msnYwg==
X-Google-Smtp-Source: AGHT+IFrvDXk+8KWZktGgE8KEphuCRdXEOh2Gt7PxSSQmRbgXOwx6lfHRPn2zJkvzqbBSAztm5OeYQ==
X-Received: by 2002:a17:902:ea0c:b0:22e:17ac:9dd8 with SMTP id
 d9443c01a7336-22fc8c7d71emr122083485ad.29.1746948871760; 
 Sun, 11 May 2025 00:34:31 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82c0210sm42065105ad.253.2025.05.11.00.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:31 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 1/9] ui/gtk: Document scale and coordinate handling
Date: Sun, 11 May 2025 15:33:11 +0800
Message-ID: <20250511073337.876650-2-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x633.google.com
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

The existence of multiple scaling factors forces us to deal with various
coordinate systems and this would be confusing. It would be beneficial
to define the concepts clearly and use consistent representation for
variables in different coordinates.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 982037b2c0..9f3171abc5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -800,6 +800,71 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+/**
+ * DOC: Coordinate handling.
+ *
+ * We are coping with sizes and positions in various coordinates and the
+ * handling of these coordinates is somewhat confusing. It would benefit us
+ * all if we define these coordinates explicitly and clearly. Besides, it's
+ * also helpful to follow the same naming convention for variables
+ * representing values in different coordinates.
+ *
+ * I. Definitions
+ *
+ * - (guest) buffer coordinate: this is the coordinates that the guest will
+ *   see. The x/y offsets and width/height specified in commands sent by
+ *   guest is basically in buffer coordinate.
+ *
+ * - (host) pixel coordinate: this is the coordinate in pixel level on the
+ *   host destop. A window/widget of width 300 in pixel coordinate means it
+ *   occupies 300 pixels horizontally.
+ *
+ * - (host) logical window coordinate: the existence of global scaling
+ *   factor in desktop level makes this kind of coordinate play a role. It
+ *   always holds that (logical window size) * (global scale factor) =
+ *   (pixel size).
+ *
+ * - global scale factor: this is specified in desktop level and is
+ *   typically invariant during the life cycle of the process. Users with
+ *   high-DPI monitors might set this scale, for example, to 2, in order to
+ *   make the UI look larger.
+ *
+ * - zooming scale: this can be freely controlled by the QEMU user to zoom
+ *   in/out the guest content.
+ *
+ * II. Representation
+ *
+ * We'd like to use consistent representation for variables in different
+ * coordinates:
+ * - buffer coordinate: prefix fb
+ * - pixel coordinate: prefix p
+ * - logical window coordinate: prefix w
+ *
+ * For scales:
+ * - global scale factor: prefix gs
+ * - zooming scale: prefix scale/s
+ *
+ * Example: fbw, pw, ww for width in different coordinates
+ *
+ * III. Equation
+ *
+ * - fbw * gs * scale_x = pw
+ * - pw = gs * ww
+ *
+ * Consequently we have
+ *
+ * - fbw * scale_x = ww
+ *
+ * Example: assuming we are running QEMU on a 3840x2160 screen and have set
+ * global scaling factor to 2, if the guest buffer size is 1920x1080 and the
+ * zooming scale is 0.5, then we have:
+ * - fbw = 1920, fbh = 1080
+ * - pw  = 1920, ph  = 1080
+ * - ww  = 960,  wh  = 540
+ * A bonus of this configuration is that we can achieve pixel to pixel
+ * presentation of the guest content.
+ */
+
 static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
-- 
2.49.0


