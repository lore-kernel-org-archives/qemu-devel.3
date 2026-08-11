Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D03C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpRQ-0007i5-5N; Tue, 11 Aug 2026 12:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtpRN-0007gK-Ao
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:35:01 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtpRL-0001KL-Qf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:35:01 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-825fdc558d3so27925597b3.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 09:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786466098; cv=none;
 d=google.com; s=arc-20260327;
 b=sncVhtWsqpUmMR8nhWhtRlwB0KPSbvmcZ0qjj9hq6oClmn8zgo8zJYp/y1VG9okYlB
 40MbKjFTwTXN2lcfkdsxClphDVWluzN7yhym5txp4GBBn3VrfX2MKfjIdizz1lrvU3LQ
 PkQQ7m5XUHeYz5mezaD4d/mzN5WizMq8spzkmzTP1Mb2U+H0g5sawK6KPQ3liypqDreu
 V1TQJ6V8gZNezh/KPP0MjXtKC00tK43pCTctxNhtVldqOghvjA03zrbANzONBMFmDRTz
 vWpmCX4Ya6nyiq2pqqB+80ObOPw6V85SF6I3DTxsorr86FLymOmyPDOI7N2Tru/LJMky
 Cq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8EbK/cVmyZw1P8EPDSC8umshUChDHJTmOQHTSuvB0zQ=;
 fh=D8b2gzgRy35SnKUug0ReQjJg6oubJMsPhjYS3YxHhpE=;
 b=KkGvkx8am7QiyzcvApiV/HDggF+Z29iXNwpxIifPpB9pS7ux7LeajpxS0a7PfzQorG
 cuZaA+MG8YznF4rD3MLJIMtbau5xKfIIb3iwfusKs5MyrReuqHGMZ6nj4PVm3cdOMkbe
 AFmQUSYIaMDBHYXOf6lnfaEyoOXi7IRxeoBpWUUBli4nfEHTMmo76fUgylchygiB2qbz
 AFWMIt5D4/ycKQ8VCe3k6321pG9rYjHLlCPc6WpRzOhNzDmXETZeo3l6HrYnDYfOY9S6
 ihM0xS9lLjxS1KaM9g/sHB9l6rClG1NXo/+laKALgpLwsRz1ZMQqcUYvfEjm5AmPXl0H
 +7PQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786466098; x=1787070898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8EbK/cVmyZw1P8EPDSC8umshUChDHJTmOQHTSuvB0zQ=;
 b=RoLMjTZtYso1viW3yyRSdhLtutgUfFmcvJZWd6Saj3YFBq44j+zvMH5+Yb1tyX5UZN
 b0vKmZ0dGXPoHqrG9Lp1pAVftiBs1R8NSsQOxICnKo8pbKiioGVg5GiXkUZDiGAZrQFY
 VsIHNxe0VQGG9AYoCxQLIVc2QrYO3L/x2vcN44OpP4g+GSstxKxiikBgZwScs2RniQdt
 sl652sbLkmtLnwcUQ/Gto1EcdUr13HorO3NItXoHsoipEaxhPM/Ym3Zk+pMXgqdSpNGp
 JAgTC6OT8LXRUidg8P74U6feoHHP1pt1M3kdriR+of9yDzLlpIJLapgDWUWboHna0vqw
 xeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786466098; x=1787070898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EbK/cVmyZw1P8EPDSC8umshUChDHJTmOQHTSuvB0zQ=;
 b=tLeSxZgjm0RVs27hwQ+5dGn8Q19+7amJ8m2znz3xZVU3ToiGfpKJnouxOZEqcg91ju
 sOeLgDp/LbOe15YLDTBRXEVfXX1XJ5h7l1sxsmo7BX9z813nQ6RXUiXF9+lP2IA/xf3s
 j6h7FBxN4mV4PEFpSzFnaNikZYYEdNK5hKWP8cVv2aYFyIplMxSM3E8N1Kl6Im5sE2le
 lrtORMDCycdlE8yOvYMVEeCqf+0kd7UOt3pM9btxqBsSqmy4DCUFK/JuKFdJH6SKbrgj
 hq1zTXmxS7VoAX0P/iRgZNMlN95GSI/qABbebNu3W9TrFS8+J8Z/jrNrDwqFqkdpJVGK
 4rjw==
X-Gm-Message-State: AOJu0Yxat5SoetzGn1xa8L8wFeC9qRrdAk2qQQgABonEYEKeLtM3XVl7
 qTNrQkj87Np0G8pSpdlyUzLziRWmrIgMOlaqfUrAo4eEeFHFkQDnKD2ff4a3MSKzMRslQ74ntpm
 3HGZqItbM+W45nOe1VZulHh7RqnuT1v4dmcGDW+x8YA==
X-Gm-Gg: AR+sD13KkD9IEk+xjNfAdaHBEGwUowZeRDRc2skpDqR1coSVQa6CViYo6SSbT/gWODS
 OLjlTxABlMcW4Yg3cPn17kNMX+U/I6nCiwlYv7IG0CswZeT1N7AXWqiXwd530gKmThEpegBsAK8
 x6Qg/zXXplN797SdX+x2XATQpUIvz1l9bnlJMlVN0qF3u/D6leFQyF+s6y19Ixtp6RlfhVX/4DV
 1I5VNVGz4KycVJsgXBFspWRxOY5ZouXGQPFtCKp3fcYNRHcanGxS2+dyTPga7yt/GBGxoq+Q3kM
 HCQRuT30otAl0n5vvtCFVgoiIu8MjQ6hu885qIhU1EEESszEqsF/38tAFnXrYFGwT5RrqVzoUgk
 wawmUPzHe8jlojgtDflnFmdxXXVUY
X-Received: by 2002:a05:690c:e:b0:81e:4e5d:484a with SMTP id
 00721157ae682-82f271b284fmr34218277b3.2.1786466097833; Tue, 11 Aug 2026
 09:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
 <20260811154930.13915-7-philmd@oss.qualcomm.com>
In-Reply-To: <20260811154930.13915-7-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 17:34:45 +0100
X-Gm-Features: AUfX_mwCNAPNS1BzvuS0OwAM1cB0zZT2BXoWQ5Y4TRqZF6IPJT6PZS2yuY-cA5g
Message-ID: <CAFEAcA_ZnATfiM+EO1Pm6MPykQMpCoOnObO9epnSFC0tU=qNFA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] hw/nmi: Remove unused @errp argument from
 raise_nmi()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 11 Aug 2026 at 16:50, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Not a single handler update @errp. The single user is
> nmi_inject() filling with "machine does not provide NMIs".
> Remove the unused argument from the raise_nmi() callback,
> simplifying the methods in hw/core/nmi.c.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

