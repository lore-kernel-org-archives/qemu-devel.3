Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA6C10AB830
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67u1-000814-I9; Fri, 27 Mar 2026 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67tz-0007zW-Lk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:11:07 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67tw-00065a-VY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:11:07 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ae222d978so2200946d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620664; cv=none;
 d=google.com; s=arc-20240605;
 b=GeIkl/8g3KUpsAFMwzvLa/jbLOktppM3iT8/QAiDoc7S8YOTFZzrNPhbeLA14g1Lbi
 K8Ztif44urwXFyfteBRNU5WP75v20HoxmJ2l8PiuKqgcdwS76/9hhC+YWp6LcmSuSwRs
 VDHUwLQGzORMew5/v72s2Nn1iRq6dYM03a9/JjGdxUJhmISGQUfG6mHGSrSooR1/kh7n
 TNM+z4Vm6O6X52z/WP21QlU/M7BVHEF02bk8b+ka6tl60sfYVIyc7qhc3T2JH5aqB7zS
 97bzybAJIB/srpcd1aT79nzmr2XvJG8rvE5bE/W5RfJg3wX/B4Yy4uTp1CV5w+JXyWRY
 YlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
 fh=oitZ3QHc6awKanHQdMZes5gSKaAVP43MsSikilUj+dI=;
 b=OErE01nf0twZaMzG1ddlSH07jgy0OewjY6xxC759e2MRflJD3uMQohz/EM+yvWF7vu
 VPnFKLv9umaOYZG9SfhqUuhk8Y8Wu6XbTl4PmW44LoC7zguSZBhl92l1XcDS/IeXzmSY
 PMchJlZmyBDC3aU30oVdsfMuuY6KD96LqdjNYPVkOaG2J0JF+t1gvxtpyZQ0R09t8B+f
 ZuOTfzmPQDFvZbwuxMXwSI/QESjkNmhpGcs7905CqhP8A9fRxgRDW9vS4mJ8f8HxMHC7
 FurpbiC9Fl4mvRvi2y01waqcS4cYG63eYB/GFzkr2zUWOzacbuHJsKnfVa2R/imd6ZnQ
 XS8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620664; x=1775225464; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
 b=b5/dHR128P29i8dF1fnQPGn9Ua/IT23mS+JvxUGN6F1bnjtV9cO7fQVqGHLkg3/f+5
 Pa+8OoUrzLuGyE77U1cu8eXzKu7lvYGti2PSHBebudcrqj8xPaUyxeyHLEQuLQ0BV4xQ
 BYEvlnBgeExII2AW6/hXj+N7q/wc2IQWrToWqdx+F7tQ8fF2uvTxxs0nC3uD2UdAu0w6
 XVaUSVeA0Psn6qMmgQR38BbquTcbW2ImPx7x0e4cQlGVS4SldSrCwB32DKADfmlqogOo
 CXJ7z+Mn9knkBzYRrLJtsCBdr4V73B4bw8gPaKUsa9wv0Gp9mJR7YBBCiwDr5Ochaqjp
 YYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620664; x=1775225464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWerNXa55FoGg8UqFfKxYXxndTZQ6MD9X0nThJk+MDU=;
 b=k3QstPZi2T/GMMPNRwoGuwtiISq56hmVg6N1R0naorkXInZSXlcElZ2DVe+AmAGMz6
 QNfwS3zZXJqKqDnELfU/BR3tFN97FmfzZ6i/80Ht9VvmrElcrD3H8vDge/y5DNM7qZnA
 QzCXl88EBKgOHltFMYQPeraDbOp1NUdMtunZ05crOXgztJf68scotXf/raU2n5Wy1psG
 3B57O3upUu93egOQkTJ4YwYCQNFS41ucHThj0u7K+/c6vLK0DTEwuwr43ZhvdwtQWu55
 +7itAD52/ODpRpkZ5wCv9lLEDZ7nUlEdBBQAWiZafUY1wDDZ7qaxO3v5XDb9J2ONDcue
 0JWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvpFWtMZztyCLLrw8xVooT7lnkh+mR2mAWCaMo2ee7pnM3f0T6jHrRkfR+FAivCHTRZuwqkJTRB9hb@nongnu.org
X-Gm-Message-State: AOJu0YwHWdr7IvRHZioqw6aLWM4AAsHVSpac+SmjhWRc2yenIjfi3eYQ
 uUCjqnFd3iT1Fu4jvA2mU6NxVPNebOCnTK/mgJVcaKtyI8/8bkrV++VUG1zJgtarSCDUsI1WhCm
 kotb/3vUSnd1QgUswL2eb1IPUXuuFbqeMQW4qp5g3WA==
X-Gm-Gg: ATEYQzxZk8yqCrDlXEHFCwW2kOeUmWeXqllZTTLDXDS41MgDDTH3M8wCPRphxeo7VfM
 XQVPlGD76WDOtpvtjEiUbAdskeiQKJXaFhMEM4znNmEMHpEpMRnjVZ85DJ2s9YEFvZx9v6Cc78X
 IFOiq6k+kXrRanf2d0WGI0OBdreL8APkKmijF9qGM4rXn3YgLZvAPAYp+VG0pUz5yx7gThj0dGY
 yrAiwfXZ1hedUs36tRlgqf4ARO7iLjSlYaGzroiupd7koQPpA9CBFbHuGip7Bs6SiS+TOkXaPUE
 bkcnIzVWK0UZ+e9uDtj3JmXnAs+3965/OrfRlbFmuCEDTOosVKXOIYp6IlmyMApDzYY=
X-Received: by 2002:a53:a50f:0:b0:63f:b9b3:9c3 with SMTP id
 956f58d0204a3-64ff720f08fmr1735404d50.31.1774620663398; Fri, 27 Mar 2026
 07:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-2-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-2-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:10:51 +0000
X-Gm-Features: AQROBzCjIUjSFHkDPFtUrdZVMFUY3sr0ofDX50lkRJBlZpHp2XQmoCuXEF0Cnk0
Message-ID: <CAFEAcA8--YTs5rbeQSUZ3N-uGTcWjeOU2wNe8BY63tk_PmRv2Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] meson: Use stddef.h instead of unistd.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> POSIX says stddef.h provides size_t, which is the only thing
> we care about here. unistd.h can be missing in non-POSIX runtimes,
> so include stddef.h instead.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

