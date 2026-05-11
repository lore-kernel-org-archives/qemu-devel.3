Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A0CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTw4-0006X7-Uq; Mon, 11 May 2026 12:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMTw3-0006Wd-1f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:56:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMTw0-0004lN-Hz
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:56:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD3PhP774991
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 16:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LNG49oAYLl84GB3lJnrw3eJ5gpiePL2lqdzmtMR3LTE=; b=IxccfPf6sgsJMvOr
 QdlnRSQw4kGpxFAbVssybjBVy5uwNnBiZZEwsbaT8e05k2ZlQMNdNOG5Qq5INo89
 Lp0+RONCT6e1uSyl8QMXwdDBkKbUfsG5IaMkX31awwEToeICWrIKnIei6PRPjdQi
 drGDQjrun1mWtUmXVJCzX8FB8kl7wRTVvu/2t3tzg06TLQy6Vs/1i42f2FwS15+n
 t6lMLFUQtT2POd/q5DjqBmY8FfO4MFvMJXZR8g+5mCOt1zceOW5YDOX47o2cP0kO
 r56Ne4V0BlE94TqVwmM4h6p1lV10kkni1sLVK969/rUDevInkGg7Iztkp7yAVkSu
 xc7pvA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32jcqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 16:56:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1270dcd11c1so9471011c88.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778518601; x=1779123401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LNG49oAYLl84GB3lJnrw3eJ5gpiePL2lqdzmtMR3LTE=;
 b=QDTux94t68HDrKw3xwKxImu8fb9ItpRu43QhOQ46vkJbtxbzdGUQ9rm0aCJn0d8jl9
 z1yYbtwLUvy1M3cNqUVXYP8ZMXgZHr9ny7vuhWaE2GiMkl741nOkTlXiyZY6pBSI4IKt
 NCeRpW/In++FZa1oSk2SRv79nRelPZ2NkkewQ84bSJU3Fje29I21V8s6JBXGaX2OIFTB
 G5NB7y0Obtk/AXnv11HMZlR+zTRsdEh2oIRtoxrYAr+55lfxFzDOm7A9dVtIPu5qvoO+
 xcErkFbrL6kauVf2f0s7xiLaaNhkMGB4Nr405WAOKhDd6++fILkl4m9BqtTRCocnIcrT
 r3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778518601; x=1779123401;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNG49oAYLl84GB3lJnrw3eJ5gpiePL2lqdzmtMR3LTE=;
 b=l0sP+k+wHbe3U6bCfc4XoNE3viaUlwexZ50wZVioXRAzicRP2xRqGgRbPW9UOsSu0l
 cNLYQd14lpz2AlZ8EH4Vj9meKzvNVJ6qzsOCU6l0UlNAZwY4amx80Tv72YThs0T/j6up
 5jnSuIv3EIfkAeR092P2DGD507RwKaMrekMIRrzvtUjuQ6CUZxfl/9p5th69bZTaUXIB
 jPIf3D4Fx/DrJGkhSHwZzRpqO/48gSqN49E75y9AEGKnq2HoVC5iS22PTKNJuNE8+boy
 8H/whqhMcpQV58d+X7W5NwAuNYslfqOqHOAGX+0znLbPHXwzLT624Mm6wI1UeTq0SRZ8
 IqNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gs3023+Bapwu+zrQqe/0Ae3gKRsE9Y3Poifciki5Gi+8L2gps9gF0RhcOSmUqmGhC+3hXBKnW4AGK@nongnu.org
X-Gm-Message-State: AOJu0YyNhz33H5fH6aO7fnFAwgwUVCyPzm60eVwNZ8gOQxZqaPeODew5
 eWvUg0e8oFMoKsCwaKXd1OdIZFSI5eKtB85MGspDnf51q9uMCJ5J3lUFALZCPi9S7LCDTwD3uCw
 8KuCnZjWusClLoi2zzRBkyeIJg1TFHIybtCzEyJoi+Z7z8XkOUQPAYhgW9g==
X-Gm-Gg: Acq92OG2vru2CsdU8EPUUdvWPyfc1XZAmuZuyFoWAnK5DMJuqfv9yOoNo6pwkmus0Ox
 rCu07S392KKoHl7Bl3HPahClnz7IAyhcEE0oeaVvTpTFoxi4y2BVJYxlzrdF/SQS08hjnWdFstE
 EkD7B7/gcn/PTGbSe+hMTwu2HMAE4geNGrdYadCiPwvGOenHoFwOz9+ua289iH0bTXGk6I3J4vb
 xt2TjqFro8XlMMOxiWr0hoOaxW7GpjWFjytTxTpm8qONge+wKqAMofi+6EnkEFG96yt6PMwWWdE
 wo0bVyq4m5P4w7JxCKPbgFaxZOg7yC3ape+ZOhDoIbzP0aKHy/lc2AOLgBk4bgtncsGvyIX4zcz
 0RTmlu5asjfe6I+qm+K6WbZ6RxyOVH3zowhCnfnNcqTDHHsxyY/zf2ljFAmw6x/bXCUEoUWjsZc
 LqdRMeHxOwKLm1/g==
