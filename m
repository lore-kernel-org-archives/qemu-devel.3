Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4049CD6E4A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTHUO-0004jg-P0; Sat, 30 May 2026 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wTHUN-0004jU-Vw
 for qemu-devel@nongnu.org; Sat, 30 May 2026 07:04:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wTHUM-0006Mz-GM
 for qemu-devel@nongnu.org; Sat, 30 May 2026 07:04:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68c5eecdd56so1426515a12.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 04:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780139061; cv=none;
 d=google.com; s=arc-20240605;
 b=hYs3lCVBcqiiUwh8Br6ulhllSrk7X1gAqv3uPpu/aaTa8EdVTr5sjDf6e8m9z9cogA
 XTxqpo4xYwFkH0ocHMt7As8dhjc/GB5vI646IgY5Z67Rdo5ZAutNkKIqVyrr+Re/TXIT
 mpe1cDpNwRksLsQQnRiCb4kJlc76MUruRabZOJAQ14cibZdFTmHglV1VXSsWKxe9q62j
 t5KDcUgI9R50w8yhfne+DRt39JlbEQpb9jXSZEVbLh9biJImD5jRUn4dOs+zKBvGGibG
 LGcDQ8UTYey5BXuZxkpaME6pZWEmxG7ZyRKP5zTWrBWqV0+fahjKLi12BjRbogQ8888d
 G6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qPnTJg/Lzrmi76Fw6argkaw5mKM0iBaalFZqNskxC+I=;
 fh=6xfvgCOniLKoqQc7pml9COjz7CYYfy4pGMhYD7FaAv8=;
 b=cSh+yGUmanFBCOZBGxa6hyWL9hRXum00GJzoWqdhD6/BPuu/8GxV1OoAFJ8C1iiRSX
 XebIT7e7P2ljAodxr15EeJ2NQEKFcMrZVUzBhlVq4t6xoboPDldKtN3FVkow6RvyiErq
 Fn/XyVzHiPb28jZed1hWQZM26rPo6Xe4Iv8Z44C0EMHK8wurQpH/E97IHv0RULbgVruA
 7y22FIlQ9Qev6MZieslGl9I/1pSpN/KNXxqw7hS9nB+0rH3bxBw0auuIopxDdZsEbNsu
 wivREmj8UBouqwYC7x0k+V8AMiCH3b6iL/HowjhIwzheKP5TkmTLi/L+bvE2IrHbuGDs
 V8IA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780139061; x=1780743861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPnTJg/Lzrmi76Fw6argkaw5mKM0iBaalFZqNskxC+I=;
 b=ni+ZmjaSg6cLtc9mMTrKBFiRCmQqAcU6PzE2H6IHws7LT+Xl6owjsHmxY0cdxbzV2T
 7WEJ0MeozfBWSYaEIv2djqjKJ0oWXY1yS5Q4wqD+Q8J/acZ7cWvGYmHE0LKqtJiOmsao
 O7UZ5aZhY6QIPXSCwHWod1N3AYfaOlLmwoXclir2MEpXqSKhlMxTGm/WQAI75qZTP6iA
 uEovfJj+WQK7uB1wNnmvpybsODpLzOO2nj0nQ0wtQzAd2XzvMOesyZMcYnb2C9OIyT8l
 l2uE2S5b+/Ed8n4WlZtFccSFor57sKovz6AB71hupJRfGYbo/D4HA1nB/FKLJ/BT7KAO
 kMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780139061; x=1780743861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPnTJg/Lzrmi76Fw6argkaw5mKM0iBaalFZqNskxC+I=;
 b=WhWeNZhvK0j2COWUoEs2i5sSfe29tnhRK3S2u/ezIylSKE7LH/PtJPqKWVrCcQ1aGc
 qWgChAcUbtSf7RHQbzLqeVQ4z8y9h6evrQph3UdWneuEsprwD+hnlK2GtkFvcu3a9OZ0
 xOTVGeUSNqzVXjGtetMETDhP9zNqiDAH7Mmdp0Bs96jWOfk4yrl6BQ1kh4rih+Jj5LEX
 wMnEXjBdDwvF+my0jxKxvV9GEGLZjT8tLVGRe0XcdWw/MPriEsIND0eQyTtNPYFDqZtA
 UBGyTGR9UAq6ibfkthLr4+HsJdy4zIPO8yBcHhLK5WJ90a9q4BvxX4vhoQqpP2nna5ee
 6mcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ971T5ylug8dTMcPgiPn5udRo9dCznoh/NBc+MHpSTVIxAUghrqzDcWMFhKQfgNAIIMJh+8VsWWv7mJ@nongnu.org
