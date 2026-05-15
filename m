Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DABCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyB-0004Te-6D; Fri, 15 May 2026 17:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxw-00037Y-E2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:05 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxv-0003C3-16
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:04 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so344789a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880061; x=1779484861;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hea3vfuymH/462A29VI3zQPB/i83Cle/iCROOOOr29c=;
 b=p3HoEDHmmDO361R1HzaNWnQbsKaYc6oY6EIxC6eNuRXVuE0smpcJWLV8hUW2P93CgM
 orYUqW5UseS+88GTRz/YePr/3+Gn71FedOVWn1Jl2D9EH+wEw84yQ68jJBoji3u1WTz8
 cp4SWzIRBV+FthG31t79U77G8jaAj2ED0/k1R43htjFS5Z659OWK4pZhsiu8lhMR/SSf
 PieGIcm0inQY8B6yFjH5S+VKIiI2QJXy0PlS7bpHJFEs8WR75plWHDlbTP4peiPsWw8L
 1yaupjppb0a4tTIzqOvomfVs+VEaHRcxyERQk8rDMaxcGybX9gvVP4NfBsLpo7HOHha1
 YbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880061; x=1779484861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hea3vfuymH/462A29VI3zQPB/i83Cle/iCROOOOr29c=;
 b=ACLK6kIzNye/v1zEBxF6BVMU4e17YqkDfrBd02hZgf8Y1OX1O8YhuXCiAFbT9vxlV5
 Da1+1ewhi4MAmxS1k5iYwnw7XjVwpaOt0BiAyu6uy11lONmVSEchHttGeVNMn+bWTG/r
 Menv2Sul4Q5lKhBg5TOnCChYyg6fOuV8CxIir9h503gH3wLD4PMnyjwB/1+U2XseDBvG
 hAxZvR7DcFlUNSrecGMUd4TKyS6CBnmr7/jS23feeCHNF3LJ7PxVe/UrpG3JQoduwBRj
 Cx/zlitrU+5uvf5AGk/9iFbq/atFg1E3SNandkHwgzwdDbZU1jTSZvSI8O30xd1luc53
 3Gew==
X-Gm-Message-State: AOJu0Yznpb2XZEMo6y1WD8LGU5tYmTb189nv3kchUINynLGTr8O68fj6
 EkMFbNThuweSUMCURlSjSnhxKw0JPWMFprH+46juiiDrkUP7aaMmdrobZusn5TZtre8Wfs9Cz36
 l8EKWt40=
X-Gm-Gg: Acq92OEiqa4oz7OJcrPuQ/yHTWHm9QVSurthIIn9Pdwes7+3jv5H2SINTjtzRSXxPAp
 FAs7GZ5n2GHnWahCHXSB5V7/f4hrR6DbW0+BxKWZ5eAMOGruzEBscwb24tXKxpmueJxHrwPsEmW
 qm21xDNCQXKeXJ696DxIXSsp+w/ZnHvjZRj8O3EQQOAuHhppz/TMJx4BLDqcUf8PglSfHPoqh25
 wQ8ZM0/yzCIRuavhy9nv4papclEEAMfE8EPz8SzNGqR/Z+lPkO26lXmXY58s2lSAm5S1X1E9OMP
 zKfpPAOEzkxK0xstJy+B9YPW4pHNM/Rpv/1j9t1cgvoEZ+AKqNLdFPD2n48pPqSAm6lPMEhmdfx
 98eAQbrj5R4uWyvmUhNKer8gIg9/v6BL+57RmsW/g+45h1v/u5wBLrYX7JeLHnuXJbFh3altRFe
 aJkkHawjRbFA==
X-Received: by 2002:a05:6830:631b:b0:7d7:dcbb:280b with SMTP id
 46e09a7af769-7e49a881a10mr3653087a34.1.1778880061635; 
 Fri, 15 May 2026 14:21:01 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:56 -0600
Subject: [PATCH 57/66] bsd-user: Fix gettimeofday's writeback to tz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-57-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=CzoBqHHHLiKb7y0UDPvs+hHkuyOVl6iTOtVPzpPOIR8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43owb0bd8qTlHP6YXUvvZhXtyv59sxcMg3Zh
 hGt2o6/mBaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 AOoDD/sGvKuqJ11DHTberZCoR1566Koa2KnBOLJWV2PDgFiTFUm3A14Zr6fdKvn07WyS9dCwt0D
 ZQTuEuxdibEV/0lQfkEjx79qQos9VmBgbMoxf/OL94vpSY+5kw5iZrBN1g1WQIRnzYVqd3V3/kT
 Gn2ooX1TekbvtW7F07kHCMNxoVSAnJB/JwSIlz40jrw0hmTMXkywOYIGbNAV2i8NSXZcYg+oKmk
 zj5Oq4ZJalI5UQl2ZH2ZTdyBczj1Hvwd5megkhuO1X4UsSlQlpEfMq8ov3Wwhj+wJvvxBy6t9gq
 W2m9uGQlYN0oh9ldC+maCM3hXzzRkdmrP9CfkhJ2C7OZrCBl3Uri2J71TrxJDhFmhXEgeRtxqDO
 vCMr6NgZg8W2nJOo/ta53fThNXNCDwBZuAD5lvxx/cTv234h+BAGllQuT7zMkYvsYRdrdQvEEmv
 texIMatZ4tPNE01YDCSkV+yJwbVWGjr16Kl2v5oii0N4j86hkkHt6KtkjNFXPCOocw+/JoLipVd
 CrG/y/R1xTrgSeHJbt+qboFnRiyv/xXsEKOj+W1XvjGDZRiGoySuOE0eFyXrc3pFEWfTjNBIEri
 RZU1YSorKEB4bpU5lmCaA5ac1pttpduEn3aMwk7Cj6jxAt35e5hrhrIAKguUwOM1MdJarOGjqKo
 DI2BZno4PfItgmw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
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

While TZ normally is NULL, and we normally write back 0's, we still
should write back rather than read it for gettimeofday.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index ed075b7df4..29436997ce 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -124,19 +124,19 @@ static inline abi_long do_freebsd_gettimeofday(abi_ulong arg1, abi_ulong arg2)
     struct timeval tv;
     struct timezone tz, *target_tz; /* XXX */
 
-    if (arg2 != 0) {
-        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
-            return -TARGET_EFAULT;
-        }
-        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
-        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
-        unlock_user_struct(target_tz, arg2, 1);
-    }
     ret = get_errno(gettimeofday(&tv, arg2 != 0 ? &tz : NULL));
     if (!is_error(ret)) {
         if (h2t_freebsd_timeval(&tv, arg1)) {
             return -TARGET_EFAULT;
         }
+        if (arg2 != 0) {
+            if (!lock_user_struct(VERIFY_WRITE, target_tz, arg2, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+            __put_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+            unlock_user_struct(target_tz, arg2, 1);
+        }
     }
 
     return ret;

-- 
2.52.0


