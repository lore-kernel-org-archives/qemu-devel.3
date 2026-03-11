Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C101125856
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NMj-0004Yu-LB; Wed, 11 Mar 2026 13:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NMa-0004Xn-74
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NMV-0008Qd-1G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773250123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnz4C0Vu9SNNJwYnwm6nhcbjSmXEfRPtDa4QWf3Ulc0=;
 b=Y98B1ZMH5a63yStvvGeTnbRGYkJB0CNtyd87e9Mh7/GfkgKNTAi3QdQopRQZkPHi3Mp8I9
 EBt4tXR3Jkg1TiDgeFY94d2fJyQ8r2UbQ7v8rd2Lh7DkHVTSuQoVbP1g0BRkbR1w+FhF1b
 8NuGEXd8NaSy3j9G5RHN/RA5WfLTgfY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-V1pZfr2ENculHhCM2wchjQ-1; Wed, 11 Mar 2026 13:28:40 -0400
X-MC-Unique: V1pZfr2ENculHhCM2wchjQ-1
X-Mimecast-MFC-AGG-ID: V1pZfr2ENculHhCM2wchjQ_1773250119
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd81ce6fdcso47232985a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773250119; x=1773854919; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wnz4C0Vu9SNNJwYnwm6nhcbjSmXEfRPtDa4QWf3Ulc0=;
 b=JsKzOzcpR9RU1gLyyoWKRBk5I35W9aKZMT+rQaYUG9AMuWLJ58zrvlsu94XSVyNWda
 LZ3JXRFCzP/mPJJ6UTW668yDbSYiFWm7SwsDcc3p3WAKapo6CYEZeucGEhJoSFdPXpCh
 7M4dvTr9HKNyOWkdJz9y1nQYba+zcpYDebTC7hjCTBdOoxaNEu7oiMi2Ifh9FvS9E5yh
 jjuVJ84t/HGv4yx5mrKtnCa8mXku5j+N3aS8nm6xqBt7zSgiap+ANP4kIhKZZNd5EM6A
 JUHL5iYACOcFXeg+vU7XI2MsKSF8f982l5WMRMbmPdebk2dNnin5igESxkzg7zdEWwCx
 zYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773250119; x=1773854919;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wnz4C0Vu9SNNJwYnwm6nhcbjSmXEfRPtDa4QWf3Ulc0=;
 b=eSQiGpCUk+lhrVxO1X1hxpzSxsO2zcierMv88l5rWkk8U+Jz5YSrVP2WCyYei3HVNt
 DOz4MdHBw5MmFyDBJEZ0sbIy2cS9cWk8L2h9H7DSmuBeQd2AB7I1fW4QR+BtZE6e5FrZ
 cH8dv0mgykU8M9wWUtLHA33/+vMa2yhiGwLV+6iRWTDWM1CfDjh3HPscTRKvp3Dau0I5
 N7DMfXq2EHUxD1H8g/TKM3XMvlyKfW7K3E0pqLKfE4zTYI1mCLNbPNgkdCakWS/P1uUW
 I4KE9XQHoM3vPDS7ZCfE7LH7926SnNp9XD5VijTd0YXuMMU30PEPjAjphS14MN7AGfWq
 My7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU480RU21bMcHWPVNg5ianSUh+UKexD2oHdECbmdeVJOtwwed+fq2D4Q05jZeHcl5ZTVsxQyrtQcexa@nongnu.org
X-Gm-Message-State: AOJu0YwXvl3oOc1AecArn2iU4lySKuilrv+iv04llwRYfel6EQxHGSCG
 iXnve3Msq80cxILJiWvABkt24Is7ZDfkBD6YK1EVC+ar34DPorvbUXOvkEPU+QM3ZeztLFc2sz2
 aduAr0euFQTZZDavlQtaekeVdbrte/Ltk/615rmoCyQsBAxA+U1v4FTMW
X-Gm-Gg: ATEYQzzaInwUo8u9DFhExwUNk3jVuecxWfSeDjV6svHZJXayGEZOWBYeEkVYQfCQ020
 JOYMI6mE8LuZw0qiRw522F65KKt3iWdf7pAkBJcV+2M5V4z6sudWYkgPHa7OsG7MUJ98w5T70RZ
 /zQfYk9+zE8lmzoGLlstdDeRt5NSt0HTy76zTl+t1BqQ4xGejNYkcV9fXpIA13hnFsdIy8Kk65J
 O0WviY9HvOa6ud63lycirHqv0r55sifueexdo8g+RMo0nWsliAHl9XS5e5nCgJ4A4NkrEMML4VT
 ERGIEr+z16805YGcWkxA7I+My+lQ/P+b98wgmc23guWN+j+SPj88QynukPJHzlhMRemy1r9o+Hn
 RH5JvwcOqgzPTpw==
X-Received: by 2002:a05:620a:2916:b0:8cd:8ddd:2699 with SMTP id
 af79cd13be357-8cda1956f9fmr432331685a.24.1773250119331; 
 Wed, 11 Mar 2026 10:28:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:8cd:8ddd:2699 with SMTP id
 af79cd13be357-8cda1956f9fmr432327885a.24.1773250118872; 
 Wed, 11 Mar 2026 10:28:38 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1ff4a8bsm181855685a.20.2026.03.11.10.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 10:28:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:28:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <abGmRItAZiiRIeIY@x1.local>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
 <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com> <aa8Pvd5O-OLKIXam@x1.local>
 <abFZvUoinIjfMlNX@redhat.com> <abGKkoFfy1RILXA0@x1.local>
 <abGesQMQuVSYJy1W@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abGesQMQuVSYJy1W@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 04:56:17PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 11, 2026 at 11:30:26AM -0400, Peter Xu wrote:
