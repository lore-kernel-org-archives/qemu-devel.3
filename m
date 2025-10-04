Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C42CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 17:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v56Mr-0003s8-O4; Sat, 04 Oct 2025 13:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v56Mm-0003rR-PB
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:48:21 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v56Mj-0007UK-3T
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:48:20 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-57edfeaa05aso4192465e87.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759600092; x=1760204892; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vuzm8FeLO84xvcLhr8EGDm+15bWYBkiXGDkQ3fYG9w8=;
 b=MdaM4aOYn8VNTWk2zimDGftW13aFwiWly60FPiHL72KwPOaXNXHBUTfg9S4+jdGGl1
 mnQflqxiQ/6ivYAZS3Bo7kStadcz/1f1m7px68LAT57NI9XtwWMo3i2/ditzSyrtrfew
 NzgWoEAR6/iB8UXAx6cF/QLHOmkYhnFE3jK+ZFsZrl1uEIGEb/biQiqIzbYNLgzIsrPU
 yo2n+JoEU8/F9Kpwebym+5ehIuxN1QY1nQvx6a0UgBDcvkxQkD/V1cBpB4lS5kn9UisT
 I9D+q1FM4UGkvJw7Ogbt/TlSkK9he2JHBtZ66FDd0WGTifZ067KeBB7IcXStwXRZcwOM
 H2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759600092; x=1760204892;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuzm8FeLO84xvcLhr8EGDm+15bWYBkiXGDkQ3fYG9w8=;
 b=DFfjCI6OJxCqHE2wP+AlauUBE6DHn6O78NLadpjwWYqPJ96D1K1nyU1wt0tAf/GbBo
 JWoL4VPxT7Q8RS8AGdQ3iR3dviz3dX64QbIrxKYho8HioiMHkfGIJt0CSZenV2Alhl59
 HK8pUVofNWOl5a9dK1CEI/Ow4LGdp50YUvNdBZFZfxc2DWNzRWNaLHo5wsnnWbigQZe0
 GBO8APpt8Ws7AgyjFsoHmpwVE1ULO02lbkvhoAyp8f62cjxZKIWilRqf83rhoysF9O9G
 lMT1M3Ahdxfnkzkocvpqqcy0TSCrFv2fOjXurChEMvcIVrwjNYf5KzYZlZ8IXJosUf9H
 Ypyw==
X-Gm-Message-State: AOJu0YwfP2zN8TmckmnCOhKe1DBv8dQKueB6o0FktVAGDc7yERieY2PH
 sT/eb4exyXpAullNnf0wIh87z9/IJPFiYLvpOe9eChYyXGZDAAIy7G1wmCHSf0AWOAc=
X-Gm-Gg: ASbGncvvq8LGWavsJauz2i9nTEYPD4T3HGwTJWVS89X8Rz/j9Gz2qMjRK8kqbPeNk/g
 EVALaPZ5u4TlIYx7CkBNUZYgrLAhCx9Ag94vKy0+AHD4rkyN0Jq30FapTyRHJCsaPoV/cFMPKAM
 IfZi27nhVcHlLzRvKY3FrrsoB4t2OIronbQeG2BMr9IHD7+vpNSxSNnvu7cuvBvbY5PVN96JD4i
 cIdvYIAhKr+ZmofH8Tmp3ZC6bgtUy9nF2Lkng665mlESvmJL1NnoUgqKt5xfxIO50nSEqFsy3SQ
 UHcOdLhxQKsdBsDG+OJ6yBwIuL2MhcuWWX647YxbUo3q1tceGYipn75w279H4B6f0Ur3wRVKK23
 ZRdGmSrQIAA+vS25+B5Rf5wkxgTXX5w6vL3fwHUhjTxvlFo3y
X-Google-Smtp-Source: AGHT+IG/xSIOeAmXcaPtDLFFHENUgnEWAoufYk4qkkTIsisu8DuF7jSvpV4Qdqts8s0+WUa+ZbL/uA==
X-Received: by 2002:ac2:4bd6:0:b0:57f:6da2:6a1a with SMTP id
 2adb3069b0e04-58cbc2a52bfmr2084024e87.48.1759600091831; 
 Sat, 04 Oct 2025 10:48:11 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8080:446::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-58b01141f33sm3048501e87.61.2025.10.04.10.48.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Oct 2025 10:48:10 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: [PATCH] system/runstate.c: Add a newline character to correctly log
 guest errors
Message-Id: <32D0DF37-A1B3-4532-B350-082E19E4EABB@gmail.com>
Date: Sat, 4 Oct 2025 20:47:56 +0300
Cc: qemu-trivial@nongnu.org,
 =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCT0YDRj9C90LrQvg==?= <xpahos@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The pvpanic handler calls the qemu_system_guest_panicked
function with a NULL parameter, which results in the absence
of a newline character in the guest error log.
The qemu_system_guest_crashloaded function has no additional
logic, but also omits the newline character.
The qemu_system_guest_pvshutdown has no reporting in the
guest error log.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
system/runstate.c | 5 ++++-
1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..8b4bf75cd6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -674,18 +674,21 @@ void =
qemu_system_guest_panicked(GuestPanicInformation *info)
        }

        qapi_free_GuestPanicInformation(info);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "\n");
    }
}

void qemu_system_guest_crashloaded(GuestPanicInformation *info)
{
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded\n");
    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
    qapi_free_GuestPanicInformation(info);
}

void qemu_system_guest_pvshutdown(void)
{
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest shutdown requested\n");
    qapi_event_send_guest_pvshutdown();
    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
}

---
base-commit: 81e3121bef89bcd3ccb261899e5a36246199065d
change-id: 20251004-add-newline-guest-error-log-62d68638b28c

Best regards,
--=20
Alexander Gryanko <xpahos@gmail.com>


