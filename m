Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B0C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUky1-0003j5-54; Tue, 30 Jan 2024 05:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUkxp-0003ZS-ED
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:03:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUkxV-0002qR-7z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:03:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ae2d80b70so1777620f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706608990; x=1707213790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dr14j43hgwSmBhhg2Tg0pSKom3e5w65OKMt7jIndMt0=;
 b=uIK3cwfRCMRjq/peyqNJ9TzGYgU8TYhwiO+xmR1uS3LcTCquOq3HitldNpJFD1jedg
 e+fnC0T5LoMFHIfcSYET/Zd1QzVvcD+5vNQaRpcqrn9PC72v1r8Yla5zMS5uvIFr+LkE
 nDGIubsme66o4ONBA1ElMlyd0XwmnX1vLSkYlRoXh8T0YB52fItZqWn+VDSCHqt3OMEf
 BLcbYyaeIZN5JYohsLkd7Xjd2en1cI/c5tp+h0NRB5pVfotUivBqFAs+5HtZDaqTZ2gI
 Of1cfUjaIApHWcHTTZteeIAlw4hghUQ7ZGfXXT/I98dkG5l9IVTNaz30IWN0AjCqfqoj
 EAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706608990; x=1707213790;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dr14j43hgwSmBhhg2Tg0pSKom3e5w65OKMt7jIndMt0=;
 b=TSHevSJxltXnXQ++3qd2jZen0GRXfKE8niLheDe9ShHUkSMX90RoUSv/BONXZHMyz4
 NqIdHXN8RTtBt2SId7NdHfqE6PSmxZ2mTpcqZX1urBoZN4N866zFee4csURowcTRAsXk
 n5QAL/OqJdGGK4TxYeV7RI3uOP/W8a2RcboB57p5e5BR2OFR/pIUps92YcF3FeoaZhJ7
 hKQcshQr/Yjuh3t8rCPdvYG27W7/lndGSQVolfdR6GSKq5zch3U0NwbdwIh3a9f8QwWw
 Wrt9uNGAWV9X1SFPvDj1gM6N4q0o40F7QLuw26dPMK9SxasmF8WLDQVHHh+FfWYvdAHl
 G7Sw==
X-Gm-Message-State: AOJu0YxBevVQmoZIXbhBysAE0iJEP6A2Z2IpbvQXP28M7DlQLCqCY5zb
 IqSAjKImmCef52yngkoQ4Yvnf9IUvXTACD+9ja/hjQ7Pfxpe6I1TGl4PD7e/zaM=
X-Google-Smtp-Source: AGHT+IGdyaoGquQslnWseh6lcNyQZXLRidFfx3VP1JwqdUiEOMA/ql+Uha8+T4mmRDkQkOV6ANbs6g==
X-Received: by 2002:a5d:4d49:0:b0:33a:e613:79f8 with SMTP id
 a9-20020a5d4d49000000b0033ae61379f8mr5288007wru.27.1706608990180; 
 Tue, 30 Jan 2024 02:03:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bk7-20020a0560001d8700b0033addbf2d2csm9821485wrb.9.2024.01.30.02.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:03:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 47B485F9D3;
 Tue, 30 Jan 2024 10:03:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3 3/6] hw/arm/xen_arm.c: convert DPRINTF to trace
 events and error/warn reports
In-Reply-To: <fe5e3bd54231abe933f95a24e0e88208cd8cfd8f.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:38 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <fe5e3bd54231abe933f95a24e0e88208cd8cfd8f.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 10:03:09 +0000
Message-ID: <87h6ivqgte.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on trace events should be able to opt-in to each trace event and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into trace events. Errors or warnings are converted to error_report and
> warn_report calls.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

