Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1090EFC9EE4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 10:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypBd-0001lI-6a; Sat, 07 Mar 2026 05:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypBa-0001kv-PO
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:47:06 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypBZ-0007eL-Ek
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:47:06 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad8435f46so9794166d50.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 02:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772880424; cv=none;
 d=google.com; s=arc-20240605;
 b=eqyfI6HBjoVIOj+/pfwL8hEKAcvJf73uUi2ZYCmbIf6J72VRPDA38CNLfCVErsE8wE
 1H4RxdODtT+EZE+efjgahI80N0BpJJmi78ZaYXLzKxm6NX1yoqnK5qnpQdyjfRTTm9UU
 y0QrgTZZMYzbSLN8xUdjBJwer02Ra9oX//UMyhRqeRlaQRHIiXoONkeMRRfa08kQMSoe
 /lkVqyNBWJFEOiENdXGSYLBcY3v7X3kBPfr8p1nVqZF2rqrAzq3vl7RQbHGg5dIjgp9Q
 c5Tgvkn0LA65rrY9XCmDF6FQJBUnFWo+4VyLl+MKx4lOpukNfeMLXCfE3fjBSo606dZq
 DNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GEBStAUlGAnSVua+gRmnZy14m+9hwuYx1uL8rKIZYlE=;
 fh=F6bOIkOA5aBYREcZAmFgJCjXkzyN1AsEyw/DQQWelOI=;
 b=VuuQKDgAPF1iINFvovkZrQkZUPQHJfTuUCn4J/7uiafh1VBalj23LBw65nb/ldvuy1
 bRwt4xAyZ6SvbV+h7/a+ayJhvWPDPjVOCPSZD4wq3rX7oxhADMyGZT9x7lhGDAxhZFTb
 4vnUWepfpv3eYGK1ayfeWsu50oxpq/FwmdOOSzwtbONsHrU2yqDFWlTTWFdWOtcrLXUF
 Cgx/YdxG7pHgRw3W2PXxPc22qVBHFaGb4RdzqeV2QIQsca56MKLIGwwO9mhObFpkyncx
 qO6OE7yCUZgV9fJEe5Ld94pa1WX5FCF5j0gCJXq11klKjnQlAFBG8GKko233gnKJ+P5z
 hO9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772880424; x=1773485224; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEBStAUlGAnSVua+gRmnZy14m+9hwuYx1uL8rKIZYlE=;
 b=U86az9n0p5krQktcUEB3G+CoCE5nm6FBxZ6zgGPmpT3n5cav7vDWzR1NHcwy07oRwz
 JD8AEhVZ1mSaeWEebBh9j1YhBw6xX7M7IvnstKUXhGGLJ9zjjCysrbgr+gBCIk4DLO4g
 R0IuVoqhXvYEI8xcVJv5n9RTr1kjinQNZ8F2IySFq0b7x5lseIcqvRXSNgWGJmQqz0P7
 GHaNiWYqI9wIsgaRVB5J3IKrZHKD/jvk4ZlFwmUifuAu3XSWEmkPwaimIIR088Cl7y64
 xttvv4Il/0GN3LgL6wGWZwPWm7dmAwc5/MjIqNSTZ4t3QbSg2EA2ZtoD88CnTSv+L8Ss
 nQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772880424; x=1773485224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEBStAUlGAnSVua+gRmnZy14m+9hwuYx1uL8rKIZYlE=;
 b=nJAmGsbXCFPFP3RBlmDvb0Bt7RHxT3ItokME4XagSl8XaPjhq4erh/XVt8Y0s6/e12
 2DALbEzeWBkMUAkrJOIvrHMPxyZBOdmGZ417zVgesxgf6Yu3T5TmRN9QLIixy3kuNXHS
 DHBSQIHfToHkly50SqXNuvLnjGnRnjxlIZvAFgLYL1rGg+MFYT9GOCI8DP2dmDJfW3uL
 QPP2WqKbLonLY7p27RIy4W+kKFX9MVjRIotrdMOPojfGoy/WU8+5UZzxQDtC7iapY8AQ
 rYi7AkigOj3Zvnrsya7jJPS4OBxSsxSNumergu/kF7F4ZPSzt1YszLIzgwqFpbBDFcum
 Hz6g==
X-Gm-Message-State: AOJu0YySrsiFreXZ2eV0pubJJF73wYxgslxkMTvh4wHVpLxt3SMY4mwK
 xoh5tQ3sNIwDk4eFeBFGG9y/5+Aja9slyW0Nkj5QCz2zs2K4QHwIpoyROLrcmy6u7tbke7myXwn
 ijXW9aGbtEg2c90BJc9CPkHLpDQ2sy1h/4QCQxQXDmA==
X-Gm-Gg: ATEYQzxDBfQGWanSHg9bNNzPSPD9RM2qRZP2I4GOeI9+tIqWBFp+0Wt8myYmuyfFMaT
 heon3p6+DTbbj8UpMDF78wU2N+N+Aaqe6fsiCYU9kKVGKJwd9pI1+QtYfhxzo4Ca1YRkx/7njD/
 iGrq9ieIdbtdwrsO3Hrt5d0Y+0ProNNvG5WfVNCO2Ha/0UzcDLA5Zd0UEazAmldDdvyd82gDY7f
 +3PWSuPZ0gG9hC/amnEHrhbo3atFC/yIJK2BvArQnIrLu2EZvBe06pqa+8SFY+riw1MvLDL1JKv
 qOnGtzSmX1slNx+kmD+FqqrnXAUJQz4uuRFC7T6b3e/qM8OvCaFpyfi9RVC0Mb4CAVk=
X-Received: by 2002:a05:690e:d4b:b0:64a:fe95:2ba7 with SMTP id
 956f58d0204a3-64d14164dcfmr4221659d50.31.1772880423852; Sat, 07 Mar 2026
 02:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
 <aas7xpjiDx5Bhrs4@p100>
In-Reply-To: <aas7xpjiDx5Bhrs4@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Mar 2026 10:46:52 +0000
X-Gm-Features: AaiRm52OriZ479mxbJ7cFyG_ds0Rqm_WkctSEmOcBNYAA-5F8ayh8IJmkENxEBY
Message-ID: <CAFEAcA_Tcarx1+EbLfrZxVpHFaKQkfOy_pTLc_T0FdNFRDfPTw@mail.gmail.com>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 6 Mar 2026 at 20:40, Helge Deller <deller@kernel.org> wrote:
>
> * Peter Maydell <peter.maydell@linaro.org>:
> > You need to increment the version_id and minimum_version_id
> > to change the vmstate. Or you could instead replace the line with
> >            VMSTATE_UNUSED(1), /* was "disable" */
> > (which keeps the migration data structure the same, so no
> > version bump needed).
> >
> > I have no strong preference; I would probably just bump
> > the version numbers personally.
>
> New patch below.
> Ok?
>
> Helge
>
>
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
>
> The "disable" property is not used, so drop it.
>
> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Helge Deller <deller@gmx.de>

That looks fine, you can have
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(You should send these to the list as proper patchmails.)

thanks
-- PMM

