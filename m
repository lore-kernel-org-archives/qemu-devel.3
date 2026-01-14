Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAACD31A05
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 02:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfqKR-0007Qu-5g; Tue, 13 Jan 2026 21:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vfqKP-0007QV-GT
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:09:45 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vfqKN-0007Wh-93
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:09:45 -0500
Received: by mail-lf1-x142.google.com with SMTP id
 2adb3069b0e04-59b78886454so6820067e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768356580; x=1768961380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeqQcXHt363KF4Qx7aySXe2/l3tkvy3uwTXXtom6M1Q=;
 b=ASu4p+GosqtizXftPLzvOehJ1kr4mE6lf5qS382g57FV8qLW24FbQcfv8S7s7DN2iW
 V4BGvdJP+qHZuMYQ7/WXwvsNm30yOIhvqc7ZtzHH7uDXNlDI1yLQiUyr7otaY6fDi6WN
 fm76IOsWrmGdjAFoT05+lrOViBV6RLm3+m2HfZcB8E3LXkY08XsJXe8bRQI6INI9syQY
 c/nUthL/z4bSLyxkNEXtH1d/zIIbncFUK8RATmkSfSnXcmpQ9o75VTDn8xTXEfewmJXn
 mn27Z7c4AliNbezdPkk6rKqmEYF57MVDf2eA4XoWvAL9UQ9GCPv30Vd3wKIynaq10lc1
 NZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768356580; x=1768961380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yeqQcXHt363KF4Qx7aySXe2/l3tkvy3uwTXXtom6M1Q=;
 b=PjbRGZ3cqKUeXzBb/voIUKDOjmXTjiXDJ7yr2y/u/tVJ/33qYeUUrmx6qv6fR99pT9
 GiUbE7YjoFC8vv+/tQ3XH2Go6IO3rOZzUxQcu6j58a8IV5mLrgWhEowcdXB4jCYPw9oi
 WwhmaZN2T1w1QvaSKH8Tgu/B7SAWPDc2Byd3NjNrii2K3fTX4IoZNd6VWiew9IeoRtuR
 Ri0NqU4Zg0sQ9nuLqerysllGEopwlLFoNYIV8ovHtC+BnNGKCLIIPHHpyKURjGml2Dk0
 ijaaFydyHMMDqqdtRCp7VDYrxK+q2GyZWibinlHAO51oP20lIuhojW4RQFaplhvoIINY
 9GxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWOYS1t3bWjy9Aa6wilDL++JEcHxM8QMHx6qFk+DDGBO171DCGWrGyNKIAkbPx6MCZtD+9L6m5x+y@nongnu.org
X-Gm-Message-State: AOJu0YywMKbFwSdxPLLK7Au2O1hd/j/CZ75NkJ/62Ey5fkRQFqKlW2V+
 DnH7X4pwFDnmUB3oJS6sivQ7hpsSYLoUZ4v7DM4qieDVnuB6M7K7hwJM+lQja3wDhWhRCi3BVwy
 rjt4eNYf1AmVsjIphCfw1W33Lr/OYCDw=
X-Gm-Gg: AY/fxX4i4yhnjdWJRvAHPfkj/buhokb8AcPjJe2Vucg9idhZtFy0tJHKDASdR9zErj4
 9G6FaZ3IsB5uwV/Zm3HVEZ/St8UXvilEtpod5Gbae2kjkwT5i1lkwmVVHxN3FjLDA89vHsxSGFr
 3F9AHrAnLjdcG9muF2UkSnZLyiHI8AU75PARXNhNixOd5LsCBQ0amVRU8bhfcF2akXNbV2BRoba
 BdIoPobVa7WnnhB07wUYvSo0yMp9Xb9rnjixqVf3y2/yuWhcCT5SBA7xkAxTixncOQtMipb1Xpv
 9jPOisuGMWRz1jbCB/k3Sy5Zeqc=
X-Received: by 2002:a05:6512:b96:b0:59b:729e:6808 with SMTP id
 2adb3069b0e04-59ba0f81012mr283242e87.32.1768356579818; Tue, 13 Jan 2026
 18:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
 <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
 <641dbb9e-302b-434b-a0a9-0a1a5499fbee@ventanamicro.com>
