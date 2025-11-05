Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A6CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 14:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGeOl-0007CH-TI; Wed, 05 Nov 2025 09:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGeOk-0007BV-Ep
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 09:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGeOj-0000KE-1i
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 09:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762352524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIEDT39neNu+4//svZsgUU+/V0snVc0wOUC9cyKRJtM=;
 b=dZh734iR3K0I9zqh08ZRHoC/FHBrl+c1ZqkxWavQ7F6WoCer3oj0e8lV1MNbZvI6dAdZu6
 nRIsBcqF2gvSI1/6IqzXlMyan74+6E0m38jW/OXSmXDpRdTiSs/fuyTJgPj4ZsuFKWxdIa
 kTDBqVnsBcM3PwVVnA6OAreSbTwVeu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-v_BxRA8EOiO6LjT1yoeYNQ-1; Wed,
 05 Nov 2025 09:22:00 -0500
X-MC-Unique: v_BxRA8EOiO6LjT1yoeYNQ-1
X-Mimecast-MFC-AGG-ID: v_BxRA8EOiO6LjT1yoeYNQ_1762352520
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7EC1954B24; Wed,  5 Nov 2025 14:21:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9FC73000198; Wed,  5 Nov 2025 14:21:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A35D21E6A27; Wed, 05 Nov 2025 15:21:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PULL 12/12] qapi: Add documentation format validation
In-Reply-To: <dfa1aec7-3449-48bf-867d-14b9b2cfeddb@linaro.org> (Richard
 Henderson's message of "Wed, 5 Nov 2025 14:41:26 +0100")
References: <20251104132125.4134730-1-armbru@redhat.com>
 <20251104132125.4134730-13-armbru@redhat.com>
 <dfa1aec7-3449-48bf-867d-14b9b2cfeddb@linaro.org>
Date: Wed, 05 Nov 2025 15:21:56 +0100
Message-ID: <87tsz8lfuj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

> On 11/4/25 14:21, Markus Armbruster wrote:
>> @@ -423,12 +428,55 @@ def get_doc_line(self) -> Optional[str]:
>>               if self.val != '##':
>>                   raise QAPIParseError(
>>                       self, "junk after '##' at end of documentation comment")
>> +            self._literal_mode = False
>>               return None
>>           if self.val == '#':
>>               return ''
>>           if self.val[1] != ' ':
>>               raise QAPIParseError(self, "missing space after #")
>> -        return self.val[2:].rstrip()
>> +
>> +        line = self.val[2:].rstrip()
>> +
>> +        if re.match(r'(\.\. +qmp-example)? *::$', line):
>> +            self._literal_mode = True
>> +            self._literal_mode_indent = 0
>> +        elif self._literal_mode and line:
>> +            indent = re.match(r'^ *', line).end()
>
> Another failure from my incomplete testing last night:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/11982687207#L127
>
> ../scripts/qapi/parser.py:444: error: Item "None" of "Optional[Match[str]]" has no attribute "end"  [union-attr]

Missed in review, sorry.  I'll post a fix a.s.a.p.  Thanks!


