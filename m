Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB1CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn2N-0002AF-VA; Mon, 22 Jun 2026 18:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wbn21-00029s-RP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:22:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wbn1z-0002ms-TZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:22:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so7576207a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782166932; cv=none;
 d=google.com; s=arc-20240605;
 b=kGtEECEkouWpZPL4xqebF9zCAbmbeqkINFez9V2GO0psz9NMZp8NPEOuETernO3LxP
 YVq1ZwBtiegnYvbkZx0TI/DS+At9aY3fvPyXh9jxuf/Txy4vXYFLBv3vc5ngHSHQ5A4E
 LbhV9BsmoYnTHKCl9UyBCRCYPl04QPnEPQS++UHwJCrXV9T8gUV+yPphnbmJj98AZ3yX
 8SyJVB43ZaYm42qolE32S5FKoEadYwfMKRyWyTHDjXT4Nl6kL4a0inxSvydokBSs8Lra
 ZiLUoZlbVre19jb8UaTz5ER4RhmMChV57fKTUIOYvmQ5ABoXvQdkQSawE8srkVOWWT0U
 6jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RyPaIIgbF2KRIHCZLVSxp0/mVQ7uS/q58Qt+B94xu/I=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=BtWP4RABrEeNBgb9xJT9woVHlnHtFmulE+IOR/x+jKxyTpLjCXLg1eBKatAmjsWnFQ
 UuQpFVu+Ky/DzntJGCATjdSzIHD7SlRTvh+aKoYbil+TtzTQX9dFiI/i35i/IJD//DW/
 eqJrodfOvDVSjJzGn3NP9p16/Td7lEi4kUpm3bi5VPfE5jhQZogTIXLaY99JDqu8jqqh
 hABmZLY9TSQF2CQG/+XHBBe+BmlP6wYmEMQ2Lcmsa5aGxkZ4i6KX+M/iFrd5Pppke4du
 dCSC0U6xZgbu/dKtXn+fAwns3T84VUs2VDP5zxKprLh4fYKap3ycLWwht2THHZ1SmnaY
 b0LA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782166932; x=1782771732; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyPaIIgbF2KRIHCZLVSxp0/mVQ7uS/q58Qt+B94xu/I=;
 b=dxd5HOQXmel0rhN12hlMHCsflIxK/5CizN1j7tgqdgImNspOZoMqwZ1ZNPaZLdhJ7Z
 cW3bWqXLvfqAwEvm7it7B1TRkhjR/knbRVKm1ip/5oru0V+jnqbFHSKDd6jTjcAL7kEi
 07iY7gKOUgzyqqA1ccoTV3Tnn0wLi6qut6Jd/NcIbB1A0UDEMihymFTZZ+qWMiWg9n4C
 h2RSq19MVl2qYVkWFoAIGT/6hRe/y95DlXipN1CawAOA0sslM7xKotDiyAd+OZtMWyKZ
 +Bp5SmsJRqpT5GTLWExuV0/tIfuu87QIBTH5RSgbqMK7Ko6/T9WflfJs/KmaQ6zc/k0u
 Xgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782166932; x=1782771732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyPaIIgbF2KRIHCZLVSxp0/mVQ7uS/q58Qt+B94xu/I=;
 b=gpaIzAOE8QPVYm61QMaCXAhBtYTcbRXrtHSE9ZJGDv4DayMCIGaN37vZsEarjlGfmz
 RN91mLU5lmwmIOngYB3KNnSQYjSL1ktCp6ZIVOMw1Bo+COiKKlR8IViH0wuzkTUNlwI5
 w2QDTvZWetbczeEFqZAsxweWaKFF5zrq/c3dqGBdDdCh+fpEejvDfd2kGAGgXbzuTDmA
 wFvONNlX/a7bTa19SNPsHK4P89GV0Ir5xH0aOHMBnQDLGStQRQ2Qu/hEjYm9vB3y4B7J
 WnbFFDJTowSHvVMBZAWQhyk+yh9m08U9LVhCKkpAHndqnQ71Gso3aaErEm/mnl6eFUE/
 vokg==
