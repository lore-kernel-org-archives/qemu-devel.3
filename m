Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5240BD74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIjq-0005wJ-9B; Fri, 23 Jan 2026 10:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjIjm-0005uZ-6m
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:06:15 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjIjk-0001eh-Cu
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:06:13 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-78fdb90b670so21436267b3.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769180769; cv=none;
 d=google.com; s=arc-20240605;
 b=G66AlASfd5kKHgT1k+RJSBb8sbXj83OE0RO/regySajCIjl6u1V5ngrUrVWrVxfk4/
 aC3RTSPHq2eVSzxwuNTOcaE9c+bceMzVkUf3wduICEaK2ceJ2cN2Ehtuvd+PlaeHEWx8
 eE2OFHmuidoqKAxUIZadnLVRU3vF+W3ch+KgNux4jRrzoXs6E72KsuUWGbgav6lwN2R1
 quzihycv+0mtGay+d0x+gaXwxMqTR5xodsKWJtfmqbZwURskf0890S+3KK8vqbro1k2X
 OTWx0H18Y9FOXjHsh/0EPiPbskM7XevZQ2nC90kFHQGhkx9AM4OrSXjxRlXULKI2Lb+M
 BQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bb55XTSNzdky9WU0oKM2F3ZA/eluT7mQAYoxH8GswsE=;
 fh=cqz76aa3Z61Hm9psUsVl1o90fxZ1nR6HqCuX7elJstE=;
 b=IfjISx1CKyxXeJf6X+fn6crf4DhkTvfzvqVA/iXUsVbZwRXhoB1rdD00qva6uE68Xu
 eyyRzMfdh/1fljse2J7Riy+ChxxhD1lEXPt1aJy9JAn+2vDG3cMHVGHtVQUiYcncq4Ai
 WSVBiWWU4X6aAGOUgOL9fqVLJoApI8DjJwXXKBS/ninmfH6aL9+qNDfDH1ZQzQMlhLqw
 5X2Qb66+GXJGzntayqlDmMJJtTAQBTxm9t3v73A52Y9FK+/nORJp38mQS+QBuPXptJmZ
 qpd2ZNEC2CqTqm0x3vmWtj2l1bP6j7qY02wz8XRKC7zeI5/Me3yyAM1soDZG99p2sOdh
 THFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180769; x=1769785569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bb55XTSNzdky9WU0oKM2F3ZA/eluT7mQAYoxH8GswsE=;
 b=jnl51XheqoVjfdvmr7vCicw5oEtotVVrqqh+bYDgwRS2aqslfdase1C1XOwZJw6mDi
 kxfUwOu5VYp5hccdt0/n0CGRUGdFJKA8/Xadu3BUX+zRAnkf0lzA+oJzDN5xG1OH7Ecx
 teSMd33dmOlRI4IBwbw37Y9J5yMLajGBYUQmwX7s+LEP1I+b3p4ho6AZWL9G5kag56TA
 9Mj/o7VF47sLvT/PSj6CBqA80SVUNSJHAuXaOnI2te/QUi+hvVU9JBakUp3ZfxB1Xkb2
 RwKnqXsRIUrhANbditBeqOriyRwDiTOWBpslcLQ6etNP96HPmdwuoAG2EaCFeYqdBYOR
 uqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180769; x=1769785569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bb55XTSNzdky9WU0oKM2F3ZA/eluT7mQAYoxH8GswsE=;
 b=Z+HAzIBCI2KWEKbM/MKkE6iyIDlzTC9GboMdlW4EOjLZXrug+QE2G5FW3sZVKT0Dc0
 ojlTmb8ctrymxmMWkEHFvuNBVWwJmJbygl6IAQmk9jvAyJ0jYePTv5Eocce8eFnlTvia
 ajuN5prHHrc+Oaa6W7K/9Kaaqij0sczS1+BqPQcO7Ns6JtgcaJoMfF6r0wTeTqVrC2l2
 S8svDw8yn6acVLki6bEQSVwI/0T0omXmAValyq2My1tjP0cCojjkrPbVdkFO+Ra4ZVDZ
 GXAvRQWSfUXMwtHuNePO03QlADVqt9t1TnIiDq82T7aX6CpaBiPTgnywQdGS7mEnuHm7
 WJ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzUSPfDelRWW7NpChk+KWEeSSHdXr2OuIHkqDX2MLOt/qCBsOHZQi4165AKJvnTXIbLOKdHdHxNYWF@nongnu.org
