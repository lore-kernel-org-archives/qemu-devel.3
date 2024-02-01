Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E49C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDt-0007eN-DX; Thu, 01 Feb 2024 11:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaDc-0006uI-Df
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:47:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaDa-0003OY-Qv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:47:16 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so1409622a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706806033; x=1707410833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjMXOv+9b7sh6dM0wTgq4km9RZuOela+8yUR/J9JlWE=;
 b=ZJDRy/mV/gfjloEGwBmTF6CxbkLybacdEK6sNJs6t2xIkiZbauKBTjK86iTbLy1/jV
 S5CbX7c0Hrj6yYzqTibj+HsCY9GWhVWpC/r/cePsvzQlR2bcKZmIfUyj6JCya9jYZTXA
 E47cYISoxdctPPVRlJppds6neb1dIQ0l4Iy1mO2hOfPOLk/kGOfc0Cg2+2g78CPuq/L3
 qHERoAkZTEodicR62F+TbMfT6CiT6hG+9D7qP86IID+J4mrRCfUQ0XqCpFkfX+N5b6HJ
 EaaW3p66OGla/rVD28E5PI9vhOYMtPc/GKcRI/W0cOs6aE/cWqPQ3TNu87P/vPIz6t55
 DjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706806033; x=1707410833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjMXOv+9b7sh6dM0wTgq4km9RZuOela+8yUR/J9JlWE=;
 b=MSranAxjdCNNdgcJt9ziW5ansXrXibsIvu4Jlo+B9Za0w0oF4PwPQdezl39EAW5avC
 rML+73pDw3kgiEU890NdfXH5haAybqurmZ8iL9IlYPcN8ywbrm21tqZ/Jd9RlUcbTTQG
 HFydUiWVH4qHolIsbGUuCM1Cc+LnDqDUgXsTearONMUlEpRy3O9waLvdYYq1XDt4o3Gn
 oSsAwh2/arna8pt+TWcRI5aEvxc9uq+LB8jcMsvAX48R/wVUrQtioCLiUGdYH3FZvXR+
 IUuueMlUaiplIZC8WkwP7kW51h/jh41Rxy/1JHFKR6n7suYqhbcqaE/Phx0PplVkTTUe
 dvFw==
X-Gm-Message-State: AOJu0YxC3N586oEaT84emwMaP5Qx3+7ByqKBnrluBXHtp1unOIRGzhQH
 q2TOYKW1KyLGNb8oLsaiy7lo4tl0ahczhMSzuFPO2P2d9G4xFHfZgYmpoiLFSzPLjdWJT1Ys811
 yzEDH419ck/KQzEZueGDL/fYtQBCKn9tnLKZnug==
X-Google-Smtp-Source: AGHT+IF/TCNDaJX2ftH+Kysd3AFg8PNeMDel56Poaurfokzb+guuvRGvGbOMZvUcfcgd0zaY9bdYp0pSWflQV+SiI90=
X-Received: by 2002:aa7:d344:0:b0:55f:2c48:abe0 with SMTP id
 m4-20020aa7d344000000b0055f2c48abe0mr2017780edr.23.1706806032977; Thu, 01 Feb
 2024 08:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-4-philmd@linaro.org>
In-Reply-To: <20240130190317.25692-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:47:02 +0000
Message-ID: <CAFEAcA8Vop+hBsPYqtdzDL9ce2QJ0WyXgv0m-ERJHwqu7V6=GQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/stellaris: Add missing QOM 'machine' parent
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

