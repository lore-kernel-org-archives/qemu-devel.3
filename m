Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C618C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVX2O-0006Px-Df; Thu, 01 Feb 2024 08:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVX2L-0006Pa-UT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:23:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVX2H-0005HO-Rn
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:23:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEB7D22147;
 Thu,  1 Feb 2024 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706793799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9SSVDW8uYIbqv1wY3ghNR+a4Of8ubLQedhlEsTqzw4=;
 b=sBVwBPAqwAc/IgourOyZIkoBn2ZhAtOIvT1JzMvCNFYDQS7VvI2OzgR6JMsFwh1qU1vqXN
 OcN6lVcakSGDfqtWWpTA5IedrEgAcz7IP8HMrxtsSi5NkuUMGorhqKHtTAHMEBG0290DB3
 GrdhJwN6ZC0Tyg+9qqnaP3GzwCMf6sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706793799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9SSVDW8uYIbqv1wY3ghNR+a4Of8ubLQedhlEsTqzw4=;
 b=4S5B6I8cjVgFiNOUe/R4x1zUkgJfLJsPFqABGCU/O9VCOK/URIhsiSKfjWaJmQF2hiK9he
 29WCARA0GBHCXJBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706793799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9SSVDW8uYIbqv1wY3ghNR+a4Of8ubLQedhlEsTqzw4=;
 b=sBVwBPAqwAc/IgourOyZIkoBn2ZhAtOIvT1JzMvCNFYDQS7VvI2OzgR6JMsFwh1qU1vqXN
 OcN6lVcakSGDfqtWWpTA5IedrEgAcz7IP8HMrxtsSi5NkuUMGorhqKHtTAHMEBG0290DB3
 GrdhJwN6ZC0Tyg+9qqnaP3GzwCMf6sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706793799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9SSVDW8uYIbqv1wY3ghNR+a4Of8ubLQedhlEsTqzw4=;
 b=4S5B6I8cjVgFiNOUe/R4x1zUkgJfLJsPFqABGCU/O9VCOK/URIhsiSKfjWaJmQF2hiK9he
 29WCARA0GBHCXJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36C6D139AB;
 Thu,  1 Feb 2024 13:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fUE5AEebu2UlRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Feb 2024 13:23:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bryan Zhang
 <bryan.zhang@bytedance.com>
Subject: Re: [External] Re: [PATCH 0/5] migration/multifd: Prerequisite
 cleanups for ongoing work
In-Reply-To: <CAAYibXiUg5pkBhQA=QFZ7jgBXRFN81L3bQETFdEnSquyY95hHA@mail.gmail.com>
References: <20240126221943.26628-1-farosas@suse.de>
 <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZbdVhLTLo5udNfeL@x1n> <87jznse211.fsf@suse.de> <ZboS9CPIuxIc9PTf@x1n>
 <8734udljwz.fsf@suse.de>
 <CAAYibXiUg5pkBhQA=QFZ7jgBXRFN81L3bQETFdEnSquyY95hHA@mail.gmail.com>
Date: Thu, 01 Feb 2024 10:23:16 -0300
Message-ID: <87v878iaij.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sBVwBPAq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4S5B6I8c
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: AEB7D22147
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Wed, Jan 31, 2024 at 5:19=E2=80=AFAM Fabiano Rosas <farosas@suse.de> w=
rote:
>>
>> Peter Xu <peterx@redhat.com> writes:
>>
>> > On Mon, Jan 29, 2024 at 09:51:06AM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >>
>> >> > On Mon, Jan 29, 2024 at 01:41:01AM +0000, Liu, Yuan1 wrote:
>> >> >> Because this change has an impact on the previous live migration
>> >> >> With IAA Patch, does the submission of the next version needs
>> >> >> to be submitted based on this change?
>> >> >
>> >> > I'd say hold off a little while until we're more certain on the pla=
nned
>> >> > interface changes, to avoid you rebase your code back and forth; un=
less
>> >> > you're pretty confident that this will be the right approach.
>> >> >
>> >> > I apologize on not having looked at any of the QAT/IAA compression =
/ zero
>> >> > detection series posted on the list; I do plan to read them very so=
on too
>> >> > after Fabiano.  So I may not have a complete full picture here yet,=
 please
