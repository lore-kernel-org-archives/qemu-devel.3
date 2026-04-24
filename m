Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBFEFB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBd2-0004L5-MV; Fri, 24 Apr 2026 04:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBci-0004AC-6Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:10:59 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBcf-0003Bl-HN
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:10:51 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-652fcd5a6d7so8260622d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018248; cv=none;
 d=google.com; s=arc-20240605;
 b=dgdUEGiX/H0InMhhdSlklCaEGmdHuXpnsv7Bs0PiyfPc71FV07PfIqTeWOygeeYANZ
 IPoqntLzyDZWZS+vmnUECwYv6K239UlxayBCzKN5QInUa/3uLQKHOWTjfqh9SaREOQEV
 ja9VgorgmV88UdB/y4T3libNtvBgcVVPmntbhMUQLUPPxIQVX4LPLnGY3HUxuGvgEBzL
 XAJToMg9SQD+hooWZjVpYmEK5spoMA9pSBFdOHFdAGLglyfIeTAHuz9f406eqOg9ag9e
 eMBEJElxiOnisuVnDPpAAdF8BhLMb8tfH4yZcncwPFPGBJXsksFom8kRKTXd9elhjzFX
 yiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gxJWurcS+1K1oWc0W4+lon7MvEpckKjZgKf0N3mbbME=;
 fh=w2rW9W+Opgdio/D/BQfWVHJfvF5HftItzormBXGftPs=;
 b=I83SmKRZJPuM/3OFAPvbiCpCUc14mTLBj6i6/hXnmoadTsk04leJAjbL0067srTEik
 lum9k/FTfkaTnBI2dj3Y1fZbHn4JyRrfjnKFa38aPR5MMA5E5Bgim0+C4KXpdqeNidDy
 YJJppxDODSV76yBob9axdD9xArO81Ctq0D638Nov9ZlXy+ejcZIGXkKkuJP6E6jItHKY
 iVWNnf7vBWXzFPrTn5tQLTyShkIStUo16EB0SQ2Fuf+SbsMrfbb6ItJzpjQVR6qYTtCx
 qSs0NFkBvnlOh2sHCd590a7gPss6wQ0alVFpYnMFbUoaOn19lGJUt0cFY/MEiEeD6D3w
 6EsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777018248; x=1777623048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxJWurcS+1K1oWc0W4+lon7MvEpckKjZgKf0N3mbbME=;
 b=Aqq5zx+0pZsQnb0HCZCe30N0Mcx6fOyhcDdyl9cRY0XC/Dtg8onfbgyMU+1Re043fO
 XXpn20VBw+fcDI/aSblaBvS5m+DdDwflTFU2RrNU6OZMeJsKbepVtGeSHKuhhtpdqr+6
 +WXLNVGx9Hh1vwLK0ewwDBb5oHM3GZeCh8ThsqxLn8m2UODx9ZO6KEsrjhZ8QtJdAnti
 KMvNvfaSIt+Xpq5Wj37js5oJ7HNWlQ5EPcKrgHd/UlJ/tjMgmnKnKmkxEVpSkWGWA9YF
 4YwMRTpi3mjgSViB0DCoo0cFseolpVhCu4f34kkHyzoFLddNtJp/1d0jqTOqT7Nj5ZZa
 QM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018248; x=1777623048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxJWurcS+1K1oWc0W4+lon7MvEpckKjZgKf0N3mbbME=;
 b=akG4WSgOe5MU/lJ9Xu57W17kzAb9FpPG8GNmJ3trZv7hDsblbvDpkvSiEMdSn0LZFs
 6fQSZpzkRQUHri8I6s7PWpwb99gj8dsfx+EEQ8vbQKGVbm3F6rm5lkZrTHZEcdNxil1A
 22zsjTEQ0bsqUf/3DB7qFRbYwnKBCDF+hAxayIbdWx587JLQ4AiBLwHNy6PmsEVCYT8S
 9h0by9PLeyyMMk3urD8ifoZydhJ4iWM5hdY4AWx+FXYJnkhnxesHh7DiK8NTd1rItBtK
 tgaQn/6ddNb3DOd+PGt3BaoUo71p74OgAoH+ORUAOG7RieZO6Zdhumwlt357bUHUNzlF
 7a9w==
X-Gm-Message-State: AOJu0YxOJpQNaLt+lDY8rUJ/+azY4Vh5cnFR3sQ+aLEwxk8DHbu+cSWH
 2JVvtjYuzoUUpHY4iRNigISHvOdzoVxJkZxXp9pJ+s5HJalfZIQ8OhsRHQgHfhaSxGaB0tr7vEj
 yDpJr5g+7MRjugIlpGuLK9WN/nEBkFQitoiPbxbVgWQ==
X-Gm-Gg: AeBDiet4BYZIHA38KiWAAyUVeX+V6PfgSnEm11ncZ9P2L8P410V3YZSPFAc5e+WyIWC
 bg6PotRyapaN5hDkMudH9ak7QuB2BeXuifQQOIL4HMvkPzQ6rTshCJ+dDfbHjpaNs9oa9Yo0wpJ
 hRQvQEC5xSSGxEMp40xoCBZ4W0jAZ5ZbFscQlS9JB0M+Q6rAseYPpNkXVGaNmI1SSUmbAVm9s+L
 U9ZeQZoaBAD9aFpGdtTCqVFMPWg6lopXNXpoAeMNCKipgUQV9sVpjL6uMtkuatlcCWTDBmrsfYA
 peMvHOg2smMEzKRFfUZtvBcQPyccuVXWV8ul/0rUb6VwMDzPJMLytH3KNIoSsg+Qr7YceplM+0I
 jWg==
X-Received: by 2002:a05:690e:b81:b0:652:dd57:af1f with SMTP id
 956f58d0204a3-65310b87f31mr26714457d50.61.1777018248223; Fri, 24 Apr 2026
 01:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260423180304.53789-1-lucaaamaral@gmail.com>
 <CAFEAcA-mqtqcgMVeNgMawjN+RJF9DsfXvnLw5ncB9fRvTo2iJA@mail.gmail.com>
 <CAFO1s2OoAe=qktioe9uWLWR5bHL+LEzrrc3DuXzremfWPQigzA@mail.gmail.com>
In-Reply-To: <CAFO1s2OoAe=qktioe9uWLWR5bHL+LEzrrc3DuXzremfWPQigzA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 09:10:35 +0100
X-Gm-Features: AQROBzCrjIGT35RJckDSmicD2sY7uoxv1TJZ71xt5_A0UKh5KXMM2XbNIJTbQ8s
Message-ID: <CAFEAcA-um6WHbM9+LypV4fJpD750vBO1Vo2vhCdWS4Ko_yr9cQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Lucas Pereira do Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 23 Apr 2026 at 20:07, Lucas Pereira do Amaral
<lucaaamaral@gmail.com> wrote:
>
> I don't mean to be a pain, the contributor guidelines says to ping weekly if not reviewed, I just included that in my todo list (and doing every two weeks).

Yep, that's the right thing to do; pings aren't a problem.
I was just letting you know where it was in the process
on my end.

-- PMM

