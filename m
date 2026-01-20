Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25C3CA5FB9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFZ7-0006ev-GH; Tue, 20 Jan 2026 12:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFZ5-0006cW-Ta
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFZ4-00048n-5f
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lix4T3Jf4MaWYxQCCSsdRao/bXlgbtP5Dl3pVFuMvsM=;
 b=G5t/OjmgFJCRuAgE2ot3DcDJNK9USJ32ueFpbiHQlQK+t+LGeisoVMnGvSNqolBxv00KzW
 nYt8pIyD1vCbf5lFjAGwXn2OE1r4R3ZxMnwcJl4PxUWA7mPTLhlq8tB39Dum9F1URI9lNH
 B7/sDYaZy0Wt2yw+5gW1W/3tnOi8LoQ=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-bIRSRTyEPYiUf5b5XMLJoQ-1; Tue, 20 Jan 2026 12:30:45 -0500
X-MC-Unique: bIRSRTyEPYiUf5b5XMLJoQ-1
X-Mimecast-MFC-AGG-ID: bIRSRTyEPYiUf5b5XMLJoQ_1768930245
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b70c92f404so333289eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930245; x=1769535045; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lix4T3Jf4MaWYxQCCSsdRao/bXlgbtP5Dl3pVFuMvsM=;
 b=PmBty6ltNZN/n4StmEd/UqtTno9uwL/Osb3+fbSbUs3yQqZLDgUobWZcyd9OSWL0uF
 laO2b+8cjTvBwtd4eT4j6e46WiDmVtiZ1ggXUJY/Riba0aZXdC1EoqXAHMha91LzoGzc
 RdLuN/em4wn+AhjUmtQNDUQBwpB1XJ30BCgBD0wrvlt6nl6PIZsQhpbQaEENWKk2LB67
 BDteAkwVAjzkz5nlaMzHA358P4gC8/T18nNGOgr8ltlxTA4O5tfVw825djeKkV7tau4k
 5Wr7q3LcKGEmhzyc+WqNoDUvroN/nQtxGR9XIfj//4tg4cSbhRoNGTqdVbXMwp+xmAvY
 NP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930245; x=1769535045;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lix4T3Jf4MaWYxQCCSsdRao/bXlgbtP5Dl3pVFuMvsM=;
 b=xFPliGBXEoxiwOyEZaaah2ay9Kx0Dyca3uA3LYbSTo632a4gtDuxesHm3bR3FcOo8K
 /SemWLHKbBmV9NrcYk/z/V7ZFRpXb+7IAvujj736oviWI8d44VBmF8DY29ROC1hgXaCk
 cXWB4QU5BlzS3nVZ2G7L1+zk4zdtcFy8O61z9fi8+sKJk7zweZfnrs783aaRAVN9JIVF
 C8A63RcgutQ5WYHUJUdKcwzcaYMaxaV8n9JziJkr8XUSNEj+Xs7RHQmPsYPlPdbdx4Vd
 NiXCLg6lXGVmCe/wdoMymmI4rCuiPM4y1FlaDpJX/MJiqtvYfWodVUE6jqV7iylBcu8g
 BLIg==
X-Gm-Message-State: AOJu0YxRtywfAGNJI1MyVkdLWqlPcXlIIBnN2pAtBRwEb/QLH406tJyt
 zXkUifRXlqU3a3f7gU2YtNnUQ/V6YlBY3OLhHcLftA9vXhz0E1tXlgCFBct2PUBdXnqYGLakmfP
 vp2GWXFUPv6kbH3XhqO5VuhQ1Piinwl6PiMe0kIyDw/92bzSS5v9kXrLq
X-Gm-Gg: AZuq6aL+eAV8JVzVFQv+cXWGu/C+GVFoRGS+qq0PiAg3MgFeLQ9ULOokrYelVfnHxAw
 Z+WoGZSiJ2KlLjUbdD7Cu0985btMuLoBw09ux8foJzTRCD4hNEr5/EGnbU3gq9Wi/NWXryNdX21
 DiZGpa4fRaPFgeh2f0ddYssyx+oSNBwckoGrAt9d3E9FlQeEsjuVlVhwAauqVzKo45BJyw9/Lg7
 bpdUbgbrIDUDI09dv93HsYpHf5XtswYsYTiT+u6hDB1NMBnJow2dnMclVdDGyhdWihiLVKRGzxb
 irsFjNDZY63VXT/944LAT7pjMaRgAkCZ6dGZeSY12uxHDUVKW9ffKiWSF/a+EEXrYQ6v0xxBEc7
 3vtI=
