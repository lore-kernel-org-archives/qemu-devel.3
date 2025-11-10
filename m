Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26703CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQGR-0008Rg-Uf; Mon, 10 Nov 2025 06:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIPxU-0002pI-Ho
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIPxL-0005iF-0h
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762773665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jN7idRk9bzpk8HsZk4Hk7HC1S/hjpZ1sNC9lvwCe404=;
 b=f5t4jlY7jNlRi/tjYd7nfW7pZRORV047HH6X4Yz8nX49Z+I9eN+K2YZ5VtjnEmw3UcaQDw
 nOGEHmATw1dduTNW3tuQrByuR82tu7S6+qWPtOUcA1gjQjn/1umDXT39DI3bcG1tEulur+
 1xUzSi0vLjNW78UdW2BuBLIFnkRjMws=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-6cXjnJ99MCS-44E692JqKg-1; Mon,
 10 Nov 2025 06:21:00 -0500
X-MC-Unique: 6cXjnJ99MCS-44E692JqKg-1
X-Mimecast-MFC-AGG-ID: 6cXjnJ99MCS-44E692JqKg_1762773659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 761E11800343; Mon, 10 Nov 2025 11:20:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B567D19560A7; Mon, 10 Nov 2025 11:20:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 072C621E6A27; Mon, 10 Nov 2025 12:20:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru
Subject: Re: [PATCH] qapi/parser: Mollify mypy
In-Reply-To: <5d05e71e-0ba0-4bde-81bf-1911ba5562ff@linaro.org> (Richard
 Henderson's message of "Mon, 10 Nov 2025 11:58:00 +0100")
References: <20251105152219.311154-1-armbru@redhat.com>
 <5d05e71e-0ba0-4bde-81bf-1911ba5562ff@linaro.org>
Date: Mon, 10 Nov 2025 12:20:55 +0100
Message-ID: <878qgem8vc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/5/25 16:22, Markus Armbruster wrote:
>> re.match(r'^ *', ...) can't fail, but mypy doesn't know that and
>> complains:
>>      scripts/qapi/parser.py:444: error: Item "None" of "Match[str] | None" has no attribute "end"  [union-attr]
>> Work around by using must_match() instead.
>> Fixes: 8107ba47fd78 (qapi: Add documentation format validation)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   scripts/qapi/parser.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 1bb1af7051..c3cf33904e 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -441,7 +441,7 @@ def get_doc_line(self) -> Optional[str]:
>>               self._literal_mode = True
>>               self._literal_mode_indent = 0
>>           elif self._literal_mode and line:
>> -            indent = re.match(r'^ *', line).end()
>> +            indent = must_match(r'\s*', line).end()
>>               if self._literal_mode_indent == 0:
>>                   self._literal_mode_indent = indent
>>               elif indent < self._literal_mode_indent:
>
> Thanks.  I'm going to queue this so that it's in the next CI run.

Yes, please!


