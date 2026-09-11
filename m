Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7948C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50mb-0000R9-Sf; Fri, 11 Sep 2026 08:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x50ma-0000OO-CN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:55:08 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x50mA-00022k-Hy
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:55:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9055E1FF01;
 Fri, 11 Sep 2026 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789131274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/iHV+Y4en9401T/dzBCxDXXr8CyF7fSiDFptGtwPjg=;
 b=Sa5IpZmrdcOW51z0906KNrOJWkWV1MbJ/Ewk84GYdaBk3t+O2bwt1G2XE8LQ/dFTdk2Uf5
 vMuk9G8keho6QY0FaqqtxmWrVPtlqVhgtFfd5i3RoxKrz7L0AwHHJDZf/z6gXMRek1WtwZ
 AgDkPBe+U3oCFw98aFVOZV7OaNQ3yBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789131274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/iHV+Y4en9401T/dzBCxDXXr8CyF7fSiDFptGtwPjg=;
 b=xSIDb5WqyvVGZ/RkYsKRiRuynUjaDvVsG0HZx2LX+HavrOXCnd3v6l5OAvYRp0JwriL1ao
 SaY7J5xYvMNgYbCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789131270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/iHV+Y4en9401T/dzBCxDXXr8CyF7fSiDFptGtwPjg=;
 b=WlS/RtmYDm5eSxdFpDtSJH/yLbTYXylZLKK8X8LfnhZVFCCNhqNr4meQFk7s0t5vEIPpH9
 mdP1AbRuFpylZbmsKGB2ypkVgnYWNFx6XcYPjyaOx8HrIL8y+wDGXWQZ8dfnF10qvY4agA
 ohSGflpQFi8X2L6N+2O9u2A+ywA1ilw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789131270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/iHV+Y4en9401T/dzBCxDXXr8CyF7fSiDFptGtwPjg=;
 b=TmbGYvyNAkCunwdqkAUMoM0zQOcPav0v95O3QKlCv6DQKzuQNU1n5lh3XP/xDsa5SttZRi
 N04+kItHfu9VAFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 126D2136ED;
 Fri, 11 Sep 2026 12:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d5taNQX6o2rzGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Sep 2026 12:54:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 13/18] migration: Use keyval input visitor in HMP set
 command
In-Reply-To: <87y0d89oyv.fsf@pond.sub.org>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-14-farosas@suse.de> <87qzj1e563.fsf@pond.sub.org>
 <87qzj1tcpl.fsf@suse.de> <87h5jwu59t.fsf@suse.de>
 <87y0d89oyv.fsf@pond.sub.org>
Date: Fri, 11 Sep 2026 09:54:27 -0300
Message-ID: <87ecf0t0cc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>
> [...]
>
>>>> I think a hmp_report_error(MonitorHMP *hmp, const char *fmt, ...) would
>>>> be nice to have.
>>>>
>>>
>>> I'll look into it.
>>>
>>
>> I see that hmp_handle_error() takes an hmp argument that's unused and
>
> Unused since commit 193227f9e5 (error: Use error_report_err() instead of
> monitor_printf(), 2015-12-18).
>
> I doubt it's worth removing.
>
>> also that callers often do the redundant:
>>
>>    if (err) {
>>       hmp_handle_error(err);
>>    }
>
> Would be nice to clean this up.
>

Yep, I've a patch for it.

>> But aside from those I don't see other improvements to be made, many
>> callsites of hmp_handle_error() re-use the Error for other calls,
>> e.g. block/monitor/block-hmp-cmds.c:
>>
>>     Error *err = NULL;
>>     ...
>>     if (!qdict_get_try_str(qdict, "node-name")) {
>>         qobject_unref(qdict);
>>         error_setg(&err, "'node-name' needs to be specified");
>>         goto out;
>>     }
>>
>>     BlockDriverState *bs = bds_tree_init(qdict, &err);
>>     if (!bs) {
>>         goto out;
>>     }
>>
>>     bdrv_set_monitor_owned(bs);
>>  out:
>>     qemu_opts_del(opts);
>>     hmp_handle_error(err);
>>
>> So having another helper I think would just create confusion as
>> error_setg() is already a standard way of creating an error.
>
> We have both error_report() and error_report_err(), and it doesn't lead
> to confusion as far as I can tell.
>

They're not analogous, hmp_handle_error() it's more versatile than
error_report_err() because it can cope with err=NULL:

// this uses only one helper for the error
pseudo1() {
    err = NULL;
    
    ret = afunc();
    if (ret < 0) {
        error_setg(&err, "fail");
        goto out;
    }
    
    another_func(&err);
    if (hmp_handle_error(err)) {
        return;
    }
    
    yet_another_func(&err);
out:
    hmp_handle_error(err);
}

vs.

// this needs two different helpers
pseudo2() {
    err = NULL;
    
    ret = afunc();
    if (ret < 0) {
        hmp_error_report("fail");
        return;
    }
    
    another_func(&err);
    if (hmp_handle_error(err)) {
        return;
    }
    
    yet_another_func(&err);
    hmp_handle_error(err);
}

> Whether doing the same for HMP error reporting would be an improvement
> is not obvious.  Let's move on.
>

Sure

> [...]

