Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CA7E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSD-0006Yn-Pk; Fri, 06 Dec 2024 07:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRP-0005zE-NX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRM-00043V-QG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:15 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-7fd2ff40782so78539a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488090; x=1734092890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6IjMTOhbbtnbKyiu9odYQrXzvjL175+vD8tdZJb7kU=;
 b=gq20P4ik3aaOwfIhD0bWMDiR7Zz5hVfS4KanQyn2vZOg4pJMVtcDmweajgN+gIl9rA
 atn+TmUbrj+AumauDIxIF4zSaD1YGqgbnvsxiGbC2H72zIgBTmb6o2lXpGzMfOCJDlwQ
 fFC77YwtGpfGKzCaAm1NpTqD95IRGikzjVPG3KiEXjMIWJh2z66Ylrn6v8GUEn8nvdGn
 Ou9vHj3ixsXq+umNOyg4pdRSX10FjR5DDqF1L/yuY30RdO5L6sXCTxCc8HL6p0wbbS6O
 bwm2FWisvxksoDPZXzLQ0uzCoVhKMe8DoeRuqYQbdz0xTDrzwgQ7aXu6u/OFwjP2H69b
 GR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488090; x=1734092890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6IjMTOhbbtnbKyiu9odYQrXzvjL175+vD8tdZJb7kU=;
 b=KjxYiBAsGggTsfHA+1lbCVcZ88ZIPBYrhUk3IzEyuRtt2xPDjCRIgUWlVzQcOKl93l
 cbtZlOjhwcC97wfxQKpy46k0fX1ub84OXviB5g1rMyu8thN3IiR8VB1OCkfUjKcVJ2lX
 +ivT0YNZuJw1xrunTCiiYaZXIZme1xzcrAAZEFdDEFUAOcTf6l/bO0NY/WCKKZ3wvXel
 e+SZQxyfqUq6GOQb0Cb7HNgn8ojyAdNmXN4b7VfL4OdygI+NL9sdl4VBNwrZQ1FrdfQQ
 tTk+3hndGVHCrEt+xDSlvMvS4WzXhFg+FthI90L/ZMZerkrKrstRXx7RnAKgbHzF4LOJ
 BWEg==
X-Gm-Message-State: AOJu0Yy0GksFvyzsF3tLLZGddC5XTvrbp1rYEaZAz45jDcwOgqoh1IVD
 hQVQzN/wVbpFOIWwWJNCHtDyM+CmmgaKcdcFSyWiVeeh3ZuOQl4fjaWXlwpzkw==
X-Gm-Gg: ASbGnctp+ZlvhEgLKTCVsUgro7QFD5FLOnz2OmOQ0jASGtqKA2cFrvhJMJbbULDyDA4
 xh9P8MjP5/jQMLil3/8faDEE2t0HM8v8mImNBKdmb/RQzuXwyexwgEehfmk22bSEv70L00/oStI
 SjyqfpmyppiJSheYSuUpRwyT81AzuoM/L361kTgcG5SRqNSxXkceCq+ZmouOroCDbIQB94f+3zz
 RDLlVjJUxnJh3H3ZmYuGuPVOPbsWG7ei457AHifYES2BiseQ/79P3yZ1A==
X-Google-Smtp-Source: AGHT+IHEGMXAG5oagoQTnTA103gm5+sZAl7xZs3LnjkUVjThmPcaRjOp1zyxC0RMDyPTgnX5b1xDkA==
X-Received: by 2002:a05:6a20:7f9a:b0:1e0:dc34:2e7d with SMTP id
 adf61e73a8af0-1e1870aea52mr4908449637.5.1733488090069; 
 Fri, 06 Dec 2024 04:28:10 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:09 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 06/10] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Date: Fri,  6 Dec 2024 20:27:44 +0800
Message-ID: <20241206122749.9893-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
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

All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
config space, add them to the list to support igd passthrough on Alder/
Raptor/Rocket/Ice/Jasper Lake platforms.

Tested legacy mode of igd passthrough works properly on both linux and
windows guests with AlderLake-S GT1 (8086:4680).

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ed236f443a..49b6547776 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -86,9 +86,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
         return 9;
+    case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
+    case 0x4E00:    /* Jasper Lake */
         return 11;
     case 0x9A00:    /* Tiger Lake */
+    case 0x4C00:    /* Rocket Lake */
+    case 0x4600:    /* Alder Lake */
+    case 0xA700:    /* Raptor Lake */
         return 12;
     }
 
-- 
2.45.2


