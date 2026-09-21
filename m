Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94BDC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8j-0002XL-DG; Mon, 21 Sep 2026 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8h-0002WV-NX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:47 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8f-0002hF-Iz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:47 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-8138dddb94bso316067a34.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986044; x=1790590844;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mKSAZ6FBzXteRc983sECAUIs1x6XG4ddUlM3LYVt+Xo=;
 b=GwJ50/k/p7xQ2i7JnSbdO3xmAoS3u0Uxc0U8WynONHVI342m3dUycyIhMVci0dVdF4
 cBzzt3IyxNiPrwlMw5W7WWtUYBc7VQ4N+AS57Nj5+AkZjaLPeoSbE+mg66y4mFO3Dprp
 xZ6jMG9lNKIVaf5N9XChEOat55fu16p+fPgfpNfJXCNeyJB3ZXN/w9FFbQxR4KlP9Tls
 sD160VUkwb7VLPolS4OMMrilD3czHH1D6f2JFMYszCSQUxki01m/0wBJwonyzugOYfMi
 ZPGitnAlDs8g06bDSD+QXCGrtgDRg7MtMz1HUYGQhyBu6Q+fKk+WB0HhJnl+x2SvKAEf
 CgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986044; x=1790590844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mKSAZ6FBzXteRc983sECAUIs1x6XG4ddUlM3LYVt+Xo=;
 b=F5tGCH+0tbN4DqSY5/3XJy/htqwvTUdLaMRqu9CfqNEEG91A75ApyDGRtWOfQ76CRM
 t6I/VT539EY4s3h9Irel8pK62y2PD4ba71QzZxDBaQkeKAS1wBfw4SUlqvUZPGbsF7Bi
 KoZwU3xXra0wwEQMoF5Z3R+oY50E8kCqQhP2i8GJb6g2hz8s7J3PsJZpGZFlL/2DUvCw
 je/wCcGcvMdmq6/DN5yJ4DB5oE7Zb3S3jj1w+FyOYA/yn7OjBlzpidaJcBFWnwXEUCHE
 PwpXCmbl6cz8oFm5RgBeEylPWBBcK+vszpCkRqvPSLBMCl/4s/rKiT4wXcipkDCcruDt
 3/nw==
X-Gm-Message-State: AFuF++mMpBpAL44EL1U/MYW5rA3J+upzpU+8GCRei5G5j9ap+dRbsyNx
 /Gs13H6AS7mRTCSj7vimSHMF4dD9Wsd0FooQokrbS+PpsQLUUQb5lZGK2A0zHln+2/zoITJ1Vnd
 wOHsYyvo=
X-Gm-Gg: AYBFou34h4HdS1RnYnclCvVHndNa+IP7D+O3hZknZzQvFOXzpQHk0VG83/JBs1HpOtc
 LnTUUib1f6mP+FBBrnkY9Oh2UOy5o57rq70NYPZRIW5I8JjypPQAAFBS+RmVb4T3lC1Fz/JIw5k
 dFf/ANYY6QmTFtpB0zwbcvcgMZkmqMCazeAw60frvhHLelWk4yTTVyeDy/nRRiJPukM4K+E7+V8
 aWraGYPaFjStrQJK/5y0I9ZwHKm8DM8Q2hUqTNZ+rQiMMla4hegEHeHZNpyyT1UxKjmAAR6VqMD
 rTLla2WNgJqZhRRCTSyXC9HRnxgqQMUc5xPMhOAcj0fjJcyzk1Rb774NawSNGHxKVUU+T3+/5RF
 R1ee/KBCY9FOszT5eLMpGcDuGHEYx+uWcxLxi8yajCFWfUPb5q9wEjGMA8ddjEh05h3Uf9J//TW
 GEA9yaKdPjANwU9F5xXFZDpGUuRHWe5ehLsRL2zXizzytv6dgObyJdMqAAaw==
X-Received: by 2002:a05:6830:4420:b0:806:dbd8:9929 with SMTP id
 46e09a7af769-80de199fademr11557446a34.15.1789986043771; 
 Mon, 21 Sep 2026 03:20:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:52 -0600
Subject: [PATCH v2 10/11] bsd-user: #ifdef sockopt that aren't in 14
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-10-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=as+TrLfnMvgZhgHOVxzgY6vI9wuwcgF9aZAh6NmFKts=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTedJR83J6C+qdl2tKBDo6ZukZX1+csOTZ77
 +2jRUm2hfOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDe4hAAnZICareFYIGnWbmt3SNCKFqg+oR11aJ
 yRUJGGJJ3uGB67WU8jFHQedlrV3/qgkIIvHkscx++pqgNNxwxz90bSDQ9KRkrv44MrYzQoBN/PZ
 2avgiIw3GJFBe+13mkb2xRFi1mjj8wltPmRTTzO47Omxc2o+2HGivzj072h3fZzWdvGY5d0k7f+
 WqXCjFpqh7bJn/0jj9ivnM2Xml0/p9oByRu38gxz+VEC9y5K4B3+vT9dN6YkMkbaIdjzzMQIArw
 GdwPM4/90k6WXyBB80Yyn2roDbpv2k3zx2Cl+yTb/9HrerZ+jR+rWa2j0sg8uQeo6c/EqY45Ck4
 DIsmSQ0OZUR3xRcPCiZanf6j9DsNY+uw8p64R5xuYrr5QbgIbJT0gz6jy3ZEHI9bBZhyCXZPaZo
 8Kym10bm+JhAYMVocdPgjt0LHhcakq/cTO1coxz7kLhbjltlcoTtEcHqJO5vwaLKnxJdXYeb+yP
 YbA506i3XecPy7zIGVSdR3jO+O3ISidQHpE3RLRVfWjQooLpqQIJ2Fkk4FqmjjRUZQBiBc3NpyT
 LbHU3DD/dpAl8SlD28OD1imkNil3vItqSfqrj5Wd4oz24ie6i3/cS6fZ/LTNuqNKuHHVvYn2z7Q
 ECRENFkzqRWo+bL7DKIew/U02kG4DkI3P98oOPCc3J29XD4EVRbM=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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


