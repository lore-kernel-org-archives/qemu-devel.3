Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A40C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmemL-0000xU-QY; Tue, 19 Mar 2024 15:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmemJ-0000wi-Fi
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:05:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmemE-0002M7-Ao
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:05:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A496B226A6;
 Tue, 19 Mar 2024 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710875131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgP/GaMj98M3mxWVu/Xg1xaJQnzuD6hzl+BKtkAb/Ms=;
 b=WQEFoAI3tOPKvCAvtXnOq+xBM4jzvALmU/LLCog5U+Q3JKktfDur+UK5On8KDPOiV9/n5j
 gU249tLtEvxaO49Op32jxuU088LKeVdE6y0nJBt2+VKTKogOWu+QAGfcEk83FJ6gVYNRqB
 IAfOEVsmipw9izFmXE+BuN/ACGy4uRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710875131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgP/GaMj98M3mxWVu/Xg1xaJQnzuD6hzl+BKtkAb/Ms=;
 b=iJ5wwDnngZZWD2zu4YplcM7ZUbDM/1a8lt6kCfWXFF817a6/tr78dShEv6kKdQ1qVN19Zs
 N8TUVw/RiZq7kjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710875129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgP/GaMj98M3mxWVu/Xg1xaJQnzuD6hzl+BKtkAb/Ms=;
 b=2T4AsKJqdxwMOvbe9U8yLwbY+JpYWm596mFEYHwusessgHJ9KBGJjlUzL95Ie2xuLgzq3z
 fIU7/vOA+M51eV3bjI9PJpCbA3m+09z9ScGMAwA6RMg5fI1FcvhUomyfT11ftCLpAbhVAA
 +TQuYlrsi4hxX4qUGtYYy92EClO2BZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710875129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgP/GaMj98M3mxWVu/Xg1xaJQnzuD6hzl+BKtkAb/Ms=;
 b=9At1pxHTQQAa0dWmaAUrYuS1M8g1pQzj0M1nCY4kvZhzmie45ID4MW5B52sqO7xlk6Fisu
 VcPyZTgsev35OVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B1EB1376B;
 Tue, 19 Mar 2024 19:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FDQGOPjh+WXjWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Mar 2024 19:05:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
In-Reply-To: <32c4cf1d-91d0-48ed-84a9-e21ad7bcc254@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com> <871q8b8xeg.fsf@suse.de>
 <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com>
 <87bk7baamp.fsf@suse.de>
 <32c4cf1d-91d0-48ed-84a9-e21ad7bcc254@nutanix.com>