X-Gm-Message-State: AOJu0YxZMZPJFuro0xl7Sv+JgCLo6aRNzdy14NU+7c6FKQpRBIPWIHgt
 QEWzpm0rubJi8qiAF6tYpzpwH+/LNYuihGmN+ZZp9Xdm5lhXRtDPD74mEQjyvHYUuTJrgf/Oj9U
 gBQYfm779oWY5/W2RlqqDsMjp/sI0EzsMfuHBtUanDA==
X-Gm-Gg: AZuq6aJNpd7x7lYAurXokt2VwEwb9Tr9NnQtdwtpgOd+mhRsFCMx/ASxBQSWdcHHEX6
 FLAl/5aKdpVRYxKnNZaScyL01zA+yXTzgmksToMxQ+wXM/Zyw86Z0nSUvxeZcsAswRN/pT0XvkS
 L64uNloMREL3jyeGJJFdNb15nQ0zNAP0rBqoF5IrLjLDgtmIzs/v9CXtUnYB4ArRUsglH0jd+Fx
 l8NxqrHchdg3NDhijW0jtaQJdvZf9L91vkgVLYN9bcMLq8W7OA8Eqys2uxjatmnz5IqdhLNwOpf
 3dtu
X-Received: by 2002:a05:690c:6809:b0:793:e580:94b3 with SMTP id
 00721157ae682-794399dd408mr25931717b3.35.1769180768896; Fri, 23 Jan 2026
 07:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 15:05:57 +0000
X-Gm-Features: AZwV_QiPZ169cidWqIBtgbAlvqpV1TtQydj0YFfBWcRB62srPYs-F8RQUe6U4Rs
Message-ID: <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, 
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
 Krishnakant Jaju <kjaju@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 23 Jan 2026 at 12:04, Shameer Kolothum <skolothumtho@nvidia.com> wr=
ote:
> > From: Peter Maydell <peter.maydell@linaro.org>
> > I can fix that up when I queue it into target-arm.next.
> >
> > Thanks to everybody who helped with code review on this series:
> > not having to do that myself has been a big help for my personal worklo=
ad :-)
>
> Thanks for sorting it while queuing.

Unfortunately I had to drop this from target-arm.next,
because it caused one of the gitlab CI jobs to fail:
https://gitlab.com/pm215/qemu/-/jobs/12839040278
(Not an intermittent -- the job failed the same way
on retry, and passes with my target-arm queue without
this series in it.)

I'm not sure exactly what's going on here, because
the bios-tables-test test passes on my local machine.
Could you investigate, please?

1/457 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test OK
83.58s 55 subtests passed
=E2=96=B6 2/457 /aarch64/acpi/virt/its_off -
ERROR:../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion
failed: (all_tables_match) FAIL
=E2=96=B6 2/457 ERROR
2/457 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test ERROR
25.86s killed by signal 6 SIGABRT
>>> MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:p=
rint_stacktrace=3D1 PYTHON=3D/builds/pm215/qemu/build/pyvenv/bin/python3.11=
 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_STORAGE_DAEMON_BIN=
ARY=3D./storage-daemon/qemu-storage-daemon ASAN_OPTIONS=3Dhalt_on_error=3D1=
:abort_on_error=3D1:print_summary=3D1 RUST_BACKTRACE=3D1 MESON_TEST_ITERATI=
ON=3D1 G_TEST_DBUS_DAEMON=3D/builds/pm215/qemu/tests/dbus-vmstate-daemon.sh=
 MALLOC_PERTURB_=3D162 QTEST_QEMU_BINARY=3D./qemu-system-aarch64 /builds/pm=
215/qemu/build/tests/qtest/bios-tables-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
acpi-test: Warning! IORT binary file mismatch. Actual
[aml:/tmp/aml-7QQVJ3], Expected
[aml:tests/data/acpi/aarch64/virt/IORT.its_off].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
to see ASL diff between mismatched files install IASL, rebuild QEMU
from scratch and re-run tests with V=3D1 environment variable set**
ERROR:../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion
failed: (all_tables_match)
(test program exited with status code -6)


thanks
-- PMM

