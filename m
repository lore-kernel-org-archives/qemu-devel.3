Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAFDCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJp9-0004MI-1w; Tue, 19 May 2026 08:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPJp7-0004Le-Lr
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:45:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPJp4-000639-Ut
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:45:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso2867645f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779194721; x=1779799521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIrcAWnb2Oj8YLYLyAr7hThaXdNHD8UOpWa93u3m5Ns=;
 b=IvE9fVmsw0yVruT3tmrq/0sDPwoH0pkyxRapt7XST1x+s00j6KWAOIAkm4nXn6XOTO
 fTQt7H1UKt2zhTgs9zJE7JmnCPp86UXTHWm7gO8LiQh9ilesHse2Oyd7qhPZPUHHXGqK
 A+5KCl3xDSF9zA8Aat0/IGVFYDXqv+4DZXrY3yXZFwLBP99nsl8H5+EVkgYC8IStSE3O
 FLmRi01YaUyknw0oS/wG5PwB6mXNhzhxz8BBFeO9RFNUCB2qztURMwYufHhuPZWR6NLL
 EkBaNcng3NesLlVc2dw0LblMwsu+Nk1UvrHpT0qf9BtsNDBdw7uRQxkh8u12vT+p3EJ3
 KINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779194721; x=1779799521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIrcAWnb2Oj8YLYLyAr7hThaXdNHD8UOpWa93u3m5Ns=;
 b=sPwJCtWMw0b4Se9Ru+oJHhdLMJfx6TKNls5X5gHL9IQg+1Jta23WT3tYHniomk2EIG
 ulxoe2kwSCnYiPCtCkVznzkNdBeWSUiykKXKQUtFB90P0n0f6jSEiHBTTTTlToMVrpzQ
 /mZgr9hIyzfPIBQCeVQPItDlhF9ddqmW0edK1AmleIAC6jUQWuwhlrB8N2Kf5U5Vm77d
 p7OFJmH0Pc4C7rRBmru+BAbgXHL5mmMQJzARAYfq/8YOv2iLC2uWttgXpCGvAdKEo5Bk
 dWw/uT+5X4TIvAklbtFwg3ZEIllqKRPcYJofyY0XOxRqBYZFgWrY027ZY54S0/xpnUIi
 rIag==
X-Gm-Message-State: AOJu0YyhCA84pXAPwQza6H9C8sR4Oy6wVbN6Rbpk8hGgnvq4HVlyChhT
 oUm0nXNmQJzJpxkvmzv086KQKdcN42voDP0sk17phFtqbumtp+VrJ/Ogf++pbOH4Mo8=
X-Gm-Gg: Acq92OGVcLflGMkpJzCIx6umm67kd3XcbgP4i+hYyg9sEUPhql0CfJAtajJvCifAztf
 l2KpZJQMtDG3Jdr3WNE8tJhATG1O5UwKqSfnjZjSHEaGuWTI/OJ5SK/1AN694QCGBYKWDaI0p1W
 4bzONhy65a5jo1cvyO2k+4/a59p0jmz/xWMiwgjd8AMzU6P/Iqk0vPOVtkp/rG3tpPP2EY4nLfB
 GwP7BLp+761TJVKVNiCvt5XhgHeOJgXU0qTrrtDdiqNUC3JCtxnQ0j+luX6XBHXY6qkh2NP+srh
 37mJ2Lnw1Nnuabd8awHpY1uCJ/N6rpYzSxNg8pb8kQD9sBITXqsUHp8x4POQKcjtDhILPX0MFkD
 CG9oOfZOLHgfFVcMOjOhLrxVUUiqbZ+gL55vsacQ8e0lWRwLT0iCgqh5YpefSufE2y1OABde1oS
 IbI+vQ7zTMXwA6DspTcr2okqU=
X-Received: by 2002:a5d:5d86:0:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45e8547f327mr9281088f8f.37.1779194720692; 
 Tue, 19 May 2026 05:45:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm48592663f8f.7.2026.05.19.05.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 05:45:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 589695F81D;
 Tue, 19 May 2026 13:45:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-gpu: Do not wait for the main thread
 during reset
In-Reply-To: <87h5o3bmp5.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 19 May 2026 13:36:38 +0100")
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
 <87mrxwcxzd.fsf@draig.linaro.org>
 <aeeb9f81-3dd8-4fea-83ae-7d88ec1be971@rsg.ci.i.u-tokyo.ac.jp>
 <87h5o3bmp5.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 13:45:18 +0100
