Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387DCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZ2x-0005ZM-Hn; Fri, 02 Oct 2026 04:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZ2v-0005YN-KF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 04:55:13 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZ2u-0003Nb-4y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 04:55:13 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso5314090a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790931311; x=1791536111; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kFI9Ipqv1IK+Q3kUm3eyssgZyz91uoDIhybbVmztPkw=;
 b=Hr1oUhUZr3nG4/p3yW3JY6ZqgPZEh3Zj+sko0mUvoKrz3bJAeMEj0c6P+hGZGy4gcE
 e9ko/tPQBrgA3vroHMJJGc60Ct5WU2LnB+BOHf+9O9uyBQKJWfjWxBQwFw9sUYzN+mzy
 xRxuQCIpUNCIHuSuIUTZ1Z+ki1A/hPju51qn/7wJQvtvKkBwjrqPb5O11akF8fNi+9TV
 OdGhrMkG6rgK1q0OYgKnvu4mZ9GMhcd7sm7yR3D7JfIW+CK7HFJ/ZPHWd/NmvBjwQa+N
 iugtpd9kPuekaA6XTSb2j5gbEcy98SpcG6+k11NB5iqMB/vMnNjy4Wlhf7Wn8hWr7Qrn
 +S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790931311; x=1791536111;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFI9Ipqv1IK+Q3kUm3eyssgZyz91uoDIhybbVmztPkw=;
 b=y+NpW6n4dfXNxV06hI3uqGzYPPrxNdqB6tqieBpBv7i/HCDLQtGXIyeiky8skVaB0b
 QIWQnn/wEwBKcIXiXiRMuU+VYR/JM5UdciosKXrw5F28mNWxFqjXmEqAONSsLbuR1BBz
 vXj8G577mfXd8nRJ74F+5Aiu3OGcKgUxeqkylar2Nc1LRRP+PISIloD6GKpMoLQCXMhG
 hDpcfItrBiB4E3DtghcAAJtk6DfUi4Jt8rtt6QQeGYPdKNmUMFRQDoB10WOVOjEx4BlW
 r2oDJWnUF9jKd09sEgf+NmSAoSuc80PXKMsAFqIG4shrUWeBSmJW0VtVhbkOTl68IYhK
 U7iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSh5VD3u1RwhQz6P6dExhPUbs3GYmumrV0VNOQm96AbKBPhpTZf1VRgWm7uvlCaAM62nqhgpgFykR9@nongnu.org
X-Gm-Message-State: AFq9FYIenIzTIi8z2eneSBR3nOLNpdHmYItI7M8+G0V0Z6Jp8CGplOkw
 tzCLFQangp6StzIDtE4YOn7ciEefWQrwvdfCDj33SywsRJs4bQUB231A
X-Gm-Gg: AYBFou2zGcGqwnqB2Dn9u3d07EO8eh11J/Y3Lldnqb2q40r+aKvxKdtY17IP4y7dZgm
 poTs1dKG8mWxXx8DnED4VKws0KTwFiQAyp37bQbNGAnWPZ7aPEQ6KRhSg7+50sD5eoPOlHjQAJS
 lOm8VWLi6pPKpn4Qalvu8MG0B2GQ1GjEiqVma8xRrChKayhAZLAAIFeLnDwM3iAd28ShCP3MFI3
 7DyLWDe/h2uJ+lMJ1RCCLQbl5I0xEHcYNV49AT74iWq7cwu9JUmv5IAfS7VNbnnTbecyz4u7QG9
 ZiI6j4f/P9a5LBZiP+yMUiaEXCjN9jzbFpBz4oXqaRjaMCoVKupLZ/T3bZwI7c+Z4z1jT6IuU4h
 +WNB3Rr+IdP4kTMUCbA/395Us7zhSPBztW5J1kcg3crHLbHay4dmZdsi0niwn4wozvw6vdpU55R
 RfZafyuQaOPC2IwZ2NqZ9EsOI14HeKUV/FyZdOm/OEZW0GYI5l/A4lc/djnJtuOFPJvaJeIDKPo
 KSU83tWFYjS
X-Received: by 2002:a17:90b:33cc:b0:3a5:25e:85f0 with SMTP id
 98e67ed59e1d1-3a6ced64d02mr1974231a91.56.1790931310646; 
 Fri, 02 Oct 2026 01:55:10 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6c97e5cc1sm3180999a91.0.2026.10.02.01.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:55:10 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
To: Jeuk Kim <jeuk20.kim@samsung.com>, jeuk20.kim@gmail.com, 
 stanleyjhu@google.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, fam@euphon.net, 
 kwolf@redhat.com, hreitz@redhat.com, j-young.choi@samsung.com
In-Reply-To: <20260923144911.2877141-4-stanleyjhu@google.com>
References: <20260923144911.2877141-1-stanleyjhu@google.com>
 <20260923144911.2877141-4-stanleyjhu@google.com>
Date: Fri, 02 Oct 2026 17:55:00 +0900
Message-Id: <179093130014.85103.5733803911053837491.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x10.google.com
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

On Wed, 23 Sep 2026 22:48:11 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 4d8c641b07..336bdb8718 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -819,6 +823,119 @@ static void ufs_hce_reset(UfsHc *u)
> [ ... skip 92 lines ... ]
> +                UFS_UPIU_TRANSACTION_TASK_RSP;
> +            desc.upiu_rsp.rsp_header.flags = 0;
> +            desc.upiu_rsp.rsp_header.lun = desc.upiu_req.req_header.lun;
> +            desc.upiu_rsp.rsp_header.task_tag =
> +                desc.upiu_req.req_header.task_tag;
> +            desc.upiu_rsp.rsp_header.response = tm_resp;

tm_resp is a task-management service response for output_param1.  Using it
here puts reserved values such as 0x08 in the basic-header Response field.

> +            desc.upiu_rsp.output_param1 = cpu_to_be32(tm_resp);
> +
> +            if (ufs_addr_write(u, desc_addr, &desc, sizeof(desc))) {
> +                continue;
> +            }
> +
> +            trace_ufs_process_tmr(tm_func, task_tag, tm_resp);
> +            u->reg.utmrldbr &= ~(1 << i);
> +            completed_mask |= (1 << i);
> +        }
> +    }
> +
> +    if (completed_mask) {

UTMRCS should only be set when a completed UTMRD has its I bit set.  As
written, an I=0 polling request can still raise completion status and an IRQ.

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

