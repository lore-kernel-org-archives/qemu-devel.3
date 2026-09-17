Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31654C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7H3f-0005Vt-F4; Thu, 17 Sep 2026 14:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7H3c-0005VP-NN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7H3b-0003QK-3X
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789670521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPIjgpMPP/HzW4EXbV5QyaCHdSOmrQaWh7qV5tYdYvA=;
 b=KAsWVaWxTXOsF5VIrbchWYkSbLxuO/t4fdqS9CJx7d4k+gxGB8b7qAfSrNfw/FDI0JQcyQ
 6cyARXlBTvsilt7okKKJlS9BBJj9GL+wJPwZpdIXeH+D75IaasN2JgYTELM+hTNQ6vBObw
 /CnY16rsNOBri9d8Fcn7CQdZCiXZDzo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-mgNTxZx4O_SnyP_YrecnDw-1; Thu, 17 Sep 2026 14:41:59 -0400
X-MC-Unique: mgNTxZx4O_SnyP_YrecnDw-1
X-Mimecast-MFC-AGG-ID: mgNTxZx4O_SnyP_YrecnDw_1789670519
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so339095785a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789670519; x=1790275319; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UPIjgpMPP/HzW4EXbV5QyaCHdSOmrQaWh7qV5tYdYvA=;
 b=ilROnI/HOIZY+dO/92Aq3DRfGSEJaM0B9Diw+miyAINLrgtGQac31aHl6N5yLqV4TS
 DQQ+k1OT5I0eZY6eQ2KJQK2KNHkXJDdMYY8Dcba9/L5aSdLjVOQXRB+4iZccUUK22NLT
 T38cTAZVOl1be9yuDH3I6ujySJX/uTNP4/Rp1/Ivk/MJaQX7U0WDEu8tTPeLn9yk2E/R
 WNIJmpGbSXN/4AC8azqjceqHBxj32dsBZFPs0fGd1Wf//pWoBMhhgq2Oj/+ZDxKdolPL
 28YdEJrmz3ksIbMLTiiRK/mDEcV6DG+UrWv4ZDWnId/AE1nfe3x4QFygqpmQQKPMyoKQ
 +Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789670519; x=1790275319;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UPIjgpMPP/HzW4EXbV5QyaCHdSOmrQaWh7qV5tYdYvA=;
 b=V4EYJ/yxTHVUUAlgX5KJ+uwL4kmBvnDXzJLd7qlK2m5PCXIU//ybENwEYc3EicJd67
 D3CoQ97IauWLiywZ8gvck+4d1a2Qi3rysNKSTJSEY3q5jOxeVcc9OInX8yyW++BGBpa4
 ABSvSI432O0Wz6jUy68f64fljE2LxckgnUEEcsJXKGPkuay8WIiPCOWicYdraTqkvcqW
 REBkxpnn2Km6UbyR5aJL3UuRjbouFbM2jJSZxUrT28CK71KYTBXZFgaatlrQCTYa1F8B
 cayn6t5iV83rI0oCDITp/c+p9M86jzq8secITDZZm6TVtkxfHDk3/qWAdYDCZEF3qbr1
 UoVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG9yANACjBGeBec8wydCCr4oAaYtxpcRxakw1yC7Wt3T9d/a2nZaaeU79zZVGKSkaETHFr9JnpbPRG@nongnu.org
X-Gm-Message-State: AFuF++mf7pbEi7P27LKMIPlzheU/v2bXPAPRA30QEVBJIVCIiwJ08htm
 YtSCZjeQxeVB2HyMVpf8RCOggUrN260fD+cmS1Wl4ZGME0KV305JuYpBuLf5RCbvOGaMq1QmQTX
 FmOVRbKhuM+USvxPjR79g1YzBHQ2X4Lpq3ag8pwv1eHUtCC0TZwNhrE1L
X-Gm-Gg: AYBFou3ngmKRQ8LTopxHds6iljzPyZRz2JlghR9TYu5Lzbw2eFt2CIyCjrkX/6C5Y6p
 ewSMKhTEN25z4Wo92xakv3nS81qnLB9mjdw8hiRA7A7ue7zJnnIjIwnrpJBpfrvlYTrlCSNHyHV
 9AnVkXGM+4pXRO7Zb+v2/8LaYl9z/WnzHO4F0WndHtvbhr59EZgIbtJEX5hXI5nJi2fP2V4OSj0
 cjgQWCvsgTgMj5DxPnbQ6Yh6Pq1b0T/1u/GC3e1lZXEs0hNrsmQC343oU1ZnYlOeDJ+y8a90ZGZ
 6jotYhx5PRDwcO+LaMG5PWrZQ+GadEjCJk/n0evpEVwnjYPkpa8gPE6yjpbdrjN6gr6o
