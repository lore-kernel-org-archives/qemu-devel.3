Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18F8C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbPO-0004TL-Gt; Tue, 16 Jul 2024 02:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTbPN-0004SF-I7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTbPM-0008TS-2j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721110286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEUS3GK9CAlgsKu1+HDJu1TubI0apgsDDhyfkV2xhd8=;
 b=ahlK5SUkFR+a5c4vy5BBeVwpTgXnEMkeg6KQJ55J9dIksNCewKFhhsfxu0VLwCQ9vs3zeH
 CpzCvUuNeQqbCrFvT3BEUUeCGBqlrLTlTQgJkvwMYZhOf8V+OiGlxbLMkPtXIF5h9A0j92
 x/RRBPSZSdwFj3IFp5/KHzhxlPyFXwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-Z2drGY29MIicf5yh9bg64w-1; Tue,
 16 Jul 2024 02:11:22 -0400
X-MC-Unique: Z2drGY29MIicf5yh9bg64w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A71291955D4C; Tue, 16 Jul 2024 06:11:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EAEB1955F3B; Tue, 16 Jul 2024 06:11:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C657721E668B; Tue, 16 Jul 2024 08:11:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v1] target/s390x: filter deprecated features based on
 model expansion type
In-Reply-To: <141e7b65-2e72-4216-acb7-10899adaf372@linux.ibm.com> (Collin
 Walling's message of "Mon, 15 Jul 2024 12:52:54 -0400")
References: <20240711203254.49018-1-walling@linux.ibm.com>
 <87h6cvxjxg.fsf@pond.sub.org>
 <141e7b65-2e72-4216-acb7-10899adaf372@linux.ibm.com>
Date: Tue, 16 Jul 2024 08:11:15 +0200
Message-ID: <87bk2xooho.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Collin Walling <walling@linux.ibm.com> writes:

> On 7/12/24 1:23 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>> 
>>> It is beneficial to provide an interface to retrieve *all* deprecated
>>> features in one go. Management applications will need this information
>>> to determine which features need to be disabled regardless of the
>>> host-model's capabilities.
>>>
>>> To remedy this, deprecated features are only filtered during a static
>>> expansion. All deperecated features are reported on a full expansion.
>>>
>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> 
>> Which command(s) exactly are affected?
>>
>
> The query-cpu-model-expansion result will now report all deprecated
> features when a user requests a full expansion.  The inputs are not
> affects, but the output is modified.  I will make this more concise on
> the v2 commit message.

Yes, please.  Consider including an example.

>> Do they need a doc update?
>> 
>
> Yes, I forgot to add this.  This is what is currently documented:
>
> ##
> # @CpuModelInfo:
> #
> ...
> #
> # @deprecated-props: a list of properties that are flagged as deprecated
> #     by the CPU vendor.  These props are a subset of the full model's
> #     definition list of properties. (since 9.1)
> #
>
> I will change to:
>
> #
> # @deprecated-props: a list of properties that are flagged as deprecated
> #     by the CPU vendor. These are a subset of the reported @props.
> #     (since 9.1)
> #

Hasn't made it into a release, so we don't have to document the old
behavior.  Fortunate!

Separate sentences with two spaces for consistency, please.

> (I will also the correct typo in my commit message).
>
> [...]
>
> Thanks!


