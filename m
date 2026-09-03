Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F424C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2EGo-0005OG-G5; Thu, 03 Sep 2026 16:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2EGm-0005Nu-FN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2EGl-0000tN-0Z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788468166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUAMw7EqjHXYBk4c4LhhLM8csKvR09JiaZKOZRnxYZk=;
 b=NHUc4zbbY5CeFeLRGb+GvkzQUtbP7UQoAf+dd7SWPm4gZo68of465ecaqUWnWSklbTwnRI
 B4T1FPyLJD9jU1yZUk3ITyr6IhwxoVFSKFkaDIUD7tqjKepkmgI9/qdA81rRDjgRbYGVkG
 aBUhTHo4O727XwQCfpflcaGJZLykqPM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-0bvR_4hOPK2JdN8q6Q0jfQ-1; Thu, 03 Sep 2026 16:42:44 -0400
X-MC-Unique: 0bvR_4hOPK2JdN8q6Q0jfQ-1
X-Mimecast-MFC-AGG-ID: 0bvR_4hOPK2JdN8q6Q0jfQ_1788468164
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so10431431cf.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788468164; x=1789072964; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUAMw7EqjHXYBk4c4LhhLM8csKvR09JiaZKOZRnxYZk=;
 b=G3ZSc7xQdaCwcYfcZT8cZULAPpTeQg5IOW5lbMk5v6QWcCHoSl802EUsapzSUT4oY6
 qcnoCvUJhRl6ook6jfeD27o3iKBaLXqpTLbeRp2IjFlSOD4sVYr751Ng7VcvCqexySGN
 jcwIVnJoYIU0TH972yc7tb20wPNVI5/f+XCOpizG6tkJMlpRN+jfZSeDIEWJwrlCIfcX
 zrMpU/ALM+INJ3ypzm03ycEZ8eIkb+nS6r2ROxDpa8YiWdD6n7P7LINdI5mo/Jn8msKD
 H9MvqPkSROXhyWMMbcqLv/Ys2jq541Sb7+iqu9Chlf4IwitJRiSyhV0PMLs98RVdxpO7
 wYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468164; x=1789072964;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUAMw7EqjHXYBk4c4LhhLM8csKvR09JiaZKOZRnxYZk=;
 b=J6lOvtSLCEHvt7js64EDJSJJv4iP0XOt6e+RVhsN+71Uc1Kbz5CDYJOfc0UOZlnmF5
 cHtvWNT3jLSWdB2vozUOjrcJvZqmqAlXxVhYvVol2tYU2KIkVTbhBnyS2itMc7v4xkFj
 SmRJdKJbKTnv48lUTP1LpR25mKC8mKPjusE6iMtZGlfKm+4HrQ2eLgyoM8p/fV5KguN/
 PfhZigfHldkBk+ThZ0bi4dRUxtir/0v4AMNa4DuwQk4Skmis17cXYmE76kCP1Ux9kKSU
 6v+6df5COCHAp1+dq8KgjQzSAMXnXcwROfwUp2s4sxOVkvpr2NAvhbJ564VZLV8jRfwk
 DIGQ==
X-Gm-Message-State: AFuF++kFble7BpCZsPA7gGvodyVWLeuETu1zt8YbEdaXi0xExO6azCoF
 I31sUtBBWdwUzT9oi3NVpvXRW1IlgKAltsazYEbv8pGqag/mO/14Eq0ADXBn5gnr1cyCxddDtjC
 E40MTzZck/yQDc0EUg9y8Op2zw2tm0DG6QXkFDBNCoQhtOqklcit+D67y
X-Gm-Gg: AYBFou1DlKksKDiYRTVYNI0MeFp3+ceBNBpYHCuw4FgYVSJbFjPG/q8zInbvT8Ee+08
 Hi0kH4TH1KZBfll2yiPnCGmbHXP/8GiukxAILwEq51aKHaEoX+fYIb0jEvQ4HDTsPkuupi19dMa
 xdCqfbtsqOn6LMkzLDl8L/HrlpK9YobgYuBEOaXPntsMZfLEGyBPUVx2gwr3nD94aLP1R3Aqmn/
 ugprCMocDP8R2MGTI5Cb2l3i5+2u3ZKjIQKa7djM4FoEAx/cZnmGpXi4cLi78O23qPEvzTLGrMB
 FdsPKOhiiRB8DRIIBEuKMfCDM51AdHtK4/FHhQTrPhInpB74paa8i3gJpWjLd3HVDJTwKM16+w7
 dwSCwiZIyg6FmGvIZ2iMbgb2SV+S4Eb6OvrYkI1lFLZxvUHxl/84OMvia8JY=
X-Received: by 2002:a05:6214:21a7:b0:90a:807d:31ad with SMTP id
 6a1803df08f44-9103f025ea8mr14925596d6.26.1788468164143; 
 Thu, 03 Sep 2026 13:42:44 -0700 (PDT)
X-Received: by 2002:a05:6214:21a7:b0:90a:807d:31ad with SMTP id
 6a1803df08f44-9103f025ea8mr14925376d6.26.1788468163658; 
 Thu, 03 Sep 2026 13:42:43 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040595f81sm3677506d6.2.2026.09.03.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:42:42 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:42:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/18] tests/qtest/migration: Add a test for HMP
Message-ID: <apnbwWmg_3KaxXnO@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-10-farosas@suse.de>
 <apna08iQ-h_IGPsd@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apna08iQ-h_IGPsd@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 03, 2026 at 04:38:43PM -0400, Peter Xu wrote:
> On Wed, Sep 02, 2026 at 07:15:37PM -0300, Fabiano Rosas wrote:
> > The following patches will change how parameters are set and shown in
> > HMP, including readline completion so add two minimal tests.
> > 
> > - set/info migrate_parameters
> > 
> > The test uses qtest facilities to issue HMP migrate_set_parameters for
> > each of the existing migration parameters and queries them back with
> > the info command. A list is kept with the expected strings. A
> > substring match function inspired by glib's g_str_match_string is
> > implemented for this test so the test can produce a decent error
> > output instead of just assert failure. E.g:
> > 
> >  # HMP output mismatch for entry at line 55:
> >  # expected vs. found:
> >  #
> >  # max-bandwidth: 10356305952768 bytes/hour
> >  # ---
> >  # max-bandwidth: 10356305952768 bytes/second
> > 
> > (note that line 55 above is the source line where the test case for
> > max-bandwith is)
> > 
> > - readline completion
> > 
> > The test puts the monitor on a chardev via socket and bypasses qtest
> > facilities because it needs to emit raw codes to readline. It
> > therefore requires a couple of new helpers to read/write to the
> > monitor socket.
> > 
> > Usage:
> > QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> > ./tests/qtest/migration-test --full -p /x86_64/migration/hmp
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Acked-by: Peter Xu <peterx@redhat.com>

Ah I forgot to say: Logically this test should not be in migration-test,
simply because it uses 1 VM not 2.. hence MigrateCommon doesn't make sense
to be passed into the two HMP tests.  But can be done later too.

Also feel free to also keep my A-b if you lightly update it, e.g. add
set-parameter test entries, duplicate g_test_message()s, etc.

-- 
Peter Xu


