Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA6E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVF-0002p1-Rl; Thu, 19 Feb 2026 00:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVD-0002nw-DN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:03 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV9-0001xU-IK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:01 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so345187fac.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478578; x=1772083378;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iu6XADh6tBVGnb9s7zpQE7ccWgUjuPoiVdjFMev6W3c=;
 b=qBxZfdcOGXLM+2ZsBzyGpo/3IiU54oXk5KkAuBri24AfU4UH4pXwwBTcfI71bHUZoK
 AJMc5QLaGduEzT9A/xDVqa7gXpEpeIPJ89lVeJ979Rd3RjXHqHqCwWoTV7NWPsvbpQrz
 6u8Kq/0HXEI8ykEeWlJFwD2RVlWXpKscH7XaS/lqKp4W5wgqtYlqNSuM/KZZvu5ZK+7m
 39K/9tLsAIFtZa9IB6WliWUd5iQj/9sKe2ZQCh9TlghTJSpkgfnpX1hpDwyI7e1s3sNt
 9gZK/dH1DfI29nKGRk7TghWbhwOj19CpacteNCf79CfkmPwpl23SggB7kYwVZ5H1fq/K
 5LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478578; x=1772083378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iu6XADh6tBVGnb9s7zpQE7ccWgUjuPoiVdjFMev6W3c=;
 b=qemWM6PIUF4gEv7tEJsCcJdI5YXztw5xhk/MPsrIxXDW7lLyQCAGyGksEN6WWUi9WP
 OLnvCz8UKdlVtqcEGkw42L21EY2A3WCNqfhPmhNh7Y02q7cVFXR1Pp2yeALVGmJjEZ49
 snGCzmtjz10fya81E5b/FgF5jaLJeikZ1HZTPPScXUv45kJoSqdIWGSjBlOfR7TXVvQU
 EJ0czm9WbyeC3v6YK9tkSwZQFaBSocerouTuCEJQebE296XPW0SQZn+dy5GVLF5cDQcg
 fkOduafau3C0TOZXCmXTXlfHXtKbGfSO6V5/pQmoX/SuXpbQxOJk8TiCaP+SvRnmRdzP
 ESLg==
X-Gm-Message-State: AOJu0YxCp4xT3Hk/l4LHZigt8wMZVq9FZNKC2yF16FLGAmHxke6dsXqy
 62RBdfD30aBZbQ/JG//kRLmzuQcHdgtwOQZSl3uENepS1bTJyar42yQP+4cSHDPl9kQ=
X-Gm-Gg: AZuq6aIsV4e+k53gqsLCLK3XjIwdhEgo5DGhuvamYIEEZ0bJpJHVvHTlBvpq75Nn8ll
 RBb+7rJ1W84ui5woTJ/wdBKAoSPfIVHbJvunp4n8pCIYxTi3kdvAk43da9Euhu860bLkAK0St4b
 DhTHV7QRkLVSI13j8XOkXOGP46ex/EQbWKCk4mEoSpeI1/BAdoKiwEjBKTEixbfHjTZ5xZJoCXn
 MtkqRBoHe4Q/M7BLOoyKPbIc/P4bnuMeB4tYk2c1P+5VOVxLgDWH+KpojZcvzO2u5G2OwIEGJag
 BSzg4dlFQw6Noy/lRqQPp0GdpAu5/44CjzjcsV8H6lFuw1IFuu7jHM0Lwk0mOmJ6rZ95fhZf07B
 rr8xAlk/+NiHqZvEN3uDcS5lbQW2PtF/qffUENLdWMf0hQ/f+6oFUicXen96boN3jbWlsFoYyoG
 Y8VwyTvEMsIw==
X-Received: by 2002:a05:6820:160e:b0:662:c09a:903d with SMTP id
 006d021491bc7-679a7477d8amr2498782eaf.79.1771478578511; 
 Wed, 18 Feb 2026 21:22:58 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:58 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:39 -0700
Subject: [PATCH v3 16/24] bsd-user: Add do_bsd_semget implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-16-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=SV0eNLU7fS1XVSTHoXjgS6GD2dK60TDF+cTpamGVRRE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sQoccYgVjK9Wklsst9B+hEXmCTkbpcPflv
 f0ypbkIcOqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AKisEADhXgN1AI2SHLWgfJWMhWwG90EUCSJuETkekAaRjIl/ZsZ5/6+bAPf1IKlAmqYCkEeuRah
 MO9h4lb3hgwcjyo4HwZdq5MjpLfhS515I4AY1MMSZnxI0j4UmJyyVVdjbnRxwJycqbb0lbIFmqT
 amBeLrhPEaOLnLT7dit350i70VR76pzUt1UczSljguJ09uHmHM7faZoEU5yBv9eEIs89J0n4yRB
 +eSwwdj1lTjEpel51LRk48rcBY8ipuS6T19icKIULj9ujbZBOd7IvZJ+K2xqLW8tfAzFkj8WV/+
 jZiLDOJlCIlPM7Hwwc3lQxTc/DeE17/HvEr87F8Jex9/mMQ697ldmsuou5WsPIao58gUJ0ZAD9G
 MmBxhhb2tbLVtHGvZ9/QDO+l3tPgS7Zh9zSHdUMTQFjsfAz0UBxa8sU/r+gWBUYXjGxikLoT8x9
 6cAk+48CHo5IIN+o0xOUkq3dc0xal/bxY61FC37A/W+AgiCsyvLzFLb15NRsGE9120YFWQxAH41
 zvSKey8pKGsE/8o+IqsNSLVlFFU0OJvTCxmdfTIlq62ftBBVLfZRCbCqnckjSnvNcozcgxG48ob
 afN0vJiOPY5On0DuTpczuH+gGkBsKo/FZxDjm1dSXLgXxLS6TeCaGQgDCmzEB8yuJPMIgsYURCR
 W93g7J1v+/SoqEg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of semget(2) syscall to get System V semaphore set
identifier. Converts target IPC flags to host format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 9f1cc8a0cd..3dffb977a5 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -65,6 +65,18 @@ out:
     return ret;
 }
 
+/*
+ * System V Semaphores
+ */
+
+/* semget(2) */
+static inline abi_long do_bsd_semget(abi_long key, int nsems,
+        int target_flags)
+{
+    return get_errno(semget(key, nsems,
+                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


