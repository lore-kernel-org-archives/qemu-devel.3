Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EF0D0EE25
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzzi-0003r8-Oi; Tue, 25 Nov 2025 15:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzz2-0001Mi-9F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzyz-00036V-GZ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGyXi9hfMSi2eU9XFpkQq6llh/vKAazZMlSSUUXEl/g=;
 b=dd6uR62mr/z8cv99YcIq364lVE1/4ettnuLjC4dKptovOlisi1uHJNDgDZ5MJroCEyvj2m
 m6rwAy+gimhbdcWZIEim44c1onJP88t+ed7W5hJv84ZOHLMNVt1DIRaxETSTL+0R6+rgTP
 +BP1VMbq3AYgrrNmr81v5d0Cv7tlCxo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-jbFtaW7uNSSWrqms_0U71A-1; Tue, 25 Nov 2025 15:49:51 -0500
X-MC-Unique: jbFtaW7uNSSWrqms_0U71A-1
X-Mimecast-MFC-AGG-ID: jbFtaW7uNSSWrqms_0U71A_1764103790
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2657cfcdaso713322785a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103790; x=1764708590; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aGyXi9hfMSi2eU9XFpkQq6llh/vKAazZMlSSUUXEl/g=;
 b=CvHYV5IIVus1/xixwy7aruyqt8T9nCje0oC3FTDhyZKsaGQcraStwIHANJ7qzc9a33
 HwFp0xl0weKk+cqJP4RYe3dd20KR+wIzbdwc8eiC5qdySZPO7W5clCEQWYH2ehrmMdHC
 Ketfp+wuKtARpiA8kLNuuXnLekAeco9tqs/4ts36SehktjW6rF8usNYeEUhx1ZawN1OS
 hFFVotjmhDHR9L3oyd6TUSSZsTmlpCRJIHf6nKgtCqz7jD2HyqaAS0JGkOiR2WQryPNO
 3rHCPlzjqW3nE5usgR16ZMLnoHEirev0LSQZRDjzkFL4xtZv+n183mx1olMAfhUFb5PW
 L2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103790; x=1764708590;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aGyXi9hfMSi2eU9XFpkQq6llh/vKAazZMlSSUUXEl/g=;
 b=kUrEOuSpFGgJwSi4njH5fuNtdHqE9Ycr4MzETeT87aakfh/BJFq9YMmOfTc80KvfME
 csCepCMh7wmKoAIzWJBvzCgYQl4zoz+vkX6aIDmAGmoeuGDiyeeAYT9k/L5yTm8YC75J
 4ZJ4BoySA9RtM28pm8fdem+I9Ze6/2Stw1jitZvqvJlUz/lw1juZ8335XL8jhBd76VKl
 rQO6LKXIP+j9sPtpw6ZX118ONjD/b/br3ruFzpay6Zi1iW1gFQunddzAfZTuifsB6oen
 AVy7QDK66ZIj6U6jOGYs6WwOeVXDIVkKbqw/CbwTj4ZTMBqeORHMLNRe584Hx1KJsZYa
 MtnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWQayFYGGOSZBqde328zCkWZh4K4QME8P0VtU8kQzQWUCqAYsRd50tT/4ALtbsayNLrdNEktIndd+7@nongnu.org
X-Gm-Message-State: AOJu0YwXYz7ODjIY0sWSHwFGqVvBXcy8otZG/DagHCvYg8H0avhoJoH0
 VN6GDcLh4YBsY5At25iSTCPEVDKAAe56EMMYyjK+Za2B2xHmzTok4r7a7OwVfCC1KjxVQbmlVgn
 ExcYqXjGzBjsAyTFjhKEA+Rt0SiOaEKYvAz92DEJJjAL35iBfWV4gmunA
X-Gm-Gg: ASbGncu6MmhBY0LgRD3Lt3KoN3L3ksDpyBRdd+zUXWyftre90ocwMNBAEjlC2tZ1D/j
 CbLTDDy9iZEOHe8O8WFXN111CF01lL17OGpOm2JDFLPkoixdeBub7IQ7LNiiB04csWxZQyEssZH
 3KbsI52vQNbM2N2hy9aFPvx5iactj0EEFPylfH6N0zvyHfdTqMffHaV2Bxw1eBUcDZ6WQpctx/M
 WEnq1szY0b/Kq6i3N5X/V0mBUZRfAyH9NFr5PWN510RuS+/wCZYKTeVyRA9/SpP5JcOHxGVpI0f
 rLqXzMKPUs3vyebo72T9Puyn3JeGfeaBsFkiHkBx/pIGcGTZsEMkmi2q+s6KnF1OPCG9jpE8A7M
 IQvg=
