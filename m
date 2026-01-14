Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4DBD29FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzYG-0007yO-Ml; Wed, 14 Jan 2026 07:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfzYE-0007s9-5I
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:00:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfzYC-0005at-16
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:00:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C8DA5C4E9;
 Wed, 14 Jan 2026 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768392031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtveHY4q3COoRsHAepIbBafVMLKVl2JVpjOKmbdQDN4=;
 b=Vg9JKwnIZAjGr3t9rhR1Ua1CuW+ghdjsgPgYQNeocfbqs+ju6/kmuYwZCmkLls452TXvZd
 t39fXoX/dUfD3zPyc3PPzSoMr/pb6wOQ2NryBDvJkTWyVenTYYfM/R9CEm3g5AslVaGpBv
 7uJu8PbingJ/zCr3ykjDvSF5rSK0+s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768392031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtveHY4q3COoRsHAepIbBafVMLKVl2JVpjOKmbdQDN4=;
 b=G6UR5exz2etkE5lqZU+Akg17jIO5MesjergN99F4klnvEDfFODPeYPP1IUzQnSEZ3lgk50
 ByQovr1pUS+v6uBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vg9JKwnI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G6UR5exz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768392031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtveHY4q3COoRsHAepIbBafVMLKVl2JVpjOKmbdQDN4=;
 b=Vg9JKwnIZAjGr3t9rhR1Ua1CuW+ghdjsgPgYQNeocfbqs+ju6/kmuYwZCmkLls452TXvZd
 t39fXoX/dUfD3zPyc3PPzSoMr/pb6wOQ2NryBDvJkTWyVenTYYfM/R9CEm3g5AslVaGpBv
 7uJu8PbingJ/zCr3ykjDvSF5rSK0+s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768392031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtveHY4q3COoRsHAepIbBafVMLKVl2JVpjOKmbdQDN4=;
 b=G6UR5exz2etkE5lqZU+Akg17jIO5MesjergN99F4klnvEDfFODPeYPP1IUzQnSEZ3lgk50
 ByQovr1pUS+v6uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE1133EA63;
 Wed, 14 Jan 2026 12:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p1tNI16FZ2k/LQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:00:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] tests/functional/x86_64: Use the right Python
 interpreter & fix format string
In-Reply-To: <20260114101101.36225-1-thuth@redhat.com>
References: <20260114101101.36225-1-thuth@redhat.com>
Date: Wed, 14 Jan 2026 09:00:28 -0300
Message-ID: <874ioopfoj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.48 / 50.00]; BAYES_HAM(-2.97)[99.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5C8DA5C4E9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The bad_vmstate test currently fails if the host does not have a "python3"
> binary in $PATH because the vmstate-static-checker.py script is executed
> directly, so that it gets run via its shebang line. Use the right Python
> interpreter from sys.executable to fix this problem.
>
> Additionally, there was another bug with the formatting of the error
> message in case of failures: The "+" operator can only concatenate strings,
> but not strings with integers. Use a proper format string here instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/x86_64/test_bad_vmstate.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/functional/x86_64/test_bad_vmstate.py b/tests/functional/x86_64/test_bad_vmstate.py
> index 40098a8490b..71a1c0cf638 100755
> --- a/tests/functional/x86_64/test_bad_vmstate.py
> +++ b/tests/functional/x86_64/test_bad_vmstate.py
> @@ -5,6 +5,7 @@
>  '''Test whether the vmstate-static-checker script detects problems correctly'''
>  
>  import subprocess
> +import sys
>  
>  from qemu_test import QemuBaseTest
>  
> @@ -41,12 +42,13 @@ def test_checker(self):
>                                         'vmstate-static-checker.py')
>  
>          self.log.info('Comparing %s with %s', src_json, dst_json)
> -        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
> +        cp = subprocess.run([sys.executable, checkerscript,
> +                             '-s', src_json, '-d', dst_json],
>                              stdout=subprocess.PIPE,
>                              stderr=subprocess.STDOUT,
>                              text=True, check=False)
>          if cp.returncode != 13:
> -            self.fail('Unexpected return code of vmstate-static-checker: ' +
> +            self.fail('Unexpected return code of vmstate-static-checker: %d' %
>                        cp.returncode)
>          if cp.stdout != EXPECTED_OUTPUT:
>              self.log.info('vmstate-static-checker output:\n%s', cp.stdout)

Acked-by: Fabiano Rosas <farosas@suse.de>

