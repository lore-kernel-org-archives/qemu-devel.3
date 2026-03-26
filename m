Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9766D10A1E7C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ixb-0000UD-Ui; Thu, 26 Mar 2026 07:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5ixZ-0000Tn-VT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5ixY-0006QA-4a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFWBGqsD+OTQvIlTBc+s/7XQkE8V29leRTjwPnyysws=;
 b=h2pVt4i8VAXyfg96wDdgEi7d3qgiBBvafAmAWyYpuASpwLC8Jm1kIJz+pYa6ySOPXtykIa
 5E5wlFRWSSyZ7G5HoVGHh7eWEDmMKLTtk06/QbUQyC9eOxZtd5UUuP1TWDxXMGquwYjUnB
 YM5pkidkAgElI81Cw80/qj0/m4MO4hE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-YOVeIDSSOQyoR9wluzKzzA-1; Thu, 26 Mar 2026 07:33:05 -0400
X-MC-Unique: YOVeIDSSOQyoR9wluzKzzA-1
X-Mimecast-MFC-AGG-ID: YOVeIDSSOQyoR9wluzKzzA_1774524784
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7414516609so707964a12.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 04:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774524784; cv=none;
 d=google.com; s=arc-20240605;
 b=XZhTT/Pvyw/4cKBCGuVaJl0qnSSbbg514iDoilm6zeysiVDxEURL1n4urrb57TSfi5
 oHZk5Vd7NtPMB76Uc/uPY9KSl9L6/2xVGMOs2OqZeZzQcAPNTn5lIg9yJxG0M3h06GBs
 AT4ebUHYIRin6VZDlRg1Ptbkr6gU2JAYG/NRMAuEx29VSwYJk3/65Ac09erHO1tmIaLS
 asXLw4y0UJZ1rCa5K1pvNDJ0FvuTJnlTkdybOgdepXOmwprAk1iiDZHcrMcXwJht1Tob
 +74h8ptdeQ+ZbKDEAjZ9i4S/+03g4FsPYPseJhn6sJ+H5wzR/38EuTiGpN59HsArjgBD
 zlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cFWBGqsD+OTQvIlTBc+s/7XQkE8V29leRTjwPnyysws=;
 fh=z6uibAafEEdEPwoLxuRjPMr66T7KT1R7Y8Wa3xPfp7A=;
 b=SXRfq0MWZGdbUHaIIfl1F9rWhLdNwe74scLkczOJdsg1gZayd+rLmqfO/hnNpwR1pL
 qKNkMaEdnCevKX8ggDgudYu69VmLFPgqr9np0eE6b3VIs50vhyQEMeNjGA5GZM8lm94g
 mltgaXfGCNng4Ww9FcD/wSrA0SNfE7xLnY7sQfHPrix6GqCElSpYnQ3FlbealnxqWl6V
 0/voqYUN4AqMhVT47vnLOQ+g8w1gltFpheAHa4FvdB8aYKb/wtrb/UxXXwFhSWJmmm2O
 0bVxy7Wbd1lFcocpDPWgmYZwzAcdpPBWNNVLtDXQ47oD6s5U/9DKfXPme1DZB0wFb1bv
 4Msg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774524784; x=1775129584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFWBGqsD+OTQvIlTBc+s/7XQkE8V29leRTjwPnyysws=;
 b=jbM4i6iMchHZBQIuJ3mMKnV5YzQahQPyF3c4VE8Ikq+GQGblneOsTCvheF0c2j9hgf
 W5NKxDZIB2YaZn1lHD2i57p5+hxYoWzcCsBz6H3OAXdgY3gpIYNpVU9Fj+j8wdcVix0g
 0I9i8KYAXy0yksc/oGSS6J5LPLn6khCV76+t4SpJ5XaxETa8Q+0MCLg+k1xauNqqojHJ
 5Op8gjNp05kaYTJs2GkdOxl0hXNYQpggWrg/5oCOMkSzFOjxqXDqyoBX5H+GKbkeBWi+
 RjVOqCiRssr7nF5bobKTwHWNm7nEIlwuW5FVryjjO44xtujXcA53dSnujUyBoXjPiOP6
 j/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524784; x=1775129584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cFWBGqsD+OTQvIlTBc+s/7XQkE8V29leRTjwPnyysws=;
 b=j4A819dbwhpYKff9RlNevYhfqAgUPng4uHyqFTaAfiXUQe6hjSknmk3KNVzMBResMx
 yjNwR+3Q8B5wg0KKAJ4aTtRdT1LBWSxOF0y1RVue8wfx0zU+hk6za+JjmlWwF1X7QkUG
 k50t/0v6XeQJ7QeT+RB53avV2/4uYpf9tir0vtFyciAEs+Inn8k1WRazH3JpxWfKPFWM
 YGEINl9LdfkIoS43VTegljtvZT3RbSlQmn4h9k5sB/UonZx1MhrAy/3RZSWrM7MKapIS
 90jHSAyMhcR/ggjBqPFe4NiaOx1k+1cGM9GrKusL6tR1QtvHLoNFey1aAX2dyoDgB1M/
 XYAw==
