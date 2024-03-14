Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F80C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rknKo-0002bA-IW; Thu, 14 Mar 2024 11:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rknKm-0002ak-QD
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:49:32 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rknKk-00088j-Vy
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:49:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD0C021D3C;
 Thu, 14 Mar 2024 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710431365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyiVEK6szeJ4sVZQklq28GiejLCfpy3rgaMZ8ehlvpA=;
 b=LuM7wYLN1umnCvcT6wH6OD2JWOIiO7tNlZhgD6JnfNTa4i2WdoNA6sfHW80rqZBuBlCzpg
 UgXc4/YUmNxoi8W95Xl2xMe0HUPNMKuyIr4/0jQ/I0knwjgu+bp7Umj9WIrRzsq7FozR6W
 CdmzzKglU2uGcd4+6LElQCvm+j2Ed7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710431365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyiVEK6szeJ4sVZQklq28GiejLCfpy3rgaMZ8ehlvpA=;
 b=JycLJK0rzaXdDuxTHWowP6YlnCWpFmZgSSemlWNXmRH9vjXF9LsJYctvy3sP/btV7ME73s
 EQQ7EA/Arq1vHbDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710431364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyiVEK6szeJ4sVZQklq28GiejLCfpy3rgaMZ8ehlvpA=;
 b=j42S0mN1qjeHZWzP81RsEJl9pG7gTnLG9zi0GpRQ6afzG6+pcbhLo3Mh+kuiMZd9CsN3kA
 jF8ran+3C1NIy+Tm2KiufU+jhgw31HsBCBBMCrgfipfGFE4obYIBwXwiDDMJtRctq4dR8S
 naJ4jBBZZpUAqiUJmugAOyEN+/+4Qh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710431364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyiVEK6szeJ4sVZQklq28GiejLCfpy3rgaMZ8ehlvpA=;
 b=nNJdJHoieUTGX/Vq8YxPFPaD+WIDaY2zfZVYEXPXfPcYkN9tA9QkBqO7UNIjVlhvzSpOE/
 d0RqwUSLGm62YYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA901368B;
 Thu, 14 Mar 2024 15:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PRATLYQc82WsMQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 15:49:24 +0000
Message-ID: <c2aa273a-6f49-2a02-fd4d-a3ddd37db388@suse.de>
Date: Thu, 14 Mar 2024 16:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>
From: Claudio Fontana <cfontana@suse.de>
Subject: question on s390x topology: KVM only, or also TCG?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j42S0mN1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nNJdJHoi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; SUBJECT_ENDS_QUESTION(1.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: DD0C021D3C
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

Hello Pierre, Ilya,

I have a question on the s390x "topology" feature and examples.

Mainly, is this feature supposed to be KVM accelerator-only, or also available when using the TCG accelerator?

(docs/devel/s390-cpu-topology.rst vs https://www.qemu.org/docs/master/system/s390x/cpu-topology.html)

I see stsi-topology.c in target/s390x/kvm/ , so that part is clearly KVM-specific,

but in hw/s390x/cpu-topology.c I read:

"
 * - The first part in this file is taking care of all common functions                                                                     
 *   used by KVM and TCG to create and modify the topology.                                                                                 
 *                                                                                                                                          
 * - The second part, building the topology information data for the                                                                        
 *   guest with CPU and KVM specificity will be implemented inside                                                                          
 *   the target/s390/kvm sub tree.
"

In the docs/devel/s390-cpu-topology.rst

I see the example command:

 qemu-system-s390x \
    -enable-kvm \
    -cpu z14,ctop=on \
    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
    -device z14-s390x-cpu,core-id=19,entitlement=high \
    -device z14-s390x-cpu,core-id=11,entitlement=low \
    -device z14-s390x-cpu,core-id=12,entitlement=high \
   ...


which uses KVM only.

In https://www.qemu.org/docs/master/system/s390x/cpu-topology.html

I read:

"Prerequisites:
To use the CPU topology, you need to run with KVM on a s390x host that uses the Linux kernel v6.0 or newer (which provide the so-called KVM_CAP_S390_CPU_TOPOLOGY capability that allows QEMU to signal the CPU topology facility via the so-called STFLE bit 11 to the VM).
"

So I would assume this is KVM-only, but then in the "Examples" section below I see the example:

"
$ qemu-system-s390x -m 2G \
  -cpu gen16b,ctop=on \
  -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
  -device host-s390x-cpu,core-id=14 \
"

and

"
qemu-system-s390x -m 2G \
  -cpu gen16b,ctop=on \
  -smp cpus=1,sockets=8,cores=4,maxcpus=32 \
  \
  -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=1 \
  -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=2 \
  -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=3 \
  \
  -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=9 \
  -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=14 \
  \
  -device gen16b-s390x-cpu,core-id=4,dedicated=on,entitlement=high
"

We received questions about this, so I hope you can shed some light, maybe it would be good to just update the web page to include -accel kvm or -enable-kvm everywhere for clarity?

Thanks for your help on this,

Claudio

-- 
Claudio Fontana
Engineering Manager Virtualization, SUSE Labs Core

SUSE Software Solutions Italy Srl

