Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C745DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7vj-00022X-4w; Fri, 26 Jun 2026 10:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd7va-00021Q-ST
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:53:11 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd7vZ-0006AT-ES
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:53:10 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66481f17a4cso1124564d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 07:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485587; cv=none;
 d=google.com; s=arc-20260327;
 b=fQLbvyigAb90Y2HFJeYKSQDph+nJwUXecPN4e59B6eWzPhlhOBRxa4OyKAssQq4OQk
 NqE5SRNcC6fo+zbMm9cHSlZwO/kPGetj+Y8eWXUqnTpFvs3KznQZUWFecynfvx0x0Ad4
 evGgg29Aq7tkpSCxQPQhDERtlcD4o+XsmaKPJFysssn70WIylleFZM9rbpxEtxbi2xAD
 Fqf1gImb3F4BMJ3hK+dMLFeVVfUVCxMwULWyViFjPjcUi136ySqH9C6X25DnDGtXp7GF
 oggJcDl5PY+lNlz1fzOVW0xLjDm3Z5pNO097nwcHZzR7rQNPW5K/m4qdSObCckzCFRdS
 1wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vipiksW0821brCBx1duTb4GeR+AFtKEUEzrlarYLIck=;
 fh=nqU2qTrUylmjwSPaum8+DG0h3pDD6hPcgtsDXuA2oBE=;
 b=RjlRXeHcleQLPIKbyyW8wVRqhuqCcKZ8Jq8InkB21EzbEESeLP0LzAceX9mSii2MwA
 LVN6lqcV6IDWJHNjk7q4obJVfQDm+8mwq5L57KybocBjteT9RO8igIO1kISzk0JGvClX
 rYc9kP6Kem7WH+P1OJ/L0KYzawLMBwqugUxpKdQbHax8I4HX31b+3qcX+REEI2GJ3UWv
 Ck/kcD79IFAuxWK5ET0LItUVd8wA8e87obWY+Uz/uwe9rLWuA5esh0l+0oqkAZBulR0x
 KRyVBOv+waFWOTLtaRUgmx54sgtNacoZrs8llC9LMoBhW85r9XpQCFtsutLtrAjDr73P
 Dgpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782485587; x=1783090387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vipiksW0821brCBx1duTb4GeR+AFtKEUEzrlarYLIck=;
 b=MnlJfUYaaBCuSF85iVAmJbkkoVq0ET9rRVgTRMfmTesXfFyB5rA01WRDkp5YhED6hA
 kNnR8fdJlzm1qNcbvz4qzv2hdAGVp0Mq6Rv3Va0Oq9b8YqmnEMYX6rYpXLCwsaOnfX5b
 HXeI2URjvAYUNXOgvAR32UXd9KUbbO00Pud49YK65WcLYqSD7IgZ7xSnEHLHhICxyHGW
 PmKrvKJG5VTm/AnTWFYL67pHDl7WZBvoVoksHLtLKEMsiejySdWP9fEqejS69fcJITtn
 aowdegxBRu2UloFLfrkXMCii3A49OhXbA3g1hgAb/kNvxJBDIPyZco0w/Kabw2oI4+Bu
 IYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485587; x=1783090387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vipiksW0821brCBx1duTb4GeR+AFtKEUEzrlarYLIck=;
 b=AhHbjsEav2PV5jbQbQln8TGPZnPXFW0jWdwGXE99z/nuf3kFyCunZF6l6jVkloSR5j
 k40xbWN9vK/3KZN3GdeY+YIAQ5J8bMlqWwuy9WrFlLgWU1ehMcl7JMZL6cLvfYzug9Qj
 3RE5vadwSZMPPqfx8OCRaj/KPKwn1nm/xBnKrL+Pxf9mCyweLHeoBGW0J8WXl4ooMQPL
 Rm8KbmB9WGeiSZTxySKb3L1hWRGhV/rqB//ZjHe5oB3g2/Ew34NZKQiA1N1/E7gygVgf
 X2PNkdOxOj8olMLIyBjd63VP0ZQRVmLWBDNrjqm2oMAKoIRV2Lu+rFYcinB4fi+ObqY9
 VMcQ==
X-Gm-Message-State: AOJu0Yzm5U2lgHkAcFzA4tOl+ENqaMhfWMGL67DTrMiXRTdqhlMwW1ag
 q5BzoTG2B6k6NQSVgPEp4qdw5GYB+qwsAJm9ObT2aJiUso6htTFmnlgOwWd+aMk6W24UK4zOBNK
 DiAFYXmM83UlmraMgL1sFqhxnSH57mjC+VzS+MGXPwQ==
X-Gm-Gg: AfdE7cmVZ40KWwKkbTQ2W8O1Q7JN61cOgaCHQZMgcSm9Oj2S+GnoW0iLlHtqW5OUtOd
 X9Z4z55jtTTsR+8YN3AE83yvJqNCGhyTAnZ09tY00mmofj1eMOO08HpRrYV3oIZQx+IDO16l1ID
 YbqrfSbofqUMlidp4rraRX0qB5sePEi6PNXzXVWDqWUVqS2gJHE6QicsoXYFfwl2kNotlHKmAlu
 13A+vX+JY9iDw9avUidzRp0Rv7IsVY8u+pkIeb2C9TAouZ9GULnPl7LDUiHa+eWOnxPuCScQRZE
 O9K+7+LprbhPPcXWyhM7V5VIVuItg4cCaD7QU62vqrN6zaEU5fQscUUy
X-Received: by 2002:a05:690e:191a:b0:660:689b:1509 with SMTP id
 956f58d0204a3-6635564cacemr12676327d50.29.1782485587426; Fri, 26 Jun 2026
 07:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 15:52:54 +0100
X-Gm-Features: AVVi8Cf_kiIrjaWJhJ13n94Xn_bDuYfzpt3XUAwP-HxRp2CH4uXnIL-ydYGhEfk
Message-ID: <CAFEAcA_tnLa4WKJT1GGZGOTpQBzwy81rg1eewC28VFpyzAuXLQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] amd_iommu: Fix Coverity and endianness issues
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sarunkod@amd.com, 
 pbonzini@redhat.com, richard.henderson@linaro.org
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

On Wed, 24 Jun 2026 at 20:59, Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:
>
> This series fixes the AMD vIOMMU issues reported from the 11.1 pull request
> Coverity scan, plus follow-up review comments pointing out bitfield usage and
> big-endian hosts compatibility concerns.
>
> Although patches 3 and 4 fix correctness issues in big-endian hosts, these are
> longstanding portability bugs rather than recent regressions, so I have not CC'd
> qemu-stable on them.
>
> Thank you,
> Alejandro

For the whole series:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

