Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656EAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsd6s-0002Ef-JU; Thu, 13 Mar 2025 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsd6q-0002CI-Ix; Thu, 13 Mar 2025 03:36:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsd6l-0004LR-Kb; Thu, 13 Mar 2025 03:36:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so101826766b.2; 
 Thu, 13 Mar 2025 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741851357; x=1742456157; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzNWP+qaHl/k7mENdDMy+fTNRefXf1Qi+bumMTbqWpI=;
 b=DTYfdLgyM1md2EbOQ8QtGH5N807KUKBS1wlu/muijlV/Vs4knqbxF1Zt8q3EH458Lf
 q45kzvllCtJn81hFCDJD97lQGM+Q4Iel61eyjSfgiOxaZFt3RA4tCh7RgGyu6AvFSYUp
 c0Xk3Rr74BIapz4hqB23aKaJcc6vylZhrNbs3gGukp+agN5RiMCZXtUYvk6ZVe6R50ON
 2UdjrleG8bCHdIdoOqfdaNWSAvN++ziz2UC2NjBOQZOLt8/NFKzz1TRmZhTE7bpWxlep
 a3KQvJQcH9TrMGPkyxltkrfm4Q45Wpl/DOWAbqQq1zdwJzUlg5dkaUMddhOgAH9eOLMf
 IDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851357; x=1742456157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzNWP+qaHl/k7mENdDMy+fTNRefXf1Qi+bumMTbqWpI=;
 b=WbGok7QNGheTYljM98rbjZtL5XrBRdJ/5qD1maXOGvlmUu34Wo0i7zz1qGatNQ1ZLL
 2ABbfCejERJ99NuwPJ4krsdm2wGdEZqgFJjvFa/hQLqDLhD+HoiX4cFwNxvGKkCDw53U
 PswNxTlJYOcImzVhtH0NeU8WQuUwANKB4JuMTOwsIhOQNypkGdkHQl4J6xlioEJw8yX3
 efXWGzuCfbJAAcpWPReQaoOiytJ6GJeQzZIMmB9LqzrEN1i9jiEUAuBz+8dTQuxBGpsX
 B2cSMTBH7lrYcJRf8K1NCCHAjQCXpYP9w0uKTbgnKkcUaydxSy1qWbi5j2hiH+s4MyW+
 SZ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgwwP/IxExU8S9AzUGlGeEG6xqVbBKdiIRnVvFDBsVxQg7c70zZed/Bbw0s7ZMWR8uCE0oc6DJGoB2@nongnu.org,
 AJvYcCXLi53CSkhJ8TjAM/ya021koT2vLxr1tNflDUsvrsELe6URCIbHNUSca/FHu0N+PEqduDBzHdlLNuY=@nongnu.org
X-Gm-Message-State: AOJu0Yz4SR4DyKSw/v5bzsEOar+EDjOdg4r+5BNGb5NKw3p9L2qi2iH0
 PnwNSmNeSfqWvpueI/hloYzIvaKjqkGrflaBGwXPiLm7wOJViiKJkSoRhSL2BGvWHlv8woCQnam
 S+cKEXStoHsCnPwXOC2GNVWlSUiw=
X-Gm-Gg: ASbGnctFWOjLJTnQMPUE+zHacuvcyLx8Vkd3GAX4QcYSjx1+flpYJh2SjKKMgg/xkUk
 LuXTLEjq1Ct9Ky96GcoqtrRRryBxpHVVqXXR/nB8P2fEDuVhfmWUMMzMBtBjrpMczKSeLGW9Hv+
 EIAagrsaFtUOaBZ1tH64P0dWG1vQ==
X-Google-Smtp-Source: AGHT+IHeGdxXuuMqlUJhwLy/xpX8ysyYV4q1t2CmkKzcX5IsTetKHmsUsa2FvXbUvyeKK/Q1liSs0Pe0veohGDWhjDs=
X-Received: by 2002:a17:907:7e88:b0:ac2:a5ca:4c5d with SMTP id
 a640c23a62f3a-ac2b9e1c8ffmr1385638066b.26.1741851357223; Thu, 13 Mar 2025
 00:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250311080142.897437-1-npiggin@gmail.com>
 <20250313070414.GA1086072@fedora>
In-Reply-To: <20250313070414.GA1086072@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Mar 2025 15:35:45 +0800
X-Gm-Features: AQ5f1JrjnkoWofxP_kP5hhT_KK5NF5ZWp4Fe0xZ7nESylPIWULLrnP2HvhCZQDY
Message-ID: <CAJSP0QURXxBL7Xrpoz=Z31cc=L+W15wevEh6gZhHVG2ETn1uhA@mail.gmail.com>
Subject: Re: [PULL SUBSYSTEM qemu-pnv] ppc/pnv: Update skiboot firmware image
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Mar 13, 2025 at 3:05=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Applied, thanks.

This email was sent by mistake, please ignore. This pull request is
for the ppc subsystem and I didn't merge it into qemu.git myself.

Stefan

