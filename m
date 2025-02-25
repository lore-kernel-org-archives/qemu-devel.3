Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E7C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtSh-0001PZ-3R; Tue, 25 Feb 2025 06:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmtSd-0001MG-5X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmtSb-00058R-Ee
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740484247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwDjm8vm7eQhqe3yePHdCUAi2UAJOq9xRsdRLYnmRGs=;
 b=S+w0NMGndIc8P4ynjLAqoIsxLyU2RySHX8yf/IpN/06PdIp4eNpwU+6Fy/qz/80uT4vDUT
 A6X1VW2ib3G66CB/tGutvXoogjhyAkWJ1G1jHLEKGZSIQMKRTa4rZgtMC7yYxgX0xXL0o9
 WSXSn7PHqrqP/JRCq73sD/g7zwyaFi8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-9ts8nwIcP4eylHsavGkEoQ-1; Tue, 25 Feb 2025 06:50:43 -0500
X-MC-Unique: 9ts8nwIcP4eylHsavGkEoQ-1
X-Mimecast-MFC-AGG-ID: 9ts8nwIcP4eylHsavGkEoQ_1740484242
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4399c32efb4so27248125e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740484242; x=1741089042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwDjm8vm7eQhqe3yePHdCUAi2UAJOq9xRsdRLYnmRGs=;
 b=gn/gGWLd29cYpUqycB5tWSBJhtwKhKFPHCcdCDUJyibncvLd80Gam1/Y4EMxipTz//
 oWruCBtV6RLdc8BZ1Y6PC0UnWcvd4b1s+pwqUee4QM7i+iB9Dn5zXmTjzoajqTdk/Nh1
 BKrH7aQ5V+qeQ1Ze+qxTZuwZ+ShFg68GM6EJWy+RBnK9E2kwpaVnWLIf9l9NAnFLnXiy
 gZ0YGB83vg2+MaGLI22SNsWjctedxXyu7oF0umv41LZsiPZ49w4kpR0O7JCvy/R3MJpZ
 iC9mSC2wt53RwAm90HuG7GzCmcFN70zWbmam6xJgzotT4jEjSajRsG33S/xi3pAjnuZQ
 3eTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtWLVqiBBYv8W542YA/SQ1BFhcr5r2Cbbxcch6IzTL+ldHT4IfxydJ6j4vYEC4J1cDJYz8cVdLhKBr@nongnu.org
X-Gm-Message-State: AOJu0Yw3i4flImjn3gWxEbY5BZ54Qz2tUMe3FMYu8dwwCHW6ujxBSLhc
 ViDZ0HcwnXJk3J+zS5eCGWH81NRJP+uW/L+iXOZsaYvSdgbM0C84J7tF/3SlNUyKs2l22T87JkR
 hXw0yZTVaMaPXyrodTU3+0b9NZf87jG3pCLgpqrf/0CLefekGC3nC
X-Gm-Gg: ASbGncu/2q6Gaq+oPDG+jUYKAurDddE6GMXBH+1o88h58n5OBTFQ3uI7rTxXgyblXuc
 CplVrWz0r85TCQvgpOLsdi3eONdelr+AJfj+aayjQD2EWe2Qrdaxs4xc5qj24qM3AZGLVLYft1V
 Mtv0pq6CKPR+H58a4WisdMMzurwVf2zZNi1Xc0TZcgm/OQDuoFJ8/O57YA9BsWv5BTOi56MbpBG
 KwQkPtHyPULsm+HaNlmWMd636LRF8bllgGzO9FD2mQGkJhrbDlAoRmQLlLUr/vFHKx4oh5UXwxI
 uDF2DfjNXv3FCp3MLJfYpJ9IEOZJVoDhtSznj2s0F/M/eZqSSeJLfNiBHLGHaRE=
X-Received: by 2002:a7b:cb48:0:b0:439:9384:7d08 with SMTP id
 5b1f17b1804b1-439a2eb3e29mr174507705e9.2.1740484242298; 
 Tue, 25 Feb 2025 03:50:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQzgpa22yZpFzBLfDH/CX4DhtyP9YGvR5I1CvEiJvHTEhgMJzAq4pWg9GFwnDn4L0fhNBEcQ==
X-Received: by 2002:a7b:cb48:0:b0:439:9384:7d08 with SMTP id
 5b1f17b1804b1-439a2eb3e29mr174507505e9.2.1740484241932; 
 Tue, 25 Feb 2025 03:50:41 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab155eba2sm23502125e9.27.2025.02.25.03.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:50:41 -0800 (PST)
Date: Tue, 25 Feb 2025 12:50:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <20250225125040.2567cd40@imammedo.users.ipa.redhat.com>
In-Reply-To: <Z4f0FmfT-FnwN8yI@x1n>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
 <87zfjtfu3g.fsf@pond.sub.org>
 <20250115111928.17950323@imammedo.users.ipa.redhat.com>
 <Z4f0FmfT-FnwN8yI@x1n>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, 15 Jan 2025 12:44:54 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jan 15, 2025 at 11:19:28AM +0100, Igor Mammedov wrote:
> > Another question is if it's safe to move/rename device withing QOM tree
> > wrt migration (i.e. when 1st instance has old QOM tree and 2nd a modified one)
> > 
> > quick smoke test works (migrating from old qemu to a new one with this patch)
> > But it's better to ask to be safe.  
> 
> I had a quick look, taking the simplest qemu64 cpu, I see two vmsds: "cpu"
> + "cpu_common", provided with different "instance_id" for each.  That's the
> ABI for the migration stream so far to match devices on two sides.
> 
> From that POV it's okay to move CPU devices within the qom-tree, hence not
> yet part of the ABI.  It matches with above tests that it would pass.
> 
> Though I'm not 100% sure this is wise either from migration POV.. because I
> think we need to rely on strictly below on both sides of QEMU src/dst:
> 
>   - Exactly the same QEMU cmdlines to be used (e.g. -smp X should be the
>     same on src/dst, or anything that creates the CPUs in cmdlines)
>   - Exactly the same QMP command to do device_add / device_del on CPUs,
>     with exactly the same parameters.


-smp X must be the same, but -device/device_(add|del) don't need to be
in the same order as ('cpu' and 'cpu_common') take it from cpu_index,
which is overridden to stable value (-smp topo based) by machines
that care about cpu hotplug and migration.

For machines that do not have cpu hotplug and do not override cpu_index
only -smp X matters and it stays the same.
That will break only if order of vCPUs creation is changed in a board code
(not impossible but for boards where we care about migration we usually
would pay attention to such reordering) and pretty soon get reports about
broken migration if it get merged.
To test for such case, we basically need to keep old QEMU binaries
and test cross version migration. 

> 
> I suppose only above be guaranteed by the user (or, libvirt), could the
> instance_id to be assigned be identical on both src/dst.  But I'm not 100%
> sure Libvirt can guarantee that.  E.g., we have vhost-user bug that can see
> different instance_id of some slirp instances after some plug/unplugs:
> 
> https://issues.redhat.com/browse/RHEL-56331
> 
> That might be slightly different topic, though, so the movement in the qom
> tree so far looks ok..
> 


