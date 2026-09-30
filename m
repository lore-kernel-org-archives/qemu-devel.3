Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848CACA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1k6-0001Oj-Bo; Wed, 30 Sep 2026 17:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xC1k4-0001OX-TH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:21:32 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xC1k3-0000oY-EQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:21:32 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5ba3fc22439so952843e87.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790803290; cv=none;
 d=google.com; s=arc-20260327;
 b=oYh3LEGEnlPJSx8T5j7cDuNxM/N3maf8PoiSKqccSMJP1c+I/ad5tcJrxiVNW3A5n/
 tfLjJoPieGCIoUVoLPyovn53XdQmeqWHb7UIVIEmZtKtcjILD68655UeBYtYnBTnQQp8
 HA7hkWMkXDfDrKLuXfjNZWmlkyPSRYEGA4CZHQ2tIC5haou/ds3ECLD218s6bgjUllxS
 pu1ppTmlbt5YAmq4YhnIqpg83RimaBbZDZtTgdH9+mae5a4BFqbMG+fkihF/rcqZhNGF
 D4ETg412JBOVpy66TcokeP7Ymcd8Zee098G2drxdu/x2F783VaP47EQ7ifDvQEXvthvF
 KTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nlMsKXdEO8oh2PwAOtwXcRiX9pmJpziNj9rb1ympYJo=;
 fh=YkwhcuwKMkpFEIaJGc5NHBRKJaqNxc2bA5StU/QRRmg=;
 b=pH05Wx+Hvvx+mYAzKksmBuSWUCT6VDIUN8wixz2afyEqZ0d0i0zJ2aemjvf3fmZfut
 /8lME4ySJveBsHkNBSFx0+kKp449x7y7mQ1BGPNPsz+qgxjgB4HNXjedxQ8dxuBMjBTJ
 kwXx8/28FpJg4bqlnNEzlgyUR98DlWzWbGJF8iOWpyPvJfOlqD3im1TBvHKWCYKWzT6M
 KJFuxd/sGEhT3xx94SO2MYDdR7t7ZHiu8Ygx5f64qaOY0bYlgD3wWr5dKD1Rg36WpuPS
 ksIZgK7oUkL9Ppl3htgnCg8bJV331z9Zplz5lV2/HYZPAwVV11oQN6caMmSNKmc+Orbp
 a/Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790803290; x=1791408090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlMsKXdEO8oh2PwAOtwXcRiX9pmJpziNj9rb1ympYJo=;
 b=Jiev3zX8jdRtYfOo6CTpaM9rdjo+gfQ5VOQ8e/f2xUAcfqoVSGuGiJO6wMPbiBVrW1
 K1V3jT/bgk92cmPCpzfCb5AB01L3XATKe8qdQdmFz3433lDN+kZz5qETIORAPhNQuXf0
 FwCeTfxaoNz2X1MlmbIoXATB9z+BAQLd01sT1RkvHyl82D0L5e9pLaVpmW591p7pakbI
 MvhxYjmW8lfcHo4sJamNWltyp1iygn/fPXhI81eBYTCFf3n/aNZU9B+1WgdazTIhPUSH
 tKCT5GqlWJL53yyywS6yNVekMTULmpmNM+O67pOJ2QNTU7UgR2mO9IbphBPozuygTCEo
 lSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790803290; x=1791408090;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nlMsKXdEO8oh2PwAOtwXcRiX9pmJpziNj9rb1ympYJo=;
 b=pYATWTHEU2rFGfswHffsAsEqLypmhreGQ0T5YyfoTpmr6AfeLeTP8Sh0ovSUflG/G7
 7ZVcr5vuh/RMzCInZjHOz11i32sewYb36YsTI9fHDDieC/1JmkQYgBvZyHVS6A32Qp+B
 Eh9FasdcMlsI9xDb3+sg4jTVpSZntDCFQWj6Afhax8jldhQwCQuqQbUl96XYrOuwotxL
 EnryE/+8ClaY/OIaQOd0aKxe7xh0i9U5pMi0hB9kAvsc2e6f2ndT3+s6mgDUAPwyXRJr
 t7l7BuQ77IMbBQAy6+2aODkqv7uY9GJCmD9Pa3FyK2uGn2paMN5uFI2cP/Sa06Vo8z1W
 /mvQ==
X-Gm-Message-State: AFq9FYJMcW8xHcRbOjfc3kor9uyR33POxY+nThiuor1R1NlVzpGw6FSS
 wXmz1IQdlwBnmnYCzlne72OFJ5s3VIcWzLJ5orY7agb6hROmqAN8TOMuSQFeHUhOwFXs2LeJ5oy
 hegnXh+2nrnUaO8pMMN7G3gnlwtZq2l8=
X-Gm-Gg: AYBFou1F/DocagAfOHm2pudh7FqrPRsdHzzuWsfawcGSJbv0ju5NbmcycpHEn3aIoJH
 TEV4HHkBWMJf0cELxDieKIRHecaP218AO82iX4gy8jG/5cb5tWfURw36jwmBSx+X/0S1o03rHO0
 QbMAJXHOY7hMKxRej+sVdS0HSG46aYoLAVAKzhe6H/ank1rXfJa3qcvuvfMDhG781pTE6g3VbLm
 QtayLmMYHWKk8wowJ8ThLaFXXR1GbSD9yebBXZaZIFSQx9VKjkhy4PWRyaPWFU3Lp5hfnJkiu/a
 787RnQ97DHGWNJIY9+Kg66hKtug0n3yKITk2HHVO9fBK4xToqGXO7KxfjtOORfnyvv/cTTR+He1
 Pc95mnjJo3jQF3g==
X-Received: by 2002:a05:6512:3e13:b0:5b4:adb1:b25b with SMTP id
 2adb3069b0e04-5ba403e89abmr934792e87.14.1790803289370; Wed, 30 Sep 2026
 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260926040812.725493-1-mattst88@gmail.com>
 <20260926040812.725493-3-mattst88@gmail.com>
 <fa0a483457c6fe97dddb1c671065dbc9583473e5.camel@alistair23.me>
In-Reply-To: <fa0a483457c6fe97dddb1c671065dbc9583473e5.camel@alistair23.me>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 30 Sep 2026 17:21:15 -0400
X-Gm-Features: AclHuK98cPrlfe9EwqyBJDeTnpJYyurD5gtHKIF7NpWadNhTsIv_zZ2g9ZpMuO4
Message-ID: <CAEdQ38HC6CEvajfd2HsXmLq5ZhhCpaqy8=pZE4ZLAfmxXb=JmQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user/riscv: copy the executable's e_flags into
 core dumps
To: Alistair <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Sep 27, 2026 at 11:27=E2=80=AFPM Alistair <alistair@alistair23.me> =
wrote:
>
> On Sat, 2026-09-26 at 00:08 -0400, Matt Turner wrote:
> > Since commit 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags
> > for core dumps"), Linux writes the main executable's e_flags into
> > RISC-V
> > core files, so debuggers can see the float ABI and RVC. QEMU wrote 0.
>
> You are missing a Signed-off-by line

Sorry about that. All three are

Signed-off-by: Matt Turner <mattst88@gmail.com>

