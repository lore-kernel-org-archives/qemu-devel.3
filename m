Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69702CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8crU-0005Nz-LZ; Tue, 14 Oct 2025 07:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8crS-0005No-Kp
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:06:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8crL-0006ns-S1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:06:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso4373718f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760439982; x=1761044782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d3jFHQfjHsvOgwKvGPYzZ7fn/QtfE+eJCsh3Xku+co=;
 b=X5W8/lYvUUwmEDOhrrqkzu2tXge+INOk5/nlsgUEGKW1TuLwUFdN+AHL1ED0C4+khZ
 B5l61n0IKxY3k4GyJpaHZHxxoL1ruluu+GoztVuvWKXqD0o0xl3h4In5mz8GbTPEYZ/S
 VEI8URQxwafkB9xFxDB1GtBDAlO0HiKn1Yj5PWumpWTGDR8eIlNoTirtRR6RAv7zvDr+
 NampoQRkLAuV2Juj4/9vpx9WdectN3bXA2L6wSgyZ3fCXOm0IXUqWPsApvfqxXORPMqf
 tH6MNs8NITrVVJMCua8+X8wMY0aSkzItzE6BXBsSeTbFSFAANUp79UEKdAycS7w0Kpiv
 tREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760439982; x=1761044782;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2d3jFHQfjHsvOgwKvGPYzZ7fn/QtfE+eJCsh3Xku+co=;
 b=KzdnKk0j1bD9doM+Pz75R2xibftsW5vMuZglugcBSENKKdovP1thbIYG05pRjXZa2v
 yYgntY2m4PjtXXXYNXwIiYLEvGdrcxNckVRdnL/uf2j8p6pZEvm/H/0RDM5rnsi5bedQ
 js8hHWzWmIHfZwPSKphsa8NUao1Eoqaf8jFyunvdMMHQK+HTRjoMNfKZNYOBTSpkUduL
 kVKKUw9yqvoPx9KtqrObcRvyJ/MfOmPNRau2A4y1zsi2bjRUHYiM///oZ2si+5JUTxat
 tgyLdjR1WGJmjG/S3CfFJ+DXKzT6PaWt7YMOUKtqQLjE7F4KjxNa5wpUT8tRbgy+x+E+
 Jxxg==
X-Gm-Message-State: AOJu0Yx5vJm6KXeENZUqgf91+1Y7lqw3VLEQqIaeDvHAZShk481mKBaU
 YXbh6+TbDSw18goQl+xqWFnS+BEUrbvcY5Rf8kO0RaecdbU3JbCdZT46SBDYYFJeQ1ruZdLQ7LT
 DUyfm
X-Gm-Gg: ASbGncvbA0qrFcDBYUP2IFIJjIlaPigyiwDV5DS1R+lOsUDwVpQjmxGyrhfjYR0cPTm
 Novcts0PUOWwmPF7bB61hjVfJm+jb8ve1j/mHOV8RFgAV4PDO1YsHeFL31fJOgYkVopXWpn+9ty
 sytWZmLJdA4A29GkDxaT34UzuW1M/2mMIkBkwyjEuF0+3Erc8B2dI+7DGMLzk6qiQu4CdZ8E2Iu
 80bWwxbftZWJErcZQ2UuR51/FNiHPU/e3WtpbjV/dYzFvmUrk1XP0ECPA5Qf+0lIaUVktUAS/IO
 sAlA0XfSbYUDpIYmop8Qre0e5C47/s/VXuVWhRJoo30nPB1VTOSpf/DBwCp3euNbfYxpNoCpEww
 RPOAloLRjhVC2X8agxRvtKIQOmzpHfFe9jDmryGlqvIVHTNgNpZNyeNly
X-Google-Smtp-Source: AGHT+IE7EUFt/092KCHWEeq/d2Zkq5qLZXrJCViGXRWtAKUASIAbqaRNrZd633D91DZRsSHH5jusVw==
X-Received: by 2002:a05:6000:200c:b0:3e8:f67:894f with SMTP id
 ffacd0b85a97d-4266e7cf0fcmr18328535f8f.26.1760439982282; 
 Tue, 14 Oct 2025 04:06:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5825aasm22707197f8f.14.2025.10.14.04.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:06:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8053F5F812;
 Tue, 14 Oct 2025 12:06:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 01/25] plugins: add types for callbacks related to
 certain discontinuities
In-Reply-To: <7eb3da25409f1134671ab23ca4b092bae4a1b9ba.1759744337.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 6 Oct 2025 11:56:56 +0200")
References: <cover.1759744337.git.neither@nut.email>
 <7eb3da25409f1134671ab23ca4b092bae4a1b9ba.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 12:06:20 +0100
Message-ID: <87wm4xlp3n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. However, traps of
> any kind, i.e. interrupts or exceptions, were previously not covered.
> These kinds of events are arguably quite significant and usually go hand
> in hand with a PC discontinuity. On most platforms, the discontinuity
> also includes a transition from some "mode" to another. Thus, plugins
> for the analysis of (virtualized) embedded systems may benefit from or
> even require the possiblity to perform work on the occurance of an
> interrupt or exception.
>
> This change introduces the concept of such a discontinuity event in the
> form of an enumeration. Currently only traps are covered. Specifically
> we (loosely) define interrupts, exceptions and host calls across all
> platforms. In addition, this change introduces a type to use for
> callback functions related to such events. Since possible modes and the
> enumeration of interupts and exceptions vary greatly between different
> architectures, the callback type only receives the VCPU id, the type of
> event as well as the old and new PC.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

