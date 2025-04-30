Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uABMa-0006l2-5U; Wed, 30 Apr 2025 13:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uABMW-0006kB-Ci; Wed, 30 Apr 2025 13:36:49 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uABMU-0008Fz-6t; Wed, 30 Apr 2025 13:36:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so306639a12.0; 
 Wed, 30 Apr 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746034596; x=1746639396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j2q8O/EWgoOFRvMJ7pH770SWjqONmQgQTlZb0EdmaXw=;
 b=Um7hUNpEKxY5/VdVCodmp/A6TkKmNL3iYl9AHmA/RZoVcDzJzFm2cYGkUhCF1yVUQu
 YdfAgkRUlfZf3cm2HwxSObQQ8r2Mv1gBA4SGjPMYmZ2L8kdfBdSE9Zy0J7V5oKAROqyL
 EDpjzFdT46OY3IPacNmeRbpo5ViqIJGBLzcwWKrceXmyHXUaNpDIG7NQJ4pOhQDCizIr
 J/8sSVXtYgHZFosyfDzb9ToK938LyyxiNTQ12/Q6jxn9Gl3/oTvl87vLmiqJlNyR8u2z
 o7hgAN6p91b+kOqt2EcsYDsar+ym//w5lfrC6CwWqYG0ZALUju2CpWXlLnBGf+gK1NYL
 D6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746034596; x=1746639396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2q8O/EWgoOFRvMJ7pH770SWjqONmQgQTlZb0EdmaXw=;
 b=Z/eIvic85PtMajnEghO2/zEfUgBUylkLA9L+iwwTPi+akJ5pyCBPmTr62kQZK5iPEY
 J3Q3qwF1fLI+g4EkL6iRLGRQQEW7OeX9IwVWOEgAAQ/dsoGw7bTQ5CFuipt/KnIcxI9H
 hiOC0E8LqxevDTn74/EE/bvT9SR92fAP7iMQPHeBYOLmxH3TQIy1gynP5f1acojuT7nL
 wuQ0yCZnWhgr4/lKXHcuCY6tzeG8T0j1q0i+dLbH4yqYs84PzVSPHVaPQ94ezaJsySHk
 d58kJv8r5oQAUkoznbnhz5tMtBkKTP9bBgkHuG7ZlkB1lPCODsk0p0w1GbBtExuABDxq
 tU6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTRUtFlYVPjZJPiWKRdCk6biAZ4FrDIn/vEx1306tR/V681Qmk4LJqJ/1LijlFXYFmjGj7tFIc0Lmb@nongnu.org
X-Gm-Message-State: AOJu0YzqhsDfk1qJPeB9niMwVcka5m2v1gtB9lU7QrihEeE+bubLxRU6
 8a7Ysd/wkyEH609LeUHhThaXTR/2qQi7fIidttIGB4nsmAebtnugr8GqHl1IReTTyaNzIuqm4+d
 2tzwdDEksjU0GILVm1iBlmiaYVAg=
X-Gm-Gg: ASbGncuVG5kIDpLM4PXxvccITFA3azy1/0kFj6csXPk1/ttQC8Gx+phL3Szn8JRF/Tl
 pTpXBGma6p0lnEvg1S6Vv26Qc1k7kx2VxZwPmATFmljtLReNMSDwwOCpeKInL7tGZuEWOgum7k9
 vfId/ircFCPAJLbbmomStW
X-Google-Smtp-Source: AGHT+IH0L4fl4EUItLraxJ9tgs080CeF9GmZzEIA8PilBUhYkxst52IHoN77njQXbdmDXPiIJbyyw7mwG7pfyu1AuuA=
X-Received: by 2002:a05:6402:3208:b0:5f8:3645:79c5 with SMTP id
 4fb4d7f45d1cf-5f89ab661ecmr3624824a12.1.1746034595942; Wed, 30 Apr 2025
 10:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
 <5aae8743-0fdd-4664-869a-e7d22f40c016@yandex-team.ru>
In-Reply-To: <5aae8743-0fdd-4664-869a-e7d22f40c016@yandex-team.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Apr 2025 13:36:23 -0400
X-Gm-Features: ATxdqUGTgN7Kodb12I6Ct77ekjNF8hYlwZwO8ldvMCRBuoudO-XjKCikfdQoKmI
Message-ID: <CAJSP0QUHh+wMC00dhJ3_fyTbDyyy3qH_jb21-_mW6b9gpn6VPg@mail.gmail.com>
Subject: Re: [PULL 0/8] block-job patches 2025-04-29
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

Please take a look at the following CI failure and send a new revision
of the pull request once it passes:
https://gitlab.com/qemu-project/qemu/-/jobs/9884338000#L3671

Thanks!

Stefan

