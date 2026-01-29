Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4257CD6B076
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTxK-0000md-4T; Thu, 29 Jan 2026 10:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTxI-0000lt-Oh
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:29:12 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTxH-0006JY-8W
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:29:12 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-794265fb73bso11256887b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:29:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700550; cv=none;
 d=google.com; s=arc-20240605;
 b=iMKF2y4lykTEEtal8cCh+WpXHSETKiT2umWjsT/ROJwTKd2UnZkWMuop638zWXMPNt
 +w991Xq2eFGJGr0HYwSlTywQWrc0luDJ/K/fX6uVu5M24O3f/seqeXzVXvHgbmV4FW7L
 eDLPWlZ3i2uKtfrwdWJUJeIX0sFwxpy9yvboyMB7/swX5Lysps4cFZRnRa9DhhE9GxEe
 b2moUtMN8eRHlK7xKuRtnSvG6zGJP9SJRhUteak0VuKfypfmXjNJ9cxnJSFUxCe9TCXi
 6plNKvLl3CoOjk9HFrGnbDLXFUudSQrcA+0hILx1VrMHC/dNO4SgXYDiG4Ls2zIEXFDY
 Dl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZBA5Zu9U5fRJlrNmY/yMVMhQUF0W+nyt4RfDpHFCs7A=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=NRYAICX3pj+NueF3QnJFbrgqiZbnjy+GuPt5Ay9J8lzKtXsTyQ58RnCG5ZXt/3uKHq
 Em3KFubtXGjZrp0u86wXN03S24AVJb+YpoafAM8IvnfVEO/Phz/4kckKFBJW3ibttIxR
 JUnxhq0A9K4Gnx1Icb+PccePTlvjGTYeMYsdauTALaTrZrNElhSL0BEfHKHTeFyAJwcP
 gx62ZwaQVWhUu+o2tlQraEFyIWE2Yah3DzFPIUhQTVWb/sgE7ZJSmqbRD7Wu0AvhMFRO
 kXRhfSgBpKwb/IBDScK5cW4UmOjzg6q1thgIHFlGd3L81nToX/scjr+Rdg/lOHiywDwC
 +fbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769700550; x=1770305350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBA5Zu9U5fRJlrNmY/yMVMhQUF0W+nyt4RfDpHFCs7A=;
 b=igjMDoYIbz7Hb7WkY9QC69pyJ4DirzmKFQStIi0Ri1WS6FIYeDax81+7VfUfsLpsey
 elXw9XFDYNQ7im1nHyfSDr+h/jj0GmDxw45GQCrykAt4ioB3TSYoaCa2ksj9eBvS5fUI
 8gWQqX7qRU6Ck8d2/iHzB0CVCxKBwPHZ5eOLWhx5P4T7MIweOm2lyy4p5DUmoxqntLoo
 lRljcxJ+fLinKuWk+JCGc4C+sHincrei1pAiimoUKi6VlUfWLZqqB1xIcj+IDwMGWhI0
 ZHKF+8r55VIxrZb002xRhRc7mvctlZQdqefu2pTA9z7HO2EVvzDpqs2YBqO42JTQdDqm
 OXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700550; x=1770305350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBA5Zu9U5fRJlrNmY/yMVMhQUF0W+nyt4RfDpHFCs7A=;
 b=oHqKt90ieddi9O6tEiaGlForKM2CchJTpXzmqLk1nCmeCl11ZCy3nJhZQAVDFz9ynm
 Te6y+E8lmnWAKkuPCGiqznywl22WIUeI7YiDjNI9pVraFErMEuzJSEx876Nsk2ZhLguR
 qa7IJZcBApW7warPD+9HYAYkqebV4AHvac3qxKC0XhdV1NHi8/Tn1Es/OBgOb9psIXpW
 QpbfB7seUgniUxz5WkGgqQiQGj03mnN6ss1e9f5OaCJEIMWFccvDjiFMr3rsIrWo81wA
 4FiB5xXpy/vHad1Q73iwkFxxT7avK9N0Gi67vySQYrOdvCZpVXCNWbFwv2lBWgTJrw9/
 LJWQ==
X-Gm-Message-State: AOJu0Yw+JGuhpaM/d58YYft2NF7SLm5m3Tq7o8TjU6/3dCRSUE9PZMaS
 IdPAgtzcP7wrtKdYiOgohAadgVqQRWW4iHBhTrXLz6JOwAjRzZjtbwwD63ZdVO4r9PB/ykbqifN
 jlL1b3LJJjFeJUnkWBgR0DhhW59LzxPK/DFasqbn5Sg==
X-Gm-Gg: AZuq6aJ+0LCf3cIVPX3NhwPfoLNy5xuC4pbLVkcBLsFPmNuytIB5kZo4ls+F/4eWSIl
 vogNLdFKTmSibDLUXX9a8M252by7c/rrtzwj8gFAEM1WngiCt/j5FSuVeEkh/voMOTJvhMRoi0f
 0290TYsFyxgtDi6QRF6zMRWB/UrSA/GUfHzQTH/e2i0T3qwoKZKhM03+g1ECwI3QOMko7Q2vPSp
 q8uT3pUUMX2bnyUcvcI5/HjCJ8GvGvrP+yKEOlOAa83Jki4+KXFVimRcrXf4/rkcuBTIgGNTZmC
 tsl4
X-Received: by 2002:a05:690c:e3ee:b0:794:6fed:9596 with SMTP id
 00721157ae682-7947ac00e59mr73402977b3.39.1769700549808; Thu, 29 Jan 2026
 07:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-14-mohamed@unpredictable.fr>
In-Reply-To: <20260127182805.73212-14-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 15:28:58 +0000
X-Gm-Features: AZwV_QiK43RPHfA6TW6CJMG6ld34ywvsRw2H7j_blG9KQWHBXtk6j-uDJe-_3Uc
Message-ID: <CAFEAcA_+o2BRGPjk=++2pkZpN62yPKRhy4sx+7kSvXcee5ofqg@mail.gmail.com>
Subject: Re: [PATCH v18 13/22] whpx: interrupt controller support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 27 Jan 2026 at 18:29, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>



> @@ -2143,6 +2146,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
>          }
>      }
>      if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
> +        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
> +            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +        }

This looks like it ought to be an "else if" or some other
construct so we don't fall through into the logic below --
if we've decided we definitely want a GICV2M we can stop
making decisions about how to set vms->msi_controller.

>          if (vms->gic_version == VIRT_GIC_VERSION_2) {
>              vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>          }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