>> >> > bare with me.
>> >> >
>> >> > If this series is trying to provide a base ground for all the effor=
ts,
>> >> > it'll be great if we can thoroughly discuss here and settle an appr=
oach
>> >> > soon that will satisfy everyone.
>> >>
>> >> Just a summary if it helps:
>> >>
>> >> For compression work (IAA/QPL, QAT) the discussion is around having a
>> >> new "compression acceleration" option that enables the accelerators a=
nd
>> >> is complementary to the existing zlib compression method. We'd choose
>> >> those automatically based on availability and we'd make HW accelerated
>> >> compression produce a stream that is compatible with QEMU's zlib stre=
am
>> >> so we could migrate between solutions.
>> >>
>> >> For zero page work and zero page acceleration (DSA), the question is =
how
>> >> to fit zero page detection into multifd and whether we need a new hook
>> >> multifd_ops->zero_page_detect() (or similar) to allow client code to
>> >> provide it's own zero page detection methods. My worry here is that
>> >> teaching multifd to recognize zero pages is one more coupling to the
>> >> "pages" data type. Ideallly we'd find a way to include that operation=
 as
>> >> a prepare() responsibility and the client code would deal with it.
>> >
>> > Thanks Fabiano.
>
> Hi Fabiano,
>
> Your current refactoring assumes that compression ops and multifd
> socket ops are mutually exclusive. Both of them need to implement the
> entire MultiFDMethods interface. I think this works fine for now. Once
> we introduce multifd zero page checking and we add a new interface for
> that, we are adding a new method zero_page_detect() on the
> MultiFDMethods interface. If we do that, zero_page_detect() needs to
> be implemented in multifd_socket_ops and it also needs to be
> implemented in zlib and zstd. On top of that, if we add an accelerator
> to offload zero_page_detect(), that accelerator configuration can
> co-exist with compression or socket. That makes things quite
> complicated in my opinion.

Peter has proposed an alternate scheme. Take a look at his series. But
it basically keeps the compression as is and moves some code into the
prepare() phase:

https://lore.kernel.org/r/20240131103111.306523-1-peterx@redhat.com

> Can we create an instance of MultiFDMethods at runtime and fill each
> method depending on the configuration? If methods are not filled, we
> fallback to fill it with the default implementation (like what
> socket.c provides) For instance, if zstd is enabled and zero page
> checking using CPU, the interface will be filled with all the
> functions zstd currently implements and since zstd doesn't implement
> zero_page_detect(), we will fallback to fill zero_page_detect() with
> the default multifd zero page checking implementation.

Take a look whether incorporating zero_page_detect() in the prepare()
phase would work. We're trying to walk toward a multifd_ops model that
is not tied to the pages concept.

>> >
>> > Since I'm preparing the old series to post for some fundamental cleanu=
ps
>> > around multifd, and when I'm looking around the code, I noticed that
>> > _maybe_ it'll also be eaiser to apply such a series if we can cleanup =
more
>> > things then move towards a clean base to add more accelerators.
>> >
>> > I agree many ideas in your this series, but I may address it slightly
>> > different (e.g., I want to avoid send(), but you can consider that in =
the
>> > fixed-ram series instead), also it'll be after some other cleanup I pl=
an to
>> > give a stab at which is not yet covered in this series.  I hope I can =
add
>> > your "Co-developed-by" in some of the patches there.  If you haven't s=
pend
>> > more time on new version of this series, please wait 1-2 days so I can=
 post
>> > my thoughts.
>>
>> Sure, go ahead.
>>

