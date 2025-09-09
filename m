Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D848CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuDI-0004r7-OH; Tue, 09 Sep 2025 05:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvuDD-0004mB-2C
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:00:29 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvuD8-0005Sy-AX
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:00:25 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6196ace1fd1so925159d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757408418; x=1758013218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z49sepq/3zqZKM1bKhwY9sTr/qPvppgs1oGh06pKPZY=;
 b=VB+xd03gIWCAaJ2wWC99v9basu/Rt0xmRCePUi35aOas84dnFWmKGEeLD061ZVxGxh
 qkVZA9hFmvmuOwy+72eU3ZK9iFNtABOoaWl6b8tTpR6Yi5YpVvcbTwFb17s+/75p/kvW
 oxQbAu22czL+yPlAokmUUKPO31a9l3AjHSrpk9aw4TU0fN9Mt9/n2/HdBMD0UHhumJg1
 aZRu9HL7985MmcqBtLBt+Ivco6xXKUnhcqSlZJ1NGpR25oS/CPVPSVF8Sg4aGpwwNsEt
 KWi6Ky3CTyy3RjLno4g04UTqjbzbIebeni4C5uPLjmJgPpmoCi68Uh8HPuIekZLON7fN
 pFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757408418; x=1758013218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z49sepq/3zqZKM1bKhwY9sTr/qPvppgs1oGh06pKPZY=;
 b=S5sLzwA18cXcOm8g/IbRq+fIKvhHVFuCBke6x21xLWFKnib5LGRPx2c7YX6PM3fU6j
 hWH/hvlBKgqfcmwrKfjXNfK1ewhFSvADRL25u3j9kp1EGiplT2edPBA7vxhLijE7O2qe
 A4x5Q9EHq3UE2nzPeM/zSkkcj9eVcohRKE5QyLEIpwWbceM2gf4jx0MmK83GsOu66grZ
 C5PPiHZgpo/EmsWdv2hfzs77DYefqEZka+z3L9zPiDUJK0aeZSfwg0ph0ybbIlVLnjgz
 k4DTnHjEqA7cIM3E0KB0nFpAUh17+o8ZCzlF4z8AtRemOsMX056USBJ3N/Yg/OBDzZ8/
 9j2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA3kdXdgFBaxCqtlg9VQf0qlLMyQeCrTihVmvgGKSwew8xGrbFRBtLHWVt4N+4jpYfIsC8XPi9EkqW@nongnu.org
X-Gm-Message-State: AOJu0Yz6JWJNOIk8MR5SVSZrfCGrvUCXnUSudXianiUBI2pTG39ZnORs
 2gc3en8uhpueMSeg/p7CvouYacL4ghmVnjZIpxCdndiwtupI4XK3/z1EfBrHcuySXjr+kqC7Q/A
 RoiWk+1ojmjoqPavO5A08I2KYaFBfyliEV76aYsNMHA==
X-Gm-Gg: ASbGncu7eGethPSCX8i/Y6bcshUNTjBekciMUqN0C1xf1riBwVSIaur8kEHRRf6+b35
 +FDDbLxAADHJidVoM9nwXxfgkpdpLVl5rea2VOTn9i9CBRYl6jmzzcl1xyChBKmf7QOwDfU27Kg
 WlEt8iStLk/mh2UWgxhQ9J3tpsQxg2b/4HntTANSqqqoZQiYJbR905bphHxVbbo3Y0bw7Y5CE0b
 fRXsPcE
X-Google-Smtp-Source: AGHT+IE1lYni0mOLv6VKfYm4T1KgbJtm+N2BDOCUvIwRDOvjDbnQXlQGbZKT7P3n6ipvPjB6wyJR1xqgm8Mh4+PU4Xg=
X-Received: by 2002:a05:690c:700c:b0:721:5b31:54bb with SMTP id
 00721157ae682-727f505853dmr112011767b3.23.1757408417665; Tue, 09 Sep 2025
 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250908211859.2678847-1-alex.bennee@linaro.org>
 <56baeaa6-b274-457c-931d-4ae76535f6dd@redhat.com>
 <87plc06mwi.fsf@draig.linaro.org>
In-Reply-To: <87plc06mwi.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 10:00:05 +0100
X-Gm-Features: Ac12FXxm8FiMkZtNimYKqtfIa7lYL3OrflX87FoePOT2sPiQ8muUUxseKXmH5OM
Message-ID: <CAFEAcA--2G_K-4cjb=Xms3hQoGBAauyn+rJLTsFh1TnfnY6KWg@mail.gmail.com>
Subject: Re: [RFC PATCH] scripts/ci: add gitlab-failure-analysis script
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 9 Sept 2025 at 09:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 08/09/2025 23.18, Alex Benn=C3=A9e wrote:
> >> This is a script designed to collect data from multiple pipelines and
> >> analyse the failure modes they have.
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>   scripts/ci/gitlab-failure-analysis | 65 ++++++++++++++++++++++++++++=
++
> >>   1 file changed, 65 insertions(+)
> >>   create mode 100755 scripts/ci/gitlab-failure-analysis
> >
> > You already get a nice overview by visiting a page like
> > https://gitlab.com/qemu-project/qemu/-/pipelines/2019002986 ... what's
> > the advantage of this script?
>
> Not having to click every link when I want to see what the pattern of
> failures is and what might be a candidate for making flaky.

What I would like for finding flaky tests is to find every
case where:
 * a job failed on commit hash X
 * we also have the same job succeeding on the same commit X

Those are the flaky tests, where we hit retry and it just
passed the second time, and it rules out the cases where
we had a genuine "job failed because the code being tested
for merge had a problem".

When we find those jobs that only failed because of a flaky
test then we can analyse their logs to identify what the
exact failures were.

Can we find those with this script ?  (You can't do it with
the gitlab web UI, whose search and filter capabilities
are extremely limited.)

thanks
-- PMM

