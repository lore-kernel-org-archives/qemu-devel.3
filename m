Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE8C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ED9-0004jr-0D; Thu, 03 Sep 2026 16:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2ED7-0004jI-4M
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2ED5-00085d-Nq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788467938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWtTelgr18n35CxvbpCxE6va0BosWS/wc5EEvRJ7Ypc=;
 b=B4Zw5e7ea6z3jpEu4AfaV5KCBpzbY5WVVN/AvD5l5QCzj3w1j7/Y1RAEy/3kKLgi5Y1Jlc
 bUK+rYLzlXtvkwsDXI9dK6gbacUNJQ+5YY8cIrt8X8O6lXLM70nEhrbn18bnK3kXcEcVBJ
 JmuccXs8xzyiKQ65x8PIDdT5kUqS+cA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-WVrlbwwmOqmXMB3IKGioVA-1; Thu, 03 Sep 2026 16:38:57 -0400
X-MC-Unique: WVrlbwwmOqmXMB3IKGioVA-1
X-Mimecast-MFC-AGG-ID: WVrlbwwmOqmXMB3IKGioVA_1788467937
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ce64c41efso9852031cf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788467936; x=1789072736; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sWtTelgr18n35CxvbpCxE6va0BosWS/wc5EEvRJ7Ypc=;
 b=H0NaQMV6yATdJHyN7Q+EUWB6tSxZV/q36tfBzPTJkZRcfhj8vJYHFr/KzexMw3asr1
 EJAF1p7IAvCuZAVpDmED0mg4VvId/QLAdBlwojdHPA8QmUZqHEAudgA5Niif23QMhRDb
 egHOekOhDZ78jvGnr1JIdVNuLj0no1qDeolc8qwZVY7aMqgmJRKwMYJJ5PRkHnBKVwv4
 fb8AWG1G84gpWQGsf2Y9nJCZT4KMcx4a7EwdHGct+6jQsAFJoWCHf3PKaZVRUbvBMRJf
 +N09O4I0XJMLc/KHSAsrqhy4NuYrUr4dLbxjRZgHQLctdZqhn86KMCTWLEqnrU9VbPKa
 0/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788467936; x=1789072736;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sWtTelgr18n35CxvbpCxE6va0BosWS/wc5EEvRJ7Ypc=;
 b=jZbMeMe4f7GGGg73g4vCSgKe40EgqnLuC6sy3Z8+ltIpUJyzleGh3tdTvS589oAodS
 VA7u4wVsR0BaALzersDEUuHXjUPVA5rdXGNZBbI30QTvQDNxiVHrlLgKSE4QnIubtFkx
 60icQjvO/DahhIuaHFu4ieHrN4zYI/NxRpWW+8npBBAaoxP0c9JFJilJK2y0cClmMcUn
 xy+6RI8hxYCltpq2qbSxjsbFlt5RsB5OfV9rywpi2pOxkocOlMT7xvYlua+Eqo3YLNrd
 zqvO1pN+O4xpL42HJId/bMEUYFp3bgS3Xiu9O9Z3IjeoKuf4saDH8qMAbirrwvWqH3S9
 mWnQ==
X-Gm-Message-State: AFuF++nZBi7UMHt17XMPeaDySHYyZOrWtL/DVhWjH3gCSoP6ZWNQROTn
 vjxP+1uhqW5rKUNrFTWORessveN1U1rIJe3BRP/0mRXP296jrqW3IsUKKdg+/sAGhHC/R6uhbZj
 SD0q4/3dOZDL8XvadBCEqNwr53JKdE/8xvCdf8a6dFy0xfBA/KOb9rln/
X-Gm-Gg: AYBFou3Qu95j9SL6YvECY2IG54vW32qW1lbdVUdkGpy8b1X+rgrjvXg0tQ4KozuHLxq
 iIahAxKhV4IbBYlo40AloYI06pXUjsptz68/AX9OJ3FabSmmIEGUyV/HvulovyzI79tQT5WAEW5
 NLr9TF094GaughqGV96WZuBulfG/pnMzyscUTkXmon4cvO6/zUjb3QpnUiipfndIbfnfF80OsfN
 2JHxaMs/gDOi+pR6mv5cBNxRHaJucMaWDqzJH8G7R956sorgzz/eHAgBx3VTeeJ28BWn8NnxG5b
 slcPmzEH8qwMeTmtxMo9Hkmm8+w15QCKjv0q8Sy8lE7lEMicfRFaOzRpIykZREIisIkx
X-Received: by 2002:a05:622a:1114:b0:530:3bd9:e4d0 with SMTP id
 d75a77b69052e-5305485a9fcmr16537871cf.20.1788467936448; 
 Thu, 03 Sep 2026 13:38:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1114:b0:530:3bd9:e4d0 with SMTP id
 d75a77b69052e-5305485a9fcmr16537311cf.20.1788467935907; 
 Thu, 03 Sep 2026 13:38:55 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054116933sm5293561cf.7.2026.09.03.13.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:38:55 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:38:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/18] tests/qtest/migration: Add a test for HMP
Message-ID: <apna08iQ-h_IGPsd@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-10-farosas@suse.de>
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

On Wed, Sep 02, 2026 at 07:15:37PM -0300, Fabiano Rosas wrote:
> The following patches will change how parameters are set and shown in
> HMP, including readline completion so add two minimal tests.
> 
> - set/info migrate_parameters
> 
> The test uses qtest facilities to issue HMP migrate_set_parameters for
> each of the existing migration parameters and queries them back with
> the info command. A list is kept with the expected strings. A
> substring match function inspired by glib's g_str_match_string is
> implemented for this test so the test can produce a decent error
> output instead of just assert failure. E.g:
> 
>  # HMP output mismatch for entry at line 55:
>  # expected vs. found:
>  #
>  # max-bandwidth: 10356305952768 bytes/hour
>  # ---
>  # max-bandwidth: 10356305952768 bytes/second
> 
> (note that line 55 above is the source line where the test case for
> max-bandwith is)
> 
> - readline completion
> 
> The test puts the monitor on a chardev via socket and bypasses qtest
> facilities because it needs to emit raw codes to readline. It
> therefore requires a couple of new helpers to read/write to the
> monitor socket.
> 
> Usage:
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