> > On Wed, Mar 11, 2026 at 12:02:05PM +0000, Daniel P. Berrangé wrote:
> > > On Mon, Mar 09, 2026 at 02:21:49PM -0400, Peter Xu wrote:
> > > > On Mon, Mar 09, 2026 at 05:51:29PM +0000, Daniel P. Berrangé wrote:
> > > > > On Mon, Mar 09, 2026 at 05:42:08PM +0000, Tejus GK wrote:
> > > > > > 
> > > > > > 
> > > > > > > On 9 Mar 2026, at 10:47 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > > > 
> > > > > > > !-------------------------------------------------------------------|
> > > > > > >  CAUTION: External Email
> > > > > > > 
> > > > > > > |-------------------------------------------------------------------!
> > > > > > > 
> > > > > > > On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> > > > > > >> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > > > > > >>>> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > > > > >>>>         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > > > > > >>>> 
> > > > > > >>>>         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > > > > > >>>> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > > > >>>> -            sioc->new_zero_copy_sent_success = true;
> > > > > > >>>> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > > > >>>> +            sioc->zero_copy_fallback++;
> > > > > > >>> 
> > > > > > >>> ...this is counting the number of MSG_ERRQUEUE items, which is not
> > > > > > >>> the same as the number of IO requests. That's why we only used it
> > > > > > >>> as a boolean marker originally, rather than making it a counter.
> > > > > > >> 
> > > > > > >> Would the logic still work and better than before?  Say, it's a counter of
> > > > > > >> "messages" rather than "IOs" then.
> > > > > > > 
> > > > > > > IIUC it is a counter of processing notifications which is not directly
> > > > > > > correlated to any action by QEMU - neither bytes nor syscalls.
> > > > > > 
> > > > > > Please correct me if I'm wrong about this, isn’t each notification an information 
> > > > > > about what happened to an individual IO?
> > > > > 
> > > > > If userspace hasn't read a queued notification yet, the kernel will
> > > > > merge new notifications with the existing queued one.
> > > > > 
> > > > > The line above your change
> > > > > 
> > > > >   serr->ee_data - serr->ee_info + 1;
> > > > > 
> > > > > records how many notifications were merged, so we now how many
> > > > > syscalls were processed.
> > > > > 
> > > > > If ee_code is  SO_EE_CODE_ZEROCOPY_COPIED though it means at least
> > > > > one syscall resulted in a copy, but that doesn't imply that *all*
> > > > > syscalls resulted in a copy.
> > > > > 
> > > > > AFAICT, it could be 1 out of a 1000 syscalls resulted in a copy,
> > > > > or it could be 1000 out of 1000 resulted in a copy. We don't know.
> > > > > 
> > > > > IIUC the kernel's merging of notifications appears lossy wrt this
> > > > > information. It could be partially mitigated by doing a flush for
> > > > > notifications really really frequently but that feels like it would
> > > > > have its own downsides
> > > > 
> > > > IMHO what this change does is removing the false negatives.
> > > > 
> > > > Before this patch, if QEMU reports fallback=0, it doesn't mean all the
> > > > MSG_ZEROCOPY requests were all fulfilled by zerocopy.  It's because we
> > > > justify it with one boolean over "a period of time" between two flushes, we
> > > > set the boolean to TRUE as long as there is _one_ successful report of
> > > > MSG_ZEROCOPY.  So even if every flush reports TRUE it only means "there is
> > > > at least one MSG_ZEROCOPY request that didn't fallback".  It has no
> > > > implication of whether a fallback happened.
> > > > 
> > > > Hence, before this v2 patch, there can be false negative reported by QEMU,
> > > > assuming there's no fallback (reflected in stats) but it actually happened.
> > > > 
> > > > After this patch, if QEMU reports fallback=0, it guarantees that _all_
> > > > MSG_ZEROCOPY requests are fulfilled with zerocopy.  It's because we monitor
> > > > all messages and accumulate any fallback cases.  Even if the messages can
> > > > be merged, when "fallback" shows anything non-zero would imply some
> > > > fallback happened.  Here, the counter value doesn't really matter much
> > > > IMHO, as long as it becomes non-zero.
> > > 
> > > AFAICT, the v1 of this patch was sufficient to address the original
> > > bug and maintain the current intended semantics of the migration
> > > counter. This v2 is mixing a bug fix with functional change in
> > > behaviour and I don't think the latter is justified.
> > 
> > It's just that when it cannot report all fallback cases, I don't yet see
> > how it would help much even if we fix the previous behavior with v1..
> > 
> > OTOH, the new behavior will be deemed to have no issue on the problem v1
> > was fixing.
> > 
> > So IIUC v2's behavior is the one we want, and helps identify fallback
> > happened.
> 
> I don't consider v2 acceptable as the value its returning is an
> meaningless counter that doesn't correlate to any quantity that
> is used by QEMU, nor visible to users of QEMU.

It can be a boolean if we want showing "if any fallback happened", that'll
at least make it accurate and avoid false negatives. But IMHO a counter is
always better, e.g. when we dump it from time to time we know if any more
fallback happened.

In that case, no matter how that counter is defined in granularity that'll
help, as long as it get boosted when fallback happened.

I also don't expect this value to be consumed by an user, but only reported
by an user and should only be consumed by a developer.

Thanks,

-- 
Peter Xu


