Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4AC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 06:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd30C-0007jO-Hl; Thu, 22 Feb 2024 01:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd30A-0007j3-0L
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd308-0002kr-8h
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708584971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5acXxS4pr09a/C3XLkEDgOE8gkOKWd66vuCAeBqVJ8=;
 b=Nb4oTuEx86S7yhFVYHlkZNDIqYSLRgN+Ca/tW18GnHhi1YKankvWfADM/UgqvIxkVfYAbF
 3jczicIuRah2/moMQJ8kKW87DVUjViW81EWWZFfeQHjh7FX2MeP41CeTJYzafrTtf+38HL
 qZQEew05/XnMD5rr+rPhqXfmkg3WxM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-jgOQ_dF-Pf-EabgfV6oM1w-1; Thu, 22 Feb 2024 01:56:07 -0500
X-MC-Unique: jgOQ_dF-Pf-EabgfV6oM1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2464F811E79;
 Thu, 22 Feb 2024 06:56:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2DC740C94A7;
 Thu, 22 Feb 2024 06:56:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98AC221E66D5; Thu, 22 Feb 2024 07:56:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 32/34] monitor: fdset: Match against O_DIRECT
In-Reply-To: <87plwqaqfy.fsf@suse.de> (Fabiano Rosas's message of "Wed, 21 Feb
 2024 10:37:37 -0300")
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-33-farosas@suse.de>
 <878r3exj3f.fsf@pond.sub.org> <87plwqaqfy.fsf@suse.de>
Date: Thu, 22 Feb 2024 07:56:05 +0100
Message-ID: <87a5ntyol6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> We're about to enable the use of O_DIRECT in the migration code and
>>> due to the alignment restrictions imposed by filesystems we need to
>>> make sure the flag is only used when doing aligned IO.
>>>
>>> The migration will do parallel IO to different regions of a file, so
>>> we need to use more than one file descriptor. Those cannot be obtained
>>> by duplicating (dup()) since duplicated file descriptors share the
>>> file status flags, including O_DIRECT. If one migration channel does
>>> unaligned IO while another sets O_DIRECT to do aligned IO, the
>>> filesystem would fail the unaligned operation.
>>>
>>> The add-fd QMP command along with the fdset code are specifically
>>> designed to allow the user to pass a set of file descriptors with
>>> different access flags into QEMU to be later fetched by code that
>>> needs to alternate between those flags when doing IO.
>>>
>>> Extend the fdset matching function to behave the same with the
>>> O_DIRECT flag.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  monitor/fds.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/monitor/fds.c b/monitor/fds.c
>>> index 9a28e4b72b..42bf3eb982 100644
>>> --- a/monitor/fds.c
>>> +++ b/monitor/fds.c
>>> @@ -413,6 +413,12 @@ static bool monitor_fdset_flags_match(int flags, int fd_flags)
>>    static bool monitor_fdset_flags_match(int flags, int fd_flags)
>>    {
>>        bool match = false;
>>    
>>>      if ((flags & O_ACCMODE) == (fd_flags & O_ACCMODE)) {
>>>          match = true;
>>> +
>>> +#ifdef O_DIRECT
>>> +        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
>>> +            match = false;
>>> +        }
>>> +#endif
>>>      }
>>>  
>>>      return match;
>>    }
>>
>> I'd prefer something like
>>
>>    static bool monitor_fdset_flags_match(int flags, int fd_flags)
>>    {
>>    #ifdef O_DIRECT
>>        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
>>            return false;
>>        }
>>    #endif
>>
>>        if ((flags & O_ACCMODE) != (fd_flags & O_ACCMODE)) {
>>            return false;
>>
>>        }
>>
>>        return true;
>>    }
>
> This makes the O_DIRECT flag dictate the outcome when it's present. I
> want O_DIRECT to be considered only when all other flags have matched.
>
> Otherwise we regress the original use-case if the user happened to have
> put O_DIRECT in the flags. A non-match due to different O_ACCMODE would
> become a match due to (possibly) matching O_DIRECT.

The fact that I missed this signifies one of two things: either was
suffering from code review brain (quite possible!), or this needs a
comment and/or clearer coding.

If I understand you correctly, you want to return true when the bits
selected by the two masks together match.

If we didn't need ifdeffery, we wouldn't use nested conditionals for
comparing bits under a mask.  We'd use something like

        int mask = O_ACCMODE | O_DIRECT;

        return (flags & mask) == (fd_flags & mask);

Bring back the ifdeffery:

        int mask = O_ACCMODE;

    #ifdef O_DIRECT
        mask |= O_DIRECT;
    #endif

        return (flags & mask) == (fd_flags & mask);

Or maybe even

    #ifndef O_DIRECT
    #define O_DIRECT 0
    #endif

        int mask = O_ACCMODE | O_DIRECT;

        return (flags & mask) == (fd_flags & mask);

Not sure this is even worth a helper function.

Or am I stull suffering from code review brain?


