Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8EAC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BWY-0006RD-Hm; Thu, 03 Sep 2026 13:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2BWW-0006Qx-77
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:46:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2BWU-0005b0-DB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:46:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C36E1F7B4;
 Thu,  3 Sep 2026 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYjtSa9ryjc70qcKjVP9Mt4OPlrdie+lhWD2faQultc=;
 b=mSAAWYFBhrPVg1qghAVP6WdFudkpa78nYLjL/7mu6iI85mfZ+k4dgLnfpOr03pu7NzCSuu
 yrMm1IHnoZoNZ405etniuHyoi8grurTeVv7y475QOdvwimGQGfKBzcewpsEh+42aauPZo6
 1wsJC4WGspay3pwBdKVNYeFxQpsvtn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYjtSa9ryjc70qcKjVP9Mt4OPlrdie+lhWD2faQultc=;
 b=Ho1xJ5WwKCWVmVLV04ERwAJi8udR5bdaf+n33ZUf0Rbutt02a9VSIjjQ+TloA3mStBtDLn
 4CLS7HTHlbDadpBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CH/wYFs0";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VlOuoQ38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYjtSa9ryjc70qcKjVP9Mt4OPlrdie+lhWD2faQultc=;
 b=CH/wYFs0v4ntDOJpn8Afvtix1qKMiV3bNzyQMzggaoN1xNkc/XLNolyOuTLgGz1FQbzy0S
 6b/rk0ephWOPjRvtUbApF0jTWo3Ei/n/ZqN+rU8hRwdFOWD31QbNT3RESdzz6+AfGPCFor
 LyKAZopdcbIA8JZDf6MeCQnhxYThAKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYjtSa9ryjc70qcKjVP9Mt4OPlrdie+lhWD2faQultc=;
 b=VlOuoQ38GJnwRJLznSR6mrp1pgJB0AZ6HZP2Yd35tL6lbhtWJnywdo8cGmIuqdtNE+R+qV
 wG2BkbBm//n4b/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B18136E6;
 Thu,  3 Sep 2026 17:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4LOREX+ymWpNWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 17:46:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
In-Reply-To: <apmwZbSLZ46yvGmT@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de> <apmwZbSLZ46yvGmT@x1.local>
Date: Thu, 03 Sep 2026 14:46:37 -0300
Message-ID: <87bjae8bya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1C36E1F7B4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
>> Using newlines in the g_test_message is fine. It automatically adds
>> the '#' required by the TAP protocol to the start of each line.
>
> IIUC we have such check not because TAP, but because all these functions
> will append one newline at the end, hence it's not needed.  IOW, if it
> applies to g_test_message(), I don't see why it doesn't apply to the rest.
> But maybe there're other reasons?
>
> To make it simpler, maybe we just call a few times g_test_message()?
>

Not sure I understand your point, Peter. I want to be able to print nice
messages in patch 9:

 g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);

 # HMP output mismatch for entry at line 55:
 # expected vs. found:
 #
 # max-bandwidth: 10356305952768 bytes/hour
 # ---
 # max-bandwidth: 10356305952768 bytes/second

What would be the issue of having newlines here?

>> 
>> Relax the regex for this function, but still forbid a trailing newline
>> because it's added automatically and usually not what the user wants.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  scripts/checkpatch.pl | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 03f35e75012..fd4534b3a1e 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -3303,13 +3303,20 @@ sub process {
>>  					 info_vreport|
>>  					 error_report|
>>  					 warn_report|
>> -					 info_report|
>> -					 g_test_message}x;
>> +					 info_report}x;
>>  
>>  		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>>  			ERROR("Error messages should not contain newlines\n" . $herecurr);
>>  		}
>>  
>> +		# No newlines at the end
>> +		my $trail_newline_error_funcs = qr{g_test_message}x;
>> +
>> +		if ($rawline =~ /\b(?:$trail_newline_error_funcs)\(.*\".*\\n\"/) {
>> +		    ERROR("Error messages should not contain trailing " .
>> +			  "newlines\n" . $herecurr);
>> +		}
>> +
>>  		# Continue checking for error messages that contains newlines.
>>  		# This check handles cases where string literals are spread
>>  		# over multiple lines.
>> -- 
>> 2.53.0
>> 

