Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48EAC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYO-00073c-TL; Tue, 06 May 2025 10:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVG-0001iO-Nu
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-000289-Sv
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso43120915e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542554; x=1747147354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SqPsRilVNteNXwBemBSBWzj+hYoVzuHn388bnHoTVPQ=;
 b=Sh636d58Iwf+chip0/vWRDdhq3FWyog0A6SmFvyiuynFtUozXSfKYnO2yHNWLgZICT
 cTN5/sOGmSFSYq6Ly7XERRkWy4t/MecKQJzCM27RztugSdV6mEvA/DnXt4WF4yVo4DOr
 hxoJJ3le4Zb3OTdW8+syQ41WcQCWomqO1SdWgSWYeIJKnpb8aqTOx6bqSHLFl+XtJOfO
 g7srmg6Uk5vt3HfxRK+KXrmFOnCv0sNiie6c+b9d64DSPa7/bRRQBK0cH2xU6UONFT0h
 FnKrUp05xaj4kiDXfl3l0G3JjRvYwwPKIlq4AnziwbvWEnft3HzuKh5arQkJS0qfeK6R
 9G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542554; x=1747147354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqPsRilVNteNXwBemBSBWzj+hYoVzuHn388bnHoTVPQ=;
 b=ECg2mXXVRCYZ6GNOrTArixH1IhhNFCmFUfOwrD+pJceOOhaIJWP1P4g4xTQGEzwDDG
 nqhw5nDWutp5SEn07v+fqRpB3QYhfv5MOn/fagQmMh53meXh834TEJ1YtUg5wBWngRA6
 pdtOe+Vho2Ja9cfGwyqZXvZ2RKaeVICP7AG8FxDnT7p/46KQxc8LyEhtEhjL1T90vtTu
 nRObMFyUJ24pmxf04SnR32ToFMhdIiju3zRJkrblX32bep+ZmM8SlvIJVrhVzPnv33MW
 iOVtnsnxTvLNFrHfPCJCsQLyGh/FGEZMjcDTnEsmbqwDJPe1XKNWOMZic/QV+IJukfCN
 NMkw==
X-Gm-Message-State: AOJu0YyduwTRIbcG/v6AF3S+UureKhB2MQb372aolxBBZDLAwtd9IpIJ
 faBPSx+h8WF2Fq3fxZT+tbBL53UCuPi06NH5y05GYwkeI7hr5ut6qyYjAAxQjD47jSOI1Sn50CB
 5
X-Gm-Gg: ASbGncvjwylIHaxvOh0TNljk5gi6FIBamJt+BAm4Y6uzwjwn6rlYwhQ8uTLYYGSuNxr
 gHm/kf6H/56JPHrz6t0O3L0QJ10iNxoMMQw4moiM+BlLPP5ujarC1/iWgPT2i3Oc31YMiAqvBww
 WcQ9maI1fRB0kxszUEpR8DiIXwsCM9tiKg5ujjBHLdrahcO8vQ2m7vzFu9gu0gRmMX90JVx9yIT
 8p3U4rM151z56XxW1M/5ZERLi+AYXWibDl9gh2y40iOliwOoDWZw6ovteMiYcjsn0ify1vvC7Lo
 YOBbcopGo8ho4FVDZTXMh1PP1akPTHNcah8HAUn9dJlL0iE=
X-Google-Smtp-Source: AGHT+IFguC+dqk6npzBXSrb9I00qFqHYpgsd6NIf3lqF/Q50SgUNi+a7FwGNM2P79sDRM3Zqn2saCQ==
X-Received: by 2002:a05:600c:5105:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-441d100a80emr30251455e9.26.1746542554054; 
 Tue, 06 May 2025 07:42:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] hw/arm/virt: Remove deprecated virt-2.9 machine
Date: Tue,  6 May 2025 15:41:57 +0100
Message-ID: <20250506144214.1221450-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 13cbd2275ef..1c84297fab9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3620,10 +3620,3 @@ static void virt_machine_2_10_options(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
-
-static void virt_machine_2_9_options(MachineClass *mc)
-{
-    virt_machine_2_10_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-}
-DEFINE_VIRT_MACHINE(2, 9)
-- 
2.43.0


