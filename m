Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C71FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbcQQ-0002eR-Js; Wed, 07 Aug 2024 04:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbcQO-0002dw-6Z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:53:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbcQM-0002um-JR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:53:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso11418205e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723020816; x=1723625616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AaVb4b+4cr7qcKjWWeuMBINEGYnV67JnBvUG+s/7VlA=;
 b=w3Oy3XPZEBd51RoszzDF6B0J8BgUH64PX9vswNlPh0bBAmf7lkN/RqtteOZMCRsi6r
 KcR/GCc6DWaJxQvWNoslOvOlDmVkWSDMI3VEiitTyMFTofFSq0w9Qf5GDBU3Q1u98zvL
 jynlr1gmeQ6XNA+PJn+ZkklV8F0ud8zgwnnF3yLw7lVX9NeRPqtuhHYkHfaOjThGWIPc
 lte8RZ9sPjz5UI11PTrQp44o1PFPlLohzKQ8d9c02GUCKbWWC0xYXjRM2+yceDk394Ko
 c+LaMc+pC7/KC4uZCm+scUvzB0oacjOwoWs3Dg7IlWWRfmcq9dmeVBLkHeLXZLOussTp
 Q4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723020816; x=1723625616;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaVb4b+4cr7qcKjWWeuMBINEGYnV67JnBvUG+s/7VlA=;
 b=SBq21QHSRKzHY2oLnyzWNb0AWWe1Dd1NdU34xUrAp3c158Kuw7/4i6U4w/VA9lLF3+
 CNRBwWOk+0F7Wcs40VkvAKqvAwUFJQUvKBamBPgetnNORnDdOD3AR/G6lBXFKxGtBNn7
 SNt20nphonk+LGSuhdZUlBEjFwlFkfnFKiAj9auf98iju8j6EUdbfiAIzYMidrR8XSDq
 CkjsaerL/GtZD5BY7+o5yRz4y1kTGa9ccH/ey2stIwMpVBRorE4P3TQUCNIdLlnbB8lR
 zeqmd+OPi2he85x3iQiYndV4ARm1AKgsVSDCKVGcPuT9hL8Cq2mlxw7Xj8BNJ2eezz3V
 UNqg==
X-Gm-Message-State: AOJu0YyjLWe+CKs8Y61FlyVhXKblXZFXAIojCnKZ0U4wkgcWB5zTLcr/
 khbuXnwnvxhJp5Z98t98+Ogm57TU1CRnPSEMb7/7/FL4E9V1q14+FvygwP2U3wuh1oOoUw38S0Y
 z
X-Google-Smtp-Source: AGHT+IGjsyzjlMU644yvx7V0HsYEcoqdqazcP5M8dUYYjM9Db1H3Jh2KoTHAFKPR7pV92F8ekbx4PQ==
X-Received: by 2002:a05:600c:1549:b0:426:6eb9:2643 with SMTP id
 5b1f17b1804b1-428e6af6c58mr107033755e9.11.1723020815583; 
 Wed, 07 Aug 2024 01:53:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42905802023sm18875595e9.37.2024.08.07.01.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 01:53:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C81F95F796;
 Wed,  7 Aug 2024 09:53:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  cohuck@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v2] scripts/checkpatch: more checks on files imported
 from Linux
In-Reply-To: <20240718072050.9503-1-sgarzare@redhat.com> (Stefano Garzarella's
 message of "Thu, 18 Jul 2024 09:20:50 +0200")
References: <20240718072050.9503-1-sgarzare@redhat.com>
Date: Wed, 07 Aug 2024 09:53:33 +0100
Message-ID: <87frrgr9wy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> If a file imported from Linux is touched, emit a warning and suggest
> using scripts/update-linux-headers.sh.
>
> Also check that updating imported files from Linux are not mixed with
> other changes, in which case emit an error.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Queued to for-9.1/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

