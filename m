Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBEE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWaQ6-0007K8-Qm; Sat, 11 Jan 2025 07:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaQ4-0007JU-JB
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:16:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaQ2-0004kD-Oz
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:16:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so21066695e9.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 04:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736597805; x=1737202605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4itmC12w80sl2QZ5mJBnamygFIJzf3r/HgzsiDNec4=;
 b=x+hk+P3o1Om1Xl1xoHRD2hPnIgwWu+xuAPSoZvG812lQ0ICG8uq2N8XasxTdtyNmuM
 q97606EcDEsVYj59vUxtcr3VhxUCJt5rajJUxVL5eM/WTzVlX08Q7e8uCIgb6QUNG/Ua
 v2MbNTJTisuOMT1ywqgpMMmko+Ju2OL6Kn64NsKEK5a4IjIdL4rAn55O92jhcNl9Pv9Y
 6oF9iSEFVINOGtIGi/G1gwAni+Lapo6/ku5kwXCO5yCGi7uiCs3531Tqem99nm8unqY7
 e12AzCCS/keCBKSVTHM0xfHl3a8AgRyixM6WjGDnw71wQqgMYpdZpqVgmrDH2bqB+mOp
 SE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736597805; x=1737202605;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W4itmC12w80sl2QZ5mJBnamygFIJzf3r/HgzsiDNec4=;
 b=uuNBM1e5sd0eLM7zk1WA4dMj+p32m3avBj8SGyYJo4P+FBum+gBmeR9Jz2un/VtVap
 Z+fqVHnJ1CGyHnLxT3UGdhr6QjOHnaHoSqGYZvK8yPVY+HADpEduu4Q8fc0pC0ikz+8Y
 WWI+xUY61RyAn7bItqgypBNHlMkyzHXSepiVtiufTtNcLEFG83L+Mum2XuWyESvs1gox
 xQ4QaOUu5A5Xs7tcvhNh2QB5dKGCKbx3lu3AWyo7+N/6jG+NWaH57B5Kj0H5u7uTXP7M
 FDu6hIts4JoUCXmYWzu1oNTNRqeUZl0JJPo8hVCotWWjVtd3g5mznGoeIf5rkaIHWyKb
 jBQw==
X-Gm-Message-State: AOJu0YwFOAB8t6ERQ/nyUWpHODUtTEqogI8pmr7QdHFmyAImuPQS5RYg
 obtXgzc5SB14/g7vHdv6Y+seeiT5UVlQR36o4GIKoGUkUglUb5K0Q6jMpcFox4Q9oWzrpnJQwpm
 vybI=
X-Gm-Gg: ASbGnct0xYm0D+Y/FG5nDBgp7mbQ1AVr0XLnkfr7kVkjCn+UoNBOM13GjuVemh2LmrW
 hsEoq65i7f/l+e0cF6aq4k/0PBqNwkrxW+16o0/qUdsf+gNcx8b1cJbZUlo/cG7mgJqDG72vgJ6
 4+atiBTeC0dOQyCAld2rIfmVoRAPVMHlNcn/fEiBr6fVjzLIzxynZzSlEYUVX6cI2Nt2VhgB0vU
 qqvBpIyUsECHh9W3qV3IVNMOXxXlyB9icMzZ1jVR422gCZhxuI5Ghw=
X-Google-Smtp-Source: AGHT+IHGvmTopQmj3tsn5TYH+yRDSvlNMaNJIPOhKKkrOHloMiBt56SOJpx8KE4mEg0moHTttPEMVA==
X-Received: by 2002:a05:600c:3ba4:b0:434:f3a1:b214 with SMTP id
 5b1f17b1804b1-436e26f4af7mr105447665e9.28.1736597804914; 
 Sat, 11 Jan 2025 04:16:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9df958dsm80906405e9.17.2025.01.11.04.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 04:16:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D04B5F886;
 Sat, 11 Jan 2025 12:16:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] testing updates for 10.0 (tuxrun, libvirt,
 dockerfiles, misc)
In-Reply-To: <CAJSP0QU85dCHKDUwuW7w2QjBNkR+tJYgQS5wE2_n1yNNmc73kw@mail.gmail.com>
 (Stefan Hajnoczi's message of "Fri, 10 Jan 2025 13:38:17 -0500")
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <CAJSP0QU85dCHKDUwuW7w2QjBNkR+tJYgQS5wE2_n1yNNmc73kw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 11 Jan 2025 12:16:43 +0000
Message-ID: <87a5bxwno4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, 10 Jan 2025 at 08:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit bc6afa1c711da5b4f37c9685a812c77b114d8=
4cb:
>>
>>   Merge tag 'pull-xenfv-20250109-1' of https://gitlab.com/dwmw2/qemu int=
o staging (2025-01-09 08:39:32 -0500)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-10.0-testing-updates-100=
125-1
>>
>> for you to fetch changes up to 70b7c929ba39f15a94fbc63d9be88e8da907cc46:
>>
>>   MAINTAINERS: Remove myself from reviewers (2025-01-10 11:18:38 +0000)
>>
>> ----------------------------------------------------------------
>> Testing updates for 10.0
>>
>>   - update the tuxrun images to the latest baseline
>>   - add the m68k tuxrun test
>>   - ensure qtest checks the result of clock_step operations
>>   - introduce new ztsd helper to functional tests
>>   - ensure aarch64_virt test exits early when no TCG
>>   - add new test to exercise virtio-vulkan
>
> Hi Alex,
> Please take a look at the following CI job failure and send a new
> revision of this pull request if something needs to be fixed:
> https://gitlab.com/qemu-project/qemu/-/jobs/8822037880#L593

Ahh the acceptance tests don't run automatically on my CI run. The
problem was the opensuse image doesn't see the DRI node. I've tweaked
the failure leg:

        try:
            self.vm.launch()
        except VMLaunchFailure as excp:
            if "old virglrenderer, blob resources unsupported" in excp.outp=
ut:
                self.skipTest("No blob support for virtio-gpu")
            elif "old virglrenderer, venus unsupported" in excp.output:
                self.skipTest("No venus support for virtio-gpu")
            elif "egl: no drm render node available" in excp.output:
                self.skipTest("Can't access host DRM render node")
            else:
                self.log.info(f"unhandled launch failure: {excp.output}")
                raise excp

so it now catches that (and also fixes a small bug with the unhandled
case). I've posted v2 of the PR.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