In-Reply-To: <641dbb9e-302b-434b-a0a9-0a1a5499fbee@ventanamicro.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
Date: Wed, 14 Jan 2026 10:09:26 +0800
X-Gm-Features: AZwV_QgnF2rOCUSfG2uotlisH_23I2g0I83M7ZXSr2T0EMyWtuFN3dhbmuL0JfI
Message-ID: <CAGL8uCVEF+POcTws=F+5JPZrs-n0zBW61Ds70yB46JE68MPqUQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "vivahavey@gmail.com" <vivahavey@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 daniel.barboza@oss.qualcomm.com, andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-lf1-x142.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/14/2026 2:55 AM, Daniel Henrique Barboza wrote:
>
>
> On 12/19/2025 6:23 AM, Chao Liu wrote:
>>
>>
>> On 12/19/2025 5:10 PM, Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89)=
 wrote:
>>> Hi Chao,
>>>
>>>> -----Original Message-----
>>>> From: Chao Liu <chao.liu@zevorn.cn>
>>>> Sent: Friday, December 19, 2025 4:09 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: alistair.francis@wdc.com; Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=
=E5=98=89)
>>>> <alvinga@andestech.com>; bin.meng@windriver.com;
>>>> dbarboza@ventanamicro.com; liwei1518@gmail.com;
>>>> qemu-riscv@nongnu.org; vivahavey@gmail.com;
>>>> zhiwei_liu@linux.alibaba.com
>>>> Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debu=
g
>>>> specification
>>>>
>>>> [EXTERNAL MAIL]
>>>>
>>>> On Mon, 1 Dec 2025 09:42:53 +0800, Alvin Chang via wrote:
>>>>> This series try to support versioning of debug specification. The
>>>>> early debug implementation supports debug specification v0.13, and
>>>>> later new trigger types were added which are defined in debug
>>>>> specification v1.0 version. To support both v0.13 and v1.0, we add
>>>>> 'debug-1.0' as CPU property to let user choose debug specification
>>>>> v1.0 by specifying "debug-1.0=3Dtrue". The default version is still v=
0.13 if
>>>> 'debug-1.0' is not provided and set.
>>>>>
>>>>> For example, to enable debug specification v1.0 on max CPU:
>>>>> * -cpu max,debug-1.0=3Dtrue
>>>>>
>>>>> Changes since v2:
>>>>> * Improve commit message and fix typo
>>>>> * Apply "Reviewed-by" tags
>>>>>
>>>>> Changes since v1:
>>>>> * Apply suggestions from Daniel. Using boolean property instead of st=
ring.
>>>>
>>>> This is great work! Thanks to Alvin Chang for refining the sdext. It s=
eems we
>>>> are one step closer to merging rvsp-ref into the mainline.
>>>
>>> Thank you, Chao.
>>> Please note that this series doesn't implement Sdext infrastructure.
>>> We have some patches for Sdtrig based on Debug spec v1.0 and we want to
>>> upstream those patches.
>>> We ever submitted the patches, but unfortunately the patches were block=
ed.
>>> The maintainer told me that QEMU should support both v0.13 and v1.0 for
>>> backward compatibility, rather than eliminating v0.13.
>>> That why I submitted this series, trying to resolve the version issue.
>>>
>>>
>>> Sincerely,
>>> Alvin Chang
>>>
>>>
>> Oh, thank you for your clarification. I also noticed this when reviewing=
 the
>> main patch series =E2=80=94 it was my misunderstanding. Still, thank you=
 for your
>> contribution!
>>
>> I have done some development work on Sdext before, but I noticed that
>> implementations of the DM module vary among different vendors. In additi=
on, how
>> to achieve compatibility with gdbstub is also a challenge. I will send o=
ut the
>> RFC patches at an appropriate time in the future.
>
> Hi Chao,
>
> If I understood correctly you might have some code that implements sdext =
 in
> QEMU. Is that the case?
>
> If affirmative, feel free to send it at you earliest convenience, even if=
 it's
> rough on the edges (you can tag it as RFC). We would like to get
> the Server Platform Reference Board merged, preferably for this release, =
and we
> need sdext to be compliant with that spec.
>
>
Okay, I will send the RFC patch to the upstream for discussion in the next
couple of days. :)


Thanks,
Chao

> Cheers,
>
> Daniel
>
>
>
>>
>> Thanks,
>> Chao
>

