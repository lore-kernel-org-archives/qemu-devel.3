Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B5C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru94o-00085z-SW; Tue, 09 Apr 2024 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru94n-00085l-Dw
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:51:41 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru94l-0002Px-Ok
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:51:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso7567086a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712659898; x=1713264698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gj5LnE4hcxqYVBG5Ia1oOr3C46z2gQ347BmlvEgZMuI=;
 b=ZPVetpCUIxJdJHUV64Gn0PdhkhEMZvrauukQTW+d6U96zkeIqEXDejPfvdpL7erDx1
 fzrsUlHr6ZKftsKOMT9R335EqYFt4kx67X6ERBuzfNJYJ2po9XPqU3Brjm1Dkd1kAMZy
 vhdwWHXWeWqs+0FFRWdZgARqxHpp2m6iXuJADbjwDqBc4vkL5cbaNaNW3Nt2LQsddvoX
 KqGuAwE81Oe1AYUVpgUWrOaPG2tqLzFK4WDZraf4+c5tdgfeSecdi2JjPmHcK8SSdLXi
 QraeCWC8ZjqHdpSspObmRCXy3V7j3qGtzcNVTr6jgOgwnaZdCAgApjdRoYpAlUHZp/cv
 XocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712659898; x=1713264698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gj5LnE4hcxqYVBG5Ia1oOr3C46z2gQ347BmlvEgZMuI=;
 b=B8o1HGdB8lxeOYgvcuq4ctiFUpidDdggqOt3jJ+fjFtZgsPnfjaJgzbKISlWzU5nrh
 YHDZltEShXaCyKgEtRq3p5XRnC+SXmW0g9/0DkVmtNoEMqP+cPMfQ8+JfZ0WeY0wNHUH
 DNppXhGVer5QKNx5JGTAO5vbhD5YVMxkFI8KZUeSeWOF6TZ1mwaeoC/VqMnNvT/O//c/
 TkUxU3iD+Hx0ZnfuyVwqh72Qip6u3TSeyT4zFMgemtX1OITPdn2oaDDnvu6tqu4g3YuW
 Z6AceqKaD1tfG21sXWvqldsefyNNBuSDVEcUnF5QTmqofe6rnjTb4AHPTGxrvdBQzNFA
 SRww==
X-Gm-Message-State: AOJu0YyBNvRM7mmjKkXYnZjP3/bMh9amT6O02B6Kvhl4sfQOmdp/LFfh
 Qu9iAVAVjoObewuOvFzmBS8SQTgjoiITqlj+ow8UYGfvPRbwQoGCUU856lzXiXQCzO04weZ8abi
 sJ18MWprGaFZtf0pM2Qen++9vREdNbA3i3u0ePA==
X-Google-Smtp-Source: AGHT+IGf+6/6NNrbNEZqOMClTTSnTVeR5xyyjPkaOo3G3uvUehYbBpzD8nDePlRLvubUHhnxq0m1tKzJajvY1rLXx9E=
X-Received: by 2002:a50:d60c:0:b0:56d:fbdf:ae1 with SMTP id
 x12-20020a50d60c000000b0056dfbdf0ae1mr7799706edi.15.1712659898014; Tue, 09
 Apr 2024 03:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
 <CAFEAcA_KES78EcDe6G8hmOAGksxVnJS3K6CtnFzjQ05fPtqc_Q@mail.gmail.com>
 <41f35ede.f15e.18ec271aea7.Coremail.13824125580@163.com>
In-Reply-To: <41f35ede.f15e.18ec271aea7.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 11:51:26 +0100
Message-ID: <CAFEAcA8o3sEW3S3=D_nNA9qrmjm0zZNoheXTgQqEv4RTt10JnQ@mail.gmail.com>
Subject: Re: Re: how does the qemu emulate the "atomic" semantics on host that
 DOES NOT support atomic instructions?
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 9 Apr 2024 at 11:40, tugouxp <13824125580@163.com> wrote:
> ===>yes, i somehow a little bit of guess such like that, but when try to find some code in qemu to prove the guess, i found i was lost and exausted in the ocean of the code and complex logic of qeumu.
> because in my thougth, it may be do the sync in user pthread level, so i grep the "pthread" "mutex", "condtion",... and so on, but did not find any position to prove this thought.
> so, can you offer me the demo code position of do the sync like "pause execution of all the other guest vCPU threads,", to make the atomic operations meet the sematics?

I would suggest starting by translating some guest code
with the atomic operation you're interested in, and using
the '-d' suboptions in_asm, op and out_asm to look at the
generated TCG operations and the generated host code for it.

The stop-the-world handling happens when something calls
cpu_loop_exit_atomic(), which then raises an EXCP_ATOMIC
internal-to-QEMU exception, which is handled by some
top-level-loop code that calls cpu_exec_step_atomic(),
which (a) uses start_exclusive() and end_exclusive() to
ensure that it is the only vcpu running and (b) generates
new host code with the CF_PARALLEL flag clear to tell
the translator that it can assume it's the only thing
running (which in turn means "you don't need to actually
do this operation atomically").

thanks
-- PMM

