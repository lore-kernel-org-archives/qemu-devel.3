Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607ABC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 20:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQ2A-0002OG-JS; Mon, 14 Jul 2025 16:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ubOaI-0003WE-Fw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:11:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ubOaE-0006d2-M6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:11:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 636C22124B;
 Mon, 14 Jul 2025 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752520281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXva1BX8OnPP1ycvBL0ZAjIAPSSsMeapa/XK97VNWkQ=;
 b=KkqG9xLGBerh6MFGTgDyrCyitGHk46hrmEWZ3lJRFNg7zMa4QfB5AlLxni8Fa0xSF23Ru+
 BJIaSvMEs7txyN2EisXsbo5tgUqnh02RzznaSbIYJ+Okhex+519C5jhCiFEQOILNN8OdO4
 tAHGfFpycdHVwn2rJLUuYAk39Ps9CT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752520281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXva1BX8OnPP1ycvBL0ZAjIAPSSsMeapa/XK97VNWkQ=;
 b=eMBphLGLkXrp8+3zwjWjL2S9NuVXZAyQL3lHw55VVmjKWSg1dPXVMCakdkM2NBPqxV0PUG
 ghBvu7SgxVYtTTCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752520281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXva1BX8OnPP1ycvBL0ZAjIAPSSsMeapa/XK97VNWkQ=;
 b=KkqG9xLGBerh6MFGTgDyrCyitGHk46hrmEWZ3lJRFNg7zMa4QfB5AlLxni8Fa0xSF23Ru+
 BJIaSvMEs7txyN2EisXsbo5tgUqnh02RzznaSbIYJ+Okhex+519C5jhCiFEQOILNN8OdO4
 tAHGfFpycdHVwn2rJLUuYAk39Ps9CT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752520281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXva1BX8OnPP1ycvBL0ZAjIAPSSsMeapa/XK97VNWkQ=;
 b=eMBphLGLkXrp8+3zwjWjL2S9NuVXZAyQL3lHw55VVmjKWSg1dPXVMCakdkM2NBPqxV0PUG
 ghBvu7SgxVYtTTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D046F138A1;
 Mon, 14 Jul 2025 19:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TI4kI1hWdWjDdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Jul 2025 19:11:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PULL 25/26] migration/postcopy: Add latency distribution
 report for blocktime
In-Reply-To: <CAFEAcA-_2a5CUspXhy8UErA86EnZ3_s=P2DQ9DPdrMDwNWF4FQ@mail.gmail.com>
References: <20250711141031.423-1-farosas@suse.de>
 <20250711141031.423-26-farosas@suse.de>
 <CAFEAcA-_2a5CUspXhy8UErA86EnZ3_s=P2DQ9DPdrMDwNWF4FQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 16:11:18 -0300
Message-ID: <875xfumvu1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 11 Jul 2025 at 15:20, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> From: Peter Xu <peterx@redhat.com>
>>
>> Add the latency distribution too for blocktime, using order-of-two buckets.
>> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
>> prior rework, it's very easy to achieve by adding an array to account for
>> faults in each buckets.
>>
>> Sample output for HMP (while for QMP it's simply an array):
>>
>> Postcopy Latency Distribution:
>
> Hi; Coverity points out that there is a bug here (CID 1612248):
>
>> +static const gchar *format_time_str(uint64_t us)
>> +{
>> +    const char *units[] = {"us", "ms", "sec"};
>> +    int index = 0;
>> +
>> +    while (us > 1000) {
>> +        us /= 1000;
>> +        if (++index >= (sizeof(units) - 1)) {
>
> sizeof(units) is the size in bytes, which in this case is
> 24, as it is an array of three 8-byte pointers. So it's
> not the right thing to use in bounds checking the array index.
>
> You probably wanted ARRAY_SIZE(units). Also, the ++index
> inside the comparison here seems unnecessarily confusing.
> I would suggest something like
>
>     while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
>         us /= 1000;
>         index++;
>     }
>
> which puts into the while condition the two conditions under
> which we are OK to shift down a unit, and keeps it
> clear that we maintain the invariant of "when we shift
> down a unit we also divide the value by 1000".
>
>> +            break;
>> +        }
>> +    }
>> +
>> +    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
>
> Otherwise this units[index] access could be off the end of
> the array.
>
>> +}

Thanks for the report. Peter Xu is not available at the moment, I'll
work on this.

