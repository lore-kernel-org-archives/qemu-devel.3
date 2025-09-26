Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A92CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Acj-0008Px-T2; Fri, 26 Sep 2025 11:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2Ach-0008LS-LH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:44:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AcY-0001NK-L7
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:44:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso14663325e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758901465; x=1759506265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehHu+AJJTLVFFlN8btUv+fyxSIRKavcO80KOfGhNBM8=;
 b=ZJS+XzyTfw8vkt+0iBBD3Tuy2p8mcDHdsUI+SXAe3SV3xXmtvTIk4zN+l11gXqkh+u
 4+gnKtw3Zox5GIumYYui1LFTWuuQRox1OR36SCCxyCvn/YIkBUsLbIxuwhAcyCyuqbBi
 fo7k2KqmB5qgn12vH86vlKSFJfFW2PKOZmZHdzYWXOCYjc52jCDR4cj0BK1pL8JiQy3B
 7ebc5knYzwbBFiMOIjTrodDg/RVOz1f9tf1az8tYfXFw519jQBPRkQCIb6to+yJPpJfH
 p6QxCVYMbBCD6cVhrT6LrySUXqoBEnReKxQUlwPjRLUtr9YImjwUfNCMny5LoHv9HTCB
 2aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901465; x=1759506265;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ehHu+AJJTLVFFlN8btUv+fyxSIRKavcO80KOfGhNBM8=;
 b=xPAkhOpP45KMFxmaVLtkzkdmnkmCqRLGZmTon4NjXnKQykF5ANG8/1NBPtlwUzjOGQ
 3XlVkJXbrV9OrXrZT8zZMZWiiTqxqadm3Cor/vfekEtRrRhcdM6qQIwHPpMSjy282LfQ
 5iTWVTopepnTxG4Dq4+nQgAPDGSFHskcqw8btLvVXew0j0yWF5IpTbNUoOIM0OPrxDR7
 aRlKW6nbsC3bJ+BpZwtBtv2XS3T1b+BRLp6tKo85Bhap9D9aZ2lehB7whkEk+VRkMI8f
 KvLgXB7sYa4TVw/9s6fq2FkcGsEcPB126ewWEgsDf+xSrH4Eg0CUk740QxyE6azcSZ7a
 rtlA==
X-Gm-Message-State: AOJu0YxfVhS4e5jHmgY4nifEqJpAP28hJQdqP94WpcZ59PpUsar/oIBF
 EO9cSOsvEkFbj4KPmJ3GUdQWoIqqjQP0veeWy9YGXEianD1nK9Y1V/wUk9tJsMAfVlI=
X-Gm-Gg: ASbGncuRv8TUFT0XWZPrUsnzVWtju9fB0f3esM+8Q2nqhbzehrs+R87jEWwnCEz47JK
 V2CoOp3aL48nbgKzvXvQ/+eF4wOpIiJx1WoIwfpkXwxDjM1A5ecKJG8z76BbGubP84P+QdX77b6
 TBWcxe6GexrGdZKZq9R+qyCFYAeX1OELupYbjzNmPlU2MXMptMf7HpFMjyiD+8s33doWddsKd1H
 mfDwuHaqdRbxMMumNuEfYJGGfD3rcOaKSrWHaFStErFbqnxR66gdRJeJ4e2s3YXb9T+M+ydecfQ
 rtNGi64IXwAwwUguZ8UFV53icKG3ELr1egU6gPvHiumgZlf76rS0cBYT8rVZ2L5rEYaAq9+JAhZ
 /+ah/DC5KZVNIOH4NmdW8mXo=
X-Google-Smtp-Source: AGHT+IFGA/N+MueinqqXZw6SEs+nJRHS5EmfJAq5SV4IVic6KTR9UJEfB+3l0GImVmNYcyoEfy2YcQ==
X-Received: by 2002:a05:600c:a086:b0:45f:28dc:60ea with SMTP id
 5b1f17b1804b1-46e329b63a8mr88103535e9.15.1758901465316; 
 Fri, 26 Sep 2025 08:44:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e3bffe67asm34859785e9.5.2025.09.26.08.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:44:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1DBA5F7C3;
 Fri, 26 Sep 2025 16:44:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  Yonggang Luo <luoyonggang@gmail.com>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Warner Losh <imp@bsdimp.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>,  devel@lists.libvirt.org,
 qemu-rust@nongnu.org,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 05/27] scripts/archive-source: use a bash array
In-Reply-To: <20250924120426.2158655-6-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Wed, 24 Sep 2025 16:04:02 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-6-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 26 Sep 2025 16:44:21 +0100
Message-ID: <877bxli5gq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

