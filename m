Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E217E8FDBE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 14:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaEHo-0007Ww-Dz; Mon, 29 Dec 2025 09:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vaEHY-0007T8-FE
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 09:31:40 -0500
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vaEHV-0004oI-MH
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 09:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1767018677; x=1767623477; i=laurent@vivier.eu;
 bh=NiBDCR7peu09zjb71rD/BcRqvjxunCML05uASAhoSgc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=xDaGLZj5iEr2y4Hh2Kv32I3o7rL6ODollvQJW01VWvStvDdCR7uPFPeUJH+j875c
 kv7shZSComUPjlSI1k0whX8secjnEVgFle7es4hkpcP586LWUOgg3P4yhVj/KdtWj
 XXdeoUhdK4br8WQabmunFzCxZkOZSsBjUrer7NqDBy9Zj5lqOKOzSuqozrL3KDsPF
 3zXR+q9Dut8SpMcEFKDgwkiHnPIf+0717wWYoevz7ScvvIgVp/4QB1fBr5qxE6lrK
 aSal2cFy1oozgeIZ4HdiwAbgrhA0aTHPH6vcUMsRcNrKRW135MSFiBMRnBEVk9QXs
 B1nqlYMmxhVOhydFBg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MrQ2R-1wEXQY307T-00kxw1; Mon, 29 Dec 2025 15:31:17 +0100
Message-ID: <46bee198-d686-48a8-8353-201b7729fb29@vivier.eu>
Date: Mon, 29 Dec 2025 15:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: fix CAS2 writeback when Dc1==Dc2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251226213707.331741-1-laurent@vivier.eu>
 <1c2fc596-7196-4901-b9aa-91a1a6efd71d@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <1c2fc596-7196-4901-b9aa-91a1a6efd71d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aqL2vnZJq2DRLMdxtsLrHEkh/YtZsUexaPFF6jiQ4wLksZE5YKx
 cBQMfxt25CrzqKcYdLyzKBpGqmj2J3D1SzDiEBizx3fxvha6hvtQXlyriVOeBDQ2sx0yUvl
 vfVTrCMob79ZzHEIfgSTB8mcyhMfBd13I82BDaAiOoD1ZQifteaK8RniPcEYpNDKiIGJsmk
 M9D2HDnH8OC2jZdGlxY9Q==