X-Received: by 2002:a05:620a:a41a:20b0:93b:cb64:25af with SMTP id
 af79cd13be357-93bcb642834mr397753585a.32.1789670518939; 
 Thu, 17 Sep 2026 11:41:58 -0700 (PDT)
X-Received: by 2002:a05:620a:a41a:20b0:93b:cb64:25af with SMTP id
 af79cd13be357-93bcb642834mr397749485a.32.1789670518245; 
 Thu, 17 Sep 2026 11:41:58 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b78243f77sm529010485a.25.2026.09.17.11.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:41:57 -0700 (PDT)
Date: Thu, 17 Sep 2026 14:41:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 14/20] migration: Use output visitor in info command
Message-ID: <aqw0anGmdLfHtv3q@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-15-farosas@suse.de>
 <87zexg2ix9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zexg2ix9.fsf@pond.sub.org>
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

On Thu, Sep 17, 2026 at 01:53:22PM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > The hmp_info_migrate_parameters function currently open-codes the
> > mon_printf calls for each migration parameter. As with the set command
> > in the last patch, this should not be necessary as the QAPI
> > infrastructure already has generated code that takes type and struct
> > member names into account, including converting _ from C into the '-'
> > character as part of parameter names strings.
> >
> > The current code is also quite painful to rebase if a series has been
> > carried for a long time while parameters have been added in master.
> >
> > Replace all of this with a conversion from MigrationParameters to
> > QDict using an output visitor and a loop over the QDict that prints
> > per-QAPI-type formatted strings.
> >
> > Modelled after block/qapi.c:dump_qobject, but with some changes to
> > keep the migration command output formatting.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Old output of info migrate_parameters for me:
> 
>     announce-initial: 50
>     announce-max: 550
>     announce-rounds: 5
>     announce-step: 100
>     throttle-trigger-threshold: 50
>     cpu-throttle-initial: 20
>     cpu-throttle-increment: 10
>     cpu-throttle-tailslow: off
>     max-cpu-throttle: 99
>     tls-creds: 
>     tls-hostname: 
>     tls-authz: 
>     max-bandwidth: 134217728
>     avail-switchover-bandwidth: 0
>     max-postcopy-bandwidth: 0
>     downtime-limit: 300
>     x-checkpoint-delay: 20000
>     multifd-channels: 2
>     multifd-compression: none
>     zero-page-detection: multifd
>     xbzrle-cache-size: 67108864
>     x-vcpu-dirty-limit-period: 1000
>     vcpu-dirty-limit: 1
>     mode: normal
>     direct-io: off
>     x-rdma-chunk-size: 1048576
>     cpr-exec-command:
> 
> New output:
> 
>     cpu-throttle-tailslow: off
>     xbzrle-cache-size: 67108864
>     cpu-throttle-initial: 20
>     announce-max: 550
>     direct-io: off
>     avail-switchover-bandwidth: 0
>     local: off
>     zero-page-detection: multifd
>     multifd-qatzip-level: 1
>     x-rdma-chunk-size: 1048576
>     multifd-channels: 2
>     mode: normal
>     multifd-zstd-level: 1
>     announce-initial: 50
>     downtime-limit: 300
>     tls-authz: 
>     cpr-exec-command:
> 
>     vcpu-dirty-limit: 1
>     multifd-compression: none
>     announce-rounds: 5
>     announce-step: 100
>     tls-creds: 
>     x-vcpu-dirty-limit-period: 1000
>     multifd-zlib-level: 1
>     max-cpu-throttle: 99
>     max-postcopy-bandwidth: 0
>     tls-hostname: 
>     throttle-trigger-threshold: 50
>     max-bandwidth: 134217728
>     x-checkpoint-delay: 20000
>     cpu-throttle-increment: 10
> 
> New output has an unwanted blank line after "cpr-exec-command:".
> 
> New output adds @local, @multifd-qatzip-level, @multifd-zlib-level,
> @multifd-zstd-level.  Commit message should point that out.
> 
> Order of parameters changes, and not for the better.  Hmm.

Good point.. it might start to be awkward to users looking for tls-*,
multifd-*, announce-* or cpu-throttle*, etc. after this change, expecting
them grouped.

Maybe we can sort them by name with inserting top level to a QList first
from the QDict.

We won't be able to keep all relevant fields together, for example, we used
to have max-cpu-throttle together with cpu-throttle-*, now also separate
even with alphabetical order, but it's a special case of bad name since the
start.. where it could have been "cpu-throttle-max".  Meanwhile, as another
good side effect, we can finally have max-* fields together too.

-- 
Peter Xu


