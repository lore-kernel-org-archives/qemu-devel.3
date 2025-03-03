Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6FBC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp78G-0001nb-P5; Mon, 03 Mar 2025 09:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tp77h-0001K5-BD
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tp77c-00066S-6P
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741013416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Epy205p7t/wZxXA23eqh+oB1II3M+2NGIg2+dviLgM=;
 b=LhrV5Ftt83FA8k8mvmkoiHlEwh9p2ZKyM2tuLiOFds5LDwnWuJNlfM+Y/BiBUlrg1tMZOg
 fCTmPqW6/5tdCb4iK7E2xK2tX/fn1gDfIsF+F5OkwvoZxq2gcAcdKYf7e+G+nXnQmjwTK5
 pSRTXn8EuPYUmUvpxVfyIBqY4QAiMxg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-vpcvZGKCOHa61rV6Gk736A-1; Mon, 03 Mar 2025 09:50:14 -0500
X-MC-Unique: vpcvZGKCOHa61rV6Gk736A-1
X-Mimecast-MFC-AGG-ID: vpcvZGKCOHa61rV6Gk736A_1741013414
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8c2ace94cso42511856d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013414; x=1741618214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Epy205p7t/wZxXA23eqh+oB1II3M+2NGIg2+dviLgM=;
 b=UPSTagiYlNh4ZONXZZKimuKA67yvSsbgnX51h3pqlWqYtoZ6F27HILi4Rv5n7SDPIl
 8Tb7Q9a4zUG0NB7mFH0Sow0Tp2tqp9XivYSwz5MfaxHxmS6yk/ddElRcv6lETFlTeYEr
 aEUkbHsYyoNG4LUdisoJ6z29FaFObiJSv2B5lep5nx8ttJSF+hS4A2Ohc5CFROxObkPB
 w/PPRdQzP952LQQ5bjKIxUppv0BOg5of5FlkLh84Tv0e9OAMEOv9TJvBiaVBVH7fQLYp
 ftN6cvPLie7W6/y8hWAWDq2Teo5EfIFaitnfOEBxcjTJuLLYTfCBJboRfVRc1gP1URuk
 eTzA==
X-Gm-Message-State: AOJu0YwiyYeBCnDrGZBe2pm6f/3pk/kkWnxSMyQNKRZl7kYFl2DaUqNZ
 mexivL8tuBql6oO0KBVlZ3OL4Fso6qocjOqfzeG5avBjEwyZE8PMr1o3gKlbInkFmGc7MS1H7dw
 peApexofzvLCIM6UUwh4GbmP/orYRlAQhNLPf80+WEm+hfWeoNAUl
X-Gm-Gg: ASbGncuQz848UlCzwtWQDv74hbFVY7zuF1lcwBFO9jPdaC6n1nIYY/vZXAaogSWl7XL
 7YjNUoDy+zOk1FyhCS0K+LbTUHXweHPpN/+sc/hrHEqBlBzY1gilXjMjYM8Bxay7ncGzrgPmvsC
 syOPy90QkHZC4cbDdYp43yWDK6sZy3j5zagFcSilqy19W4HKCMESu+Cfznp1I2ZgvWPZFQRQB8V
 RbAvQEgMZiaXB4uKRkNys4UEdOBRy54DFnqo0P2vKvkZO0QYhd839VIVCFiNm5vpSeEeBKE3jLi
 UMs+dv8=
X-Received: by 2002:a05:620a:600b:b0:7c3:c1df:149a with SMTP id
 af79cd13be357-7c3c1df1716mr328790485a.46.1741013414135; 
 Mon, 03 Mar 2025 06:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHppRYSR5vaUv4PXAod8Ym9ytktl8S87G4RD/Dh8ySbAROo/cPqSN3D7RNHNUAZOgbImuS88w==
X-Received: by 2002:a05:620a:600b:b0:7c3:c1df:149a with SMTP id
 af79cd13be357-7c3c1df1716mr328785985a.46.1741013413632; 
 Mon, 03 Mar 2025 06:50:13 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3c267c0dbsm83378985a.63.2025.03.03.06.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:50:13 -0800 (PST)
