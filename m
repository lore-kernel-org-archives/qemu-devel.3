Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46209F419A5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0P0-0003Nr-P6; Wed, 15 Apr 2026 09:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0Oy-0003N8-Iw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0Ou-0006N3-49
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776260125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJtIDh78hVz2Og/caLm5pOUhFBAnjSYPwwsVV79UXS8=;
 b=QZLEBCJ/pC5U/jR27tSIcSs9PQZ8QxJLpX85JJJccideCAmR7PdDiMAiRKxUT0BaVEkQXP
 p8uTOIpEHqGprvKaep7tO3O5o8BrHEuWCH2mRjhemBNAOlqwb37gu9VWwVeUGNnh+PAPxW
 N5YRK7lNeo0hlLnw27EPnuZI8Yyi9og=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-A9aBuLqHNu-Ef4xNQj9Abg-1; Wed, 15 Apr 2026 09:35:23 -0400
X-MC-Unique: A9aBuLqHNu-Ef4xNQj9Abg-1
X-Mimecast-MFC-AGG-ID: A9aBuLqHNu-Ef4xNQj9Abg_1776260123
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-68e924f632bso9020483eaf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776260123; cv=none;
 d=google.com; s=arc-20240605;
 b=MoCMqtrRI/a77+KShAH1vARhzyD63y7FF6RX2rA8sp+TCZpKkVih0U9CC8pyJTaIkr
 mOjVjqZoWV+dc0rQYaU/PqZU1LwWN3tvrPV9M9zp7VMyalu82p8EAliqAc0P9R4MCPgA
 ZygTAYDq6HRaooEO4GlZ8WTwoFio9/XTGgSVR6Qf/vcmtNcRkh//022mhWeKp72EcT7L
 ouM8sXq/vMFcemMxllW6kD+ly4rPZ+0aLmogbd/FRC4gDVAWpo2/NCoxFHV+eJs2RwOB
 5odxsks8W9KFgru+1tVgbYGwOXoaZo4ro7vnQVhvMt/RQbnwG33RrtW5wQj9Cx+O73dy
 /Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mJtIDh78hVz2Og/caLm5pOUhFBAnjSYPwwsVV79UXS8=;
 fh=ey4PBSvBqeQkg4f2UbbK4rf17z3h5yS3KmmMBcBtgh4=;
 b=FOC/Fnn3f2H8bVK31FdqAeoBbryFPc++d+3xoAdiFv0WajC2fMdJVqCZh0DD1JgeHW
 +SdbquTkj3QqK60z5p6UKRqUugQZnoriQ1Q6WjvHQ0rgRMpNL44U0Ya8QIDaBxh0/6SQ
 t1urwbeWoLFbob6broa41HzhFWHHL6LP5otlW15qphj4EyIPYcbME75ttyYL7FfOw4cP
 iFeHaMssPKwv5X2Ph7B9RBFgJHIPs1SyhqDTl06XCN1wQvMW1xfFi5uf157ba09Pcwyy
 +BQYj2h6Uh5PbP6XTMMiAKKGVIM6tYpTmEaEs6Vdx9bk/B+MzuFqm9g7SIs6bR+ghyQx
 oqrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776260123; x=1776864923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJtIDh78hVz2Og/caLm5pOUhFBAnjSYPwwsVV79UXS8=;
 b=k7J7N+fluHqLWQ5vQ2S9yNdHhQm+7Oc650GK0c7kfzjHk8t2Rclbpfa2rt0d0oLLKZ
 bA8WMTMbaNwFUrL6Fo+Iu2s8GX3XrGvWmsj6176j7Rea3zwsYwDlk73H4ytvGp6l8HZn
 T1sHh4RjuV8oL+GKAkN0Fvy7+KlPXq52NBydHu39albXEt4WYWE17dIDei09TyIPoq7l
 aDG9RaVtu2vdfl7yejcayb323JD3mjMyn7HzQwcd0eBxfUB3EiQSDbkSAMRSWVGsaKjg
 yeT8yUomEjSA2slrHqmjW64Xb3iSXJa3bHzpOxU02O6jVocIV21882Inqcwvcfmg5zpc
 4nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776260123; x=1776864923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mJtIDh78hVz2Og/caLm5pOUhFBAnjSYPwwsVV79UXS8=;
 b=Y8rwG1AsuTkOjs6ygRgW3yfl3KY703PzqBLwh2DScXjWFnh06Up9koubh7qgFD1XfC
 eOfI/qvmuvdKV7TTQa4OTgqD5y9oiqzilpCSMjmepe5w7x9jBbw9pQuQlwMIJQtzubRx
 uu395QIQcVOiHV0daNv8oATuRDUPVIlMDR5mr8Mt6T0DTiUKKdQeo7QOMjEr2eL70Aop
 uL0nF2Cg+znrJ3pnlDikYsNQ3daf0bgqdO64tS+X4x3CULU3/iWYvCQGsfAY1uMC3aap
 9bFPWRrL+o6fRFGILp6/ykJUWXlYrNDSH8ezTK71wV2jjMbH80u8zyMHT0qQfcFml97N
 kDkQ==
