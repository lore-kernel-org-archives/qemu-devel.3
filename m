Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD885C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsLl-0005Yy-SA; Tue, 13 Aug 2024 10:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsLj-0005XW-CR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:18:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsLh-0003OE-DH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:18:11 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135dso6410970a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723558687; x=1724163487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=td+SkppZkzQrqhuwSz+9+8m4FdrNXoGDoQtAuD3zH5U=;
 b=KKXQzpSjTgZ8Pbd1643Pjt+YtG88EhlyuwiLEPbfRhQ0uojLWTFHKu9uIza+s32eBD
 9m04QrWxPq6yc8qtLpXPzOYOaFfie2P6bpg3P5TtLw5xbO4TbkSvlIF1qDOodZsfQb1O
 XhB07KGYn3qffRwJ9YdNK2QWs4McR9VbumaGBbz97rhGH2vMhxlK6aJSMPwASFdrckHe
 KVP7CycXfSSJC+ZwdFf3q8fzaIIvfOacG8/1T3fBIKW44P5JjC/J0YypL938aAwZ70rf
 8BT2bPjjZIfpoZxSGZqR8hDNGfwuspJ0B1dVHeiZ4npe04V6sMRlhLVfK2NlcrNpRbvt
 8moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723558687; x=1724163487;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=td+SkppZkzQrqhuwSz+9+8m4FdrNXoGDoQtAuD3zH5U=;
 b=YhY/TBQYUArJYeZUzWL+1/zuPz5P3qtdo732UN2W63kFHa0LAlHqM3s98VcLPYathv
 IMF3gjUL2jXkb2wZsH527KT8GhGYizRzuZKxcYw2cZmHFw/YpQmPTWx2VtUxXrbR3H+C
 YSTlNNI0vTbQ1QXCmgYJB/Wrw7wIRE1ckpeRMZqEKqhxiNiefupvM/sblqX6GgBP9GQ+
 DWIaruUFtSiS0+NABWjZZvvwsm6y3PaSU/rKM9XqcUGvQKkhwHOLFXQMj1dxv13bIFI5
 G2A8UOKXUfwkPsiWhWH3gIPQRu4LZ11+ud4UtYpF/vTQKmzjywxCwPG9MwoB/R+Hz1Zj
 Nr9Q==
X-Gm-Message-State: AOJu0YxW1VgTbEDv5dW3SYLIiUxq5j+1/FKmmQeF3rCsUSVzEOYOQQ4C
 sdb8rc/GJKlCrQ7Rrzw4bYddfXF9WrgcLRY5LADjOADFCzEzcq23QcRGV1KJXiA=
X-Google-Smtp-Source: AGHT+IEt58RLiF8RnynWZ59PWNlYI1L2IZXnWDVbBl4HhTvbHUw0WOlnfntnuftZJeana7IGp9yplA==
X-Received: by 2002:a17:907:96a7:b0:a7a:a3f7:389d with SMTP id
 a640c23a62f3a-a80ed25bbecmr247856866b.31.1723558686478; 
 Tue, 13 Aug 2024 07:18:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f4c443sm73381466b.3.2024.08.13.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 07:18:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 060105F7A3;
 Tue, 13 Aug 2024 15:18:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Weil via <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Michael
 Roth <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Blake <eblake@redhat.com>,  Stefan Weil
 <sw@weilnetz.de>,  qemu-arm@nongnu.org
Subject: Re: [PATCH-for-9.1] docs: Fix some typos (found by typos) and
 grammar issues
In-Reply-To: <20240813125638.395461-1-sw@weilnetz.de> (Stefan Weil via's
 message of "Tue, 13 Aug 2024 14:56:38 +0200")
References: <20240813125638.395461-1-sw@weilnetz.de>
Date: Tue, 13 Aug 2024 15:18:04 +0100
Message-ID: <87frr8a4mb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Stefan Weil via <qemu-devel@nongnu.org> writes:

> Fix the misspellings of "overriden" also in code comments.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

