Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D01CCFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dqO-0000y8-Il; Tue, 15 Oct 2024 05:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0dqM-0000xl-Us
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:27:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0dqL-0004qR-Fy
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:27:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so2844174a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728984471; x=1729589271; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tgpPHOMHhB56moS4r7vrLRohooFORWaeNRHN7Bg0Hk0=;
 b=AFBObu/bpWLJkLiN3b7RH6DT07w8mXbNkU9Wk9VfZC6mkoG59r4kVv9+fN/tiQdEsB
 Rz/1ZaZq4hmlwJRM7GWjjvdp1EUYZrAmKFce/oKaU1/8W1C6++J+MYyOsTVzkSp6A7yk
 ywNu385t7VIz0Ix9nChOWOMM739zG4JZS63qx+uarA/9M8teJ/TyXlcb9sdfjwrylbnZ
 mCPMzzt0hXXc66B+4RY+goVuXqYkgeM+R1BN0uNJrWciL9BhG9we3+nnVkUH46t96or8
 Rsjr2w+x+0D7ZdCl6OpGrXnXZHYdieXwWIfx6X+5igIqsTBqnsqLP70kl1PQy+UAbJ6D
 k4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984471; x=1729589271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgpPHOMHhB56moS4r7vrLRohooFORWaeNRHN7Bg0Hk0=;
 b=J8sRvNGP6VtY9W7RqnY/Y3T6+ofbNMChOP5WrQYOHrf7Nikkh2LTuXr4Qv4+3KZCi0
 4Vz47yyTZX5JUZzyL12Gt14fVsw6aclJ2LBnquznCI66QXrm84kGf61Xp2oZ3IvlGdPM
 1vls6RipR5TV1bZmrR2jGqWoe8fBiZuJ27MOFFHbh1HtNT+mGzGnBzVgSjMPIjiPiDRz
 iXAwBe1EArI1++PuL9tuaXjqdXFA1kZZQjWBXhJ7mySQk//YbBQMe+tRWgCU9V4QDYLH
 mcv070ZPkC8bZeqotmLqEq6/HDo5XE/FWVG3z1Oa+hPX50jgLb2F1QvmcHdr0vcvTneo
 qG8Q==
X-Gm-Message-State: AOJu0Yyy5wUdsQUQU3cE3rII+OYALANHNe0ORjQBSLMkyORrUogvHOMi
 qug3yQVvPYajTGwWVyVM1/Nv2LmhjTXp6Q2SOZaBMKLhhkBCK8NnRYwsKh+Ix4N/kAjdJW8P3jX
 hfqq44oaHcX1wVVNtwXTdGg9HnyX49d2emvkxs9Jb0JQOCjyr
X-Google-Smtp-Source: AGHT+IE65V4pHqNZZieJFL9FWMscyKPq1oq4EQ3etlDwW+qPPm9AzLgtjATlVTX7ft366uLBM3noGCsndAFMcY/qbP0=
X-Received: by 2002:a05:6402:2685:b0:5c3:cc7d:c29d with SMTP id
 4fb4d7f45d1cf-5c95ac09825mr7747372a12.6.1728984470867; Tue, 15 Oct 2024
 02:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-2-shentey@gmail.com>
 <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
 <E3D8FB20-605D-4E29-A430-DD3C4B01102D@gmail.com>
In-Reply-To: <E3D8FB20-605D-4E29-A430-DD3C4B01102D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 10:27:40 +0100
Message-ID: <CAFEAcA8cEFprRy-9AbPsGLU4p1DmVepmWCsgY1LkKh26tHo6qw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 14 Oct 2024 at 19:50, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 14. Oktober 2024 12:47:52 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >> +typedef struct Lan9118PhyState {
> >> +    uint32_t status;
> >> +    uint32_t control;
> >> +    uint32_t advertise;
> >> +    uint32_t ints;
> >> +    uint32_t int_mask;
> >> +    IRQState irq;
> >> +    bool link_down;
> >> +} Lan9118PhyState;
> >
> >This takes state that was in a QOM object, and moves it
> >into something that's kind of a device but not a QOM
> >object. I think we should avoid that, because at some
> >point somebody's going to have to QOMify this.
> >
> >Making this a QOM device is a bit awkward for migration
> >compatibility, unfortunately.
>
> Do we care about migration compatibility here? Or is it
> sufficient to check the version? In the latter case I could
> QOMify it.


Doing a quick grep it looks like the lan9118 is only
used in a set of Arm boards and none of them are ones where
we care about migration across versions. So I think we're
ok to break compat with a version-bump. We should mention
the affected boards in the commit message.

-- PMM

