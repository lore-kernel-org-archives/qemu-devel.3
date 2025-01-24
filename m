Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3414EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJ8x-0003t7-PX; Fri, 24 Jan 2025 07:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbJ8r-0003sP-KV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:50:33 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbJ8p-0005UR-WD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:50:33 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dbfab8a2b0so3954883a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737723030; x=1738327830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AB2Veo0ifNebcRcOL1ytt2gp+aiTiH3Sf5xY6qaSWgQ=;
 b=Jrj3n5pqWN8TDLirK0E0i8ju/e289V/TCmuHT0B3ttRL1DTDpmpkoVwHAOvn0xXyC+
 4bTxLnJwMilNZwT2U/K+0DuDjNVAxv+qhNcYcPWc4ck7fshOh/4Lz3ey/g9wuywKA6r1
 okbCE9gc4CCGCukDPlUSWse0ofGMDzlRJUU0C0Mzu7/HjAOFHBzoKjJHS+czvZk+dP0L
 2bFYQAs7WV7JK+7zS8FbwQp33LsodeUCQz9rUXvg8817XVq2iREXqy27yV3XB/8ML5HO
 pxqAI9WKESYUNj41OgpDfVrEni99MraC1t0nY1PdPA1BpsHx4AoRxEl0gCGFErbyXV3r
 EGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737723030; x=1738327830;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AB2Veo0ifNebcRcOL1ytt2gp+aiTiH3Sf5xY6qaSWgQ=;
 b=rT3BUWEiQNeB5j9RdtgqBqU++GteA48BSYEAn0HU/U0GyWmmZTLiBZWPJUGRG43YmV
 nyX2LZJPQzKXNZ4sPbAR3lgHs36dQECFJqcrpqU9mhvzvlVf9rU9liLoIxh7QTPHARhH
 jt3HXGPUqf4D7YLiHM1Iz413Q2njZzc0WH6lMCs9sIHV1vbHDuBX4YQqEjr6OjU3CdMN
 aaMPuEedZ0xITQpPOjuHHihVxWORLazLZ980owh9G/WLE2xT1WaCURHsjI0hM0FPiici
 wpAulPsc9/93e50f1V/eE0IrdKJ9lbu7suLITM6fODHpLMIS9s0dETLaARiAG58GWuCQ
 s6Cw==
X-Gm-Message-State: AOJu0Yy0cOrM91t4ORPpor3dx50ZGoaBpwzRsew9nP+HWv7xCopkgbKH
 qCmFqrtrEu28+G1HhgRlXFTDI96N/AO64PgV3Ndr2gixGH7isRXjeKi6BeaHXnI=
X-Gm-Gg: ASbGncunxkbS/fxuqHc9pmRFXU8i9yW/lAC7nzGaPGY00SDrJrgJHF5MhzSxQSy4L++
 tt2VVaEelZ1+v0+zADPXsZixfy74zLU3zapm1UfzlcXf7Z6OkyUVGhW3701nSDpvSBQqliBRefY
 M4u9N0lzBF8jKLFAY6KtcRgXcmAyVoQdmrvXlPgr4pCM+0GlqrQe0O7TFkNxgwQp444dcdmDZeY
 yCYemtVexD6hmi/HyTzKMoO+SRLxyJ+JPi/veAfZXM0H8Dmu6DqEChCy+VrcHALfQXRzropNXQ7
 5Jo=
X-Google-Smtp-Source: AGHT+IHgpCErm6J9FACp/DlMJmoU6m0AQvWBem6CobohmkoE2PSx9F3d28v8z9FWDQeB/0B9Gf2dDQ==
X-Received: by 2002:a05:6402:4403:b0:5da:b47:1092 with SMTP id
 4fb4d7f45d1cf-5db7d2f9b01mr25474703a12.10.1737723030120; 
 Fri, 24 Jan 2025 04:50:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc186d905asm1135005a12.79.2025.01.24.04.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:50:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C1185F8D0;
 Fri, 24 Jan 2025 12:50:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  qemu-arm@nongnu.org,  Igor Mammedov
 <imammedo@redhat.com>,  kvm@vger.kernel.org,  qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,  David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org,  xen-devel@lists.xenproject.org,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/20] gdbstub: Check for TCG before calling tb_flush()
In-Reply-To: <20250123234415.59850-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Jan 2025 00:43:57
 +0100")
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-4-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 24 Jan 2025 12:50:28 +0000
Message-ID: <878qr0jrzf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Use the tcg_enabled() check so the compiler can elide
> the call when TCG isn't available, allowing to remove
> the tb_flush() stub.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

