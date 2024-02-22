Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DDFC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCHO-0000Ws-4T; Thu, 22 Feb 2024 11:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCHM-0000Ur-1E
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:50:36 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCHK-0003zO-JO
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:50:35 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-564e4df00f3so3712110a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708620633; x=1709225433; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgOPU27vjAp5s0THB3860vwQUcK4dtxv/dD/GiIAuF0=;
 b=tpC9QYps0TCa9cGbMtOKntOm8JizHPpjG9hG6awMECtdqneTJYo4WSDiSKxfzn3Gwo
 nuNWW/lDU5iu2M7OHqo8TgZJJf8q7m4aSKkaAj7MFPRxcOdgpdE6LOcoDl33L+1nn1tA
 xSEGyqCnxOcTFgur6FWdeHBdnDBNf7GoZEA4YI+HEvQFbc+iBE22nQX9Ouc/kHuRybQw
 KbfsDVFc4DxMy1H80BycxeqtZ0oWC85Wi9sMcLB9X3+IVFbH+pWtrROCkqjNzs6pOEqm
 pXaYSSDpX/1/fc4MB8/rCxzMpmE52eXPf/QdTqMV5QrRX1G+8pu2FBoXMhmd9rpvgvPj
 i24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620633; x=1709225433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dgOPU27vjAp5s0THB3860vwQUcK4dtxv/dD/GiIAuF0=;
 b=AA5bPn2hoR8aYTFg+Bk/ZCaqdsrVW4SkcJvQhe6KD+rY5A0GsCp/OnU/8Z3NfAlRp4
 XLAhUcgTXlz+alh7VNgHBrQCC1Zju7QKUqswLcYGkp9wKxW8hWv5kttSt91r6jqUqvw4
 gGiAbhFMJJzb07xjP29WsNU1kQEmKoshDNmuukk4+U+fbkloqjHBmF6SouvoHtx32o2r
 qQ+O/ADN97Dwsfgve4Z7g53OOM8atFKG4sEkUsz6d2wbJQ6VjTTo4icAOpRlXGo3oW+r
 qevVKgAQxEXc+duomxESrkN7RzWnoy/NP2IX2FQKWcpB9YmB1org99PCukUaUbn/ozE6
 4V+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrKgmjxNbG1BASZ7/L1codbhJibjmkWgTfD/Ej7daI32tYbdCV11d46cndz7naUdjx2hvMMw9Ye30+aPqAmZriZWJxwxg=
X-Gm-Message-State: AOJu0YxhbIibmUx/K5nFROG1iUQj0IvH3wzc8uBRdci7NEMLTS8U7DPP
 YZAnjeKzNXjfeXxVMxTTyaYiTuclg71UoM7s/tBDQMiBWbVJ7oypKBgDrEfiVmr+n70z8Rf77eL
 IZy/u5jVNwdTOJjHQ4BLl7opNcNYN6iUZwE352lMqrNpkBEz6
X-Google-Smtp-Source: AGHT+IE11nJGmn6UR0oFtru87IIQZ/qx48u40A5a6siGgijcd3YLw/REJzA8MFdCscqnWqZsbR8VOQw/7RsC4c+yBc0=
X-Received: by 2002:a05:6402:4301:b0:564:27a5:4289 with SMTP id
 m1-20020a056402430100b0056427a54289mr11129961edc.18.1708620632998; Thu, 22
 Feb 2024 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-4-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-4-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:50:22 +0000
Message-ID: <CAFEAcA8UrteHW64EHpSrgo1d4Mth_p5RCPMz2Q3cXkSSFiSnDA@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] ui/cocoa: Make window resizable
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> The window will be resizable when zoom-to-fit is on.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

