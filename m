Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2ACE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJce-0001ri-Dn; Thu, 05 Dec 2024 16:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJJca-0001qO-IW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJJcX-0004Dt-2M
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733434967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXyiWJBF/LWcXHsKXYdo6v/1PbCNNvvQoknDM7rns3s=;
 b=Igr53SEA/U6t/4o1xafSg9DCz4xvEl/hr+EyeYB71PhvHph1B7KBeMGfX7QbAsElHYTHtc
 PkfXSECc+8+xEn+lEerdvUgIOSC0rIz9fQsVhSwslp49f+iw9Jor3RyhTrIkSvJtz7ZH7h
 4DN1YQYAOQz6qe0NcuDLBJAqEz8ySfg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-BjaqHUzeNpW7nxvfPgQrkw-1; Thu, 05 Dec 2024 16:42:46 -0500
X-MC-Unique: BjaqHUzeNpW7nxvfPgQrkw-1
X-Mimecast-MFC-AGG-ID: BjaqHUzeNpW7nxvfPgQrkw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6732101a6so263749685a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434966; x=1734039766;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXyiWJBF/LWcXHsKXYdo6v/1PbCNNvvQoknDM7rns3s=;
 b=M0BsbjfJ9/ISvFCjYJ5KNWf+3ApVKp1S/Im0VzOzoKUc25ub3gFKTybFdaN5ppoAXE
 HzE3ea/KPUB25vPKdX3s1or6s0JV76/Z3/1NXUqKdUcNJe7Luq3rtJx+x2ElqxBIkoGZ
 tL16AxWIgUkz23gvzds0Ws8RqMabX8+027DgtBhEeNOwZiAdueH9fl08G48LF6IUB5S6
 QqCsBluP5GvTrIHMUf6IsnT4q4VBcHKC3VrK8Yeq4fo1XU8WtB6YKJCCHBSvSgY4KJYY
 LjeBmdqunHaxkKp5sKfqVF4hjHXaqCJJa5B7N5mWhlbylc1U/vYEfJT4rJi98nUUJQEy
 eesg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXaPZVEZ58dmKACKf142VJQ91fE8TiCk8dYjpSqg98Zb01HHRrQ1Lkt0uRF8FgGa2+k6Y0GAY2Qov0@nongnu.org
X-Gm-Message-State: AOJu0Yx2TB6HaP2kzL0mjvvBjwTZz9spyPBfT4eSFmIn0dZaJs8l6OQV
 T+2Q/l64f1aSNijSf94jOgsElUy6egDZQ5z4CxVMbnojSQeX4xePb6XC3Bc1QmHF6C0GYjapvw2
 c5apKDNUuVguZU5ycrI7gIgtWSxuJ0q+x+RZiGcQjIyDoxALCgjVo
X-Gm-Gg: ASbGncsP3StCmUSn9SUZUQB7YeNI/nJDsZLbEtxBWQovwaLk5wSCgSW0f6ZaSq+XOeH
 X4oVzhYWdLAGopANykOgFwsRdYiM/WN5jUylTgurGWWyMIDAgLHON7Q4zC9ilYYRBFOUNyToPFi
 Kp8dWtcnYxfA2/SwTavhV2F9Sy6q6qPT2pjtmVGlp8mQsZpqkVJ9YGwfSN/6nx0RAI3meOWKszB
 ysecbV9F4LLFt0lui4zJdn9uSF8/JfgWVSv6K9mVxBIgYjD0x/VYlP6jAZmA/EsAQ4q6V3wV3la
 RghHeBoMlTQ=
X-Received: by 2002:a05:620a:4507:b0:7b3:5858:1287 with SMTP id
 af79cd13be357-7b6bcb45290mr138944185a.44.1733434965808; 
 Thu, 05 Dec 2024 13:42:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9EsSqPb24nC+8N5OuHlnRGoxxWdxfP29Ghs+BukHrqy5GixbDZGyv1uICKGWiwZoQ5epLpQ==
X-Received: by 2002:a05:620a:4507:b0:7b3:5858:1287 with SMTP id
 af79cd13be357-7b6bcb45290mr138941085a.44.1733434965454; 
 Thu, 05 Dec 2024 13:42:45 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e8d3sm99943385a.98.2024.12.05.13.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 13:42:44 -0800 (PST)
Date: Thu, 5 Dec 2024 16:42:41 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/24] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Z1IeUbDe2pMdyJfD@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 05, 2024 at 10:27:09PM +0100, Cédric Le Goater wrote:

[...]

> > Important note:
> > 4 VF benchmarks were done with commit 5504a8126115
> > ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
> > reverted since this seems to improve performance in this VM config if the
> > multifd transfer is enabled: the downtime performance with this commit
> > present is 1141 ms enabled / 1730 ms disabled.

[1]

> > 
> > Smaller VF counts actually do seem to benefit from this commit, so it's
> > likely that in the future adding some kind of a memslot pre-allocation
> > bit stream message might make sense to avoid this downtime regression for
> > 4 VF configs (and likely higher VF count too).

[...]

> I did a quick run of a VM with a mlx5 VF and a vGPU and I didn't see
> any issue when migrating. I used 4 channels for multifd. The trace
> events looked ok and useful. We will tune these with time. I wished
> we had some way to dump the thread and channel usage on each side.
> 
> A build was provided to RHEL QE. This to get more results when under
> stress and with larger device states. Don't expect feedback before
> next year though !
> 
> Having a small cookbook to run the migration from QEMU and from
> libvirt would be a plus.

Cédric,

Did you test also with commit 5504a8126115 and relevant patches reverted,
per mentioned above [1]?  Or vanilla master branch?

I wonder whether it shows the same regression in your setup.

Thanks,

-- 
Peter Xu


