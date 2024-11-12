Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBFAD42BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuJT-0004NJ-SE; Tue, 12 Nov 2024 12:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHk-0003L6-J8; Tue, 12 Nov 2024 12:02:48 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHj-0001Vf-4Q; Tue, 12 Nov 2024 12:02:36 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so4275040a12.3; 
 Tue, 12 Nov 2024 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430952; x=1732035752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcTg55TVLZf6OfSuBaidjAn4zuepTjhmMHoIrKI/Xb4=;
 b=Fb4xriYcGpyCCSmMags/421Dozpn2UaIw2I8jNA80R2zIzPZKQ+CZo2rrBrcHbfx8L
 RnCVHmwytguLQPEPvV3PXIcFA87+0qyaa5z7sgwkGZ9XbZ+eKk3VpbCyP2hKp7jvPNgb
 OOiHFt5u1PgdykNneAwdQhosjREleGexg+Tdcr+ySCsLsfEOBlDg+AXsdAX2Hxg5HhC6
 JRbhjGSSVviowakAp5p3P+EQCgvJH3p3BKy+0rcduiVwlZGf2fgMKyNRzdpdN9PiJJlF
 D5FPELENmuIXUOvbuczOeNGzKkveqs+R/NGJgM4S/hfyJhdyYfxL496PnzZOzfx50AuL
 Skpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430952; x=1732035752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fcTg55TVLZf6OfSuBaidjAn4zuepTjhmMHoIrKI/Xb4=;
 b=MVX8Iav1VdWS0DmvB2tWwFd7Cu2BkGEvNcsSd+xSlGtnGwQbDjGeBytH9WU72EMqz9
 ri34nCq2QVDlkPTLzKi4Nr+y2u0FxB/EJT1uJeEPFAvJ0tNnpDXeIYf1IZRD0ERgEB/G
 w3ys7/3Gm8X612BIHpoerDBFbQcnjGwI1+S9SclyY4+cys0V4t3Yh4R+80iZFtaOxbz/
 es6xsbYR+fAQYJ7nsfRvpiC04Q2Utl6Ipww64sVDOW20OCBFyD6rlfiXcb65jHDSO1Ho
 H5fn8tEPEzcx1PYXReQaXbAW4iNDeFTj0MQwHWLRSImmN8qns8Mj+gKq86pQIwVJpLRV
 0zBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCLfr0yMt0NbG8oZ8qmTLFiXSWzd2Xyzbt/bqdcdqS6vIQGpUEsyVj6Tz+GrRttMTItqQcNWC3Hg==@nongnu.org
X-Gm-Message-State: AOJu0YyVQMiYHtYFnQ1Nnbao7S1Zj38eJ92trMUpdbAZXK31t6ZnPyr6
 7ej/bWpnegY7FsRHOBKFPyDTX1MG1eg/pEu+ToyHK4+VRXQAcyOVvXgHuw==
X-Google-Smtp-Source: AGHT+IEo0iBRS8PRdHLawG2F8k7ytxnHA6MKmimMdTNLSR/HGwzY1IKpyhxTro1TN3tvLPQvi0i04w==
X-Received: by 2002:a17:90b:4c4c:b0:2e2:cf6d:33fd with SMTP id
 98e67ed59e1d1-2e9b174821bmr22673530a91.31.1731430952418; 
 Tue, 12 Nov 2024 09:02:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5f8f4e2sm12046793a91.26.2024.11.12.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:31 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RESEND PATCH 10/10] usb-hub: Fix handling port power control messages
Date: Tue, 12 Nov 2024 09:01:52 -0800
Message-ID: <20241112170152.217664-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112170152.217664-1-linux@roeck-us.net>
References: <20241112170152.217664-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ClearPortFeature control message fails for PORT_POWER because there
is no break; at the end of the case statement, causing it to fall through
to the failure handler. Add the missing break; to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Change from RFC:
    New patch

 hw/usb/dev-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 4da91d151c..2872c6712a 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -532,6 +532,7 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                     usb_hub_port_clear(port, PORT_STAT_SUSPEND);
                     port->wPortChange = 0;
                 }
+                break;
             default:
                 goto fail;
             }
-- 
2.45.2


