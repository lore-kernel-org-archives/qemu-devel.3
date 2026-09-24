Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAF1C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lQk-0001qz-T4; Thu, 24 Sep 2026 11:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9lQf-0001py-2k
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:32:10 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9lQc-000149-Rt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:32:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4CF200DB;
 Thu, 24 Sep 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790263920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwTA1bX/Hn66ixKWQx7qBeoCJYBvKVueMDgwbILtWDc=;
 b=2AcpOvY+kv9DDGgsfLddsG1PpDKIPcHoz17QciN9AYJeSV8u/+xj/Bu0I8k7qAklbKcCla
 YatQ1mBMm/3ksbeAhT1oWRVftZ64IWa9VCx4Wf56E6Z0f/6UGHpdGbKzE4AB+RrrSkWcMi
 PWby+ocKFL6q+OVZHEwv116OjTByAug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790263920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwTA1bX/Hn66ixKWQx7qBeoCJYBvKVueMDgwbILtWDc=;
 b=gBEnJn0SSFXdY0kr14RIC4E8ix8zqy31hrHzBtwJIylWBWMkuuF+J+LlqPdOut72Kp/YpD
 I5AH+IpMD4dIPKDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790263916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwTA1bX/Hn66ixKWQx7qBeoCJYBvKVueMDgwbILtWDc=;
 b=xmSHIzOvRATQ9Ip/nPxuvW2DLVNGKl3FoU/jog3SwPgs+OFYlQXVi/L3jxRCjvlIhm4yYw
 iU7d4xJpPe2FNKI1jBgESMjx6uLugHaFEPD87YLZaSSDRGQdnnhGjC1JzY5rEzjBeUZLGX
 CfxNy5rjgkLWYwctaHc9mTORQrbD6EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790263916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwTA1bX/Hn66ixKWQx7qBeoCJYBvKVueMDgwbILtWDc=;
 b=k0Mw0lcZg6+W31far/JUPr59RiMPUScDVkchdUA5fS9URTZSoa0DjFaBpL/WzY5mivgKRc
 mutk2I2q9YNgiiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDEF21365D;
 Thu, 24 Sep 2026 15:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZRqEJGtCtWrbNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 24 Sep 2026 15:31:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Chinmay Rath <rathc@linux.ibm.com>, Doru
 =?utf-8?Q?Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, Magnus Kulke
 <magnuskulke@linux.microsoft.com>
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
In-Reply-To: <59a6c0de163178a7571de6cf8a9530c14fa36c4d.camel@linux.ibm.com>
References: <20260918140037.3082357-1-farosas@suse.de> <87ld8s9kz1.fsf@suse.de>
 <59a6c0de163178a7571de6cf8a9530c14fa36c4d.camel@linux.ibm.com>
Date: Thu, 24 Sep 2026 12:31:49 -0300
Message-ID: <871paiacnu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Shivang Upadhyay <shivangu@linux.ibm.com> writes:

> On Wed, 2026-09-23 at 10:05 -0300, Fabiano Rosas wrote:
>> 
>> @Shivang, we're discussing about cpu_remove_sync() down in this
>> thread,
>> maybe that's of interest to you. Philippe is suggesting we could
>> maybe
>> move the call up a layer.
>
> Hi Fabiano, 
>  I checked the dummp_cpu way to working, I can see you changes makes
> sense here. I couldn't understand much from Philippe's suggestion. Do
> we want to handle the case for thread waiting on sigwait, inside
> cpu_remove_sync ?
>

The point was simply to call cpu_remove_sync() from another spot. I
think he made the same suggestion to you here:
https://lore.kernel.org/r/bb91d62a-f15a-42e5-813d-5ec7e6d92479@oss.qualcomm.com

While researching what would it take to do it, I got concerned about the
effects that setting cpu->unplug could have for targets that currently
do not set it, but nonetheless use it as the cpu loop exit
condition. That question is still open, I haven't got time to look
deeper into it yet.

If you're interested in that area, you could give it a try. As I
mentioned in the other email, the unplug logic was added back then to
improve the usability of spapr cpu hot-unplug so it could be pertinent
to anyone working on ppc.

