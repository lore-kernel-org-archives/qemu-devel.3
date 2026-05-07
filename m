Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E14CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtOz-0005TJ-7F; Thu, 07 May 2026 03:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npickito@gmail.com>)
 id 1wKtOg-0005IY-UI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npickito@gmail.com>)
 id 1wKtOf-0007ks-FZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:50 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so836634a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778139827; cv=none;
 d=google.com; s=arc-20240605;
 b=eOItCbEMY9OVZZKAy4HIc1JnXqtcdP8Xzsy02KT9IuIzg6HPC7bNlcauBSNuzMlyC4
 kiTeLqqI3OKzZwN+MeGtrBBwt90jlrjqUQWG18V7xebOxxW/o/dN75AwSWOfmSAqVmb8
 jvooGOqFr/yIsb9FzGbW5OvKHZVuUREg5fQL0WH4DfiDB0S6Nd5mNLkHFJ8xs9Z5jcvv
 7OOCUl9+ZE09wvT92RMbuwbXIC3PbZh6X3nYjYHbRRwJQ1NkyMhYjAyDhLBKwfiS6aAw
 35zVM10ptWb0SCu2iZWf6IqQTri/hort2jTdRTliat0RVli1qijlHf4IKlas/5YgdOOE
 iONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+G/eOW1a3NVhiF5Lz8yvuXedOpZTOjt5RaGeZVkwIko=;
 fh=CgATFaH4GkFfW6AwWoX4jVQvgcffpeNYdjkncG5m9kM=;
 b=lKOlM8//SZBQU39h+Zjq+N0UT9pHQYEdAto40zqzoxttBdWUNKsM9rQ0PaXive8fZ/
 iQR9Z25zTO4CNxFUmOjJxFM2ubxGGK1l82IQbMY1K+EooDAKPVqL0SMuQ7F/Qq1xXz0O
 XiLy1IvZ0QSRc1GAhxHQF+2e9ax5KScHg3xj4NchZarsyG7QTGGZr0Pgit4X0w/lG+S1
 ZneWU/5Hc67H1f9zn8DYlAURiLzwRfp8gM2MJYSD9bsCbEX3gt6Jb844dTWj6vAhjy4o
 EGwSw6HRlHDA9SQBwYXiMEmiKGUZav1DE5POpx+OkItuwuSUR9RluVh9T9VSCUOwmBg5
 uJkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778139827; x=1778744627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+G/eOW1a3NVhiF5Lz8yvuXedOpZTOjt5RaGeZVkwIko=;
 b=awwma6o7bjIapjx92tyPReUR+QgwJBzKtpDDS6I2f+Wje+UfsXFDJ0rIKKiNjpRLgO
 s83jlFCs0z7AJ0Xgx7JbK3v8kQjXS/eRCKNiO7o4UzgiIiL8kCMqO5AsAIUmzpealTkI
 NJmrskhB2CEZJOD5RGexCDRU0Ptm90f9GbVoSzqDrdrO15q9PgG/sY1LVGKZKsanjMWS
 1zjO+ug7r0KpHvv6i9cc0knAfG4t2P3MwQ5RHVLh7bT2GK0ya94vuKzHn/0IGSD8XJqJ
 Rc4k4uQASKtrcjqhnrgFxhlCqEuZD1jUotJeOiOctuYWz+ypT9rjctEI0jozWECmiMv4
 TZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139827; x=1778744627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+G/eOW1a3NVhiF5Lz8yvuXedOpZTOjt5RaGeZVkwIko=;
 b=hikBGtSwTD96jq8uUxBkV9BeVAAE0yKAosBO2qgWU8k5WC8urWGWvV5xTYIC/7szvA
 3ov1Z8iRkEm1krPInb/RbM0qdm6bSCi2zDpFNTOuQSuZG3k8TKQPqilDfjIYhWiSre2Q
 L17hVOWUXOLB4w7YuZ6mGRI/y7gY8E/hlzGfYC1Z6QbH2MqR3iQ1VAcyKiz7/B5ggHbm
 yM9AQ4AP8sYNeglM4ruTIXCMurUozMRqv4WKQdDVPZcEBYQkWnD5mF98kssa4iGHEdiY
 STJnwEoizJsZd9SM+KOkbgP/SOlf/LP2gG/fKdZ7V+irSdWMo6wHsN6uYO6VFZiqOflr
 ssTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ96VQ/ltOJ1wyJJcBxKcrpgrOxYm9LsAI9ZG18T9nGu76wQdguRarS0UkH4VGF1BRNuGLNLKW/RaElS@nongnu.org
X-Gm-Message-State: AOJu0YxdUSXue2qfVf633TkG+KaZ8UNgMrxX4ZfHfNREh5RdZuCigvuR
 0nbcx2FZQiW9nTYwGe817AOLiVsMYsw+TyCpRCOfmzbNYuqKT5+0pOTS7vLCN7jm5yxyUaHyJOh
 sBNi/QP43Wum5uBLB5ZImySAySQowJrg=
X-Gm-Gg: AeBDiesowewOCc+Dlq3if7JB0Q2Cwf3b4RwtuRm+Y1ZImqzNZVwN+83vHRf3jwnYWsa
 YBO0DONoAmEnw4LNM8iM/MAVgrIdbqrBo5Plo3SMhNtgckGO0heJT3hjLCwEWu6jhLdfdth+XSO
 LNGNg2LoydNbdZPRW6rcPx/jOninMCGBDbloLhVLlc+99e6cG3vBv8VtKbWO8prILp1t/JnE4QV
 EIh76Av51M1UAGgPoBMQr3+Pc2EwUMhd+on4TktcF9wtQ37yjZ6E54hkw69KgyaJmWaagzNKlNw
 Yl/YZAU7/thP8M7w+rxlrIVBNsx9Ik8=
X-Received: by 2002:a05:6402:3046:10b0:670:6b0f:f77f with SMTP id
 4fb4d7f45d1cf-67d645babbemr2577049a12.17.1778139827116; Thu, 07 May 2026
 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-2-xiaoou@iscas.ac.cn>
 <336c0c4b-af67-4cb8-91f3-704348124f55@oss.qualcomm.com>
In-Reply-To: <336c0c4b-af67-4cb8-91f3-704348124f55@oss.qualcomm.com>
From: Kito Cheng <kito.cheng@gmail.com>
Date: Thu, 7 May 2026 15:43:35 +0800
X-Gm-Features: AVHnY4IZk1fLkbAkUZfMebcODcxyBVpyqKFhoRrmmssKOF_W32YUjgSwBNoykwc
Message-ID: <CA+yXCZDgpcUZSgy2bSnch7FMw6YmJC-8RTs=c-GcckSddGkP+g@mail.gmail.com>
Subject: Re: [PATCH 01/14] target/riscv: rvp: Add option defines and
 dependency check for packed simd extension
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=npickito@gmail.com; helo=mail-ed1-x52f.google.com
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

Hi Molly:

> +    if (riscv_has_ext(env, RVP) &&
> +        !(cpu->cfg.ext_zba && cpu->cfg.ext_zbb && cpu->cfg.ext_zbkb)) {
> +        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
> +        return;
> +    }
> +

zbkb should not in required extension according spec:

https://github.com/riscv/riscv-p-spec/blob/master/P-ext-proposal.adoc#p-extension-for-packed-single-instruction-multiple-data

