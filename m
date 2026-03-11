Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AC11125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LWL-00080h-AM; Wed, 11 Mar 2026 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0LWC-0007uJ-JL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0LW7-0004hE-HE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773243034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x06mqwuab/NgXXniKMH8XhjXE/4crP98wDkaDqDe6A8=;
 b=O9rBrqjllWX8JiNhuyik4gWiZxTpsLe490LbLfa4gPlTl3mr7rVLzuLb1W1BYpHwRq7heO
 Jc1QAtFiTLWAr06jIkn0FE5vm7vqzVl7thRvRu03wEvbh89Nh8i5CwU5RQZYQNpaZpX2FA
 Oo/H+u0qrYdY1M58uRZWZO5PqQ0uEMI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-CKV0cQcrP92MQRpJh54D4g-1; Wed, 11 Mar 2026 11:30:30 -0400
X-MC-Unique: CKV0cQcrP92MQRpJh54D4g-1
X-Mimecast-MFC-AGG-ID: CKV0cQcrP92MQRpJh54D4g_1773243029
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd80bea54dso2144924285a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773243029; x=1773847829; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x06mqwuab/NgXXniKMH8XhjXE/4crP98wDkaDqDe6A8=;
 b=YCUtDPg3QWuZnfKa/KuI+d8cO/SvIKaYG/VAtNVwgw8wHGn9bReo2SJ3lS864enIaw
 YDT15ILZXfoj5zOwNfDhJp4QP4njUgM/nYlgzli+AsWWpYLFC6CRqQ7g9JvLvYMl4hxE
 zEQshrFACKThr4b8dh84EnAKy/JxMfZlMsMTRp6zmNeFG+SuaABvOhFDEdsKEF4zT0oJ
 ja8XeuO1Rm4cOBQM7sxUpV6a2J2C0HZpULMWoFPobIaRJ1HJUhfhMR32vSYYCPQU9NOR
 3OVgNqcBqlvC5JFhKYMzs6kLpqrh67oG2+YHt+QqUbcTLTTIamFbukGNPnxdycQtbTen
 FncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773243029; x=1773847829;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x06mqwuab/NgXXniKMH8XhjXE/4crP98wDkaDqDe6A8=;
 b=Cc82xas77i3QeWsgk0ir7JmrnVGIrFT/1dYQXQyKeNB17SXhagkn0wsjoZHuwzG7Jx
 Wrt9/ofkcRHphbGsb8DZBdQrgOXcgvueb0ANrIDJT6MLbVGkoe9UsalhoEt5g3SKQf/B
 qoc74Aledd5ijtDUcZm+UDPn0JQIKWkE1UporughXVg9RGjRp8UM0Bd+FJdWFHC3RjA/
 8yb4TAUFChyFTIGOEzrCTTjcfVHpJLs2hJ4RwLh73G8zeet2tVOB4Wi4UVip17m/tilz
 rhUU8IhC4BEUcPdE2TANFcwmv/crZQsdW8ibGRJVKem6FCzlKaPm4Oh8FPEwxoqY6g11
 xITg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Qw4HkXo0ceyW1Gxj9AWY+ZNd1C9y6xYJyz6RHDmWmmlovBoqn1L9PfI97aUSOBDwl+ODQs9vZ9rt@nongnu.org
X-Gm-Message-State: AOJu0YzDaKfHJaLKWUCiAPxi9syvXXXMM6bkHmom+w/vQV1Om6Z4NOUO
 q7GELcBRHS0tO5pB4JTuMtwn5bIVY5ms9dh1ubzJ51LvZ+zBUahTfryvVIR6DGAX56a3d8wB7PC
 b5y+aNRfkyNE/Z3HuGCE+ZYjQDW6Cg0e55pSJRDSxgc2hsgYGNZNvGAql
X-Gm-Gg: ATEYQzxMq/3LqrlXbfH9WRx0y4C9i84ilpRSFlX/cAVKjsgRt0/awPedr5wf3/igIWy
 tofPkMc4os3wmE56iy021E9sqhxSHsL+3nT/nRbMJkxD5BxEAgN4cXfHv+BhI7D/Ob7K2KzLLKc
 lfp+fsM/D854MqhUCXV6ZHuklFbTK2ONDGjxogMwb96E1amSjrywUsJgskmp8TW04vog033BCvU
 BgeMEVtcEkIdU9EYYJX7dzQB9coHk/xk6Aq229Wb+yl6T0Xc1MTyhJwJhtfNxzMSyRUGejbf86u
 rlnPlbXLT2FdMqlqbNLm1ZezKVBmhXLYPTdfCTepcdxHu57yhFkzd/b0T30lXIMQo04XIVk+7aG
 ecSnwl7M2pARYeQ==
