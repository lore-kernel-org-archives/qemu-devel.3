Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD08FCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 21:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5zH-0005xa-PR; Tue, 09 Sep 2025 17:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw5zF-0005x9-9P
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw5z5-0007e3-K1
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757453672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyfRiMuu99hZlnfL/4N0gyRNLF22iv7sfeQeqU+5yRk=;
 b=erLgQ2k7G1sjYRDZt/dGslKCuhexKytxeeIBjnafOAa2Zvny6SXFB6NoIJBZ+JS3wplE1n
 AbkrnFRClKSfVlspGuBA6zITLr13A2g49dImvuM/GwM9K2FxL7/JDzgP5G9wjfO12p2y4n
 xtATdNf2QXXeJpXYGSxSO9lD4hmEYo8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-bf65dg7sPtey15Orcjbohg-1; Tue, 09 Sep 2025 17:34:30 -0400
X-MC-Unique: bf65dg7sPtey15Orcjbohg-1
X-Mimecast-MFC-AGG-ID: bf65dg7sPtey15Orcjbohg_1757453669
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b32d323297so143301581cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 14:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757453669; x=1758058469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyfRiMuu99hZlnfL/4N0gyRNLF22iv7sfeQeqU+5yRk=;
 b=Sx5wbgdiqSDA19PIlx+meYMrcNPEvL6RtKatgArR+Uy1ek29/kfphUfZIx11Fiz80M
 g7qMDPt//gVmiKCcvljI9HF4d6+h1c7Y3JXRucA4lETkK5ve0zyffMQDpXQrOHbk5cOm
 bvAXMMA6VCe+oPtUVssoyTk2vXQhWlmSfXYlGfgKz/2Ix5sWipAdKRxc22UeRMpybh5d
 Bd7/EGJP2k6miK8eo/u7NQPtFQ4cBJM61UeX6CYZ60I/eRAnuJF12gjpPD+xbKupvL3R
 VG/WCf6N3BjPd5GzmADcL51sdAN4lJZ+Ql4WOHwmzKgUl0Iwx4nE77rdVDQ8dq32YiCC
 +Cag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPOI6pcy8hob574PI69xRa5as/YgpiJ4VSQLRyRD2OQ1qS1+H0UjeK5Ax+mBs/Si2ZsOijByHELVxS@nongnu.org
X-Gm-Message-State: AOJu0YwAnQPkm6amRxKK7WEZKx33wGVKrEcjslMxIW6I7FqT2vsCJNOo
 ti/kXCAuFGn8wSm8nNnVUUMuSwla42aNHtTCYwPLj/Osf4LbPhudp4lo+rft/RCJkLonOK+4bgM
 KZe/5pNAmRdMAqOt8kv+e9qcfwvAGxYnvuzRzmXct6JCVhOLUK5rRqc6j
X-Gm-Gg: ASbGncvIW0coTMNM0qb2slFjcvb8S0m00+hN0HPNMP3znZIgmLBXvb3r8Y4mO8tUsV9
 XuJW2bM+TXFAcxK+GCX1QkfaD6tmzaF8VfDhfrRk9U6Co4NhDVu0dyzXPfcDQVa9L5kfGLz+D04
 Xm7O43pw790IhGQCsLmdGFRnklEA1q8qooKuN0gY6s+84LFLgEpvxt+Q9lm2xKCK19vsZBNqoiJ
 XvOeem3rjA+Xo34DqpVlJjTi345bLPyAmVR90C3tV7U4XmLAkHLsJAjtP71j697214Nw/C24ea9
 2x1G17HTujA/MpgwmYyF3BGv6c0VYzsBetBVTru39aDOVGfDhXSttUCBrGiLi3mmUIqKr/0b8it
 1QuN3YMv6XmiWmAkBFnAOIA==
X-Received: by 2002:a05:622a:1825:b0:4b3:d14:ddc6 with SMTP id
 d75a77b69052e-4b5f83860f8mr129298311cf.11.1757453669288; 
 Tue, 09 Sep 2025 14:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlgpnXav6OEuY5LQvyuPZJBHPkUGmlY/4osD9yeFVjpoazCpTWrrVr08houDFP5f1n3psVbQ==
