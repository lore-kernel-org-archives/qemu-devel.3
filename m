Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93636C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmTI-0002sj-KC; Tue, 11 Aug 2026 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmTD-0002qo-2B
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:24:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmTA-0007VY-Tg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:24:42 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15e592da74so361416866b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454679; cv=none;
 d=google.com; s=arc-20260327;
 b=aZQJoVfJYtWiYIh/EJm3FLe3wHWIozEcAYSx4z+rrZfRxlBG1EvKonFPqqeJ3FnPow
 cgWfs184MrE6NkfWsZdiHE0RIvzcnHEVPj2ZDeBnkIngGyM8PMFOxt4oFPCWtTDzA/EH
 TTJRZ7nsGj/6tZZZ2TtKQEZQPa9Zk5JgrhCG+ABySz251V7tlZ+IqF2QLAq/UJk2WOdY
 yfH9ghkvyeqUo5PK1fAkUzcgAdHOyGCikiJKRxkd9LJYvACv+RBuTAadW8UYrlwnh36c
 M+4k/Eb9ZOaVNtNOP0j+j/KMTqcDZHrpAIgFf7IyM0eHac8Bt7Vs8UAbvmpzzXjfOgU9
 8zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jTXaA2SHpHXXlRCQ79+dBU18IWzowbs5ltzr+OVr0VI=;
 fh=fY1hac5nrlXpQ7YDv5ffhDfNTEnXha1SHTsEDZCQz08=;
 b=MHolNc8a/WSgSx24zaYYwJz8e2x0tu93u7O7XXuwPtCrf7UKqPPGckTfGX4j3/8iXt
 AaTNem+eChvLGEK6izrd4M07HGleewXbmky3OEMWUrUMUtz6aSku6yTRV9rQa+fTNzOR
 q6h11hQ4EyK/Oy1pV85SITV39Waopf0ArkmO1q9kTzu9bJVL7A5QuLPpypI19fY1Yk+k
 JYuDuaObmijm8WGoI9iUp3ZeByA2QBByfs5iJuwB0hbl1uqUWmsEgY7Oh0lQiHybxtQS
 Aw9w4VTWVBy+s6s9+wTcUKh7kX2u9+dUko4643eprJxD3bxJ3mCyr/ZJBa97bwQ86bvX
 tF8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786454679; x=1787059479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jTXaA2SHpHXXlRCQ79+dBU18IWzowbs5ltzr+OVr0VI=;
 b=Nq2C4kl5nkffvFPqOO5328UEyUW0ceCDtkJbN9hT4zAH188TFkab/oZh9AF7Xlny/p
 PS4iKO5ZErJiU/H0gE/rXv+0eRXHzBadPab55NklHZSqULkcZvV3ViQ40OKA/t//Vxcx
 cMHJ1X8urs0PFVgPcD9niqFqcju8QX8pEe0GUSTzIQblxcqCxXRXmL6xP2x19/NqHWjK
 sdnjdLsjJY4CCNNFX+ByysqCbsDxm/tiYE6P8ha/TSSWLGghAzBqsm5UkR9YQCKXoPf4
 XzpQ/OS1fFFOpocXSDy5MPS1DvnKX5Gu+CHS1R9NDR2QfQDf7QzDGfGXrOn6moSzSdbZ
 jWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786454679; x=1787059479;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jTXaA2SHpHXXlRCQ79+dBU18IWzowbs5ltzr+OVr0VI=;
 b=Bx56bCEUsGn9aqLaMOYUgjIgj1xeg9zJ9D5bKRNR+FYyptX80H/bw5f238wnZne0TK
 ssrDN6+vEyDHfBzHjxcJw0uDtv4MpudJ7oT88ALL49p7/hrto1Ud28rC01ecrCqpmjmq
 N3M9mAmGqObyuFxOiynejqg3LXzMAk9aXCni2ucpHC7BGDtSvKHXsKvg+Q9yCNUlyX6E
 yEVPgGMipQoPer1XoIcvkMLxEhBV1MiBiklbXsAym9xOR9TZCqiFoi+JQYrvfpXrSy+B
 dEmyjYPA4mHqaC3Jmoy8YetTnxiBfvHJifDHn/BZedBneSm4E4Mu8HPTXOqlBjY3zwrk
 X8yg==
X-Gm-Message-State: AOJu0YwwS1inm2quqHnrjVtOy94FOXM/+tmmlmFCqCm3sc4gp5CgIPXS
 hvLCxFeUbLlxvbojz6VSZTwbPO6OI75qUDGijSCCps5imHuG5QaPxxf/BJvjRmHkl0HQCik3ds+
 qdowZpwvASxi9CVGz9oWIAZVv7NKh2WQgzYkVS4SPRg==
X-Gm-Gg: AR+sD10S/EnwFsJLJf5ZegWrJMm12v++uCNc6KlxppZ6swMtuP5960v7csemjM7vzkO
 L75muyiDN4A/0UCpaC7Pyjlg71BsgCZJfh6JKPxVvIGIBWUMBjqp9dXSPEhPKvhXptu6dCPdBmF
 ixw6RahnXlaWpba3Q/Dldwzp/cbLRGko28t8ofrZcQOC3rSzJdA8tjDp7Bx+8nH9S1kaZcFMXFN
 m3L5PI1uNQ6sb/5iQDy6flRR0Ogm8x0LJ1XMxywNKd2v3rvk3qpZ0Fox5CA41EtxrJKB+DMh/a0
 UWveqLvIbgwsMelXhs42Pd3+BVMSzSCNjGPGJUBIQwIRGbYtk66PKauhCAw5rBeHpQvKII/7hwf
 AYCXLUY31cLQhR2yuiQXWsEuadj67
X-Received: by 2002:a17:907:97d1:b0:c15:dbc7:a6c1 with SMTP id
 a640c23a62f3a-c20e5df3050mr150420166b.0.1786454678634; Tue, 11 Aug 2026
 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-7-philmd@oss.qualcomm.com>
In-Reply-To: <20260811105425.7429-7-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 14:24:24 +0100
X-Gm-Features: AUfX_myenv0lZsRJ9ZVDgRwL6ZkHo_litPa7lssCbVgn4bEj_Wzx2weeSrv_6v0
Message-ID: <CAFEAcA_VMtdZzQzFOkjOj4i1JoGcA-2v3Ku8SHtLL7-MXCQp9Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] hw/nmi: Remove unused @errp argument from
 deliver_nmi()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-ppc@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 11 Aug 2026 at 11:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Not a single handler update @errp. The single user is
> nmi_trigger() filling with "machine does not provide NMIs".
> Remove the unused argument from the deliver_nmi() callback,
> simplifying the methods in hw/core/nmi.c.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

