Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A99C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9o2-0006Oi-TZ; Mon, 18 Mar 2024 06:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9nu-0006OI-Mf
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:01:15 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9nt-0005Cb-7g
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:01:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5649c25369aso5526009a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756071; x=1711360871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaY19AtTlZO7Z+9h2acjgNrAN4NSvw1wocNGV/SFOCk=;
 b=c22OZDoHgBBjlcL38pNZZrn5hHxFib4RRAOY3v7X/By566RfP6lCGqKpQm0fhxGWjq
 5VfyTVRRQCWydbj31GdPIYYTxfC/FuLbATGx1ySVQykhZUZeriqi+gIagn89Nte5UAib
 /brZkpuSP34UzUg20v5hvGhKPubrCFR8FIHgsFK2lvkgjsyCcOVJBnVVSiQRQgEV9uNm
 2zYK5CM5w1/x83uH+gTdL5sl9BeKDW4fTi/WgDovN7hNl0rcaFdLtcvxggbRfAHH4fQk
 JYOqdKKnyn+BrtzBgJU+AmamLVcP/afx4fVpoM85ejve9joCKeQadr/doLE8yF+lOyWs
 N3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756071; x=1711360871;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaY19AtTlZO7Z+9h2acjgNrAN4NSvw1wocNGV/SFOCk=;
 b=Kz8nHIUNaBXUVefy+ijCrI8wlbNWVVP9YasV95/ql+xsYZAn2FkxuxB7DPxANL+CjW
 0hOUENvEONa3yKffNVcJCgVALFZSUh+9paZk2zW3EiJHQei2FolP/oc0TqMcqOgX59Uu
 UcrrCvM63RCocP/VosT8uM+TD/JnSAdY6X2zUOftqScNlDT7EA17UYZgZ2w7qEegUVZW
 M3Z2glZq92jEOL1Ld3UVkPpPU4JLViQqA/EKSPyEVXiQ0ZUfkJj0oOcfvqzyVwhdpz2X
 UzCNsJPKpggeqiTSBOAjxv6yJBLYqi4AS5IXr4KXU+9dD7rDZUb8SqpnsX6d3+r9XP1B
 5dBg==
X-Gm-Message-State: AOJu0Yxqm4UBe2lHroBLg2Iek4XEasOkRIgGITdr1zPdFZZLN/XWPlp/
 DRycnFFFyvJ0KFOv3hJkXsuxZpO38Vf1XVkCkcjACB16wk2v5IASySy3IjYt7iQ=
X-Google-Smtp-Source: AGHT+IGmTgDKbeNfqNmynEQJ4DyJVZa4u8TSqoRxzbVdByrEha85EglzqAsVO17RKB4Nnzx0B4XsCA==
X-Received: by 2002:a05:6402:3706:b0:56a:2b6b:42cd with SMTP id
 ek6-20020a056402370600b0056a2b6b42cdmr1503414edb.3.1710756071221; 
 Mon, 18 Mar 2024 03:01:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h13-20020a0564020e0d00b00568b163c4easm3306731edh.11.2024.03.18.03.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:01:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A8645F88C;
 Mon, 18 Mar 2024 10:01:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 02/22] tcg: Make tcg/helper-info.h self-contained
In-Reply-To: <20240316015720.3661236-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:00 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 10:01:10 +0000
Message-ID: <87o7bboo49.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Move MAX_CALL_IARGS from tcg.h and include for
> the define of TCG_TARGET_REG_BITS.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

