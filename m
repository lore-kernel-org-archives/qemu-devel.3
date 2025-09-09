Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D01FCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 11:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvwiv-0003zJ-0g; Tue, 09 Sep 2025 07:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwir-0003yw-KC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwil-00005z-0j
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757418064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WY+HCBuz6buVinHHgFAsnFYZ69hUbixIneepC4ktvY=;
 b=eYF4+GE1S9qzdSxz/u5splRh3ps4OO7DgfuMUCyHPUXKXfOrxxd/pcE9UJV2DCGvKjv4nY
 Z6+LvbBgzebR92k+TYe4SuuIARQm53GUjC+dcD6OwsGs/LIdwwdLcn77iIeAppT5J7jcH9
 zkpVKg+qpDS+hRsMCvWkL50VEMn7oAM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-1GXEuMLaNSu9vBIEjsAyAA-1; Tue,
 09 Sep 2025 07:41:03 -0400
X-MC-Unique: 1GXEuMLaNSu9vBIEjsAyAA-1
X-Mimecast-MFC-AGG-ID: 1GXEuMLaNSu9vBIEjsAyAA_1757418062
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C251955D6E; Tue,  9 Sep 2025 11:41:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B15300070A; Tue,  9 Sep 2025 11:41:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 518B721E6A27; Tue, 09 Sep 2025 13:40:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 06/12] net/slirp: Clean up error reporting
In-Reply-To: <aKRblxuJ-9_4jw0X@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 12:10:15 +0100")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-7-armbru@redhat.com>
 <aKRblxuJ-9_4jw0X@redhat.com>
Date: Tue, 09 Sep 2025 13:40:59 +0200
Message-ID: <87348vzwdw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 08, 2025 at 10:08:17AM +0200, Markus Armbruster wrote:
>> net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
>> report WSAEventSelect() failure with error_setg(&error_warn, ...).
>>=20
>> I'm not familiar with liblirp, so I can't say whether the network
>
>                        ^^^^^^^^^ 'libslirp'

Will fix, thanks!

>> backend will work after such a failure.  If it doesn't, then this
>> should be an error.  If it does, then why bother the user with a
>> warning that isn't actionable, and likely confusing?
>>=20
>> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
>> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
>> ...)  are.  Replace by warn_report().
>>=20
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  net/slirp.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>> diff --git a/net/slirp.c b/net/slirp.c
>> index 9657e86a84..d75b09f16b 100644
>> --- a/net/slirp.c
>> +++ b/net/slirp.c
>> @@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_so=
cket fd, void *opaque)
>>      if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
>>                         FD_READ | FD_ACCEPT | FD_CLOSE |
>>                         FD_CONNECT | FD_WRITE | FD_OOB) !=3D 0) {
>> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSA=
EventSelect()");
>> +        warn_report("failed to WSAEventSelect(): %s",
>> +                    g_win32_error_message(WSAGetLastError()));
>>      }
>>  #endif
>
> IMHO this one ought to be considered fatal. If we can't select the
> right events on the socket, then we're not going to have a good time
> trying to poll on events. The libslirp callback API doesn't allow
> us to return a success/failure code from this function, and IMHO it
> is not appropriate to use error_fatal here because a fault with slirp
> should not take down the whole of QEMU. So warn_report is the least
> worst option I guess. At least it is a hint to the user that all is
> not well - even if they can't action it, it might alert them if they
> see network problems in their guest.

So, we'd make this an error if we could.  But we can't: the function is
a callback that cannot fail, and outright exit(1) is too harsh.

That leaves silence or warning.  Warning is less bad.

Correct?

>
>>  }
>> @@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_=
socket fd, void *opaque)
>>  {
>>  #ifdef WIN32
>>      if (WSAEventSelect(fd, NULL, 0) !=3D 0) {
>> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSA=
EventSelect()");
>> +        warn_report("failed to WSAEventSelect()",
>> +                    g_win32_error_message(WSAGetLastError()));
>>      }
>
> This one is reasonable to treat as non-fatal, since once we've
> unregistered the socket for polling

Whether clearing the event associated with the socket can fail is
unclear.  Whether it should be treated as an error is also unclear.

If yes, then same argument as for net_slirp_register_poll_sock() above.

If no, silence or warning.  Warning is less bad.

Correct?

>>  #endif
>>  }

[...]


