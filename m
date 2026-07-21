Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BEEC44533
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBFh-0003jZ-T6; Tue, 21 Jul 2026 10:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmBFg-0003jM-IA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:15:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmBFe-0005aZ-QJ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:15:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso8113517a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784643317; cv=none;
 d=google.com; s=arc-20260327;
 b=srYCjRAedWuY7rO4SV3w/h+wqcUdvQZZtw+bP3QCWZ7xmlpcnKJ0IafkBxdqGiCmBo
 EFK/BoMfj9YNVRr/XwfP7hjgPa0uQ8yKxe5djKS6azJUDql6oHf1mX5jMuCsYXEhwq2k
 jdd3jmyCdl6F1KQZfor0OBv6G3SoGg0ct3Zu7DEiy2AN5nT9k2R70giSFaZgzkFOwM5/
 icC+ZAc6D4ECcT2E42HyC/ubpqbwWED56gQA3dVecZYTZuMswvcxNWfHFJxrVHYfLLo9
 k8Hc/H9HXa/iqq+VanOjDEwG0Y3y9fniCq7RfwFMmxV0RBpRKEm70T91unFb9rz5KPR1
 jyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v1EU+oq44Z1MwoiAosqixFpEWFjxd9dPzEoQLDvB/PQ=;
 fh=stw8hlGMscVofcXRSC/1LHW5VotI8ZEA/9r0dIBDjso=;
 b=BYrlHkdxKJuc9Q0S6VhJeNpsYZhqxrDVvfU9paLq8f25t7SXWlxbAblpX9Ses7vC1l
 ej01FJENahKF2UKDKGhGC3s8Rlzgk/ozXqiuKsKU1DfiMCRP6AIJj5gad8Wg7vdkEy09
 K4YUbiecsXP4OverXKcoxKMM8nqeLEdketI+cLWGO/28KIqREJJt7AEy0omobP0YIrok
 SeXd1b5eUG3XHjKUszQQdiTS/4lLl4Sq3d4z/PPshIOR5wfyGvG6sZlBwCZugoaMCSWm
 QLRjvGPDWSURHehNBHG8KB8MDqDfV7IJ83ZeKWm4CZ3TjOwcdHWSMZ3DMxjV99kmYMdR
 0VNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784643317; x=1785248117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v1EU+oq44Z1MwoiAosqixFpEWFjxd9dPzEoQLDvB/PQ=;
 b=a4NIButGlS3b9KxM/vW9cctVqrn1/7UAc24v6LfiHjkwOHIqRew1yY1ZHlAAHoJYKF
 7YuwkRFoGudsT2HJjmzitboije1got1Pp44HEkZhD2B+538GWH1/AGSWs/EwOTH8hF5F
 mxRyqlDUZTJVai2vxyTGMyM/J+daQ5O3MMPYYV+Viovgf4X+rPgxg5UNyt84ql/oKVFf
 cxlhZiaNYbM1hhtgC4W2P7ooBy5u8ZjoD94LCm+DuGhMXb9kIAcD+g/UlYj6x80AZhHK
 ljTMORqWZNSplrL38OHFaZhj+hspH9q7ZoNbThlpEaslk8GvsJIgwNhyFGrUhLlDtch5
 P10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643317; x=1785248117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1EU+oq44Z1MwoiAosqixFpEWFjxd9dPzEoQLDvB/PQ=;
 b=MWybz+03eau1yI3S3m/IqOMToImdDldFdvT+blVGHZphURjC0hbvzeouQJuJvI35ou
 Dp0ykp4eTSbXkOHPl78m+yI9g8OkP/YnVsD2Esx5Rkc0/51UyFVVwb/Hrv7FGx7oXRgj
 5fHqtUuMxyyoj4tko7SLFfvQ3bW+m9zbaRHXIUeJvFfpUJSlHncMN1wSt3qDBDEJt3v5
 zMmcis54WNLwVI7Dhu9W7rfw5jxVTzKquQBPpsptCRezRLyumKufJQLddIQHoW7eJCdB
 XX6SQpggrNWLDUuBlpGumo1xBjYQKvlyFfsjtqS95GzrUUgyhFHIJEfgqm8nynuNkaAq
 oRrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbHs3X7TdJAC80s6gufGIRUxcPwv5Z4TtOMqKFnxJNLb36YGwoxSzEna+HsMt26j1IkmyIi+ei7Vyj@nongnu.org
