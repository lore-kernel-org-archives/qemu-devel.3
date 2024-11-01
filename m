Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AF9E6F070
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vHJ-0004su-Lb; Fri, 01 Nov 2024 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6vH2-0004mw-BR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:17:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6vH0-0007A4-G6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:17:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso5050a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730481440; x=1731086240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiO99cGTLi1DHTOs9FnwrtnaF6+TtIydPGlc4e6AETA=;
 b=x10/vlXDdA/cEmd2176zQfLNG6jf/l1XZ58we/yfL6MRJ8yh+F4dOMdjedkW+Z//1r
 RBf9Y1fyOa3IInayI3JGE3eYY7KhOecLUHAxduf41Cdo7VqOIJAEA4BKgEVuXSdeohN+
 RRDvAsKKBfvGLOp1V7uNEq2b0Vx19bhwWdJNQbhOCVwjwLfAc7oTju/MWoiDg+e4KoTH
 7u08cEzQZjcF0G5cM9ttLOPMWT3gpm5/6Oa/po0coRDZzYb/Q2XHO76uJ8MNPvqXrNfA
 ekVyCpjpYM09DumqnzWL3aUb93Ii+Z42yBrdUN1AaVDVg6hFiIlUJaDCQELi6ttROS+R
 V3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730481440; x=1731086240;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiO99cGTLi1DHTOs9FnwrtnaF6+TtIydPGlc4e6AETA=;
 b=rRxuWimkgY8bm7mJ3Gvwo73rwOD4BO3wCfmi1bvCWbeN9r3SkuRBRre2rl+nlgIM1Z
 NPN0O+K+P3EMLf99oYeO1BEotXMi7LAnatBNs4YshAEbeECYs0ds10vAeVwcYfJBE615
 tQbi5ac/ZUOpLoOq2Jr9r9kpfXRHOsZx70qrF0dd4oLcpPuXTahoUEvv+N5bbhwvmsgm
 ZPpvzpe9WAU+NODEhvbHpwR9f5jYGgH7En93RmHREZGy3Q+3KbDw9a0jLg0KpY/G6By6
 1/QJWQunHFAOw7RuE6w+POGuqqru1+6pARvlILYhgHL59m2CnpUKBK6iVZX8PF9SiC4Q
 fGdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVl+RbIk8qOtL4tIrLOmd/kYb04czQym1Pytjz7MrRhSzBGl3z3LtD+iJtwyReOQpTqk6pY/nrpfMb@nongnu.org
X-Gm-Message-State: AOJu0Yz3QDcQMyqNM/9YOo/K6KGUFT5OStIBBQ1HAcV0sMw49bNu2NCr
 o5/30QBEt+GJvawdBGS+sn4XPvZzYbwH4JUG/B5xHKIN18RwIPxWMUpUQm3kqVE=
X-Google-Smtp-Source: AGHT+IFB2vcfpDrmpfiwDa+6BZkeKDS3TZ9ititrKmmQ09WM+DG1QVZs/DbnuM+8tCyMZLEXHjQNOQ==
X-Received: by 2002:a17:906:6a12:b0:a9a:3718:6d6 with SMTP id
 a640c23a62f3a-a9e3a7f2373mr1311914066b.58.1730481439924; 
 Fri, 01 Nov 2024 10:17:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564c4fbbsm206567266b.58.2024.11.01.10.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 10:17:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C2A035F8D3;
 Fri,  1 Nov 2024 17:17:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Robert Beckett <bob.beckett@collabora.com>,  Antonio Caggiano
 <antonio.caggiano@collabora.com>,  Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>,  Huang Rui <ray.huang@amd.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
In-Reply-To: <73bc5cb8-0540-47cd-8a1e-aed8bf772d3a@collabora.com> (Dmitry
 Osipenko's message of "Fri, 1 Nov 2024 19:04:14 +0300")
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
 <73bc5cb8-0540-47cd-8a1e-aed8bf772d3a@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 01 Nov 2024 17:17:18 +0000
Message-ID: <87froaho0x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 11/1/24 18:35, Peter Maydell wrote:
>> On Tue, 29 Oct 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> From: Robert Beckett <bob.beckett@collabora.com>
>>>
>>> Support BLOB resources creation, mapping, unmapping and set-scanout by
>>> calling the new stable virglrenderer 0.10 interface. Only enabled when
>>> available and via the blob config. E.g. -device virtio-vga-gl,blob=3Dtr=
ue
>>>
>>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_s=
canout_blob
>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Message-Id: <20241024210311.118220-12-dmitry.osipenko@collabora.com>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> Hi; Coverity points out some possible issues with this commit:
>>=20
>>=20
>>> +    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
>>> +    fb.width =3D ss.width;
>>> +    fb.height =3D ss.height;
>>> +    fb.stride =3D ss.strides[0];
>>> +    fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.s=
tride;
>>> +
>>> +    fbend =3D fb.offset;
>>> +    fbend +=3D fb.stride * (ss.r.height - 1);
>>> +    fbend +=3D fb.bytes_pp * ss.r.width;
>>=20
>> Here 'fbend' is a uint64_t, but fb.stride, fb.bytes_pp,
>> ss.r.height and ss.r.width are all uint32_t. So these
>> multiplications will be done as 32x32->32 before being
>> added to fbend, potentially overflowing. This probably
>> isn't what was intended.
>>=20
>> (This is Coverity CID 1564769, 1564770.)
>>=20
>> The calculation of fb.offset also might overflow, but
>> Coverity doesn't spot that because fb.offset is uint32_t
>> and so the whole calculation is 32-bit all the way through
>> without a late-32-to-64 extension.
>
> Will make patch to silence this Coverity warning. AFAICT, there are
> other ways to cause integer overflows in that code, though I assume it
> all should be harmless. Thanks!

Ahh I'm happy for you to do it as you are more familiar with the code.
Note the duplicated code.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

