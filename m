Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA27FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy2-0003O3-W4; Fri, 15 May 2026 17:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxp-0002we-AE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:59 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxn-0003A1-P1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:57 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbd23bc684so161034a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880053; x=1779484853;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3OO0Hnh/zKjyFfYuyvc3qo8c9ME9eHPWV3ninOtzGOw=;
 b=XKYRCKoFam52r2ue7IseqqLMV2dJICPj3SU44pj66jO8ODTUN9GWp4xD5E6lbb4s4M
 F8aiy822yrWw0eXq5limixwQfvcC1ML34ApC2LTM89/zpyfnAcyIPLhj19druTFbfHan
 fPAqlBJQAhGsvDWqChSLSiE9UT7TDaQ1ZV4Ch7/B+XBUUkU4sgOHS4GwbS3FXux4Zap5
 Xm4xis6vREOYSAEuSIxGHHy8JaXUlnQZ5LEVJmbOhQkdtl/ogHSdLze0PBFlST5z8FPN
 Dcbi2Enq/XFsP6Fu+tXXpfhixQLmD2YrWakq/DZlCgvKIZGVFsoqnAbu3niuR6UJjKPT
 s7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880053; x=1779484853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3OO0Hnh/zKjyFfYuyvc3qo8c9ME9eHPWV3ninOtzGOw=;
 b=XbCI3+YeuajFlFidC7LyuG33R3sSvAAM8Iqb6VuY09+6y8TIOgbTwOj22+ezcp2S5A
 pYlnhsMbJR5rCpc9J4lhlMoTSak8ieRHPYIf/BX1ndxEnJ5mXTuSscZZMQQiUNIJOcLP
 6MSc6n2sMUZVF1Nz1Qmj8Vu4LVF3hV4RC5ns3IoyMC3PvZW85NZV7gObMtuwyiO5+tHp
 ENLCipLHkstnFMxHTyun33LuivnknDENBu89ekz5eG5kpcgDbo60t+0322rx7IZ75xJm
 l2tadIk4dVjzaTg6BWgkDdMsVN+axRE2G1ajhBF1EwLTdbfGdzLMIQU+2d4dF+9bw/5f
 1WHQ==
X-Gm-Message-State: AOJu0Yw3+Yu65c56737wMGMqp5rtoGXZ9i1oUTqeJ2PHkB/7EWC0FUDp
 oUGfRiZlwhfe9q0huJJVoM2B4sFz0zkH7Hg0bMNG33E8MaLhP7NpXLqmcRuzIVIWxYkALOTQfJV
 TzUNqHA0=
X-Gm-Gg: Acq92OG1IVzgmGESJzm4w4iinFfCunMMNWgbGR/boQWS78/DSMdJgWUU/axaw5Y6OMm
 4jJm0C0jpKDbVtWkAn8wUhSKiE2SYZaNxTbShSBCRzVgUJPiC4OT0Qn4FIWMhluJEgiIdb15yq5
 aRxL0OA3bw1H3CQUl6wxSQXQR9yw8CtsBzNBUjO6fHn9NV5m1zKseTUKOIQa5/XajmWrJOCTY8V
 rzi00ecCDyZBdlz3FKNIWIYag3k2tFlszI10fLwLaAMlCTnTwUVgEAWxkqslc0AYucbEiVQmkYl
 aXEybbXC2fc5mdnrzFX9z8X16i+W2dr+pgEkCzCqS1ecR7eh/R7ybvGzmYFRIBgbovJovXCDxwi
 b9XHlVFNbkC1EW8MidlsWfthN84JZuRoJBhn4I25TY2qUmUjKBv5fvdNcdnvwPMrdSR1jIo81ei
 53GO7joD5jmckqOHvTbRGJbmaBsnTBFcg=
X-Received: by 2002:a05:6830:6d27:b0:7dd:5a21:2246 with SMTP id
 46e09a7af769-7e4fa0bdad4mr3976418a34.25.1778880053231; 
 Fri, 15 May 2026 14:20:53 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:52 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:48 -0600
Subject: [PATCH 49/66] bsd-user: sendto/recvfrom need + 1 too for addrlen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-49-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pbDXi5M7FeJTx8g/bOe21hJcf64XImhdah4CYd8ifz0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nL+I8U1WS4nxzHOSvJY9Qn5HY9C5BUK29V
 StxZ3Ce2nmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 APYVEAC9tRIrw7CIjCkIJb7Ly8LB1/asfEUjGXy8dPJiBfsh9DkS92UX1iJ3rkuyUsZvf5cji2a
 EHk8HqnTFaLRqDKzog1Lhf1VHMeycxpQQLXYMKkilryajCn7nTtS+fzgoyZf+Hjh4GkkEmuQmAH
 tAc/3WCmVclAW4VqIJt5+aTJkhj6qpjd1hmpF8UR8gNXPAekDwKZ3Y+WAbjIIbrRp8Y2+dHrkqB
 ShM6R5AnBuKQaIk4LISfcZ6fJ+s6/B8uRtQYJDl/LSZd0jwAtJNYlSiBeQwRS/4WPma45gVFcr+
 f3UYkETyhihvWJbeaRxnjho1Lf9lxqoS9GA4STQDb1i0amM/tMu0kBm0XI4CKthuYzZbcB/l/7B
 jBeL6KiHr0l7vp9PodZF7YInLqw1zpO35rgo4oQUZ2JaVL2WjTmYn9WmUBS5c6Sz+FBtNVPulH5
 yxpww9EcPz+LFWN3RWEHgyFbL81jhSkn8mh29dIegcFbs+cPbtg1XMYeYgZEXgCFW+6fDd6095I
 T4zeuPXawNZquwZjSsvrOTp4iAepZdcGDmKkpeAtjmh9hDVJ61AlzQUlsCTCRnu3PMb4tNwRMNk
 D6TvJ1kFyBJlr0b1O3cV3DrtZuY7Ut7A6tHIzB6uWWQ6i6A/s3y8Y6I5k9u/qsX+Pk6NHDZRwSk
 7c14beCYOC2MI7w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Since we adjust the length of the addrlen by upto 1 to cope with the
off-by-one errors that plague unix domain sockets, we need to add 1 to
the length we alloc off the stack to account for this. It's not common
to sendto/recvfrom a UNIX domain socket, but it is possible.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
index 578cc3959d..d85dec59c0 100644
--- a/bsd-user/bsd-socket.h
+++ b/bsd-user/bsd-socket.h
@@ -198,7 +198,7 @@ static inline abi_long do_bsd_sendto(int fd, abi_ulong msg, size_t len,
         host_msg = NULL;
     }
     if (target_addr) {
-        saddr = alloca(addrlen);
+        saddr = alloca(addrlen + 1);
         ret = target_to_host_sockaddr(saddr, target_addr, addrlen);
         if (is_error(ret)) {
             unlock_user(host_msg, msg, 0);
@@ -235,7 +235,7 @@ static inline abi_long do_bsd_recvfrom(int fd, abi_ulong msg, size_t len,
             ret = -TARGET_EINVAL;
             goto fail;
         }
-        saddr = alloca(addrlen);
+        saddr = alloca(addrlen + 1);
         ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, saddr,
                     &addrlen));
     } else {

-- 
2.52.0