Date: Mon, 3 Mar 2025 09:50:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8XBowkG72G-l3L4@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 03, 2025 at 05:13:56PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Fri, 28 Feb 2025 at 19:13, Peter Xu <peterx@redhat.com> wrote:
> > We should be able to do multifd's flush and sync before VM
> > stopped in postcopy_start()..
> >
> > What I actually think the easiest is to do flush and sync once in
> > postcopy_start() as mentioned above.  I think that'll serialize with
> > postcopy messages later on the main channel, making sure all channels are
> > flushed before moving to postcopy work.
> 
> * Is there some specific benefit to calling
> 'multifd_ram_flush_and_sync()' from OR before postcopy_start()? Maybe
> that is missing on me.
> 
> * I'll try to explain why adding a migration command makes sense:
> 
>    - I did call 'multifd_ram_flush_and_sync()' before calling
> postcopy_start() in migration_iteration_run(). After flushing the
> 'multifd_send' queue, all it does is send
> 'RAM_SAVE_FLAG_MULTIFD_FLUSH' flag on the main channel. On the
> destination side the 'qemu_loadvm_state_main()' function does not
> understand that message, because it looks for 'section_type'; And when
> it is not able to identify the section, it leads to an error.
> 
>           "Expected vmdescription section, but got %d", section_type(=0)"
> 
>    - ie. multifd_ram_flush_and_sync() is not reusable by itself. To
> make it work, we need to add a (RAM) section header to the message.
> Because then it'll go to ram_load_precopy() and call ->
> multifd_recv_sync_main().
> 
>    - But sending a lone RAM section header from
> migration_iteration_run() OR even in postcopy_start() does not seem
> right. That is out-of-place, because both migration_iteration_run()
> and postcopy_start() have nothing to do with RAM sections.
> 
>    - I think  'flush' and 'sync' ought to be small individual
> functions/operations that are section agnostic. We should be able to
> call 'flush' and 'sync' from anywhere in the code without
> side-effects. So tying 'flush' and 'sync' with RAM sections does not
> seem right, because we need to be able to call 'flush' and 'sync' from
> other parts too, like before calling postcopy_start() OR maybe some
> other code parts.

We need the header.  Maybe the easiest as of now is one more hook like
qemu_savevm_state_complete_precopy_prepare(), and only use it in RAM as of
now.

> 
>    - Another observation is: when multifd and postcopy are enabled
> together and the guest VM is writing to its RAM,
> multifd_ram_flush_and_sync() is called only during setup, not after
> that.
> =====
> 2025-03-02 18:13:26.425+0000: initiating migration
> 2025-03-02T18:13:26.508809Z qemu-system-x86_64:
> multifd_ram_flush_and_sync: called
> 2025-03-02 18:15:20.070+0000: shutting down, reason=migrated
> 
> 2025-03-03 11:26:41.340+0000: initiating migration
> 2025-03-03T11:26:41.415625Z qemu-system-x86_64: info:
> multifd_ram_flush_and_sync: called
> 2025-03-03 11:30:22.766+0000: shutting down, reason=migrated
> =====
> 
>    - If we untie the 'flush and sync' from RAM sections and make it a
> general migration command, we shall be able to call it from anywhere
> else.
> 
> > If you want to stick with shutdown channels, I'm OK.  But then we at least
> > need one message to say "the recv side finished joining all recv threads".
> > That needs to be an ACK sent from dest to src, not src to dest.
> 
> * But earlier we discussed 'flush and sync' is enough for that, no?

Yes it's ok I think, but this patch didn't do that.

+            multifd_send_flush();
+            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
+            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);

I don't think it sent RAM_SAVE_FLAG_MULTIFD_FLUSH.  IIUC you need the
complete multifd_ram_flush_and_sync(), and the new message not needed.

> Because 'multifd_ram_flush_and_sync' only notifies the destination to
> sync multifd_recv threads. It does not receive any acknowledgement
> back.

If my understanding is correct, we don't need ACK.  It will make sure when
postcopy starts all pages flushed and consumed on dest.

Instead of I prepare the patch and whole commit message, please take your
time and think about it, justify it, and if you also think it works put
explanation into commit message and then we can go with it.

> 
> * And multifd_recv_sync_main() function on the destination blocks the
> 'main' thread until all multfd_recv_threads (mig/dst/recv_x) have
> exited, only then it proceeds to accept the incoming new postcopy
> connection.

I don't think it makes sure threads have exited, AFAIU it does not join the
threads, but sync with threads on the per-thread sync messages.

Thanks,

> 
> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


