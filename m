Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30535CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3MX-000444-Iv; Thu, 21 May 2026 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3MW-00043e-2K
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:22:56 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3MU-0002Do-8a
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:22:55 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651c5d525f6so6311532d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369773; cv=none;
 d=google.com; s=arc-20240605;
 b=h0E7twlJddpP2LIR6oVOQazoRM/150G7nX/PJMU4LYeGkoz51lGrl7wGnaKp1ftxHv
 AELxW88iQU0k59/rKd17czqHH7eito8KxF/ln7imYxVQNUwVdcKsyIjyTbjwO8338pek
 PfX6eqfyCECORqB7O1k2557BP4ECePGuflRFWPtPVcvq52xLoTwPxD4FrNhLlzZOdjt5
 yh2byxNpFbC0HSqNtih+6Q3Mb4EGd7W4aymU3K9MFgYVjV3G80GiFYlcHPJnpOj4prtO
 ABMQwcnF3IPVM6kOM+sivxl8PPpguZpK704QDf0Xt8RKqQKXhqnJX4P9rOaVk44Qad1W
 qyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M0NmGdmCuabLXz4JcTf7/j2hDfPUmh7EdopHdn0sNmY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=PjfVwrdBAzrpfLknvcC7wLLw/5o/4hS9v4Jw7U6gmpQkj8geoHf82dyIVI4JWKB3/o
 ve1TNSlXpb6g4Dm/pgyqRhhFU5vInUji1ule4BbOGmt972bUZ+86wIZtGWlMdngswgUQ
 hz1KT+jq0JMbzuvsw7XZlPAwEUowAlg4/cLMgAxrMEnjmp97pXkYLQmdEu/4uWlPaLV4
 apW1GU1ezlJr0Sn/jjSvQVAi+DNu12btP9ZrG6FLj1esuzFypGzfdaeXlS/15UoNMgKy
 YvruxXBJzlfQgbiE8z5yHdxzw72TOQMz0HDyoL+Qh7llwc5qdyDIzLYMS90uKiFMormu
 aK6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369773; x=1779974573; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M0NmGdmCuabLXz4JcTf7/j2hDfPUmh7EdopHdn0sNmY=;
 b=Cm3T6TOskADmYWQRiiidclMGY393rhoVqgPmIk4DC5FJfpTBf2PFhe2Mu3bAXjEXnD
 ynVjmVNqmOhiX3tEaK93ZIqw91D1IeIIvMmfEotTtjrml6lHVIFMGtdRVOT+rTf7rygl
 L9JTDjBOZe5s1BtK4bvRzva0UasIG5ldvz4BcWsrCduA+erunbdkkdSrXgJS8tgJmqQs
 O8+JcftDQA+QgPZo15klUhPyFekxtN5bGzQo47vXopiHBg5J+OgkhBuF6w4UIHm+JC4B
 YF14b89d6IipV2ZaerJhRrB4PJ8D3Q7OFOhGE0S/GuAb1Y2J+qG/OyOddYGW39NLyllu
 qbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369773; x=1779974573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0NmGdmCuabLXz4JcTf7/j2hDfPUmh7EdopHdn0sNmY=;
 b=M9g5dduns8xvgUVqxxK08hKhosTWYjxjEwXEjBpL1EWkwPJ1DZSMJQQDh0yMTlBAfx
 LCRn43JMIAyxMfEnd+d6DNk0yKOSv6EXZv8HveHnXBz+Q4kuoyYxpNbqQVP5V2N2yqop
 DC365mZUShd2A22XjY1OclqlTyaUTvhgbYZq+67uOED4bIamSeat7vcxSkdIChZtEGBd
 ROrJHUqUpoPFJ+fo/ru4o8qIQSA7FEgXk4Htdlv133daLXM/Xhm9bR9ZQ8WdaZmgITkm
 Y/7ioNKMZM4x8/JTYxhXkjQs+2/uPWeyg/LS0VzDICzhmHftdNxq1goBmNwN6kIONIyq
 ju6g==
X-Gm-Message-State: AOJu0Yw86qoOwsdM0w4f5EQ61blGkmM+eXozYGoNprh4afqmYCkXmNYn
 PXK04DihKyphh9wbNh0IVuyEdlKL6w77UfB8Vof0ph0CYlzYGwh5ujzLX+GkvINlRwzJ8sLwMoo
 Hk4OoX9y6qHHDcUkVVxQPtriQcUFq1dInISNmNtY6eg==
X-Gm-Gg: Acq92OEps8UyWdEqrK48qoxdz+gdiVotk6/jL3s2FKav2NAVe9uJCDmOuJHmBpkDti9
 DrtVFgl+TArIssQ+JgnQGUGUJF/MpDlaNaNfcxKPZMJP3VJ1IIgglbv8v3cKpa4jOybovhugfVK
 NeljSyU/dI59H6pDVJgjplbbgO6vVLKLjRrJzGDlyNAKQuhnfAtpPPFJr4mjrk00FJeshxtYksh
 ElHAOnjyOK640bxsLr5h8ZUAcD7S6kH7zvGRBfu6wvjaxeF6YPRczypItmXqH+D5SDtiIh5EUWz
 HtIWDsBArZPWeByWQK21fV5K07UOLAjGoi4tTuRZMEp3Tszccuid/1BcskjYecr7Vwg=
X-Received: by 2002:a05:690e:bca:b0:65c:6220:5fcf with SMTP id
 956f58d0204a3-65eae3caf3bmr2370087d50.62.1779369772768; Thu, 21 May 2026
 06:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-30-richard.henderson@linaro.org>
 <CAFEAcA9tXNossXoMC=LSa7Aw0CZzsmtkppKqEGqcdSgy-X_GOw@mail.gmail.com>
 <CAFEAcA9X-2+_LgGaT3Jf3tC7p3RSH0qRQ0CK_3BhySzS_cxqWg@mail.gmail.com>
 <498188db-167b-479f-abec-1e7967f0b967@linaro.org>
In-Reply-To: <498188db-167b-479f-abec-1e7967f0b967@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:22:41 +0100
X-Gm-Features: AVHnY4LLIGe_lxxBlkXeoMrU9u45OAVfXdroan_MjIh313jkxPh6E9kp9V2M8L8
Message-ID: <CAFEAcA_nSN92zazbZ6LT43P=9PNwy=Qtix0n=bJgBxWnidqmzA@mail.gmail.com>
Subject: Re: [PATCH v5 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 20 May 2026 at 19:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/20/26 11:21, Peter Maydell wrote:
> >>> +                break;
> >>> +            }
> >>> +            g_assert_not_reached();
> >
> > ...ah, I misread it. I think it would be clearer to
> > have the float_expmax_normal case be "g_assert_not_reached()"
> > rather than "break, and rely on the thing immediately next
> > after the switch to be g_assert_not_reached()", because
> > it more obviously says "this case can't occur".
>
> Mm.  I wrote the switch to let -Wall diagnose a missing enumerator, rather than
>
>      case float_expmax_normal:
>      default:
>          g_assert_not_reached();

Since this is the last unreviewed patch in this series,
you can have my

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

