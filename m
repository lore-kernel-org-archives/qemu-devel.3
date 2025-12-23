Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAD5E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4Ln-0004id-3x; Tue, 23 Dec 2025 10:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY4Ll-0004hw-8H
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY4LY-0002xy-If
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766503845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=suBSkovoXZOajNcU7GUZLrwcjQyAzyn1he1k3SpPDDQ=;
 b=g+w3QE+SU6OjoVI+E7EUB+Pdw4gWgAzOzEx52bOfon8DRqlOWgjKymz3vpA6dDycq4GcH3
 5U/Xt6v3g12YVQV0YKp/fuMBRkvBlY/bDATobEqKFCBodpmy9d0hLqtaQpSisk4ozmQxmp
 tW4ysh2W0RGlEw3uRwSh8ZeETiYSq8o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-EfY1XUHbOb-ZeWTzIzg9og-1; Tue, 23 Dec 2025 10:30:43 -0500
X-MC-Unique: EfY1XUHbOb-ZeWTzIzg9og-1
X-Mimecast-MFC-AGG-ID: EfY1XUHbOb-ZeWTzIzg9og_1766503842
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b6963d1624so1233095185a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 07:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766503842; x=1767108642; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=suBSkovoXZOajNcU7GUZLrwcjQyAzyn1he1k3SpPDDQ=;
 b=ozrO6eeBZo+eBOPpDs3Oc4aWDW1U7ukT3gWABGjDvvbXHNABqbkyfcPKY/dItZS3Un
 cRH+sNgFTEQUKKCuS0Tpv6IzpUzRfGHJ1xcm7mXvsgLxY4uyFhPtacJgIyIARuG42K3M
 /Pu+s/SK/6AJENu7mYaFhdjzrnqHUf1KQMqDbhl5tApRCTVkItGwquCkcEgNDv38UtT9
 rcGezay7s8dL/KLVH3NngKR3m1hz7nPJx9sqU6k5Ns0C1+K3q/LcOxfkUmBIu6FoTvBB
 HvHhgG51ftnUru9fWBwPgW66T9TSuorB4IIxFoo6wat0JpbrKP4ePS4gPOSu7K8hT+V1
 J4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766503842; x=1767108642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suBSkovoXZOajNcU7GUZLrwcjQyAzyn1he1k3SpPDDQ=;
 b=bRfvIAwi4D5Sh2KJHXCeBygRY5NwkGKhJV1cNmeaClZYHH/HukUtrBUMX3onQA6ALv
 4aeBmek5nGVyQeUPxcXy3NIIoT14jXmZUetBIandU4prGhYuYmUK5baNQp3x2SPSYUeB
 NOjxkNT4XtIOlzW73VaEFJc+Fr/mtoCUEcvRmM6aKCgaZ8X3ZE4to9lXdzMfVe4hyETK
 9YPxQJEkPMu4mOxiWcHmOIiRvNLkeMw7XpvNoCN5PATqy9krugEHmz/YGZ6I6wDUoAKI
 XV2Tx1NZVGkX1MmX7zWqs9H/NbGgF5/fBS6s8HfcddjeLedRRc4Z72lIBp1i8x5U9Yi0
 V3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ehSTiX8WeOOdc+SRg6k+m5NdWN3PADbmNdVH4PXhpkO9X+jy3yFtURNmE3UslV05uJsT8OA/UZj3@nongnu.org
X-Gm-Message-State: AOJu0YyCPcAFw365aCCPyp0/WS+JfCYMks8u3pihAga/u5O7xraWIJWn
 sVwKXsrehJhO89no2KjgoqrlNY2MwdXIDvvfgkjueVEP7EL5igF+fhwvvhW6bM8+hPqlobBifli
 qNaOvm+ukQS7C8mq9SgM4OBTDyY3ueSliOdiM5i2Luq/H8V4NE5FND87j
