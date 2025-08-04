Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05044C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirwM-0008D5-MV; Mon, 04 Aug 2025 05:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uirvZ-0007uK-A6
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:56:37 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uirvV-00023d-8n
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:56:18 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8bbb605530so4465828276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754301374; x=1754906174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOqsSEw3G+BuDvoLjcnxIL9b8fBGsvkEUCwqMi3L3Mg=;
 b=HdWi6O67OBeC72ac/26yUK/j3LQdplnEjoHkxXLja9GrW2325/HXzwevY2A3HCP9MX
 YKqoiwd2aj/CrC1d/s6P8QH+aYkeaxxuTRvt0HtZYyUmVYS6NNAwIjhyLnCXOMbGt6Md
 cOZA0ZSzuz2pI9VdZB7aTnKrtvVJHC4v1n84OdkxPsTpqs/ETCQBp/t4tJAaWb9Sgfx3
 2M+13MZ4LT9sARPkrUcD4QzcCoNYzW0pDOUHPTPg5dOzXldzoC7nGx/iGWLkCnx1Rulg
 Q1SmWdk5qiB/JdpAa4TiTp+iNTvmePKr/h3uxAJ8dmnWyZju8LE0Mb7DTycvM2Lv3bPv
 AeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754301374; x=1754906174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOqsSEw3G+BuDvoLjcnxIL9b8fBGsvkEUCwqMi3L3Mg=;
 b=Donbqr2QNoU8r4gYEIPZS7ArTxfeqiP78YP/c/bctqkEX4OGpC57/V78gNh4VXjNrs
 PT6RK0koipsMaaVAfXUJAjF5ZXF3GZ/VaNZGrNjlBBAPfNg4krmbmy1Ukjl/eeEQ/epH
 mlBbLQPK48w8TNda8sW2pk6WkSw3ba2c0V368lazsGthlrhIDdpSxK7eHIxzKiUVNIal
 oikKTinU5/rPC9q3sAxR0ZXlHRk6T6P0yQ9Bc+pfJfvF588Xr76vDa3hMf3Wcug6GJmS
 Wxl9+xM7jkKcpBIY0LwmQe8bVqsz8oQ72guPpgSFcSdxB4ZquBZrmr3RbeVor9LRd1VH
 BvzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6dhK3jLRVzAKIp+LE/J2+x09qEd7EWQ3lpTH8/qfDF9U0RBPpK0CyNOW4eK8OMzSXho3QQgt3PXH4@nongnu.org
X-Gm-Message-State: AOJu0YzQpkUYthhFTxnXDgwiYayebr8pq5wrZRSFNpVHBbWfS4Iau/YV
 wNf3HeqpdgE+nLQpfmSYwtDzW5U+j/Ozqf7a0ngwl7XvXoFe60BsYu5wzalAANZIaqo4n7ET0VH
 v/rd/5pmrNMMliWJIFHCPEviGVIr+zwF+01r7y0f7IA==
X-Gm-Gg: ASbGnctn5TEDHhUDv2Vi0W2SU85eH8QAl9zt6AR4QQ3jRWs9AdlcHcFrRC3GmPjG1ZV
 CCOxfZ2KCP/zc0xs7si41+1sqD3zMLSiT1wF7xd1uxF0MeU1JOHAWUXKgZ0WLlFH83ZYHoIGLLl
 Ht4lfnM3aEkOo9tOnf0d+LLcj2JkwvnFaCV7W0B3GfUUbKQZFf0PLHu0BHltcONfd+0Z5QF+IC0
 WD5XkZ6
X-Google-Smtp-Source: AGHT+IEcQelZBtDfDGT9WcdIGIedsIk6Z9IX1Q0roEbzabDdKOW+v6GXIrhnYN9mxoTbJBEhlWXPdCT5RflKMomRsnw=
X-Received: by 2002:a05:690c:4b03:b0:719:d8dc:343f with SMTP id
 00721157ae682-71b5a860096mr186497437b3.15.1754301374462; Mon, 04 Aug 2025
 02:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250801001305.2352554-1-gustavo.romero@linaro.org>
 <CAFEAcA-6wr+frdc4idVs45POcPVG54FFTbtqPu3x9Jzfa-gwow@mail.gmail.com>
 <87ms8f76yp.fsf@draig.linaro.org>
In-Reply-To: <87ms8f76yp.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 10:56:02 +0100
X-Gm-Features: Ac12FXxW3RZOZAnP-zfOUBCd4-J_z5xO5EzDSix_XZ04Fw3p8ooDZcrMTUNdk1o
Message-ID: <CAFEAcA9zfqimHofFB-Ch=zaSc9gLuA3MaxhMoeAF-wP+meKDag@mail.gmail.com>
Subject: Re: [PATCH v2] tests/tcg: Fix run for tests with specific plugin
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, 
 pierrick.bouvier@linaro.org, manos.pitsidianakis@linaro.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Mon, 4 Aug 2025 at 10:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 1 Aug 2025 at 01:18, Gustavo Romero <gustavo.romero@linaro.org>=
 wrote:
> >>
> >> Commit 25aaf0cb7f (=E2=80=9Ctests/tcg: reduce the number of plugin tes=
t
> >> combinations=E2=80=9D) added support for running tests with specific p=
lugins
> >> passed via the EXTRA_RUNS variable.
> >>
> >> However, due to the optimization, the rules generated as a shuffled
> >> combination of tests and plugins might not cover the rules required to
> >> run the tests with a specific plugin passed via EXTRA_RUNS.
> >>
> >> This commit fixes it by correctly generating the rules for the tests
> >> that require a specific plugin to run, which are now passed via the
> >> EXTRA_RUNS_WITH_PLUGIN instead of via the EXTRA_RUNS variable.
> >>
> >> The fix essentially excludes the tests passed via EXTRA_RUNS_WITH_PLUG=
IN
> >> from the rules created by the shuffled combination of tests and plugin=
s,
> >> to avoid running the tests twice, and generates the rules for the
> >> test/plugin combinations listed in the EXTRA_RUNS_WITH_PLUGIN variable=
.
> >>
> >
> > Since Alex is away and I'm doing a target-arm pullreq for rc2
> > anyway, I'll take this via target-arm.next.
>
> Are you sending that today? Otherwise I'm happy to pull it now I'm back.

Pullreq went out on Friday, just hasn't been merged yet:
 https://lore.kernel.org/qemu-devel/20250801155159.400947-1-peter.maydell@l=
inaro.org/

thanks
-- PMM