X-Gm-Message-State: AOJu0YxQmxsPRvOTHRmZ8iL8oqqGtQmzAE7lW7Z6qT62gGs+X285WaC9
 HKVuPCVR2Lbz3qaygd4hU3Tj6t2JM85OG1CQwMcexSifYuPcn/YPlYpwE7ct3Z+1LURIRpPklUA
 LrKGxHS/Nw5b/EmqPSlowx7jN9WM4RZA=
X-Gm-Gg: Acq92OEZhHMTuxNmWNRU55wp0zZ0tPTHDBcWHKkmaKpSx5ltCEVnB9Zj5b2xJTJNLC9
 g3tq38oVAQcPFETBDn4SEh7jq0Q+VcwElv4ZjRJif9zLb4V+Kql9zOqMZMaD1TfDtxBwYR5tPGa
 whgmhbbYs0+TWWTq5GdNE0M3CqM9UZZj1sQ0one8g3yhslnEC+WuXjIDK2tKU26WCB6AIn5ly1c
 MCyGkxynYZ+F+Gz/ZD26AHveQP27AdGfhVBEKX3b0ERKl8rXPKkx9BONeJVMNo98t4f47BuLm3F
 v5rotcRC/Rwb94azYPE88vS4wVM7STue+/NBNIFvhWXs5zm8hXHF
X-Received: by 2002:a05:6402:278f:b0:68b:1e3:f626 with SMTP id
 4fb4d7f45d1cf-68c87d86170mr1953337a12.0.1780139060822; Sat, 30 May 2026
 04:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
 <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
 <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
 <CANCZdfpQA=90x-dS=d4-Vtt43zdSWYg==rcx326wrCfWAbuP_w@mail.gmail.com>
 <CAJSP0QU27JHhDq0k9+pgu3PVzAwfppReWRzdi-UCrT9CdbRG0g@mail.gmail.com>
 <CANCZdfppQVMtQYMRDVZaB4_k3Vt5X7=k-5a1HBUvUT3+Pp3i7Q@mail.gmail.com>
In-Reply-To: <CANCZdfppQVMtQYMRDVZaB4_k3Vt5X7=k-5a1HBUvUT3+Pp3i7Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 30 May 2026 07:04:08 -0400
X-Gm-Features: AVHnY4L2JgqDYJ499CVgIL28WrkVfO1rMKeqfl1pNUE9ahSXkioOGqsxtskpHZU
Message-ID: <CAJSP0QXEKm+t0NHtEFFXqBoZaBArb42X2TfYY3qO+-6gDSD2WQ@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Warner Losh <imp@bsdimp.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

Hi Warner,
I was able to install FreeBSD 15.0 because there was a netboot.xyz
image available in OSUOSL's OpenStack.

You can now ssh into 140.211.166.82 as root with your GitLab ssh key.
The machine is now yours. Please let me know if you need anything.

Here are the host key fingerprints:
140.211.166.82 ED25519 SHA256:fnEX4BeNwRVgwfwR9GQ/fmTN0mM6M59nr1GYXwWR8jM
140.211.166.82 RSA SHA256:x8IuTdim+j6H6Q1k44hkpDZwrM3zO9v5OD6RJpZ78bE
140.211.166.82 ECDSA SHA256:E3hh4ijePh3u7U0SQAwkaI+lil4mzrKmNamcUeexywE

Stefan

