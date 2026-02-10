Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690A6EA8102
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmLl-0004mX-FK; Tue, 10 Feb 2026 06:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpmLj-0004hG-0D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:56:11 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpmLh-00056i-IX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:56:10 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-794911acb04so39941587b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 03:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770724568; cv=none;
 d=google.com; s=arc-20240605;
 b=XGz67zIpS+C80NKWfSxQFJln1DA9iVsf7gnL7C/atiDvdPqq2H2mdiQNNkX65nAPSG
 yKVrl+nj6FSW4CXd7batiMFnkE9wq1DU2EUI8xDJ+s209ZJp3qPhrtKAmwmJYNm3iwT5
 b1YsDZb95UXB86qhBBDi6tZeZfYuTdp/q0B9SLK0R7Dt8qimVz3Ep3kmGSd11DtORmSg
 whsX5kseDqS1MXvTm7xeKrG8JT7tc5fctnCujjg5t+RFbETeIlgRAo3lXONc+gQhC83X
 RjezsG4dCDmzGy0ad0jG21ygPjMlQdgSM8czdlt/UBAWzoxinyW1denZxu9F22i8ZIHd
 +SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hkS99dUrqdgBELzlfh1B1oR51ZL2os6kdvIBc3sjghc=;
 fh=gJBP7LzjmxIZXesQ7h/Ujo8KabcyIAa2aeDpTz4Fzj4=;
 b=K8z8YVZL7PwIJMvRrhTXJK2hCu/6l6VDbydPK3Xb1U+if5AA049IE7L+DqE1mu97gE
 PYoNRVQVNALFNt+jLU/8X3WdQKck5W4kwxPrS0edSHYC2O0pNn75dHrJsOheFcn7b9vY
 bPu4l/tzufJ4OiEfbR2Nxg02GCe4WiR/dsNHogluzFRN0ndq/RITgXD3Wtcdv1cdBqAe
 0udNxjC4NVpRtifRojG+BIPekXjEp35G7/pJaQt6zIIUNF5sFI9+st3GmS8hoFJWS15k
 b+9qRcny8K+ZVbxlm1v72FklER4YmyFFu7j3clpFeaazsgvw/JSuPhgG9vIzkD9rHOQq
 zV4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770724568; x=1771329368; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkS99dUrqdgBELzlfh1B1oR51ZL2os6kdvIBc3sjghc=;
 b=EwSMfsvFlfWjM4EdhJMZhdDnekahWI9glhM4A0ObbZ3awTUvVCd4x5y4k+tlGiIcvW
 vJN6PWIkUDoMk6sv6nyYgAVx9d4DRebOuWZSsE59D3ttpo4c4rObw8qHW/Io0EvlkR36
 fLbirr51asgLMC+M5yM4N/vKZef7NWT0tzujnyYSnB6oU76vt3M3U4yDN+uKNexDOGQp
 G3reNxL3vQk3bTgEDdxKecfBHZlaf/fNp2h8HFaQxI2vcov/O0qDiFjRW9o95NL4VKrJ
 Pa6kpLIkLkIz5pYf1LTlvVNELM7JnLsSLJyEpcAcL5ZRR+kjJCyULbEz7z/gM85by1Cb
 wO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770724568; x=1771329368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkS99dUrqdgBELzlfh1B1oR51ZL2os6kdvIBc3sjghc=;
 b=EFO2yQ5KhFpJuElksCAaoMa8agN0P5lai1SDX1/uie+8Mx1+cOV8uN6oQXOVNRzVMd
 Q9d8TvnUhXr+gaoUG2UuxSgajH9U4b/dfGahzeH1TunPdWwSQ9daahcRYaSMes5ad0th
 24o0iktT9ccDYzVVuunGSBkxQ0cdGsgOZkjNoTlTgSkfWCpWt0EWxDhRyeak1StdKX0G
 FWiRZz6ITXoq034Q915TTMOy6JjQBNAO2jxobiRFl94nWMIILIB5Gnh5Ei+d5PsfvLmU
 ZvMD0T0ih4vGI4Wu6DF5M48vtWe81TxTEIwVBoVhV3S85/cvVCFFvVr+cQU4ISmRp0cx
 1ogw==
X-Gm-Message-State: AOJu0Yw2BEU04OwHpCY0LRZWFUc5Oac8R2hHQvuBOl3GQ+EWaxpaZUu0
 Hfirm0/PVS6/CweTjLHQIVxyKGSDQxi/LBVL3/tKfWXET0T2zJoyRWHV9nh7jgBsI/qIKioOPiy
 wYMQW335PaDjb8nufgcDMsNgE3rcbhG7rbawpWBWipsO94J4c2EfP
X-Gm-Gg: AZuq6aIz1weHgtdTT/HupqseoMiq9n5AVc/Pvu6TB0xuULUqS80VXKB0sn8k3N2GGI6
 rL1DGMdJMKbo5yIs6UT/XdaA5qZaXsddHia6hpY8mH7TAJvsaKhE+wyJXblOauCNYOeqzEaMkrM
 bA4+crg31tRGQ+yRXqFbmvowS1IKlBHNmtxeswE2C/OKewdv/kDsyBu8UAufTtAlwTjxNPsIIuR
 Lzvqowv4D/IFfogY0ALZf86KJ5xxnYkw2XTsp8FB68JOg+7xWcJm7gUQNJq3ogwuzsglUs0SoJ9
 KMI+Drm8Ow0vlD2600AbnwRjDNaUzrSOd7NyGmWCnw78Paqaqcv5H52XhFxnAC4S03E=
X-Received: by 2002:a05:690c:dc2:b0:794:c657:7ec3 with SMTP id
 00721157ae682-7952a9005f7mr150486337b3.0.1770724568279; Tue, 10 Feb 2026
 03:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20260205210231.888199-1-alex.bennee@linaro.org>
In-Reply-To: <20260205210231.888199-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 11:55:56 +0000
X-Gm-Features: AZwV_QgX6k0S3ur3Y5AYA4QBbvM4I2lYt9TtgpObrjktZb2yX-C4xmipJSI8JL0
Message-ID: <CAFEAcA_wih_kB_ZJA6HnuAq+of12myDSjC8xUNhGX8yhSi1teA@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: implement FEAT_E2H0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 5 Feb 2026 at 21:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
> being programmable to switch between EL2 host mode and the
> "traditional" nVHE EL2 mode. This implies at some point we might want
> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
> enabled.
>
> There are two values to represent no E2H0 systems of which 0b1110 will
> make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
> always valid.
>
> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>



Applied to target-arm.next, thanks.

-- PMM

