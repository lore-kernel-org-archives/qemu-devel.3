Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A12CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjm4-0006Xc-Dx; Wed, 17 Jun 2026 02:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wZjlk-0006Sn-Tz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:29:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wZjli-0005JJ-A4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:29:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so288364f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781677733; x=1782282533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oTNNqJndgPRI/V6E3Q3Aon3XWcY5YX/dMe9WULB0bs=;
 b=bV+VPn5yNRdrHaijMdHUQnf5+Nk2wdu63qRb+nZj9n+O4Pa77o/b1z+GzHyTWjzgLp
 je7bIcVpGnwkEbiJKzNhwIIr+MhOvRiP5z5pM5V9n5jiP6iBkT289L3iJ6AtDayeKOTd
 /0MAGleOoPyrUHSm5AcPtf7KUpLHwJ+xS2zVrRi40NP/igIX7kJv3wOSLZJmX/hNehAu
 vXOzsvtTTk1zn+J+K2rOy5LLsnnjFg5Vh4QDvP3+pW0Lsu1Rj65rRr3r5mGkOVdNEpqx
 T0zrjmQE/UIyI2vN7dKu2FzPWTlakvJzyJ+IamQi27zYXr+kTi8nerbTbnSmGWs+CqFU
 eEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781677733; x=1782282533;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+oTNNqJndgPRI/V6E3Q3Aon3XWcY5YX/dMe9WULB0bs=;
 b=mIFzdBFpSZgLLi1kA7ID7xsXOK8eI9il+rndVb8/Cg+R3urU1O/wKrLiYb0luasIWB
 g/IyFDR27cX03UZh8O9zeLSjAMmFnVHMWWO0rCNu/ab2YX+OT4aHYKGZ2B1wGAsT/Buc
 eT7zEeiSyjgvUg0l7WPA2wFCUPbmI2JmjuZ8cEC/xzJpX0tEzXyVpaR6uiQNKPsNj8HZ
 t0bI0JKs/kbIIO2EORTTT6qvCluBs0V9P3yR5xUtRuLB7ZgoXe+AH94z4im/Gi3udxFo
 G+/oASRd7mJ13gPl/YfQw0q2aF9vghza90b2odIL2CsTyCQPdRFfapdhTf2piJ9ee5dX
 CFwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ99N/Otf8l7hO9yXFw34UOjJSQ+//38gOeul0wtFxemXTxVn4gYEqWuDi/P2qN2W+exrWJu1aN5ZINv@nongnu.org
X-Gm-Message-State: AOJu0Yzgq2rA3UvcS9URH20UjUlqSY+tkQxH++kVuV22qzAVa0aHKXhf
 zSKyzbXeL8U2wVBHdiCIKg5rBLgBcoZhJAAhibHI0iL0rM7b0bjBaS1f9SKKRutt/P0=
X-Gm-Gg: Acq92OGRzNjEAcPPUoF+cF6ZQVLoXs7W05QPe/uWTv+M10Xo7eqLTOR5z5mH5bRmbBm
 4NaFEf4DRQZtrECU0ilc6mbbHNIJXNALgX0e8c1EK8Bu5VGQsdAJ8NyUzusavWJhe9F646KbkHq
 3LkSCTB1AmoIOLo6W/fIqCVGx8GsqwRngIXxWsg054LBj3kP8v2fQAx7vWdtSkP4tPi8Ah2iCb7
 ODkdq9DdQa0k8m7ufGB8JZYTjvwiIPu/lVhho84A72Ee7HDZobCWBnwcRtyn9RgBkPtUECp5TNE
 2bUv8LXi0/M49QtxvNhpN5zYEEY5vkdT8603h6/OAsyeF+CcLuKJCPqfOF4P6tvtuAGPHTE7ZIg
 M0nZ3xDggCwBflZ/cQ6O8FruihZPHKwjMJ5MuHDlg3piSBFiGM0W75dF3nCfX8hzc7rI0FQqgHm
 vay4MS2EwvBOhNbNuLSFlkVNg=
X-Received: by 2002:a05:600c:c3db:10b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-492333de36cmr31189985e9.30.1781677733097; 
 Tue, 16 Jun 2026 23:28:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233bf3a7bsm27941795e9.2.2026.06.16.23.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 23:28:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D69745F803;
 Wed, 17 Jun 2026 07:28:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,  BALATON
 Zoltan <balaton@eik.bme.hu>,  Fabiano Rosas <farosas@suse.de>,  Kevin Wolf
 <kwolf@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Warner
 Losh <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <ajGLcOrCjJFW3Biw@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 16 Jun 2026 18:44:16 +0100")
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
 <ajGLcOrCjJFW3Biw@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Wed, 17 Jun 2026 07:28:48 +0100
Message-ID: <87y0gdhe8v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 16, 2026 at 07:06:23PM +0200, Christian Borntraeger wrote:
>> Am 29.05.26 um 11:46 schrieb Paolo Bonzini:
>> > -Exceptions do not remove the need for authors to comply with all other
>> > -requirements for contribution.  In particular, the "Signed-off-by"
>> > -label in a patch submission is a statement that the author takes
>> > -responsibility for the entire contents of the patch, including any pa=
rts
>> > -that were generated or assisted by AI tools or other tools.
>> > +.. code-block:: none
>> > +
>> > +     AI-used-for: tests, docs
>> > +     AI-used-for: code
>> > +     AI-used-for: code (refactoring)
>> > +     AI-used-for: code (prototype)
>> > +     AI-used-for: research
>> > +
>> > +``AI-used-for`` should not be included for "background" usage such as
>> > +autocomplete or obtaining a pre-review of the patch.
>>=20
>> So what about using AI for security scanning? So how do we want to treat
>> a patch from a human that is based on an AI report.
>> And if ok, would we then add something like
>>=20
>> Reported-by: Claude, chatgpt whatever?
>
> I see no need to provide advertizing for these tools.
>
> Our security disclosure rules require that the submitter acknowledge
> they have reviewed any LLM output themselves before reporting.  So
> from that POV it is the human who gave us the report and whom
> deserves the credit, not any tool or vendor.
>
> FWIW, although pretty much every security report recently smells
> strongly of LLM (highly structured markdown with headings that
> look the same from all reporters), almost none of them credit the
> specific tool used anyway.

We have created a new label Audit Tooling: AI in the issues but the most
interesting thing about that is to see how AI does compared to existing
fuzzing and static analysis techniques. The underlying model isn't super
interesting here.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

