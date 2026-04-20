Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05343F36C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEn9V-0000DK-7t; Mon, 20 Apr 2026 07:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wEn9U-0000CX-FK
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wEn9S-0008Ai-4j
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776685850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VObyeohGQiUKlOzErRCoy+5mYOCsWgTOjURXsYdCiL4=;
 b=cqnBgPLh+X7Set7UufAV5DntiqR3dvwaQSJlMioXdOA2AK2lM1tGneRpjslviRLzeGAA8m
 oWnPu1W78/KMU2zXR5kjCGw7tQI5B64P1xSBfmplZ3ppetqkF57wxbbUwwM3QOPcmTGm1r
 lCv8y0R/QTnbWhifV0jID0KOazlDKfU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ptyFHBAKMzqi1FGEm9atLQ-1; Mon, 20 Apr 2026 07:50:49 -0400
X-MC-Unique: ptyFHBAKMzqi1FGEm9atLQ-1
X-Mimecast-MFC-AGG-ID: ptyFHBAKMzqi1FGEm9atLQ_1776685848
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bce224720d8so1547008a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776685848; x=1777290648; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VObyeohGQiUKlOzErRCoy+5mYOCsWgTOjURXsYdCiL4=;
 b=er6BPXbJdwqu+UOp0FhbHgYgVV+8Jct0KXa+qPGCTUJ/jv+S05JTT1VGVHqEcFRngd
 SBYqNVoaE2w6y8nsTwqSe6ehF+g68XxTsME22b2M7MI51qG3ntnaI2MmiIPtnGAJ2N0S
 4ji51xcFOdxLHOCC01g4hRwdSv1aOP8KGp64yvNhLjIfjf0uI/lJbYZoDQzVRJ1MG483
 0DGFYvUjrjAK8botfbYMeFa4e+y2Er+D92+Hm6xEbdQfUzvNFMaG1uroH3GJa3pJt5La
 c60BxryYAvMC8A7Zvhh/0pH4uklozx+juU36Z8w2e7Yx+lvgHQzRhUvfNWrTv5U+mzpJ
 RNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776685848; x=1777290648;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VObyeohGQiUKlOzErRCoy+5mYOCsWgTOjURXsYdCiL4=;
 b=L+EdYTpXf53hTqmd039O7Ulu0mQEHNOeUHc+xq9NunV26HtFTjyik2TvTvWC9axLbh
 N3/5vMsRT9yvF0vR+K3iceVVSfGLmboxoMEpKme27llgGp/ss4oqnWO7Y4ZoZxmxoh0c
 A+OremDizDW9K+XPm+5aoQah3jRPb1PRv2mLlhV31sWsgm8FQmK/6LfmLDC/MF/NnOns
 r0qcRiCRYq5JklJluEl3XPY7Qrp1X/YVrBzifcCjIqjliFvLqCMHq17adGJa/T2Ua3Lt
 JF7Gi3UAljKQqLS9ULkeBmgb4sGA4PQqH/sUmN0t9EWbBsOALYMfWZHPO1TFgo93Va7q
 KqmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DbsgZUq5iI38Oiiq/WPvCSm5V7AjegjpRfJzknfqZ7QLXljl4GeaYGSh27sE4LDOWjYkFFSq48j8k@nongnu.org
X-Gm-Message-State: AOJu0YyuwYdAs7m6VRuv5dIXE5niPWEWSGcKyqrSI+596tPYcGbU7Shl
 UAtfg5PQQcpgBjlWG9K03/R7lMYrPzEK9pMrcXYQGSYR1YDOF7/baCkaBzQIVWYL6QJRc1SH3Iw
 HmeUAOEFNo/Tr7F6X6XG/6Gcctgp69hCGzGoQGdzfPaK9Gv0By8/rzw2i
X-Gm-Gg: AeBDieuWwttO3TaE0o8wWzFSAxk5e3PkElL/iMo1OInTqmPoF677JZ1D0+lgxrj58UM
 1GeCG+8l7wcCMnHf5HvYH2WnonoxuZeepNwv5gbce9Vr/n5nlMrXbF7iHnkn5mmdKfbhJKxlGGw
 BTCl/Xl10YjI72cS24KAU9k0KihoVZYGEvWLX+lv2GWZgwfav9Dk+zYV2RzlWLtsstZ2tDKrkxB
 NR1VysbGJttRoCn9Snl9GDjg+FJ3rD3q3BuZrl4g4qYZR/WXAKgSx5+9olHNlbE1L9LCLCjTASs
 /fFKH25t5TfdYpUlOuovPSsI+eJZORAecxwE6Gs0jTS41Jxu6eISiyJ1iE/TVcGllliDFnnJgGA
 9iOw9EkITrQbgzr8KwxNjfw==