Date: Tue, 19 Mar 2024 16:03:16 -0300
Message-ID: <871q869h8r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2T4AsKJq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9At1pxHT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.de:dkim,suse.de:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A496B226A6
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On 18/03/24 7:46 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 15/03/24 6:28 pm, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>
>>>>> Refactor migrate_get_socket_address to internally utilize 'socket-add=
ress'
>>>>> parameter, reducing redundancy in the function definition.
>>>>>
>>>>> migrate_get_socket_address implicitly converts SocketAddress into str.
>>>>> Move migrate_get_socket_address inside migrate_get_connect_uri which
>>>>> should return the uri string instead.
>>>>>
>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>>>>> ---
>>>>>    tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
>>>>>    1 file changed, 19 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-=
helpers.c
>>>>> index 3e8c19c4de..8806dc841e 100644
>>>>> --- a/tests/qtest/migration-helpers.c
>>>>> +++ b/tests/qtest/migration-helpers.c
>>>>> @@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *=
addr)
>>>>>        }
>>>>>    }
>>>>>=20=20=20=20
>>>>> -static char *
>>>>> -migrate_get_socket_address(QTestState *who, const char *parameter)
>>>>> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>>>    {
>>>>>        QDict *rsp;
>>>>> -    char *result;
>>>>>        SocketAddressList *addrs;
>>>>> +    SocketAddress *addr;
>>>>>        Visitor *iv =3D NULL;
>>>>>        QObject *object;
>>>>>=20=20=20=20
>>>>>        rsp =3D migrate_query(who);
>>>>> -    object =3D qdict_get(rsp, parameter);
>>>>> +    object =3D qdict_get(rsp, "socket-address");
>>>> Just a heads up, none of what I'm about to say applies to current
>>>> master.
>>>>
>>>> This can return NULL if there is no socket-address, such as with a file
>>>> migration. Then the visitor code below just barfs. It would be nice if
>>>> we touched this up eventually.
>>> Yes. I agree this is not full proof solution and covers for all the cas=
es.
>>> It would only for 'socket-address'. Could you elaborate on what other t=
han
>>> socket-address the QObject can have ?
>> I can just not have the socket-address, AFAICS. We'd just need to not
>> crash if that's the case.
>
> value: {
>  =C2=A0=C2=A0=C2=A0 "status": "setup",
>  =C2=A0=C2=A0=C2=A0 "socket-address": [
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "port=
": "46213",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ipv4=
": true,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "host=
": "127.0.0.1",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "type=
": "inet"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 ]
> }
>
> Okay, I understood your ask here. This is what gets printed from the QDic=
t.
> Let me raise a patch to return with a message if the QDict does not have =
key
> with 'socket-address'. This would prevent the crash later on.
>
> I wanted to know what other than "socket-address" key can he QDict give us
> because, if that's the case, for other than socket migration, then we can
> make this function more generic rather than having it as=20
> 'migrate_get_socket_address'

For now, there's nothing else. Let's just ignore when socket-address is
missing in the reply so we don't break future tests that use a
non-socket type.

>>>> I only noticed this because I was fiddling with the file migration API
>>>> and this series helped me a lot to test my changes. So thanks for that,
>>>> Het.
>>>>
>>>> Another point is: we really need to encourage people to write tests
>>>> using the new channels API. I added the FileMigrationArgs with the
>>>> 'offset' as a required parameter, not even knowing optional parameters
>>>> were a thing. So it's obviously not enough to write support for the new
>>>> API if no tests ever touch it.
>>> Yes, definitely we need more tests with the new channels API to test ot=
her
>>> than just tcp connection. I could give a try for vsock and unix with the
>>> new QAPI syntax, and add some tests.
>>>
>>> I also wanted to bring in attention that, this solution I what i feel is
>>> also
>>> not complete. If we are using new channel syntax for migrate_qmp, then =
the
>>> same syntax should also be used for migrate_qmp_incoming. But we haven't
>>> touch that, and it still prints the old syntax. We might need a lot cha=
nges
>>> in design maybe to incorporate that too in new tests totally with the n=
ew
>>> syntax.
>> Adding migrate_qmp_incoming support should be relatively simple. You had
>> patches for that in another version, no?
> No Fabiano, what I meant was, in migration-test.c, change in=20
> migrate_incoming_qmp
> would need to change the callback function and ultimately change all the=
=20
> callback
> handlers ? In that sense, it would require a big change ?
> Inside the migrate_incoming_qmp function, adding implementation for=20
> channels is
> same as other migrate_* function.

You could add the parameter to migrate_incoming_qmp and use NULL when
calling. The callbacks don't need to be changed. When we add more tests
then we'd alter the callbacks accordingly.

I might convert the file tests soon, you can leave that part to me if
you want.

>>> Another thing that you also noted down while discussing on the patches =
that
>>> we should have a standard pattern on how to define the migration tests.=
 Even
>>> that would be helpful for the users, on how to add new tests, where to =
add
>>> new tests in the file, and which test is needed to run if a specific ch=
ange
>>> needs to be tested.
>>>
>>>>>=20=20=20=20
>>>>>        iv =3D qobject_input_visitor_new(object);
>>>>>        visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>>>>> +    addr =3D addrs->value;
>>>>>        visit_free(iv);
>>>>>=20=20=20=20
>>>>> -    /* we are only using a single address */
>>>>> -    result =3D SocketAddress_to_str(addrs->value);
>>>>> -
>>>>> -    qapi_free_SocketAddressList(addrs);
>>>>>        qobject_unref(rsp);
>>>>> -    return result;
>>>>> +    return addr;
>>>>> +}
>>>>> +
>>>>> +static char *
>>>>> +migrate_get_connect_uri(QTestState *who)
>>>>> +{
>>>>> +    SocketAddress *addrs;
>>>>> +    char *connect_uri;
>>>>> +
>>>>> +    addrs =3D migrate_get_socket_address(who);
>>>>> +    connect_uri =3D SocketAddress_to_str(addrs);
>>>>> +
>>>>> +    qapi_free_SocketAddress(addrs);
>>>>> +    return connect_uri;
>>>>>    }
>>>>>=20=20=20=20
>>>>>    bool migrate_watch_for_events(QTestState *who, const char *name,
>>>>> @@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to,=
 const char *uri,
>>>>>=20=20=20=20
>>>>>        g_assert(!qdict_haskey(args, "uri"));
>>>>>        if (!uri) {
>>>>> -        connect_uri =3D migrate_get_socket_address(to, "socket-addre=
ss");
>>>>> +        connect_uri =3D migrate_get_connect_uri(to);
>>>>>        }
>>>>>        qdict_put_str(args, "uri", uri ? uri : connect_uri);
>>> Regards,
>>> Het Gala
> Regards,
> Het Gala

