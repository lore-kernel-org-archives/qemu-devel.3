Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92005C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJ4V-0000HJ-9b; Fri, 24 Jan 2025 07:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tbJ4B-0000Cy-Rf
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tbJ4A-0004mp-FX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737722740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjcDSNTY2cA1q2EoyPuFf9MNNW8AsDSC7KqdFZ2+iaE=;
 b=LCWwyyhp/dd2mW2LzarRYyPdCnC2VTaqh5n5nGfbScJh5mxXy8LCAKeAy98l7uIWW1g1Ba
 cbSV/Cq6LVAhRtyxbr0tjeSVQ+7B5iwoH4DGNxk0LiWrOgBvPPnXeJnbB8uJybhB+/G1Qb
 ZkyqWr2t3o51AEq6qOTZOKmIgBxt8as=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-uKm2FZJgNo-eGJY2AVA1xg-1; Fri, 24 Jan 2025 07:45:38 -0500
X-MC-Unique: uKm2FZJgNo-eGJY2AVA1xg-1
X-Mimecast-MFC-AGG-ID: uKm2FZJgNo-eGJY2AVA1xg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so14553365e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737722737; x=1738327537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjcDSNTY2cA1q2EoyPuFf9MNNW8AsDSC7KqdFZ2+iaE=;
 b=Ej8e2z5/hs5Im/y/aQLuU37xCRJzroR8xsmrjlGrJZQ1XOV5MsucS/Ecp+lzj26lXF
 pei/CtrMgbM9qhnvW81udE7wGEoMf+S1J+FgR+Ye1wvECsE5THr+nNm6O9K5UMOBaRCZ
 YkJgvjf/bo2/T4oIEFmPZM0OSWh22HX31ec4diDaikODk+ud6MBQyg7Tq0plPN6DryfB
 mHJXX7cbcX4ZVE6U3mPSMVPBfBxTl104sf2xe2xyfnCRTIkGdn6HPPXlX6/fswDplnQK
 smS6Zb4EBqgaNVwB0WEjjqThgrHULbhRp3t+YbFFie2FjkUalU11XlYzy+6bf8nsjUF3
 iGKA==
X-Gm-Message-State: AOJu0Yxj8WGCTp7fTR3KKz8gtn3KnzW4xA2kEhnqZvOYLbe2sG30JnMP
 joe+bWR1yj8DO/JkvEgGdDnXnnwaMGdW4FashhBjqwzWNE9Kq62dXerpP9IKFDofKnVL6nzaTJI
 i/glJBViXR93c5rgCQSZT5QuXbx0UG9nq6OO8r9QA8JQPMEZxBA8wPcTgeiYPBmva/g9lYMS5lj
 aCbH0W7jABOE6CD1O/zHCY/6N6zAM=
X-Gm-Gg: ASbGnctOElizxhjMSqwstPUrRAeioPtjNUPRiZW/zWpGkX9bem7rcKm4JruishXCHJX
 ZNnSiBEXMrNi/I3sgU+IALrw2R7yRIGV3+Ncin+mNfGRorCNqZ46x
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr274596755e9.29.1737722736937; 
 Fri, 24 Jan 2025 04:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfRbf4rU3eO7t4t0krMyw0BOiXiWEWd+qB/OyselHXUSEOywC1K+HTyyLI9nA8fv+IA12x/bAC6qAkJgbZhfs=
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr274596515e9.29.1737722736562; Fri, 24 Jan 2025
 04:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
 <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
 <Z5EYbBXkjTu98rHk@x1n>
 <CAE8KmOwvp=LJ+79t9VVsZqf4APqSYxqCQVmYSg_5QaVD4vzLWg@mail.gmail.com>
In-Reply-To: <CAE8KmOwvp=LJ+79t9VVsZqf4APqSYxqCQVmYSg_5QaVD4vzLWg@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 24 Jan 2025 18:15:20 +0530
X-Gm-Features: AWEUYZnDMgmT5oBqycFtWmuWg1t2TO5uOWCFdjskxPocGykLowy-AMmR-INomEg
Message-ID: <CAE8KmOywe888S-oCoO=4=oFsXuN=AfuuqvT27LGor-UTC78YoQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Peter,

On Thu, 23 Jan 2025 at 16:39, Prasad Pandit <ppandit@redhat.com> wrote:
> On Wed, 22 Jan 2025 at 21:40, Peter Xu <peterx@redhat.com> wrote:
> > I believe many of the tests can be avoided, but still below is a list of
> > minimum tests that I think might still be good to add:
> >         # /x86_64/migration/postcopy/plain
> >         # /x86_64/migration/postcopy/recovery/tls/psk
> >         # /x86_64/migration/postcopy/preempt/plain
> >         # /x86_64/migration/postcopy/preempt/recovery/tls/psk
---
$ ../qtest/migration-test --tap -k -r
'/x86_64/migration/multifd+postcopy' | grep -i 'slow test'
# slow test /x86_64/migration/multifd+postcopy/plain executed in 1.28 secs
# slow test /x86_64/migration/multifd+postcopy/recovery/tls/psk
executed in 2.43 secs
# slow test /x86_64/migration/multifd+postcopy/preempt/plain executed
in 1.52 secs
# slow test /x86_64/migration/multifd+postcopy/preempt/recovery/tls/psk
executed in 3.32 secs
---
* Postcopy tests are working well with setting 'multifd = true'.

> >         # /x86_64/migration/multifd/tcp/tls/psk/match
> >         # /x86_64/migration/multifd/tcp/plain/zstd
> >         # /x86_64/migration/multifd/tcp/plain/cancel

* Above precopy tests already enable (16) multifd channels and they
seem to test scenarios like: resume after migrate_cancel() or precopy
with compression (zstd). Enabling 'postcopy' here is not the same as
setting 'postcopy=true'. Do we really need to redefine these tests for
postcopy migration? Does compression (zstd/zlib etc.) OR
migrate_cancle() work with 'postcopy' migration? Just trying to figure
out how a 'multifd+postcopy/tcp/zstd'  or
'multifd+postcopy/tcp/cancel'  tests should work.

Thank you.
---
  - Prasad