X-Received: by 2002:a05:622a:1825:b0:4b3:d14:ddc6 with SMTP id
 d75a77b69052e-4b5f83860f8mr129298031cf.11.1757453668893; 
 Tue, 09 Sep 2025 14:34:28 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b58c52cd3sm182715485a.5.2025.09.09.14.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 14:34:28 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:34:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/3] hw/intc: Save timers array in RISC-V mtimer VMState
Message-ID: <aMCdYUZyQWQ4Qc4v@x1.local>
References: <20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com>
 <20250909-timers-v1-2-7ee18a9d8f4b@linux.alibaba.com>
 <aa5ea2e9-8d01-4d45-99fc-efa5e6061c8b@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa5ea2e9-8d01-4d45-99fc-efa5e6061c8b@ventanamicro.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 09:45:07AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 9/9/25 6:46 AM, TANG Tiancheng wrote:
> > The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
> > timers functional after migration.
> > 
> > If an mtimer's entry in 'mtimer->timers' is active at the time the snapshot
> > is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
> > 'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.
> > 
> > During snapshot save, these active timers must also be migrated; otherwise,
> > after snapshot load there is no mechanism to restore 'mtimer->timers' back
> > into the 'timer_list', and any pending timer events would be lost.
> > 
> > QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
> > and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
> > with variable length, and vmstate.h did not previously provide a helper
> > macro for such type.
> > 
> > This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
> > and restoring a variable-length array of 'QEMUTimer *'. We then use this
> > macro to migrate the 'mtimer->timers' array, ensuring that timer events
> > remain scheduled correctly after snapshot load.
> > 
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> > ---
> 
> LGTM but I wonder if changing one of the VMSTATE_TIMER_xxxx macros to accept
> variable length arrays is better than creating a new macro that only RISC-V
> cares about. Creating a new macro surely is easier and less messier than
> changing all existing callers though ...
> 
> I'll let the migration folks weight in. Thanks,

I didn't see a 2nd user, though..

I'd split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch, then
define VMSTATE_TIMER_PTR_VARRAY() in riscv .c files if that's the only
user, and if that helps readability.

Thanks,

> 
> Daniel
> 
> 
> 
> >   hw/intc/riscv_aclint.c      |  6 ++++--
> >   include/migration/vmstate.h | 14 ++++++++++++++
> >   2 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> > index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f656177f0dd82a45 100644
> > --- a/hw/intc/riscv_aclint.c
> > +++ b/hw/intc/riscv_aclint.c
> > @@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
> >   static const VMStateDescription vmstate_riscv_mtimer = {
> >       .name = "riscv_mtimer",
> > -    .version_id = 2,
> > -    .minimum_version_id = 2,
> > +    .version_id = 3,
> > +    .minimum_version_id = 3,
> >       .fields = (const VMStateField[]) {
> >               VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
> >               VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
> >                                     num_harts, 0,
> >                                     vmstate_info_uint64, uint64_t),
> > +            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
> > +                                     num_harts),
> >               VMSTATE_END_OF_LIST()
> >           }
> >   };
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..255e403e5a103188712425d95a719d181e1a7202 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
> >       .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
> >   }
> > +#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
> > +    .name       = (stringify(_field)),                                    \
> > +    .version_id = (_version),                                             \
> > +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
> > +    .info       = &(_info),                                               \
> > +    .size       = sizeof(_type),                                          \
> > +    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
> > +    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
> > +}
> > +
> >   #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
> >       .name       = (stringify(_field)),                                     \
> >       .version_id = (_version),                                              \
> > @@ -1035,6 +1045,10 @@ extern const VMStateInfo vmstate_info_qlist;
> >   #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
> >       VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
> > +#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
> > +VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
> > +                                                        QEMUTimer *)
> > +
> >   #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
> >       VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
> > 
> 

-- 
Peter Xu


