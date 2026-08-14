Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE0DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuiQM-0002kX-KV; Thu, 13 Aug 2026 23:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuiQJ-0002ju-3u
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 23:17:35 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuiQH-0001N1-Kp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 23:17:34 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81f36179d72so8564017b3.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 20:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786677452; cv=none;
 d=google.com; s=arc-20260327;
 b=XtyLkIYD7gtoj1bQAaw6k4tyqwsp3USzJ7OXJPpWk4V5UfNtG8amja2o2R3A+npFCu
 sSWUGWH3cgJUHiFao8FpUY05zLv3kO+ZX/43zrmRWw4593ZcZ2JmXaiueSfQCV6L9h4+
 q4WTPvvw/14/U6coGBX9/4gbmM+WXlpRJM8b5sIVuRH7hMc/sYeLgqbG0FvmlaIleQp/
 ReE69dP6wW2Rr8AgCPzTAsVsick+c1nyWU+tGsPS/Opsf/IN3DnLWAJpM6b9FYjtQJcL
 pUK0ZDyNNPdx1jPZZv/Gi5rl9G/apBJjTJijNDOTSW7fsU9Ggaxgy+oO36plM6HzHQdQ
 nF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LAo5Gy+mb3KfoeHG45swKeR0Q2XMDagQYa4jkeN61nQ=;
 fh=haLNj98yzJ7MW0dFw28W2yq7EziWkSgrkndTeabeQDg=;
 b=sSZ/mG/d8WqdzDPONZOC/furjuf4qhkdKlhEuYPlWaiLJ+8LWBKiZcIGWPyq1flH9k
 LEWvJ9cyGF4zCFCXBaiDAzmcqV/5JqHzkE3e5/LQYQrYs+9Cs1Nl+CPr3Nm3xKT7I/tZ
 /cba1izO5Yu4f/mXby1BUEHbDT712IufvND50GUc02y1Qy8Vud77IgJ7tKC699n8toxg
 dpo8pNf4aREAqG+JI+6mAwR9kvNzfzFOy535gt825XjVWKyuLyx4neVY/9qykKtC4TUI
 JcaQ2wTnxr5JhpxHsUbdQKMIhk6Gj6uVjl77zCsjP17EHMfj6uKKblA71HdUjaI8SjR0
 6vaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786677452; x=1787282252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LAo5Gy+mb3KfoeHG45swKeR0Q2XMDagQYa4jkeN61nQ=;
 b=F4+5oH+TlNghwTbsQUv6+w8j3deYtlorO+ZENv5AOeEHhloPy2ZuuAVf5ZiQmXsqBO
 P3W07quU9fmNOtjLGNam/06FJ4QuCrE6kDPmU/DmGvOwR9al7An/ztuxGvVCcxKzm0MC
 Y+bh/pKSzn2Z5b476aFxK8UiauulfftSKrzanF4bNe7CznTRz6Q7e1vekUyXpC+gobfg
 5rRdnLP8Mgdgi65nlDRciohSJSho8sj5c2igDNNqvCXER1xJ1plfBcKl2miQUEcE7M1p
 OLjEmRN923jG7jihYBKcs4u+D3ocrh0xv1szvbXFiw2tCLQfxLeFBem/rNJ4vPKv+pEi
 7b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786677452; x=1787282252;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LAo5Gy+mb3KfoeHG45swKeR0Q2XMDagQYa4jkeN61nQ=;
 b=CeuT7GwP3hejY26Z2zMszESNeJQTqU1eiBeyWCYQ3ZOGp605f8Ki3KGadlMlalJsys
 oiuNDM8EkSUZAjInsoK3ax+uAYzDmHAT7FTXFHPBNpPdZI8iYFggROoMmsAvL5NbaA0L
 LApH/r/ffzEidNqbNG9XNS/LL4r2uMOSzuwiMgNOi+XdB5qTYVaV6Orjdo8Qn+Udd2Pl
 OS/6Y0MaTRWbbI2pQdYDAE59ZoEy9uC1ZsH5ciHxJi4I3S1ooWkJqj5UEXg9r20zfWUI
 9PelAoiSqZMf3U0kVy97yjazh4azA6m61v9ndA+CJC79SiD0e09cjFLKpJ7aTySQKbpc
 WbrQ==
X-Gm-Message-State: AOJu0Yzdoa8Pqjvvuw+79gIu4r/YArtM6+fGMGR4uv82L3Drytt/FBxn
 LJLxgykiIxUeH+XS4o9+id/co0TM0KaXQG3ZYhDKqk31C5vONhUDtkVPbO5iQX9u0sYMQM04IMZ
 D+UqXzEVS+BYwp7IBsy1KWeuJe2AsaUWELa6xLpJEyg==
X-Gm-Gg: AR+sD12yrTtJYoyegSTM+igCDOzyII6rlYLJIg/lnlcC/PgepClWXhPUHxXrjlfYRzJ
 B7s9hgrWHAbP8664qijHB0Uvdak4frBGtYyitI+Pw7hYHoe3YgTQmiDEoslHAkmG8/jiWR9JScG
 gvS9PCYgmHa72xZnCrB9ZrbL0icCpb4t45Op2SYjGuSFVqAfRIQZcjfvv+VwRZM+EtuUH81oSJx
 0ANZRqhainQH3Xx6TLI0uNYWjHToZsoVk7vHnpW1bJJiN8xQ4V4Z/iL3U38Zv6lLtlc+7ua/fWB
 zUueO4ZTVZy+NMuOFaXx+ds/uEJT0mRCuYItUBm6iZN66g==
X-Received: by 2002:a05:690c:c3a8:b0:81f:49e1:1f03 with SMTP id
 00721157ae682-83712ac29femr12092307b3.31.1786677452302; Thu, 13 Aug 2026
 20:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
 <20260813135717.2758-2-flamboyant.h.01@gmail.com>
In-Reply-To: <20260813135717.2758-2-flamboyant.h.01@gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 14 Aug 2026 11:17:20 +0800
X-Gm-Features: AUfX_my9ql4fyazm6jdEDPv4jN8X_4o_k1bPa5PeyDwWtGM6LR9FpZjDyvzSI0I
Message-ID: <CAAW0U4ZRqfcNmWi8davsvu-zVFmq4fJgbjjESb+_As3vPnu7jQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Junze Cao <caojunze424@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi all
Kangjie Huang <flamboyant.h.01@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=881=
3=E6=97=A5=E5=91=A8=E5=9B=9B 21:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Add a SysBus model for the 64 K230 Function IO configuration
> registers documented by the K230 Technical Reference Manual.
......
> Suggested-by: Alistair Francis <Alistair.Francis@wdc.com>
> Suggested-by: Chao Liu <chao.liu@processmission.com>
> Suggested-by: Junze Cao <caojunze424@gmail.com>
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
  Hi all,
  Just to clarify, I added the Suggested-by tags for Alistair Francis and
  Junze Cao in this patch just based on their concrete suggestions during t=
he
  public review. Neither tag was explicitly provided by them. Sorry
  for any confusion this may have caused.

  Thank you again for your suggestions.

  Best regards,
  Kangjie

