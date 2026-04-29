Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A3FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI55w-0004oO-QW; Wed, 29 Apr 2026 09:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI55t-0004oC-A6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:36:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI55r-0007qs-89
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:36:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 846495BD58;
 Wed, 29 Apr 2026 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777469799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKND0YhH8rEkJ4B1tEfZy+p/BbPX0YQQP6TX5dPHW94=;
 b=wHShWwL144+qTyclXRG8jbLob5/yHi+dVynSx77/ahoIJ7EBU8xCSs1yHa5VeNIr5q3l3L
 qtwJVmB4mbJPjMH4eWlXJjBNItzdA9NW5qHNkNfJoiy21yefp23L1IQJULc8Yla71aWtJx
 LcD/QPlLdQjZEx2/h7YR94vUSUTbIJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777469799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKND0YhH8rEkJ4B1tEfZy+p/BbPX0YQQP6TX5dPHW94=;
 b=LDyStsS+1+/8b4LGofeyV0bTD0uZQsVmobSO2Vl0m9EJH2qj/xujsO6cocM8UoV2y4uVTl
 k/aILW1JK6h8qTDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jJjplc7j;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pr8zojy5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777469795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKND0YhH8rEkJ4B1tEfZy+p/BbPX0YQQP6TX5dPHW94=;
 b=jJjplc7jmY83UgSZYKiMZAbD3VI6+0TDAeBSoOz6sFjhxRelYEhv7REKMpUgzmElC8t3xN
 RqLbYBHoTp0BNGLeDh7MAKZpRj733vSFvJ0xVcIYLlzeP/DCw5YId5G6XpCd1paSBimnx9
 N2rG6qBxWtbSCCLa7tqCbbzJvL45akU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777469795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKND0YhH8rEkJ4B1tEfZy+p/BbPX0YQQP6TX5dPHW94=;
 b=pr8zojy58zdC/zTjsuGY0Tni9/ygjRM8hcIjlcPsnAziXeMA5CZYn6uSgeM+tmEpkHzs31
 QHg/joPsmhyWTvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F26B593B0;
 Wed, 29 Apr 2026 13:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id igfgN2IJ8mk0MgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 13:36:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
In-Reply-To: <87jytsig98.fsf@suse.de>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
 <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
 <87a4usdmcp.fsf@suse.de> <6B7E6259-86A8-4CAB-8FFF-A406FA36F277@gmail.com>
 <87jytsig98.fsf@suse.de>
Date: Wed, 29 Apr 2026 10:36:24 -0300
Message-ID: <87a4ulriqv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 846495BD58
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

(tried to stitch the thread back together)

Elisey Konstantinov <elisey.konstantinov@gmail.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Elisey Konstantinov <elisey.konstantinov@gmail.com> writes:
>>
>>> Oh, thanks for the feedback, however, could you please describe the env=
ironment you=E2=80=99re using?
>>
>> x86_64 host running Linux kernel 6.4.0. QEMU configured with:
>>
>> ../configure
>> --target-list=3Dx86_64-softmmu,aarch64-softmmu,ppc64-softmmu,ppc-softmmu=
,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,mips64-softmmu
>> --disable-plugins --enable-modules --enable-werror --enable-debug --disa=
ble-docs
>>
>> QEMU cmdline:
>>
>> qemu-system-ppc -machine mac99 -boot d -d guest_errors,unimp,cpu_reset
>> -cdrom osx_100_4k78_install.iso -prom-env "boot-args=3D-v"
>>
>> Connecting via VNC shows the machine runs up to and past the point shown
>> in the screenshot posted as the working example in:
>> https://gitlab.com/qemu-project/qemu/-/work_items/3276#note_3105980116
>>
>> Clicking around, the VM seems functional.
>
> Yeah, this sounds weird, could you please test on the old distribution,
> like Debian 12?See three of my latest messages in the main thread for
> more information

Sorry, I don't have the means to test this on Debian 12. It's not clear
from the thread, have you reproduced the issue using the HEAD of QEMU's
master branch? If so, then I think the best we could do is go back to
the original issue[1] on Gitlab and continue the investigation.

From the information you posted there, the execution should have gotten
past the happy mac screen. You could try running with -prom-env
"boot-args=3D-v" as I did above and see if it gives you any logging past
that screen. Post a screenshot of your VNC session showing those logs.

1- https://gitlab.com/qemu-project/qemu/-/work_items/3276

