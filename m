Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5D3CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9t-0000hw-8q; Sat, 09 May 2026 01:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9r-0000hQ-Lm
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9q-0007Mb-6O
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPqRifcNBcx2spNpK0C/rcHXsgRllLbXT2mzGwKdmyM=;
 b=iycDgZFFXGMe+27Y9+LpVoEH5NHyfQWxLUy73wva8dPRWkGYjruBf5tMQw/ngbJsbkCizp
 Xm8482CXMykieYJGys0NWw0au5TycZR10gYEB0WBaZm0IyXygZ2CKskPPN9h5uk+MkumXu
 FuGKVdXg9F4j/nDZTy2mEMY2BkhRvw0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-cvBouv0jNSm999H8zbPfvg-1; Sat, 09 May 2026 01:23:18 -0400
X-MC-Unique: cvBouv0jNSm999H8zbPfvg-1
X-Mimecast-MFC-AGG-ID: cvBouv0jNSm999H8zbPfvg_1778304196
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44f56d5523eso2210987f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304195; x=1778908995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPqRifcNBcx2spNpK0C/rcHXsgRllLbXT2mzGwKdmyM=;
 b=atzMxLQz8+hPj8ZZBSxEbjdtM2BZu3nSkFZsdjujLOIexNMs2xg7HkqWTmD8AyYIHD
 RUZHnR1wKNb1Yr+2SGV7khueKru++zdHPnCCTtFjFrDUF1PLStkkGoPaUraZ992qxn6Q
 qrHyEvg1dby/xetytlUIsPcVLR2+kbY/TKvCzNQZoUJLLwJdwrM3y/yP7pItQX4x3Tno
 3YuZXQ3gD8pqsV6G8Wdy4ypoQVePN7UwmZ7kQuYvtlguRGgaykdxCfRVAb3sAHExvXDQ
 HI8WBSUv1EGOlPHu+MFW08l5+4n8na1w1DRznRCPtUGVDVsogJdeAg+AMcBUAnYr3bhy
 rDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304195; x=1778908995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPqRifcNBcx2spNpK0C/rcHXsgRllLbXT2mzGwKdmyM=;
 b=m8sbOrAqNVdgt6MNPuNWXEfg34/lYffPVPlME1teNDh2zv0S+LVvF4Rsns3dmnAlk0
 EwkgE88aqvxtDGLT+KLHqAFmBXKTWxH05gQQ+9S5MWbegICWUfmQN9kDYLUcpviRw9fb
 +Tr8QSd12l+e72AcocHBR+7/ec3ZFZQM+JsFvsPhaoywfogtI+fQwX+aSMC4K1kLa9GF
 lWghWEF4QwdTk6ijiO6DAlO8DSOG12J0m0TC8TtU3TijXzXfzWIBgW4ly/0oT7DrCSd4
 95Ek2SdDm3jPcXBJfW0bfT2bu1vBlzF82GtNyrc5d08//27NhEwLnfZvwcInblBGVf4/
 pLDw==
X-Gm-Message-State: AOJu0YwNcUnuGheK5WNa1RrRPCRvxJ8wtsqxVer7PsNFcvSAgUOPYizQ
 Gz98KOoScalObkAGSUeDohwz9MLUFWonSRpro0FKq0bMVcqfVRRfnGH0wapNjWd+PIC3vDe94A8
 yckN6Na2bTajJiQ3KbrZkNuQtU2kG0/a/l5xsspZUykHW1Pi/sUVueGsosw194HFb7oZQXiI4ek
 F9sSwBX8x/IHNKuhGL8F2Rv5gJT17xk3LK8fpQAZkg
X-Gm-Gg: Acq92OFE4SJe7ge2yR0s2e8UkFUY+S/64lfkI4rwbMw+nb6MaYOOYvbpSj9kgEXeozy
 WH39XDZa/rTvcd4czh3TAEjqlrovqQYgnB2omPy/8dD1LFKN1LMsJBSN6KS2Th1dTkQgT33RLDB
 E+6w7xM8ElhLsZFpPrAdmXOFhNTrshXK55+nJxGY+0vnTtCzMKNa3YCUWvA90TdNhNSic2HZP17
 QrylQalJguzBoofuETjWg+sx6MlxGfFls6Mbyl92PCt3BVCNeZ8JheVLkktkNbwt34BSkrvvrOp
 w237HwQFq06HiV1Y2M2GhHrNPLBFmYpxpUpHy8Ki2qL67skEyWmXe+hCDlbNMc2TUKNu6IJhHMI
 QuLYVHKlUmTi/tTVnWtLinKK6csmb/ukoIkhZvGnIDBeNOqYzbKnTkmgFDvFiuuBVmSqvLJNRno
 nSP9peiqREc0xin/ZsgHL07lFGgYDW
X-Received: by 2002:a05:6000:400d:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-4515b0571d2mr22313092f8f.9.1778304195581; 
 Fri, 08 May 2026 22:23:15 -0700 (PDT)
X-Received: by 2002:a05:6000:400d:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-4515b0571d2mr22313062f8f.9.1778304195146; 
 Fri, 08 May 2026 22:23:15 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm9568740f8f.8.2026.05.08.22.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Qing Wang <qinwang@redhat.com>
Subject: [PULL 3/5] scsi: always send valid PREEMPT TYPE field
Date: Sat,  9 May 2026 07:23:02 +0200
Message-ID: <20260509052304.2159829-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The SPC-6 specification says that the PREEMPT service action ignores the
TYPE field when there is no reservation. However, the LIO Linux iSCSI
target rejects commands with a zero TYPE field. The field never ends up
being used in this case, so replace it with a "valid" value to work
around the issue.

Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://redhat.atlassian.net/browse/RHEL-155807
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-3-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/constants.h | 10 ++++++++++
 hw/scsi/scsi-generic.c   | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index cb97bdb6362..717e470a5d4 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -340,4 +340,14 @@
 #define PRO_REGISTER_AND_MOVE                   0x07
 #define PRO_REPLACE_LOST_RESERVATION            0x08
 
+/*
+ * Persistent reservation types
+ */
+#define PR_TYPE_WRITE_EXCLUSIVE             0x1
+#define PR_TYPE_EXCLUSIVE_ACCESS            0x3
+#define PR_TYPE_WRITE_EXCLUSIVE_REG_ONLY    0x5
+#define PR_TYPE_EXCLUSIVE_ACCESS_REG_ONLY   0x6
+#define PR_TYPE_WRITE_EXCLUSIVE_ALL_REGS    0x7
+#define PR_TYPE_EXCLUSIVE_ACCESS_ALL_REGS   0x8
+
 #endif
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d0086d86d94..f1c328e6da6 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -453,6 +453,16 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     uint64_t key_be = cpu_to_be64(key);
     int ret;
 
+    /*
+     * The LIO iSCSI target in Linux up to at least version 7.0 rejects PREEMPT
+     * commands with a zero TYPE field although the SPC-6 specification says
+     * the field should be ignored when there is no persistent reservation.
+     * Work around this by choosing an arbitrary valid PR type value.
+     */
+    if (resv_type == 0) {
+        resv_type = PR_TYPE_WRITE_EXCLUSIVE;
+    }
+
     cmd[0] = PERSISTENT_RESERVE_OUT;
     cmd[1] = PRO_PREEMPT;
     cmd[2] = resv_type & 0xf;
-- 
2.54.0


