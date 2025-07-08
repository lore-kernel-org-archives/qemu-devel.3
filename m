Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95330C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAl-00043J-Rn; Tue, 08 Jul 2025 16:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZDfg-000661-13
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:31 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZDfb-0004nS-4I
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:01 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso4228522276.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001676; x=1752606476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8s2rNFN/jZxhXTWPGudCAuRjedQaKyQ6f/2FmiPQW2Y=;
 b=ajpLy902p4JiNQn10TjWyou779YhPXVtkW82SG18fm3p/DRuHSzaO8/JuqWRryGeLG
 pp+ThTkj47D4lREY2Ck5oQmDwYY+LUW+y35GKzaMZrHp05x7vnaR7BDO2oh29y6n7r1b
 uKTuZMdscS2lrYUZh/MXq70RYL3RoRdYx2NJs7Ws5UyL2ILEm8RY4UbgDfYxqWCnvlCv
 7mFKIAbb/5bR0kB5aiAxPPcI+LebcPA/4Mn0+ObnkSWQst35ZiwOwyn+W8NO4gldGUzX
 gjAWnXJ5Y3VcMOLqD98z3lhyoj56P2u8tpXZ/2krM6qsYRAhLoIgC4zv/v32vbfEUPto
 9B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001676; x=1752606476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8s2rNFN/jZxhXTWPGudCAuRjedQaKyQ6f/2FmiPQW2Y=;
 b=MIXtK+E6Csj6/cSFdz3NPnk1TrFSOMsyLlbO7oAPGfjA2419PWmaYjJxMXVpW13n1j
 wK2lfx8gKDaEKevl/rHtvITPUYYkiDnj13KZ5JJHXRyNzops9B3L2dejzLp02bMu9e8l
 +sWvIZP3IVqyAZ17Dm+SWFuF/4v/cHhAxk6Fv2Zxq62vZeVgeJsqkoNjNJH5llvRHQHx
 JJglrNIMf+1G97FuL3bYgthmBjhIwfEuBSb8oowrzziLtUm2X1Yjuv0grwV8RSzL0rLB
 13kl8PiXewWNDVsLH/9CWSatnBKGycPpga1aQzauUWVUZq+Pi9dA+v7IonwI6y5h3nXV
 7fww==
X-Gm-Message-State: AOJu0YyDL13+MC0wbsYZTc8lZyte9FMhIxfLmiVdm0qPpUZtkNxDmzky
 gzUs2XVr6mho2rBS1oYHzvTDha9T0+AFUYTBWYx58glc9IiXPOT8i7GsNKEMaNVjKJBiE8rFQFs
 VeVdvI+ffggkDE0GVEaJS/rADNJCecgOYcyOl2QAaMjPpJUKnETCy
X-Gm-Gg: ASbGncve8syPUEypv/L89wuhP87+zZaXxjiGiimmmQAfPOQ0fxmg1zRALLn1uwa+eS6
 fURFeTq6VYnhk8YaekkyAvZIkrfUA/shA3Vl54bwBffGSsI12Dvy5ynRnxuc/T+2QCdpi0Rhm/6
 j6yUyySkd+c8x5FSduk4xXnwV5dU4n2JBXQnCfUB8AjPXk8ocTWsyZpQU=
X-Google-Smtp-Source: AGHT+IExPFh8eTlGqYONtLjdF9vAhvac5+cAfCfiK7+4OOlMC3LT537uiA0z29+ItIWJx+8BK3IdGGKXQis4hgxcDQ8=
X-Received: by 2002:a05:690c:490d:b0:713:ff41:37f1 with SMTP id
 00721157ae682-717a0431c1dmr60423057b3.29.1752001676439; Tue, 08 Jul 2025
 12:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250704223239.248781-1-jcksn@duck.com>
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jul 2025 20:07:44 +0100
X-Gm-Features: Ac12FXx6fAS_admgraO3LLBLl6gkfZ5m2oiejxzSW6SjwpxOcP3vK_6D6L0PPoE
Message-ID: <CAFEAcA8ONjmXYsfSfVLQEL7DiPpS-N69BfJDNTa8fuosui_vUQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] MAX78000FTHR Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 4 Jul 2025 at 23:32, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> v4:
>
> Spacing and style standard changes in GCR SOC, TRNG SOC, and AES SOC
>

I've applied this version to target-arm.next; I expect to get this
into the 10.1 release. Thanks!

-- PMM

