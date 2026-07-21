Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED433C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6GJ-0004MV-Il; Tue, 21 Jul 2026 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6GI-0004M0-7h
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:55:38 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6GG-00065q-KH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:55:37 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ef11a0972so46571257b3.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784624135; cv=none;
 d=google.com; s=arc-20260327;
 b=LVeBEryGpBI5kiX+syuWMT5zFMgeAw0Q520T5gD2VNQeVyJaqKBQJ7OzF29ZxlCAJ7
 jeO4gD0kMyjft8k3B7scm5hIYaqdJnFL0WewxdXxO5Isk9sfaCAr1nWT5GsCLY5ctHNM
 sp72kXDq9dn3HHxgSItyrbO8He/afC/nEIIwUZnylwE3gsWLLdez2na4WTfx5jMzP1YU
 N32HbLKR8Mkcr8IscvLTKhaz64tjiNIO3Ft8nwvQtHOwaGbZaZ0YBEWTHod5q+7CuNrD
 ARIC0K5Fqu/J88nKwAbzI5R5o9Rom7NX4X1Jar2zRj05MUiTZeDWhFT3yvdF2BLfMFNE
 i3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nRERP7QdsvnkBmtsXCIlWayD5PujBnWgqbATlwaMCqg=;
 fh=huQ0GB+eYDOIBrIjJxUMwPBqmAAa8FJrOG8Ir+S2J+A=;
 b=AaL6Gzc03nI5P0NWS9kMphOu6z3aM88Atg+Bn9sWKu4FnuafqWZcqbxVWssSGBYtPV
 9FVQucJYQN1XA/cZAukI3ixrZVag7zQuva/KDeu3UL/GgfW2JKBdP+zGyLYa9gNS6sE8
 JG8HByz0hdhs5Pc6L6zpsv0mewt0rFy9+01ODqyELuJbmfExZSoyFFofgjDpNhcGQXx8
 Mo70HtI29CGO/QzIiuRn87LuHFLP/vRs/vLmyIMyY0C/MqWOqLqzYt8wcWnpJCGCWVKo
 IbKO2JINyDnICyVmcoOdg4qhJE4+U55G9Nmpl8GrhxUuIh3j0xrKrYZZbdmtpbKQl70X
 3iMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784624135; x=1785228935; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nRERP7QdsvnkBmtsXCIlWayD5PujBnWgqbATlwaMCqg=;
 b=rGnYsvyEse/3ea9e2fqWx+G8qh63//3Kwy/zcmI0GGjrmBVPf1/P37XHv3x94NBl++
 MALj4mR8Xp7+36mUehyjPZH1LMvt6MaYCypNmX036z+R0XmXN7lsKIDfh2RBEy1JmjMn
 5ivpJU6PjHGQ8CUxHJXWPwvmkalksjt+8cGL/d1TXGB9iBtUdxIs9p4t1wRSdd7SYppK
 +SqJZgbJUTOb5bwGrZaIgzLsRbUVFOx/vtbpn55EDQ7pgQiQKB1cgB7BmyXV3FDH4pgX
 aAEmJzdudc/ZD4w3Z/QYn4+S9rLCQMEXO1qbxL81CCrwQ/1BCB96G8Hdlu4+BxXAunTg
 NwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784624135; x=1785228935;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nRERP7QdsvnkBmtsXCIlWayD5PujBnWgqbATlwaMCqg=;
 b=Shx/dODXu1pFv9ahQVdIRgu9C3VJ+tN3hxX1ASiMypGThcK1MHGxv3J9FLcPUiKdUi
 owrz36K7eq8ZU4PLzXH0NV8jxwc4Kwb3+NT9Ctpuyp0qEHfsST6nJbs/XF3j+zplr72h
 sevFD+cIU+tA6jt/jAUAqjW6ZqadKUQq4do9mcDgxMbRU8HfLYwxpZMOXVsQ5qOcbtz+
 LZ9qfBoH+8GaUL53/ROegEBAJGf1y44QAIGpmWnZbiDEJBwwnB+NBGlabxbx3nenJiEy
 6XynQjy3MlFopJG2Aqrwo4dG1wEnTk+zJnfg4noSEqKQenlohlMSSD6CTkABb14sW5Vn
 IKAw==
X-Gm-Message-State: AOJu0Yz3gjhJjT+yOfqKQr19MX9Kx4fYx2VjJ/rkMllZ/3icuGLVzow8
 sT02KCs9vGCI9h4a4AVkammeqe99H4zr5MgFscx00TQGEZLIMzRwyYSARP7Ob/IqNsvk6hUoBHX
 +x26dJErDEWPfe0NzKVaUEau5JZ0YcAOfkq+gh73AcT4tJCOet1n5
X-Gm-Gg: AR+sD11McTcSYoHdrT2XAL6vsVd1qHopXx2yY2iWhC1OdgZQwMjhInTGZwn9lq7vkH4
 aBCbs9F9aJEDTc4WycIEFY6P7R7FoK3HGKeLaqFtjExrIy3UqxPpWn/YvUtqG29oQfNox0oi1ZT
 3E0vE0M5WOOEZazaiz9cvh+LznN6j6wqOyGMXRpaGlc6RQl7q1kSzM5M0Ln211w9WnLxXmtxwd9
 famyg6J29poI24tyqG3KW+XOLDlMrgb6XE0JyfjvVy4ehFMAjUiOKbKazt/DptlMilF+pKO8cI/
 R5JAU/9nru0Lvv4B9oufsSi5id6vVUeUTfMV/ePB7q81rQ==
X-Received: by 2002:a05:690c:9c0c:b0:81e:5d2e:89c8 with SMTP id
 00721157ae682-81ef22e08aamr56268547b3.14.1784624135222; Tue, 21 Jul 2026
 01:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
In-Reply-To: <20260708121011.1653365-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2026 09:55:23 +0100
X-Gm-Features: AUfX_myn9ZbHEjngl08Q_cBX4Vt2uA2eVVszxtCFLtVwW3H4t-0YgiKam__JCLM
Message-ID: <CAFEAcA8WDKBMQhQELQrMzW2LatpQdmr0qJgak64B5S3rnsRk=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/pci-host/q35: Fix blank screen for VGA when SMM is
 disabled
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>, 
 Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 8 Jul 2026 at 13:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is another attempt at fixing a regression that's been
> around since v9.0.0, where
>  qemu-system-x86_64 -machine q35,accel=kvm,smm=off
> stopped showing graphics output from the BIOS since commit b07bf7b7
> ("q35: Introduce smm_ranges property for q35-pci-host"). This is
> most obvious and bad for accelerators which have no SMM support
> (e.g. NVMM, HVF, WHPX) because there smm=off is the default and
> so you always see the bug.

Is somebody going to pick this patchset up? MST ?

thanks
-- PMM

