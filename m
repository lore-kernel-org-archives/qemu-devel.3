Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F81CF3C9BE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvOH-0007UW-1P; Tue, 24 Feb 2026 11:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vuvOF-0007Tc-9e
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:36:03 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vuvOD-0007Sx-E7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:36:02 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5069a785ed2so62941cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950959; cv=none;
 d=google.com; s=arc-20240605;
 b=RlXNR8Uol2gwsSvD63SqxJ+ijNCeoxtcKMc8WmyAJfeyZE3NSSVqrzcf+jZtCwoBXj
 dacOeJh1sG5rI8qjr6Uk4NgksTRLuYLhfmWBLbk85sulwA3zHyKQ4ACgZDN4h1L7EhIo
 sFE6JhpLCprQHdOcFrLDnvqkgi/SGIf038xUFtAqY4zatQWNPJ38F2Mtbw4X9dihatsv
 eG+C1leFC39rGEcW1KLOsoaR3d741CTz41zhW/FU0EEKVv5K5mM1RbcCZqKJpcMWIsIn
 qtAWnEF6yIyrux7iqnQ1U5weu9+d019XLbgLCmDUqbeRn8rwyikcMfYzZSWMrLKPanN2
 1umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PCtfCuHENWEXCalHDflSvkISbE8QjePpBnrO1b/uMEI=;
 fh=zj//V3ds1tgtg61reN3sMa+TgoUqRevkl+oU1GxGjxo=;
 b=UgUTrax4PwRUIXkfn354scQjCeiU4FXYc1efl9FFOpHoJQcyV/nSJtdvK9v5kqierH
 OhadKghupIaghgykl2PLoV20QxIkVpO/8GOjIifXdl/aaL6Dg4U9dVdeS7nwG/Wsm05W
 507xbeWTqUPgagRyvkk2jFNExJ9WRmcuSZLrrJsfhWk4PmaLNXCWWaAmJGif7cXq8yqR
 MkDCg8or/BEoNpgWi9iJNxIg/uAdQ+/WygSVN/vFfJQ7tvr79Pn6SeDz6ZqJLYLzZ2eo
 2ibGfkCcjxERBTN1QhuKJBIX9wOIG+ztsZ1MGdUmsSPVgP2HKWuVnnLncI075VxV+rbm
 7t3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771950959; x=1772555759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCtfCuHENWEXCalHDflSvkISbE8QjePpBnrO1b/uMEI=;
 b=aKKqrv4sy3Zzvrk1wuYs0p7JoGBIEyCdKCDSVxMNJQASZhcvv8r9UfIa3J9Ohm942U
 qLKTgEMFu4DRNqGWZnswGA/BFo7pwVMQShT6G1WyzaKJPC8Oe5GBSJd37GTXQrYoqnZU
 +fUVIghwejtNxVIisBKBS0NDndjEItqF+UCJAM9LFrde2rA+LT85HEuSj/PQOJ0SOVpY
 gwNFOZJ2OIgdfIqCL0+sNWf0lSDbCiDyIOqKN+nysCDYX5Fjd8NJz3K0GkxRXH/jUs12
 6pne66ct0ve9w7NPu/GhltwqKGxOdBXKUUCBycLspASCyv4pIFQby0TFNsWi+rJl8Ll6
 HU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950959; x=1772555759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PCtfCuHENWEXCalHDflSvkISbE8QjePpBnrO1b/uMEI=;
 b=LxNIq9KWSpc8ZtCyUIRrv79c52Rd5/V/lHXwS61degY5M9kbE8mXK2/M0xECB9qHkg
 AZPTcSREMHkhFuHVHyHBji0niHAYStgGFRvY95eh5DLbv7SsQKMgdV/F00vA7D2SSSut
 zN59yY6PzvkOp7ORmu98xZff+V65u9O1wmCavu9M9y7+0SCRjSrjiYz1pnN7jITrZ88j
 kZ/D7y59mLTwWw7Awn5F5q+2xZ9Rmatc35KnncD8+eVl2HUwiEert1Jl9n+QoPP4PZ6M
 Zhc5v5yibEW8nrkZV/LNAu2lluU4haeNwY3OtQih5Msilk2VXSCx6RezMa8S632eP7mD
 JRjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI5CwBkHbWtZDv8QkZgT1lvSRQpDz24z3AGZl3DKE9q2LSL6jKbmRRKlo/gnZ07y/VVS+UYOmolMNj@nongnu.org
