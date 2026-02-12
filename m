Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD4BEE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZfH-00063o-Gz; Thu, 12 Feb 2026 11:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZfG-00063Y-4z
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:35:38 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZfE-0001DA-Ml
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:35:37 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7945838691aso30586767b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770914135; cv=none;
 d=google.com; s=arc-20240605;
 b=G/y4+4lNAsZVV4JwmTAbq7kcTzCHe+3O1MTm19gz3xviUcepnaQ4rspVDfCNUN8tSy
 jTh69g0QAVTnLdBR4EoMsYia4YBt6HJTtRFNbAxvtkuf51mY+WYbUy5aD7JMp50rvxW9
 2MFF53sPtEkBqkOsbawU49doJ/RWvDs3EcilC2L4v1Ehbkd3lCHVfnoI7CKPbsLSbZ8s
 JpUXvxoifeOJD8kXpvWSUbob1i3IatUaPEova78IvmZPV5bDHBQw5ff4OgJzDZwYCT5v
 74zqYlKAE8Gay9bXajosKSJCy3lLQbJbRh/gqK44PKdTfSoev3HG6vYp1ZF/RegvLxDa
 IC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VXJCvP5gYwAnr0dk0cMgRmrk4HFRwkvVmDtevyMIoGE=;
 fh=PyOPoNBoQFM3aCBquwILiqFzLPoaTRIJM+NDP7vsKXo=;
 b=YT+jH0ifRvTHljiBZzJzBbDD+mrtDlanKAl2xbku0uzb/Cl93v0Ht+CUGfof+BG9tV
 qWIl/IElNMPiOv4Vqq6SNJykzPHgzn/QRjpJV0uXXqjiMSmYToS4Tu7eU7TuHfTu2Cqb
 Ldbk9k6Qi+5CMXtZIUEwEqivwsl9LAYdH82atQZnDeb7Cgc3MqUEt6707DG9la5Bmnch
 N0b8EIjHSZqMbmpTggSzLWP0lrYcJvw9Df6C9OZrezA9EvjlrcwmgelX8x/X88eJe4Uf
 32mNSS/EzPaw9BWaQ7drDksMVFaDbuNQ1dcvq+8J42HV+kG7gl+YzwPt4wKUjO557oQr
 UxQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770914135; x=1771518935; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VXJCvP5gYwAnr0dk0cMgRmrk4HFRwkvVmDtevyMIoGE=;
 b=T5iI/YRojViVxVVMjA3vEIDNj0lfrC4ERQTx9LSGhMDqp3kisK+BSkrqbnWXAK1DaU
 Ipan9nbfRMsGoVWaR83THKeo+6+d8oXEgRrvPdJ5v7E7iyrqaSyIDLDVmHHUVwe6dtJm
 A579LIVqgs/w6xLucRxhWjP5dc8TgT34medEX52ITG5X7+p8hUdt31whTm5Y5BMif2bB
 IBylReTck8wiz7qo2stVUQX4MMXb9rW4b1UyiXJp4gF1nQV3ghCJncoGz+2WzdzeIs+9
 KUho1DyrI6KX73hW0eVJM5dpeHXHsGOCLDSOvR0R/zhJq+iIDTa1GRgUxvZMv1teXFqg
 3Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770914135; x=1771518935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXJCvP5gYwAnr0dk0cMgRmrk4HFRwkvVmDtevyMIoGE=;
 b=VEeZ7p7zhWF1le8C/vgc85D//o7EbMWDnmvlNGgYRU9i2bgUK/dD91qPJA41iL3LZm
 YojlMSnpg3+zeJvAy6wcTG1u1cWR0rtMCNZEvA5+c+lgIRmY5HHug5jl0wm6hel3qmI/
 BU6qNOr6VUJW6EkVJOzMla+LQ/T97BEHdv2Au2Kb8tCHLxIMLMa0jFVWdLR6OnH/uL5k
 CIpyfnvplFEjcTCn8y0GSl9NkTY4eworFiEfTIxd5+JqtjqGe8G803kBFcFyIyWihrGJ
 ncy3Kry+ej5mcc0WkQzYIiUkkBiewZrcS8bMcNC+f9aVLmdOv9BGliCZU1K0GruPhpbW
 AyqA==
X-Gm-Message-State: AOJu0YwiVlx2SKDj32j3wzEX3doMxzZq9FW3RC85XuaR/X6+j3mPDmen
 du0ooQkafaejtAF39QRr+Da2h+kH7XYPYAgdippp8S3kFzXMhDv5K4XiP+DbpXJ1piOrT6v9u4W
 hB+uD2OZxlfB3E/jVuTAc8H5wrpQStYcAvaeE6awKEw==
X-Gm-Gg: AZuq6aIjvLb6I1yPYat69jvIDIcxUYSbGmxR2Ko+CZhR86zOBPhcEU+emLkJUysvTR2
 5A0GyAFk48/Y4/PTajKaeN2xngRo5yXXcBWRL7OetwxxMpn3xW3XHE/RR1XfBtsgjWtBCX2c6Ks
 xI623QW4/0EathoZxE3EekUBOHDJa8mdcFUGeUSpD/5BZ3x9lrc6y/Rjwe/pYYxZ1KOARBhKtle
 +bnV+/PfDomCUcnf7YieS1s3mhawZWW03MbAlyaJcCuvotNfIS7/PZ0DZhxpoOzExPB8/E3zY1G
 RENyG2MXmkRcGADjv5YElcRnptOeotZ6zI6IvMSm0s8iVv5rhHSwFIHafBRa4s7cVBY=
X-Received: by 2002:a05:690e:4286:20b0:649:3875:9200 with SMTP id
 956f58d0204a3-64bdf2f94ebmr1957095d50.1.1770914135172; Thu, 12 Feb 2026
 08:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20260206174755.3190469-1-corey@minyard.net>
In-Reply-To: <20260206174755.3190469-1-corey@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:35:23 +0000
X-Gm-Features: AZwV_Qg_PhP0oZoNlqnQUPVnzYOA4EwPDZm0KKIze11-fMNAU838t-bBtLYDBuE
Message-ID: <CAFEAcA9LRXwaJz+5YwCAwJNdX7jFw3eruMkiHzP6_uOFda8iXQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Add a fake IPMI LAN channel
To: Corey Minyard <corey@minyard.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yunpeng Yang <yunpeng.yang@nutanix.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 6 Feb 2026 at 17:48, Corey Minyard <corey@minyard.net> wrote:
>
> LAN functionality that is not implemented in the device, but being able
> to set the parameters can be handy for testing.
>

Hi -- somebody just pointed me at this email on IRC. Something
has gone wrong with your pull-request email creation process,
because this cover letter does not contain the usual verbiage
that causes it to be filtered out as a pull request for me
to process, and it doesn't have the URL and tag to pull that
I would need to process it...

It's probably easiest if you resend the pullreq in the correct format.

thanks
-- PMM

