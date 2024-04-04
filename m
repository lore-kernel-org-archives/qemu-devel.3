Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B7CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 20:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsU8g-0007tf-B4; Thu, 04 Apr 2024 16:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsU8e-0007tS-Om
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 16:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsU8c-00034G-MU
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 16:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712264205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvu0OY265NY1jxyaF6kineaC0TrX9+hJLcouQKuUNjY=;
 b=FkBpzywyGFNWfa3XkYugp6iAb0wBYCKrRAFj8Rw361UzahqY2KeiU95UpcaDz5hYYs91lu
 8fgWLCi0GyRH4p+8qNPjeXVBCc8w29EN/YC7/gYVCIpc8lw+bXzeMcvBNvvrUNGTBuuXpZ
 kl4rwfxYU3qcfWnJdXFRRmaycYoddLo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Umyrz1UHOV2tZ9xa1GwvWA-1; Thu, 04 Apr 2024 16:56:43 -0400
X-MC-Unique: Umyrz1UHOV2tZ9xa1GwvWA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6993e4680d7so112656d6.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 13:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712264202; x=1712869002;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yvu0OY265NY1jxyaF6kineaC0TrX9+hJLcouQKuUNjY=;
 b=ACJOSm/axtFHatifyTZwB/LOWPBt/UqnWZeuQM92nF2IV4kyagEZjumHYb7J///BAS
 oEi59m4F5yqXiDOSDyDBhnP684zvJlmexeL6qfpju2Mw5bmspoxnF8ECz4Gp4zBLMlc7
 X0TMQ6BiJDBOxY3kJ6HIh898ebSVdmoBD5uio4RJm/r+ySN9+r7LR18SkzPKWm0iPPhC
 w0RH1oLV9TX522DLZpu3yn/SCytlG1y64XGeG/pdjCX/3totWJCJ/Qmb2NZyHR7ZzOlc
 SZTModwPaDjQZ65wPea4oIeDQX/C+slr36p8XFJilKhrdeZtIXFTqNV7JjeDvJRasvBG
 XShg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9VAtvd0YjhpOpRZKehHZs4dcQF5Glw2S5rOP5YM1QL7S76GnibWGdVBDmy/6wPvzfK88ddFS4VASn0a5gLh9TJoPB6e4=
X-Gm-Message-State: AOJu0YzjBeVQMvtLe6+2PDLw2EoqUNBur1b46GWz3rN9BieA1OveAxck
 /Yu5+sZv7qWn5U9f+kovamu5APFzCYqKsVtvUqemkPiehBaMRLUs/onRlmxWDEvdN9udJGvacLH
 McMSv0txOKRikWz25fnBMNGdPatYKpUWxefIQ+G6TTjsitTKqyeFi
X-Received: by 2002:a05:620a:4006:b0:78b:ea64:e0fa with SMTP id
 h6-20020a05620a400600b0078bea64e0famr3917148qko.4.1712264202317; 
 Thu, 04 Apr 2024 13:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRkb28GXeEwl+fBLHkPheafZFDZHDQlGUrhOjFNKPLuLuYbsNI8O/B/4T7XelIByAojZUcrw==
X-Received: by 2002:a05:620a:4006:b0:78b:ea64:e0fa with SMTP id
 h6-20020a05620a400600b0078bea64e0famr3917124qko.4.1712264201635; 
 Thu, 04 Apr 2024 13:56:41 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 da35-20020a05620a362300b00789e1c94cf4sm74868qkb.113.2024.04.04.13.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 13:56:41 -0700 (PDT)
Date: Thu, 4 Apr 2024 16:56:39 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Message-ID: <Zg8UB900V4NpTwNG@x1n>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
 <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Apr 05, 2024 at 12:48:15AM +0800, Wang, Lei wrote:
> On 4/5/2024 0:25, Wang, Wei W wrote:> On Thursday, April 4, 2024 10:12 PM, Peter
> Xu wrote:
> >> On Thu, Apr 04, 2024 at 06:05:50PM +0800, Wei Wang wrote:
> >>> Before loading the guest states, ensure that the preempt channel has
> >>> been ready to use, as some of the states (e.g. via virtio_load) might
> >>> trigger page faults that will be handled through the preempt channel.
> >>> So yield to the main thread in the case that the channel create event
> >>> has been dispatched.
> >>>
> >>> Originally-by: Lei Wang <lei4.wang@intel.com>
> >>> Link:
> >>> https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel
> >>> .com/T/
> >>> Suggested-by: Peter Xu <peterx@redhat.com>
> >>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >>> ---
> >>>  migration/savevm.c | 17 +++++++++++++++++
> >>>  1 file changed, 17 insertions(+)
> >>>
> >>> diff --git a/migration/savevm.c b/migration/savevm.c index
> >>> 388d7af7cd..fbc9f2bdd4 100644
> >>> --- a/migration/savevm.c
> >>> +++ b/migration/savevm.c
> >>> @@ -2342,6 +2342,23 @@ static int
> >>> loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
> >>>
> >>>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
> >>>
> >>> +    /*
> >>> +     * Before loading the guest states, ensure that the preempt channel has
> >>> +     * been ready to use, as some of the states (e.g. via virtio_load) might
> >>> +     * trigger page faults that will be handled through the preempt channel.
> >>> +     * So yield to the main thread in the case that the channel create event
> >>> +     * has been dispatched.
> >>> +     */
> >>> +    do {
> >>> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> >>> +            mis->postcopy_qemufile_dst) {
> >>> +            break;
> >>> +        }
> >>> +
> >>> +        aio_co_schedule(qemu_get_current_aio_context(),
> >> qemu_coroutine_self());
> >>> +        qemu_coroutine_yield();
> >>> +    } while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done,
> >>> + 1));
> >>
> >> I think we need s/!// here, so the same mistake I made?  I think we need to
> >> rework the retval of qemu_sem_timedwait() at some point later..
> > 
> > No. qemu_sem_timedwait returns false when timeout, which means sem isn’t posted yet.
> > So it needs to go back to the loop. (the patch was tested)
> 
> When timeout, qemu_sem_timedwait() will return -1. I think the patch test passed
> may because you will always have at least one yield (the first yield in the do
> ...while ...) when loadvm_handle_cmd_packaged()?

My guess is that here the kick will work and qemu_sem_timedwait() later
will ETIMEOUT -> qemu_sem_timedwait() returns -1, then the loop just broke.
That aio schedule should make sure anyway that the file is ready; the
preempt thread must run before this to not hang that thread.

I think it more kind of justifies that the retval needs to be properly
defined. :( It's confusion is on top of when I know libpthread returns
positive error codes.

Thans,

-- 
Peter Xu


