Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26DFFF60D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Tft-0006IE-T1; Tue, 31 Mar 2026 03:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Tfs-0006Hb-7O
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Tfq-00070w-NT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774942686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNMz3trxqQN62+Z13q3nMiTl/Xd2IRpF43jxYTziW5I=;
 b=N8IZ2lETOyNKp9PYBeZo8XYCjhIGofrG7UsvszHvQlwTzJRjykNxqW5lsxAY96650Q9lKb
 56O+9iw1Bh1ZQFEE+H8MF6b/+w3upKu0yQcML3ZZ1g0GyMfr9oqjxEg7MywYtZGVpQqy6z
 S/JPw/G3nk0NGXo5cbfHkquup6MmVGg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-Ol1tNa1qNwicRWgLMEcgiQ-1; Tue,
 31 Mar 2026 03:38:04 -0400
X-MC-Unique: Ol1tNa1qNwicRWgLMEcgiQ-1
X-Mimecast-MFC-AGG-ID: Ol1tNa1qNwicRWgLMEcgiQ_1774942683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 199E4195609D; Tue, 31 Mar 2026 07:38:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1971800107; Tue, 31 Mar 2026 07:38:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11BDD21E6A28; Tue, 31 Mar 2026 09:38:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 11/16] scripts/qapi: pull c_name from camel_to_upper
 to caller
In-Reply-To: <6edfd34c-2496-49fb-8ddd-665d244261cd@redhat.com> (Paolo
 Bonzini's message of "Tue, 31 Mar 2026 09:33:45 +0200")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-12-pbonzini@redhat.com>
 <87wm01w7eb.fsf@pond.sub.org>
 <6edfd34c-2496-49fb-8ddd-665d244261cd@redhat.com>
Date: Tue, 31 Mar 2026 09:37:59 +0200
Message-ID: <87qzp0v488.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/25/26 09:32, Markus Armbruster wrote:
>>      { 'enum': '__org.qemu_x-Enum', 'data': [ '__org.qemu_x-value' ] }
>> 
>> This tests a downstream extension prefix __RFQDN_.
>> 
>> As is, we generate
>> 
>>      typedef enum __org_qemu_x_Enum {
>>          ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
>>          ORG_QEMU_X_ENUM__MAX,
>>      } __org_qemu_x_Enum;
>> 
>> Without the .lstrip('_'), we'd generate
>> 
>>      typedef enum __org_qemu_x_Enum {
>>          __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
>>          __ORG_QEMU_X_ENUM__MAX,
>>      } __org_qemu_x_Enum;
>> 
>> Meh.
>> 
>> Turns out this isn't on purpose.  Back then, the loop to map camel to
>> upper worked differently, and produced unwanted leading '_'.  For
>> instance, it mapped 'AbraCadabra' to '_ABRA_CADABRA'.  The .lstrip()
>> made the function produce 'ABRA_CADABRA'.  It also makes it eat
>> downstream extensions' leading '__'.  Oopsie.
>
> Which would be a reserved C identifier, wouldn't it?  So it seems it 
> still has its merit, after all (but it is limited to C).

Point.  There's still __org_qemu_x_Enum, though.


