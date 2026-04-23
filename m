Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E414F589C8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtYb-0003Gk-UX; Thu, 23 Apr 2026 08:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFtYU-0003F8-Va
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:53:19 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFtYS-0000yZ-Ub
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:53:18 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-654672a6d68so865063d50.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776948795; cv=none;
 d=google.com; s=arc-20240605;
 b=bx299YQmeGvq3K85SYBfpSfP0hRoZdmjBgg+JJr7P0kiHS/T4rqtxrYQl8J/R5uxOM
 tX1OGUNkdMGroqj/HPeLLH9R+XVSAlVtm86NBx7tVxkRMEwdd/PlnjNQQXuF/mnTiqH5
 JmjHiHTxcOJl0f3pX+n26+GK6QIZxfBCIht5OVQXbWCrm5ABeNQohrrqWlzoujwfK1Jp
 NaujKLCRnpdWd/Un3JCWN4JdLvaryg3m97MmtY1xVLYRptoLq4o4CQOfLh+m/Ghi5Op+
 qm9t8wbJ0VASEmS5d6tquxs4AQIRQGbtqWwyK93cnsuTvar2Mi+9BrEuOvbFPG4Z/nZg
 Pdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JpyMXRc4TQvhjT4RhSHO8NShVTlMIeNT4dcEnU1LSl4=;
 fh=7zQvc6y+YvhCFPml5gk3cFgDWZFS4L+GCEsnBE2lxk0=;
 b=E1oTlm4toYJsuGhAySJnrR/VxmpNwqE4vF27tYe0l+ukR9oU17nr9HeM4DupuihYxl
 L3vEziBAMatMYKmkKb1TMoNUSMTUHSDActgHDUTWi0zMmxCrbeij9OdguGDeTSM1dAWK
 YvoVcPbmP8gyMLzkAaPusVD5y/rFAUf9P7mdHa4ngpG086HrfI9FsOPhw4BDoHiXI9Ll
 OuhLQEim65TWkS+F31+LDusJogMASG2AIEN9psPMjbW/4SB4ix/WJ2ckPSwo5NtvMBnW
 13/B4SS3RMV9uY8WY6MsYFR3qJTcikGXgZ9bQ3vTRM7XoqyUbFFS0DxcNg8J/7RZLbcw
 zqsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776948795; x=1777553595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpyMXRc4TQvhjT4RhSHO8NShVTlMIeNT4dcEnU1LSl4=;
 b=sYT2G4qPyshz9Vf0Cw/AEe+k8I3EtJBhtHjsk9tVMmfxem6pKjJ2yDGt0CUEMdtYPb
 73tHpMOz9g+WWF0m6f9DM0UlqJQHdLFMVfccSSlcTFrgz0QSMoHs2T8IP3rACKvuuWmy
 rNZXNJHOTdW1Ja3ehNI8hS7CBT9IqTaSCM6exHB5fIYf+MpGaxgnUsMOd6Z3Vf6Yc10y
 sOdai0XP6OVuofX//KIWM5/lHX604pSHvhPwEZpcO/XCTqqi786E3q34Cl7VZZSXU5aN
 8sOVGFUAybKHGOfDEmnMCosGs/T2RVKrROslBA2ebRlv0PK3yTcMfdD5II8hVLPr3Wm7
 rtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948795; x=1777553595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JpyMXRc4TQvhjT4RhSHO8NShVTlMIeNT4dcEnU1LSl4=;
 b=FXXnXnZ+v9FqnWhtpGKYk6VWJIgxQzcaWFffYqilJdgfsxrqC3lJrGmNi4gj8GQ7/k
 k4H7twISN+9XlT9enD5NV1xtGrQMmYtYSve0qM4uFS/qiiaDx0g90NAS5rontE9gWNt5
 9MEjki7+H/jrQo+1vvvxGayili4rF4qnEP7By3lZjEnXZMlADauZz0uYxq6hZhyHneZe
 Up45e6KNHTswI+1Z7aQhIprke/mSRdQQshue0arhuGaAeeG7Dw3uWs6Hd+dOSk3Zu5Nk
 i4mm3u2g13hP+zhpoN6BhiPSXpK4445gIc90uRTUOoLa0cfB13Jk/m65q2/HflOkxxYn
 ms6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ubm5qtxOSqHp4vtrZMn8YwaJiKz5+aujDeCW7HmjJKptuHFwqicM3ifJU4//dMhdFJiA9uO+oAILc@nongnu.org
X-Gm-Message-State: AOJu0YzU3ii1k5WUhNV9v+j71Vij5equMMWM0Rc+eo7WmXdIWPj7Duyv
 Z4ipg2BwAmBUbwGGZ2AW+XJmqC3+44fzAtGI+lhjrUWZ9KB5XHHdSlYWB6F7yORLbFSPloHQf3r
 BpoOJt8qlmbm92eiTCywwupd51A1Ansx8Ox1huN9lV2KUHew3+JCx
X-Gm-Gg: AeBDietkv+Fp3gFvqVt7ByrPTOysYKSqxD/lrdFRpHk1qb1FR+jUleXlhTqZMCtUUGt
 WZ56/Q4Tvd/Y+1685OBdNiXZmMgAosfVUHtu/Y746A4DPU9KEZ/adn3M3hTzN/7YGEmygTi0cP1
 HeWBF6qZh4JINlJ0gyZ/GsZyoZhlyzR3RyILOJ06Xsg+96U6UdQ3DcjvYB2zQvcxmm0xbKaNxSi
 j1g4ApuaXichL98MkBTVQZ8VJYlPSr5k4C3e4LwoEBlSScPpik7IViWIrdJNGoYTasfl9eOMpvr
 T82DstDVVt2JwVkn4UfkDd9gJsEP6ExVnQJASKtGsVO0sdoqKrKVF/lnV/rhcmIo8HNPtFcVO0i
 HEA==
X-Received: by 2002:a05:690e:1c1a:b0:650:3533:89a with SMTP id
 956f58d0204a3-6531082cfdbmr26097704d50.16.1776948795217; Thu, 23 Apr 2026
 05:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <1291497d-21ae-4422-82f4-08a99224252f@linaro.org>
In-Reply-To: <1291497d-21ae-4422-82f4-08a99224252f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 13:53:01 +0100
X-Gm-Features: AQROBzAS6INTDg669Ygm3DA6Ttw-uSgNdTBhiRKl8bvHhJZV0WpLE8ao_b2ySFA
Message-ID: <CAFEAcA_vFBVBiU=27h1j+hWLX4P_qMbSUzW0rLy8yJJGKpx=rA@mail.gmail.com>
Subject: Re: [PULL 00/59] target-arm queue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 23 Apr 2026 at 13:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Stefan, there is a comment on #10 (a8af0fb24da) Richard'd rather
> to be addressed.

I would prefer not to reroll the pullreq just for that -- it's a cleanup,
that's all. Compilation is not broken by that #include line being missing.

-- PMM

