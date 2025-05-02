Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C726C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8M-000539-Bo; Thu, 01 May 2025 23:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8I-0004px-7w
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8C-0001K6-16
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso2422143b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156726; x=1746761526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=la/nrh6lZr7amj/W+LQ5Z/E6fUVMMUf0PMLIoeHd1gc=;
 b=R4zGAZG1GJvhUrU+1pA0Gi7a5CiQZTkyJ+65dV4WBiykTmMI/Qv3axw/ZyMNxvA+Ts
 X9Ck22pxoNfmqmyucMZl8F/jpTzrVwWc6kN+XuThOhQ9mUkhvyKeeMn52SxihT/a+MVI
 TofvY/Ni4p2CCqxZi1Bc3b8NduO2HbzuXVuAy/aGMX/FtX0Twg0W4CNk0VHw31Ttpb2w
 eZP/r6sUwmTuWfY2ej9FTMvsresMAU1P4N3OG91jfx9l0g8TlqoyEpyLQJSV8iczJYsw
 mQP7OZ1Hh0XLoh2GntGuyoNyiPn54GNLovHxxN6NdLRPpoPf5UBoyq4UjyjTVwU5L50D
 4PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156726; x=1746761526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=la/nrh6lZr7amj/W+LQ5Z/E6fUVMMUf0PMLIoeHd1gc=;
 b=fRyXqDvynmHZ8zcQvl+4CTE/STSTizP+5I9vF8uH1Qi/V3SrhX0dBMWY+Z2ACN08B5
 bg7atzyM7Kkh/fsEZyvJNqQLKzaXa2yZh/MPEn/QUA4hF1EMdhYQhVspgLLS9m32JDaa
 AA8on8sMbbAUCEQCtrNuc2ImAhc9fxV1KPvWUb3OA7+XxTjKjAsy0fdffYXjkbnDKbHT
 w0qLUoHRcA2DTwga+h+CRSCcgNXT3QdlXHBC5OFma8OovWidIIPkbqHyDxCxzGF9vY9P
 t2IRxUjD1NURjsyZ3Azm0YthYs7//vnCEvjtemmyhWxzmB0QnwvA05OLqooyOWgXZsXW
 aInw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiqXdEdVL+lujFc6PxsjIUgWj+fNKNNuPsH2Uq99RZhDgb0wE/b5wYTSwFH5lQEV8m7kiqojvg/SQr@nongnu.org
X-Gm-Message-State: AOJu0YxRqCpOHuMDVQBJAOFopvECw30fa5fdBgLwbt0vL7kOqGqYG8Sg
 CjKgSZrWRI7hnnsH2mSB8B7Xjt+hkPZUNBNRGNXe7f/Iq44QahOGbYSUAA==
X-Gm-Gg: ASbGnctvlDbxMfRQ92QiWJieGikTjxNy2QyIm/NqKV4C4O3SxhU8BF7PIOpuN4giqL+
 BVdmn7Y0wnN/mla38zMsmWrGbKvG0MM4/VvXaj/G0pJVTd3mqgT1hhrEQZYWTLpGBa4HKb7oB/G
 VkdV4c++OzvhnAXiiIJtbeQN4X6djdJR//7YaCG9yUBKLdrzZBFIEf/y9292hlfQCwmFYxUeVJS
 4Ne2nf9/C85VxJk9HIvaC/19UgOIs/V7HrBEh1eWi2yDWRKNDMoNIbQzcGCEiYP2nLf3qJSmLh0
 RwTn0YTq8DB+D5ASI74bWj79m01FuOcEsPHEjPZoz4uu
X-Google-Smtp-Source: AGHT+IH1KsdswN0zKZRDXnauC1VJAkJvyrzy7XJ4Zrzm+EEYdaUcmxx4AHQWNBs45+OhwL/DyzUDSA==
X-Received: by 2002:a05:6a00:8d8d:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-74058aea47emr1783610b3a.16.1746156726024; 
 Thu, 01 May 2025 20:32:06 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 13/22] usb/msd: Improved handling of mass storage reset
Date: Fri,  2 May 2025 13:30:37 +1000
Message-ID: <20250502033047.102465-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

The mass storage reset request handling does not reset in-flight
SCSI requests or USB MSD packets. Implement this by calling the
device reset handler which should take care of everything.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 41924b9320e..fda14271eae 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -366,7 +366,7 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
         /* Class specific requests.  */
     case ClassInterfaceOutRequest | MassStorageReset:
         /* Reset state ready for the next CBW.  */
-        s->mode = USB_MSDM_CBW;
+        usb_msd_handle_reset(dev);
         break;
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
-- 
2.47.1


