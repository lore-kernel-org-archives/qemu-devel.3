Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C36FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJlD-0006Eu-00; Tue, 21 Oct 2025 17:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJl9-0006E5-11
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJl5-0004aO-9K
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761081543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5+67aS2utQ+efvnvkIybIjGHjFwuVlBzYCM6/bWD2Q=;
 b=SCa2FkFfOub7YOnMXApTkz0pyDEypOAM5RBOVjl8YARF/SMuaWBsh4gyOInkzrr6hrEcQw
 /0/dw+XSMqU/+fIVs0fQbXImJoSBUy42Q3aZx5qA8DgAgflrdVmeGHTvFxsqWyn7UBAfIm
 IuYOQaXAbljtda9jSlt2H9vCUUsf6mQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-p-6PHJf2OFaGugs7kv7HVw-1; Tue, 21 Oct 2025 17:18:59 -0400
X-MC-Unique: p-6PHJf2OFaGugs7kv7HVw-1
X-Mimecast-MFC-AGG-ID: p-6PHJf2OFaGugs7kv7HVw_1761081539
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87c0e0d12ddso215749406d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761081539; x=1761686339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5+67aS2utQ+efvnvkIybIjGHjFwuVlBzYCM6/bWD2Q=;
 b=JnOYCbqTUmzcLIC71191aoUf+/70W8m5aPbaySni7fmvs1JZs9da+danBT5IX83utQ
 1wcaEYVGKM8tCU0nfHaZbFrAfEXrhPjZ0L2cAdtXrP3ojeJo1Zj3MFMm5Gd+lPMfnEDR
 Ct5vcf5MdykUIYlpsvr3tbvkgZHf7vLnoh8esXHUq8QiVZaGW/fprMrnYCkQQxlOwrcC
 yKDjIZM28qTDIIwSdyfG+N9FopOug066nXRzw+AoVRFmsEPfAPPPJIlULTqgYk++dwnP
 UcVl8/GF/LKA4jlbAZ38K7/+dSM64BE1B09gkpe3lSKxXqiAq6217wN5p4+tuWBxSLWY
 6RVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXDyVOvtV1MAj6ak9zV+2oXM8mxWmTI5z8m25JlxOV6rZ8+jLp9kE9iJ91uLn362fDtjEgjMv6d7zs@nongnu.org
X-Gm-Message-State: AOJu0YwLTMspI5QEZkInIhHyafVzov6IvSfLv9iwJCQFEp+alcCOGtDl
 up0Pmz8KAZivo9Amr6hUiFrwaulQtsq1pi9tntQ2CkY0+qd0kT2UJWK9Ha7+2x3DJVk0yeCMRYG
 +nhgZGYB0/PF9BHcC5588o21n01ZsJvRJXqsUkykYF12p6jBn+4h9A3Ie
X-Gm-Gg: ASbGncsu+SbuuvZWWECZOtMGlwBhDxPYrdVwWn53zNhZwmHELTJ0v/XsU3C9G7Wn3lR
 3bzeXi17nsNxNt3nao0nS4zpittflAiykQbZVMZnOAP13BzJck5UYGap5Q2OGtAfdhB3zIHS8/l
 hRCkkDAN2lnBIFpBa4GPauwZr0lcuUb6OR9ciuQNCxuDU4+tORaj6ssmwSLE7Hj77FpeVOzS2/1
 Hy8wtnv3CZbhjArbSfeMXor3QZYaUF0olnV5xN8Zvaet17SrIHIWyEn//Qlpg5owS6h0HfTZPOM
 tDpMR1YAUZzAcNYmMKmC5OuSZ8nSP0JdyW7jng4N2sWbZIoz/0GwT/ovxlvrOUr/Kco=
X-Received: by 2002:ad4:5f4b:0:b0:7c6:2778:2f8 with SMTP id
 6a1803df08f44-87c2062ae20mr268676306d6.47.1761081539198; 
 Tue, 21 Oct 2025 14:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRvxqcW4UPatuyyvU/5jTrl8qnruTjBtc4KLXJxnwZoJfHLQ4qsL5VVmju99IGkSW8Yl/CSA==
