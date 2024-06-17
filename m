Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89875C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9qG-0001nf-KP; Mon, 17 Jun 2024 06:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sJ9qF-0001nN-M3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:44:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sJ9qD-0003Sj-Tt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:44:03 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2120A5FEF1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718621039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a8bdIkBj6wZe0IN1HTK9Y69CwIxBevvLUOx3U97L41Q=;
 b=DFdAJfNYveZxS7LTS/IjIxBPKQ5y4c3grPYiSrmxjZf0bUiGUZonPv27aaJmq9q65tAQC5
 TuJv8SL+NNpbPI7LQuMRraIzXZMer4buXXjSHR6MaaKbKz9VnrtIESKV4Ww/beWJMh4XX2
 V3zQDAH/DokAtO7+QaBJZo8PwzSRlRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718621039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a8bdIkBj6wZe0IN1HTK9Y69CwIxBevvLUOx3U97L41Q=;
 b=VX8xtk1KN1aEf24sZEOR167DIhZueByIzygx6K3g6O6VfzLF8uLh1tCBq1LidOQuyMC+bI
 1E2G46ju5KGfYIBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DFdAJfNY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VX8xtk1K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718621039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a8bdIkBj6wZe0IN1HTK9Y69CwIxBevvLUOx3U97L41Q=;
 b=DFdAJfNYveZxS7LTS/IjIxBPKQ5y4c3grPYiSrmxjZf0bUiGUZonPv27aaJmq9q65tAQC5
 TuJv8SL+NNpbPI7LQuMRraIzXZMer4buXXjSHR6MaaKbKz9VnrtIESKV4Ww/beWJMh4XX2
 V3zQDAH/DokAtO7+QaBJZo8PwzSRlRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718621039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a8bdIkBj6wZe0IN1HTK9Y69CwIxBevvLUOx3U97L41Q=;
 b=VX8xtk1KN1aEf24sZEOR167DIhZueByIzygx6K3g6O6VfzLF8uLh1tCBq1LidOQuyMC+bI
 1E2G46ju5KGfYIBQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 091DB4A051E; Mon, 17 Jun 2024 12:43:59 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: linux-user: array overflow in pselect6 emulation
X-Yow: Hello?  Enema Bondage?  I'm calling because I want to be happy, I
 guess..
Date: Mon, 17 Jun 2024 12:43:59 +0200
Message-ID: <mvmfrtbq26o.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [1.67 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; ONCE_RECEIVED(1.20)[];
 RDNS_NONE(1.00)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-0.93)[-0.925];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.976]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 2120A5FEF1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
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

$ cat select.c
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/resource.h>
#include <sys/select.h>
#include <sys/syscall.h>

int
main (int argc, char **argv)
{
  int nfds = (argc > 1 ? atoi (argv[1]) : 1031);
  fd_set *fds = calloc ((nfds + (sizeof (fd_mask) * 8) - 1)
                        / (sizeof (fd_mask) * 8), sizeof (fd_mask));
  setrlimit (RLIMIT_NOFILE,
             &(struct rlimit){ .rlim_cur = nfds, .rlim_max = nfds });
  dup2 (open ("/dev/null", O_RDONLY), nfds - 1);
  FD_SET (nfds - 1, fds);
  syscall (SYS_pselect6, nfds, fds, 0, 0, 0, 0);
}
$ ./select
$ qemu-x86_64 -strace select
25005 brk(NULL) = 0x0000000000403000
25005 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fe4293b6000
25005 uname(0x7fe429bba380) = 0
25005 access("/etc/ld.so.preload",R_OK) = -1 errno=2 (No such file or directory)
25005 openat(-100,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) = 3
25005 fstat(3,0x00007fe429bb9950) = 0
25005 mmap(NULL,249267,PROT_READ,MAP_PRIVATE,3,0) = 0x00007fe429379000
25005 close(3) = 0
25005 openat(-100,"/lib64/libc.so.6",O_RDONLY|O_CLOEXEC) = 3
25005 read(3,0x29bb9b18,832) = 832
25005 fstat(3,0x00007fe429bb99b0) = 0
25005 mmap(NULL,2058296,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007fe429182000
25005 mmap(0x00007fe42936a000,45056,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x1e7000) = 0x00007fe42936a000
25005 mmap(0x00007fe429375000,14392,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007fe429375000
25005 close(3) = 0
25005 mmap(NULL,12288,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fe42917f000
25005 arch_prctl(4098,140617918707520,140617918709920,34,4294967295,0) = 0
25005 mprotect(0x00007fe42936a000,12288,PROT_READ) = 0
25005 mprotect(0x0000000000401000,4096,PROT_READ) = 0
25005 mprotect(0x000000000002a000,4096,PROT_READ) = 0
25005 munmap(0x00007fe429379000,249267) = 0
25005 brk(NULL) = 0x0000000000403000
25005 brk(0x0000000000424000) = 0x0000000000424000
25005 prlimit64(0,RLIMIT_NOFILE,{rlim_cur=1031,rlim_max=1031},NULL) = 0
25005 openat(-100,"/dev/null",O_RDONLY) = 3
25005 dup2(3,1030) = 1030
25005 pselect6(1031,4207264,0,0,0,0)*** bit out of range 0 - FD_SETSIZE on fd_set ***: terminated
Aborted (core dumped)

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