X-Gm-Message-State: AOJu0YxJRBFTVBZAVujyv3xXa/46FS+w8b4OBJq4TRrY0MIDuoW23to5
 2mZXHs2p1loiBDCc/++AWoQ5ZcZMdRk53kMdUD7ATOx8RCls7dtQjb24gLhXosbZ10jSw6+tWmI
 dVitJO+YaZfWoJvdablhd3JJHHMC2vpI7lTxgIqOk
X-Gm-Gg: AZuq6aIh3WC/MPITYXHBW2HUyX5niRHBZWXVTcKgmnI1H4gvtZfWJNNz83mRucuVAbh
 gZk8aZTJT6MuLeJwuZEv636tcNcR1xDxnU4wRK+V2o6nuv7homWWOvoMrd4xqIkry2lTrCs6rAY
 cJXDD1K4I5gsClQDKpbxJhcUJsA1xnvSj+pRTvYFjTZ5hPMWPGBVC+jhl+MAud9BSuzbO/uvOuc
 aVgKdq7+xljvuRvT5XKzcgkqFbpv935waWnNkr9xxTFRktgBmQPzvHpwNtQw0wWuxsrgyvw8sDW
 KiG+1+up3IpmjMVqM5j9fL0FN/mRPP2LUc7p/dyCjaqbRK37I7jnERsS+ORovBeU1SdJkhA6ZEo
 EdAQEtr6Labls//BEm2/HgqFUCyD4ZeaAySNH
X-Received: by 2002:a05:622a:15d4:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-5072df03d92mr11183981cf.9.1771950958651; Tue, 24 Feb 2026
 08:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
 <20260224053613.589102-23-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-23-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Tue, 24 Feb 2026 08:35:47 -0800
X-Gm-Features: AaiRm512_eNhMxLtQ6PtJok3ExPxyEcPfHX3ysWfbWxnFzdSEZ8ZKZU7nZAiz6c
Message-ID: <CA+QoejW1sU6dGFLaveLu36Cu0pk08erT_d+Mpgz_uNegAH40tg@mail.gmail.com>
Subject: Re: [PATCH v6 22/22] MAINTAINERS: Add I3C maintainers and reviewer
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "komlodi@google.com" <komlodi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 23, 2026 at 9:36=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Add a new I3C section to the MAINTAINERS file.
>
> List Joe Komlodi and Jamin Lin as maintainers, and Nabih Estefan as the
> reviewer, covering the I3C core and related files under hw/i3c/ and
> include/hw/i3c/.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Signed-off-by: Nabih Estefan <nabihestefan@google.com>

Thanks for taking ownership of getting these patches upstream Jamin!
- Nabih
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71..7bf78e0691 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3933,6 +3933,18 @@ F: include/hw/i2c/smbus_master.h
>  F: include/hw/i2c/smbus_slave.h
>  F: include/hw/i2c/smbus_eeprom.h
>
> +I3C
> +M: Joe Komlodi <komlodi@google.com>
> +M: Jamin Lin <jamin_lin@aspeedtech.com>
> +R: Nabih Estefan <nabihestefan@google.com>
> +S: Maintained
> +F: hw/i3c/*.c
> +F: hw/i3c/.h
> +F: hw/i3c/Kconfig
> +F: hw/i3c/meson.build
> +F: hw/i3c/trace-events
> +F: include/hw/i3c/*.h
> +
>  PMBus
>  M: Titus Rwantare <titusr@google.com>
>  S: Maintained
> --
> 2.43.0

