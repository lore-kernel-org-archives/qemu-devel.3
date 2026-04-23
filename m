Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE3FC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvcy-0001Kl-FS; Thu, 23 Apr 2026 11:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFvcx-0001KT-2x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:06:03 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFvcs-0007ko-7s
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776956750; x=1777561550; i=deller@gmx.de;
 bh=/oGNscVbXZ3Vnv/ffBgfeNeosLfchIzFzOv5mhdGmBk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uU4zIxi/9cA6tJlm7wZz9cEdBvJwOH9UPdYMLwL+qqST4c/JEq2oGVRrq4wGRSbQ
 LRHzOIL0iaRrmcQ/CgZxK2kRXQsdjNKmcZX+tl7NFZ60XK9FuzOGRVUoPSv49ncKE
 Ybl3Q1A1Huwrnn0WOsA7J0+XUOIVvuvz1q/bMjY69zMq/K6bVZATiazcuAEH/9xua
 NrR4waKpnTMf9T0dqGmps3qbhc81k8T4ZEuKDx2kKhnIi7xFyJWujIlSvgUHBEQ3A
 HVpjeSt6RkAhPoGsQeRADc6w9qVAhWU9spzqfvvMPAlaiap0Fk2bnFGdTZuzMq6tx
 9rdl3pPP5bT2ABuj8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1vkyez1pqt-00kHtf; Thu, 23
 Apr 2026 17:05:50 +0200
Message-ID: <8a972330-4318-4bc2-9c0a-41f45afeb507@gmx.de>
Date: Thu, 23 Apr 2026 17:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yixin Wei <yixinwei@meta.com>
Cc: Yixin Wei <easonwei1998@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260409164938.6735-1-yixinwei@meta.com>
 <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
 <CABe+LnuRJNwa=qyUOOVmNh33v0VEPBT+ob9MmycvU+DVaRSw=Q@mail.gmail.com>
 <b3c4e048-6224-4492-ab6d-4dbd6a150e7b@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b3c4e048-6224-4492-ab6d-4dbd6a150e7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWgHn7UFRJcLEOCNpxx538jNKaKN592/IBVZQO9oF0b66zNgsOB
 dhgx9YTrUYSd0RLScFPxw+eXp1ZMDIyGjd4k3svdkawa1HR2F+pdpJi5qt/YUMnTo3N+hci
 bIvHgP284wRhGKyf0MY1e6UPpp8IFaRyQsgqAOCijmqXpjOsgm6/dpeoOcNC0DRd6Dg00mI
 Opis/o/1OMyYqVSsz5Hwg==
UI-OutboundReport: notjunk:1;M01:P0:oAcoz3OgOWU=;ETEccDaBtB9RiwOhoE7wW29usHE
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/23/26 00:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Yixin,
>=20
> On 21/4/26 17:15, Yixin Wei wrote:
>> Hi=C2=A0Philippe,
>>
>> Thanks for the review! Just curious about QEMU's typical merge
>> workflow, trying to get a sense of how long this usually takes to
>> land once it's validated.

I've applied your patch to my linux-user-next git tree at
https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dheads
and will push soon.

Thanks,
Helge

