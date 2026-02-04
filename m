Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789A0E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfqB-0001QK-1F; Wed, 04 Feb 2026 11:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnfq9-0001Nt-Fp
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnfq6-0007ba-4S
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770222888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oY8KOJdhGNt+O5Af0JVJ/3HB5xDUOukmnkBI54I6fmc=;
 b=HyBHn7nLkGX3KPF2uYZrZEmUYBK+RuV43uPS+jMVbqvMD/0dalzaISQRq1pnVxDK5vppJI
 0aUozCrC8FoAbNGAszOK5e5thM7JzeTOD56sbuNbQp6hIq+eX+vAq2plarIHUgzxG6bbG0
 Y+cdUIGx3QsxmQ1gb23cMOrxejxRCLQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-CG-xeoODOV2gcEUIRmbC6w-1; Wed, 04 Feb 2026 11:34:47 -0500
X-MC-Unique: CG-xeoODOV2gcEUIRmbC6w-1
X-Mimecast-MFC-AGG-ID: CG-xeoODOV2gcEUIRmbC6w_1770222886
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c70b4b53e4so3065661685a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770222886; x=1770827686; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oY8KOJdhGNt+O5Af0JVJ/3HB5xDUOukmnkBI54I6fmc=;
 b=MmspIU0cpj4x7wIhhCUT6z4DcqngS8r4xk9cc73inDJkHjvD5RAVToaX4avMfqilZg
 TpecApGLJKReTarHLOBV0p5GM5J9i4xinXF+uTEVlnlfBj2JgphA+r0oIsx7JQE/DjAu
 +5LKiyQRrsUlm6m/DKV2LlDn1NtbFQIFk+Pb/ufvCE7tqQ0RIkiH/B6xoGJkag24CFli
 wHf0fka8jHl13U7CDT5+ouf/kagGLf6uNtAsjGeW8teaBiCBz6S6CXFl7dUYe//GrfS4
 GyWLbV+AwHUgEmGQO0UitLFfmauL4QeAgyN9mq49BUy/FSA0JiHgbmaTg3IeX3EzRfk6
 oyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222886; x=1770827686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY8KOJdhGNt+O5Af0JVJ/3HB5xDUOukmnkBI54I6fmc=;
 b=Etf9MxpbveULRrxTkUgCYQXkhYVQcS5PphWv6d/4NP5I4SQM2OtDgtE6BBP1P5M7Vd
 1HH/ZNHgbLrncZIVNh+EApWO4NyuMaYQo3V+SWIaYe83dcwLDlFGb+ahiOQQ2likYlpC
 VYuYdF/50cidkndeNozexwnOXordOp+BaC0nPiAdj8LMJSN5HUivz6FbErzpVcvLp8m7
 Hg1O2j/pe5mfPQcDlKi8Bhn9eMsb/XyEUv58f6VywWtZrUgGf2LWdiJci4dfMttWmEg6
 iyhUyfDCGsFv9YzkCKHjeorQS/kZpSPoc4p/FRxX9EnodrSacQCF0+3b0dZWYa0VdduC
 jcUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5qnF6i/FbMvCQO1BHGIvt8nXILaNbkdk3qx49ZpDNjhYcY21kTdZDIB+HpPPgmMxKTtY61siKG1ai@nongnu.org
X-Gm-Message-State: AOJu0YwaUshZLYGHw/0rz6gHzzfsIet4iV/gqq4olESAYHB1cOjCUA3S
 RIaOFIDS4O5psp0J2QJOP13RIxwlaarEQztzBmvBKgum1juLfh6qW9Qeo2d3tJjLOy8TBAiom3w
 N6Ldv++cb2iyN9unBnjbNeaRP6/ZEjkhToV8OBX5PHtVhkDADdTC3YV3X
X-Gm-Gg: AZuq6aIFoobamjaPWXzkm0DjqFuDyG2bygQjDg3z59oxkHfZ1DMw/PnipG1CHR1ZQID
 yLLruvyqCe6xnraxNR0KaJcZtIpYx4NJ9tGol+ydwXoLHlmBQHplMwTewIHTjW9SyeB7EAOwY9H
 sB45L+OtfOE67D+A8B39m7wKpcx60p3X4/DMIfN8qU1/LNc0R4e+KJ4a1jrf8HgtMf8PwY4wVOO
 9FaZSpHJXGWC6oj6bGLTdd+wNDmMRM/HY0ELm4Mw4cf4HqiedqAS/vbCSnstea7lQA24G+/Arki
 90COh4YZyBvUy2fwaD/lZTrg8wa0hCkWoQqbi//biNTRxvLKcg7e+6Udyrefvd3M/gux1jovf5v
 utoc=
X-Received: by 2002:a05:620a:4d97:b0:8ca:2e36:18b3 with SMTP id
 af79cd13be357-8ca2f9af961mr318807585a.50.1770222886177; 
 Wed, 04 Feb 2026 08:34:46 -0800 (PST)
X-Received: by 2002:a05:620a:4d97:b0:8ca:2e36:18b3 with SMTP id
 af79cd13be357-8ca2f9af961mr318803685a.50.1770222885542; 
 Wed, 04 Feb 2026 08:34:45 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fa5576csm224521585a.2.2026.02.04.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:34:45 -0800 (PST)
Date: Wed, 4 Feb 2026 11:34:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Mark Kanda <mark.kanda@oracle.com>, "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Message-ID: <aYN1I0WMl6vqaZx4@x1.local>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local>
 <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
 <aYJJ17xU2iQmk5sQ@x1.local>
 <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
 <58d40cb1-a5fc-4dce-b843-2b08b79c477a@oracle.com>
 <aYJe6mPCR_XLVX8p@x1.local>
 <0296eb32-4a67-4f46-bc5c-e4d5f1fa642d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0296eb32-4a67-4f46-bc5c-e4d5f1fa642d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 10:56:58AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> I think, rebasing is not necessary, as local-fd migration (this series)
> should work together with CPR, and even with CPR-exec. So Oracle can use cpr-exec,
> and simply enable backend-transfer for virtio-net/tap, and it should work, I
> remember we discussed this with Steve. I didn't yet tested it, but I'll try to
> add a test for such setup.

IIUC it should work for cpr-transfer, but likely not cpr-exec.  cpr-exec
requires removal of FD_CLOEXEC for fds to be persisted.  See cpr_exec_cb()
where it invokes cpr_exec_preserve_fds() (only on top of cpr saved fds).

-- 
Peter Xu