X-Received: by 2002:ad4:5f4b:0:b0:7c6:2778:2f8 with SMTP id
 6a1803df08f44-87c2062ae20mr268675956d6.47.1761081538668; 
 Tue, 21 Oct 2025 14:18:58 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028930a0sm75214706d6.35.2025.10.21.14.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 14:18:57 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:18:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Dhruv Choudhary <dhruv.choudhary@nutanix.com>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] Improve error propagation via return path
Message-ID: <aPf4wK_ZOf7BbQ4C@x1.local>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
 <aPeaBNIzrq0Ni4IM@x1.local>
 <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
 <aPelsAunpYhiQJ0h@x1.local> <87tszst2so.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tszst2so.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 21, 2025 at 05:31:19PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Oct 21, 2025 at 05:54:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> On 21.10.25 17:34, Peter Xu wrote:
> >> > On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
> >> > > Use the return-path thread to send error details from the
> >> > > destination to the source on a migration failure. Management
> >> > > applications can then query the source QEMU for errors, as
> >> > > the single source of truth, making failures easy to trace.
> >> > > 
> >> > > Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
> >> > 
> >> > +Vladimir, Dan
> >> > 
> >> > IIUC we may still need to know whether the src QEMU supports this message
> >> > or not.
> >> > 
> >> > OTOH, we have introduced exit-on-error since 9.1:
> >> > 
> >> > # @exit-on-error: Exit on incoming migration failure.  Default true.
> >> > #     When set to false, the failure triggers a :qapi:event:`MIGRATION`
> >> > #     event, and error details could be retrieved with `query-migrate`.
> >> > #     (since 9.1)
> >> > 
> >> > This patch is going the other way.  That feature suggests the mgmt query
> >> > the error from dest directly.
> >> > 
> >> > We should stick with one plan rather than doing both.
> >> > 
> >> 
> >> Why?
> >> 
> >> exit-on-error=false is good anyway: when QMP connection is established, the
> >> management of target QEMU process is the same: we do call qmp commands to
> >> add devices, etc. We get QMP events. Actually, exiting is unexpected, better
> >> to fit into QMP protocol, continuing to send events and wait for qmp quit
> >> to exit.
> >> 
> >> Passing error back to the source simply improves error message on source,
> >> which otherwise is often confusing.
> >> 
> >> Using both, we of course see same error in two places.. But we do have two
> >> QEMU processes, which both handled by on-host managing services. We should
> >> correctly report error on both parts anyway.
> >> 
> >> Improving error messages on source is just and improvement, which makes
> >> current behavior better (with or without exit-on-error=false).
> >> 
> >> Removing exit-on-error=false semantics (with or without passing errors back)
> >> would be a step backward, to violating of QMP protocol by unexpected exits.
> >
> > I didn't mean to propose removing exit-on-error, what I meant is when with
> > it this patch doesn't look like helpful.
> >
> > Has libvirt been integrated with exit-on-error?  If so, IMHO we don't need
> > this patch anymore.  To me it's not an improvement when with exit-on-error,
> > because duplicating the error from dest to src makes it harder to know
> > where the error happened.
> 
> Yeah, this does introduce some complexity of the "whose error is this?"
> kind. I can imagine future users of migrate_has_error() having to handle
> the error differently whether it came from this machine or the remote
> one. Maybe with current code there's no issue, but we need to think from
> a design perspective. Another point is whether the source machine is
> always prepared to see an error that has nothing to do with its own
> operation as it usually gets to know about a destination error only when
> TCP connections start to fail.
> 
> That said, from a usability perspective, I'm in favor of having the
> source machine be able to inform the user about the destination
> machine's error. It goes in the direction of relying less on the
> management layer, which we already agree might be a good idea.

Yes, but when the mgmt already has exit-on-error and be able to pull errors
on both sides, it'll be a problem because mgmt will start to see two errors.

But indeed even before this patch, mgmt can already see two errors.. the
src error being an IO failure. I wonder how libvirt decides which error to
use, and whether some patch like this one would confuse mgmt (consider mgmt
now ignores IO errors when the other error reports something meaningful,
but then mgmt starts to see both errors are not IO errors).

One thing we could do (without worrying about disturbing mgmt) might be we
store the dest error separately on src..  Then we expose it separately in
qeury-migrate too (then mgmt / HMP can decide what error to show).

-- 
Peter Xu


