Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8CBC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9CKb-0006z1-4y; Tue, 22 Sep 2026 22:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKY-0006xn-EI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:30 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKW-0005QY-RC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:30 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso344944a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790129007; x=1790733807; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxQqf/3UfvWlo4lgLmckn5hKGSXbcultDjSk0robWKE=;
 b=NokeXjtZSiy3XbbbdW0ZvWliIo6m7OoAHRFb3KU9hoVno3koDclYF+0Es+O/cYj4LJ
 iyefnnX13DkoVduk7JMz80FT/E2M8Aln2pLLFBscP27zX329ZTECY5q51rGl+GWlDnAO
 St9BYKUCByVVtl0FWD5IYgCYEt039zUfUSrGrHvM6Jq3zG9FvdlFydA4cKvM4s8wu8YK
 JNbgzP3uzc6x9PbI4RCbWIGQeSqNXlPUHZEvFGp4+KPooeeZQYCPZVgJVCUp7fV7n+6R
 zgtcnZ3C1GTBITKsLZk8b+zvnvWQ2UqtKXj/8mTi4+5dScAslpyjMcj851RFp/lfHe+e
 wV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790129007; x=1790733807;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxQqf/3UfvWlo4lgLmckn5hKGSXbcultDjSk0robWKE=;
 b=mj0xYQ70KXzejd8m47h7E25Lv6XqavXOLlIlmBj7ieH51QndctfI/DU8UoUTnErriB
 s9w9fT4J+Nw0hcNSJF+QwkkOMgUASnN8+mIGdnVpOElZt/Lm396Bq4jR7Y1S0hcm8Uch
 0aFtLqRzWsWSc8mSbe2C+VC3rZgj5DfuWHYZClBDPQsDC/3SR1dlecT6uQ9QqU35hldP
 UynzQIl5LeR2e57R69kwFa1j0Nyqk/vYVPjnVtaH2GAp5TfxI8SKP1i6DC4H7Lt2pvCz
 b0Odw33Z9ZGH8SAi1OpJBssAutkOkdM/AbhUU+FCRzIgAG7yO5+QLf416up359uv49Sz
 tTmg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfYfYjQbwvzzrwUUBYrruTRwFBE1C3UYcy1En6Ztx4gAfb8t2+GgNH0Z0R7zeavIxFFvsONGMfnr+5@nongnu.org
X-Gm-Message-State: AFuF++nAVEHf51hzrDO1WjFZg67BR+5eJX2mP2NHp35U2uhEv4VS5/XD
 M862GTRyC9w8dYOAtBdrMi9g0ShoY7klMba2758lWFTVC/FbCVOB1d5N
X-Gm-Gg: AYBFou0RWSuVO2/yYeLqaNbra04mHDe9GNSoUTJn2JU5ql+Y1ZlFTbk68coj9uUTGLy
 NUXma1sqVFE+6cskXLgvP9fBEt8XPk/FJVeV+3lrDVwFiv+jHd53IoofnvqUZM5qHoeM4l8Jd2S
 sG1AuYM4/D0R30AoqmKpQWlCLUJ3bF6nbIwij/Psdg2Va8sAAtYsrENKnXTrSvuZaHF72njmKrw
 ky/pj8PU07vmtizJyFzJ25p2ZlsH6nT+1wawjezs6s8BNF5u1YpfrjQkBxbVrEkyBbK0zai/mm5
 17RgtWP0FuQyuP36Pc0Ku5ahpL56/+d2m76c42HaQcnMIbJIIu3+YVECm5A5HPUp5KUK+UHk0vN
 cMJA2PTdjzR3eE3UV5Dy0sdao4dDnGKq4H0br+9Cm7bVxXhjiNKLA+h2YcjXctty5rwlnGmxSot
 N7lMS9FYlH4mliV3O75t+wHXWQnf3n3TvmelHr+up/QTlv2z5+BeC2apaV3J52zzskX2/cSAD+c
 A==
X-Received: by 2002:a05:6a21:8216:b0:3d3:ae0f:5268 with SMTP id
 adf61e73a8af0-3ddf7e973d4mr1351824637.20.1790129006936; 
 Tue, 22 Sep 2026 19:03:26 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3f0915sm299988a12.21.2026.09.22.19.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 19:03:25 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org, 
 Stanley Jhu <stanleyjhu@google.com>
Cc: Brian Kao <powenkao@google.com>, jeuk20.kim@gmail.com, 
 j-young.choi@samsung.com
In-Reply-To: <20260909031146.1646684-4-stanleyjhu@google.com>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-4-stanleyjhu@google.com>
Date: Wed, 23 Sep 2026 11:03:01 +0900
Message-Id: <179012898121.22786.2441732317511194041.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 09 Sep 2026 11:11:46 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 4e22c31f89..ca5f6f2e96 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -818,6 +822,111 @@ static void ufs_hce_reset(UfsHc *u)
> [ ... skip 63 lines ... ]
> +
> +                if (req) {
> +                    ufs_clear_req(req);
> +                    req->state = UFS_REQUEST_IDLE;
> +                    if (ufs_mcq_req(req)) {
> +                        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);

A successful UFS_ABORT_TASK does not complete MCQ host-side cleanup. 
The host driver will next issue SQRTCy.ICU, which must post an OCS = ABORTED CQE.
Please do not clear and recycle the request before that cleanup completes.

> @@ -880,10 +989,16 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
>      case A_MCQCONFIG:
>          u->reg.mcqconfig = data;
>          break;
> -    case A_UTRLCLR:
>      case A_UTMRLDBR:
> +        ufs_process_tmr(u, data);
> +        break;
>      case A_UTMRLCLR:
> +        u->reg.utmrldbr &= ~data;

UTMRLCLR is clear-on-zero, so this has the polarity backwards: zero clears the
corresponding UTMRLDBR bit and one leaves it unchanged.  This should be
`u->reg.utmrldbr &= data`.

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

