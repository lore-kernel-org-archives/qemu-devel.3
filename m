Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1679AC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIf-0005li-To; Tue, 08 Jul 2025 16:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZE9I-0004AW-H9
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:38:42 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZE9G-0005D9-N1
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:38:40 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32e14ce168eso43539441fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003517; x=1752608317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=729btSUPTq5cDvtx2ivr4Y0sPCxBg007AtEFEzdwZpU=;
 b=H+MYHHltfTeIT+EDiKVuTN5uLs5GoFXIfOEWKOXEUHqwGGcqls1TGMNPlg3uU291gv
 3ouGeCb6gOOPfX8mgPVkb5ilqkyaOizD7OuXCcaCLAq84wIiZVNStRNQSgDmWtZvPecH
 aidozT32YlB9gAaw7/qL7dnl2w49bF/oELoa96fleVDImKklyqEm6IC61rqj0lgsruB5
 67bFOFK/f87AqBTRdYTDK9VFeW3TDyCK9NDLd/4aPKeDok3IJaMId6rGuwYabr7Stoi7
 Jce/dezmTIfJlGc1kL3dP2sxNkOpVi+0LZ3sFFZSg4pqWOr+2Ne1pnf6b0jaGJrndzKv
 2vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003517; x=1752608317;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=729btSUPTq5cDvtx2ivr4Y0sPCxBg007AtEFEzdwZpU=;
 b=b3YdV2BDwjfUN6h3L+e6gMfuvcFVf0uHSj9HxcsDNIKettz/64X3c2vt41GJwSHc2n
 4F4i5LC6UbMtQgcx/CpPxn70XFNk5vPUYk3ltxlQB7X74FCIObbDLFEQ0GV7FIT1U7sg
 fcvsQ7+q6KQ/w/KBAMV3RQdUqliiJzNy/If+35F21aGdgvbKtwHwfitbb/e+3a41nDo4
 yaIsBJnrLW/4Esy7m5K3bCnS3Nd96kuef8aJA87je7m6X+1PIRxmReR3i3Rn0CT78pyB
 B0s0NLevqTYIV3UeyegNxcnHppQQYEIr5U2DdCGVm7ELl39omSp3KE6jKMQILMOR+FVA
 Qbbg==
X-Gm-Message-State: AOJu0YyEMK5Frr7sp7Nx6WtwQmmR7L9qSyLLeT3GDfx7cpfXWUcYGmZq
 rP6x/DHhJCh++dGb142qAuESBtlmSh3foSkLHsfKS03X9Qnia7xt0wWwX8fN56qBS6dgryElmgo
 o7s16VB4=
X-Gm-Gg: ASbGnct91pQUprzgCq+IVhzrmAxEkCAYb+SpKsyB64Uek5j9oBPnuzJ9LMTcae16sZ7
 Qiyh5Q/hP3D504Mr5bXLkExmCgBb72ar2OFBcEpXv5oSCVeH+ntOsQnHxKISXHO/qukiCnRDR6O
 OFtwQUpgqXlXFM/I1lWTjvn8beq92z+uv/kQtXT5uPon/40dk7EYqesdKCY/+4/WCei2MqPs2ll
 3USArRUGxic/mmxSuFH1lRALDQV9QmvJHmQ+mmR6XuDkeB+HB8qpcKBMzRAagiQQe7RghC9lYm8
 VGu76jPx0lD9pdUZRgd8sx2uYVNdlO/LmkvPEqkv0cNf0aP9BrSjZ11D3d0+cYE=
X-Google-Smtp-Source: AGHT+IF+VSzvMpg66eH2nsUAh3W1EdvnUJTNG9MRWdwyaotFyDnPIQ9iYkvFnYQsP0G2G2RoVRJYvg==
X-Received: by 2002:a05:600c:524e:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-454c64dc1d4mr70046135e9.15.1751961187822; 
 Tue, 08 Jul 2025 00:53:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd44f2e4sm13809525e9.10.2025.07.08.00.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 00:53:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2B195F88F;
 Tue, 08 Jul 2025 08:53:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  laurent@vivier.eu
Subject: Re: [PATCH v2 0/2] target/alpha: Add TCG plugin register tracking
 support
In-Reply-To: <20250630164124.26315-1-yodel.eldar@gmail.com> (Yodel Eldar's
 message of "Mon, 30 Jun 2025 11:41:22 -0500")
References: <20250630164124.26315-1-yodel.eldar@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 08 Jul 2025 08:53:05 +0100
Message-ID: <87ldozunj2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

Yodel Eldar <yodel.eldar@gmail.com> writes:

> This patch adds TCG plugin register tracking support for the Alpha
> target and resolves gitlab issue #2569:
>
>   https://gitlab.com/qemu-project/qemu/-/issues/2569
>
> As mentioned in the bug report by Alex Benn=C3=A9e, the register list is
> built using the target's corresponding GDB XML feature file, but the
> Alpha target does not have one. The second patch introduces the missing
> feature file and the necessary plumbing for it.

Queued to plugins/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