X-Received: by 2002:a05:6a20:939d:b0:3a2:dc51:458 with SMTP id
 adf61e73a8af0-3a2dc5107ccmr784387637.41.1776685847841; 
 Mon, 20 Apr 2026 04:50:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:939d:b0:3a2:dc51:458 with SMTP id
 adf61e73a8af0-3a2dc5107ccmr784330637.41.1776685847241; 
 Mon, 20 Apr 2026 04:50:47 -0700 (PDT)
Received: from fedora ([49.36.104.24]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7977031729sm8237166a12.25.2026.04.20.04.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 04:50:46 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:20:37 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
Message-ID: <aeYTDYOQzvYXuay0@fedora>
References: <20260414082915.112122-1-armenon@redhat.com>
 <20260414082915.112122-2-armenon@redhat.com>
 <CAMxuvaw2=uupgJFynh_-2Nkj2VV+V6CqeOOB02A_p0LkOCFy9A@mail.gmail.com>
 <923e81c9-fec4-4526-945d-e4b1b354a416@linux.ibm.com>
 <CAJ+F1CKq=+hRhgHeGP-27tec+ypRGL3OKd2Q70_JoPpYyAA3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKq=+hRhgHeGP-27tec+ypRGL3OKd2Q70_JoPpYyAA3Sg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Marc-André,

Thanks for the review.

On Fri, Apr 17, 2026 at 06:51:14PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Apr 17, 2026 at 6:36 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> >
> >
> > On 4/17/26 6:05 AM, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Tue, Apr 14, 2026 at 12:30 PM Arun Menon <armenon@redhat.com> wrote:
> > >>
> > >> From: Arun Menon <armenon@redhat.com>
> > >>
> > >> - Add new fields to the CRB Interface Identifier and the CRB
> > >>    Control Start registers.
> > >> - CRB_CTRL_START now has 2 new settings, that can be toggled using the
> > >>    nextChunk and crbRspRetry bits.
> > >> - CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
> > >>    this revision of the specification.
> > >> - Refer to section 6.4.2.2 of [1]
> > >>
> > >> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
> > >>
> > >> Signed-off-by: Arun Menon <armenon@redhat.com>
> > >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > >> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >> ---
> > >>   hw/tpm/tpm_crb.c      | 3 +++
> > >>   include/hw/acpi/tpm.h | 5 ++++-
> > >>   2 files changed, 7 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > >> index 8723536f93..0a1c7ecdc6 100644
> > >> --- a/hw/tpm/tpm_crb.c
> > >> +++ b/hw/tpm/tpm_crb.c
> > >> @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
> > >>   #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> > >>   #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> > >>   #define CRB_INTF_IF_SELECTOR_CRB 0b1
> > >> +#define CRB_INTF_CAP_CRB_CHUNK 0b1
> > >>
> > >>   #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> > >>
> > >> @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
> > >>                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> > >>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > >>                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> > >> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > >> +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
> > >
> > > We should not expose that new capability to guests without an explicit
> > > "cap-chunk=on".
> >
> > You mean put this on the QEMU command line? This new capability is
> > really only needed if the user chooses PQC algorithm support (but then I
> > was also going to allow for 7kb writes to NVRAM spaces rather than 1kb
> > writes so far) and if the user chooses a swtpm profile with such support
> > but then fails to set this flag, some transmissions won't work. What
> > would be the problem if we exposed this new feature all the time and if
> > we can avoid state backwards-incompatibilities, which IMO is the most
> > important aspect, if we detect that chunking was not used by the driver
> 
> In general, we shouldn't suddenly expose device capabilities to
> guests. Starting with 11.1 machine, the cap-chunk feature can be
> enabled by default though.

You are right, we do not need to keep track of 2 properties. I will
remove migrate_buffers hw_compat property.

IIUC, you meant we need to expose cap-chunk i.e. remove "x-".
And the whole logic of exposing it based on machine type should also be
moved to earlier i.e. [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
instead of [PATCH v4 06/10] hw/tpm: Add support for VM migration with TPM CRB chunking.

> 
> > and only write additional state if found absolutely necessary? I would
> > prefer to untangle the user's choice of enabled algorithm from the
> > choice of such a flag. But then there's the aspect of OS drivers that
> > could use chunking even when not absolutely necessary (?).
> 

Reards,
Arun Menon


