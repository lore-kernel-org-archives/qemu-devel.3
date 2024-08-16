Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C29C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ser2D-0008II-6t; Fri, 16 Aug 2024 03:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1ser28-0008HC-MY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:06:01 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1ser21-0001xx-FI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:05:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2101FDCE;
 Fri, 16 Aug 2024 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723791948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at5DFSP6c81qT5KRnYgWvCQnog+7QeKU+7pgyjRGQaE=;
 b=tTg+ANczlHUA1K9DXrR1Uiv+05Wg2zV8g4vfN1qhzXWQduxbRQW8+LGdSCEMNPUrkXTxQ2
 BENxRbfSkTpzAclkVaWwIzwxW0PsoeNCw949GlMpBQbTIAXZgG4TzMy74vW0s0EYw+mp+l
 7nMbp0LjzSsolyp9iwfvlNUo9h4BCTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723791948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at5DFSP6c81qT5KRnYgWvCQnog+7QeKU+7pgyjRGQaE=;
 b=p0EEYejfF76V6qlUViyyjqKb83a3BgPPY2QqTsoGjctQdwBMbTv/5P2AYSLilaH121a9In
 b1JwlsJKwoAovTBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tTg+ANcz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p0EEYejf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723791948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at5DFSP6c81qT5KRnYgWvCQnog+7QeKU+7pgyjRGQaE=;
 b=tTg+ANczlHUA1K9DXrR1Uiv+05Wg2zV8g4vfN1qhzXWQduxbRQW8+LGdSCEMNPUrkXTxQ2
 BENxRbfSkTpzAclkVaWwIzwxW0PsoeNCw949GlMpBQbTIAXZgG4TzMy74vW0s0EYw+mp+l
 7nMbp0LjzSsolyp9iwfvlNUo9h4BCTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723791948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at5DFSP6c81qT5KRnYgWvCQnog+7QeKU+7pgyjRGQaE=;
 b=p0EEYejfF76V6qlUViyyjqKb83a3BgPPY2QqTsoGjctQdwBMbTv/5P2AYSLilaH121a9In
 b1JwlsJKwoAovTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C27C613A2F;
 Fri, 16 Aug 2024 07:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDDLLUv6vmbJAwAAD6G6ig
 (envelope-from <hare@suse.de>); Fri, 16 Aug 2024 07:05:47 +0000
Message-ID: <904a433c-0471-4f11-a34b-cef8adf1663c@suse.de>
Date: Fri, 16 Aug 2024 09:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@Groves.net>,
 virtualization@lists.linux.dev
Cc: Oscar Salvador <osalvador@suse.de>, qemu-devel@nongnu.org,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxarm@huawei.com, wangkefeng.wang@huawei.com,
 John Groves <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>,
 Navneet Singh <navneet.singh@intel.com>,
 =?UTF-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240815172223.00001ca7@Huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240815172223.00001ca7@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[20]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 8D2101FDCE
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=hare@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/15/24 18:22, Jonathan Cameron wrote:
> Introduction
> ============
> 
> If we think application specific memory (including inter-host shared memory) is
> a thing, it will also be a thing people want to use with virtual machines,
> potentially nested. So how do we present it at the Host to VM boundary?
> 
> This RFC is perhaps premature given we haven't yet merged upstream support for
> the bare metal case. However I'd like to get the discussion going given we've
> touched briefly on this in a number of CXL sync calls and it is clear no one is
> entirely sure what direction make sense.  We may briefly touch on this in the
> LPC CXL uconf, but time will be very limited.
> 
Thanks for the detailed write-up.

Can't we have an ad-hoc meeting at OSS/LPC to gather interested/relevant 
people to explore ideas around this?

In particular I'd be interested on how to _get_ the application specific 
memory to the application in question. It's easy if you have your own 
application and design it to work on DAX devices. Obviously this 
approach won't work for unmodified applications; however, they really
might want to use this, too.

And, of course, the other mentioned problems are worth discussing, and I 
do agree that the uconf will probably not providing sufficient time for 
this.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


