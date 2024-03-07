Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22529C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCs1-0006qo-PJ; Thu, 07 Mar 2024 07:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riCrz-0006qI-RT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:29:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riCrx-0004xg-6Z
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:29:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 948DC8C9CD;
 Thu,  7 Mar 2024 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709811440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzj702vKUPTjfwWSsEapmboyGPr78hotEG7FkT0cGmA=;
 b=soxid7GVwyFP9V9PeR4FB/Yl28cEFkxCR3xrQ6GbuddMxGErahwGvkCasO06vqgIvX60nz
 MbhNXx+qbVw9k04y2vSpupRngq5cVD+1fJuyhHIl9W1b20kXAZyG+pb/XYrMvkELSLgAl0
 /3CMPmIakIYS0DbPjdafoOQgVi1EGwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709811440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzj702vKUPTjfwWSsEapmboyGPr78hotEG7FkT0cGmA=;
 b=tkEDDFkr6Ju4Oyk1S7GCVLIvY33Tyqc8XENqrxxSJ/Rj1AkgjL+6E8tfHrAwDU7pWM1Ivl
 40U7lfAoBri73LAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709811440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzj702vKUPTjfwWSsEapmboyGPr78hotEG7FkT0cGmA=;
 b=soxid7GVwyFP9V9PeR4FB/Yl28cEFkxCR3xrQ6GbuddMxGErahwGvkCasO06vqgIvX60nz
 MbhNXx+qbVw9k04y2vSpupRngq5cVD+1fJuyhHIl9W1b20kXAZyG+pb/XYrMvkELSLgAl0
 /3CMPmIakIYS0DbPjdafoOQgVi1EGwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709811440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzj702vKUPTjfwWSsEapmboyGPr78hotEG7FkT0cGmA=;
 b=tkEDDFkr6Ju4Oyk1S7GCVLIvY33Tyqc8XENqrxxSJ/Rj1AkgjL+6E8tfHrAwDU7pWM1Ivl
 40U7lfAoBri73LAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2102A12FC5;
 Thu,  7 Mar 2024 11:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ez80Nu+m6WVDOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Mar 2024 11:37:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
In-Reply-To: <28018429-e5ab-4dec-b742-99d7daa416b2@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com> <87sf13s9yz.fsf@suse.de>
 <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com>
 <878r2vs61j.fsf@suse.de>
 <28018429-e5ab-4dec-b742-99d7daa416b2@nutanix.com>
Date: Thu, 07 Mar 2024 08:37:17 -0300
Message-ID: <87ttliqnma.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Het Gala <het.gala@nutanix.com> writes:

> On 06/03/24 9:31 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 06/03/24 8:06 pm, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>
>>>>> Add a migrate_set_ports() function that from each QDict, fills in
>>>>> the port in case it was 0 in the test.
>>>>> Handle a list of channels so we can add a negative test that
>>>>> passes more than one channel.
>>>>>
>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>>> ---
>>>>>    tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>>>>>    1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>>>> index 478c1f259b..df4978bf17 100644
>>>>> --- a/tests/qtest/migration-helpers.c
>>>>> +++ b/tests/qtest/migration-helpers.c
>>>>> @@ -17,6 +17,8 @@
>>>>>    #include "qapi/qapi-visit-sockets.h"
>>>>>    #include "qapi/qobject-input-visitor.h"
>>>>>    #include "qapi/error.h"
>>>>> +#include "qapi/qmp/qlist.h"
>>>>> +
>>>> Extra line here. This is unwanted because it sometimes trips git into
>>>> thinking there's a conflict here when another patch changes the
>>>> surrounding lines.
>>> Ack, that makes sense
>>>>>    
>>>>>    #include "migration-helpers.h"
>>>>>    
>>>>> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>>>>>        return result;
>>>>>    }
>>>>>    
>>>>> +static void migrate_set_ports(QTestState *to, QList *channelList)
>>>>> +{
>>>>> +    g_autofree char *addr = NULL;
>>>>> +    g_autofree char *addr_port = NULL;
>>>>> +    QListEntry *entry;
>>>>> +
>>>>> +    addr = migrate_get_socket_address(to, "socket-address");
>>>>> +    addr_port = g_strsplit(addr, ":", 3)[2];
>>>> Will this always do the right thing when the src/dst use different types
>>>> of channels? If there is some kind of mismatch (say one side uses vsock
>>>> and the other inet), it's better that this function doesn't touch the
>>>> channels dict instead of putting garbage in the port field.
>>> Yes you are right. This will fail if there is a mismatch in type of
>>> channels.
>>>
>>> Better idea would be to check if 'port' key is present in both, i.e. in
>>> 'addr'
>>> as well as 'addrdict' and only then change the port ?
>>>
>> Yep, either parse the type from string or add a version of
>> migrate_get_socket_address that returns a dict. Then check if type
>> matches and port exists.
>
> one silly question here, why are we not having tests for exec and rdma 
> specifically ?

exec because we intend to deprecate it, so no one is paying too much
attention to it.

rdma because no one wants to write them.

>
> Another suggestion required: Parsing uri to qdict is easy to implement 
> but (little)
> messy codewise, and the other hand migrate_get_qdict looks clean, but 
> under the hood we would convert it to socketaddress and then call 
> SocketAddress_to_qdict. Which one we can prefer more here ?

The latter. It's easier to work with.

static QDict *SocketAddress_to_qdict(SocketAddress *addr)
{
    QDict *dict = qdict_new();

    switch (addr->type) {
    case SOCKET_ADDRESS_TYPE_INET:
        qdict_put_str(dict, "type", "inet");
        qdict_put_str(dict, "host", addr->u.inet.host);
        qdict_put_str(dict, "port", addr->u.inet.port);

        break;
    case SOCKET_ADDRESS_TYPE_UNIX:
        qdict_put_str(dict, "type", "unix");
        qdict_put_str(dict, "path", addr->u.q_unix.path);

        break;
    case SOCKET_ADDRESS_TYPE_FD:
        qdict_put_str(dict, "type", "fd");
        qdict_put_str(dict, "str", addr->u.fd.str);

        break;
    case SOCKET_ADDRESS_TYPE_VSOCK:
        qdict_put_str(dict, "type", "vsock");
        qdict_put_str(dict, "cid", addr->u.vsock.cid);
        qdict_put_str(dict, "port", addr->u.vsock.port);

        break;
    default:
        g_assert_not_reached();
        break;
    }

    return dict;
}

>
> Regards,
>
> Het Gala

