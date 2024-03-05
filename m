Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458A5C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVcP-0005kF-EQ; Tue, 05 Mar 2024 09:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhVcO-0005k6-Ik
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhVcM-0003Kv-KT
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709648284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PNBQaR6KsKmYg0wNjWKy9lcVdNG94/gkgKzakxuxElY=;
 b=iMuD9EO8fFipBP49cpOymW0/hSzYMdWvx/KSODBKVWTROQjVutBXoY115XrhfLaTyY4njA
 u4WCrxYQXQc+im/kcv/W7WA9T5kjTNmk5RxiWYS0fB/oN/UUAOc4CmWpoOgYoymd05FXN0
 7Z8ggglu6pYHHzTgOih/aVkLDbQNFmY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-PdZSlsI9MxW6DotbetgkUA-1; Tue,
 05 Mar 2024 09:18:02 -0500
X-MC-Unique: PdZSlsI9MxW6DotbetgkUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FBF83CBDF69;
 Tue,  5 Mar 2024 14:18:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69BCD1C060D6;
 Tue,  5 Mar 2024 14:18:01 +0000 (UTC)
Date: Tue, 5 Mar 2024 14:17:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/5] Generate x86 cpu features
Message-ID: <ZecplxvAjp07vnQ_@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206134739.15345-1-twiederh@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 06, 2024 at 02:47:34PM +0100, Tim Wiederhake wrote:
> Synchronizing the list of cpu features and models with qemu is a recurring
> task in libvirt. For x86, this is done by reading qom-list-properties for
> max-x86_64-cpu and manually filtering out everthing that does not look like
> a feature name, as well as parsing target/i386/cpu.c for cpu models.
> 
> This is a flawed, tedious and error-prone procedure. Ideally, qemu
> and libvirt would query a common source for cpu feature and model
> related information. Meanwhile, converting this information into an easier
> to parse format would help libvirt a lot.
> 
> This patch series converts the cpu feature information present in
> target/i386/cpu.c (`feature_word_info`) into a yaml file and adds a
> script to generate the c code from this data.

Looking at this fresh, I'm left wondering why I didn't suggested
using 'QMP' to expose this information when reviewing the earlier
versions. I see Igor did indeed suggest this:

  https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03905.html

Your commentry that "qom-list-properties" doesn't distinguish
between CPU features and other random QOM properties is bang
on the money.

I think what this highlights, is that 'qom-list-properties'
is a very poor design/fit for the problem that management apps
need to solve in this regard.

Libvirt should not need to manually exclude non-feature properties
like 'check' 'enforce' 'migratable' etc.

QEMU already has this knowledge, as IIUC, 'query-cpu-model-expansion'
can distinguish this:

query-cpu-model-expansion type=static model={'name':'Nehalem'}
{
    "return": {
        "model": {
            "name": "base",
            "props": {
                "3dnow": false,
                ...snip...
                "xtpr": false
            }
        }
    }
}

We still have the problem that we're not exposing the CPUID/MSR
leafs/register bits. So query-cpu-model-expansion isn't a fit
for the problem.

Rather than try to design something super general purpose, I'd
suggest we take a short cut and design something entirley x86
specific, and simply mark the QMP command as "unstable"
eg a 'x-query-x86-cpu-model-features', and then basically
report all the information libvirt needs there.

This is functionally equivalent to what you expose in the YAML
file, while still using QEMU's formal 'QMP' API mechanism, so
we avoid inventing a new API concept via YAML.

I think this would avoid need to have a code generator refactor
the CPU definitions too. We just need to expose the values of
the existing CPUID_xxx constants against each register.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


