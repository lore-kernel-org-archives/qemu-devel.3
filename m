Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB21F436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkXh-0008Em-V4; Fri, 17 Apr 2026 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wDkXb-0007zr-P6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:51:32 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wDkXZ-00082N-Pw
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:51:31 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2de831d2b20so1569596eec.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 07:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776437487; cv=none;
 d=google.com; s=arc-20240605;
 b=QhKU1YIUtoNyzNjGACTr55izdwWaXaqXWpa0nWeS3N7CfzCFOv56w5AKEki9ei+FyS
 kSwd0LoQ3kN4/xeWrn9tEW+ZzdF6adJO1sNILXKSBgYr/bUVGZ6UpKgWiS5MUpAiommf
 g5ngGa3rWTPbC/Jb5/C3BrSKOj0+zrec79TLC1mp6Muql6Fp7DXwCdjlWdp4K85B8TFZ
 G5F/658bgEvwm2GZLFRXApKExulmSgYf5tjNSiVZiRDl0TGqcgMu1Sh+9w0ztVPVitZZ
 44ehFdPFWWKDaqx5pbCPL/ZMaNLQmbNb1pdr9Tt67Yu3mCB2AaKNs99Q/N98ht6wRe+8
 GobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FN66NGOucyhcDev2u0kiq1YjiJEhsVTImqb06ZlXRpc=;
 fh=auCZ2RMXgE8q81fszM11/UCG6T4JWzTkqYds390aMho=;
 b=YA2mLsGHkvsOAOSNE7YoEBdVu9JHBt2mSxn7Zs1+2pJrlTJ2hGq71YJtlqE04adMGW
 VqP9AjleyTJiFGt9a0nvCdzzrnnDGmLAJSLftS9msZiu6ijOUpkiSTdFGWkpBKpVg5G5
 f0zA/dgyl7lXLSuhxy0Hi4XLGoF+/n+2xXSEubvU2RAQ/3WJ38XTaFbjoGB2SZXPaeEA
 yCiDULnTQFkVil+0xEk9O8S+rWfIwnQ1nxXkwexzZflgrs1++HtY9XkR6YRQAKMHrir2
 TKPUaNSNZXPs7hPIY5yRuAm0NM3ygdoPXBYWlF5xQu9vh7BxtecYbRtDPYboNjztzlUH
 SHWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776437487; x=1777042287; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FN66NGOucyhcDev2u0kiq1YjiJEhsVTImqb06ZlXRpc=;
 b=UVYWgGJl8OSXLgqhU4dl1OQax7p5Lo+gAF52R7BByuw8D5Kbfg83xiPpoaXprhB+Ce
 0QEorywsi+TX0vY+ARk7IqQOWLKZt/BzsDfHPjzNAUDoIaPY1a57vLj5yvr39Vt9zyjQ
 xlwA2bmO+5y4C74ylCQ+AbxkNbx9/AatjpAjfEoXw+Gv0uAMeE0UtDVbJ0aae4aF4OuK
 x3+cVK07iN2DnAldmSxr+4PhPR/lpez+3qm6ujPSDLHAtDXZxXXvNki3XCVCHfDR9OSh
 IrKXKFzSnRF2S5cvM4Fzb4MX0OdOf2qg393ibrKB4hStrl1sbHDXovBBOK6EDi8lVEAJ
 tEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776437487; x=1777042287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FN66NGOucyhcDev2u0kiq1YjiJEhsVTImqb06ZlXRpc=;
 b=DTnRPbEhESUf/EE1ic47aJowb7M4FwXtZ9qNReGQCFSr4c2qf3XuHkA9lasiorXPdy
 JDsk4ZbrTw7VeUGGN/i+dyzo5a8jcLtDM5/wEU+TGa/NvSEoexaX3BdiwDj4MWSMqTBu
 e9flYkaoWWwhBUEuPOpXTkMDh8ZSJHRhiDHGKosG+0Cz7W/potLQVmApZRs3x0MoTv6k
 G/lJeR6IMFMbB6gNz2Tz4dHi7yDPJ5q/kQLsEuBZUVT37YtGjiQkLeobqiwqF8/9W8as
 lYAd1zsjUNa7nCIWJWqvugPWshj4HzL8f/IEh2EvnRi8N7XPa0OULIHVkVHudMdgBHPT
 mf4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4repaSD+jjmQjZMyEy8aIzk0Zz0OuqDooNVfaC0rlmcKHMpfiCaF5L2sB+2IU3Ey15SQsZs6uXzlU@nongnu.org
