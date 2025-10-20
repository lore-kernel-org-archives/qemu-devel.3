Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C031CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApHt-0007DZ-En; Mon, 20 Oct 2025 08:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vApHX-0006x0-5d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:46:48 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vApHM-00025l-AY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:46:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b463f986f80so847277866b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964379; x=1761569179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e29QLgBd6FcHgVf9Iyy3OwGPEGUkB9UOBMRXzO98Nzo=;
 b=WHhz508m0z6nqYXnoL2eM7n7QopTGlh+PU1UKijGQNz3R8vk7KvymqsGeeesNASq+O
 khnj606MH0D45mzqtR1EhidUPREaDeBujWWfTXmi6T+hsMS39YsRq5slHwnwsk+RqdIv
 aGnXPsaDS54o+hsw9SEo9h7gpeytphPyu5fWG/D8ShQC4mNkVJLkknZBPqswh0sN4pwd
 rmvEPlCQkF9QZnEJz+Q48FR50PWLm3t9hoQ7JBtD4iZkK9TWgtUmCG0hoYiD/BvyqRQO
 2+5qgMtqu7Qy8nn9xh7zVQ57DCLYbpdI02+y1jiBu/ZTij+qO5PpbAxI3ikTi2qWRsOk
 XgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964379; x=1761569179;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e29QLgBd6FcHgVf9Iyy3OwGPEGUkB9UOBMRXzO98Nzo=;
 b=X+ZwdyIYf51Nz/VQtakQW48sRga8rVr1bEOuRi6OH2XTN780hrNY6pA/nqR0fmGCjX
 1RyzHvj9Xsj79glm6xzFLt3glg5zaurGPjoFukRdqJhqtDJ4Fyhs/2rnlX5qGG8x5BGn
 4h5fS5TEhcma7V7+jt3xBZx3g9ia5Fo+uB6aIWuNgUHoATmJa01K8z8iLk1wSRiuZ999
 wU+LzPU1cC3OtpEaYMg37UQR0CTbtAg80Ha2nPK2knrxgMzrPRM315bAO7cSDG1+eT6t
 9IqCCrwqhscbPt9yTZSXMFltNaX06jAc8MNCn1TON7ji6niRxHh2Q9gnBt/d5TYu64YJ
 HhTQ==
X-Gm-Message-State: AOJu0Yx9xnxJJn8K/EJXDnFvrmlI7AhcWsveu30yeBxfIj1KQvGxHrs0
 N6H3dLSwfuhRLXhdAegPKWfOw859thQuw+jjHU54R6Wk8m4KKiIt31RyLiPFuyGW12A=
X-Gm-Gg: ASbGncv8YwPTun/6aBvbM7pveOLEjepAuYcKsMEx9B0noMISjsCIT/Oc+rbORtl5OxC
 tUhuPfYdOaOgfu6xbHTLUIXqPw9Jj7bynjaxNcw5dYWHrwcDt8RaY10tQQ4M1yov+dbh+IoTrd1
 Dqe3KdUzcRSbZPWoaWf9QgVS9nB76429iklJGHaafwmOpaJzOGmG6iKwtY/TnFylinxudCHwkNT
 6ugBynHzZwyRWghg6fEKwi+svyjghRZQtHBKvigGJz23EwwK5xuoQaw6W/xZtLWimzepk9fXjxA
 QIYcjfy9wTlCyIRz3EtTUt/w7l1mErWhA/UmhWsx6VM9lPgHoc6Q7Y5CLdsZPrlno7uH3c2BATt
 EoIUsy7Pton+Paz7GrkzDfzpqUS1mueLkdqPdnHCiyg1d14ho5vtSvvl6xpC34rosJsMcxBsPkv
 dA
X-Google-Smtp-Source: AGHT+IFL1t1R2wn69Tdu2sOdWiHiYudWSQ0i/oxyCI+n0P2q7633icI63PyyTSWG4gCJOFNujmQhPA==
X-Received: by 2002:a17:907:d06:b0:b3b:d167:944a with SMTP id
 a640c23a62f3a-b647551012fmr1534978866b.57.1760964378772; 
 Mon, 20 Oct 2025 05:46:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebc474c6sm767523666b.78.2025.10.20.05.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 05:46:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC5DF5F83E;
 Mon, 20 Oct 2025 13:46:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Andrew Keesler <ankeesler@google.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 04/11] Support per-head resolutions with virtio-gpu
In-Reply-To: <87ms5lu6rx.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 20 Oct 2025 13:55:30 +0200")
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
 <20251020104149.4034124-5-alex.bennee@linaro.org>
 <87ms5lu6rx.fsf@pond.sub.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 20 Oct 2025 13:46:16 +0100
Message-ID: <877bwp91wn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> I missed this one somehow.  My apologies!
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> From: Andrew Keesler <ankeesler@google.com>
>>
>> In 454f4b0f, we started down the path of supporting separate
>> configurations per display head (e.g., you have 2 heads - one with
>> EDID name "AAA" and the other with EDID name "BBB").
>>
>> In this change, we add resolution to this configuration surface (e.g.,
>> you have 2 heads - one with resolution 111x222 and the other with
>> resolution 333x444).
>>
>>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>>   -device '{"driver":"virtio-vga",
>>             "max_outputs":2,
>>             "id":"vga",
>>             "outputs":[
>>               {
>>                  "name":"AAA",
>>                  "xres":111,
>>                  "yres":222
>>               },
>>               {
>>                  "name":"BBB",
>>                  "xres":333,
>>                  "yres":444
>>               }
>>             ]}'
>>
>> Here is the behavior matrix of the current resolution configuration
>> surface (xres/yres) with the new resolution configuration surface
>> (outputs[i].xres/yres).
>>
>> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: current behavior - outputs[0] enabled with default xres/yres
>>
>> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: current behavior - outputs[0] enabled with xres/yres
>>
>> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>>
>> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>>
>> Signed-off-by: Andrew Keesler <ankeesler@google.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-ID: <20250902141312.750525-2-ankeesler@google.com>
>> [AJB: dropped pointless output_idx range check, tweak commit]
>> Message-ID: <20251016150357.876415-5-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 05295ab6655..0ce789bb22f 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -971,15 +971,21 @@
>>  ##
>>  # @VirtIOGPUOutput:
>>  #
>> -# Describes configuration of a VirtIO GPU output.
>> +# Describes configuration of a VirtIO GPU output. If both xres and
>> +# yres are set, they take precedence over root virtio-gpu
>
> Please use @NAME to refer to a local member or argument NAME for proper
> rendering.
>
> Elsewhere, we use @width and @height.  Consistency is desirable.
>
> What happens when only one of @xres and @yres are provided?

*sigh* OK I'll drop this from the PR.

>
>> +# resolution configuration and enable the corresponding output.
>>  #
>>  # @name: the name of the output
>>  #
>> +# @xres: horizontal resolution of the output in pixels (since 10.2)
>> +#
>> +# @yres: vertical resolution of the output in pixels (since 10.2)
>> +#
>>  # Since: 10.1
>>  ##
>>=20=20
>>  { 'struct': 'VirtIOGPUOutput',
>> -  'data': { 'name': 'str' } }
>> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>>=20=20
>>  ##
>>  # @DummyVirtioForceArrays:
>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

