Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0DDCA5FD9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZ2u-0005YE-V6; Fri, 02 Oct 2026 04:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZ2t-0005Xy-Jc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 04:55:11 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZ2r-0003NL-W8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 04:55:11 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so4408906a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790931308; x=1791536108; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eSGpC8XQmdbamnXdistzuML/uapsz6yodjinw426Eno=;
 b=Zkv+Hc6bs6na4WxLH5f2caOZpdBlJweH2kVnfRcLY+XNU+TUn0UjFU7jML4AubbKLe
 cA0zexCoJdueZe+QqwrnGzFLMcyqDtSWlSEVnbCVJdrFyggkAt6mozdMdAmt42moJESx
 zqkfenwPuk9QZh4zKL5rE5yj3tc6KC2ODQzFAxJH4b5HU5Dhozwr1fn0jKLwbvkPEcv5
 BKm94WMK1tkz/GWn48e2RSCyxk0+ej72qGapKWFTfzdu8pUlPtHJF9TcU3+qaquL5MuU
 bx1wWes2Q7pkcNpw324lV0Wj6b3Bre7eVFla9MJtreWMCI7hL8mi4T5+svdnsqTvTXfD
 B9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790931308; x=1791536108;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eSGpC8XQmdbamnXdistzuML/uapsz6yodjinw426Eno=;
 b=fGxTagcZeyo3PzPkhkOTzacLj32OEpyfYb235vF+LgdYC5MdM/+dCej9y8vsAT2sa/
 xBo18jSuemIyQ0Kre+mMq7hIK9Gi+QE7MBTWT/xoiea4VfGXVsB6igKEC40D8JzM3eft
 Jp1jvkX3Y8Mdku1jZPBJINx0HrErsZ6ZW5tCgN1ZnyY8gT9LYcnkKQgydWFZy8FVHb6f
 +aXDC4hGJEOvEmCwdtE4Fvqr0j75T3/suDGuSuzC/nyzPalKU8A+M3BtXiFUo6IWidRV
 CYUMyj+i+FiOcB/m+GPZtgWItwW6v8RWe3bEIo5bJw35UU7hv8ZvXdbDK7jW1wd/nG/Y
 C2Mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIVknwt4U6Myc57u0mfB9LD7kP1lEsJL54W/pNmRM2lglgArNY+VRCDKOtJ2wn+/TbMapJ1C45MHeg@nongnu.org
X-Gm-Message-State: AFq9FYLJKPW1M/rH7oFox1STY8eK/nW2Ip8B+R7BZCg1dkSirBFvdXRz
 5nMbxxdWsxYoEuH/VYavmJf4BEzRwm82f9IjQ2S0u4iXAj5ZLHWyPeTP
X-Gm-Gg: AYBFou2OWCuH09bLC1t4txDH1SiPmD49iiZv5VOXVXMUs67pmVKRVUJxgZZGOl4egO5
 zWHffptjP5jCxh4sJZl/pqhjdxjSE9sTs1zhh/WL10fHgelArpFqHkt6osygDcJC8UEr7aFqL40
 ghGaYtrvKNaZXYTFO/wmTTF6J7Hdx6SRmKGpJbEumgPiXqxaOs7emY2r2sCh+4Sczop+NbmRbP/
 mRT13pKrOmjSDevQYdRegi0oAAre1OvnMJphUu3G2/3EEK66xckOudSVBfkcVfpVsZYG97j7RDQ
 APPuw9TFiZ10sGExfz3m6z7RAh8uaRdw578qNNieZ1IplQgziYmDOYq7jKmS9qRPCQxN34Pvl37
 ffVY9b2iau/2ix08A3CqSc4Qtqo+8qWZRn6ZZeqve9rY85Ou84puUzSZmMm3zvzA3MzxBpCreHn
 CH/ufW0LtYTXrT3IEb6LNJlhGyNC39h4T9dU8nSTjdYX/TYfAePijyI2hEHB/Emb5RtHg6p6RUE
 w==
X-Received: by 2002:a17:90b:3903:b0:39e:261:4e0d with SMTP id
 98e67ed59e1d1-3a6ce75d5a2mr1882637a91.25.1790931308213; 
 Fri, 02 Oct 2026 01:55:08 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6c97e5cc1sm3180999a91.0.2026.10.02.01.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:55:07 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/3] hw/ufs: Support MCQ runtime interrupt and queue
 status registers
To: Jeuk Kim <jeuk20.kim@samsung.com>, jeuk20.kim@gmail.com, 
 stanleyjhu@google.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, fam@euphon.net, 
 kwolf@redhat.com, hreitz@redhat.com, j-young.choi@samsung.com
In-Reply-To: <20260923144911.2877141-3-stanleyjhu@google.com>
References: <20260923144911.2877141-1-stanleyjhu@google.com>
 <20260923144911.2877141-3-stanleyjhu@google.com>
Date: Fri, 02 Oct 2026 17:55:00 +0900
Message-Id: <179093130014.85103.8462033204202020267.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x0f.google.com
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

On Wed, 23 Sep 2026 22:48:10 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index adae6639e16..4d8c641b078 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -970,6 +982,45 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
> [ ... skip 31 lines ... ]
> +            (le32_to_cpu(req->utrd.header.dword_2) & ~UFS_MASK_OCS) |
> +            UFS_OCS_ABORTED);
> +        req->state = UFS_REQUEST_COMPLETE;
> +        QTAILQ_INSERT_TAIL(&sq->cq->req_list, req, entry);
> +        ufs_mcq_process_cq(sq->cq);
> +    }

RTC = 0 reports successful cleanup, whereas a missing task must be reported
with RTC = 1. If no request matches the nexus from SQCTI, this path posts no
OCS = ABORTED CQE but still sets CUS = 1 and RTC = 0. Please report RTC = 1
for this path.

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

