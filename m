Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25941D216AF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iOm-0003QV-Hf; Tue, 15 Oct 2024 10:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0iOa-0003A8-Hn
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0iOY-0003Se-MG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCPZMCKdhv3l1yXUJeBWOYjSEV/7TCtTF9DVLMqfKLk=;
 b=ESP39H61JyGmtqF9XK89klDYegDJ5tT48ioHt5ZrCBkEyeQXC5mTLS6eO1ZHGU06KAGRti
 QesJpjqjv737Q0ykaxG1W6Wc0bGlPNh8GfZL8DrNmxmnL1GTR5bjzEVhJPYqrvI/b5IoAa
 +gg7W5ytAXto5DOsQq06PATKJHsMVJM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-GEPr2wevNzCqr85gvTRK4A-1; Tue, 15 Oct 2024 10:19:26 -0400
X-MC-Unique: GEPr2wevNzCqr85gvTRK4A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a803adfe52so803239885a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001965; x=1729606765;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCPZMCKdhv3l1yXUJeBWOYjSEV/7TCtTF9DVLMqfKLk=;
 b=GzcE5w/KuixGUdn9gNo11SwEPoXYXJxAEtonZ6UbgY1di8Q/klyBk+fijxL8yldixt
 Wg8vNR5Wdv3v11dvNVYNC6h9PvseVQdEXio7+WZTZe1goBDyZqILZk8VsL7hV6aHrqi0
 tKYybxD9XLFxjVy6UtR37SrdNXfD2G9bxVIJQkcg/24/mpOp5RkR/+OvNHS6mbJ/n9C8
 LOfRlp/f4+cj0JwBwF/L1uZS4zZzXp3HL9cJSI7M6/XxuBqGGbR2m60/Qqh4uFi+bF6Y
 1AnKzCv3tfuXZxeKnBM4atIV+xn1g0MOMn4M9XwWGpDupDfUiunfr+jCU423m47qpt6c
 8HxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxIZ2HV6NYgUVjbHbER1lE/yHy/zLRvPy3e3J2bMVWt1py/MCUOIXksS0USmAnYWtE6IUBSrrYseXw@nongnu.org
X-Gm-Message-State: AOJu0YzLrXM8znJ3fdWjWDv6Z4Y0fWj4JSwtfXmGoxQliYJy0pwbvYsu
 VLT0EEqXl0GWCaM/gKzyQpsPv+E1AzUGCWiKy20TBFkELf0X4YV+p9utpmTXhGl9YS/u15FLiiC
 i4f24x9YcQmep/EPNVfz9Ba48en4XVFrrSLW2yHwQGVrDRMH8rR53
X-Received: by 2002:a05:620a:4153:b0:79f:1cf:551e with SMTP id
 af79cd13be357-7b11a35f634mr2075467285a.5.1729001965319; 
 Tue, 15 Oct 2024 07:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXeN+6RprUq+P7dTl7oHO5aMwMSn0UJjSNTt6OXI/FqhvPmfO3pu+0AkqMo7qBFWlXYUg1Rw==
X-Received: by 2002:a05:620a:4153:b0:79f:1cf:551e with SMTP id
 af79cd13be357-7b11a35f634mr2075463085a.5.1729001964887; 
 Tue, 15 Oct 2024 07:19:24 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363b406esm74459585a.116.2024.10.15.07.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:19:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:19:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Julia Suvorova <jusual@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
Message-ID: <Zw556tC3wfbtMdFd@x1n>
References: <20241011153417.516715-1-peterx@redhat.com>
 <Zwzv3gKV3UibdzTs@redhat.com> <87msj6rcgy.fsf@suse.de>
 <Zw0uPSldQrSYg6e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw0uPSldQrSYg6e9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 14, 2024 at 03:44:13PM +0100, Daniel P. Berrangé wrote:
> On Mon, Oct 14, 2024 at 11:22:21AM -0300, Fabiano Rosas wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Fri, Oct 11, 2024 at 11:34:17AM -0400, Peter Xu wrote:
> > >> This reverts two commits:
> > >> 
> > >> 671326201dac8fe91222ba0045709f04a8ec3af4
> > >> 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
> > >> 
> > >> Meanwhile it adds an entry to removed-features.rst for the
> > >> query-migrationthreads QMP command.
> > >> 
> > >> This patch originates from another patchset [1] that wanted to cleanup the
> > >> interface and add corresponding HMP command, as lots of things are missing
> > >> in the query report; so far it only reports the main thread and multifd
> > >> sender threads; all the rest migration threads are not reported, including
> > >> multifd recv threads.
> > >> 
> > >> As pointed out by Dan in the follow up discussions [1], the API is designed
> > >> in an awkward way where CPU pinning may not cover the whole lifecycle of
> > >> even the thread being reported.  When asked, we also didn't get chance to
> > >> hear from the developer who introduced this feature to explain how this API
> > >> can be properly used.
> > >> 
> > >> OTOH, this feature from debugging POV isn't very helpful either, as all
> > >> these information can be easily obtained by GDB.  Esepcially, if with
> > >> "-name $VM,debug-threads=on" we do already have names for each migration
> > >> threads (which covers more than multifd sender threads).
> > >> 
> > >> So it looks like the API isn't helpful in any form as of now, besides it
> > >> only adds maintenance burden to migration code, even if not much.
> > >> 
> > >> Considering that so far there's totally no justification on how to use this
> > >> interface correctly, let's remove this interface instead of cleaning it up.
> > >> 
> > >> In this special case, we even go beyond normal deprecation procedure,
> > >> because a deprecation process would only make sense when there are existing
> > >> users. In this specific case, we expect zero serious users with this API.
> > >
> > > We have no way of knowing whether there are existing users of this, or
> > > any other feature in QEMU. This is why we have a formal deprecation
> > > period, rather than immediately deleting existing features.
> > >
> > > Yes, there are plenty of reasons why this feature is sub-optimal, but
> > > it is not broken to the extent that it is *impossible* for people to
> > > be using it.
> > >
> > > IOW, I don't see that there's anything special here to justify bypassing
> > > our deprecation process here.
> > 
> > I have no dog in this race, but as a data point, I see that this was
> > submitted to libvirt as a new migrationpin command:
> > 
> > https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/FVNAUEVIMLG6F2VCRKHZDUEOLBJCXQHO/#BVEGJVZMMLQMXE263GO5BSIWUDIYIFZU
> 
> And unforunately it seems we dropped the ball on reviewing the v2 of
> their series and they never ping'd for a response, so this was not
> merged. Possibly they're just running it as a local patch to libvirt...

If any of us wants to make this working properly, we don't need to rush
removing or deprecating this. Instead we may want to discuss the proper
interface, using the new qmp cmd name that Markus suggested, then (maybe)
deprecate the old name only.

I proposed direct removal majorly because of the two things I mentioned in
the commit message as major design issues:

  (1) Migration threads are dynamic so created with short windows that
  they're not be able to be pinned by the mgmt.

  (2) Only sender threads are reported, while at least recv threads are
  equally important in this case.

I proposed direct removal not only because I want to avoid further fuss on
this API from any migration developer - I think we already spent more time
than we needed.. on this 100+ LOCs.  While, this can be reintroduced in the
proper way again when necessary easily.  Meanwhile I also wanted to avoid
new users see this API at all and use it ignoring dest threads even during
deprecation process.

Jiacheng is in the loop.  Jiacheng, do you want to chime in here?

Thanks,

-- 
Peter Xu