X-Received: by 2002:a05:7022:11c:b0:133:3c47:92de with SMTP id
 a92af1059eb24-1333c47934cmr168796c88.17.1778518600853; 
 Mon, 11 May 2026 09:56:40 -0700 (PDT)
X-Received: by 2002:a05:7022:11c:b0:133:3c47:92de with SMTP id
 a92af1059eb24-1333c47934cmr168747c88.17.1778518600025; 
 Mon, 11 May 2026 09:56:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm18232819c88.1.2026.05.11.09.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 09:56:39 -0700 (PDT)
Message-ID: <6d2dde96-7728-4106-9989-86ad5c103598@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:56:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
 <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
 <CAJ+F1C+XzzsGRwLjUCYiDaS9OGXMq5oc3QM5pm4obZAgLP7Z1w@mail.gmail.com>
 <agGVRFsSh1mbKc4U@redhat.com>
 <CAFEAcA8XfDGZ4kytHk63BmLfHMOGgtiAxv8M-MaY1Xh060=d_A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8XfDGZ4kytHk63BmLfHMOGgtiAxv8M-MaY1Xh060=d_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j7He1aWloxThnQHIa3jKCUvN6bGMmI7y
X-Proofpoint-GUID: j7He1aWloxThnQHIa3jKCUvN6bGMmI7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE4MCBTYWx0ZWRfX20DD0WzuuqwT
 D2edYFRW4QJrBRAY+rtrmshEfMHYm+KW3gG8AK8ry2vwWFvpQJBLTxuKmnCRlVSf5B0Wda1gLDR
 YAO0j3zeZn2dbpMMNwqgFjp5Qt4PnYV/fMGqjrk8e56ot0jdVunHPfdN9ZeFb+a3tbAtTSCcukG
 Z43Q+SwLQj1FxG0IvC6xIpHqUJgt0cRNZIHVkJmli25wd2tca3TLeOxNP6CrbJeOBcYZF13TAIb
 Musob/YN7L/vACLimH9sCflqFrZHh1S5X9eaC1xeNt49e25a039u9kiueic6ydkTtaUAfMTnYsW
 RAy5SqnK5QbkYOyv8uotTQNPiQHDDvhFEg1X3Ev+xWeMlygN7KleLx/luNL84bosX5EAq8y92X4
 Wn/TpdejVejPv0SrEYqvB5WWVAfZqRAioewfjq/EmQGRcn/jn3rpGkW57w+3dpHwje1Uwout+YT
 EJzEVpp6FNDe1SqqkkA==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a020a49 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=vKW7GOL4CJmWShU5NoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110180
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 5/11/2026 2:27 AM, Peter Maydell wrote:
> On Mon, 11 May 2026 at 09:37, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> IIUC, the main reason to want binaries in a specific location is
>> so that tests find them in that location.  That is a valid historical
>> approach, but meson offer an alternative approach that could be used
>> instead.
> 
> It's not the only reason, though. The other half is humans.
> People do run QEMU and the tools out of the build directory quite
> frequently, and so the location of the binaries in the build tree
> shouldn't have to depend on where we put the tool sources in the
> source tree or where we want to put the meson runes in the
> meson.build files. Just as we prefer to have qemu-system-foo
> in the top level of the build tree, I think it's also preferable
> to put the qemu-bar tools binaries there. It's more consistent,
> and they're easier to find.
> 
>> We can set the test environment so that meson modifies $PATH such that
>> all the built binaries appear at head of $PATH. Tests then don't need
>> to assume a location for them in the build directory, just let execvp
>> search $PATH as normal.  For execution outside of 'meson test', we have
>> "meson devenv" which sets up a local interactive shell environment, or
>> we can launch the test via the "run" script which wraps "meson devenv"
>> for a single command.
> 
> I definitely don't want to have to run a separate command to
> set up an environment: this is painful whenever I have to
> interact with python venvs, and it's not something I think
> we want or need here.
>

I agree, this kind of "source my_env" are really not convenient to work
with. Better to have things in the correct place instead.

> I think the least-worst option is that we say "all the
> meson runes for building executables must live in the
> top level meson.build even if the sources and most of
> the meson runes for the source/object files are in a
> subdirectory".
>

Which is the way meson devs expect you to write it. For people looking
for the definition of those executable, they can expect, without any
surprise, that definition will be in top level meson.build.
From there, it's easy to see which sources var it uses and where it's
declared.

> thanks
> -- PMM


