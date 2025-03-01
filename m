Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36033C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 07:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toH3c-0007qQ-D0; Sat, 01 Mar 2025 02:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1toH3a-0007pY-Gz
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1toH3Y-0001iP-RF
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740813279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOIV6RQ1kh5QMfO6/7UUFrb2gHVenRXeteXMVGnvZIg=;
 b=Hy0GYGJML1tK6NzcjRtxLj4bWWKgw3aHt5G9fm8EL92YRXSeVjAmXb3XgFqP+Bp6Y8IoUc
 qqsGo6EAAW4oSzZea14hnZrJyt/Iiz4cPwbETu+K88pvInCMuMba1o7ParMC/lMBdJgJKM
 yI6yQ2mfSA6vmNLFfFzJohJU+PgZd1g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-O_Pv_YG3PRyTJRZE4cq0Eg-1; Sat,
 01 Mar 2025 02:14:25 -0500
X-MC-Unique: O_Pv_YG3PRyTJRZE4cq0Eg-1
X-Mimecast-MFC-AGG-ID: O_Pv_YG3PRyTJRZE4cq0Eg_1740813264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47AF51955BFC; Sat,  1 Mar 2025 07:14:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A89761944D02; Sat,  1 Mar 2025 07:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B13821E675E; Sat, 01 Mar 2025 08:14:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Patrick Venture <venture@google.com>,  peter.maydell@linaro.org,
 qemu-devel@nongnu.org,  Peter Foley <pefoley@google.com>
Subject: Re: [PATCH] util/keyval: fix msan findings
In-Reply-To: <fc1f2750-f4c7-419f-b667-301fb0bb2edf@redhat.com> (Paolo
 Bonzini's message of "Sat, 1 Mar 2025 07:12:29 +0100")
References: <20250228212039.1768614-1-venture@google.com>
 <fc1f2750-f4c7-419f-b667-301fb0bb2edf@redhat.com>
Date: Sat, 01 Mar 2025 08:14:21 +0100
Message-ID: <87frjxcjea.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/28/25 22:20, Patrick Venture wrote:
>> From: Peter Foley <pefoley@google.com>
>> e.g.
>> qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
>> qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
>> Signed-off-by: Peter Foley <pefoley@google.com>
>> Signed-off-by: Patrick Venture <venture@google.com>
>
> This is not a fix, since there's no bug to fix.  It's just the tool complaining about something it can't reason on.
>
> Paolo

The code is designed to read @keyval_in_cur only in non-first iterations
of the loop.  The previous iteration assigned to it then.

The two lines you quoted don't make sense to me.  Is this the full
report you got?  If not, show us the full report, please.  Ideally with
a reproducer.

>> ---
>>  util/keyval.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/util/keyval.c b/util/keyval.c
>> index a70629a481..f33c64079d 100644
>> --- a/util/keyval.c
>> +++ b/util/keyval.c
>> @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>>  {
>>      const char *key, *key_end, *val_end, *s, *end;
>>      size_t len;
>> -    char key_in_cur[128];
>> +    char key_in_cur[128] = {};

Suspect overkill.  Would "" do?

>>      QDict *cur;
>>      int ret;
>>      QObject *next;