X-Gm-Message-State: AOJu0YwWQZc509f8+udpEg7W/+5NrS203sjdpQbGX6a8Ayqk19yIlTwd
 8Pimff6OUOoBAYNzGSkZPocVfpPeP4mmzfdCUywRzzkhvRMqT6/vUM9TGyJYF1bpoEWh+OaQmMy
 GE0/BCPaiUDc10ub3YXB/kNF4rBD+FU8=
X-Gm-Gg: AfdE7cl+bfqNR7KqKpvHA7EndzCgG0vTd+RXRVUqqpOctPp8s5IlfyTfY/AOC3mKZQl
 ldAOTArjtUwrL/jD77AKvB0NSn4Y0bm2efuPtESPFhtIP0UmS7RFR5YhBA1fYOlVJSLZ8gf+yFz
 LfOoCGo1T2rkyJWWkSrRdFrfwJJBk4j3dNIc7M/CiI+yQRW9M8Ah2pk/HJGx1jFtp3VrnOZ/mb+
 5km0CAXQfQhqQTdDhVCq4gIN218jhG6wZJ8kRrLaDrPUrxmxLqOZqxtO/2EpOMXkYvcw6rDxwFW
 YX86cmpqnbcKNckmdH8XxwXsMfpGmSw=
X-Received: by 2002:a05:6402:50cf:b0:696:759e:1c78 with SMTP id
 4fb4d7f45d1cf-697dbad1119mr27363a12.13.1782166932144; Mon, 22 Jun 2026
 15:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 22 Jun 2026 18:21:59 -0400
X-Gm-Features: AVVi8Cc_PrhLpmMhkunwuuqLeMwbDfeCOJYtKa0L8LxLEVrUoIC4wVAcX25ykw4
Message-ID: <CAJSP0QX+2QR4346AAihY+fgW-f8WzPd8pq0Maw7uh0DcXLt87g@mail.gmail.com>
Subject: Re: [PULL 0/7] testing and gitlab updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 22, 2026 at 11:43=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5=
fb:
>
>   Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qe=
mu into staging (2026-06-19 15:00:01 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-testing-updates-2206=
26-1
>
> for you to fetch changes up to 2e020310e15d8452407c438271f3c06d4fa0c416:
>
>   gitlab: update bug template for sec issues & tool assistance (2026-06-2=
2 13:45:37 +0100)
>
> ----------------------------------------------------------------
> testing and gitlab updates:
>
>   - present a dev friendly cmd line in functional test logs
>   - tell pylint to skip c-modules
>   - widen the capture of functional tests logs in gitlab
>   - remove workaround for MacOS build targets
>   - update the gitlab bug template for security process

Hi Alex,
Please take a look at this CI failure and resend this pull request with a f=
ix:
https://gitlab.com/qemu-project/qemu/-/jobs/14979433360#L169

Thanks,
Stefan

>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (5):
>       python/qemu: split arg between base and harness lists
>       python/qemu: split console from harness args
>       python/qemu: dump a developer friendly version of cmdline to logs
>       tests/functional: tell pylint not to check c-modules
>       gitlab: remove build target hacks
>
> Daniel P. Berrang=C3=A9 (2):
>       gitlab: ensure "check-XXX' jobs capture functional test logs
>       gitlab: update bug template for sec issues & tool assistance
>
>  .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
>  .gitlab-ci.d/macos.yml              |  7 ++-----
>  .gitlab/issue_templates/bug.md      | 11 +++++++++--
>  python/qemu/machine/machine.py      | 29 ++++++++++++++++++++++++-----
>  tests/functional/pylintrc           |  1 +
>  5 files changed, 45 insertions(+), 21 deletions(-)
>
> --
> 2.47.3
>
>

