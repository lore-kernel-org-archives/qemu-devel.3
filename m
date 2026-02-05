Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2219DEC1E8B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwQE-0001zF-MS; Thu, 05 Feb 2026 05:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwQC-0001yb-7n
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:17:12 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwQA-0006wE-T2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:17:12 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-794e95357cfso7021847b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770286629; cv=none;
 d=google.com; s=arc-20240605;
 b=OAt45nYDaW6f+FB//LQWjvkUqtMfAeBJjbdsc05VwkMysvWhmFEmHRRFD3/1IrzvAY
 vKq/DepIb4slchVXiDM1ueIGCGvyaRwk7SX8xvWp6kEnvJ/b2klvO/IszuAuvIzRxDaw
 TdWE9RHg5pniWUP6iVGaVl85SzwkX/BHyqKvP/g9YMKmShO/n1+mxdbPLyGznuAdkaQi
 Bnc1GexFppg2oaY38eTIdUBUahIgPzrR9gAyz6XcTOvCjcn6irDqOloRPjF2+C8pWarh
 JP7PVnmkFqFwr6eZ4tXnUHr5PXkLkBu4YACzEyiaarS8QDocZOVCy/zgLj5hPe3oAipr
 BZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yh/gwoMoCd3XaIwuvwmcawbcsXQYz4dh6o/53HMIhHQ=;
 fh=09I2axr4uxBaQZWOq7eGnNEbjKYzXXuOZ/WYgxqbxRU=;
 b=Fiztx7ECNTh+BOJPlp0/S7aVECadh5nh8dezUxJk75/+s9NsYypgrFutzCMJf+E5AR
 2BVccBNBHphgbWZ1yKYLCA6AMAf8RQcSBynYQ3syz19Nf25AcPb++s9TuVaHDzWK3idM
 9nNN0L8ddEYdYx09yuq+filkFvQDGWeBfft7fSUalhW0s5zbzXCP5Qp+b6ZvWudjHn/i
 4Ee4/4ydEJmSOdIT3yMv3VjfCDMOXWBFhTevuZweOKL+97RfR74VLi0+4znWZI72diU6
 7mlwWuf08bnFedmkUqPFhLlF9MqXCGVFZNcYsUgO1LXIFcKFxvLWCCGn056aDDH3cSw8
 HhLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770286629; x=1770891429; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yh/gwoMoCd3XaIwuvwmcawbcsXQYz4dh6o/53HMIhHQ=;
 b=FChT1P7MgUyE8wGGZ7WC2afwQbFb3WMr8YMAdbaCsg8Nax4kiqSUzypU+oNELKC9lE
 M42XqdgIQIZlbdUc+Lsk3e6RHqSi4t1Ip02+BaDAhjMn+mVlpjxkjrGUovYfKtwyenDm
 Y2ZzUI842x10w7hovZNGdm0uTU7N9Vb1ixIP/3ZUNCXTTyJRwXw5yf3N4q65ZmAvWnC9
 QGNlNbcmQIqVXPcqj+Z88Vx6UwsuyN11P+lTD70SKT8cB56wx+/z2ey1+pkuDhSsbkQw
 1t3pC1udAq2XmkFr7WY9jSDDYjte6QB1cBgPFc6BIYj0GI1HLbhUezEbgBoxu+HBQfrS
 keGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286629; x=1770891429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yh/gwoMoCd3XaIwuvwmcawbcsXQYz4dh6o/53HMIhHQ=;
 b=Rw23lWjjiMNcR23v0HjKW9vedM/oR1wE3RKKKSDB3NuUxI90LCY0fwsO7vcdWLWgSV
 n0km6QMwTB/kvKTL/Yd52WmocnVrRRJovX9/zFRl0gi4OCO5pNpcSg/Ijw5Fl+epMrQp
 M0sk02CN0viYk8MNdXHKj8FxasfAUsEWlojC7d3EPG9Bb8ROPDh2tuLt7WVQQI3lvTUW
 4m/8r6TOV6GiuyDETh38dCOc1n8alfyTOgRi7y1Py1ShgvfElBySMhPuBMkVP5YNBQMG
 wJuF7Es1rPoGkz/NZXRtNFyDDqI4M1fgFfmswy6BNQDVYoce6isBw/Wbjkmv8Z/3KANn
 sj/w==
X-Gm-Message-State: AOJu0Yxe6S9QxHTtzGlzr5eqNBpNOysjbWN2dxRcTodtD/NOOjCoEzAr
 t4yCr/0iG0ADlFJ88VbBpeI/dFavimjsI0SXNrOAcuve9LpTGW2Y1xBFz9OniJ0G/LxthwACr2T
 ejp9gMVMR3DVBKt7GreCcK+4o0s6AFCDl14Gqq7IioJSAA36EWo2m
X-Gm-Gg: AZuq6aI+U91nreQhzDkXmA62uEu2QfB75BVstoGGWCI3lctPyVGZeY6P9QrT6G8DuhM
 LMoeG1C70PZkrkULVD9dQouXChcZOQi2xzGNaTvYAtowZSaL/ktjkiTLMLVdIwMgHc61LAdFEIt
 2ZltyMAV+ZdMtYLenz6GMOUhhy7aRhKUxsqJDPwpGQLFIajI1w0shHnXU0+0Dp3ooFtY+krNobF
 rRq1x1cncl3RM8vi7qiZyqOIlzcJkVjQzq/zTxz423ok76PW/pbHGOelacnYvhsCDK2qQ==
X-Received: by 2002:a05:690c:f87:b0:794:3068:255a with SMTP id
 00721157ae682-794fe75d83dmr59373397b3.40.1770286629193; Thu, 05 Feb 2026
 02:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
 <20260129192009.14707-5-mohamed@unpredictable.fr>
In-Reply-To: <20260129192009.14707-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:16:57 +0000
X-Gm-Features: AZwV_QifK9yOEmRQj0syBe6nYY0HaAlpeSiFq02Hp70EZ9QTg1OYsSnybQpK8ig
Message-ID: <CAFEAcA97TVmWM9WJuPLxXqS=1cqLNQk4r5x3YAm0Xwx+E+HESg@mail.gmail.com>
Subject: Re: [PATCH v19 04/22] hw: arm: virt: rework MSI-X configuration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 29 Jan 2026 at 19:20, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
>
> Remove vms->its as it's no longer needed after that change.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

