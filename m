Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427CBC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtJr-0006sx-MB; Thu, 27 Jun 2024 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMtJq-0006si-LO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:54:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMtJp-0006QZ-1Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:54:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fa4b332645so10865ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719510839; x=1720115639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMmGk62sx2SvVBa9SQ9ZhkKPy2q0qJnYom/nToZiU9s=;
 b=n3SFr6+7XfW/bSa7R9le+mCNLBq2HTlP33bnXRUKpWhpgx/8PWKNl6/ZUNX5+TJIkI
 n71hgaVEyYxiXhht7ygraAyrkgOXfKO01KkgIC0kHy6D6P28lOkoop9NT/jOdxR24TMP
 uvQT5U85qO5tKicJnxGx6y9mrJJH1jH1sgeZXEGEO+yE51JHjaSFKQqPsAbRXqP4SgQv
 oHL344GM9vixeShshQd0Jmg1gsbGHu8XZmGAS14a9QE4w5vdnW6YS17N/FVVJmWzEyI/
 cyYsfH+X87IGptGTpG2eJCsPxlhnlG1n8DHZJWmdFy5oZO5RcmGCEgjtrixMmBNSdOhD
 +4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719510839; x=1720115639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMmGk62sx2SvVBa9SQ9ZhkKPy2q0qJnYom/nToZiU9s=;
 b=F7rukgDck8GHzgqnZUvhyO/dKGHaVP11Sksm6bgTUAO6Q32PEUOfbDIALdJq8f2J2B
 f/ceHjRQVM+RWcC2WQInDow30qa46zRtYHrkUiwlqII60U+Tyd2atU8lLRoTjOUQAX6a
 MBLgKKIYZae+McMrrZ5GqEcDw7n5dCwafx+/oLoEgQdnd8TuAF+vaNFNAPgHD2wJjtyx
 v978bsCGIWjQPuWSe7BuMfhfKrJhFxIrTXJ9iONxjnBYR8D8FohY20UunOr41lcHUWO6
 DB/HmSuzn49LFBydOE+DMBVVBU96AxPtX+DS8kiyRA1D8fjzIvBCxGv4dGEf94Kag95Y
 JR+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCULakAJK2OyUC5zFiiN4yxQc6IPbuB+zr/sKhPyan5Zw71zBSQF6F4/7Mc1rlIFe84Xg6LY5FiYZWZFbzqiZTc3OWC9WVU=
X-Gm-Message-State: AOJu0YwXhDDO+1gLpmsILvLpQ8RFDKtAlpbP3ZK9yPRT9XCxewgFqrJh
 fNGbOXPbIRCGj3AuEi+fxRv8rqTVu4NmcyuasrWIrkKGDLszlXrC+dOzKq7n4KG/JLB4jdpbURo
 b7aL2tKhbv1st/qHopvlpPA+TVq+QdT9NaA4CezMeCMUUt1e8eiMw
X-Google-Smtp-Source: AGHT+IGkLLMvXNYB41tu79vl95vkF6GwgT6QdfIPAhDOXvNCKgS+CrDLs/4VOeqJAccBvCo9n1Ny8CxJKKdG7FWPaag=
X-Received: by 2002:a17:902:768b:b0:1f9:a79b:59fd with SMTP id
 d9443c01a7336-1fac181b803mr118925ad.22.1719510838305; Thu, 27 Jun 2024
 10:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
 <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
 <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
 <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
In-Reply-To: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 27 Jun 2024 10:53:47 -0700
Message-ID: <CAOGAQeo+DZpE=6xEeUWUEkqSwYgturQ9QzXyzNNt7QfrFqea-Q@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rkir@google.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Paolo, thank you for your comments.

On Thu, Jun 27, 2024 at 10:16=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> I think the easiest options would be:
>
> 1) if possible, allocate the timer and the callbackState statically in
> the device.

I think this assumption is not good for both QEMU and us.

> 2) use "aio_wait_bh_oneshot(qemu_get_aio_context(), [](void
> *opaque){}, NULL);" after timer_del(). You can also put the timer and
> the callbackState in a RAII wrapper, so that aio_wait_bh_oneshot() is
> executed when the RAII wrapper is destructed

My understanding is that this will work as a fence waiting for all
timers to finish. If so, maybe there is a value to put it into QEMU
(as times_joins() or even as timer_join(QEMUTimer *ts)) if one day
you decide to implement it in a more efficient way?

> Another thing that you could do is to use a shared_ptr<> for the
> timer+callbackState combo, and pass a weak_ptr<> to the timer. Then:
>
> - at the beginning of the timer, you upgrade the weak_ptr with lock()
> and if it fails, return
>
> I'm not sure how you'd pass the weak_ptr/shared_ptr to a callback

I suspect this is not possible in plain C++ without modifying QEMU or
code generating at runtime.

I would go with your aio_wait_bh_oneshot suggestion. Please consider
adding it to QEMU as I pointed above. I can send a patch.

