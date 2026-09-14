Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F9EC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x67xw-0000Pk-86; Mon, 14 Sep 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x67xs-0000PV-Mm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:47:24 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x67xq-0004tS-W6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:47:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 042FD21C6D;
 Mon, 14 Sep 2026 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789397234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwNj2YsMIY+phz7k2LXsZWq+UTl99RO+xBp6icEKPmg=;
 b=bXJf/VS2Y6j95puEuRt5Zb07I39PvhZARPgFHSM23IuGu6x/u6NVq6Wntk69ZyW1Fz2vgp
 kBapVTU5U75vO/qadVggJuRr11pFXNczSPFTp4BAo6u3XI7ywt4/Kqk77ToH3T8A89vADG
 u+i5C6sjoMSPUG3f29BGHfc2gq+46l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789397234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwNj2YsMIY+phz7k2LXsZWq+UTl99RO+xBp6icEKPmg=;
 b=C9D3Ibkqva8JJ4xmqL9vdxQr2d0BAiHHaaPGPPNMm4+pI7NZNX823LVKY7bVJ+fyDSv8ja
 mkKiDSpXmK2SC/BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="u4FIc/sT";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BA92ERkk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789397230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwNj2YsMIY+phz7k2LXsZWq+UTl99RO+xBp6icEKPmg=;
 b=u4FIc/sTPiKR/esZ2wPZTvoykgGs/Bci4QdA3VCJz0fkSFSrsSvPKi63+D9uzQyf2UK3hl
 BXjeEuY/TdP5iuB1Pb4KIXQuOsigNUZGF8Kzg4CYYoAASdbdKSQuMuXtB+pYYHIfTixPJE
 tSLwhffyt/f2oMHJ4qfF+bYU/1Pkc/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789397230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwNj2YsMIY+phz7k2LXsZWq+UTl99RO+xBp6icEKPmg=;
 b=BA92ERkkWrXDKcHXyeCPxbjOQ9541Yxxn0sCjVu7rzsUXJwZQfrL/xaeQqdV2n9j0Dcp46
 R1WGZJnbROWIkuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D0A13693;
 Mon, 14 Sep 2026 14:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j4CIEu0IqGr+NgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Sep 2026 14:47:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/18] tests/qtest/migration: Add a test for HMP
 completion
In-Reply-To: <aqcOjb1jV_UJlBwx@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-11-farosas@suse.de> <aqcOjb1jV_UJlBwx@gallifrey>
Date: Mon, 14 Sep 2026 11:47:03 -0300
Message-ID: <87a4pjubyw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 042FD21C6D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Fabiano Rosas (farosas@suse.de) wrote:
>> The following patches will touch HMP readline completion for migration
>> parameters, add a test case.
>> 
>> The test puts the monitor on a chardev via socket and bypasses qtest
>> facilities because it needs to emit raw codes to readline. It
>> therefore requires a couple of new helpers to read/write to the
>> monitor socket.
>> 
>> Usage:
>> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/completion
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>
>> +static void hmp_sock_read(int fd, char *buf, size_t buf_sz)
>> +{
>> +    char *p = buf;
>> +    size_t sz = buf_sz - 1;
>> +
>> +    assert(fd >= 0);
>> +    memset(buf, 0, buf_sz);
>> +
>> +    while (sz > 0) {
>> +        ssize_t r = read(fd, p, sz);
>> +        char *prompt;
>> +
>> +        if (!r) {
>> +            break;
>> +        } else if (r < 0) {
>> +            if (errno == EINTR) {
>> +                continue;
>> +            }
>> +            g_assert_not_reached();
>> +        }
>> +
>> +        p += r;
>> +        sz -= r;
>> +
>> +        prompt = strstr(buf, "(qemu) ");
>> +        if (prompt) {
>> +            *prompt = '\0';
>
> I'm a bit confused by what you want the output to look like after this,
> are you assuming this is the end of the string you're reading so truncation
> is OK?
>

Yes, it's how I'm detecting the end of input. Here's a printf("%s|\n", buf)
before the truncation:

1) Read banner:                                                                                    

QEMU 11.1.50 monitor - type 'help' for more information
(qemu) |

2) Write completion input 'migra\t'. Then read back:

migra
migrate                 migrate_cancel          migrate_continue
migrate_incoming        migrate_pause           migrate_recover
migrate_set_capability  migrate_set_parameter   migrate_start_postcopy
(qemu) |

3) Write completion input 'info migra\t'. Then read back:

info migra
migrate               migrate_capabilities  migrate_parameters
(qemu) |

I think this is correct? Let me know if I missed something.

>> +            break;
>> +        }
>> +    }
>> +}
>> +
>> +static int comp(const void *a, const void *b)
>> +{
>> +    return strcmp(*(const char **) a, *(const char **) b);
>> +}
>
> Can you use qemu_pstrcmp0 there? (Maybe with g_ptr_array and g_ptr_array_sort is
> what adds to some of the other questions below?)
>

Good idea, specially the g_ptr_array. I'll update the code.


