Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A95CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyK-0004oV-1H; Fri, 15 May 2026 17:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy4-0003Yf-Cl
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:12 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy2-0003Fh-QA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:12 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7df05fc49e5so348554a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880069; x=1779484869;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D38eO8lh1/Hmm7MWyiVfG7ePSFfaPqvbJ6JDxlidPfs=;
 b=Cz5tpxU30Go9lTgRa4lEwDu8LIzixNiW+8DVb6iPANIEx7p/Pyk4pUemCUb6hApCxR
 f7caL8QNVmTU1UXUVObnZRVWeBdpufZ1IU5cZqX0Xku5CS1CXHVzstJONgQejBVyKZId
 4XCMQKoh6BmUWDfirBM5rT9CI4bgGMVY8BvvDfBZ23QoB1/CM/oGmwrabJcd9zGwfZbg
 t8Ap0cv+VOGuDfjxgQFEhmnFZBOnlqJa/3jjt7mSQTHbBZ4Ppe9bdV0rVztg9kLDE9Ft
 BycS47h3inhHoT22ckQxmCRW8MHpSj2H9fsKXcsMAmmeaiM6CD1PWAobm/Vk0FI/SpiV
 e3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880069; x=1779484869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D38eO8lh1/Hmm7MWyiVfG7ePSFfaPqvbJ6JDxlidPfs=;
 b=fLoKCn6DGueHgajmTAjnmhv5CVYip+vZPfkM3g0Ubm6YoLep9HjF1Vn+68XHHpf9ht
 raAN4xUSOfALnmAiyrA4edmr6INxlIp4t1RLxPI8gRa7+exkviChb5OCBkHxwh7a0ZaJ
 /C1dBrAd+kSdWrrUuRmIiDWl1gsJLIcevanI18R39v5/LjlnySyg2U9yU6XvScV5Bfvn
 vwaW31qlvOnfqBS4ryrAdpeK+iK9cQyAJzGkNE1tDfWsysy/IbGTi/K29Bb5OqmK8ZmN
 HwY+beTG818nln3cnKpBhGg4q3NoqsiwZmLYI+1fD9tupwsR9rGWMaZ4kf9tU+F96INS
 gaYg==
X-Gm-Message-State: AOJu0YyhM6l7uBQ3baJrI/+U+kM/WcsE9xESxenwht/JApjrls0wdX3d
 q13hw41GXS2J8XXISWLjETtbraT3me3AsVAxaUHCTcFwbz+rIBIVMplACgV3wa0roM/ngZ5YhjQ
 HqYtbnW8=
X-Gm-Gg: Acq92OEuZ6mKtFNo8v5OwpsNknFVKbcatEjTWoTaoTZXUBafbkoB5QNQDwzXHMKveqK
 xkXdxnPFpMymWT7+rw4dOVEBTeKBDxccMxexW4kBAxRWY1bPQXyyOT34czh3E417LdPfaufIogF
 /4KfNlBeE9cGxwcjV6p1OvrxnqSgT3Wj9+CWXC26/XCeGe3+ok0ByDF2rC8Dlkw6KQkm0yjuNho
 8E7ro4CJhJ+M3zEFWrWHW/9h3IEGjTdWJ+mSZazXX/gEGsttlMKL38VlSyBmM8KAhsbyBwJzWcD
 VWUi+BZtbwlwjATSx5F+8YxKbxWpNzyEd7AT6hiTmZIoV6ap5+9hNsXYV+mWrul3RODS9i8whOQ
 zKoUKtmoj/F1c3XMhx552UsCz07Vb3BxxDZXKMrcUryu8xXjS+aJwshHeuY55vXP2X3dCk0lnLv
 XbwKjrb5uZtmdjD6kAu1oD
X-Received: by 2002:a05:6830:668e:b0:7d7:f146:8738 with SMTP id
 46e09a7af769-7e4f2b80067mr4070093a34.12.1778880069377; 
 Fri, 15 May 2026 14:21:09 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:03 -0600
Subject: [PATCH 64/66] bsd-user: avoid writeback in
 do_freebsd_extattr_set_*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-64-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=P0PmncDAKqIuggMfkd3RkG1LhSxy4JsgHEn9y6uwGwY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43oAA5o/RuPISo0ZWVRnPIje6Qcah5NveUPt
 rjWpcfmi4mJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 ABapEACfu1lbHR5SNoMLfoCuTdCgVYrstb5edNpeQDMSEOgTJMGkYukwV7epPi80/UP14pagTfH
 5ceISCAdZYk06/GOgOs274CUqIbfQDHJ9qYWroS8reC8A4v6DCHWK977I++hPOjHW2HwXfnalMr
 4wQhjw+x0fpw8Cuz54U4jZhu2X3NxdL4pxZATCnAFe4ImCx8kbbdbHv4sgvg2b6v4eylnms/4LQ
 q1Tm6Kx9FzboDLvjRRe4D3N0f/hNIUBXY3K6f+GoWfGcNj/YQiUouBAvVf+hMmIbIrST/mllCs4
 tDDCqKOKkwz63kgKmh45v21OTtYmcZ5yQvRLBS+okiPV488Za+Vd9gO07Kf8B6JUJc80woGkX6T
 qHO1xhpLJkUFX5z93XsCM7C8DrnUpcjzQaISyPRJkAF2TXXsiKVMWGgcDpxp0HC2lziZSFpFSWX
 cYehcCMYjpzcPM4VcbKT8V3qwM/oeiqCsyZz1m8o/VjZwiKZ6vur++JGZTAukeUFLzbFTvEPg0H
 8gDAVApl9YTXAPAYd8Cd3B/UxYUnUcINNG0pLhFd4lBp+sR2lBtwwudXh5HIKUjFILMOQO4/XeE
 ia7S81wxJxDrPJxjlYPxzZ+LiAU+kqo+p6NfTVaeiPsm3kYrgdpU/C1sysmJK8VGDyPp+ffVgYC
 ZD++KlERGTXTuUg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When we unlock the the data we've read in, there's no need to write it
back to the guest.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 97c0f76559..5f5678b380 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -65,7 +65,7 @@ static inline abi_long do_freebsd_extattr_set_file(abi_ulong arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -151,7 +151,7 @@ static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
 
     return ret;
@@ -267,7 +267,7 @@ static inline abi_long do_freebsd_extattr_set_link(abi_ulong arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 

-- 
2.52.0