X-Gm-Gg: AY/fxX6hst8nXJsPjK6L1fo2fyUj2UP6jWE4lDPaex70En/M1pVVsc0PEMxGRfUduhj
 ZPkrpxz9uTO3YSTxhrJ8TVODm6Zj12MyLVRZRyct7xtb0QzCB8fJ6UTRsC/Qy/gGFxxNe7ci+NJ
 RKlB/JeYOcRXnxKy7jB6cTp+Zn1GAqD9lj2B/f1oMq5H7sJPOIdAywHKM7gKVPoZ5ECVkegKQPb
 VCHJVEroBjFNyuTya6Xj9yQxvVf7zJ1N9d4QFYcY1ES9HleRByBjcmVerSZ1xQ8OEgrW71l+zzU
 cMkC1dLnIsQOveaJzi0PQ74w582xbAK9EgYrj+rPHaNVxuCOHDGQQgV63KmyrDuDfFgEdTCoDfX
 czKg=
X-Received: by 2002:a05:620a:172b:b0:8b2:e3c1:24c3 with SMTP id
 af79cd13be357-8c08fac0b9emr2403292185a.64.1766503842323; 
 Tue, 23 Dec 2025 07:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD16vVj3b1eB+R/et7k6weJxQfxyNqwY0kIGnM4h6Fb8NoWGd5YQPUsH9Rwfpb4HVSD8AU5w==
X-Received: by 2002:a05:620a:172b:b0:8b2:e3c1:24c3 with SMTP id
 af79cd13be357-8c08fac0b9emr2403282785a.64.1766503841617; 
 Tue, 23 Dec 2025 07:30:41 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0970f5fdasm1113664285a.35.2025.12.23.07.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 07:30:41 -0800 (PST)
Date: Tue, 23 Dec 2025 10:30:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aUq1oA73W9rAdCgG@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5tilhcq.fsf@suse.de>
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

On Mon, Dec 22, 2025 at 11:29:57AM -0300, Fabiano Rosas wrote:
> I'm fine with the general idea:
> 
> i) FAILED and CANCELLED are terminal states. It makes sense to not have
> work happen after they're set.
> 
> ii) Using an intermediate state, assuming locking/atomic are correct is
> a suitable fix for the issue.
> 
> iii) Using a FAILING status seems appropriate.
> 
> However,
> 
> It would be great if we could stop exposing implementation details via
> QAPI. Does the user really need to see events for CANCELLING and
> FAILING?
> 
> It would probably be easier if we kept MigrationStatus as QAPI only and
> used a separate mechanism to track the internal states.
> 
> That said, we could merge this as is to fix the bug and think about that
> later.

This bug looks to be there for a long time, IMHO we don't need to rush
fixing it if we risk adding a new status and revert it quickly...  Let's
discuss it here, and it's a valid question indeed.

One thing good about exposing such status via QAPI is, it can help us
diagnose issues by seeing CANCELLING / FAILING even looking at
query-migrate results (as normally when bug happens we can't see the
internal status..), so that we know either it's explicitly cancelled, or
something went wrong.

If it's a completely hidden / internal status, we may see ACTIVE even if
something wrong happened..

My current hope is any mgmt should normally by default ignore new migration
states..  If that's always achieved, it looks to me adding FAILING directly
into migration status would still have some benefits on debugging.

[...]

> > @@ -2907,7 +2914,7 @@ fail_closefb:
> >      qemu_fclose(fb);
> >  fail:
> >      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> > -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
> >      }
> 
> This is a good example where having MigrationStatus makes the code more
> complicated. This could be exiting=true, running=false, etc. It
> shouldn't matter why this routine failed. If we reach
> migration_cleanup() and, at the very end, state is CANCELLING, then we
> know the cancel command has caused this and set the state to
> CANCELLED. If the state was something else, then it's unintended and we
> set FAILED.

If it'll be an internal status, we'll still need to identify if someone
already have cancelled it, right?

Assuming we introduce stop_reason flag, making it:

enum {
    MIG_STOP_REASON_CANCEL,
    MIG_STOP_REASON_FAIL,
} MigrationStopReason;

Then we can switch to CANCELLED / FAILED when cleanup from those reasons.

Then here, logically we also need logic like:

    if (stop_reason != MIG_STOP_REASON_CANCEL) {
        stop_reason = MIG_STOP_REASON_FAIL;
    }

Because we want to make sure when the user already triggered cancel, it
won't show FAILED but only show CANCELLED at last?

-- 
Peter Xu