X-Gm-Message-State: AOJu0YwAM66QAcipBiSMu/+XcGi5DFNf/PHKTM5Bs6dY1Q3o4kjTn4HM
 pnvkz3hIKwdp6b6GZJ9/PIRBZU0KBEeMwit+3nKjtqQXEToKj0riJmwM1sy5KIaDs5ngPpH2Hws
 pqi3DLh8kik+GmBpywmK1mVWixufSYVo=
X-Gm-Gg: AR+sD11DUZpoOW9qvBuUrOHl3Jvg/tL5GqZjzc9jxjWSe1AemB6LENcrXKjDHnhlb+Y
 xSplG4Dx534geCgx/vMbh8begFmiqFCJ70zBljlGsjQd4ssRd/O25sFMli6OcJUu1F9yN0rU7eB
 T4cTN229vzKoX5rfMgMmwtzykUSLlno9awqb5TOh75rccZnvvaL8j4rHLLiPWkAHOkF23Gr3db0
 ZvSyHEDvY38gVRQXLEfEyR0tdV5D4XTg/ddAbxa3KBmRnikvcytR35sIYEvoYxeT1Vl6XyUHf/T
 IuFWrX8tfIsr2uBRcvjxdJj0+j8LRUpGTSSQcDKVGw==
X-Received: by 2002:a17:90b:258d:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38e4b4461d6mr19479037a91.13.1784643317063; Tue, 21 Jul 2026
 07:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260720180459.2542918-1-alex.bennee@linaro.org>
 <7d5a7592-85d8-4559-82a0-2e262e5ebef0@oss.qualcomm.com>
In-Reply-To: <7d5a7592-85d8-4559-82a0-2e262e5ebef0@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Jul 2026 10:15:02 -0400
X-Gm-Features: AUfX_mxabErc6Kc0DzP8kr1fTh8QYV-Vdrh8ED-_AgkG_XxuhLvmKgojpdsbleo
Message-ID: <CAJSP0QVnLrMkVOh-1qCbbaP40nX2soDpx31oBc=M__xgHPzGsQ@mail.gmail.com>
Subject: Re: [PATCH v2] gitlab: remove gdb from MacOS jobs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x102f.google.com
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

On Mon, Jul 20, 2026 at 4:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> On 20/7/26 20:04, Alex Benn=C3=83=C2=A9e wrote:
> > The gdb jobs fail on CI
>
> What is the CI failure? Could we at least record where the
> CI console fail?
>
> I'm worried to recall what was the issue when trying to fix
> this in the future.

I added the following to the commit message when merging this for -rc1:

  This fixes the following CI jobs: aarch64-macos-15-build and
  aarch64-macos-26-build.

  Removing gdb from macOS jobs skips the softmmu gdbstub tests which
  currently hang on GitLab's macOS runners:

  qemu-system-aarch64: -gdb
unix:path=3D/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpes3paikrqem=
u-gdbstub/gdbstub.socket,server=3Don:
info: QEMU waiting for connection on:
disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpes3pa=
ikrqemu-gdbstub/gdbstub.socket,server=3Don
  gmake[1]: ***
[/Users/gitlab/builds/qemu-project/qemu/tests/tcg/multiarch/system/Makefile=
.softmmu-target:35:
run-gdbstub-interrupt] Error 137
  gmake: *** [/Users/gitlab/builds/qemu-project/qemu/tests/Makefile.include=
:75:
run-tcg-tests-aarch64-softmmu] Error 2

  The following GitLab work item tracks solving the underlying issue that
  is hanging softmmu gdbstub tests:
  https://gitlab.com/qemu-project/qemu/-/work_items/4063

Stefan