X-Received: by 2002:a05:620a:46ab:b0:8cd:97a7:a343 with SMTP id
 af79cd13be357-8cda1a29234mr387303285a.36.1773243029166; 
 Wed, 11 Mar 2026 08:30:29 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:8cd:97a7:a343 with SMTP id
 af79cd13be357-8cda1a29234mr387293285a.36.1773243028472; 
 Wed, 11 Mar 2026 08:30:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fddfe8sm154408885a.12.2026.03.11.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:30:27 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:30:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <abGKkoFfy1RILXA0@x1.local>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
 <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com> <aa8Pvd5O-OLKIXam@x1.local>
 <abFZvUoinIjfMlNX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abFZvUoinIjfMlNX@redhat.com>
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

On Wed, Mar 11, 2026 at 12:02:05PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 09, 2026 at 02:21:49PM -0400, Peter Xu wrote:
> > On Mon, Mar 09, 2026 at 05:51:29PM +0000, Daniel P. Berrangé wrote:
> > > On Mon, Mar 09, 2026 at 05:42:08PM +0000, Tejus GK wrote:
> > > > 
> > > > 
> > > > > On 9 Mar 2026, at 10:47 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > 
> > > > > !-------------------------------------------------------------------|
> > > > >  CAUTION: External Email
> > > > > 
> > > > > |-------------------------------------------------------------------!
> > > > > 
> > > > > On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> > > > >> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > > > >>>> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > > >>>>         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > > > >>>> 
> > > > >>>>         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > > > >>>> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > >>>> -            sioc->new_zero_copy_sent_success = true;
> > > > >>>> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > >>>> +            sioc->zero_copy_fallback++;
> > > > >>> 
> > > > >>> ...this is counting the number of MSG_ERRQUEUE items, which is not
> > > > >>> the same as the number of IO requests. That's why we only used it
> > > > >>> as a boolean marker originally, rather than making it a counter.
> > > > >> 
> > > > >> Would the logic still work and better than before?  Say, it's a counter of
> > > > >> "messages" rather than "IOs" then.
> > > > > 
> > > > > IIUC it is a counter of processing notifications which is not directly
> > > > > correlated to any action by QEMU - neither bytes nor syscalls.
> > > > 
> > > > Please correct me if I'm wrong about this, isn’t each notification an information 
> > > > about what happened to an individual IO?
> > > 
> > > If userspace hasn't read a queued notification yet, the kernel will
> > > merge new notifications with the existing queued one.
> > > 
> > > The line above your change
> > > 
> > >   serr->ee_data - serr->ee_info + 1;
> > > 
> > > records how many notifications were merged, so we now how many
> > > syscalls were processed.
> > > 
> > > If ee_code is  SO_EE_CODE_ZEROCOPY_COPIED though it means at least
> > > one syscall resulted in a copy, but that doesn't imply that *all*
> > > syscalls resulted in a copy.
> > > 
> > > AFAICT, it could be 1 out of a 1000 syscalls resulted in a copy,
> > > or it could be 1000 out of 1000 resulted in a copy. We don't know.
> > > 
> > > IIUC the kernel's merging of notifications appears lossy wrt this
> > > information. It could be partially mitigated by doing a flush for
> > > notifications really really frequently but that feels like it would
> > > have its own downsides
> > 
> > IMHO what this change does is removing the false negatives.
> > 
> > Before this patch, if QEMU reports fallback=0, it doesn't mean all the
> > MSG_ZEROCOPY requests were all fulfilled by zerocopy.  It's because we
> > justify it with one boolean over "a period of time" between two flushes, we
> > set the boolean to TRUE as long as there is _one_ successful report of
> > MSG_ZEROCOPY.  So even if every flush reports TRUE it only means "there is
> > at least one MSG_ZEROCOPY request that didn't fallback".  It has no
> > implication of whether a fallback happened.
> > 
> > Hence, before this v2 patch, there can be false negative reported by QEMU,
> > assuming there's no fallback (reflected in stats) but it actually happened.
> > 
> > After this patch, if QEMU reports fallback=0, it guarantees that _all_
> > MSG_ZEROCOPY requests are fulfilled with zerocopy.  It's because we monitor
> > all messages and accumulate any fallback cases.  Even if the messages can
> > be merged, when "fallback" shows anything non-zero would imply some
> > fallback happened.  Here, the counter value doesn't really matter much
> > IMHO, as long as it becomes non-zero.
> 
> AFAICT, the v1 of this patch was sufficient to address the original
> bug and maintain the current intended semantics of the migration
> counter. This v2 is mixing a bug fix with functional change in
> behaviour and I don't think the latter is justified.

It's just that when it cannot report all fallback cases, I don't yet see
how it would help much even if we fix the previous behavior with v1..

OTOH, the new behavior will be deemed to have no issue on the problem v1
was fixing.

So IIUC v2's behavior is the one we want, and helps identify fallback
happened.

If to split the patch, we can merge v1, then change the behavior like v2,
but then we will need to revert v1 again because it's not needed with the
new behavior.  I'm OK either way.

Thanks,

-- 
Peter Xu


