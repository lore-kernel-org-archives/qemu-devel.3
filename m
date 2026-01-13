Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD29D2F35E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfjaY-0002tq-Fo; Tue, 13 Jan 2026 13:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfjZ8-0002me-GP
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfjZ5-0005pq-4G
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768330585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reko9w298o6jWNDWosmuAMSax8bMqyxzRVAiUIt2M1A=;
 b=MPYJnCN+GJz35mKgrZupWb2SxVXQm/OghCx6Z+K9CFYaCn74BUIOZlzz+diTXXvF1wBN7W
 igikNjci6d49JSomKl8tiTmzczjAEYigpXrSnmjAtQ5Kpj8Vlf6uHbKzbDUm3tSRnWOf8b
 N6L4j+OkjR4F2AegwuXCqYo7PELPolM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-xLst_ChxMFS4x8EpMtvAqQ-1; Tue, 13 Jan 2026 13:56:23 -0500
X-MC-Unique: xLst_ChxMFS4x8EpMtvAqQ-1
X-Mimecast-MFC-AGG-ID: xLst_ChxMFS4x8EpMtvAqQ_1768330583
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4f4a92bf359so223219181cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768330583; x=1768935383; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=reko9w298o6jWNDWosmuAMSax8bMqyxzRVAiUIt2M1A=;
 b=jrKzDJsl9WZsyI1EV83xDE8N+qpUuBLqb2VUDskCnQhmbzIE9K14iu7q1fjCheMM75
 dKO1/kLYKRhzPE7gM/tUDiJuVbrHzo8YLksbTAsaefH2w3+4TbTY0WSz6ntrx7YCaRdu
 3VXNT/3T2w5cM4p4SMdZLjR/XtVjOb069Bqi1m3STkm/FDNRfrLVQpyna5WpJ19BqjNk
 HTnPIah9vsa0cuC2qutGE+zlgJj/hxa+5UhsifvAkwQtNCJWB+RpP6ztcbM87FppLzmI
 Aht/+5asqsyQdFBYyv/fBwGvPL3mrDCJnGMXxaxYaOPeEYAhtwsVQyAoE6j8A9WWAZQF
 mYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768330583; x=1768935383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reko9w298o6jWNDWosmuAMSax8bMqyxzRVAiUIt2M1A=;
 b=PEqwtBQGSNJXeyx3le5xbniBOwTOlSK2OcP3LEmRE1a54Bbe2w0MZX4ol3kItx8bZv
 Rn0ExqUN6DL92wj67birmCtEz1uceNpUcuzttJrQxT0CQZZiiJFw6qYnVmibPoJ23twy
 8kSeqg3B6sic7QmqjNLhCWqeK4U3cRggvPI+Tr/NkwnTEKJQv/Ipv7TquQ+qXbOd/VXU
 s6ueOIz3u3gvixUhcPRuWTNSNXdV67rrKfmVs1rRL4ioBB0PfhIYxGgahs9Ri1cq5B3n
 0Ie1OPlAsRgERGEZzNa4+YKS9a5WZHIgusve3ZGaUcOoNoqm31qNV6faOgyd3uVodCnP
 hdfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHEoE7icXY8ZBdOupP8Z/a6RNPmTyWBG/KatXKf13oMoqYtFFvBt4ptAiULkPii37wTRrZIp/oQu1s@nongnu.org
X-Gm-Message-State: AOJu0YwqrNJTz4+HfxOYr/YyYf+A30L51yMrs93NNMunxKRkQfEYg4pH
 LqNh5lzUNlKi0oiDaLGh+qAFzsLS/VRVy5P5B1a8S/KB18ElRMoJVlom0TpL71qYissVtjswULy
 zagKXTMSv7H35fb5LjwNzRzShXLHMTZin174QB22zZCh8E4RJxoPo8jen
X-Gm-Gg: AY/fxX7X5STCV6zpxRzq21tz8rX7HBP4UR0Kb8Y5O3YxgJ0jbCdPbP6+2oyIHKk1TkJ
 WW8uaSSrVud7TBOh+LDUlVvu6tfrmTHCKTeymNOqZn+rO6zmVWTv5mc3ceoAw08+gJaoltjwuMy
 KVW4boeecJHw51ieaQYd7YbH2clbRBZiBNsbnehBFp8bP+bX6dfuFaOv+BKtZVIWKaDqWQICCvW
 xrotG/uB6/8YAwwYTwNp9Pux1QOTFaNt1i8PNCEDJw6dtcZKgWprKAirtXXRwoXwzBDEd+iXLz4
 D3veSVQ+sIoEVjHjXTvKZzZUdn652MkROonIQMADz7ADLstgU23ZQJvT7F4xECqUx/j3s5yDx4s
 Ycwc=
X-Received: by 2002:ac8:6f1a:0:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-501481e3cddmr2501541cf.6.1768330583063; 
 Tue, 13 Jan 2026 10:56:23 -0800 (PST)
X-Received: by 2002:ac8:6f1a:0:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-501481e3cddmr2501221cf.6.1768330582672; 
 Tue, 13 Jan 2026 10:56:22 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d3d34fsm145674301cf.4.2026.01.13.10.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 10:56:22 -0800 (PST)
Date: Tue, 13 Jan 2026 13:56:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 0/5] support inflight migration
Message-ID: <aWaVVJh13ctiW9Ku@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113181242.GB528940@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113181242.GB528940@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
> On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
> 
> Peter: Please review the migration aspects (especially the vmstates).
> Thank you!

Looks good from my side as long as it's based on VMSD, I appreciate that
change from the old versions where it used to use qemufile APIs.

The major question here is if this series depends on Vladimir's other
series, while there's still one patch that is not-for-merge:

https://lore.kernel.org/all/20251016114104.1384675-24-vsementsov@yandex-team.ru/#t

Does it automatically mark this series RFC as well?

Personally speaking, a new migration cap would work all fine, we should
have discussed it somewhere previously.  Said that, "local-vhost-user-blk"
capability is likely not the right one.  IMHO it should be either "local"
or "fd-passing" / "fd-passthrough" (or something generic) as the name.  If
we are not sure if we will leverage more than "passing the FDs around", we
can make it as simple as "local" as a new migration capability.

Then migration's misc.h should export a function migrate_is_local() then
device code can probe that in its own vmstate handling paths on save/load.

A note to Vladimir: please remember to add a check to enforce UNIX socket
when a formal patch 23 will be proposed some day, no matter what is the
name of the capability.  It should fail qmp "migrate" or qmp
"migrate_incoming" command if the main URI is not a unix socket.

Thanks,

-- 
Peter Xu


