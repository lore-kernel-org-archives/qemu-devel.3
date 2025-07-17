Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34CCC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTNy-000532-JS; Thu, 17 Jul 2025 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucQex-00049q-EK
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:36:35 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucQeu-0006Gv-U5
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:36:34 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8bc1258b2eso889035276.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752766590; x=1753371390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XVo2bXdUxDhLG7R29MKUOxOmyPRvZ8AnbYNITcG4hQ=;
 b=VWsageEPqqZntjeKj4diUfhLzXo6zr0NrvtXSNPhyq0ImfKOyUyM5my3xAwrRKTxkZ
 VvQlkHMMCSsr701DQB8xBdGkqaD4s9jAg8hX0q/vDTvCYXXuQYSNPDI8mvvOnkz/IAWK
 FLje/IqoNt69gALVGB9oeEdAtkFBhX3RycUs/xhfQANAQy1zant7pX7+1NkWSbSTjGp+
 ZxjVukCwxlSRUIj1bjKaslPW7LIyoad5WbLNOdfkPhPql5Ngw9D0DydC9VuHp8QFaI3t
 XLy4lt8tB4Ua52Th7Irx+DUby0EZpyS7whJz47GdYuHgtxbdFWnzQly6v1Ox2r4KFy33
 xdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752766590; x=1753371390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XVo2bXdUxDhLG7R29MKUOxOmyPRvZ8AnbYNITcG4hQ=;
 b=wvdTk/VYmApIGvhGuo0v7A4DkkrQh/iSCOgPamAAk7S7KXoaFHdrfKduMz1Nwyco92
 zcJPbT+8OQbPK11Nfx35Rg6NBZb1KSVQ+k0zGfECHjL7oTQGdsejuOUYDHNGvqaEho1J
 ZGPGNP6uNRAJUuFzmEB3W/JZ72L6/2/Aw+h13CRblZ1ozid9PovfeXHHh/pd78h46mmT
 w4PfWlkQTAH/HOTUZ0XOIt2Ui3rsNj8UqbwuJjZtR3RnqvfNiqcVniwguG8wis52a6e/
 Yzpd1ewo9EUyLTTrxktL2vZiWwb6hGg2Q9avqd62T61+uhL+qBIHd79DSkXcHZVShq3e
 69Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQw+yPcRF3ZPEzPMoXn8MsQj/cEItxbqTIz2x9rZVIO4ZwEieOms0HTaiH4uW8Qy4ePaXEVc9QBb06@nongnu.org
X-Gm-Message-State: AOJu0YwzyTbasoGKsFdJDp7Vd04zrHtIb66pxI+DhTd45B/CrRm7584v
 IfVP7CxpRMIgVz4pdOCho9VR14DwWIyD6iRFK3QxdKISMUzlWSegelGea0FNKoc7dlnm3mSbq7Y
 Lhyz8h2S0gaL0LudrifHHHKcT7q6caeVMAyiugAV9Gw==
X-Gm-Gg: ASbGncvbcYcmXT+sxQd6jBe1b8a7AsoTV+u9J/uG7Gwt7PR6akDmQffVZ1JT1POj073
 napCir2yfT6g6Sgs+0UGVeyJXRW89JYUQ83u1jmwCtum8FJOHMZLU+aV5VYzdsi9lKjrnbE1if/
 YKjb4PUYL+YKvbNOT9aZN71vuQ1z/sNBMGmCasuBfStzc+WY5c+3I5u2oPi/NKFK7hUegAtOX0S
 heaMirf
X-Google-Smtp-Source: AGHT+IEc82Stb7vdFyJLAbi4D+KzLmB2iw3wv4zDOEyKSWdtk5KL5/WU0WGjh6Re48Yaeo6Fvb0w4hXVNhU7mlSJHxQ=
X-Received: by 2002:a05:690c:2605:b0:70d:f673:141b with SMTP id
 00721157ae682-718370b0d5fmr97974027b3.13.1752766590295; Thu, 17 Jul 2025
 08:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
 <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
 <87a554z5wp.fsf@draig.linaro.org>
 <B08AAF88-3770-478A-8589-ADB407878B19@apple.com>
In-Reply-To: <B08AAF88-3770-478A-8589-ADB407878B19@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 16:36:18 +0100
X-Gm-Features: Ac12FXzNZAgYbfyH1HfExqEi1wiIdOom20TdEA6oa9pEE7an6buiNpZpLFsxIG4
Message-ID: <CAFEAcA_s2zXkSZCWXqJ7nWTka5wwBPiKJyHmYE7fGr2=fNsOvw@mail.gmail.com>
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
To: Danny Canter <danny_canter@apple.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Joelle van Dyne <j@getutm.app>, Marc Zyngier <maz@kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Alexander Graf <agraf@csgraf.de>, Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 17 Jul 2025 at 16:16, Danny Canter <danny_canter@apple.com> wrote:
> - The new GIC APIs take care of interrupt injection, and would need to be=
 used in concert with the EL2 APIs if you need interrupt support (highly li=
kely =F0=9F=98=AC). This would
> be where I=E2=80=99d investigate on the QEMU end first to see if this wou=
ld fit within the architecture without a bunch of reworks. https://develope=
r.apple.com/documentation/hypervisor/hv_gic_create(_:)

Ah, Hypervisor.framework supports providing a GIC now? We
should definitely switch to using that instead of our
userspace fully emulated GICv3 whenever the host supports it.

thanks
-- PMM