X-Received: by 2002:a05:620a:1aa0:b0:8b2:e5cd:fa42 with SMTP id
 af79cd13be357-8b4ebb9f354mr581923785a.0.1764103790407; 
 Tue, 25 Nov 2025 12:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlk88NQL04YsBvb/CONAZ1WEMnNHU4GDm9JMKfIsY7VX0yZQ5xd1U7EJyl8ZVj8phTRn0stQ==
X-Received: by 2002:a05:620a:1aa0:b0:8b2:e5cd:fa42 with SMTP id
 af79cd13be357-8b4ebb9f354mr581920685a.0.1764103789873; 
 Tue, 25 Nov 2025 12:49:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295f157fsm1248645085a.53.2025.11.25.12.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:49:49 -0800 (PST)
Date: Tue, 25 Nov 2025 15:49:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
Message-ID: <aSYWbMR5C6RSc3kZ@x1.local>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
 <87cy56gckg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy56gckg.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 25, 2025 at 08:02:55PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
> >> >> g_autoptr(T) is quite useful when the object's extent matches the
> >> >> function's.
> >> >> 
> >> >> This isn't the case for an Error object the function propagates to its
> >> >> caller.  It is the case for an Error object the function reports or
> >> >> handles itself.  However, the functions to report Error also free it.
> >
> > I'd confess I didn't pay enough attention on how the error API was designed
> > deliberately to always free the Error objects before almost whenever
> > possible.  But I see now, thanks for the write up.
> 
> You're welcome!
> 
> >> >> 
> >> >> Thus, g_autoptr(Error) is rarely applicable.  We have just three
> >> >> instances out of >1100 local Error variables, all in migration code.
> >> >> 
> >> >> Two want to move the error to the MigrationState for later handling /
> >> >> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
> >> >> the original needs to be freed, and g_autoptr() is correct there.  We
> >> >> have 17 more that instead manually free with error_free() or
> >> >> error_report_err() right after migrate_set_error().
> >> >> 
> >> >> We recently discussed storing a copy vs. move the original:
> >> >> 
> >> >>     From: Peter Xu <peterx@redhat.com>
> >> >>     Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
> >> >>     Date: Mon, 17 Nov 2025 11:03:37 -0500
> >> >>     Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
> >> >> 
> >> >> The two g_autoptr() gave me pause when I investigated this topic, simply
> >> >> because they deviate from the common pattern migrate_set_error(s, err)
> >> >> followed by error_free() or error_report_err().
> >> >> 
> >> >> The third one became wrong when I cleaned up the reporting (missed in
> >> >> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
> >> >> mistake escaped review for the same reason I made it: g_autoptr(Error)
> >> >> is unusual and not visible in the patch hunk.
> >> >> 
> >> >> Would you like me to replace the two correct uses of g_autoptr(Error) by
> >> >> more common usage?
> >
> > Works for me.
> >
> > Now I also think it should be good migrate_set_error() follow QEMU's Error
> > API design if we decide to stick with it freeing errors in such APIs.
> >
> > Said that, I wonder if you think we could still consider passing Error**
> > into migrate_set_error(), though, which will be a merged solution of
> > current Error API and what Marc-Andre proposed on resetting pointers to
> > avoid any possible UAF, which I would still slightly prefer personally.
> >
> > If we rework migrate_set_error() to take ownership first, then we can
> > naturally drop the two use cases, and remove the cleanup function.
> >
> > Markus, please also let me know if you want me to do it.
> 
> I think the first step should replace the two g_autoptr() by
> error_free(), then delete g_autoptr() support.
> 
> A possible second step is to replace migrate_set_error() by a function
> that takes ownership.  "Replace" because I think migrate_set_error()
> would be a bad name for such a function.  What's a better name?  Naming
> is hard...  migrate_error_propagate_to_state()?  Because there's
> similarity:
> 
>     error_propagate(errp, err);
> 
> stores @err in @errp, or else frees it, and
> 
>     migrate_error_propagate_to_state(s, err)

I took this one but dropped to_state to make it shorter (and also dropped
"s" to make it g_clear_pointer() friendly).

> 
> stores @err in @s, or else frees it.
> 
> We could also forgo encapsulation and simply use
> 
>     error_propagate(&s->error, err);
> 
> Matter of taste, which means migration maintainers decide.
> 
> I can do just the first step, or both.  Up to you.

I sent the patches here for both of the issues discussed (I should still
owe some other patches; I'll do them separately..):

https://lore.kernel.org/r/20251125204648.857018-1-peterx@redhat.com

Comments more than welcomed.

Thanks,

-- 
Peter Xu


