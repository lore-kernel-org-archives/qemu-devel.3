Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335C4C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkooN-0005UF-BX; Thu, 14 Mar 2024 13:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkooL-0005Tr-5U; Thu, 14 Mar 2024 13:24:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkooJ-0007hH-Co; Thu, 14 Mar 2024 13:24:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD61821C11;
 Thu, 14 Mar 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710437045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8oILZZxiogqj3knyr94Y7Cgk4oJYKp5Rd1/mPw1kyY=;
 b=xW8beGSrVDsP8ncc2y6wHcsdN7pH+nTW+kr86jreJV8tNrskEk1ZFY+OUrIDLXrc+FxeXW
 7HqAbZrVJQyvQJeDCw83SMLjYCQoPwUKrjWKWhHNI4Bkv/+LwqdGvnWuT6IlBo3K1N4I0l
 Yzvdi8mDgTefvA+ZM+TGPcWAqoiBAT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710437045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8oILZZxiogqj3knyr94Y7Cgk4oJYKp5Rd1/mPw1kyY=;
 b=iicb+KCaQt6kyFjiTol9y43jTsqiF1pUqJnB20dMx6mXhbf2U1/V29FhxUJAsIRufZdMCA
 1o7iihZC1Hpm21Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710437045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8oILZZxiogqj3knyr94Y7Cgk4oJYKp5Rd1/mPw1kyY=;
 b=xW8beGSrVDsP8ncc2y6wHcsdN7pH+nTW+kr86jreJV8tNrskEk1ZFY+OUrIDLXrc+FxeXW
 7HqAbZrVJQyvQJeDCw83SMLjYCQoPwUKrjWKWhHNI4Bkv/+LwqdGvnWuT6IlBo3K1N4I0l
 Yzvdi8mDgTefvA+ZM+TGPcWAqoiBAT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710437045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8oILZZxiogqj3knyr94Y7Cgk4oJYKp5Rd1/mPw1kyY=;
 b=iicb+KCaQt6kyFjiTol9y43jTsqiF1pUqJnB20dMx6mXhbf2U1/V29FhxUJAsIRufZdMCA
 1o7iihZC1Hpm21Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F521368B;
 Thu, 14 Mar 2024 17:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4lfRG7Uy82XITwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 17:24:05 +0000
Message-ID: <d3b18277-15fe-b9d3-cb1b-6b5a555b6954@suse.de>
Date: Thu, 14 Mar 2024 18:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: question on s390x topology: KVM only, or also TCG?
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x <qemu-s390x@nongnu.org>
References: <c2aa273a-6f49-2a02-fd4d-a3ddd37db388@suse.de>
 <f0d5ec8d-02fe-4660-afcf-ad7b0af1dc13@redhat.com>
 <93131e9b6b6292c42657ba338aa134f15a88081f.camel@linux.ibm.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <93131e9b6b6292c42657ba338aa134f15a88081f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.32 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.02)[54.75%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; SUBJECT_ENDS_QUESTION(1.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.534,
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

On 3/14/24 17:44, Nina Schoetterl-Glausch wrote:
> On Thu, 2024-03-14 at 16:54 +0100, Thomas Huth wrote:
>> On 14/03/2024 16.49, Claudio Fontana wrote:
>>> Hello Pierre, Ilya,
>>>
>>> I have a question on the s390x "topology" feature and examples.
>>>
>>> Mainly, is this feature supposed to be KVM accelerator-only, or also available when using the TCG accelerator?
>>
>>   Hi Claudio!
>>
>> Pierre left IBM, please CC: Nina with regards to s390x topology instead.
>>
>> But with regards to your question, I think I can answer that, too: The 
>> topology feature is currently working with KVM only, yes. It hasn't been 
>> implemented for TCG yet.
>>
>>> (docs/devel/s390-cpu-topology.rst vs https://www.qemu.org/docs/master/system/s390x/cpu-topology.html)
>>>
>>> I see stsi-topology.c in target/s390x/kvm/ , so that part is clearly KVM-specific,
>>>
>>> but in hw/s390x/cpu-topology.c I read:
>>>
>>> "
>>>   * - The first part in this file is taking care of all common functions
>>>   *   used by KVM and TCG to create and modify the topology.
> 
> What Thomas said. Read this as the code in file being independent with respect to the accelerator,
> it's just that TCG support is missing.
>  
> [...]
>>>
>>> So I would assume this is KVM-only, but then in the "Examples" section below I see the example:
>>>
>>> "
>>> $ qemu-system-s390x -m 2G \
>>>    -cpu gen16b,ctop=on \
> 
> TCG doesn't support this cpu ^ and so will refuse to run.
> 
>>>    -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
> 
> When running with TCG, drawers & books are supported by -smp also, but well, you cannot do anything
> with that.
> 
> [...]
>>
> 

Thank you for your responses Thomas and Nina,
I have just sent a patch that tries to make it even more explicit.

"[PATCH] docs/s390: clarify even more that cpu-topology is KVM-only"

Thanks,

Claudio