X-Gm-Message-State: AOJu0YwbPXzqARudplMRwyOuczyRGmww18od03f5nwAR7XOoF3qNEUhz
 vMwJhCU7xEmV6+xw5UQmmwwZV5QnJb4EE8SnLms2yHoPPiJFTE02UkbH3dCsTFQlk1ibVxhzgmH
 gheXXSelmQyaQf5xUcE/TGqcAaKmulos=
X-Gm-Gg: AeBDievl9qnDpVvxh8C9ij5aS4IH3JawQqupWWaZ26+a7TsPBRhJkN2//OeaeEZSg1O
 QndNCT+qcniB/OAKoAkHC9ox7thG+Cvm4Qa1PRX67qVDB/5bn3CbzJDRv2Vb06MepgDKafVCFC1
 u1N05A2+V/9kYsEOhOt6/fkI/3Se2+40JKfrIcadhhlmVyhqkRVQNgyU4m4oTc8WUc6zu/9qNSI
 2klceA23RxYrp5RNZ3FbBPu4vw2v12MOAKtm6wWRm0Ox4MYyHU5akyDGz2IQ19DOCH5BVdRaLyI
 lRc38/K+G2oQVQ10Vros7JkygjmOrYfq3D6LtdHSc9ndZjhpKVQ=
X-Received: by 2002:a05:693c:2b04:b0:2d1:a3ea:d8d4 with SMTP id
 5a478bee46e88-2e4647d03a2mr1636962eec.6.1776437487383; Fri, 17 Apr 2026
 07:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260414082915.112122-1-armenon@redhat.com>
 <20260414082915.112122-2-armenon@redhat.com>
 <CAMxuvaw2=uupgJFynh_-2Nkj2VV+V6CqeOOB02A_p0LkOCFy9A@mail.gmail.com>
 <923e81c9-fec4-4526-945d-e4b1b354a416@linux.ibm.com>
In-Reply-To: <923e81c9-fec4-4526-945d-e4b1b354a416@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Apr 2026 18:51:14 +0400
X-Gm-Features: AQROBzD0-1DQmm54eX7gKvkha5LR-VOwmnMwdHwS8NiYi0sCSkKdniy6v-1ma2o
Message-ID: <CAJ+F1CKq=+hRhgHeGP-27tec+ypRGL3OKd2Q70_JoPpYyAA3Sg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Apr 17, 2026 at 6:36=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 4/17/26 6:05 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Apr 14, 2026 at 12:30=E2=80=AFPM Arun Menon <armenon@redhat.com=
> wrote:
> >>
> >> From: Arun Menon <armenon@redhat.com>
> >>
> >> - Add new fields to the CRB Interface Identifier and the CRB
> >>    Control Start registers.
> >> - CRB_CTRL_START now has 2 new settings, that can be toggled using the
> >>    nextChunk and crbRspRetry bits.
> >> - CapCRBChunk bit (10) was Reserved1 previously. The field is reused i=
n
> >>    this revision of the specification.
> >> - Refer to section 6.4.2.2 of [1]
> >>
> >> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Spe=
cific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
> >>
> >> Signed-off-by: Arun Menon <armenon@redhat.com>
> >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>   hw/tpm/tpm_crb.c      | 3 +++
> >>   include/hw/acpi/tpm.h | 5 ++++-
> >>   2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> >> index 8723536f93..0a1c7ecdc6 100644
> >> --- a/hw/tpm/tpm_crb.c
> >> +++ b/hw/tpm/tpm_crb.c
> >> @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
> >>   #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> >>   #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> >>   #define CRB_INTF_IF_SELECTOR_CRB 0b1
> >> +#define CRB_INTF_CAP_CRB_CHUNK 0b1
> >>
> >>   #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> >>
> >> @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
> >>                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> >>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> >>                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> >> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> >> +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
> >
> > We should not expose that new capability to guests without an explicit
> > "cap-chunk=3Don".
>
> You mean put this on the QEMU command line? This new capability is
> really only needed if the user chooses PQC algorithm support (but then I
> was also going to allow for 7kb writes to NVRAM spaces rather than 1kb
> writes so far) and if the user chooses a swtpm profile with such support
> but then fails to set this flag, some transmissions won't work. What
> would be the problem if we exposed this new feature all the time and if
> we can avoid state backwards-incompatibilities, which IMO is the most
> important aspect, if we detect that chunking was not used by the driver

In general, we shouldn't suddenly expose device capabilities to
guests. Starting with 11.1 machine, the cap-chunk feature can be
enabled by default though.

> and only write additional state if found absolutely necessary? I would
> prefer to untangle the user's choice of enabled algorithm from the
> choice of such a flag. But then there's the aspect of OS drivers that
> could use chunking even when not absolutely necessary (?).

