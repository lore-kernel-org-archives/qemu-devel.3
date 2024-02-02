Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97862C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvCG-0005rq-Jb; Fri, 02 Feb 2024 10:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVvCF-0005rE-Fj
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:11:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVvCE-0001M6-1E
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:11:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A488321A04;
 Fri,  2 Feb 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706886672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khk/eqE/ZU6GiguRMAKHVNh1YhqZBPyvzK++566dyi0=;
 b=ACIjbDgQs5vLiQcvmND4cC1cyBtKMqGx38qSqYUpNQqdTzmPJ9h9ZGT/XiGsC4HI7eO2sx
 tWmyphMwamLVXw4ncHemUeStE5ai+QV8bqmDMwrnoA2aAbKTXWrhTLamOZWrMwJKdIvX0y
 McCwCMgQ5FSFmESkKgW9nb+cWR6AluA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706886672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khk/eqE/ZU6GiguRMAKHVNh1YhqZBPyvzK++566dyi0=;
 b=VOIgrjjGUcW1wM9Sn5JAvHbcwzn0XZ4SzDvotO2PXXLigWdTOY05DCEC+gwe4J8U3hYbxi
 nZ/X+qUR/pdIUgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706886672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khk/eqE/ZU6GiguRMAKHVNh1YhqZBPyvzK++566dyi0=;
 b=ACIjbDgQs5vLiQcvmND4cC1cyBtKMqGx38qSqYUpNQqdTzmPJ9h9ZGT/XiGsC4HI7eO2sx
 tWmyphMwamLVXw4ncHemUeStE5ai+QV8bqmDMwrnoA2aAbKTXWrhTLamOZWrMwJKdIvX0y
 McCwCMgQ5FSFmESkKgW9nb+cWR6AluA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706886672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khk/eqE/ZU6GiguRMAKHVNh1YhqZBPyvzK++566dyi0=;
 b=VOIgrjjGUcW1wM9Sn5JAvHbcwzn0XZ4SzDvotO2PXXLigWdTOY05DCEC+gwe4J8U3hYbxi
 nZ/X+qUR/pdIUgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25787139AB;
 Fri,  2 Feb 2024 15:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FUWfNw8GvWXULAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 15:11:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] migration: Fix return-path thread exit
In-Reply-To: <d2d0314a-494f-4ace-ba73-e14019fb4fd3@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-3-clg@redhat.com> <8734ubhqr9.fsf@suse.de>
 <d2d0314a-494f-4ace-ba73-e14019fb4fd3@redhat.com>
Date: Fri, 02 Feb 2024 12:11:09 -0300
Message-ID: <87zfwihpf6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ACIjbDgQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VOIgrjjG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; BAYES_HAM(-0.51)[80.08%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A488321A04
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 2/2/24 15:42, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> In case of error, close_return_path_on_source() can perform a shutdown
>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>> and the shutdown fails, leaving the source and destination waiting for
>>> an event to occur.
>>=20
>> At close_return_path_on_source, qemu_file_shutdown() and checking
>> ms->to_dst_file are done under the qemu_file_lock, so how could
>> migrate_fd_cleanup() have cleared the pointer but the ms->to_dst_file
>> check have passed?
>
> This is not a locking issue, it's much simpler. migrate_fd_cleanup()
> clears the ms->to_dst_file pointer and closes the QEMUFile and then
> calls close_return_path_on_source() which then tries to use resources
> which are not available anymore.

I'm missing something here. Which resources? I assume you're talking
about this:

    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
            qemu_file_get_error(ms->to_dst_file)) {
            qemu_file_shutdown(ms->rp_state.from_dst_file);
        }
    }

How do we get past the 'if (ms->to_dst_file)'?


