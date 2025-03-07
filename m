Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4488DC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdex-00047H-0i; Fri, 07 Mar 2025 14:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqdev-00046q-4d
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:47:01 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqdet-0001hC-Jz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:47:00 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8f6970326so16619386d6.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741376818; x=1741981618; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1QF7RN71KkOSjl10iByxyS8OBYmxEAVKrlgr4/I2y1U=;
 b=kej3Kmo9AlFVB9Yd9BMV6HfBKnRqHb+DeFiVDYhQQsBzVDokAi5ta5unRBq+k00w9F
 Bo3Yk8MJCsE/oOCAWPlAxYSi60qTi4bR9KKSHgSlhyRyi5GUyk+6touy8Ix5CEFFOWsk
 HlmtcN6aGNeg1N9prITQYIw+WI4HTxUIikN8dA2kBWa4wUW3FDb9czWO7eUIHSVz51kz
 rLJt06fM/sVXzyJYk/Qo0sOeFfIKvhIlsPIi18rLzNzLOvEgMoEwUzpGEySClTGZhRl+
 7j33ccOy6yyATF++5jy7sNdObT9t9Q9q5UYR1T9c9uK+bWNGm7nBBDDfM5t6xsY/6LhZ
 krHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376818; x=1741981618;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QF7RN71KkOSjl10iByxyS8OBYmxEAVKrlgr4/I2y1U=;
 b=akv+bMRCfzOHFI52XKcTMdWO3Gptw3XtInjr1RnP/4PeQRnC8GqsJX2wMzwLZ/QvFr
 BroO9OpVG5jX4PiQxNpp5WDX67kL9Gqe6JJHsZhfiwBiDjGK7JMU9fJMKq0jzNcdQr0B
 OuaD01ilEJg6psxLjzMYxS/Nrx1F0OU3SYPxLzlZDifOTrMEni60GZOVWkngf9PtVL0W
 D0NhpY135yM/49ArAyxsjpP8uSTTQLNzCqjZIPEiFei+ZEkN9XA87JHGJS0+pVWx3PCk
 S8fBdUk6ySU8B+MmysnZiX6ov4QzQ/IAzWW6nKzpEDvo/IPi2J8KHC6Gb7As+01qe/g7
 X9Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXV0Ru/WTk6V8+g4Tf7T1opgYEwQKjRDlbQkuIAVz2K0Aj4KWFDrtCyK9bKkklQMQOwRNzysir1lkn@nongnu.org
X-Gm-Message-State: AOJu0Yx5vZKbjk16+Cvk3Pp9oBO4Wj5kxiboeNWlYLBP2qFClP8jSEeL
 L2quVtA8crpBr3sHRtZD0wxe4GraxDkImwEG8y11dIadN4UUOeB7
X-Gm-Gg: ASbGncvoSgLRfzHT/PGWjiGtMjccg+e8JAeofrJkdJ1zO7gVfYZqfjs+Q+yBzlnFo4L
 KUTBAcFeJZaIOwuN4k+MfWVXUUoqvL7jRfFVQ3WO0WIvUDN+axdePtsRClkwg79KF4hBcbEuIhg
 QlFv2VeboX/4aDcxfIgmH9t/l3/A5YsKgu0GIkO1u5ZpvUS2rrLw5nbI2X4ptFArLN40SfMDMCV
 oy5pRdbaZoTRd/4J5ru2Ysd3hStG0xCv/PW8SPAyQZ67yTF8ZAf7G670ZGkROSdQxnvk7gKFdXg
 f4HS6qnB3w8TYpCt+71d5cbly4jI1g26eAUE8Q+EJgPq8AsuLV54Vpodu8lYufA=
X-Google-Smtp-Source: AGHT+IHwOIBJqUk0Z7FKsaV4zcFEXyCWnt0GwcbNU7hA4BpOsGd2wrfzoPxHJjkN6/a5HGyQJiyewg==
X-Received: by 2002:a05:6214:20c4:b0:6e8:f940:50af with SMTP id
 6a1803df08f44-6e9006b925dmr61435556d6.44.1741376818554; 
 Fri, 07 Mar 2025 11:46:58 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71709aesm22684456d6.116.2025.03.07.11.46.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:46:58 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-16-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-16-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 15/38] target/hexagon: Add handlers for guest/sysreg r/w
Date: Fri, 7 Mar 2025 13:46:56 -0600
Message-ID: <029601db8f99$b0267440$10735cc0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIcxVe1tOuL+LA=
X-Antivirus: Norton (VPS 250307-6, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf34.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 15/38] target/hexagon: Add handlers for guest/sysreg =
r/w
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> This commit provides handlers to generate TCG for guest and system =
register
> reads and writes.  They will be leveraged by a future commit.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 159
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>=20
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
> 2c5e15cfcf..488d0b4b97 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> +G_GNUC_UNUSED
> +static void gen_read_greg(TCGv dst, int reg_num) {
> +    gen_helper_greg_read(dst, tcg_env, tcg_constant_tl(reg_num)); }
> +
> +G_GNUC_UNUSED
> +static void gen_read_greg_pair(TCGv_i64 dst, int reg_num) {
> +    gen_helper_greg_read_pair(dst, tcg_env, =
tcg_constant_tl(reg_num));
> +} #endif
> +
> +

This will work, but G'regs 0:3 could be read more efficiently by reading =
from TCGv hex_greg rather than calling the helper.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



