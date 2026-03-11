Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAC41125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lg9-0005x4-70; Wed, 11 Mar 2026 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0Lg7-0005ww-AM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0Lg4-0007yW-Oe
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773243651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bl+uAo3hJ3Y/4vXA8qyHqvL/gnvj/7p0B2HaBtU7PE=;
 b=PQDGIzg++QD/5QxKrRskkcSe+lmH7cgCPHtJSpYaNTJI0/p1yfaSR6/rIWBi/gt44XAeVw
 pV5Oo8pg3xQ6PaWsGbNqX33g8s8JrRvjtnd7bKbh6FZAwdKIu9BPP4zt+1LlfJB5CBWbPL
 C4XHMHngEpgF3jWJULw71LbjMXHrsIk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-2qkB_-Y9PG2iuSAfIF1wvg-1; Wed, 11 Mar 2026 11:40:50 -0400
X-MC-Unique: 2qkB_-Y9PG2iuSAfIF1wvg-1
X-Mimecast-MFC-AGG-ID: 2qkB_-Y9PG2iuSAfIF1wvg_1773243649
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89a0258c5e5so166623006d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773243649; x=1773848449; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4bl+uAo3hJ3Y/4vXA8qyHqvL/gnvj/7p0B2HaBtU7PE=;
 b=noCzqZEsQ8kzj5s15GG6gEVejMw5rfRfDe3YqFqWltrCLaU54KhrapK3QVgfu2NL6e
 x5ciFBdAjFfFkyei17v0Jm//WJ+3Xj0BoeWjHiDUG3bVah0ku45Lvgy2PIbUx82ZpJbL
 zncpXtWVFJc6LkwEdMBGEWB6Zba3NZflyNvjsCm1bDrE8fh3EIFKv4d+j3vmEfWs99Sj
 v7r8lxkz/YX1v6Fgs0O/7bfpGHDN2qEyQDxnrUtR4nF1AqGig1XmxR1USVRvLaMa4ta+
 65XGtHIh26qi5+V6wZ8XPAGLCCKYud58CiO866B/rnDAR+bUDbC3vhAANAtWfSSbUMBl
 2M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773243649; x=1773848449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bl+uAo3hJ3Y/4vXA8qyHqvL/gnvj/7p0B2HaBtU7PE=;
 b=NEW1Y6cRbtIGvfA7HCFA43nFwaILHStf6ePERghNKiiM7y/gsKJKyy8FCSaqgVk9i3
 nyopuaI2DfscTNtAACaExUtag+/YO5ja+MYFTnqTjNDyM56jflogARncj6cOTn4mdwy5
 fpvXKsRkdML80AJMavREAiTbM12ax87D7+s77t8xT/ZFUhSh/kK3XmF7uDb0YS85gPYh
 51oPVoknaBSwfA0Thqwk0au28rEuBQR0RfYzGFu2SZg65E7JybXgZ14b9kapZSJ2/NEx
 QF1iLBLo2JRoH89ds86g7lqmB5fFW27VG0KLzo+K26e5EnqbUuExTsWyLU8vU0tf4F8V
 pLZg==
X-Gm-Message-State: AOJu0YzaH6wZq6E+Mhf1pefC4KepZ0bhqFM6WsaaXXdfzwen6DCTLv8e
 QsKMxeHtZo6p4hW75Bs+pH1AMx058Fhw+WgHv7nDxuxdREQ1i5s+t4G79YKxUesah488krhsyqJ
 TBsUjRUySyO1n2DQQDU9eI0akbf9AAyT8ZINzTBNzrDzSK0+e/XeTBinJ
X-Gm-Gg: ATEYQzzYdOvop/dNkeuB0qzSxfFOldqwxCHX6c3coHvTm18nS89+n9OGPyMcWQnY6TT
 1Ns/D5Tu4fkC5pMaqZqQc4AiI87QIU6jnXtsozCGqdsaTDHkX4y7JjRyJNn/QoBe83vXERCXaBF
 yEPY/PNQeptbnS2IGExH1RXYaVY73oeSGf+7GkAYBZLhLnb50VtBtHrUlsJitwz2QzRxQvn37e/
 1SnCAkMuqHH9rGkAg5D/FMoxCIIeEhCWPygfqzqAISykgGIM6SSKIDXmFycLCn1wfx3U2LaiyGD
 S/QETJODtlqcTGH1K6JFAu9Q+MSG3pt4vPAYCz9keN9NKWGd6hraRrsyOeDxLRkhQJREsfuieCH
 MB41sRy836edCPg==
X-Received: by 2002:a05:6214:5094:b0:896:fa50:4c0c with SMTP id
 6a1803df08f44-89a66ab1b47mr37732406d6.53.1773243649499; 
 Wed, 11 Mar 2026 08:40:49 -0700 (PDT)
X-Received: by 2002:a05:6214:5094:b0:896:fa50:4c0c with SMTP id
 6a1803df08f44-89a66ab1b47mr37731746d6.53.1773243648878; 
 Wed, 11 Mar 2026 08:40:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65cfd520sm16072086d6.36.2026.03.11.08.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:40:47 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:40:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/8] tests/qtest/migration: Force exit-on-error=false
 when appropriate
Message-ID: <abGM_oxlF_WsrgeS@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-5-farosas@suse.de> <abCDJyknIzzX8dUy@x1.local>
 <87o6kvz8sp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6kvz8sp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 06:14:30PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Mar 10, 2026 at 10:55:37AM -0300, Fabiano Rosas wrote:
> >> Some tests can cause QEMU to exit(1) too early while the incoming
> >> coroutine has not yielded for a first time yet. This trips ASAN
> >> because resources related to dispatching the incoming process will
> >> still be allocated in the io/channel.c layer without a
> >> straight-forward way for the migration code to clean them up.
> >> 
> >> Since this is an issue only affecting testing and leak detection,
> >> let's make sure tests only use MIG_TEST_FAIL_DEST_QUIT_ERR when
> >> strictly necessary.
> >> 
> >> To make this process easier, force exit-on-error=false for precopy
> >> whenever the expected test result is MIG_TEST_FAIL. The distinction
> >> between the two return codes is exactly that, the latter should never
> >> cause exit(1).
> >> 
> >> The affected tests for now are the TLS tests "no_hostname" and
> >> "mismatch_host".
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration/framework.c | 5 ++++-
> >>  tests/qtest/migration/tls-tests.c | 6 ++++--
> >>  2 files changed, 8 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> >> index 4cc63bba7b..cfb8409d33 100644
> >> --- a/tests/qtest/migration/framework.c
> >> +++ b/tests/qtest/migration/framework.c
> >> @@ -854,7 +854,10 @@ int test_precopy_common(MigrateCommon *args)
> >>              in_channels = qobject_from_json(args->connect_channels,
> >>                                              &error_abort);
> >>          }
> >> -        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
> >> +
> >> +        migrate_incoming_qmp(to, args->listen_uri, in_channels,
> >> +                             args->result == MIG_TEST_FAIL ?
> >> +                             "{ 'exit-on-error': false }" : "{}");
> >
> > Can we set exit-on-error unconditionally?
> >
> 
> Yeah, what about I just remove MIG_TEST_FAIL_DEST_QUIT_ERR entirely?
> Aside from the ones mentioned in this series, there's only one other TLS
> test using it. There are two tests setting qtest_set_expected_status(to,
> EXIT_FAILURE); after migrate_cancel, but we can just wait for FAILED and
> then qtest_quit(to);

Ah yes we have one left.. Sounds good, can also be done on top if you will
queue this.

-- 
Peter Xu


