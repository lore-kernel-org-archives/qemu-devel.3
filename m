Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98E1C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujtmW-00079R-24; Thu, 07 Aug 2025 02:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtmJ-00076M-MO
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtmF-00085b-QR
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754546816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4CmV5YASTUZprXp5ORNdpqU8Pxy4LKF5SrvfpyfSnQ=;
 b=hQmPTn+8AS7E/UsmFKLRVZ/liK67iPeruZ4Sjl04CCWrRwc2gPswDU33607yYlkNKS8yjl
 ruZ/AWNje+XROcujsoQUdCvO+2U/nbIY4kVesL/Oc2LjA3iyL48Ypy1vp2cSOyl2Jc4hln
 jPmTsbUQ5//qhWSI9xYQfyGr9JPGXW8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ph7qWKKyN5yxUrr6EK-W7g-1; Thu, 07 Aug 2025 02:06:55 -0400
X-MC-Unique: ph7qWKKyN5yxUrr6EK-W7g-1
X-Mimecast-MFC-AGG-ID: ph7qWKKyN5yxUrr6EK-W7g_1754546814
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e348600cadso165394785a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 23:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754546814; x=1755151614;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4CmV5YASTUZprXp5ORNdpqU8Pxy4LKF5SrvfpyfSnQ=;
 b=YIVkuVcofhVX2JisalCdpEm4b+kJTgNnl7nwUuKh1XU1dQpda8Dl9qBHFm5ti7aDE1
 Y3LoV1SDZrdno0OPSW+HS1yDW4xLX9blXSe7VHzZcrLFOCpomtD+7/IhYXPe4y80fLGL
 fMqQu53oT27IXi8LNE+JBa7Ynq30/YlsHpoB6iEZA1IiNOSXmrgJPs65QNsIiHGmVdqc
 CoxJvGiO0Dv62zmemwhA3SWz2e8YIWk95ngVFf+YvAGDJXrrsd7SaZahASyshXVo5whh
 vCJt6XquGnpFillrsUNc6HvYaqxMciQhTkNy+UBgmFC0st3jonrQzLtxZ30pLILeyxUo
 f7Sw==
X-Gm-Message-State: AOJu0YwSuK+IfrYyfQRFGPOVkMIP9+jyimbBtoyEMIaMdO5RG8SJLHfl
 IWRz3ND5SFNbhF2xHMtO9TPm/h5MgQICRzVqRWTxvo6ZZVew5Iw9234p4LBD2AKAzTXSM3R9kBJ
 GBMICfsE0a5oJQhNvsNbvjVNGRErWsN0l01f+rHBjWxL3manXEaPobQj+
X-Gm-Gg: ASbGncu58v0Uzu37US11939qkNEtCUBqJ+hjRrVlfydd32Nk+YxXFZJhho0mUZzEBTg
 KUxjUh8srCRcTfFeijKo/lF7LKMvEg3FltbdbE3AaPC0rR5Uhb+kJgW6yY/6oK03L6oRe0mUin8
 YAqFL02SezjH9NZWL9iGHMPI/a/rmOvSWPZGEFaEL59Az/GTiAdRhS1FXSMN8vIR2bFWBEVuEUv
 PNGWMneLQuD2FSNSixhvhfskS/7QoTrFrm2mGeYpuMI/+JiI+hHlHmGTcY9kbYUxTZV1YM7rNfT
 2BXezV2fB38M/34emZhGH4RnilTLGUeqtsUHxVentTh7catv9OE=
X-Received: by 2002:a05:620a:ab06:b0:7de:fa4b:773f with SMTP id
 af79cd13be357-7e82080d982mr262221185a.17.1754546814425; 
 Wed, 06 Aug 2025 23:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqi4mzQoa29gR6lnFyd/gZIarpKyFPyEz/b6dIE9mrXZLJuv/CbyD9ByJJWgVNdm8gUx8zg==