X-Gm-Message-State: AOJu0YxFanGflN4GVTvzTMCemnO+J9HJ7NPPNUi5tnLmcvbyxQg5rtbo
 UzM3wM8p/u/OKp7Rd2Ca1j/VP7qUDX/W5npkic6+WSX4BQR4G35+L9pu6jYBMoUUFZ4ifTg82t+
 3TPYTQyPOyLJiEJXz5ZsmNGblAQM5KBjJ0LVe6MIS7V9/8RGRiiIcGmpkyftCEJM11M0vXfnoqV
 sYGlTzfJVM29WChYtYf+vCa9kMsWL04G8=
X-Gm-Gg: AeBDieutwHEQATY9gxbKOCI1BwCQLCaUOQSaCPdBGWPqQ+dVAk9pR50v3Mx0wZgPzIT
 yzWpwvu6wk26X0Oy+RCNwPuT8acTWAR8uQ9p1yh8CmTR/pW96KS0lgn/JtD7MMlU8v4gXwlez0Q
 6+aMRE9TvUxeobgJuYQcfue4yPPyZ6UM+oy15RIhID57tCvG2IvmZs6x30Fu9Evf1IYgHgh5gNq
 oC9cVlEwgZK8WygHIr9j+Tq4AUEl0pw19kXU1P3ih/ovw==
X-Received: by 2002:a05:6820:98a:b0:68c:a53c:8ff1 with SMTP id
 006d021491bc7-68ca54bd3eamr10729392eaf.11.1776260122732; 
 Wed, 15 Apr 2026 06:35:22 -0700 (PDT)
X-Received: by 2002:a05:6820:98a:b0:68c:a53c:8ff1 with SMTP id
 006d021491bc7-68ca54bd3eamr10729367eaf.11.1776260122238; Wed, 15 Apr 2026
 06:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-6-armenon@redhat.com>
 <CAMxuvaxU=1nds7QAysem_j0jSOM8DK-E0Y74xCs3kS35Se_JKQ@mail.gmail.com>
In-Reply-To: <CAMxuvaxU=1nds7QAysem_j0jSOM8DK-E0Y74xCs3kS35Se_JKQ@mail.gmail.com>
From: Arun Menon <armenon@redhat.com>
Date: Wed, 15 Apr 2026 19:04:43 +0530
X-Gm-Features: AQROBzAeoFQkp0bAZvHvPa2_bbrqU9d_xtHg3BvQYR4riX9NzFClZjwJ5Y-Bups
Message-ID: <CAE_eyq_HPtkkpKURPwca1MBWkHQTHP2ajvPv9NoMJ7LwNLdndg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] test/qtest: Add test for tpm crb chunking
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 02:40:51PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wr=
ote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > - New test case added to the swtpm test. Data is written and read from
> >   the buffer in chunks.
> > - The chunk size is dynamically calculated by reading the
> >   CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
> > - Add a helper function tpm_wait_till_bit_clear()
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
>
> This alone doesn't yet test the chunked write/read, as the transfers
> aren't larger. The following patch "tests: Use ML-DSA-87 operations to
> caused large TPM transfers with CRB" will. It may be worth to say in
> the commit message
>
> with other minor style nitpicks below

