Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BCEC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zN-0006VL-TL; Sun, 20 Sep 2026 01:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zL-0006U5-1e
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:19 -0400
Received: from mail-oi2-x0e.google.com ([2607:f8b0:4864:32::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zJ-0002D0-Cm
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:18 -0400
Received: by mail-oi2-x0e.google.com with SMTP id
 46e09a7af769-805cc8b4231so1164532a34.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881676; x=1790486476;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mKSAZ6FBzXteRc983sECAUIs1x6XG4ddUlM3LYVt+Xo=;
 b=j0gXsz/pjvoO8o6YbWadpl0kyvztUNJq1frn4h+cErJRhNWVsSZSMOCGWCQV2/+Vbf
 fkM8YLBemoazcKalr/ZUcU0UERs17acIgOGAFfp6Cjod3gjO5qo8fXFNmRgm/6YyZIll
 c/wUjqq6xkLOkMtGpSJNltZYIS+5QPYVxpngOKNEfk/dHh51nNRYWnR7KCYBmgSTR6Uc
 cqo0WrrGDmat5s16Nv/b5lxr9OJ5eMLh0Murqi4UHcHon+l2sf6hvcme/lfFZMr8KwDN
 MdgpJy0JPL7WrG45yGMDK1n5ZN2ATIlAf7Ioh/rYhLqRumHwPhP7YpkiiFx87d0KiC4d
 5H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881676; x=1790486476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mKSAZ6FBzXteRc983sECAUIs1x6XG4ddUlM3LYVt+Xo=;
 b=rMT5Dun5Q6KM9T+CfK+ZzsZk82m1/9bGk/8/7LP9QyPCKvTgFr8r7UvLaJDP1TikSU
 X0CHPcani0IRiNtoMVrlxrxLii8YLmYJ6Zd7Z8fy2Cc/p4eev/9JEdeBCHWPFYbvybtY
 einQmlJzHWfMLV5v5UJfjTZ7uunnCaAPqI0PtR1FO9Ar50/YfUonXXpI1CteZPThGNqT
 NR+Mq0mnQ7f/BaYuxJB7bhx5H7SIzX082yGeWzteG8Zp3/6ONeh99yKr4tylguH2UB/J
 fOUeTtVoALQsV3R9DN7sxrRpV9UW9vw4N7ee9HiMGHU5OHAcxmlLGeVeNvXbZh38ZD3K
 EwLQ==
X-Gm-Message-State: AFuF++nSGf4cVp1b6CWtCZAsxnNT1qISpvWaGXPuWq1EL8ojDLfqk+pc
 5n6dmOnfO6I+wj2zr0tj5zDMQJGD1QfO3pJ+7gX5ljw55e9TTklh353hTpMm6Z2bFZ4=
X-Gm-Gg: AYBFou1lQfEFkgVVedlbrmTYUH492jlIG2RjbKEx7nA0tX6KeGVe5dDdfqt6YP1/GoQ
 OOiUC5A3sxeldldSUkSdBdzNU1Udj8oX8AzZyqAkybzGCJZ30zMp4fyuCnMo927ACHHDXJZ9fJx
 J0+/fYepDxeC3zXBK50nuF5fNDfMo53dhotG3DwEc2S4V6MFGND5Z3hhMJJRYe3HTd6hJjAlUuL
 sxJQTUB9kgcdHi5JoayQ9j30LvGT5kfJBc1TC5X0fgH/Mo54lcG8JCKGpm9TW1izliDNccdjIA8
 rfHY+PVTJ+Eor7KiGQJQ+zxsz52P26s9TRHuNw7RCP+RErmopmEiAmufsvRhbV/yoK7LGWX3K+e
 F2hyJIdsNr5M+KkBcUpB1OHXmtY21POAqg81vAlb8y8TkfBJU0aEEs7di1eAmrZI0DYyd1J9/Dg
 4J55MI5IXEHQtTERPbz5QWP7p3XQIbqanVCbVIfEkqfDakORmSYp12l10Lhw==
X-Received: by 2002:a05:6820:f012:b0:6cd:3fec:de70 with SMTP id
 006d021491bc7-6cd3fecf355mr3946278eaf.70.1789881676058; 
 Sat, 19 Sep 2026 22:21:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:48 -0600
Subject: [PATCH 12/14] bsd-user: #ifdef sockopt that aren't in 14
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-12-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=as+TrLfnMvgZhgHOVxzgY6vI9wuwcgF9aZAh6NmFKts=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20x+fH/PNnu9lckMoPF6RfVW7If/S3c20b/P
 dn5c2W7LZKJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAsnQ/9HCRHpJNcl/oqRNEDzt7iNTOw659iITX
 l58ZtpLXpJfmH2Bb8VG4At7Jv6giTh9bF6Tq6OB7o+XTYRGiJ9M2Too7/60e8fRV6HWYPm5gBah
 3nHuWUWkacVDxNLPRpYcQ9xqQKXgKUVlaABH7JqieOJ80T9gJB5T0SuIJ309113oRtTY1QFm4Lx
 R4Zse9nm98Oq9KB21pYXQfSq+XN1lv52aGzP3rhdHmP0y6AbWXqGTwPoM43pnvsm3C1DHlODee7
 44MrAJJhs2kSEBc8SFwFd76vWVzmDT6K6g2XN1j2+fCO4goVCEvHFoYIyySPcVUmrg37OgeG0ti
 w0aED3nsVNKcRW9Hhe+FZhPBRCAHomcA55H7Iotn+gcKnqa2JzaFkMOfqXLbMsFT8mLq480UsXa
 d/AGd5WUctbm11vRW9f+i9R8h2a39H68W88XowuSLaHFt56xnPyDjbHBb5tVi2aI/w4mCW38mg0
 UudVZFeZpUTLX3+k9yh6zVdiSlOEqBlmXP9Z/tQ8HQ/KGFqaymZi/VlRXEQ0rJygPi8Pahu/WVs
 4iyChx2qGsvbkn7CpXTH9ZaxGbVgLL6s4BEHuygj7guPna5c4smoDN/22/laVuZevwyQ5u7cCNv
 YV2p2B+hbj09lJb9qx0CIjLZgan8vJY/HENUN9FhBXYUwdPn2Q3E=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::e; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-sockopt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/freebsd/os-sockopt.h b/bsd-user/freebsd/os-sockopt.h
index 2f984cf8e3..55b678824d 100644
--- a/bsd-user/freebsd/os-sockopt.h
+++ b/bsd-user/freebsd/os-sockopt.h
@@ -281,6 +281,7 @@ static struct sockopt_entry ipproto_tcp[] = {
         { IPPROTO_TCP , TCP_RACK_PACE_MIN_SEG, { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_RACK_DGP_IN_REC , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_PACING_DND      , { SOCKOPT_TYPE_INT, } },
+#ifdef TCP_SS_EEXIT
         { IPPROTO_TCP , TCP_SS_EEXIT        , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_DGP_UPPER_BOUNDS, { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_NO_TIMELY       , { SOCKOPT_TYPE_INT, } },
@@ -289,6 +290,7 @@ static struct sockopt_entry ipproto_tcp[] = {
         { IPPROTO_TCP , TCP_SIDECHAN_DIS    , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_FILLCW_RATE_CAP , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_GP_USE_LTBW     , { SOCKOPT_TYPE_INT, } },
+#endif
         { SOCK_LEVEL_NONE }
 };
 

-- 
2.55.0


