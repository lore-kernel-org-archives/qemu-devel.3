Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6748E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYXr-0007cC-0F; Tue, 17 Dec 2024 09:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNYXe-0007NV-Nw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:27:20 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNYXb-0004SP-FC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:27:18 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso866290366b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734445632; x=1735050432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQZXyPf2Lcza74qCKe4Z9IkJEWWCzPGjiV+bXL2PGtg=;
 b=PDkgQSTvNRFB5Ol/9BfRmGECAPFpJME2JNwst1w60bjIr3dmEu/FfU/4HuOw3BQ0rk
 5pIA26q3pMDsuGyAYnisXKaHBv6OLLPGs9tiyjLUz2MWBS+P1ODkrWmN0wwojOGoxdR9
 wdp+3qOcc8ORuvsp2S7/rp9MiA+aLDOZbeSNor6uxdQxSO1/Lp1Z3XKbvS3N/wo5kUUk
 cXo6ku/SnlNyYEnhfvjHoUQhA8kXe3dTpVqULgGQGHxcTtFztHWzeRSB+r4Pp922uwH+
 l/x3AYoF0qC1kI5RJYUrJurp9yGFqmP775H/5bgNxFzu4CjessJcDSOb3V53EyiU40DB
 UJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445632; x=1735050432;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQZXyPf2Lcza74qCKe4Z9IkJEWWCzPGjiV+bXL2PGtg=;
 b=qD651LKFOs4HjUVKLgeKcpw1cZ4Tl/WUD+GahgwssQ5yy2GnK37eyQCAxmNrS2FRdB
 v52Q/NqIsygvaDCcvDY/9BsqMAixyJcqI7ZYSDWqymx88r5I2tyTaYJhFidO4TQA4D8u
 nj2NuDEYzYI7jwhrz46EaoF7xEWRvHgT5ubA+7CRXizDpGNccCSl0myww4uzDEofVQsj
 NbNuO2a/8er2xk3EruMEReFlbCjdVvXVIS2xmphQXqPLzFZPekIoPjWdKv/FW14pm6X/
 A4LrHljNztKl/C4R1Zf07wsdUtfFUNK3HOtezCA8TQoZShr0rmgClLQqRZFkptz0nVxm
 zzug==
X-Gm-Message-State: AOJu0YxXhDOe5R7E283CUChCB5XBxW1qh6VDpOrbP2KCaMlu/0SKYQhH
 9ahTnVfJ5yyFmrToqx3LbX873okLyrX4XFvkZ41ffq0xOxB8i7tqP0Yi5nIFugo=
X-Gm-Gg: ASbGncsmtI0OU/ePr2ApAEOC+wXE4HrkQqqQVehMdtMIKzAtju4ltFsT2tQWqXtY7Zw
 c2rkdLdtG0SelOogkXlscWQZaEPGYD5r/d87fIEXMRViTf36LsJhcUudE7PdkLNYbaETZ4E+YAh
 xVPHpakHvvm4NyD94vumZ1vOAOstcpvwB39YqFrhNeUOB8nWQXR5x3VK8LwI0BVvPpy2YXaGAmv
 GyXhngQmtF5VboEaxaF4UW+x3EdPKAPbGrdB47fPHeOxKkLSMpU5xM=
X-Google-Smtp-Source: AGHT+IGb08K8CxEuiIlAJRafI5atEJBVnlcNqm8747lV2yCiIlv7c3FWcJFJGLaNwfawa/TAsU/1ag==
X-Received: by 2002:a17:907:9491:b0:aa6:84c3:70e2 with SMTP id
 a640c23a62f3a-aab77909e8fmr1967591966b.20.1734445632257; 
 Tue, 17 Dec 2024 06:27:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aabcc677867sm186640366b.47.2024.12.17.06.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:27:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A44AC5F953;
 Tue, 17 Dec 2024 14:27:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] accel/tcg: Declare cpu_loop_exit_requested() in
 'exec/cpu-common.h'
In-Reply-To: <20241217140648.98538-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 17 Dec 2024 15:06:48
 +0100")
References: <20241217140648.98538-1-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 17 Dec 2024 14:27:10 +0000
Message-ID: <87ed265qrl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Move cpu_loop_exit_requested() declaration to "exec/cpu-common.h",
> along with the related cpu_loop_exit_noexc(), cpu_loop_exit(),
> cpu_loop_exit_atomic() and cpu_loop_exit_restore() methods.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

