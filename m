Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F8C27C79
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI57R-0001ir-7H; Fri, 14 Jun 2024 07:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI57P-0001ii-8j
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:29:19 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI57N-0004Gd-L7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:29:19 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6269885572so545470266b.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364555; x=1718969355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ffXCW18R/1vz/9nQeA71JaDuY+gli/4qmdXv2Yd35Yc=;
 b=p4uUkd6sRUIiNm8AEzuT89dEKOnBeJBi7HWXVVShv/pjpOkik0xiaLT6zzCQC7iMzU
 NPl7bpYRLR4S/MFODwlQ/SFcuGXzotNxlZe8Qf83AKq9QeS7YO1w6mOhlUCovJWmRV8x
 QrYzcsxkh2vce8ZN31NC2+asmhvwcmZfS3i60YUPSNvp5clZWfhx86lmf2wqFU6jnosE
 8giAZKnsd8N7jxiNMIiexuzkG+2cRuj0k1YrZTkFRYixzIRsR40F1LiR5mBG66oLDIKL
 o0thqw9XHApUl69o787Oby7dB36vVAUqkDdS+ORwcvNtuY4iFMDnDQlrve0yiko4cwjO
 VNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364555; x=1718969355;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffXCW18R/1vz/9nQeA71JaDuY+gli/4qmdXv2Yd35Yc=;
 b=tJgRbtvjSuQUPwxNCpp+0mAtTKt+bWZzOgXrlCPlTLO+X6Gt19v3OEDSe5HthhYLc2
 jlUfI977LsUmVkR5mzwWAO2b61eo4e86gV0j4MhiH581iYFW6RSuS4gL0+MRP/qYmJ0T
 ZO3mrWPxQvA+OAkL2g4uwHcYDQDd7y7NRydEGnMv2LA0+DZ7iTAtkpaAFKxrysSXL5AI
 vUJjdsEtArAgpv1YfXZi9kVeQMVUCTmkvUlxYOX3jrI3Pcmj8eBuD46eOlmhe9ATeaWT
 NZuFK7D405Ifl3VAPaBLAVY6IoKKQfQtGrXMryRUFiDCHtkT6gaTBUB5gU4qSh+NVI3X
 Ge3A==
X-Gm-Message-State: AOJu0YxoAbGiuDQPH6oKM8AHadsmjPstTKIkcv6KcvUzKfyMddqdo/f9
 i6anJAzgdMnyO9HaSqS6ANj7vZHkMziTDjwgNT6EvzVmKqTgX4IoVNqT55AnYSA=
X-Google-Smtp-Source: AGHT+IF7M+g86EpITWUpdJn6sDGPENvOIjXuCb3ELqqXYK14ZYL8SFrahCtvmlzmseHWY01AefhRiQ==
X-Received: by 2002:a17:907:b9d5:b0:a68:b159:11ee with SMTP id
 a640c23a62f3a-a6f52403808mr368402766b.12.1718364555001; 
 Fri, 14 Jun 2024 04:29:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa41cbsm175879366b.225.2024.06.14.04.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:29:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46FCD5F794;
 Fri, 14 Jun 2024 12:29:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
In-Reply-To: <20240613172103.2987519-5-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:20:58 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-5-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:29:14 +0100
Message-ID: <87wmmru5it.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> If page in 'ptr_access' is inaccessible and probe is 'true'
> allocation_tag_mem_probe should not throw an exception, but currently it
> does, so fix it.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

