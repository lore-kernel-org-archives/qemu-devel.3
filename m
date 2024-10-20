Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B829D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 19:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2bkO-0000pC-3h; Sun, 20 Oct 2024 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2bkM-0000ox-Cg
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:37:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2bkK-0001Rx-Ux
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:37:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so375322066b.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729453065; x=1730057865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvFdx3DM0sYJp01pVvhNq8L+693g+/1//XNAAq1DiJE=;
 b=Rf9gO49AzuW5pOsE2isE/jTfFNifCmHkPIRfh2f5PVv/JZJkJ/B6RMA0SrozjCcAiT
 ZZ3FiRhWWcPBFlPTKgntRjY4s6+KHxK40urPX4PeqVh3oOwZT+nebTnPq0ugPPm/4t5L
 zLZ10srtKoIp4rup3d+a7NLPomuEsmRXhXPILecZQPIjVG+ZSQsP2cHH8YPgvFDs6n3R
 E8tteUphljej27UcixDioEcshpei/8H1bEEeZXv7C8sn5cQbzVnhtyil14z5Rf2fZfPD
 l94NEoIas82EO1BhxQkN/odJ14bFjuoXfP9dk9Ax4wpNWxw2fKTlIKSH31OD+ZcC7Hjy
 tKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729453065; x=1730057865;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvFdx3DM0sYJp01pVvhNq8L+693g+/1//XNAAq1DiJE=;
 b=gXQYkHR9kUDU7QMk1ZO3F4tTznjpvx0HsNXzRLlqTEaskxXfy1dytZZ9hVYHMtSuSW
 Sslx3cfUchTQaIvHbeQGKMrFqt/9o+7MaBXDJ9TqOS94JvhPiF+cwiIwqUVQ7I23zqQY
 CeInhqIcx/FMXxrTXK+hoRSvPRFKgHqDmvVsuuHsU3eLxJOEZm/l4dBcn7BBV5kx/VCE
 Xwc/Ij7VenRFqUcPoeiEMwbr3E0MXKPM+Ne04qRWWU6HlwqJh0Athcsd3krQVaed7O4u
 7gf6oSy5ta7ICVFz/38r/zlmyU4g+2YkPYzrp4PHCafp+obXGgkUaBRkzBQEM9INqF5u
 8YjQ==
X-Gm-Message-State: AOJu0YxdNTnErLrWRWXostvJGuYgVFx5fEFc/hxFcTNOnZrdZ4MWupbK
 ZFMkoDllqCMcZsDafa/exhxu54gJEWxa8BB87LQRx8LGoxi9s3N5dpjZFtP6TWxEAcjQL1NC0Gm
 z
X-Google-Smtp-Source: AGHT+IEvFXKgadClULPA/WpQO2Il5C5p4DHOf5Wy4d5ynsCR051OW4RP5aST3bUIY5Z51p3PNLOhMw==
X-Received: by 2002:a17:906:c155:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9a69c92093mr810114166b.47.1729453064537; 
 Sun, 20 Oct 2024 12:37:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d623fsm120323866b.9.2024.10.20.12.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 12:37:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D83CC5F8A7;
 Sun, 20 Oct 2024 20:37:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
In-Reply-To: <cover.1729355735.git.neither@nut.email> (Julian Ganz's message
 of "Sat, 19 Oct 2024 18:39:33 +0200")
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sun, 20 Oct 2024 20:37:42 +0100
Message-ID: <87jze2va49.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> interrupts. For example, we may need to handle the execution of a new
> translation block differently if it is not the result of normal program
> flow but of an interrupt.

For future iterations please post as a new series as tagging onto an old
series will confuse tooling like patchew. I shall try and get around to
reviewing later this week.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

