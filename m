Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33794D6CFAA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iI-0004vD-A8; Thu, 22 Jan 2026 18:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iH-0004uf-GA
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iF-0007RS-75
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ij5tWyLXqZYPkX6tkFNcKvOiNQ6HcqzkeC/Xiocs4c0=;
 b=YkThbGfVcIJU6pAf9lC+b4Ez5tYMPFCBlcuCf+Q9hd2J7PY/8N5sMCc7Rov1AS+vA/Xwxr
 pfSIZs4tKgUaCRQoNmKRa5KsH0NiDs3IG5t+iYviQ/dZov/LKt+2wyuvQ0gW6y+MT84QHj
 we6bZzGf72Nx8moZPxLnVDj+s7BnWys=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-m3X1PjBcOO20rTl7GDx1mA-1; Thu, 22 Jan 2026 18:03:35 -0500
X-MC-Unique: m3X1PjBcOO20rTl7GDx1mA-1
X-Mimecast-MFC-AGG-ID: m3X1PjBcOO20rTl7GDx1mA_1769123015
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c53919fbfcso349760585a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123014; x=1769727814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ij5tWyLXqZYPkX6tkFNcKvOiNQ6HcqzkeC/Xiocs4c0=;
 b=gvGbRbniggpht6/VwFOcSakel5ctt4KHfMzIXYQvh1nEvIZy/9W5Y0LhcbJpjHyNK8
 VVYHipKPIRLtUMVLsbx0CuA9P/6wIPS8uhFsLLXpBkPh5qky2JdLQSbVgM7zjOR7k8mv
 N1RKGnR/Iuqqsm61t1fhZgKMvR6C5WcOWMTuv654durmvRfc0r8950+dxQ/J7cZqxJtr
 wiUptxzUQDI38UlqGjIMogwHS6pgDBqsba1t1DpcfqoUZH3zoFD2uHOowVLFA1ITRzLy
 rEatvzmEtjbvQczFwxfvr7cOhWE3pQf5JY/l3Eu5tBucj9wGMCgTqmpi2lVtGHeYkiVh
 iibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123014; x=1769727814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij5tWyLXqZYPkX6tkFNcKvOiNQ6HcqzkeC/Xiocs4c0=;
 b=MuJbHEChqJAnaemEiV1ljxu1INRJYw6EX0gLgbM+17DUdmi7OwrwQgyq5+y5hvIUHN
 bvd/jmL1A6Kzq/pIRYdpQM6tjK5GE9RYjNIGrSGItxyvN20zOAfUBblyijGdlCpEuuaa
 lFjvPYD6AvmLdoQBG6uZGmmF+6AjUNe/CB9iT6h/Wz379iCx2bjUshPLuq3avde6A09o
 v+jWpVE8Midl24t4CuNf6tG8Z4fqb27tPv4f4W05OAY+DU4LhXENaX7XwXHnUHRUW65f
 KE5ZEsbG1dJbR4SnFyXHxUwA1Bgpu557O6NxA5lQwBkXUO8RURjOrF1Q0jffZS/zcxZU
 afww==
X-Gm-Message-State: AOJu0YwXln1F5YfIQHPdIiZa+yOBFAIddxB5Z3rDLhCs3SmKEonJuVtt
 eXKuYSjMCUgQ5XnpvziM03fnCnZNtrZzGD19l0U8KcWnnBUT7lWg8jAjVjY3UuGimVVTzPV3Ddl
 R73em4XRFBYVFod6h42+rrQNu0eXbFn/ZGNzQk8o352QFR0p7YFPPkNrtRs7Uv38ERB2ARR3XD1
 ylkctzhwJ4oS7Y2uNIlmSS2Mj/0ooAFGbtx4r+Ug==
X-Gm-Gg: AZuq6aIQtIvLgWH8yxaeLK8FlAMEZRFP9YwC97qU68qupwJ553T4sWt2timaXAgFQvS
 OTrE507jAIA17NLScsT8lpq7Z/UN9td/Vmcpj/OWOjqQj+gjk0SVG2Diy1Z1ywbmsHPpquNfHVv
 sfi895Cm6zoj9k7ssnesTmpeSrzisaJrpoguRZEktZh1QIbDFF93Lw7dI9Yk1CV9ywWZMCHwnpe
 nId/M8tyy9eJgaAjrdbBcR4aJsFnAyCOBPqQ1A7ht8P9e7n6j+IxO9qpdDI1ddPLor9wvpCpqB/
 kvzlC2DjU3EhAF469VUJa8dgeCbQOUyiksIjF5SWHlgHnqI65ZsrGBBjYGDK5/Zr5yRQS72qXHF
 3
X-Received: by 2002:a05:620a:400e:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c6e2db03cfmr153752785a.29.1769123014556; 
 Thu, 22 Jan 2026 15:03:34 -0800 (PST)
X-Received: by 2002:a05:620a:400e:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c6e2db03cfmr153748185a.29.1769123014046; 
 Thu, 22 Jan 2026 15:03:34 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:33 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 0/5] migration: Notifier fixes for 11.0
Date: Thu, 22 Jan 2026 18:03:26 -0500
Message-ID: <20260122230331.3543312-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2280356561

Two major goals for this small series:

- Fix postcopy issue where DONE and FAILED notifiers will be invoked twice

- Move FAILED notifier to be before vm_start() if the failure happens
  during switchover (where we will stop the VM first)

The 2nd goal will be needed by Stefan's ongoing work on block persistent
reservations, where a fallback should be required on src to happen before
vm_start().  Instead of introducing another FAILED_BEFORE_START, this
patchset should make FAILED work instead.

Patch 1 adds a tracepoint for me to verify this fix.

Patch 2-3 are the real changes of above two.

Patch 3-4 are some cleanups alone the context that we can do, hence
attached at the end.

More details in commit logs individually.  Comments welcomed, thanks.

Peter Xu (5):
  migration: Add a tracepoint for invoking migration notifiers
  migration: Fix double notification of DONE/FAIL for postcopy
  migration: Notify migration FAILED before starting VM
  migration: Drop explicit block activation in postcopy fail path
  migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*

 include/migration/misc.h | 15 ++++++++-------
 hw/intc/arm_gicv3_kvm.c  |  2 +-
 hw/net/virtio-net.c      |  4 ++--
 hw/vfio/cpr-legacy.c     |  2 +-
 hw/vfio/cpr.c            |  8 ++++----
 hw/vfio/migration.c      |  4 ++--
 migration/cpr-exec.c     |  6 +++---
 migration/migration.c    | 30 +++++++++++++++++++++---------
 net/vhost-vdpa.c         |  4 ++--
 ui/spice-core.c          |  7 ++++---
 migration/trace-events   |  1 +
 11 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.50.1


