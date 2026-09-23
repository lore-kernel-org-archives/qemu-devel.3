Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2995C98306
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9CKY-0006yB-VA; Tue, 22 Sep 2026 22:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKV-0006xL-Uj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:28 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKU-0005QK-4J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:27 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-8674704dab1so507229b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790129005; x=1790733805; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wxwz9AAXteZw5NGD+3L6DJYtkwvBwNDRfnnw995qavY=;
 b=ZCEx8HDvpKHIzvo6uMwPS7M45KXRctXgPdHUZ0uBio4DcZ2P5zb0xZjY8v+k3W0ixH
 Gq/U5AbGfHDAHKT2Vo8j/vf5LrMPu8Fs1WkFQFX2Pd9sliAoGeOtdEijU5HvmMrJRsf7
 fPh/iY5ma/itMxVNQ6KHTjryJECXu7WLX724y/XZhngsSpuSjrr0leJobFPFrujyqxQp
 I7ljCuExjZFFmdL/xql/sXdsoNta/gIUoQARR038N2rAR+V2xGqVUgJjBK5UfC0V2gvJ
 /Crb/NYr8Zq/NoRJVH52SqZslEreB8kp2IQNwKl9xxyfvglwDbVEro1hkhlFvKamikbN
 Y3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790129005; x=1790733805;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wxwz9AAXteZw5NGD+3L6DJYtkwvBwNDRfnnw995qavY=;
 b=mOVTPi2CCI2GILhBljIa+PtpzTWv3DfAWR3X0xDucQlDiwB1HjT1csTjvYC6mkyV8Z
 FBtOuCK8iLGeRvN/JUOfI5YjU5Dh+PLa47rmHZQsOyBLZMLRaNoWY/rgGCOsgLqGTHIm
 HMCbGBf8LZvnuY9nGsm8V2XMsjCTey6loU7RF7f4ltS35EJ1rbgk8VuNTyMweH4AXkyC
 Z0cp5N/ynfU/rNZup90ohRPjwpjPCg2v6KnmenZy2z1Hr7bAPLDFtJX6esJv/hguYRUK
 jHxK1n6evjka5r/t0nxZoKzLnTleI1apZ4uwokfWC9BSl6/Onu+R5mlLgUivsR2LH0xV
 5wcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztMPTY8744XdSZYfhmT3TRZayVzd7BJEYe/Ek/UM8tBymoNsQb567Xwq/uK45jfIvm654LdnIKz+fE@nongnu.org
X-Gm-Message-State: AFuF++kYIM8HPZolLGsUQ/6T5R1VW+I0Xme3lfnNh9xKLSgnVRck8d8c
 tCfyTlsAzQe9DbwFYhiuHysTetu7LNlhkmvFZYP+owTpFf0gqjdAB1jb
X-Gm-Gg: AYBFou2kTiUReBPwOeJlkBlFgUrdYOeUaISVh5RoFH8IOSFvPr7B+EeItW2sJbwB7MX
 1wmyadNLfjXW6ahFOvitmU6oO/iENipw8E9Ey835dWEFBSBBIo2lWr25m0LwWaj5dBiTu9JPdkm
 gXhvaxhd+wo49q7z18XKdAwLDyREaJ5+DJmq0FNjCi+wdn531Q6sRgYlsqiaV/TNeoXDHZLyHIh
 JJ6mMgx7bxqFuOBblSrXlvrqqB5tsjGgZAy4NlXF/RT6mSc6KERsTpYeAF/WZIyN2Iyf0Pn/ZSt
 Yx4Mpe+7buifWB0z8ULc8uaQAazpA8gKbfr6TolBvp1bBSoHK5F+YXS37FvG5FEh9/lUGYftcP+
 0v/AUfcD7WG8qwS83xb/ZV1ozLzS1zvWtvVLY/yKkF42lR2J/8+9MDSoIhm7xV5hC6QfEmVw1A9
 uhfpa3FJ7pVIj7g8QmD5URLoJbGHQDPjKYArWitZr2tpBRwamEMr6v8uttPa4af5tyRTpeCk8oA
 g==
X-Received: by 2002:a05:6a20:5483:b0:3dd:a00a:170c with SMTP id
 adf61e73a8af0-3ddf82bc563mr1385318637.39.1790129004316; 
 Tue, 22 Sep 2026 19:03:24 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3f0915sm299988a12.21.2026.09.22.19.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 19:03:23 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] hw/ufs: Support MCQ runtime interrupt and queue
 status registers
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org, 
 Stanley Jhu <stanleyjhu@google.com>
Cc: Brian Kao <powenkao@google.com>, jeuk20.kim@gmail.com, 
 j-young.choi@samsung.com
In-Reply-To: <20260909031146.1646684-3-stanleyjhu@google.com>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-3-stanleyjhu@google.com>
Date: Wed, 23 Sep 2026 11:03:01 +0900
Message-Id: <179012898120.22786.2623487845191822676.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

On Wed, 09 Sep 2026 11:11:45 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> [...]
>   processing bottom half.
> - Support per-queue interrupt status and enable registers (SQnIS/IE, CQnIS/IE).
>   Implement write-1-to-clear semantics and dynamically synchronize the global
>   CQES (CQ Event Status) bit in IS to prevent interrupt storms.
> - Store queue configuration for interrupt aggregation (CQnIACR) and completion
>   timeout intervals (SQnCTI).

SQnCTI is Submission Queue Cleanup Task Information, not a completion
timeout interval.

>
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index adae6639e16..4e22c31f898 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -990,6 +1004,38 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
>          }
>          opr->sq.tp = data;
>          break;
> +    case offsetof(UfsMcqOpReg, sq.rtc):
> +        opr->sq.rtc = data;
> +        if (FIELD_EX32(data, SQRTC, ICU)) {
> +            /* SQ_ICU: Initiate Cleanup (SQ_CUS = 1, RTC = 0) */
> +            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 1);
> +            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, 0);

SQRTC.ICU reports successful cleanup without using SQCTI or changing any
request state. Is the actual cleanup expected to be handled by the TMR path?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

