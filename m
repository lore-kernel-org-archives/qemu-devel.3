Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F233D5E374
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVVuX-0003KR-Bp; Tue, 16 Dec 2025 09:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVuV-0003JW-0h
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:20:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVuS-0000Tt-Vs
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:20:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 519795BCDC;
 Tue, 16 Dec 2025 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765894813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaMFXXSLppug1KLjowz9ap5fJaKnjwVWCdMBqaq3h04=;
 b=pRn/7zZ4Mo9DoLc/vcvMJcgeKjyviz4CkYaNsoN1UF07Jir3HUeiLUgi33GQWwnIk8x8He
 zcXetAGkZBfnpLx1F00FZvenq3AcntMpRHigWLM9LcYFvcWopv27gAEGrLmBfotZLs7wcR
 RB2wxs+Bx5aUpckVko1GHZ3qY/nvF1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765894813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaMFXXSLppug1KLjowz9ap5fJaKnjwVWCdMBqaq3h04=;
 b=fpaU3WfnPylyLIk289HN9Je3caWQFUz7q1gsGgRzT+0l0jAjswPzbvsApspii6oKrY70Co
 ylmtiWneG5URJOAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pRn/7zZ4";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fpaU3Wfn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765894813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaMFXXSLppug1KLjowz9ap5fJaKnjwVWCdMBqaq3h04=;
 b=pRn/7zZ4Mo9DoLc/vcvMJcgeKjyviz4CkYaNsoN1UF07Jir3HUeiLUgi33GQWwnIk8x8He
 zcXetAGkZBfnpLx1F00FZvenq3AcntMpRHigWLM9LcYFvcWopv27gAEGrLmBfotZLs7wcR
 RB2wxs+Bx5aUpckVko1GHZ3qY/nvF1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765894813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaMFXXSLppug1KLjowz9ap5fJaKnjwVWCdMBqaq3h04=;
 b=fpaU3WfnPylyLIk289HN9Je3caWQFUz7q1gsGgRzT+0l0jAjswPzbvsApspii6oKrY70Co
 ylmtiWneG5URJOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C00113EA63;
 Tue, 16 Dec 2025 14:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bYgcH5xqQWnWQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Dec 2025 14:20:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, peterx@redhat.com, Alexey Kardashevskiy
 <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
In-Reply-To: <20251215205203.1185099-13-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-13-peterx@redhat.com>
Date: Tue, 16 Dec 2025 11:20:09 -0300
Message-ID: <87o6ny1pba.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 519795BCDC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Add a plain tcp test for guest-memfd.  Note that the test will be
> automatically skipped whenever not supported (e.g. qemu compiled without
> KVM, or host kernel doesn't support kvm, or old kernels, etc.).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/precopy-tests.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 57ca623de5..88d2627efd 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -215,6 +215,16 @@ static void test_precopy_tcp_plain(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_precopy_tcp_plain_gmemfd(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "tcp:127.0.0.1:0",
> +        .start.mem_type = MEM_TYPE_GUEST_MEMFD,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
>  static void test_precopy_tcp_switchover_ack(void)
>  {
>      MigrateCommon args = {
> @@ -1276,6 +1286,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>          return;
>      }
>  
> +    migration_test_add("/migration/precopy/tcp/plain/guest-memfd",
> +                       test_precopy_tcp_plain_gmemfd);
>      migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
>                         test_precopy_tcp_switchover_ack);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