X-Received: by 2002:a05:620a:ab06:b0:7de:fa4b:773f with SMTP id
 af79cd13be357-7e82080d982mr262219285a.17.1754546813964; 
 Wed, 06 Aug 2025 23:06:53 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.53])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e7fc4db4bdsm513631785a.28.2025.08.06.23.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 23:06:53 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:36:35 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 18/27] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
Message-ID: <aJRCa94RnXGdTfeM@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-18-123450810db7@redhat.com>
 <CAMxuvay5ysmMXw14SBZtY7M2mJdoq4Fk2MYD-JjXurBCPZwLEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvay5ysmMXw14SBZtY7M2mJdoq4Fk2MYD-JjXurBCPZwLEQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,

Thank you for the review.

On Wed, Aug 06, 2025 at 11:54:36AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:30 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_postcopy_ram_handle_discard() must report an
> > error
> > in errp, in case of failure.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> >
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 
> > ---
> >  migration/savevm.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > eb90873a750ded354b3db31cba40b44d1be79864..3abe4193e02aae9c813ff07fb388a7ee470c8a6a
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2004,7 +2004,7 @@ static int
> > loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> >   * There can be 0..many of these messages, each encoding multiple pages.
> >   */
> >  static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> > -                                              uint16_t len)
> > +                                              uint16_t len, Error **errp)
> >  {
> >      int tmp;
> >      char ramid[256];
> > @@ -2017,6 +2017,7 @@ static int
> > loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >          /* 1st discard */
> >          tmp = postcopy_ram_prepare_discard(mis);
> >          if (tmp) {
> > +            error_setg(errp, "Failed to prepare for RAM discard: %d",
> > tmp);
> >              return tmp;
> >          }
> >          break;
> > @@ -2026,8 +2027,9 @@ static int
> > loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >          break;
> >
> >      default:
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state
> > (%d)",
> > -                     ps);
> > +        error_setg(errp,
> > +                   "CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state
> > (%d)",
> > +                   ps);
> >          return -1;
> >      }
> >      /* We're expecting a
> > @@ -2036,29 +2038,30 @@ static int
> > loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >       *    then at least 1 16 byte chunk
> >      */
> >      if (len < (1 + 1 + 1 + 1 + 2 * 8)) {
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
> > +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)",
> > len);
> >          return -1;
> >      }
> >
> >      tmp = qemu_get_byte(mis->from_src_file);
> >      if (tmp != postcopy_ram_discard_version) {
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid version (%d)",
> > tmp);
> > +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid version (%d)",
> > tmp);
> >          return -1;
> >      }
> >
> >      if (!qemu_get_counted_string(mis->from_src_file, ramid)) {
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock
> > ID");
> > +        error_setg(errp,
> > +                   "CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
> >          return -1;
> >      }
> >      tmp = qemu_get_byte(mis->from_src_file);
> >      if (tmp != 0) {
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
> > +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD missing nil (%d)",
> > tmp);
> >          return -1;
> >      }
> >
> >      len -= 3 + strlen(ramid);
> >      if (len % 16) {
> > -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
> > +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)",
> > len);
> >          return -1;
> >      }
> >      trace_loadvm_postcopy_ram_handle_discard_header(ramid, len);
> > @@ -2070,6 +2073,7 @@ static int
> > loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >          len -= 16;
> >          int ret = ram_discard_range(ramid, start_addr, block_length);
> >          if (ret) {
> > +            error_setg(errp, "Failed to discard RAM range %s: %d", ramid,
> > ret);
> >
> 
> note: the ram_discard_range() and ram_block_discard_range() functions also
> calls error_report()  Maybe they can be converted too.., let's not do this
> in this already long series.

Agreed.

> 
> 
> 
> 
> >              return ret;
> >          }
> >      }
> > @@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f,
> > Error **errp)
> >          return loadvm_postcopy_handle_run(mis, errp);
> >
> >      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> > -        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> > -        if (ret < 0) {
> > -            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > -        }
> > -        return ret;
> > +        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
> >
> >      case MIG_CMD_POSTCOPY_RESUME:
> >          loadvm_postcopy_handle_resume(mis);
> >
> > --
> > 2.50.1
> >
> >

Regards,
Arun


