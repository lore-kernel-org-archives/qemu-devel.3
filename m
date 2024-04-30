Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337DAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1k2O-0000wE-Fl; Tue, 30 Apr 2024 05:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1k2M-0000vw-UV
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:44:34 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1k2L-0006YY-Am
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:44:34 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so4464880a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714470271; x=1715075071; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCMfKZAGNmI/PtFOZQwGD9xZljZQvoZow3JJeS0YYVQ=;
 b=vuUlsKkbwf0F2MDlvg2o3EK6DGTFqga50aqM/7uBI344QoFv+/IEiQmu8toOZ+ASdW
 CP3NVovIKfZb33FWoUfFW6nQF02V+l+CRJqG/sf84YXHUjGweQBRf33W6ScLPtRoDXgb
 M3BOh2BSAajjd4agn5wj5C1+ym8aT2yo84hrKq4GnSqbwseTPlPh6tZwzZTe9RIF1jI0
 Mc/TjMA+hb2hAAVjP1MLMV3g6ZMO3aEFEHMp8/ZEL0R62wkA+PFHkfTUJOp217DRIR2z
 MqQLDLJDhrTwEla0wS1FAzszO0qgFNsYlBcQ2qBsywy7rK9uBK3d+pP/P8P/eRBaKOk3
 eAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470271; x=1715075071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KCMfKZAGNmI/PtFOZQwGD9xZljZQvoZow3JJeS0YYVQ=;
 b=Fl5oQxlLE+Pw7HKDzoPmmq9CI3qGwihOQ0X8yCK5i065xIa35c+LznqxVXtyNxuRDr
 jGQNC4g8QufbRcmfTgfG6JEmXTcj74vQ/uZkgn29ycI6CkugY4hh+NLGStwW46O253j+
 s6coTbBnnjUegxnJxCSTSuZhpbIMLlUy9h1ibCdD7XV4yfTCZ7r2fBL4MmjUbIhiFYuD
 iAW+SnLVW9AoQW7cLYZnlNo7o0O+sbwFCaOR0EQ4zdICDGwaQje7JAIP5oMF8fJAIvMs
 ihwxX0Xfw2+Mu7x/ZSfSlGGTB+RVsydW/5LB6Y3jALdtCs/8S1SB3A5zWOz+1gUzZusO
 sH+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEROSMhIhKF+yUYUbGNQYrLNwotA5hT78Oxk5XLrAIfjp4X+o8HkqJNSkXjz6HPtvYdmhC3hg5eXaKIBR1beHmtq6sAmg=
X-Gm-Message-State: AOJu0YwBv0vGXQ+lK+oxO6PDTcxS0CvPlxb5Mdzc8rbDtx9cpqdKds0u
 mBoMddK4XxpkuSXz+HBnOGJcNE2F1m6P3UQSQBLJqR6Ew6ZdfjwsI0A3Z1soa4aP6awJCSE+1Xv
 kYuhwLK9WbxUWxhCg/b7xS0CfZGIlj3y7PNkwGQ==
X-Google-Smtp-Source: AGHT+IH6FssOWWBfhPrgpynkrGQCO/em/xoUSkGGqAZ404w5X1+ajBKTsEKpWLo3siwB/6xLTgOgabiawHvIz1s0CBg=
X-Received: by 2002:a50:9e06:0:b0:572:475c:a47c with SMTP id
 z6-20020a509e06000000b00572475ca47cmr9317690ede.22.1714470271506; Tue, 30 Apr
 2024 02:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
 <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
 <Zi_C_xHx33Q7T_96@redhat.com> <87v83zcnfc.fsf@pond.sub.org>
In-Reply-To: <87v83zcnfc.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 10:44:20 +0100
Message-ID: <CAFEAcA9P+axwCS+aaA1K2rVzBsNquRG0-pNTncZemaOsXi=GyA@mail.gmail.com>
Subject: Re: QEMU Community Call Agenda Items (April 30th, 2024)
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, afaerber@suse.de, 
 ale@rev.ng, alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>,
 bbauman@redhat.com, 
 bcain@quicinc.com, Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 clg@kaod.org, cw@f00f.org, Damien Hedde <dhedde@kalrayinc.com>,
 eblake@redhat.com, edgar.iglesias@gmail.com, eduardo@habkost.net, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, 
 iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jim.shu@sifive.com, jjherne@linux.vnet.ibm.com, 
 Joao Martins <joao.m.martins@oracle.com>, konrad.wilk@oracle.com, 
 Luc Michel <luc@lmichel.fr>, mburton@qti.qualcomm.com, mdean@redhat.com, 
 mimu@linux.vnet.ibm.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, 
 stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 eblot@rivosinc.com, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 30 Apr 2024 at 08:36, Markus Armbruster <armbru@redhat.com> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >  * /machine to get the rtc-time property value
>
> This is an alias to the RTC device's "rtc-time" property.  Only some
> machines define it.  Useful because the actual property depends on
> machine type and configuration.  For q35, it's
> /machine/unattached/device[N]/rtc/date, where N can vary.
>
> If we moved the southbridge out of the /machine/unattached dump, we'd
> have something like /machine/q35/ich9-lpc/rtc/date.  Stable, but you
> have to know the machine type to find it.

Do we really want to call that stable, though? If we ever
wanted to refactor the devices internally it might change.

My gut feeling is that exposing something we want to
be stable as a specific "this is obviously an externally
exposed identifier" (e.g. in the way we do by having an
rtc-time property alias on the machine object) is more
likely to be reliable than trusting that a QOM path all
the way down to a specific device is never going to be
rearranged.

thanks
-- PMM

