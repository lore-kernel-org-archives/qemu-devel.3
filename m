Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F254DC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmt6b-0003Ol-FL; Tue, 25 Feb 2025 06:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmt6a-0003MU-9H
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:28:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmt6Y-0002Qv-LQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:28:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f73e6ed7fso1941193f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740482881; x=1741087681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtJ63S4m52FQjL8V9SEdJUf/oni7GEfE5fqT4tTxkk4=;
 b=tPabZC740hUPahvrXWTw1el1JdJO7M/0LFgHF5CXVBQH1OniJOcCAt+s+DxwF4yqpW
 z86UgKrbeuHa+9x2Kgp5/9dx/GhwxNlGA1hhVO0/RFMGsgX7qD1KADwsetMq1m7kLk4E
 BXM2e/j4KhhLhpCeAKllgp0z+Az/18OthBKMrwGeXLiXWmgUg+9yeLhW7HkHCAwnOGTD
 eKD3AeNLPoL78/L6g+W00T3GjzOkgsNWuziAqNY40cNSlvjCRXkRQRmODZAi6dfdbz+j
 VU3/I6vAbtmbsO0pZycPlcUJQlbsvACQNUtEflZYd5vxFUb2P9P7ov25za45nuFAgBeZ
 Keyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740482881; x=1741087681;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jtJ63S4m52FQjL8V9SEdJUf/oni7GEfE5fqT4tTxkk4=;
 b=Xdpuc5T1cqD/JS1njDVw8TuMbvJ0QJIjzcSY7HMf2HaXSe0Yp+oeCbLm5QqiGrM0Ga
 i/57H3pW6DwDo2NaCZ5F8IHcSCur10N5blbgUAz0J+KghJFjuSsuQRHFabCDPY4nPiAn
 rGvP3LaRunkfUk1fxXuAWosV064XNpzRMO0+41xl6B3o20CEyagq1oxExkz1Q+TxocGX
 ZM6sMJRnN1lKRgYTTNxO5HFmMG/9XbwdGdt67VZ34AVLymSnnU/2rf4z4k4L3d0sCHqU
 xBKMOP15qzJlDqqenDdLaoOGjkPVrGVKy1eVoSl7jUqjAhAwvUSKB2ZgTsCGfwwFXy/r
 TP3w==
X-Gm-Message-State: AOJu0Yy7HJS6549Vh5CXMvzeCzz+32q9smmpvoLqRaKh1zawHOma4cyh
 QAQkcDLXrP0Za6Q6HUtaa0zAWxY73ZptvzRgNca49LIzTEUAMu7/XewvVEM6dagm8job084buqJ
 0FgM=
X-Gm-Gg: ASbGncvn9LB5fN73B6n5yN/tcQGWALvVRqRlpgGwgTt0fymifjIENNBFjDy6nNKF2Nw
 V5DEFaH496JhAt3eihu71GbeRR1EcZmynn5iJTCPJ9sGP641NjwEQtltE4hT/Vgu6oqG14c+e6g
 S/U//v3LpSOTQ8NjAYXEM1zE5BZXJiURa+AdCTNSoakKxk82Oq0QR2sPp/0chxWdgUbDRxDt4lr
 LUjoMvkyE9Ad6KsslCcUBJkMpn33KyClVZLdgAuFvSySpp5f9FmXdqGiuZI4W7EWdvs79+Qj5QN
 bwGY6YaR7sjqunncBuDNL/3Jshes
X-Google-Smtp-Source: AGHT+IGmWGKOE7H8HB2nhP0PszMQP73UWSbWU63J/HkDKv+6Z7IDXn6EqWC4sI6zm0zGcecyWVkP/Q==
X-Received: by 2002:a5d:64a2:0:b0:38d:e078:43a5 with SMTP id
 ffacd0b85a97d-38f6e947079mr15188157f8f.13.1740482880976; 
 Tue, 25 Feb 2025 03:28:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cc26sm2004991f8f.30.2025.02.25.03.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:28:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0A9F5F7DC;
 Tue, 25 Feb 2025 11:27:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 03/10] m68k: reset vcpu after it's created
In-Reply-To: <20250207162048.1890669-4-imammedo@redhat.com> (Igor Mammedov's
 message of "Fri, 7 Feb 2025 17:20:41 +0100")
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-4-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 11:27:59 +0000
Message-ID: <874j0i6z7k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> Reseting vcpu before its thread is created, caused various issues in the =
past
> for other targets. It doesn't cause issues for m68k at the moment but
> to be consistent with the rest of targets, move reset during realize time
> after qemu_init_vcpu().
>
> That basically prevents reset being run when when vCPU is in incositent s=
tate
> (i.e. accelerator hasn't initialized vCPU yet).
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

