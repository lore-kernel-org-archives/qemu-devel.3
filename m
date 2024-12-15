Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52D6E77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0u-0005nx-TU; Sun, 15 Dec 2024 14:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu05-0003kG-Tj
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:58 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu04-0001Xk-4Y
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:57 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e3167b90dso1563542a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289795; x=1734894595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOXuwhe/X8DCCmXnKuLNeVCJhg3yybg+mdVjtiSSZ20=;
 b=VGad1h+dJKsOKRsB8fI+WwPnUvuj9Wjc4+E78udJ3fdZpP+uF9KBbjryKCmOOhCNkI
 zIlm/JUsYueET2SivulLQhanfVhKojPqpioGaH0a49C6B2XClgE0U7X23yyKI52uhTN4
 5WGUHnDShBO2U7tNruqno5OhmK623ycC8RA5Znlry1LWgCoiHRZq/DpGL88CwT81ibcH
 aM5SptBx8FrBdQmM6BeSbj0NxN9Ex/pUW/S7btytPYq62juQwAk0jjeAQqLMzSw1/Nyc
 gPEagQwy7A+8+MdMdQ9eYbfqVeFNLCQbD/WpNvFHWl+53twdapNJB9J+Yt62+83Jdrni
 WKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289795; x=1734894595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOXuwhe/X8DCCmXnKuLNeVCJhg3yybg+mdVjtiSSZ20=;
 b=bFFQ+qK2qFQzhCc1XFht0UcOfzZEMQBQoFQI21CMCb1xbdRqgI8trKS4Ajer+0joTz
 wJT0t8tohO1TEtCI733Bmlz0EhNoOA+SHyBvgCIyeQTsTwp2dXu4qbxIPjX5ThhKNEZ8
 poMUpjy/vx57BlhXRxeIuRNkm2dpoqUp+4c3isEndcBlf50kCSL5UOMpybtksOH94C/Q
 aGuDGLI1IMwcm4kZ6DoeYDuS96XBRUWdLRvAgQbMxG/gz7BrQjHLTs5K/ygqdYPMdgQV
 4ueD91ZCZVGnhsbn3BFqwQkeua24BP5YktvMBi4Ta95eDozkjA6pua0qi1E+4pZXIpAB
 OEVA==
X-Gm-Message-State: AOJu0YytDLtzFl6+7x9eUhk7LKo85De4lusmk6VFzZaocinakFMZwrCQ
 dTKnCSF701gUU0oFlzUkTKCZpul3nN3KM81yOnjLXfRAuy2tGJd+oWv6IcWJ6cIYL7voV+bKUgz
 DBCuQ04yp
X-Gm-Gg: ASbGncucL3SeuyT0M6UwYQyleZe3W/OfXJoyGgBFR7maUeUb3cHWbfzp5+nJvWegwQ9
 4vQkvOUe5CY4wBPnuWwR9iohHhGJlIsCdj20D9CgeLZ2hLteC2bKopsIKjXxgbx/7hevm5aGXsj
 uioAPWn6YCqJ/R7Xy5G1Wlu/JMNvu2F9sCL2N6Z8ircNQ5f7+V5LimzBlTNm78xz3IHDWdtuyf1
 W/CtRtijfIuPRetyuPGDLwun+cPnUXYBkjMrmYqeYKHTx2IuaGvhFx4mG3XPTIf+HwHyL1n6Uhr
 wSTddvCcidVrzORHcuW3Rm8uNoW5/wA7rMfbrCSPtRY=
X-Google-Smtp-Source: AGHT+IF7Fl/jQR6xzULO6oy1vTXDK7+Ci209V2VDyI67xIbOeYNtn+lRLuJ27BHTDoc4UcHzcTworQ==
X-Received: by 2002:a05:6830:6c17:b0:71d:6221:d4b7 with SMTP id
 46e09a7af769-71e3ba628b2mr5847366a34.28.1734289794799; 
 Sun, 15 Dec 2024 11:09:54 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 60/67] hw/ufs: Constify all Property
Date: Sun, 15 Dec 2024 13:05:26 -0600
Message-ID: <20241215190533.3222854-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ufs/lu.c  | 2 +-
 hw/ufs/ufs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 81bfff9b4e..74ff52ad09 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -274,7 +274,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     return UFS_REQUEST_NO_COMPLETE;
 }
 
-static Property ufs_lu_props[] = {
+static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 79f786ed4e..fe77158439 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1752,7 +1752,7 @@ static void ufs_exit(PCIDevice *pci_dev)
     }
 }
 
-static Property ufs_props[] = {
+static const Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
-- 
2.43.0


