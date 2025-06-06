Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2CEC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNa1S-0001qQ-Cx; Fri, 06 Jun 2025 12:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1uNa1Q-0001qD-QE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:34:24 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1uNa1O-0001Yo-Rd
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:34:24 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e7b4ba530feso2091629276.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749227661; x=1749832461;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTYAh6YODEp15JDlSKfe9dGlhRijyGcVncG62LXwwSo=;
 b=sv8aXDTWZ8h96JI2yiQE46kQFv/776mt8/ItsNoOJXSC5Q63bObC7VEdZ1QUFxYspC
 fiKTKLAJPbrGz3oe59HhuFc/MmYkwZEStlFbqBs2bKGieXNOBlyldEHh+1vbHwqX2ig9
 wyA7CJh8mWRdW7EpIIXQWxLMkxclaYuTOvG0gUNa0CZCOh7lvuLSUD6NpB3fb+UvaFNL
 VV2xWy7iyT0FIR8gPP6KkQcIQBiyy5A95KO/KdjXzLtYyXdls3xUyCM6csgacd9oHaQz
 uXNadu9O4K3YfjMMmKp3Ax2LbFkCf/Q/5pFdLfNK2f71Vkd03nocUNN4NoViQ3AgWxLf
 cIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749227661; x=1749832461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTYAh6YODEp15JDlSKfe9dGlhRijyGcVncG62LXwwSo=;
 b=ZWAEkQiAKzdizs36XpLltaATUFqeaR680pfLPon9TdiWMkbbY5+16nzIM/kvMF4fEh
 yJC4c+yjnCxfUrRXNex4m5UPHXu+g+CwkJtABhK/EIQ5SI3SUmqzEOhFcjHB+vH/ZcPc
 3cBABj9Wqd7txp/9l/1wMo1/Pt3TxUJzyibdAc2LDYcdoehGDqlcj+bjTJs9r3rXIN0h
 y4Qcrws2xnLxQGNBR9+TjyZIocKBUteqSUeLtGp8WzoqKM8sBQdb6Xl27MD7aZY1kIPZ
 nJCZ61+d+UBJ6OYfm0YcsYjbavTGTk6B9bbY7O3XIdEBasUJEFgIkC+UuwkHqEjb//QP
 ridw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5gz1Uj+yoHRMmhs+WP7of7907b33Vy5QRI5ApAl5eU1apIlzCgBI6dQcvdXAAnFRmd9rRMkeJMBe9@nongnu.org
X-Gm-Message-State: AOJu0Yz83aSw5TvWkPWxqQdOc/3ghjiqJzlEnfL/XOGR4qp8ulRPu1te
 O/AAXmUtyVbS/U7Y6XlEeyJdYE54bE5mbY4MXqfAAC2+K63RcYHPEVVRkqJ/X5k/I3rgo7kOjHl
 FTeJ2dJR0BSddTpGjt6Gap7HNpJLVb0yZzmbk/sXwrg==
X-Gm-Gg: ASbGncvT7V6xHfGOrAYZQ2O7PgWzpzjxCvQT/k5+4/stJuCBWul3j1EbIO+k407cg21
 Qt/LnTy6tEnbINQ2xbKCuQAx3o3QQ/ANXbrD8JmIcV6QyTyfumQOaaauNKsFdMb74b2oev/Ixiy
 dwALSHLfIak+soQ3U23tX38lFKbqhpooL1sA==
X-Google-Smtp-Source: AGHT+IFneTSlARfGZH4zAt3VwU8P/d1fTKkriQSfSc+O7whvf/O7t6i0BPcAlKMm5vsKlxaL42kqOPwB274zK48/2Fo=
X-Received: by 2002:a05:6902:124b:b0:e7d:7310:2d3d with SMTP id
 3f1490d57ef6-e81a2332f4cmr5476588276.33.1749227660713; Fri, 06 Jun 2025
 09:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250605142126.1939798-1-alexghiti@rivosinc.com>
In-Reply-To: <20250605142126.1939798-1-alexghiti@rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 6 Jun 2025 09:34:08 -0700
X-Gm-Features: AX0GCFtsDnJEUmovKNpHqwrtbW-6bSm0nVxINJjMDhj0dIDNLOsOtMofkacdXis
Message-ID: <CAKC1njSo-C=H1aJdKGLvWjH4kTj3oAp=JoRo79E6zWsggfvFEw@mail.gmail.com>
Subject: Re: [PATCH] target: riscv: Add Svrsw60t59b extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=debug@rivosinc.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jun 5, 2025 at 7:21=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
> for software to use.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