Thanks for the review, I have incorporated the feedback in the next
revision.

>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  tests/qtest/tpm-crb-swtpm-test.c |  10 +++
> >  tests/qtest/tpm-util.c           | 108 ++++++++++++++++++++++++++-----
> >  tests/qtest/tpm-util.h           |   5 ++
> >  3 files changed, 108 insertions(+), 15 deletions(-)
> >
> > diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swt=
pm-test.c
> > index ffeb1c396b..050c7b0c1f 100644
> > --- a/tests/qtest/tpm-crb-swtpm-test.c
> > +++ b/tests/qtest/tpm-crb-swtpm-test.c
> > @@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
> >                          "tpm-crb", NULL);
> >  }
> >
> > +static void tpm_crb_chunk_swtpm_test(const void *data)
> > +{
> > +    const TestState *ts =3D data;
> > +
> > +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
> > +                        "tpm-crb", NULL);
> > +}
> > +
> >  static void tpm_crb_swtpm_migration_test(const void *data)
> >  {
> >      const TestState *ts =3D data;
> > @@ -54,6 +62,8 @@ int main(int argc, char **argv)
> >      g_test_init(&argc, &argv, NULL);
> >
> >      qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test=
);
> > +    qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
> > +                        tpm_crb_chunk_swtpm_test);
> >      qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
> >                          tpm_crb_swtpm_migration_test);
> >      ret =3D g_test_run();
> > diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> > index 2cb2dd4796..603c5a825d 100644
> > --- a/tests/qtest/tpm-util.c
> > +++ b/tests/qtest/tpm-util.c
> > @@ -14,16 +14,44 @@
> >
> >  #include "qemu/osdep.h"
> >  #include <glib/gstdio.h>
> > +#include "qemu/bswap.h"
> >
> >  #include "hw/acpi/tpm.h"
> >  #include "libqtest.h"
> >  #include "tpm-util.h"
> >  #include "qobject/qdict.h"
> >
> > +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> > +#define CRB_ADDR_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> > +#define CRB_ADDR_CTRL_CMD_SIZE \
> > +    (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
> > +
> > +#define CRB_START_INVOKE  (1 << 0)
> > +#define CRB_START_RSP_RETRY (1 << 1)
> > +#define CRB_START_NEXT_CHUNK (1 << 2)
> > +
> > +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t ma=
sk)
> > +{
> > +    uint32_t sts;
> > +    uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SEC=
OND;
> > +
> > +    while (true) {
> > +        sts =3D qtest_readl(s, addr);
> > +        if ((sts & mask) =3D=3D 0) {
> > +            break;
> > +        }
> > +        if (g_get_monotonic_time() >=3D end_time) {
> > +            g_assert_cmphex(sts & mask, =3D=3D, 0);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> >  void tpm_util_crb_transfer(QTestState *s,
> >                             const unsigned char *req, size_t req_size,
> >                             unsigned char *rsp, size_t rsp_size)
> >  {
> > +    uint32_t tpm_sts;
> >      uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_C=
MD_LADDR);
> >      uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_R=
SP_ADDR);
> >
> > @@ -31,24 +59,74 @@ void tpm_util_crb_transfer(QTestState *s,
> >
> >      qtest_memwrite(s, caddr, req, req_size);
> >
> > -    uint32_t sts, start =3D 1;
> > -    uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SEC=
OND;
> > -    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> > -    while (true) {
> > -        start =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)=
;
> > -        if ((start & 1) =3D=3D 0) {
> > -            break;
> > +    qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> > +    tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
> > +
> > +    tpm_sts =3D qtest_readl(s, CRB_ADDR_CTRL_STS);
> > +    g_assert_cmpint(tpm_sts & 1, =3D=3D, 0);
> > +
> > +    qtest_memread(s, raddr, rsp, rsp_size);
> > +}
> > +
> > +void tpm_util_crb_chunk_transfer(QTestState *s,
> > +                                 const unsigned char *req, size_t req_=
size,
> > +                                 unsigned char *rsp, size_t rsp_size)
> > +{
> > +    uint32_t tpm_sts;
> > +
> > +    uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_C=
MD_LADDR);
> > +    uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_R=
SP_ADDR);
> > +    uint32_t crb_ctrl_cmd_size =3D qtest_readl(s, CRB_ADDR_CTRL_CMD_SI=
ZE);
> > +
> > +    size_t chunk_size =3D crb_ctrl_cmd_size;
> > +
> > +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> > +
> > +    for (size_t i =3D 0 ; i < req_size; i +=3D chunk_size) {
>
> extra space before ;
>
> > +        bool last_chunk =3D false;
> > +        size_t current_chunk_size =3D chunk_size;
> > +
> > +        if (i + chunk_size > req_size) {
> > +            last_chunk =3D true;
> > +            current_chunk_size =3D req_size - i;
> >          }
> > -        if (g_get_monotonic_time() >=3D end_time) {
> > -            break;
> > +
> > +        qtest_memwrite(s, caddr, req + i, current_chunk_size);
> > +
> > +        if (last_chunk) {
> > +            qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> > +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOK=
E);
> > +        } else {
> > +            qtest_writel(s, CRB_ADDR_START , CRB_START_NEXT_CHUNK);
>
> extra space after START
>
> > +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_=
CHUNK);
> >          }
> > -    };
> > -    start =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> > -    g_assert_cmpint(start & 1, =3D=3D, 0);
> > -    sts =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> > -    g_assert_cmpint(sts & 1, =3D=3D, 0);
> > +    }
> > +    tpm_sts =3D qtest_readl(s, CRB_ADDR_CTRL_STS);
> > +    g_assert_cmpint(tpm_sts & 1, =3D=3D, 0);
> >
> > -    qtest_memread(s, raddr, rsp, rsp_size);
> > +    /*
> > +     * Read response in chunks
> > +     */
> > +
> > +    unsigned char header[10];
> > +    qtest_memread(s, raddr, header, sizeof(header));
> > +
> > +    uint32_t actual_response_size =3D ldl_be_p(&header[2]);
>
> avoid mixing code & declaration per qemu coding style.
>
> > +
> > +    if (actual_response_size > rsp_size) {
> > +        actual_response_size =3D rsp_size;
> > +    }
> > +
> > +    for (size_t i =3D 0; i < actual_response_size; i +=3D chunk_size) =
{
> > +        size_t to_read =3D i + chunk_size > actual_response_size
> > +                       ? actual_response_size - i
> > +                       : chunk_size;
> > +        if (i > 0) {
> > +            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
> > +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_=
CHUNK);
> > +        }
> > +        qtest_memread(s, raddr, rsp + i, to_read);
> > +    }
> >  }
> >
> >  void tpm_util_startup(QTestState *s, tx_func *tx)
> > diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
> > index 0cb28dd6e5..681544e7d8 100644
> > --- a/tests/qtest/tpm-util.h
> > +++ b/tests/qtest/tpm-util.h
> > @@ -24,10 +24,15 @@ typedef void (tx_func)(QTestState *s,
> >                         const unsigned char *req, size_t req_size,
> >                         unsigned char *rsp, size_t rsp_size);
> >
> > +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t ma=
sk);
> >  void tpm_util_crb_transfer(QTestState *s,
> >                             const unsigned char *req, size_t req_size,
> >                             unsigned char *rsp, size_t rsp_size);
> >
> > +void tpm_util_crb_chunk_transfer(QTestState *s,
> > +                                 const unsigned char *req, size_t req_=
size,
> > +                                 unsigned char *rsp, size_t rsp_size);
> > +
> >  void tpm_util_startup(QTestState *s, tx_func *tx);
> >  void tpm_util_pcrextend(QTestState *s, tx_func *tx);
> >  void tpm_util_pcrread(QTestState *s, tx_func *tx,
> > --
> > 2.53.0
> >
>

Regards,
Arun Menon


