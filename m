Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EACD11DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbvW-0005wc-AG; Tue, 19 Mar 2024 12:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmbvU-0005u6-GJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmbvS-0000ai-Ph
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710864173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8VFDBunFP1TsbC9ZqFD7YmyyvENN6UTAtuBUk9DlcA=;
 b=iNY0Up7q7RkJMPlcUvSEaYN+4TfjsM60ul4Kp2X6/9g6YPlzBKqfr+jbn3vcIsYURTaczN
 +ZBYxBsM4utBb1xhQf8UpVjqJ8yv3t+O9ZCC2zcO1b9eiFwClM8cXlmO3vKwTGrgf/1gsz
 HM23z9q1dI76L9FUh2gR7vucHt9WN3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-2hJK3zmfM-me62hMaUX84Q-1; Tue, 19 Mar 2024 12:02:50 -0400
X-MC-Unique: 2hJK3zmfM-me62hMaUX84Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AFB3800262;
 Tue, 19 Mar 2024 16:02:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F3D640C6DB7;
 Tue, 19 Mar 2024 16:02:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35E6121E6A28; Tue, 19 Mar 2024 17:02:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v5 24/25] qapi: Tighten check whether implicit object
 type already exists
In-Reply-To: <CAFn=p-YuKWRvGcxDApVt3kXg22c1YJDogWJG9g4AXud_tgbZag@mail.gmail.com>
 (John Snow's message of "Tue, 19 Mar 2024 11:30:50 -0400")
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-25-armbru@redhat.com>
 <CAFn=p-YuKWRvGcxDApVt3kXg22c1YJDogWJG9g4AXud_tgbZag@mail.gmail.com>
Date: Tue, 19 Mar 2024 17:02:32 +0100
Message-ID: <87r0g6yztz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> Entities with names starting with q_obj_ are implicit object types.
>> Therefore, QAPISchema._make_implicit_object_type()'s .lookup_entity()
>> can only return a QAPISchemaObjectType.  Assert that.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/schema.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> index e52930a48a..a6180f93c6 100644
>> --- a/scripts/qapi/schema.py
>> +++ b/scripts/qapi/schema.py
>> @@ -1297,8 +1297,9 @@ def _make_implicit_object_type(
>>              return None
>>          # See also QAPISchemaObjectTypeMember.describe()
>>          name =3D 'q_obj_%s-%s' % (name, role)
>> -        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
>> +        typ =3D self.lookup_entity(name)
>>          if typ:
>> +            assert(isinstance(typ, QAPISchemaObjectType))
>>              # The implicit object type has multiple users.  This can
>>              # only be a duplicate definition, which will be flagged
>>              # later.
>> --
>> 2.44.0
>>
>
> Seems obviously fine, though I don't suppose this narrowing will be
> "remembered" by the type system. Do we care?

mypy passes without it.  It's for catching programming errors and
helping the reader along.  The former are unlikely, and the latter is
debatable, but when in doubt, assert.

> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!


