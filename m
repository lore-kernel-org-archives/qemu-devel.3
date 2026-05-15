Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD7ECD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNpxE-0007Ng-Kf; Fri, 15 May 2026 06:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNpxD-0007N8-30
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:39:39 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNpxB-0005PX-QH
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:39:38 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c396d3b36so11791938d50.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778841576; cv=none;
 d=google.com; s=arc-20240605;
 b=YDAO+ZAMqjy8Vv0UjJJyJXsVaqCiZQEAzDViIt9/tOsAxRqyDCWWOJx6KnYcMQpO/D
 qP8xVt37h6NtvZaWNM201kE7aO6y3Zcvlyheub0mB9dzaetj5+n6MJz8pyMSQkcnMlXs
 t/lAgCQjWDRBkwiicIeRMBn+cRJfYipzF405KU0le3853p2IHOUc335fs9p+s5TaAUnw
 z9z/S25lWnMngGO4DBfQi6AP0LJaAEPbKhxdqDehXgjvCv7aPc+E9Bgl4LTnO3rT0T7T
 ghmiz/wdYviNSGPkAp13cvY+T8MyqOtNuyaDx2BGfn/oWfYWsqxFVnt4OWBr8yuejpeR
 XOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8V9MsRPAtrfGNpaBIrVqmbcRuCD4OEpbMZ0Gmq5IewI=;
 fh=4YEFpNnPkA7CDFIH8AQnfynK3ALVwg08iwCq9o2iTYQ=;
 b=HZBjG69i3lyZQY7EQW6qlIE+9eQFKycmtrQ2If8kqOjFWoVh23WtRywSy+bbwcM4FA
 xcJ3ZQI+itGUAr+Il+3Hf/WIM/YOoUFhBZjSErfZHh0BX8GHxq9OH5pIIP5QqjWaeTtf
 eFTRW5fJGk05MC7hJwSW5EWRfs6+8wNy254c/OmRYAf0Yy6697KqKSUmZNN6BJeBXIyD
 eKiLzQOC2+/c80DLC+LbHpM8iUc/n27EjewvwQcB39LLhnCFjgKY3MFmoGHomVPan9Yt
 NXm71vbaH9QqbmLQQweHQY4q19bVu31Sfcav47iE5eGZcp6H+pCccplsho9Bu6arAta6
 ExjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778841576; x=1779446376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8V9MsRPAtrfGNpaBIrVqmbcRuCD4OEpbMZ0Gmq5IewI=;
 b=JspHA/jEZ0ALoB5rwNy5tsi97U0KNNwXpHUFXEti5JCVLpOs6uGQ9bWyJw0VrQ/CrG
 My4+BEA4KaYBNlV6pxMJixPTIoM/tZsTINRekt/kOrNBvHQ+/0kJsevP2H0yXumS60u9
 /ifnpGgj15iGKihr3sTBm18DlWowhz2dvGsI62yGtWiumED2IrZUCzlIaDftL+C4PG3b
 U5w6j1Gd3t/A8Btlf/90BJJo8WT1v8T6XoPyPkqCZ7mAR/xjdhmSrASgLA0hE2nDc96N
 b3gcQoVyHCfeNnD12C6q1xrsR6mJi1KxnkfOXXCmFxptCqYBSPR5bNcisJGDQTXm9aDa
 k1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778841576; x=1779446376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V9MsRPAtrfGNpaBIrVqmbcRuCD4OEpbMZ0Gmq5IewI=;
 b=f8otZbwYcNTkQX1mh0YVW17iMbZAwWhyfDSV8M4r5D7RobHoTW6zbLDsTOrFG96k9g
 AQd3UrSQWbfQL/nPgtYKSbGJzu8Tp4p0IXzudZSaVnE1YM5rBldvtjtI/3x2u7WhL3i0
 x8uBVYOIEAvRl4ppHA29dGd3tZKwTitLQqn6f0gsQF2shkAk9wN4o3D7JH3o1kMAPLOf
 1fh0gurpH/RI221wohN6ZJM/jJsFl0qPIa1chLK0nGAV24+hRaI13KyWeBIU/KbY77Zz
 KO8hSgOq3Xj5hv9M9cV9hstg25lAEPnWOQd/JUJQg9ufZRnpwJoTJVLWcOGrGScWM8FZ
 vglA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NeGFNbA+jDsE4GiqTeX0oRQX/o/d37rUnXPs3uDvG1di3r6WfO+KdmHRqxkrE2ze6CbUcIVecIaBs@nongnu.org
X-Gm-Message-State: AOJu0YxS++KpD8OkNvinRkS/MHKI8waEg1RmTXOMAJP+EHN0fx0e7JEB
 xvYpeJdB39VI6jtq99DuKnudlyN9Zcb7Dro2NvmlLu0d9fW78a879QRvxQRl0ElLtfkmL1T1K5e
 HWkR2o15SHljzdxTRX6AkN6ByEBY0xOAIwQsbwLgKXg==
X-Gm-Gg: Acq92OH430S/7KhbyOMlCMM+XmE78hoJECBWgXJ2lU1e9bO3JehQOBumvyr4LkFalCR
 LwH1Q6/I3ZALbZbrwCH1kfGN8yQ+P7Zavs3F2lFIhBAWvT2++yW2YjlG4uWxK2TTlAwm0moC7n+
 BadVZC+sMv5K2dzxNZXQlAnIF6ZCEZbwfbOkRYCRDkwe7wed/oitVb2PgGsashBNFBDhCGKwJxT
 dPEOhjbXQl0j6V+aQIfUo3U9eSUw7HGQzq0MUjaDPhXEKciWbieXQDgjnWK8OWz/4C6jcrjKF5j
 aeV8XIFrhdSCJn2ml1NSA5t9nPSmM7dKCwZyNOeymr5gfXsnMQT+XIeeD9sQAex80iU=
X-Received: by 2002:a53:d047:0:20b0:65d:7e2c:cbe0 with SMTP id
 956f58d0204a3-65e228e63c6mr2588404d50.55.1778841576196; Fri, 15 May 2026
 03:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <E8468087-647B-45B5-AF4E-85DD15A6D35C@unpredictable.fr>
 <20260513022109.14107-1-scottjgo@gmail.com>
In-Reply-To: <20260513022109.14107-1-scottjgo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 11:39:24 +0100
X-Gm-Features: AVHnY4IX_hjQfNJWNgwLl3fNZZjt4IBEdXLie5Ju8_mLEpWeWNg_39Y7NlmnxeY
Message-ID: <CAFEAcA__VLg89_c3ZJMfN4BJs4sJ4KGFKnNVOW9AppoARRiMtw@mail.gmail.com>
Subject: Re: [PATCH v11.1+ v4] target/arm/hvf: Fix WFI halting to stop idle
 vCPU spinning
To: "Scott J. Goldman" <scottjgo@gmail.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 May 2026 at 03:21, Scott J. Goldman <scottjgo@gmail.com> wrote:
>
> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> changed hvf_wfi() from blocking the vCPU thread with pselect() to
> returning EXCP_HLT, intending QEMU's main event loop to handle the
> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> always returns false and the vCPU thread spins at 100% CPU per core
> while the guest is idle.

I've applied this to target-arm.next for 11.1; thanks.

-- PMM

