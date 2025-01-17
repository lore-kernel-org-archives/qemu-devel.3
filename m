Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921CC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtn8-0003yY-Hk; Fri, 17 Jan 2025 16:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtn6-0003y4-DE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:22:08 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtn4-0000WN-NG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:22:07 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5da12292b67so4190672a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737148925; x=1737753725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf4qxlBszTl5uWUziL/BAAofSkTZ5DDNEEyqH9IcavU=;
 b=EeB1SPp0yct7KA+urzwTlLIIDJ+nMwtAdlbi2iJIJcCbtycIwq7DbC148YK0SOytlb
 9N7diTjIb3Uy6EIgEJNMoU904lHVu9FdxhV8MqEc43BMl7vQDDMooGGvUYyJMtfuSiej
 6JrJtekFfDk83ZAmIrOxXT6uXqs10LYaMdRSF0e1EI0+PM4JXNzmN9cR9rK+4oEjax0K
 ggNtfgiNHg3fmHawWEYgrw+Gm99A3yftP2Yu9pY7q3oB0sEXfNTzYMz/KOgB/RQaFHqp
 PW3sbnKSBNKm7Fe0Ekj0pL7H5UMmWM2Ws9n7FkLUgeVaFGj2h8OHuDZ9RciJKXJURMeR
 45Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737148925; x=1737753725;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kf4qxlBszTl5uWUziL/BAAofSkTZ5DDNEEyqH9IcavU=;
 b=rPT44FXUatxyl6KKFHapwe5UqbKgmjmgbmJN01nZ4Z/3JquknE2c87OqaIzADDyLRy
 Cn6bh0sB2axMSDWdwdIIUVeYd7k8xiNJ2T8uYh8ngLYrKh2xzh1ZoB5rrxq+IZZqrAd4
 R6KG6bcYIe3PgMKPm/sojGQOx+QtCOnveesCXF3jUi6OrAWOv4VkhXbnDz8VT52oHU9K
 2Y7pNZ3TGoFvZozSlifkqX531sKGnkeFrLPHHby6yxGbTX0nkLA+XADTR1XBvlEYQoMF
 qCrKnr8z+bWOKNiXPuU0J3TS0VyxlCwBzOzm6roM2ddzY2FiMWxwUqiPMRvtpc4bTjEK
 wdeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyJZMVBNbDjFhAeiNQVDeKF8NWhu8u5L/0u6CflIRx24s0jQMrVkoFprey82lLAmA4Xuhsl3uvsLe6@nongnu.org
X-Gm-Message-State: AOJu0Yytg2HJE/4h3dWgp6TFYwwawcBaDRlpTmoYmVjYBWV/Wfs0AJMj
 DHUgsUf7RlntoWvq/Fyaq4rTETgKeLyypm/X/WdDMVD7l1KklrWV49IBmKZ5L3UhP2RrucdaDZy
 Z/IU=
X-Gm-Gg: ASbGncuwj/q3EJ0QTSNbz9P2Bg0o0rANy7AVeifv6eHQwmugV2QDrgD1BFG3gYZr2+/
 lS+wiVFQ1Crt2hqDbx5fqOupbjH7+trBqe+ejZH38axD/gwBifIk4VIJ+GRdC/P8pJAjaWLHUAS
 1l3kXkXM8qYyRios1SZ0d1TQiYDFXCZtVeXu3KY7aZlRyoVZKNQcypO1erGbDHvF2fquNza/IXY
 cIdVJQSxe0mzkzkXGcWv8gZDQI/1yGexHmiARwGsi/Wiaavd+S/2z0=
X-Google-Smtp-Source: AGHT+IGaAoaCXZVdfiYQW57ZdjKMAOpVO1OlFfdTNjN+/+6p7feVM0LfDm4fnQFeogRviwtZLpnT1Q==
X-Received: by 2002:a05:6402:26c9:b0:5da:1219:c81 with SMTP id
 4fb4d7f45d1cf-5db7d300633mr9807775a12.16.1737148924990; 
 Fri, 17 Jan 2025 13:22:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c60717sm231525266b.37.2025.01.17.13.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:22:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C1AD16083E;
 Fri, 17 Jan 2025 21:22:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v6 6/8] gdbstub: Allow late attachment
In-Reply-To: <20250117001542.8290-7-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 17 Jan 2025 01:11:31 +0100")
References: <20250117001542.8290-1-iii@linux.ibm.com>
 <20250117001542.8290-7-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 21:22:02 +0000
Message-ID: <87v7udm8zp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Allow debugging individual processes in multi-process applications by
> starting them with export QEMU_GDB=3D/tmp/qemu-%d.sock,suspend=3Dn.
> Currently one would have to attach to every process to ensure the app
> makes progress.
>
> In case suspend=3Dn is not specified, the flow remains unchanged. If it
> is specified, then accepting the client connection is delegated to a
> thread. In the future this machinery may be reused for handling
> reconnections and interruptions.
>
> On accepting a connection, the thread schedules gdb_handlesig() on the
> first CPU and wakes it up with host_interrupt_signal. Note that the
> result of this gdb_handlesig() invocation is handled, as opposed to
> many other existing call sites. These other call sites probably need to
> be fixed separately.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