X-Gm-Message-State: AOJu0YyTMUcKz9XgH8jQ/KceKSH9eaYiTN0BFRHoJCHd5jvJ3SeCHGEM
 wYFsK6IJvZCoE13EhuT3Z+1Rnh9vHo5avK6d1u/pd7d7cTKbcFIE2y/YhgPpPDdADNNcG1irAz8
 HzQfmcN06gMt79BMOEqpbLrxN+72QqjZ+NcaInQLycxJt0D9mcN0EfTFxnGi1RjwyLd5mkrl2LB
 pZWr2OiJK4TxGvpRI0osQklPZrJRDwXhE=
X-Gm-Gg: ATEYQzz5aDCY3vo49LRUeoyUhvkqq2/O9FTRbTqEeezv0U0e48YG83Ll9lF6kWEBMTw
 K7TudIuxGs/fMFgdpFyjw+zIz5PxO3Ujt8uN18hKLb30/pMuI30amotfuyqJeVVzInYOOPGur9z
 ORSsstOWUID7uqSVjz4LkblRfZc50RRMWPjTOo4B+KMLqBuS2KOnsIQ7+/Yv5cD3vupk/tTDq4L
 eA2JhaMM2BivPcZ5EByuncWuBIabRiyi2IrHMTuDUGel1r16XCB/+SJcBfVaBhacg==
X-Received: by 2002:a05:6a20:914a:b0:39b:edcd:d92f with SMTP id
 adf61e73a8af0-39c4aa68829mr7530156637.11.1774524784207; 
 Thu, 26 Mar 2026 04:33:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:914a:b0:39b:edcd:d92f with SMTP id
 adf61e73a8af0-39c4aa68829mr7530117637.11.1774524783773; Thu, 26 Mar 2026
 04:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-6-armenon@redhat.com>
 <177452442287.34609.2774813943061790610.b4-review@b4>
In-Reply-To: <177452442287.34609.2774813943061790610.b4-review@b4>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 26 Mar 2026 15:32:51 +0400
X-Gm-Features: AQROBzAcffHOHf04na0eJesYrf_g-KvTNiw2afKjSXXw0v3IrE21R-rZdAKUSpI
Message-ID: <CAMxuvaye8FiT2JeCV3N09pVX57ebKLvZPM4DQ2AhW_TUWmCUcg@mail.gmail.com>
Subject: Re: [RFC v2 5/7] test/qtest: Add test for tpm crb chunking
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi

On Thu, Mar 26, 2026 at 3:27=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> On Thu, 19 Mar 2026 19:23:14 +0530, Arun Menon <armenon@redhat.com> wrote=
:
>
> Hi
>
> >
> > diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> > index 2cb2dd47961..dfc1fd70b7f 100644
> > --- a/tests/qtest/tpm-util.c
> > +++ b/tests/qtest/tpm-util.c
> > @@ -14,16 +14,42 @@
> >
> >  #include "qemu/osdep.h"
> >  #include <glib/gstdio.h>
> > +#include "system/memory.h"
>
> Use qemu/bswap.h instead
>
> >
> >  #include "hw/acpi/tpm.h"
> >  #include "libqtest.h"
> >  #include "tpm-util.h"
> >  #include "qobject/qdict.h"
> >
> > +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> > +#define CRB_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> > +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
>
> Shadows tpm.h macro. Use CRB_ADDR_CTRL_STS ?
>
> > +
> > +#define BIT_START_INVOKE  (1 << 0)
>
> Similar (although in tpm_crb.c unit)
>
> > [ ... skip 11 lines ... ]
> > +            break;
> > +        }
> > +        if (g_get_monotonic_time() >=3D end_time) {
> > +            break;
> > +        }
> > +    }
>
> Consider adding a g_assert() here
>
> > @@ -31,24 +57,74 @@ void tpm_util_crb_transfer(QTestState *s,
> > [ ... skip 30 lines ... ]
> > +
> > +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> > +
> > +    for (size_t i =3D 0 ; i < req_size; i +=3D chunk_size) {
> > +        bool last_chunk =3D false;
> > +        size_t current_chunk_size =3D chunk_size ;
>
> Trailing whitespace before the semicolon.
>
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
> > +            qtest_writel(s, CRB_ADDR_START , BIT_START_INVOKE);
>
> Trailing whitespace before the comma.
>
> Style: should be tpm_sts per QEMU naming conventions.
> Style: declarations should be at the top of the function.
> Same: declaration mixed with statements.
>
> Style: should be tpm_sts per QEMU naming conventions.
> Style: declarations should be at the top of the function.
> Same: declaration mixed with statements.
>

This is the first time I used "b4 review tui", this is strange. I'll
check what happened :)

I'd recommend others to try it, especially those like me who lack a
good "all-in-terminal" workflow for reviews.