Message-ID: <878q9fbmap.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>
>> On 2026/05/19 4:35, Alex Benn=C3=A9e wrote:
>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>>=20
>>>> This fixes a deadlock I previously observed with the test in [1].
>>>>
>>>> However, I can no longer reproduce the issue reliably with that test, =
so
>>>> I used Codex, a coding agent, to write a more reliable local test case,
>>>> shown below. I applied to Codex for Open Source to get access. The test
>>>> case is not intended for merge: current policy prohibits that, and it =
is
>>>> probably not worth carrying anyway because race-condition tests are
>>>> inherently fragile.
>>> What sort of hit rate where you getting with the race? So far they
>>> have
>>> both been rock solid without the additional patches for me.
>>
>> I hit the deadlock in 8 out of 10 trials.
>
> It's taking a lot longer on my system (~ 1 in 100) but with these
> patches I'm still seeing a hang, it just takes a lot longer to get
> there.

tsan shows:

[INFO] mapping blob object resource=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
[INFO] resource_map_blob response is CtrlHeader { hdr_type: Command(4358), =
flags: 0, fence_id: 0, ctx_id: 0, _padding: 0 }=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
[INFO] unmapping blob object resource=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
WARNING: ThreadSanitizer: data race (pid=3D3564641)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  Write of size 8 at 0x55c8ce6d4250 by thread T1 (mutexes: write M0, write =
M1):=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #0 qemu_ram_free <null> (qemu-system-aarch64+0x98f863) (BuildId: 9e57c1=
9eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
    #1 memory_region_destructor_ram <null> (qemu-system-aarch64+0x977046) (=
BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #2 memory_region_finalize <null> (qemu-system-aarch64+0x9830e5) (BuildI=
d: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #3 object_unref <null> (qemu-system-aarch64+0xfa741c) (BuildId: 9e57c19=
eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    #4 object_finalize_child_property <null> (qemu-system-aarch64+0xfa765f)=
 (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #5 object_unref <null> (qemu-system-aarch64+0xfa73d6) (BuildId: 9e57c19=
eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    #6 flatview_destroy <null> (qemu-system-aarch64+0x978e7d) (BuildId: 9e5=
7c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #7 call_rcu_thread <null> (qemu-system-aarch64+0x122e268) (BuildId: 9e5=
7c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #8 qemu_thread_start <null> (qemu-system-aarch64+0x121cc8d) (BuildId: 9=
e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  Previous atomic read of size 8 at 0x55c8ce6d4250 by thread T7:=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
    #0 qemu_ram_block_from_host <null> (qemu-system-aarch64+0x98fabb) (Buil=
dId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #1 qemu_ram_addr_from_host_nofail <null> (qemu-system-aarch64+0x98ff16)=
 (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #2 get_page_addr_code_hostp <null> (qemu-system-aarch64+0x4bbd0b) (Buil=
dId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #3 tb_htable_lookup <null> (qemu-system-aarch64+0x49f7bc) (BuildId: 9e5=
7c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #4 cpu_exec_loop <null> (qemu-system-aarch64+0x4a08a5) (BuildId: 9e57c1=
9eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
    #5 cpu_exec_setjmp <null> (qemu-system-aarch64+0x4a112b) (BuildId: 9e57=
c19eb7cc79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    #6 cpu_exec <null> (qemu-system-aarch64+0x4a1b74) (BuildId: 9e57c19eb7c=
c79d8195b5fb05324859b4db6fbbc)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
    #7 tcg_cpu_exec <null> (qemu-system-aarch64+0x4cb92b) (BuildId: 9e57c19=
eb7cc79d8195b5fb05324859b4db6fbbc)
    #8 mttcg_cpu_thread_fn <null> (qemu-system-aarch64+0x4cbe81) (BuildId: =
9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #9 do_st2_mmu <null> (qemu-system-aarch64+0x4ba389) (BuildId: 9e57c19eb=
7cc79d8195b5fb05324859b4db6fbbc)
    #10 helper_stw_mmu <null> (qemu-system-aarch64+0x4bc571) (BuildId: 9e57=
c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #11 <null> <null> (0x7f936faabdb2)
    #12 cpu_exec_loop <null> (qemu-system-aarch64+0x4a04fc) (BuildId: 9e57c=
19eb7cc79d8195b5fb05324859b4db6fbbc)
    #13 cpu_exec_setjmp <null> (qemu-system-aarch64+0x4a112b) (BuildId: 9e5=
7c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #14 cpu_loop_exit_noexc <null> (qemu-system-aarch64+0x4a2242) (BuildId:=
 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #15 cpu_io_recompile <null> (qemu-system-aarch64+0x4b0a9b) (BuildId: 9e=
57c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #16 do_ld_mmio_beN <null> (qemu-system-aarch64+0x4b47c9) (BuildId: 9e57=
c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #17 do_ld2_mmu <null> (qemu-system-aarch64+0x4b93aa) (BuildId: 9e57c19e=
b7cc79d8195b5fb05324859b4db6fbbc)
    #18 helper_lduw_mmu <null> (qemu-system-aarch64+0x4bc0a7) (BuildId: 9e5=
7c19eb7cc79d8195b5fb05324859b4db6fbbc)
    #19 <null> <null> (0x7f936faab758)

<snip>

So I guess we are trying to free the memory while still running?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

