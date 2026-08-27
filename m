Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8064EC61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWik-0004jQ-A1; Thu, 27 Aug 2026 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzWij-0004jD-7S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:48:29 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzWih-00055V-A5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:48:28 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81ea0b7d137so20876567b3.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787824106; cv=none;
 d=google.com; s=arc-20260327;
 b=Lj2u9+u6R4Y8LV0yyuPCjR6wSYnuaH/OiN7TsDaffS/0RaWdgmYLTdhJBRfwfhXuMS
 YMlwVi+POPDc5OBn2wHytPfAjqi0tWA3b0PP3cfBR+rs+qX8CYeQ5ULz9lu1NXGWYQI0
 CFpX4FwFWsr+RqSEO6gxQoJUnC/x7hYBDN/yRTiz1kzumzCrC9sl5NL6YKpQGeOe1kY9
 N0YwJdzEWSWxCXEkwZwvueUjt4Uld7LSugzTMr8lS6r8O00BRre/66aq5rclfvlsmj+u
 4LwKWo4ZpzMVFHSTlFWNhvtx/BvL1d8sdJczc5h7aJbuDr5SiXzbhRNkfFaPRbxXYx6F
 F4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sHCnzV+x2eg2b5OxtZhbCRPxOklRYRvw7EVzT+L4Sxk=;
 fh=QFzjk5Y/nR/g10pdLemc5PgFvnp7BZS5BGhAmf5sjDc=;
 b=lRaxjJ0NVLVjr+3jP1xw+a1MugbmsQ2uiH83xXUL/2EoRflrDtXsQacj6FRmVaB/z6
 AwBXeiGJu5ii8xDWKUEgUk6AzE1JuTjEx2L3ODo2bKaJ0TIbDKhrL2czIiWZJQNImoAV
 JRhLHs9X3qCPXxBSfLOpAwjZLCDJL7/qJZhbyl4DRVAK7TzzuJIMLOyu2iu1Jtc3qVat
 lN5jdjZId6Ljeeq8t2avrbZav/hXA3FMfwsmPydAikWqL/Xkc2m6Rx1YavbEH6W39TEV
 A9AD8WHyCNz/vS45XRC/f37yOCVnV17CD1CvRGYX0nuCKB2suK2SSrTHXDvCvG/K+U0x
 fKdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787824106; x=1788428906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sHCnzV+x2eg2b5OxtZhbCRPxOklRYRvw7EVzT+L4Sxk=;
 b=KQPdsZPc2BzVp2gvKBhFpncVIvME+KrHq+M38CFeYgvyuCMp1E4rw+ErEzwD1lBdqf
 tu7WmJh/7s+SLAD1MRNzEG5fPvTMgXo3KSQkVHqirJTy6mumyOv8b/N26ixgVjJlheA/
 i5kcULsGPcTPOFgvjJEeldFO1rissh8AnB3dNposMIwaYhgLLuiW9cG7H/nKJlroA2f6
 VxVI2WGfGBMwR5ebzr2TjZqUMnnCSK9XAJ5zE78mSF+Tnesy2/4Pw3m18fvBxRkLWOXy
 +aTfaIYxkzWta8YXgBwtNWy5xftPGhN6HMAMIUVqjxHfUVLrnGiUtGGkdbXXq3z/IvUS
 +V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787824106; x=1788428906;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sHCnzV+x2eg2b5OxtZhbCRPxOklRYRvw7EVzT+L4Sxk=;
 b=Jb6K8wW4/VONR4AaICAQYYz0QEbJu7li5me1LsebeBFCsWs9yWfUi6PrO+vkt4vTNt
 Y+n/3MaBV6qKfXS0kVxP49Cj2jFmrtzsZuRs51kXw95qAq3lxf2+IrbxNWdvIkqgxDuS
 opLlLHcrz4jUdqx5KZsLvTkHGQ8tMkhR9O8AeF2jsAJJvNpGsaW2iq/R8jkwGPPHSwBU
 eKMk1PCxw14pfdSn9zxz0wWGXPm8dQKSt8nR3D23GNpcWM0kJZT9/+LYtz7Xt28xDDIR
 5RDVEBbxXT8mMevaDCTu+3Yw3DJN7zsH15A1o0VgHGiZMt+JaBq8XV/lAv0lI8VTk4ec
 K5QA==
X-Gm-Message-State: AFuF++nnDIk2XEljnwjqgRmVcAJHqVurUsP2YKyLya0BJJ23PWxcXIuB
 h+Q04wN5OrqUEP38dO8vorWYCyGUAx68++0yXFpjt1DCyM4l3RIn27NzNALVIpJ9TEchh5O0xej
 hUlY5TDqfTfGnieVGOU81HuDq9/0t/sx5+YnrY3klEA==
X-Gm-Gg: AR+sD10Jd792lkcpb7j746nlhzgbdLl2IFnBSEYLwW0CRH9EEjIEpLCxRDkVfAyfn4i
 btvecxudpTWx3BZ0fs6bL5lyIYfGgrC6DBKZDGTzh/r0+1uJ/PhKSgvfi4xKXSs2OI5hAI6gJ3e
 N7ZLh+umnS1dJfjD5zjtEyfJwmjRQdtnmNgmgB8G4YOohXoegU4O/dvmVE5R/bZ5IQmh0xKthk5
 U1Mut0Unu48g0g13Y08RhS/sgQPQvXZouOZXPEcd9haL2ac15l5Hu9Bpk095QDZHhPoXMduU9AQ
 vWHdA9zh3dF+W31ifOqULx0MME88pHcfAmX2qBXpeOCc58ZceOx+d2aFbLa6Mj/sMLGdn3FxwUh
 4rq7VzeWBK1mbCqxgkh6acKsN6x9w
X-Received: by 2002:a05:690c:e288:10b0:858:def3:3422 with SMTP id
 00721157ae682-858def3356cmr31008297b3.27.1787824105803; Thu, 27 Aug 2026
 02:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260821104832.151452-1-alexander@mihalicyn.com>
In-Reply-To: <20260821104832.151452-1-alexander@mihalicyn.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 10:48:14 +0100
X-Gm-Features: AcwNN1UsAxnvGlWmLXSlGl_khbKI7V4veIfdmnaTjejmADeiWMbsto8FhB1TUIw
Message-ID: <CAFEAcA_ODdYjXzgq796Fk3xK-dUwV8L8ajFAR7M3GTLGyBvfVA@mail.gmail.com>
Subject: Re: [PATCH v4] hw/char/pl011: support backend hotswap
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 21 Aug 2026 at 11:48, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Currently, when Incus issues "chardev-change" QMP command to change
> chardev backend from ringbuf to socket it receives an error (with aarch64=
 VM):
> "Chardev user does not support chardev hotswap" [1], [2]
>
> Let's fix this by properly implementing BackendChangeHandler for pl011.
>
> Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
> if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true=
),
> then after change we need to send break to a new backend too.
>
> Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-conso=
le-on-arm-architecture/23096/3 [1]
> Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> ---



Applied to target-arm.next, thanks.

-- PMM

