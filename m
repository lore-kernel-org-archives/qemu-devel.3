Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDB6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKVm-000705-Tc; Fri, 09 Aug 2024 03:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1scKVl-0006yB-AP; Fri, 09 Aug 2024 03:58:09 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1scKVj-0004xQ-4J; Fri, 09 Aug 2024 03:58:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 026E21FF16;
 Fri,  9 Aug 2024 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723190283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6W+uU1lUlPDFJUJ6ull0sC73zvSlpOSGqeI0md8Fkc=;
 b=OM6IR1/ZubAgZa12EDp1SWJ4C3sTvC86wBTCVJ1mi2ZJR0uPxse6JcXRSPPIGt04vrtaJX
 LTOsG643ackfxrh8PMhPgKGRu4ba2/9ASOYyow9hTU320akuV/3XcBVYpPXVv2xPH5tVWY
 CIepKgonpOj82K24PGunTvA2ogm2AzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723190283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6W+uU1lUlPDFJUJ6ull0sC73zvSlpOSGqeI0md8Fkc=;
 b=YCDLeMgXOiGUE8Ad27BzoBWsH+uvOJgub5f0pi7uYP10U5DPlgovTshGF0lgF/tTGI3PZP
 +3gDhnpUrhVhKKDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OM6IR1/Z";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YCDLeMgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723190283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6W+uU1lUlPDFJUJ6ull0sC73zvSlpOSGqeI0md8Fkc=;
 b=OM6IR1/ZubAgZa12EDp1SWJ4C3sTvC86wBTCVJ1mi2ZJR0uPxse6JcXRSPPIGt04vrtaJX
 LTOsG643ackfxrh8PMhPgKGRu4ba2/9ASOYyow9hTU320akuV/3XcBVYpPXVv2xPH5tVWY
 CIepKgonpOj82K24PGunTvA2ogm2AzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723190283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6W+uU1lUlPDFJUJ6ull0sC73zvSlpOSGqeI0md8Fkc=;
 b=YCDLeMgXOiGUE8Ad27BzoBWsH+uvOJgub5f0pi7uYP10U5DPlgovTshGF0lgF/tTGI3PZP
 +3gDhnpUrhVhKKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B32B11379A;
 Fri,  9 Aug 2024 07:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d9wsKgrMtWb+GgAAD6G6ig
 (envelope-from <cfontana@suse.de>); Fri, 09 Aug 2024 07:58:02 +0000
Message-ID: <00caf9c1-b6bf-4cd2-bc32-1a31f4b526a9@suse.de>
Date: Fri, 9 Aug 2024 09:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] kvm: refactor core virtual machine creation into
 its own function
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: zhao1.liu@intel.com, qemu-trivial@nongnu.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20240809051054.1745641-1-anisinha@redhat.com>
 <20240809051054.1745641-3-anisinha@redhat.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20240809051054.1745641-3-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 026E21FF16
X-Spamd-Result: default: False [-6.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

gltm, thanks!

Reviewed-by: Claudio Fontana <cfontana@suse.de>

On 8/9/24 07:10, Ani Sinha wrote:
> Refactoring the core logic around KVM_CREATE_VM into its own separate function
> so that it can be called from other functions in subsequent patches. There is
> no functional change in this patch.
> 
> CC: pbonzini@redhat.com
> CC: zhao1.liu@intel.com
> CC: cfontana@suse.de
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 86 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 33 deletions(-)
> 
> changelog:
> v2: s/fprintf/warn_report as suggested by zhao
> v3: s/warn_report/error_report. function names adjusted to conform to
> other names. fprintf -> error_report() moved to its own patch.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ac168b9663..610b3ead32 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2385,6 +2385,57 @@ uint32_t kvm_dirty_ring_size(void)
>      return kvm_state->kvm_dirty_ring_size;
>  }
>  
> +static int kvm_create_vm(MachineState *ms, KVMState *s, int type)
> +{
> +    int ret;
> +
> +    do {
> +        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
> +    } while (ret == -EINTR);
> +
> +    if (ret < 0) {
> +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> +                    strerror(-ret));
> +
> +#ifdef TARGET_S390X
> +        if (ret == -EINVAL) {
> +            error_report("Host kernel setup problem detected. Please verify:");
> +            error_report("- for kernels supporting the switch_amode or"
> +                        " user_mode parameters, whether");
> +            error_report("  user space is running in primary address space");
> +            error_report("- for kernels supporting the vm.allocate_pgste "
> +                        "sysctl, whether it is enabled");
> +        }
> +#elif defined(TARGET_PPC)
> +        if (ret == -EINVAL) {
> +            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
> +                        (type == 2) ? "pr" : "hv");
> +        }
> +#endif
> +    }
> +
> +    return ret;
> +}
> +
> +static int kvm_machine_type(MachineState *ms)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    int type;
> +
> +    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
> +        g_autofree char *kvm_type;
> +        kvm_type = object_property_get_str(OBJECT(current_machine),
> +                                           "kvm-type",
> +                                           &error_abort);
> +        type = mc->kvm_type(ms, kvm_type);
> +    } else if (mc->kvm_type) {
> +        type = mc->kvm_type(ms, NULL);
> +    } else {
> +        type = kvm_arch_get_default_type(ms);
> +    }
> +    return type;
> +}
> +
>  static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2467,45 +2518,14 @@ static int kvm_init(MachineState *ms)
>      }
>      s->as = g_new0(struct KVMAs, s->nr_as);
>  
> -    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
> -        g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
> -                                                            "kvm-type",
> -                                                            &error_abort);
> -        type = mc->kvm_type(ms, kvm_type);
> -    } else if (mc->kvm_type) {
> -        type = mc->kvm_type(ms, NULL);
> -    } else {
> -        type = kvm_arch_get_default_type(ms);
> -    }
> -
> +    type = kvm_machine_type(ms);
>      if (type < 0) {
>          ret = -EINVAL;
>          goto err;
>      }
>  
> -    do {
> -        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
> -    } while (ret == -EINTR);
> -
> +    ret = kvm_create_vm(ms, s, type);
>      if (ret < 0) {
> -        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> -                    strerror(-ret));
> -
> -#ifdef TARGET_S390X
> -        if (ret == -EINVAL) {
> -            error_report("Host kernel setup problem detected. Please verify:");
> -            error_report("- for kernels supporting the switch_amode or"
> -                        " user_mode parameters, whether");
> -            error_report("  user space is running in primary address space");
> -            error_report("- for kernels supporting the vm.allocate_pgste "
> -                        "sysctl, whether it is enabled");
> -        }
> -#elif defined(TARGET_PPC)
> -        if (ret == -EINVAL) {
> -            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
> -                        (type == 2) ? "pr" : "hv");
> -        }
> -#endif
>          goto err;
>      }
>  


