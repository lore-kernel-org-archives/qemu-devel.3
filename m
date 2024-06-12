Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E966FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVZz-0004Df-Mr; Wed, 12 Jun 2024 17:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHVZv-0004DT-G0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:32:23 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHVZt-00033i-LE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:32:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so50168666b.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718227939; x=1718832739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Fm8qhyYPvAGbcwa7pivW+p71gMTKiqmz49sDfUBpaY=;
 b=WOFayNY5ri/wsQC+tC/LaS8kd/ZGIUfyVvJ3uPZUA3j6twLQ9YfDgRE0a8fiAhTfMP
 5jVXqcnJMw2D+6TfvuI3K84kolJ0pQ5iDSVQzTRe13KA2eIYn7f6behBQIXhgNZrZ6hX
 LGIH4Qvd/hqz+UMBHU9ipwkyLVYXb5xaHxpWPHlYLQKORqRe4UXvD+2dw1Zmp+LnWVmt
 /cCb87/M+nc+Eg47hOCaZOdUt8cCN0jel9vR8LwZoqka4FDkjRyaH6NlNbVhU3SLgYuY
 JGDNFFF7t3A/NCMWmJNqiY0Y1E+mwqlmDEgmRE1WtjdGey/+CdajKyWAm12k/B6dI+fo
 I0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718227939; x=1718832739;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Fm8qhyYPvAGbcwa7pivW+p71gMTKiqmz49sDfUBpaY=;
 b=aIGQctrSMa242SRZOdir1RmtZQS1vaqkV61Fbph4tRpS/z04hL68dGGHtMgEZeUluC
 UHPIwd7y0eYpP7G5X6YnRS65xeEHQb6elcv0BYXiLIDyz5/NGSIL3w3fVadgPiW4MxMy
 hK6fCEQ4dkbHwqQ+XXGAotYJY4KZAFETrKDiHQnrP4kaaJfvjcuQxSLGFj7/2jz/v16Q
 pUQCMUHW8AxcJ3cVFcHLKxtcKocnQOSZSXBZdvDCd9IAVs6xXejsFmdziJFcYUEbSc7v
 AM1ZkpMeM5p+X2btvj3k6m/95vrnlNw1w2B2zdQP+wskNE88vqzCTLHR+nUWX0O/af85
 r1EQ==
X-Gm-Message-State: AOJu0YwRn3bhltHarGCD6HCrwQPgFgGNAm5nQflc8/BCitPxTsgqyiBQ
 OAh8lCklNsv6tUWQdgUHfay3DvoQncHaV61Ytx4e8LWyGbPh/3gBXVb+oi3GFuU=
X-Google-Smtp-Source: AGHT+IG1jNAzRIW2GoO9r2f3zr8UMuQBzhUdwc4libljuZIsU6J9Fc9e64l/v150xOI1sNY3f1oRww==
X-Received: by 2002:a17:906:7194:b0:a6f:4fc8:2666 with SMTP id
 a640c23a62f3a-a6f4fc870admr91893666b.44.1718227938492; 
 Wed, 12 Jun 2024 14:32:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c99d8f1sm473568166b.175.2024.06.12.14.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 14:32:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 756E65F893;
 Wed, 12 Jun 2024 22:32:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH 0/2] Bug fixes for plugins
In-Reply-To: <20240612195147.93121-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 12 Jun 2024 12:51:45 -0700")
References: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
Date: Wed, 12 Jun 2024 22:32:17 +0100
Message-ID: <87ed91x2xq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Those two commits are meant to be applied on top of current series
> <20240612153508.1532940-1-alex.bennee@linaro.org>
>
> The first fixes issue with windows plugins, while the second is a bug that
> concerns memory callbacks, and due to a previous refactoring.

Queued to maintainer/june-2024-omnibus, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