X-Received: by 2002:a05:7300:cc0a:b0:2a4:3594:72d7 with SMTP id
 5a478bee46e88-2b6b3f069dcmr9237644eec.6.1768930243099; 
 Tue, 20 Jan 2026 09:30:43 -0800 (PST)
X-Received: by 2002:a05:7300:cc0a:b0:2a4:3594:72d7 with SMTP id
 5a478bee46e88-2b6b3f069dcmr9237582eec.6.1768930241787; 
 Tue, 20 Jan 2026 09:30:41 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6c56a23ecsm15528033eec.11.2026.01.20.09.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:30:41 -0800 (PST)
Date: Tue, 20 Jan 2026 12:30:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 7/8] qemu-colo.rst: Miscellaneous changes
Message-ID: <aW-7ulV3ZVUdXnzP@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-7-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117-colo_unit_test_multifd-v2-7-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jan 17, 2026 at 03:09:14PM +0100, Lukas Straub wrote:
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  docs/system/qemu-colo.rst | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> index 5b00c6c4c2679153f398ed5a85a5d9cc515630e6..2052e207e57afdd3ab3ab1a447d55f5e2e5b5b87 100644
> --- a/docs/system/qemu-colo.rst
> +++ b/docs/system/qemu-colo.rst
> @@ -1,14 +1,6 @@
>  Qemu COLO Fault Tolerance
>  =========================
>  
> -| Copyright (c) 2016 Intel Corporation
> -| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> -| Copyright (c) 2016 Fujitsu, Corp.
> -| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>

Hmm, I don't see this copyright line in the current code base.  I think you
added it in previous conversion patch.

When converting, we should keep that patch change nothing in the content
but only convert things.

If you want to propose new things to the doc, it needs to be separately
done and reviewed.

We'd better not hide real changes within a conversion patch.

Here, I'm not sure you should add your copyright line.  IIUC, that can be
added only if you made prominent contribution to this solution in the code
base.  Becoming a maintainer is definitely a bless, however not justified
for an additional copyright update.  I can also be wrong, but please
justify.

> -
> -This work is licensed under the terms of the GNU GPL, version 2 or later.
> -See the COPYING file in the top-level directory.
> -
>  This document gives an overview of COLO's design and how to use it.
>  
>  Background
> @@ -83,8 +75,8 @@ Overview::
>          |   Storage     |  |External Network|       | External Network | |   Storage    |
>          +---------------+  +----------------+       +------------------+ +--------------+
>  
> -Components introduction
> -^^^^^^^^^^^^^^^^^^^^^^^
> +Components
> +^^^^^^^^^^
>  You can see there are several components in COLO's diagram of architecture.
>  Their functions are described below.
>  
> @@ -158,14 +150,14 @@ in test procedure.
>  
>  Test procedure
>  --------------
> -Note: Here we are running both instances on the same host for testing,
> +Here we are running both instances on the same host for testing,
>  change the IP Addresses if you want to run it on two hosts. Initially
>  ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host.
>  
>  Startup qemu
>  ^^^^^^^^^^^^
>  **1. Primary**:
> -Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all hosts.
> +Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all hosts.
>  You don't need to change any IP's here, because ``0.0.0.0`` listens on any
>  interface. The chardev's with ``127.0.0.1`` IP's loopback to the local qemu
>  instance::
> @@ -193,7 +185,7 @@ instance::
>  
>  
>  **2. Secondary**:
> -Note: Active and hidden images need to be created only once and the
> +Active and hidden images need to be created only once and the
>  size should be the same as ``primary.qcow2``. Again, you don't need to change
>  any IP's here, except for the ``$primary_ip`` variable::
>  
> @@ -354,8 +346,10 @@ Wait until disk is synced, then::
>      {"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {"capability": "x-colo", "state": true } ] } }
>      {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
>  
> -TODO
> -----
> -1. Support shared storage.
> -2. Develop the heartbeat part.
> -3. Reduce checkpoint VM’s downtime while doing checkpoint.
> +| Copyright (c) 2016 Intel Corporation
> +| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> +| Copyright (c) 2016 Fujitsu, Corp.
> +| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.
> +See the COPYING file in the top-level directory.
> \ No newline at end of file
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


