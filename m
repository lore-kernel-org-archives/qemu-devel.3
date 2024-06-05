Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D902C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmiu-00059f-LV; Wed, 05 Jun 2024 05:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sEmis-00058y-Og
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:14:22 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sEmir-0000Cb-5x
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:14:22 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id DDCFB21A61
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717578858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=vtGKSyUhtS72HIxxhvrZ+lqdKuFGY8Sfcp2iXxIUfEg=;
 b=VUp7c/YOjyh1OGc3XzM/VASfIUjuRixlborXU5qslueD8TdLVtIrBztI8JnEjg9YycU5zB
 bka6lGzyp+B2rzDHV0ILL4ATUNA6yexRqsy/Thqowv7AksBBtY73nHnU1OGvsbFQ2IjA0O
 jEIMVmqPCxwZYtwB/GGSPQ3ZClMrcoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717578858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=vtGKSyUhtS72HIxxhvrZ+lqdKuFGY8Sfcp2iXxIUfEg=;
 b=mrGBa8Vqn0YtMXn3HMiXZgH7g/n2pCfEJ0qkSFXdhbMEoOonzwolJLqC0Jpt8Trmo0X5KP
 uOOQGTjIqCXZKuAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717578857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=vtGKSyUhtS72HIxxhvrZ+lqdKuFGY8Sfcp2iXxIUfEg=;
 b=u3pCR9DYa6T9kaX9zM7JxbwC17nYY2Dp+lLTjqdJgpqv+PK5aEX+s5qAiRESP39cCHS4Yd
 NYYc9WCIlYzbUqow2iKBoPnjkHpxqcj33o36R4XVstrm7bV62aRDcY0T2sojXRWHpglBKA
 hRKDwqSkJ4jJEYcrpZ4MX+7hMuWI+34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717578857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=vtGKSyUhtS72HIxxhvrZ+lqdKuFGY8Sfcp2iXxIUfEg=;
 b=upIak1m5Y77mjvfTSAPh/tXrjRxn7XDeWgmKZKjh8jtD3MuicZNnw1ezFWPuN4irB8p+vA
 Yn8wOmrgq3SZ5fAQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id CF0114A0552; Wed,  5 Jun 2024 11:14:17 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: linux-user emulation hangs during fork
X-Yow: Will this never-ending series of PLEASURABLE EVENTS never cease?
Date: Wed, 05 Jun 2024 11:14:17 +0200
Message-ID: <mvm5xunu4ye.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.19 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.974]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

$ qemu-x86_64 --version
qemu-x86_64 version 9.0.50 (v9.0.0-1211-gd16cab541a)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
$ cat fork.rb 
begin
  r, w = IO.pipe
  if pid1 = fork
    w.close
    r.read 1
    Process.kill "USR1", pid1
    Process.wait2 pid1
  else
    print "child\n"
    r.close
    if pid2 = fork
      trap("USR1") { print "child: kill\n"; Process.kill "USR2", pid2 }
      w.close
      print "child: wait\n"
      Process.wait2 pid2
    else
      print "grandchild\n"
      w.close
      sleep 0.2
    end
  end
end
$ ruby fork.rb
child
child: wait
grandchild
child: kill
$ qemu-x86_64 /usr/bin/ruby fork.rb
child
child: wait
^Z
[1]+  Stopped                 qemu-x86_64 /usr/bin/ruby fork.rb
$ grep SigB $(for p in $(pidof qemu-x86_64); do echo /proc/$p/status; done | sort)
/proc/3221/status:SigBlk:       0000000000000000
/proc/3224/status:SigBlk:       0000000000000000
/proc/3228/status:SigBlk:       fffffff27ffbfa9f

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

