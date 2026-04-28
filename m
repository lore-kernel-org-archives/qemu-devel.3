Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72695FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHf1P-00011o-8i; Tue, 28 Apr 2026 05:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHf1O-00011Y-IN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:46:26 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHf1N-0004dv-6r
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:46:26 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79ea87af213so171558227b3.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777369584; cv=none;
 d=google.com; s=arc-20240605;
 b=R896eTbBmNQdL1ArdM9DzpXIDPYjiNjWNVBIo8tVHN0UgfmrHUQfOQ4SoJvqBGY4d9
 RkScUr/qs+iYXkDW3UQep9n3tmFYnQTNnjrnjJ55NDfOYVQ4nmzyXYOUHCebf3IDDqS8
 Hek1VNzANC9qEMtenLIKXjkeaGKIgVpUuj92Lf14/g5Dy2xj0woS4/NcdL8GVhnK48y9
 CSCFXWbYIq/mTtRlXf39KGB53JjoaywDOIQcrhle4IytE5ohITqQV57j/Z5ENaMG20nI
 cg3YCV14E5lUcq/S3vPcN6QW8koBksOsnb5Xjz1YCsz9FZgY+5k4cm8kRFr9iC7gK0d+
 XFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KnOTyoBONZL5lUhxgLh9D6qE6LWii5d0WK1ENz5fK6w=;
 fh=BBXXBmZbsnh1iUcPA7aYGot0GnoKedpL6BO7ZAJRQVM=;
 b=ZJIsu7ymMLZ4LDiIEayh7+6GK2gqDpUgai101GX6jHp0GzYMc6jRrO7LzODy7DWzvV
 RQfLMAatHgEAk4o16LiIhtZByWptCP82WFVnujJ75EwS+g2HqeSetXE0irAmxM/z71bZ
 l7wOzEXb3hAgStoAOB/ri2kNInqXRqd7P7RA6WakgYPbofq9PN9BQBoTbt38110qrh9Q
 JSgU3xoIBzMrY69bLMjav9CRFEGs8AHpDUEDyb/Xo6Eu93by6L3qLSFzn/nD6xdikcRR
 OMYLtAEKnfvtLpPX3X9JqhwAV1TD8YmP9+EiDykwyxWMpCDTiJMiAwMnwVyr5G/kQBO9
 4pag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777369584; x=1777974384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KnOTyoBONZL5lUhxgLh9D6qE6LWii5d0WK1ENz5fK6w=;
 b=PDxo7T4ZvJ1I1d8yg9i/oswde+NIVjkqjGiF5zorI4hY3IF7b9aYwIZM8Eqy8QgDFQ
 Cm4xTxdC0ShflmDEI3rn0ykqGooYZUCeAya/5NXdFBASbTqRqNiGbXX0i6at6hxXSh+B
 DhWhcKU5KShE1sV6I3XzZxYe1XWvVVko9TR/5M7kzBzKP91kXDVtR+tVeXSO9saW+uYB
 OxOj8xup25/Wm4ft4ga41jmn6CFOV3Lbmy02INdXNDNorbt00hjHxyE7UCsQWz8j0nQ9
 BbBr9O8JKLn4UiPHQbKs6UlAYsUPQbW6WjB/NlDQYB9EFjYNpVigteXNDVlPUzYkWoZA
 /PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777369584; x=1777974384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnOTyoBONZL5lUhxgLh9D6qE6LWii5d0WK1ENz5fK6w=;
 b=s1ip053jpG2MdnoGx/Psc6YDP+b2UoOzG8ZI+IIpceqKm6NNApyAjbDO4iDuFtNI0Y
 kUQDmBsPc9WAUwiOEA0sP3G6SR29C9Kx7nv03wnVpc/al3nhLmVRSQ/HKilKhulhl5U0
 gx+4YEGSAh66AfL4gA9UPlzwX78zVGCa8Ynre3IyhCSYFODR5o/KwyA7B6AvP9iLONR2
 +HhmxKDLY7TbXcwRLitlR/2eBHLjyTOjmxtdV7JCPiynNiqaxmRnrBQSNpCBATi9ozW0
 Hqp/0eFOH1MzN6reVEWiYHN0PutlnTcOcLaRCwLRTTdmWcQA1EXWuvn+wfCaMJ31i8FI
 0lYg==
X-Gm-Message-State: AOJu0YxGZ9DCqMAcDvKaX7KC0NlbBwXy2nWbHmRS73ofXWO3RjOaz8V/
 fvSa6OuGXfzz0O4qVLTd0Ovn9YcCqzMaVQ4K1O1XTX4hVYg1q2r5RjMa35Q3xxzn58otMoYzSE1
 pmaN3wN3uYehjEMX7MhdBnGvFfewz8MLcZlo33O+Xog==
X-Gm-Gg: AeBDietXv93njz3jAn8TI8yuJPG5bc4mEpS9P7tRPAicvQIIcPnB8uvqs80xkpjYlxq
 jDiSaN28jDSl8P6X2xQPEzWPS8cxyZGPIxqLubs50+t0ZBdIVOFnKjpDT1st1Ff6fuvA46omXRZ
 JgKckfyohNOHCHrbbdBrJR1deaDT1JiO+rGuBneyz2cfSlcBbOXedVZVoFaVhOdPyxw4r/0aPWg
 aaOAICGEahjDr70AVwLWIAogLfa5zUby/jCVkAFBM8cCcXOo0jA0GJOxcoqIcMY6M+XGQmiWULI
 7dHx24x/RzamfV4QjGcGfWQ6IasW13e5M7i83j3ezxFK6t1vX3gc6XLZUBik4QQkyYQeZaJxi0H
 2Mw==
X-Received: by 2002:a05:690e:b89:b0:654:99fd:4a1e with SMTP id
 956f58d0204a3-65bee6e075bmr1723676d50.5.1777369583702; Tue, 28 Apr 2026
 02:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-2-shentey@gmail.com>
In-Reply-To: <20260308203516.160103-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 10:46:11 +0100
X-Gm-Features: AVHnY4Lp4-tZHtm8EalkPK5wy_ymIxgoTBUzDEEHaaA0m03tg5Dofjowu1o-E5U
Message-ID: <CAFEAcA_o9_j05GmXT79TF2z_BqwxmTWeqaaapUOv+E4=P-hh-Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/arm/fsl-imx8mp: Do not create redundant
 unimplemented devices
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
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

On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The GPT devices are implemented. No need to create redundant
> unimplemented devices.
>
> Fixes: f8b26121762c ("hw/arm/fsl-imx8mp: Implement general purpose
> timers")
> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

