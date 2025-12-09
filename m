Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B98D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0QV-0002KK-5A; Tue, 09 Dec 2025 11:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0QC-0002JX-5W
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:18:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0QA-000887-EW
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:18:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477770019e4so62250945e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765297117; x=1765901917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6H0gDhXCAZT7mqiN1PaLRxYNOzxfaHzV84BDnYDJz6Y=;
 b=aw6NPr8dTuEBb0zSQYUSmYaCs2TzNaxkF3tnLAmlxC52mb3tQjCchkd1CYL28AX5dV
 c8F07epfE0F5HW8W3TuiBSTuFWLKUlwFq2pmnsfyA3tLsys3T6AGc6EyMYO5ti8zEA86
 OhsR8S3ujmIxzkNYBEP3qBbIc0uzYJKlGp47bIdYpzRc8x/LISQm0oqJelmPh9gKvEOK
 jqcf47LV522Ux6btTU2ZTRsukSpJmT29tUYC/pZjGf0Hsy3oAXzX6BbTdMpI3kAm073g
 qPLV9luJitl8buAwfvrMBRPvBU5N1Qr0d57BEH710HSEwd+EERxozVtX/ktfVjMS93MQ
 YvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297117; x=1765901917;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6H0gDhXCAZT7mqiN1PaLRxYNOzxfaHzV84BDnYDJz6Y=;
 b=YdA/JVh8agEx/JH5yWmmARoSfGrDT8/tR+SVInPOIyOk2MxhrRu7Vo/OXKeG/ZGkOX
 fsq4JHfw0OSjZQkvvqcHsWSIffREMDmpR18f0FnqnKF5zAHBu/DsmS844h1hMfeW0v2w
 0ThkaJ8Jjz0EbvJVF7/7LEHBUPF14sgI3TG3Uk4MmZrlwMDQFYTaUe+M13VpzQS/Wbhp
 iT90geR383Bk12dgPV/s7WnlfFX8q3BYPIa1qPghHfNx/7Yn8yZAphoPkAuTxEFwFj/q
 wbigNWmp0OZzHl3NmZMWYuLxVxKhi/6CzkLgrLm6bZDYjDAstpqRIyIshpwoYmcY83z2
 uDUw==
X-Gm-Message-State: AOJu0YxDz6/rzLw2cY/Fs3PAtDU+uaXZOPR0+8gGHxQLmN+XztxWFoIp
 gRW78O7OdsqO+0H6LKxxGd6Kgjg8CUO9SqLtZBSrxoHMX58wumyttQf4httJ32i9VTY=
X-Gm-Gg: AY/fxX53LS3XiWNZlT2zHDt9BxB0j+D825K9SchDV/qplt9LS0Qj2VdwhK25CQTJ5cS
 67y+ADRlPTAAr5/K1yS5lgZJYion9/9bYTBo+dp10VEggizmHErHQpB+bPvq5z47bqrWt26kSmA
 A0rzsubf2qowGPHjfC20x+yNcbCIcfm2XVRT8dSIAebUyAEl+68g4jTSU3PDM4seX3H6fzAzMUf
 HbQ9nK30jEs7jdkMjVxhZbJLcW7tBe+G4IIiA+StjsVwfqWXj9j3FdsGsZm44tcaz9cx6pq3uL5
 XiuCvQauKh650Jq6/pk5MsZdARfBvYULQCNKroD5aHf+VukZm3L73sB6sRfP3eg2WrDFFBeqxDP
 vVoJYRscfhVOPnBFbiZEpQldOtxOEEnGCNRqHTUJMUPtA5c7qviphNuth/wnrwsmz9d5m3ej8pA
 miiCgI2cL8GWA=
X-Google-Smtp-Source: AGHT+IFrV1WOTUSYpYaiqjN8G/lrmiyMmcm0uzW9KedfMLbdpGpUvD/LA9aaixRMwPbTZTamL5SECw==
X-Received: by 2002:a05:6000:40da:b0:42b:3907:a38b with SMTP id
 ffacd0b85a97d-42f89f53ad8mr13222875f8f.44.1765297116760; 
 Tue, 09 Dec 2025 08:18:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8f85sm33364817f8f.5.2025.12.09.08.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:18:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31F6F5F818;
 Tue, 09 Dec 2025 16:18:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org,  erdnaxe@crans.org,  ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and
 add limit argument
In-Reply-To: <6955a4f0a032b68a2b9fb1d1b6a7b620@igalia.com> (Alex Bradbury's
 message of "Tue, 09 Dec 2025 07:10:12 +0000")
References: <cover.1764716538.git.asb@igalia.com>
 <6955a4f0a032b68a2b9fb1d1b6a7b620@igalia.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 09 Dec 2025 16:18:34 +0000
Message-ID: <874ipzwrvp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Alex Bradbury <asb@igalia.com> writes:

> On 2025-12-02 23:05, Alex Bradbury wrote:
>> This is a resend of my previous patchset which unfortunately seems not t=
o have
>> been applied (see
>> <https://lore.kernel.org/qemu-devel/cover.1753857212.git.asb@igalia.com/=
).
>> I've rebased on current HEAD, checked it works as expected, and added
>> Reviewed-by tags to the patches, which all received review.
>>=20
>> Repeating the summary from last time:
>>=20
>> This series contains one minor feature addition and a series of small
>> bugfixes/improvements. The addition that motivates the submission is to =
add a
>> limit argument for the hotblocks plugin, allowing you to control how many
>> blocks are printed rather than being hardcoded to the 20 most executed.
>> Setting limit=3D0 and dumping information about all executed blocks is
>> incredibly helpful for an analysis script I have downstream.
>>=20
>> This is my first contribution to QEMU. I've attempted to follow all of t=
he
>> guidance in the "Submitting a Patch" guide, but apologies if I missed
>> anything.
>>=20
>> Alex Bradbury (5):
>>   contrib/plugins/hotblocks: Correctly free sorted counts list
>>   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>>     blocks
>>   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>>     PRId64
>>   docs/about/emulation: Add documentation for hotblocks plugin arguments
>>   contrib/plugins/hotblocks: Allow limit to be set as a command line
>>     argument
>>=20
>>  contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>>  docs/about/emulation.rst    | 12 ++++++++++++
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> Sending a ping as per the guidance at
> <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-p=
atch-seems-to-have-been-ignored>,
> and also linking to the patch on lore.kernel.org as that page suggests
> <https://lore.kernel.org/qemu-devel/cover.1764716538.git.asb@igalia.com/>

Sorry I missed this in v1. As we are getting very close to 10.2 getting
out of the door I'll punt this until the tree re-opens. I have it on my
backlog now.

If you want I can also cc qemu-stable if you think its worth having the
cleanups in 10.2.1

>
> Thanks.
>
> Alex

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

