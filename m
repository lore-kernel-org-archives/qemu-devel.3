Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4E3C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUg-0002Xh-Eg; Tue, 18 Aug 2026 13:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUZ-0002Pf-5N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUX-0001oj-Q5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To/MdJW20rS45e8qxJJP7drCgP4oJXG+BP3hCTv3ngQ=;
 b=Xm0euHahUFnCPSs4tWgu2bOkQnXmdSZPi5BRC0wdXw2QRsBfahIL5kRN/Vx1isS51F6ElW
 Q+5+lBI15ygtG4WQuXibzlkXuAmA188Rwdj3mhzLolLPb7PQrVA1qNvVcJD5u6S3tTV4rm
 ZI13Rg7L5qPCGAHsbC2XIoFQuytK2ks=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-Ru0sIR9mPMCSHUX7W1C_AQ-1; Tue, 18 Aug 2026 13:20:41 -0400
X-MC-Unique: Ru0sIR9mPMCSHUX7W1C_AQ-1
X-Mimecast-MFC-AGG-ID: Ru0sIR9mPMCSHUX7W1C_AQ_1787073641
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52dcf1bb6e9so3399731cf.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073641; x=1787678441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=To/MdJW20rS45e8qxJJP7drCgP4oJXG+BP3hCTv3ngQ=;
 b=FsWmX+5GHnQpGg+l18MJlX566vGYWyWjcM7v2nlXJjluGP1+zZlOgYgH1Q/lCVU9e2
 XyQ4+k7R7u/bmRJ1STQUNVBC1LWWrGtx3QIXR+ZfxSa6ffzzEqxFVqWMbLrPkOzx1IA+
 XQMv1i/Vj0MVg0rMajh/3VGqldE3rlh1vOeaih4F9JSSSfgLiEJvBlaPIVVWKg95KC5m
 jv8XsN2nw0E1rHFt2lCV1xzyVMcOsRTmk6YL81OvVQCGB+IohFlzrZR190tfP6tqEfTn
 0qTbr8UAZaQLxz1t0v5o8T/ofoOaXgdE+pZOH9KRz1gw+n1v3A4lyUGDzZUWX7xz071w
 xXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073641; x=1787678441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=To/MdJW20rS45e8qxJJP7drCgP4oJXG+BP3hCTv3ngQ=;
 b=UhVloVdLT31Vf9In5lGk5kj0Ltzpo8scYKTsqml3RIg6WDn53O5zmZ0cBxTndKwlx2
 vTxPvhmZM+5sT80tkNoqjRzK+xwxNS3/lzFZxUJmJ577Rzth0J5+gumym7wNPfc9qDg8
 5w0yepLvB4O2pXNIDuC12ux8eND9sGikU6QOIc+jI0ifCw4XBvAeYVq2F8sx4O1d4wCX
 5soXfKVQ++glZm9YLJCtBlii60rQR+y+h7c342qIaWcKQ2xB1sB3Nc0mr6PT2pQqkQF+
 3RcHpWSWkmbj7PPc8ixuuay86SBazOoFrbTMQyCvMFezRqcKkpsQx3mjwD55By9XKZmn
 91sA==
X-Gm-Message-State: AOJu0YxyyzRdhPVQ3Gf3f79/3b4rn7avCiAA7p2lXfVBC/iF+co384hU
 n2d0WwpGtUI5HJeDt40XPtYSNRj3beSabg+rOEIxVWMjTIT7Fa3iNJyUtOlCDuJendZdhW5fV2+
 KXeFXhgJkN+m9jl70/38TQSXL7IThdQllxpXR5+2iZVpPE1d5UEJdykG51cx0C30FLFqv8M1LKz
 olj4Gzo/hQ5Y5Ko9gF2QNczWCAcdb563fk0RF8+g==
X-Gm-Gg: AR+sD1025mALBrLWTxASqrNIhH1fR69jcUdfcrLYay8s0/IAl1bLwT3PxRK2W1zf+Kb
 VxYIH44VR0DaOFIHMW/lN8g3KFcjBEF3taXo0humOvj+w/BX+Nkb6JfH++AuQUszqnn8ZauBGgq
 2D/PmlalmR2COS/0+TKyoUZdVmbcbwaWfqh1S9kiTVwl3wxaaGrPhXHTaCZkdmkiOTDE5jZZ4UU
 FMGJo7avhWIM85tC0dMBDVVBxa2c5p064XchQZx3pTzPT9CSXiUaw1EfHW7AhZFsGnSae1Jrh/y
 oZ8O7nTTV4b8DJouCf3cShEMY2NNwinuxWGoFCWDux2miIpEwD8cKRMNF6iLAN7LfBNP1FzwskP
 CAjAGSJohnr2fXemki1QJH3TvUvDR13aSdHf3AaZgmCzHy1E4kOSNEGL8
X-Received: by 2002:a05:6214:459c:b0:907:be64:6b76 with SMTP id
 6a1803df08f44-90c4cef5967mr107649906d6.12.1787073641103; 
 Tue, 18 Aug 2026 10:20:41 -0700 (PDT)
X-Received: by 2002:a05:6214:459c:b0:907:be64:6b76 with SMTP id
 6a1803df08f44-90c4cef5967mr107648706d6.12.1787073640468; 
 Tue, 18 Aug 2026 10:20:40 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 9/9] machine: Remove 32bit limitation on ram size
Date: Tue, 18 Aug 2026 13:20:12 -0400
Message-ID: <20260818172012.3052821-10-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU has switched to 64bit-only hosts for all system/user emulations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e617f7804d..776df84191 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1625,14 +1625,6 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
        clock values from the log. */
     replay_checkpoint(CHECKPOINT_INIT);
 
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (machine->ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
-            error_setg(errp, "at most 2047 MB RAM can be simulated");
-            return;
-        }
-    }
-
     if (machine->memdev) {
         ram_addr_t backend_size = object_property_get_uint(OBJECT(machine->memdev),
                                                            "size",  &error_abort);
-- 
2.54.0


