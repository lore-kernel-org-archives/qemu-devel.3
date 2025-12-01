Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC3AD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAVi-0000tB-VW; Mon, 01 Dec 2025 15:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAVc-0000hr-F0
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:28:34 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAVa-0002az-Ry
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:28:32 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-78a76afeff6so50722937b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620909; x=1765225709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=majON+XdJ5PDnqemTlF76bCFXIc8a0k4e6RWILRqT4U=;
 b=SLmZvccK6/JN91kVjLOiTLqjYiIeqtzNI9c5TnJSu2eAsu5iRwRxuOQPFHpDFZesIN
 HBJ3GPeiYBzj/3xaGh3RAOlUrxepxwOxwZNCmSqNczQ5RLnavgMwCNvL4/Cq8W3vNjwk
 Z4zcL1xtz3/o3MmVTjI2lAhgy506i+AzbHiGKBsPNfrNI2L9LLrI7h5PfdOP1jC+yvwZ
 CKwsPOqqzooaD2MejLv36HZHUP4XblipbsSFnvB9tbIjpHA7SuzqP8Gsd8MZzLRJnLVL
 XlctwHqsJLodpQVIJdKZJ8RZy+9qxKuOnEqYC6ISOzcVKaC0qtB55lUzuJVgwsImGzI0
 ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620909; x=1765225709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=majON+XdJ5PDnqemTlF76bCFXIc8a0k4e6RWILRqT4U=;
 b=d8eQFEiVsIByqmygHMuF4ntPtG3nhx4DJJkb5mGF7B5EKomFC7XfaegLk4Pfv4Oooo
 zfl8+Wx3brunOjr371P3jgECmC6gCWPyHcrn3v2A2l1GKyQgi9io6C6b/IKm0jIG1BUj
 fPU/tu2CBgjYvdFMQfDooiTGQkwlZREUyBhEjROYxSPHWGja6pvBdeTjZGKmpoWLTAVp
 xh0Ti6XxM5S//35C531stWWFKeJFuoQHM/5/IuSeU+2ovi9DOwXAsHKesbgH26XB0ZAJ
 AwQchqiuaxsllastWxxHUiZyEj7vxf2qKDOPUNzLYZOUpIsj+v8Or0QmKHpxRU1gBazj
 mnzw==
X-Gm-Message-State: AOJu0Yy821AQ+OanlVi840nVV4av+jA9cBEdKNkCTAwlvm6vc4mxpP2Z
 SYjHOV4uaHh3afTew3/1bBGOmLYCJMONgDagma8m8lxQA7j0cBszsgqSRPpG69CK37gJM0hOFvp
 QWmkrv/kuXlLId+kHVt055Rnsvbz70Tn2/umq9rAZEw==
X-Gm-Gg: ASbGnctM7tvHWPvi+GGNAXqW0LRMI7P1RhWGTI0EFMYgW/kzhsf2yYCCWgiWy/EzoLu
 wWK85kkHg3eYH+RNIP6LBNm/Dm40tosm+mWcXCewzpJZFK6O6sMWo7zsPzJ8pGefCVpHvCzCpwV
 uARk67D8U4ImfwYg9IWNkN3gYEDt5MVIpb/KYGyyE+uSbdWa42GGvAhRp5+GVLW52/kcOQQ7Y9X
 XvNOLAya0uN37h94PWWrLx4TmgShQKGjUz9kpdIU2oIYAAVWMMzcUwXanFu6+uMDcGY/GMG
X-Google-Smtp-Source: AGHT+IEMrDHmSRQtvGHBN8MLZ8Vy+E9aYAcu/Ae0Ja8qMjx6X5JJlHw5HU+1J/2Jr9ypcEA+DzUcyta2tUEITsfPRZc=
X-Received: by 2002:a05:690c:fc3:b0:78a:27a9:d4b2 with SMTP id
 00721157ae682-78a8b499dadmr326111897b3.19.1764620909183; Mon, 01 Dec 2025
 12:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-6-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-6-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:28:17 +0000
X-Gm-Features: AWmQ_bkB7VhtQ8I-_skuQIEWGJnkSSVLlcb0qUONSo2c7FCkV0Qv-mUPtyHqjtw
Message-ID: <CAFEAcA_+5xCOxm7MbHEfrPm=N3ZVHec+NA3ZzqajpxtKKyxaHg@mail.gmail.com>
Subject: Re: [PATCHv3 05/13] hw/arm/fsl-imx8mm: Add PCIe support
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> This enables support for Designware PCI Express Controller emulation
> It provides a controlled environment to debug the linux pci subsystem
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

