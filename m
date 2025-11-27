Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0828ED11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 09:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYjo-0004XW-TV; Thu, 27 Nov 2025 04:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOYji-0004Vs-8W
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOYjf-00063v-BF
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764237381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3jsijaX9E5IJhaTwRaE3+V2ffrJ3L3g3vqtDYbXUPE=;
 b=DkcGRSe9NpxAzeMs+Gp6VjNOg7K49ir0KSZrXFCjUL/BSPhBGATVdLsAndoaTqeiw6h2iq
 AMDoAdlTh9hEImF6HTE4WVV3Il+A0Crf24BFSqYqXCdtcZOy/2HKlBvYfDQRiNHQFW8Gxm
 nY9jwPWdDNYsxDTDcE4d8SrT7wGOwHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-V2eODFPONzOhFVaZE8hf9Q-1; Thu,
 27 Nov 2025 04:56:19 -0500
X-MC-Unique: V2eODFPONzOhFVaZE8hf9Q-1
X-Mimecast-MFC-AGG-ID: V2eODFPONzOhFVaZE8hf9Q_1764237378
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D48195606F; Thu, 27 Nov 2025 09:56:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 062C51800872; Thu, 27 Nov 2025 09:56:14 +0000 (UTC)
Date: Thu, 27 Nov 2025 10:56:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: andrey.drobyshev@virtuozzo.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <aSggPDzhqem_jxnR@redhat.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 25.11.2025 um 15:21 hat andrey.drobyshev@virtuozzo.com geschrieben:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> coredumps") introduced coroutine traces in coredumps using raw stack
> unwinding.  While this works, this approach does not allow to view the
> function arguments in the corresponding stack frames.
> 
> As an alternative, we can obtain saved registers from the coroutine's
> jmpbuf, copy the original coredump file into a temporary file, patch the
> saved registers into the tmp coredump's struct elf_prstatus and execute
> another gdb subprocess to get backtrace from the patched temporary coredump.
> 
> While providing more detailed info, this alternative approach, however, is
> quite heavyweight as it takes significantly more time and disk space.
> So, instead of making it a new default, let's keep raw unwind the default
> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
> command which would enforce the new behaviour.
> [...]

> +def clone_coredump(source, target, set_regs):
> +    shutil.copyfile(source, target)
> +    write_regs_to_coredump(target, set_regs)
> +
> +def dump_backtrace_patched(regs):
> +    files = gdb.execute('info files', False, True).split('\n')
> +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
> +    dump = re.search("`(.*)'", files[2]).group(1)
> +
> +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
> +        tmpcore = f.name
> +
> +    clone_coredump(dump, tmpcore, regs)

I think this is what makes it so heavy, right? Coredumps can be quite
large and /tmp is probably a different filesystem, so you end up really
copying the full size of the coredump around.

Wouldn't it be better in the general case if we could just do a reflink
copy of the coredump and then do only very few writes for updating the
register values? Then the overhead should actually be quite negligible
both in terms of time and disk space.

Kevin