UI-OutboundReport: notjunk:1;M01:P0:HlTXoveFdc0=;7ZzOFb9KJjCMXt0R9Y5w6LTWNpO
 lG/X+1zulqIx0UjVA0oqTnRo0C6xo5F8wdTkT91ZhVTgfRvaPYwKQ46Y5sFLk8aGqs8otOGOr
 qyn55IRviUlZNhrv5MuS2K1jTawBtBW7lq3o56Z+FbZ4xv7vdrMv6MYdNG+Z6UmSElunJWSwU
 N3FdqMUTqHol2qDtoCrCEtSo+7WAqjXpt9gWD78bsTKzBVjooCS+9MKc7h4HSGtbiUK9Kd10F
 4HBSaV9K1VfufUjUwesP0Ew3vPkxCJ7K6RaK4HBAo0jZQpMDcmkOhPFSDPuakR/sXJgBQ4Fqh
 eNMF4PKRzPbdOfe1wXHgrgmOQPIRxZVRjFLc1CHiD4HbAtGfsco4OMjEV6BYHc9McE6ama1EW
 fMqe1L/9u1xuR2fkImlLEBLPZdcCmHsKeEaWvEz4v2FbEjoDBic3B8E6i5K6DrWlttpOnhKRq
 TTtCysz45N/heXDr1T/Q2bbgYat8SUcByrnVaSM9zEJ9PlrWkW1/4R6eZq9vMaxWRO6ygD05f
 JLDJpoAWFmDhIp04cEhiu22kAuJaujfWZtjRxoX+m795fEkOP2cmR9ekLwtkk2X2KEK+44DJf
 Ra3dV+8ZkG0AUNDeqOeeagM5BuJRr5fHiGd+xSA26l+k58TDv8jxJqqh+dbVC1IiARAs1/w4S
 +wxHrGx7Lts8DfnM21KF81IBc3fI3nfJZXV4Ta+thCklvCSFXSSPljqmGzBC55kbp5GeLhDpO
 +fFayyVxDw4ufe2fmhXc28J8N9TxfZeEcTJVebTxdWfsJh2MKBRJPTY7xxWmXIkbIhnSgWnSp
 tAtUiNITSM2ROF15stwafJNbx/TflkQ8c7NinBTlvs4oJTBOW/f1ywY9GDPC+LR/EDR0h9jdS
 vk49IlUf7MnRQYRfel1eRR9w/6RqzZMwmAfHRGgz7jOs70R7OCYLg5bc8gR7lvRKZtcxEki59
 peeDw890c50tHpYEOCW+auPovqVCfYOJ4RxdkWIjn1TahhxNIGpE4PVhnkRHvCn401vfyluDo
 reISCIOSC/0hisGgFHXiS/fx1mqfSEbvPqYXdXoS/nqnYHV+Zc1tCjLFrasAxP0CMlxGIHoSB
 Q8f6uvEOEqU3tQTDeYiZtjyPfbEVV2ldgYnWVWBKrnt++bChY6eehYYbq8Ew06KVUFTaauAft
 YtW1qi0TOlgM8a+6PTGob5ESkbpH4S+lhSQg+Fh2emI9qt47/y//0DD0ulE5TL54FUmZMIjXQ
 gW+36XGqUstO6r8oNGuuu1FQyR+Yafr8nPiil8xCjaQgHU5fXOelnXTQlPQ193geV24hDWS1F
 CHYrxGi6zj5vLZLASk0wYjuJle4ZKXt8E1QLKDcFOKbarm1xaE0AAl6OyflrduyCE1RrKCfyA
 viwL9Db0UfLBKqjfAcdHEWcv17xJUpDqpl/qbD9WWYSCETXPNRC2angb9xeBdqcYtNXpKlBZC
 zqLehEKt7/V+7IoXzC29g+BkjRQAw1wnHn/SPjCFMN/wKuUiCl1a7WRlHbyqwq8iPdStAtfdf
 VFPkYa9GlDIoKG46LMxph9V3S123Iz2plUj1+ZdNOSITFl+Rn891TReQMUm58IgrEJFgdQr8O
 kh373GYn3DGhuMZI7cXt69/IsxY6E0TXdWRHDhiIKjdgt1UBfaAigrj9NhCedTEDYEzPwcEEZ
 K/d7trqRfkfyNL8aMsXy8fhPaxFa6e7UuzSgiW95uyaE0TskUOzrHeFJrxNkagtQ0Wo1HRjmX
 bHuxKty7EFpi+l+64tFH8hUHmBLkUOgVmplHI1aP3kh0oNerDq88uYIM=
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 29/12/2025 =C3=A0 00:13, Richard Henderson a =C3=A9crit=C2=A0:
> On 12/27/25 08:37, Laurent Vivier wrote:
>> According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
>> same data register and the comparison fails, memory operand 1 is stored
>> in the data register.
>=20
> Where does it say that?
>=20
> All I see is the pseudocode
>=20
> CAS2
> Destination 1 =E2=80=93 Compare 1 =E2=86=92 cc;
> If Z, Destination 2 =E2=80=93 Compare 2 =E2=86=92 cc
> If Z, Update 1 =E2=86=92 Destination 1; Update 2 =E2=86=92 Destination 2
> Else Destination 1 =E2=86=92 Compare 1; Destination 2 =E2=86=92 Compare =
2
>=20
> which *suggests* that Dc2 is the final store.
>=20

This suggests but later it's explicit:

MP68000PA/AD REV.1
MOTOROLA M68000 FAMILY Programmer=E2=80=99s Reference Manual
(Includes CPU32 Instructions)
https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf

CAS/CAS2 Compare and Swap with Operand

P 4-68

Instuction Fields:

Dc1, Dc2 fields =E2=80=94 Specify the data registers that contain the test=
 values to be compared
to the first and second memory operands, respectively. If Dc1 and Dc2 spec=
ify the
same data register and the comparison fails, memory operand 1 is stored in=
 the
data register.

Thanks,
Laurent

