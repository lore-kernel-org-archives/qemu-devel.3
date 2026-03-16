Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5FDF30275
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Fsp-0007Lo-0b; Mon, 16 Mar 2026 17:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Fsm-0007Kg-09
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:53:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Fsj-0005OO-Jm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:53:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5A354D318;
 Mon, 16 Mar 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773698027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmCchWQoERSSMnkd5Yn9phNf3O6FBZGjNLNYb7fZ0Tw=;
 b=DqdaOwu2D9Q7MYZfj9cxB3FhyXsrPY3LJ4t4kG8e2rWfoS6HQJmbYa2GNtLKpaFK2RdfK3
 hTNI9Mno7KhmKDFrvByMUX9R7aTesthdAyfoTdQ4ElvLsYte+nm5raQb2XU1zYx9YrEnvk
 iiuR8kYohShfX6aqkZdvkUOrr2wsKv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773698027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmCchWQoERSSMnkd5Yn9phNf3O6FBZGjNLNYb7fZ0Tw=;
 b=2g0rHSBNQ7umz9dqZQZoMi7NzoeIwJPyLmYthpA3lSifwPPqVmdaNp3ToTzzmUjRXCV5Y7
 GuwemQiQ7u4L+UBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773698026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmCchWQoERSSMnkd5Yn9phNf3O6FBZGjNLNYb7fZ0Tw=;
 b=UI8cB0Xg7Ude3UoOAgSx5vAOW9tFZXVqO/dtdsMqXSel6+b3MKu+x8e9JLC5yhNtIiFlgQ
 DoFxrBL7qPesLkeREqCBlilXKOLDMjYOA3ovUHxtwPc9g3+E9LptjYY70I2nRfnf/zoS4D
 fFENgYnIz7lwmEir4rEsl/+I8+mKFA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773698026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmCchWQoERSSMnkd5Yn9phNf3O6FBZGjNLNYb7fZ0Tw=;
 b=iv/EbDLUmKM4/JSJ5Q95/7V5IEKlKkhaJJibbdKvzwsNIvX+ggkVyHeCpEZbnN55lI4yxy
 MV/clECR558xCbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DD74273B;
 Mon, 16 Mar 2026 21:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9w87Cup7uGlJaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Mar 2026 21:53:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v1] migration/savevm: Allow stub VMSDs
In-Reply-To: <abhyg_wRK4_RmqdO@x1.local>
References: <20260316194759.22672-1-farosas@suse.de>
 <abhyg_wRK4_RmqdO@x1.local>
Date: Mon, 16 Mar 2026 18:53:43 -0300
Message-ID: <87pl53qw48.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Mar 16, 2026 at 04:47:59PM -0300, Fabiano Rosas wrote:
>> After the referenced commit, empty VMStateDescription objects declared
>> as part of stubs have started reaching the vmstate code.
>> 
>> A valid VMStateDescription must at minimum have a name and either the
>> .fields or .unmigratable fields set. Stubs, being empty, have
>> none. Code that assumes a non-NULL name field will now cause a
>> crash. E.g.
>> 
>> $ ./build/mips/qemu-system-mipsel -nographic -drive if=none,format=qcow2,file=dummy.qcow2
>>     [Type "C-a c" to get the "(qemu)" monitor prompt)]
>>     (qemu) savevm foo
>> 
>>     Backtrace from doing this under gdb:
>> 
>>       #0  0x0000555555df7d4d in vmsd_can_compress (field=0x5555564f78a0
>>       <__compound_literal.3>) at ../../migration/vmstate.c:339
>>       #1  0x0000555555df7dbb in vmsd_desc_field_start
>>           (vmsd=0x555556431ba0 <vmstate_cpuhp_state>, vmdesc=0x555556918690,
>>       field=0x5555564f78a0 <__compound_literal.3>, i=0, max=1) at
>>       ../../migration/vmstate.c:362
>>       #2  0x0000555555df85a7 in vmstate_save_state_v
>>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>>       opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=1,
>>       errp=0x7fffffffc948) at ../../migration/vmstate.c:528
>>       #3  0x0000555555df8032 in vmstate_save_state
>>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>>       opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
>>       at ../../migration/vmstate.c:427
>>       #4  0x0000555555df8f83 in vmstate_subsection_save
>>           (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
>>       opaque=0x555556c9aac0, vmdesc=0x555556918690, errp=0x7fffffffc948)
>>           at ../../migration/vmstate.c:695
>> 
>> Due to their very nature, it's better to allow stubs to be
>> completely empty instead of forcing any rules. Teach the code to skip
>> them.
>> 
>> Fixes: 7aa563630b ("pc: Start with modern CPU hotplug interface by default")
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/savevm.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index dd58f2a705..e8d3360877 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -861,6 +861,10 @@ static void vmstate_check(const VMStateDescription *vmsd)
>>      const VMStateField *field = vmsd->fields;
>>      const VMStateDescription * const *subsection = vmsd->subsections;
>>  
>> +    if (!vmsd->name) {
>> +        return;
>> +    }
>
> IIUC this is fine but isn't needed for stubs' use case, because "field" is
> checked right below..
>
>> +
>>      if (field) {
>
> .. here.
>
>>          while (field->name) {
>>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
>> @@ -897,6 +901,11 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>>  {
>>      SaveStateEntry *se;
>>  
>> +    if (!vmsd->name) {
>> +        /* assume it's a stub and ignore */
>> +        return 0;
>> +    }
>
> Two questions on this one..
>
> (1) when someone adds some new VMSD to device and forgot to attach a name,
>     it'll silently ignore that new VMSD.. of course anyone testing this
>     will find something strange, but silently ignoring an VMSD when not
>     having name does sound like unexpected..
>
> (2) would this fix the above crash?  The problem is the commit got fixed
>     used VMSTATE_CPU_HOTPLUG which is an internal vmsd, this one only
>     checks the top VMSD (which should have a name here..).  So I'm not sure
>     if it'll work..
>

Ouch, you're right. I checked the CI, but the issue caught by the CI was
the other one. My brain is fried, I'll get back to you guys
tomorrow. Sorry for the noise.

> Is that MIPS board the only one that is broken?  Do we want to make sure
> nothing is missed? We can definitely decide to break the migration, but we
> can also choose to just revert the needed() back to normal.  It just that
> it looks like we don't strongly need to break it.. as I don't see what we
> get from breaking it yet.. (say, it's not like we can get rid of some weird
> API or legacy function, we need to support needed() anyway..)
>
>> +
>>      /* If this triggers, alias support can be dropped for the vmsd. */
>>      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
>>  
>> -- 
>> 2.51.0
>> 

